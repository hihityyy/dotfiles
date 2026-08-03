 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#171310',
    base01 = '#231f1c',
    base02 = '#2e2926',
    base03 = '#9d8e84',
    base04 = '#d5c3b8',
    base05 = '#eae1db',
    base06 = '#eae1db',
    base07 = '#eae1db',
    base08 = '#ffb4ab',
    base09 = '#caca8f',
    base0A = '#dec1ac',
    base0B = '#f2bb91',
    base0C = '#caca8f',
    base0D = '#f2bb91',
    base0E = '#dec1ac',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#eae1db',          bg = '#171310' })
  hi('TelescopeBorder',         { fg = '#9d8e84',             bg = '#171310' })
  hi('TelescopePromptNormal',   { fg = '#eae1db',          bg = '#171310' })
  hi('TelescopePromptBorder',   { fg = '#9d8e84',             bg = '#171310' })
  hi('TelescopePromptPrefix',   { fg = '#f2bb91',             bg = '#171310' })
  hi('TelescopePromptCounter',  { fg = '#d5c3b8',  bg = '#171310' })
  hi('TelescopePromptTitle',    { fg = '#171310',             bg = '#f2bb91' })
  hi('TelescopePreviewTitle',   { fg = '#171310',             bg = '#dec1ac' })
  hi('TelescopeResultsTitle',   { fg = '#171310',             bg = '#caca8f' })
  hi('TelescopeSelection',      { fg = '#eae1db',          bg = '#2e2926' })
  hi('TelescopeSelectionCaret', { fg = '#f2bb91',             bg = '#2e2926' })
  hi('TelescopeMatching',       { fg = '#f2bb91',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
