return {
  "junegunn/vim-easy-align",
  config = function()
    vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)", {
      remap = true,
      desc = "EasyAlign",
    })
  end,
}

