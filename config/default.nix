{ pkgs, ... }: {
  imports = [
    ./lsp.nix
    ./options.nix
    ./plugins.nix
    ./theme.nix
  ];
  config = {
    extraConfigLua = "vim.cmd('set cmdheight=0')";
    colorschemes.gruvbox.enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = suda-vim;
      }
      {
        plugin = autoclose-nvim;
        config = ''lua require("autoclose").setup()'';
      }
    ];
    plugins = {
      nix = {
        enable = true;
      };
      oil = {
        enable = true;
      };
      lualine = {
        enable = true;
        theme = "gruvbox";
      };
      nvim-colorizer = {
        enable = true;
      };
      nvim-tree = {
        enable = true;
        autoReloadOnWrite = true;
        hijackCursor = true;
        openOnSetup = true;
      };
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
        };
      };

      treesitter = {
        enable = true;
      };
    };
  };
}
