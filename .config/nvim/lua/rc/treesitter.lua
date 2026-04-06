-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function ts_disable(_, bufnr)
	return vim.api.nvim_buf_line_count(bufnr) > 5000
end

local function enable_treesitter(bufnr)
	if vim.bo[bufnr].buftype ~= "" then
		return
	end

	if ts_disable(nil, bufnr) then
		return
	end

	pcall(vim.treesitter.start, bufnr)
end

local function enable_loaded_buffers()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
			enable_treesitter(bufnr)
		end
	end
end

local group = vim.api.nvim_create_augroup("rc_treesitter", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileType" }, {
	group = group,
	callback = function(args)
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(args.buf) then
				enable_treesitter(args.buf)
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.schedule(enable_loaded_buffers)
	end,
})

enable_loaded_buffers()

vim.keymap.set("n", "'r", vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set("n", "'d", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "'D", function()
	local ok_telescope, builtin = pcall(require, "telescope.builtin")
	if ok_telescope then
		builtin.lsp_document_symbols()
		return
	end
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
