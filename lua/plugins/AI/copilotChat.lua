return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
    },
    cond = function()
      local output = vim.fn.system({ "node", "--version" })
      if vim.v.shell_error ~= 0 then
        return false
      end

      return (tonumber(output:match("^v(%d+)")) or 0) >= 22
    end,
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      keymaps = {
        reset_chat = "<C-'>", -- Change this to your preferred keybinding
      },     -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
