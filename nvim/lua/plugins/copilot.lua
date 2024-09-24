return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = true,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = "VeryLazy",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    opts = {
      debug = false, -- Enable debugging
      language = "Japanese",
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
    },
    keys = {
      { "<leader>ccb", ":CopilotChatBuffer ",         desc = "CopilotChat - Chat with current buffer" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual ",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccx",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "CopilotChat - Run in-place code",
      },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>ccr",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
    },
    config = function()
      local select = require("CopilotChat.select")

      require("CopilotChat").setup {
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN カーソル上のコードの説明を段落をつけて書いてください。",
          },
          Tests = {
            prompt = "/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。",
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
          },
          Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
          },
          Docs = {
            prompt =
            "/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
          },
          FixDiagnostic = {
            prompt = "ファイル内の次のような診断上の問題を解決してください：",
            selection = select.diagnostics,
          },
        },
      }
    end,
  },
}
