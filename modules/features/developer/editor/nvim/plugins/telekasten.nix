{
  flake.homeModules.nvimPluginTelekasten =
    { pkgs, ... }:
    let
      home = "~/Notes";
    in
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        mattn-calendar-vim
        {
          plugin = telekasten-nvim;
          config = ''
            require("telekasten").setup({
              home = vim.fn.expand("${home}"),
              auto_set_filetype = false,
              auto_set_syntax = true,
              dailies = vim.fn.expand("${home}/daily"),
              weeklies = vim.fn.expand("${home}/weekly"),
              templates = vim.fn.expand("${home}/templates"),
              template_new_daily = vim.fn.expand("${home}/templates/template_new_daily.md"),
              template_new_weekly = vim.fn.expand("${home}/templates/template_new_weekly.md"),
            })

            vim.api.nvim_set_keymap("n", "<leader>zt", "<cmd>Telekasten panel<CR>", { desc = "Find Panel" })
            vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>", { desc = "Find Notes" })
            vim.api.nvim_set_keymap("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>", { desc = "Search Notes" })
            vim.api.nvim_set_keymap("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "Today Note" })
            vim.api.nvim_set_keymap("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>", { desc = "Follow Link" })
            vim.api.nvim_set_keymap("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = "New Note" })
            vim.api.nvim_set_keymap("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>", { desc = "Open Calendar" })
            vim.api.nvim_set_keymap("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = "Show Back Links" })
            vim.api.nvim_set_keymap("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", { desc = "Insert Image Link" })

            -- Call insert link automatically when we start typing a link
            vim.api.nvim_set_keymap("i", "[[", "<cmd>Telekasten insert_link<CR>", { desc = "Add Link for Note" })

            vim.api.nvim_create_autocmd("BufNewFile", {
              pattern = vim.fn.expand("${home}") .. "/projects/*/intro.md",
              callback = function(args)
                local tmpl = vim.fn.expand("${home}/templates/template_new_project.md")
                if vim.fn.filereadable(tmpl) == 0 then return end
                local lines = vim.fn.readfile(tmpl)
                local ok, t = pcall(require, "telekasten.templates")
                if ok then
                  local title = vim.fn.fnamemodify(args.file, ":h:t")
                  local uuid = os.date("%Y%m%d%H%M%S")
                  for i, l in ipairs(lines) do
                    lines[i] = t.subst_templated_values(l, title, nil, uuid, nil)
                  end
                end
                vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
              end,
            })
          '';
        }
      ];
    };
}
