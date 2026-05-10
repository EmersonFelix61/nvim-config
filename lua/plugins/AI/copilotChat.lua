return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    setup = "telescope-ui-select.nvim",
    opts = {
      keymaps = {
        reset_chat = "<C-'>", -- Change this to your preferred keybinding
      },     -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
