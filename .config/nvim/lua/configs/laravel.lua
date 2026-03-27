local M = {}

function M.setup()
  local ok, laravel = pcall(require, "laravel")
  if not ok then return end

  laravel.setup({
    -- enable telescope integration for fuzzy pickers
    telescope = true,
    -- caching interval (seconds) for completions (as per plugin defaults)
    cache_ttl = 30,
    -- try to auto-detect project root
    root_patterns = { "artisan", "composer.json", ".git" },
    -- ui options
    ui = {
      prompt = {
        border = "rounded",
      },
    },
  })

  -- Optional: nvim-cmp completion source integration if installed
  local has_cmp, cmp = pcall(require, "cmp")
  if has_cmp then
    local ok_src, laravel_cmp = pcall(require, "laravel.cmp")
    if ok_src and laravel_cmp and cmp then
      cmp.setup({
        sources = cmp.config.sources({
          { name = "laravel" },
        }, {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        })
      })
    end
  end

  -- Add Telescope pickers if telescope is available
  local has_telescope, telescope = pcall(require, "telescope")
  if has_telescope then
    pcall(telescope.load_extension, "laravel")
  end

  -- Convenience user commands (only if not provided by plugin)
  -- The plugin already creates commands like :LaravelGoto, :LaravelMake, etc.
end

return M
