{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undofile = false
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.scrolloff = 999
      vim.opt.updatetime = 50
      vim.opt.foldmethod = "indent"
      vim.opt.foldlevel = 99
  
      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>", ":")
      vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { silent = true })
      vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { silent = true })
      vim.keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { silent = true })
      vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
      vim.keymap.set("n", "Q", "<nop>")
      vim.keymap.set("n", "o", "o<esc>")
      vim.keymap.set("n", "O", "O<esc>")
      vim.keymap.set("i", "jj", "<esc>")

      local is_dark = vim.o.background ~= "light"
      require("cyberdream").setup({
        transparent = is_dark,
        variant = is_dark and "dark" or "light",
        terminal_colors = true,
      })
      vim.cmd.colorscheme("cyberdream")

      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })

      require("bufferline").setup({
        options = {
          offsets = {
            {
              filetype = "NvimTree",
              text = "Files",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })

      require("lualine").setup({
        ons = { theme = "auto" },
      })

      require("neocord").setup({
        logo = "auto",
        logo_tooltip = "Neovim",
        main_image = "language",
        show_time = true,
        global_timer = true,
      })

      require("gitsigns").setup({
        signs = {
          add    = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
        },
      })
    '';

    plugins = with pkgs.vimPlugins; [
      { plugin = cyberdream-nvim; }
      { plugin = nvim-web-devicons; }
      { plugin = nvim-tree-lua; }
      { plugin = bufferline-nvim; }
      { plugin = lualine-nvim; }
      { plugin = neocord; }
      { plugin = gitsigns-nvim; }
    ];
  };
}
