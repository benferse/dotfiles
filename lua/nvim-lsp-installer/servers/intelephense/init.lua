local server = require "nvim-lsp-installer.server"
local npm = require "nvim-lsp-installer.installers.npm"

return function(name, root_dir)
    return server.Server:new {
        name = name,
        root_dir = root_dir,
        homepage = "https://intelephense.com",
        languages = { "php" },
        installer = npm.packages { "intelephense" },
        default_options = {
            cmd_env = npm.env(root_dir),
        },
    }
end
