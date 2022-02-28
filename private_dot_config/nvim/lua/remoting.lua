-- Remote control an instance management of a running
-- nvim server

if vim.fn.has('win32') == 0 then
    -- Make sure that internal terminals can launch this
    -- server as git's preferred editor
    vim.fn.setenv('GIT_EDITOR', [[nvr -cc split --remote-wait]])

    -- Delete temporary git message buffers as soon as possible
    -- so git stops waiting for us
    vim.cmd [[
        augroup git_autoclose
            autocmd! FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
        augroup END
    ]]
end
