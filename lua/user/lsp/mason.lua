local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"pyright",
	"yamlls",
	"bashls",
	"clangd",
	"rust_analyzer",
	"texlab",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

require("lspconfig").pyright.setup({})
require("lspconfig").yamlls.setup({})
require("lspconfig").bashls.setup({})
require("lspconfig").clangd.setup({})
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").texlab.setup({})
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
