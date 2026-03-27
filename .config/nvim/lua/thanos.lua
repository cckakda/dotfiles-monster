-- Thanos snap — deadbranch-style disintegration on VimLeavePre

local M = {}

-- cell states
local ST_NORMAL  = 0
local ST_SCATTER = 1
local ST_EMPTY   = 2

local DENSITY_CHARS = { "·", "░", "▒", "▓", "█" }  -- index 1=sparse … 5=dense
local CELLS_PER_TICK = 100
local MAX_PARTICLES  = 60

-- ── helpers ────────────────────────────────────────────────────────────────

local function get_screen_lines()
  local height = vim.o.lines - 2
  local width  = vim.o.columns
  local win    = vim.api.nvim_get_current_win()
  local buf    = vim.api.nvim_win_get_buf(win)
  local top    = vim.fn.line("w0") - 1
  local raw    = vim.api.nvim_buf_get_lines(buf, top, top + height, false)
  local lines  = {}
  for i = 1, height do
    local l = (raw[i] or ""):gsub("\t", "  ")
    local w = vim.fn.strdisplaywidth(l)
    if w < width then
      l = l .. string.rep(" ", width - w)
    else
      l = l:sub(1, width)
    end
    lines[i] = l
  end
  return lines, width, height
end

local function lines_to_grid(lines, width, height)
  local grid = {}
  for r = 1, height do
    local row = {}
    for c = 1, width do
      local ch = lines[r]:sub(c, c)
      row[c] = {
        ch      = ch,
        state   = (ch ~= " " and ch ~= "") and ST_NORMAL or ST_EMPTY,
        density = 5,
      }
    end
    grid[r] = row
  end
  return grid
end

local function grid_to_lines(grid, width, height)
  local out = {}
  for r = 1, height do
    local parts = {}
    for c = 1, width do
      parts[c] = grid[r][c].display_ch or " "
    end
    out[r] = table.concat(parts)
  end
  return out
end

-- Build a left-to-right biased queue with Gaussian jitter (deadbranch style).
-- Lua doesn't have built-in Gaussian, so approximate with Box-Muller.
local function build_queue(grid, width, height)
  local sigma = width * 0.12
  local items = {}
  for r = 1, height do
    for c = 1, width do
      if grid[r][c].state == ST_NORMAL then  -- (flicker removed; only normal cells queued)
        -- Box-Muller approximation using two uniform samples
        local u1 = math.random()
        local u2 = math.random()
        local noise = sigma * math.sqrt(-2 * math.log(math.max(u1, 1e-9)))
                             * math.cos(2 * math.pi * u2)
        table.insert(items, { key = c + noise, r = r, c = c })
      end
    end
  end
  table.sort(items, function(a, b) return a.key < b.key end)
  local q = {}
  for _, v in ipairs(items) do
    table.insert(q, { v.r, v.c })
  end
  return q
end

-- ── main animation ─────────────────────────────────────────────────────────

function M.snap()
  local lines, width, height = get_screen_lines()
  local grid = lines_to_grid(lines, width, height)

  math.randomseed(os.time())

  local queue   = build_queue(grid, width, height)
  local q_idx   = 0
  local total   = #queue
  -- particles: { x, y, vx, vy, density, lifetime, age }
  local particles = {}

  -- create full-screen overlay float
  local fbuf = vim.api.nvim_create_buf(false, true)
  -- initial content
  for r = 1, height do
    for c = 1, width do
      grid[r][c].display_ch = grid[r][c].ch
    end
  end
  vim.api.nvim_buf_set_lines(fbuf, 0, -1, false, grid_to_lines(grid, width, height))
  local fwin = vim.api.nvim_open_win(fbuf, false, {
    relative  = "editor",
    row       = 0,
    col       = 0,
    width     = width,
    height    = height,
    style     = "minimal",
    zindex    = 250,
    focusable = false,
  })
  vim.wo[fwin].winblend = 0
  vim.cmd "redraw"
  vim.uv.sleep(80)  -- brief pause before snap

  -- animation loop
  while true do
    -- advance dissolution queue: move cells from NORMAL → SCATTER
    for _ = 1, CELLS_PER_TICK do
      if q_idx < total then
        q_idx = q_idx + 1
        local r, c = queue[q_idx][1], queue[q_idx][2]
        local cell = grid[r][c]
        if cell.state == ST_NORMAL then
          cell.state   = ST_SCATTER
          cell.density = 5
          if math.random() < 0.40 and #particles < MAX_PARTICLES then
            table.insert(particles, {
              x        = c,
              y        = r,
              vx       = math.random() * 0.7 + 0.4,
              vy       = -(math.random() * 0.5 + 0.2),
              density  = 4,
              lifetime = math.random(8, 14),
              age      = 0,
            })
          end
        end
      end
    end

    -- update cells
    local any_alive = false
    for r = 1, height do
      for c = 1, width do
        local cell = grid[r][c]
        if cell.state == ST_NORMAL then
          any_alive = true
          cell.display_ch = cell.ch        -- letter stays readable until snap
        elseif cell.state == ST_SCATTER then
          any_alive = true
          cell.density = cell.density - 1
          if cell.density < 1 then
            cell.state      = ST_EMPTY
            cell.display_ch = " "
          else
            cell.display_ch = DENSITY_CHARS[cell.density]
          end
        else
          cell.display_ch = " "
        end
      end
    end

    -- update particles
    local survivors = {}
    for _, p in ipairs(particles) do
      p.x  = p.x + p.vx
      p.y  = p.y + p.vy
      p.vy = p.vy + 0.025  -- gravity
      p.vx = p.vx + (math.random() * 0.1 - 0.05)
      p.age      = p.age + 1
      p.lifetime = p.lifetime - 1
      if p.age % 4 == 0 then
        p.density = p.density - 1
      end
      if p.lifetime > 0 and p.density >= 1
          and p.y >= 1 and p.y <= height
          and p.x >= 1 and p.x <= width then
        table.insert(survivors, p)
      end
    end
    particles = survivors

    -- overlay particles onto display grid
    for _, p in ipairs(particles) do
      local pr = math.floor(p.y + 0.5)
      local pc = math.floor(p.x + 0.5)
      if pr >= 1 and pr <= height and pc >= 1 and pc <= width then
        grid[pr][pc].display_ch = DENSITY_CHARS[math.max(1, p.density)]
      end
    end

    vim.api.nvim_buf_set_lines(fbuf, 0, -1, false, grid_to_lines(grid, width, height))
    vim.cmd "redraw"
    vim.uv.sleep(48)

    if not any_alive and #particles == 0 then break end
  end

  -- hold blank then exit
  local blank = {}
  for _ = 1, height do blank[#blank + 1] = string.rep(" ", width) end
  vim.api.nvim_buf_set_lines(fbuf, 0, -1, false, blank)
  vim.cmd "redraw"
  vim.uv.sleep(100)

  pcall(vim.api.nvim_win_close, fwin, true)
  pcall(vim.api.nvim_buf_delete, fbuf, { force = true })
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local ok, err = pcall(M.snap)
    if not ok then
      vim.notify("thanos: " .. tostring(err), vim.log.levels.WARN)
    end
  end,
})

return M
