return {
  "tpope/vim-fugitive",
  cmd = {
    "Git", "Gwrite", "Gread", "Ggrep", "Glgrep",
    "Gdiff", "Gstatus", "Gcommit", "Gblame", "Gbrowse", "Glog",
  },
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
  },
}

