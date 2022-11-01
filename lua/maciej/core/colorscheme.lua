local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
	vim.cmd("colorscheme blue")
	return
end

