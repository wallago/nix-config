vim.lsp.config("nixd", {
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			options = {
				nixos = {
					expr = "(builtins.head (builtins.attrValues (builtins.getFlake (toString ./.)).nixosConfigurations)).options",
				},
				["home-manager"] = {
					expr = "(builtins.head (builtins.attrValues (builtins.getFlake (toString ./.)).nixosConfigurations)).options.home-manager.users.type.getSubOptions []",
				},
			},
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})
vim.lsp.enable("nixd")
