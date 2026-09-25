local function is_blocks_templated_sql(buf)
  if vim.bo[buf].filetype ~= 'sql' then return false end
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, 20, false)) do
    if line:match('@include') or line:match('@BLOCKS_') then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if is_blocks_templated_sql(args.buf) then return end
    pcall(vim.treesitter.start, args.buf)
  end,
})
