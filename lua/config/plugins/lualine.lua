return {
  "nvim-lualine/lualine.nvim",
  config = function()

    local function buf_bytes()
      local n = vim.fn.line2byte(vim.fn.line("$") + 1) -1
      if n < 0 then n = 0 end
      return string.format("%dB", n)
    end

    require("lualine").setup({
      options = {
        theme = "iceberg_dark",
        section_separators = " ",
        component_separators = " ",
        globalstatus = true,
        refresh = { statusline = 100 },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { buf_bytes, "encoding", "fileformat", "filetype", "filesize" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
      callback = function()
        require("lualine").refresh { place = { "statusline"} }
      end,
    })
  end
}
