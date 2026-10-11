return {
  "keremimo/noctalia.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    palette_path = vim.fn.expand("~/.config/noctalia/colors.json"),
    auto_reload = true,
  },
  config = function(_, opts)
    require("noctalia").setup(opts)
    vim.cmd.colorscheme("noctalia")

    local p = require("noctalia").palette()
    local hi = function(g, o)
      vim.api.nvim_set_hl(0, g, o)
    end

    -- Float / Popup / Cmdline
    hi("NormalFloat", { fg = p.fg, bg = p.bg })
    hi("FloatBorder", { fg = p.border, bg = p.bg })
    hi("FloatTitle", { fg = p.primary, bg = p.bg, bold = true })
    hi("MsgArea", { fg = p.fg, bg = p.bg })

    -- Noice cmdline
    hi("NoiceCmdlinePopup", { fg = p.fg, bg = p.bg })
    hi("NoiceCmdlinePopupBorder", { fg = p.primary, bg = p.bg })
    hi("NoiceCmdlineIcon", { fg = p.primary, bg = p.bg })
    hi("NoiceConfirm", { fg = p.fg, bg = p.bg })
    hi("NoiceConfirmBorder", { fg = p.border, bg = p.bg })

    -- Snacks input
    hi("SnacksInput", { fg = p.fg, bg = p.bg })
    hi("SnacksInputBorder", { fg = p.primary, bg = p.bg })

    -- ═══════════════════════════════════════════════════════
    -- ПОДСКАЗКИ / AUTOCOMPLETE в cmdline
    -- ═══════════════════════════════════════════════════════
    hi("Pmenu", { fg = p.fg, bg = p.bg })
    hi("PmenuSel", { fg = p.bg, bg = p.primary })
    hi("PmenuSbar", { bg = p.bg_highlight })
    hi("PmenuThumb", { bg = p.border })
    hi("WildMenu", { fg = p.bg, bg = p.primary, bold = true })

    hi("NoicePopupmenu", { fg = p.fg, bg = p.bg })
    hi("NoicePopupmenuBorder", { fg = p.border, bg = p.bg })
    hi("NoicePopupmenuSelected", { fg = p.bg, bg = p.primary })
    hi("NoicePopupmenuMatch", { fg = p.primary, bold = true })

    -- Snacks Picker
    hi("SnacksPicker", { fg = p.fg, bg = p.bg })
    hi("SnacksPickerBorder", { fg = p.border, bg = p.bg })
    hi("SnacksPickerInput", { fg = p.fg, bg = p.bg })
    hi("SnacksPickerList", { fg = p.fg, bg = p.bg })
    hi("SnacksPickerPreview", { fg = p.fg, bg = p.bg })
    hi("SnacksPickerTitle", { fg = p.primary, bg = p.bg, bold = true })

    -- Telescope
    hi("TelescopeNormal", { fg = p.fg, bg = p.bg })
    hi("TelescopeBorder", { fg = p.border, bg = p.bg })
    hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg })
    hi("TelescopePromptBorder", { fg = p.primary, bg = p.bg })
    hi("TelescopePromptPrefix", { fg = p.primary, bg = p.bg })
    hi("TelescopePromptTitle", { fg = p.bg, bg = p.primary, bold = true })
    hi("TelescopePreviewTitle", { fg = p.bg, bg = p.secondary, bold = true })
    hi("TelescopeResultsTitle", { fg = p.bg, bg = p.tertiary, bold = true })
    hi("TelescopeSelection", { fg = p.fg, bg = p.bg_highlight })
    hi("TelescopeSelectionCaret", { fg = p.primary, bg = p.bg_highlight })
    hi("TelescopeMatching", { fg = p.primary, bold = true })

    -- Dashboard
    hi("DashboardHeader", { fg = p.primary, bg = p.bg, bold = true })
    hi("DashboardFooter", { fg = p.fg_dim, bg = p.bg })
    hi("DashboardCenter", { fg = p.fg, bg = p.bg })
    hi("DashboardDesc", { fg = p.fg, bg = p.bg })
    hi("DashboardKey", { fg = p.primary, bg = p.bg, bold = true })
    hi("DashboardIcon", { fg = p.secondary, bg = p.bg })
    hi("DashboardShortCut", { fg = p.fg_muted, bg = p.bg })
    hi("DashboardProjectTitle", { fg = p.primary, bg = p.bg, bold = true })
    hi("DashboardProjectTitleIcon", { fg = p.primary, bg = p.bg })
    hi("DashboardProjectIcon", { fg = p.secondary, bg = p.bg })
    hi("DashboardMruTitle", { fg = p.primary, bg = p.bg, bold = true })
    hi("DashboardMruIcon", { fg = p.secondary, bg = p.bg })
    hi("DashboardFiles", { fg = p.fg, bg = p.bg })
    hi("DashboardShortCutIcon", { fg = p.fg_muted, bg = p.bg })

    -- ═══════════════════════════════════════════════════════
    -- User NoctaliaReload — срабатывает ПОСЛЕ highlight clear
    -- ═══════════════════════════════════════════════════════
    vim.api.nvim_create_autocmd("User", {
      pattern = "NoctaliaReload",
      callback = function()
        local p = require("noctalia").palette()
        local hi = function(g, o)
          vim.api.nvim_set_hl(0, g, o)
        end

        -- Подсказки
        hi("Pmenu", { fg = p.fg, bg = p.bg })
        hi("PmenuSel", { fg = p.bg, bg = p.primary })
        hi("PmenuSbar", { bg = p.bg_highlight })
        hi("PmenuThumb", { bg = p.border })
        hi("WildMenu", { fg = p.bg, bg = p.primary, bold = true })

        hi("NoicePopupmenu", { fg = p.fg, bg = p.bg })
        hi("NoicePopupmenuBorder", { fg = p.border, bg = p.bg })
        hi("NoicePopupmenuSelected", { fg = p.bg, bg = p.primary })
        hi("NoicePopupmenuMatch", { fg = p.primary, bold = true })

        -- Float (перебиваем noice)
        hi("NormalFloat", { fg = p.fg, bg = p.bg })
        hi("FloatBorder", { fg = p.border, bg = p.bg })
        hi("NoiceCmdlinePopup", { fg = p.fg, bg = p.bg })
        hi("NoiceCmdlinePopupBorder", { fg = p.primary, bg = p.bg })

        -- Остальное
        hi("SnacksPicker", { fg = p.fg, bg = p.bg })
        hi("SnacksPickerBorder", { fg = p.border, bg = p.bg })
        hi("TelescopeNormal", { fg = p.fg, bg = p.bg })
        hi("TelescopeBorder", { fg = p.border, bg = p.bg })
        hi("TelescopePromptBorder", { fg = p.primary, bg = p.bg })
        hi("DashboardHeader", { fg = p.primary, bg = p.bg, bold = true })
        hi("DashboardFooter", { fg = p.fg_dim, bg = p.bg })
        hi("DashboardKey", { fg = p.primary, bg = p.bg, bold = true })
        hi("DashboardProjectTitle", { fg = p.primary, bg = p.bg, bold = true })

        vim.cmd("redraw!")
      end,
    })
  end,
}
