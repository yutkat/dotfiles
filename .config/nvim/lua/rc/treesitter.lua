-- Skip special buffers and huge files, where treesitter highlighting gets slow
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("rc_treesitter", { clear = true }),
	callback = function(args)
		if vim.bo[args.buf].buftype == "" and vim.api.nvim_buf_line_count(args.buf) <= 5000 then
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})

vim.keymap.set("n", "'r", function()
	vim.lsp.buf.rename()
end, { noremap = true, silent = true })
vim.keymap.set("n", "'d", function()
	vim.lsp.buf.definition()
end, { noremap = true, silent = true })
vim.keymap.set("n", "'D", function()
	vim.lsp.buf.document_symbol()
end, { noremap = true, silent = true })

vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, source, predicate, metadata)
	local capture_id = predicate[2]
	local node = match[capture_id]
	if node then
		local text = vim.treesitter.get_node_text(node, source)
		local lang = text:match("^([^:]+)") or text
		local lang_id = vim.treesitter.language.get_lang(lang)
		metadata["injection.language"] = lang_id or lang
	end
end, { force = true })
