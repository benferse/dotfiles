-- Remote control an instance management of a running
-- nvim server

if vim.fn.has('win32') == 0 and vim.fn.executable('nvr') then
    -- Make sure that internal terminals can launch this
    -- server as git's preferred editor
    vim.fn.setenv('GIT_EDITOR', [[nvr -s --remote-tab-wait +'set bufhidden=wipe']])
    vim.fn.setenv('EDITOR', [[nvr -s --remote-tab-wait +'set bufhidden=wipe']])
    vim.fn.setenv('VISUAL', [[nvr -s --remote-tab-wait +'set bufhidden=wipe']])
end
