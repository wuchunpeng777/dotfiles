-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

if vim.loop.os_uname().sysname == "Darwin" then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h17'
else
  vim.o.guifont = 'JetBrainsMono Nerd Font:h11'
end

vim.opt.clipboard = "unnamed"

vim.cmd([[highlight FlashLabel guifg='#ffffff' guibg='#FF1493' gui=bold]])

vim.g.neovide_floating_blur_amount_x = 7 
vim.g.neovide_floating_blur_amount_y = 7 

vim.o.scrolloff = 999

vim.cmd[[nnoremap <silent> <leader>bb :BufferLinePick<CR>]]

--打开当前文件所在目录
if vim.loop.os_uname().sysname == "Darwin" then
  vim.cmd[[nnoremap <leader>cd :!open %:h<CR>]]
else
  vim.cmd[[nnoremap <leader>cd :!start %:h<CR>]]
end

vim.wo.relativenumber = true

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = false, lsp_fallback = true, range = range })
end, { range = true })