return {
  "nvim-lualine/lualine.nvim",
  config = function(_, opts)
    local p = require("noctalia").palette()

    local bg = p.bg
    local fg = p.fg
    local slate = p.bg_highlight
    local accent = p.primary

    local function variant(mode_accent)
      return {
        a = { bg = mode_accent, fg = bg, gui = "bold" },
        b = { bg = slate, fg = fg },
        c = { bg = bg, fg = fg },
        x = { bg = bg, fg = fg },
        y = { bg = slate, fg = fg },
        z = { bg = accent, fg = bg, gui = "bold" },
      }
    end

    opts.options.theme = {
      normal = variant(p.primary),
      insert = variant(p.secondary),
      visual = variant(p.primary_light),
      replace = variant(p.error),
      command = variant(p.tertiary),
      terminal = variant(p.secondary_light),
      inactive = {
        a = { bg = bg, fg = fg },
        b = { bg = bg, fg = fg },
        c = { bg = bg, fg = fg },
        x = { bg = bg, fg = fg },
        y = { bg = bg, fg = fg },
        z = { bg = bg, fg = fg },
      },
    }

    require("lualine").setup(opts)
  end,
  opts = {
    options = {
      icons_enabled = false,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      disabled_filetypes = {
        statusline = {
          "snacks_dashboard",
          "dashboard",
          "alpha",
          "startify",
          "help",
          "lazy",
          "mason",
          "qf",
          "Trouble",
          "NvimTree",
          "neo-tree",
          "Outline",
          "terminal",
        },
        winbar = {},
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(s)
            return s:sub(1, 3)
          end,
          padding = { left = 1, right = 1 },
          color = { gui = "bold" },
        },
      },
      lualine_b = {
        {
          "filetype",
          icon_only = false,
          colored = false,
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { fg = p.fg, bg = p.bg_highlight, gui = "bold" }
          end,
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = { modified = " ● ", readonly = "  " },
          cond = function()
            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
          end,
          color = function()
            local p = require("noctalia").palette()
            return { fg = p.fg_dim, bg = p.bg, gui = "bold" }
          end,
        },
      },
      lualine_x = {
        {
          "diagnostics",
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { bg = p.bg, gui = "bold" }
          end,
        },
        {
          "diff",
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { bg = p.bg, gui = "bold" }
          end,
        },
        {
          "branch",
          icon = " ",
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { bg = p.bg, gui = "bold" }
          end,
        },
      },
      lualine_y = {
        {
          "progress",
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { fg = p.fg, bg = p.bg_highlight, gui = "bold" }
          end,
        },
      },
      lualine_z = {
        {
          "location",
          padding = { left = 1, right = 1 },
          color = function()
            local p = require("noctalia").palette()
            return { fg = p.bg, bg = p.primary, gui = "bold" }
          end,
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { { "location", padding = { left = 1, right = 1 } } },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
