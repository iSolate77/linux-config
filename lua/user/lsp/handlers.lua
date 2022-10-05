local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not status_cmp_ok then
--   return
-- end
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

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
    virtual_lines = false,
    virtual_text = false,

    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many", -- Or "always"
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })
end


-- insert shortcuts
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "K", vim.lsp.buf.hover, {buffer=0}, opts)
keymap("n", "gd", vim.lsp.buf.definition, {buffer=0}, opts)
keymap("n", "gD", vim.lsp.buf.declaration, {buffer=0}, opts)
keymap("n", "gt", vim.lsp.buf.type_definition, {buffer=0}, opts)
keymap("n", "gi", vim.lsp.buf.implementation, {buffer=0}, opts)
keymap("n", "<leader>lj", vim.diagnostic.goto_next, {buffer=0}, opts)
keymap("n", "<leader>lk", vim.diagnostic.goto_prev, {buffer=0}, opts)
keymap("n", "<leader>lf", vim.lsp.buf.format, {buffer=0}, opts)
keymap("n", "<leader>lr", vim.lsp.buf.rename, {buffer=0}, opts)
keymap("n", "<leader>ll", "<cmd>Telescope diagnostics<CR>", opts)

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  attach_navic(client, bufnr)

  if client.name == "tsserver" then
    require("lsp-inlayhints").on_attach(client, bufnr)
  end

  if client.name == "jdt.ls" then
    vim.lsp.codelens.refresh()
    if JAVA_DAP_ACTIVE then
      require("jdtls").setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end
end

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false }) 
    augroup end
  ]]
  vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]

return M
