local cmd = vim.cmd

--
-- Filetype detection doesn't do a great job of telling the
-- difference between json and jsonc (just json, but allows
-- comments). So just highlight comments as such anywhere, and
-- assume I'm smart enough to know where they're actually
-- supported :|
--
-- The default json syntax does let you turn off warnings altogether
-- with g:vim_json_warnings = 0, but I just want to squelch this one
--
cmd([[syntax match Comment +\/\/.\+$+]])
