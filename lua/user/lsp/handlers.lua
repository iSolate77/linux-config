local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps()
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set
	keymap("n", "K", vim.lsp.buf.hover, { buffer = 0 }, opts)
	keymap("n", "gd", vim.lsp.buf.definition, { buffer = 0 }, opts)
	keymap("n", "gD", vim.lsp.buf.declaration, { buffer = 0 }, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, { buffer = 0 }, opts)
	keymap("n", "gr", vim.lsp.buf.references, { buffer = 0 }, opts)
	keymap("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 }, opts)
	keymap("n", "<leader>lf", vim.lsp.buf.format, { buffer = 0 }, opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = 0 }, opts)
	keymap("n", "<leader>lj", vim.diagnostic.goto_next, { buffer = 0 }, opts)
	keymap("n", "<leader>lk", vim.diagnostic.goto_prev, { buffer = 0 }, opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, { buffer = 0 }, opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = 0 }, opts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, { buffer = 0 }, opts)
end

M.on_attach = function(client)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps()
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
