return {
  setup = function(use)
    use {
      "nvim-lualine/lualine.nvim",
      event = { "UIEnter" },
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      wants = { "nvim-web-devicons" },
      config = function()
        local empty = require("lualine.component"):extend()
        function empty:draw(default_highlight)
          self.status = ""
          self.applied_separator = ""
          self:apply_highlights(default_highlight)
          self:apply_section_separators()
          return self.status
        end

        local function process_sections(sections)
          for name, section in pairs(sections) do
            local left = name:sub(9, 10) < "x"
            for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
              table.insert(section, pos * 2, { empty })
            end
            for id, comp in ipairs(section) do
              if type(comp) ~= "table" then
                comp = { comp }
                section[id] = comp
              end
              comp.separator = left and { right = "" } or { left = "" }
            end
          end
          return sections
        end

        local function search_result()
          if vim.v.hlsearch == 0 then
            return ""
          end
          local last_search = vim.fn.getreg("/")
          if not last_search or last_search == "" then
            return ""
          end
          local searchcount = vim.fn.searchcount { maxcount = 9999 }
          return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
        end

        local function modified()
          if vim.bo.modified then
            return "פֿ"
          elseif vim.bo.modifiable == false or vim.bo.readonly == true then
            return ""
          end
          return ""
        end

        require("lualine").setup {
          options = {
            -- theme = "OceanicNext",
            theme = "jellybeans",
            -- theme = "onedark",
            -- theme = "wombat",
            component_separators = "",
            section_separators = { left = "", right = "" },
          },
          sections = process_sections {
            lualine_a = { "mode" },
            lualine_b = {
              "branch",
              {
                "diff",
                colored = true, -- Displays a colored diff status if set to true
                diff_color = {
                  -- Same color values as the general color option can be used here.
                  added = "DiffAdd", -- Changes the diff's added color
                  modified = "DiffChange", -- Changes the diff's modified color
                  removed = "DiffDelete", -- Changes the diff's removed color you
                },
                symbols = { added = "", modified = "", removed = "" }, -- Changes the symbols used by the diff.
              },
              {
                "diagnostics",
                sources = { "nvim_lsp", "nvim_diagnostic" },
                colored = true,
                diagnostics_color = {
                  error = "DiagnosticError",
                  warn = "DiagnosticWarn",
                  info = "DiagnosticInfo",
                  hint = "DiagnosticHint",
                },
                symbols = { error = "", warn = "", info = "", hint = "" },
              },
              { "filename", file_status = false, path = 1 },
              { modified },
              {
                "%w",
                cond = function()
                  return vim.wo.previewwindow
                end,
              },
              {
                "%r",
                cond = function()
                  return vim.bo.readonly
                end,
              },
              {
                "%q",
                cond = function()
                  return vim.bo.buftype == "quickfix"
                end,
              },
            },
            lualine_c = {},
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { search_result, "filetype" },
            lualine_z = { "%l:%c", "%p%%/%L" },
          },
          inactive_sections = {
            lualine_c = { "%f %y %m" },
            lualine_x = {},
          },
          extensions = { "quickfix", "neo-tree", "toggleterm" },
        }
      end,
    }
  end,
}
