## Requirements

- [Neovim](https://neovim.io/) 0.5 or later
- Lint task requires [luacheck](https://github.com/luarocks/luacheck#installation) and [stylua](https://github.com/JohnnyMorganz/StyLua). If using nix, you can use `nix develop` to install these to a local nix shell.
- Documentation is generated by `scripts/docgen.lua`.
  - Only works on linux and macOS

## Scope of lspconfig

The point of lspconfig is to provide the minimal configuration necessary for a server to act in compliance with the language server protocol. In general, if a server requires custom client-side commands or  off-spec handlers, then the server configuration should be added *without* those in lspconfig and receive a dedicated plugin such as nvim-jdtls, nvim-metals, etc.

## Adding a server to lspconfig

The general form of adding a new language server is to start with a minimal skeleton. This includes populated the `config` table with a `default_config` and `docs` table.

`default_config` should include, at minimum the following:
* `cmd`: a list which includes the executable name as the first entry, with arguments constituting subsequent list elements (`--stdio` is common)
* `filetypes`: a list for filetypes a 
* `root_dir`: a function (or function handle) which returns the root of the project used to determine if lspconfig should launch a new language server, or attach a previously launched server when you open a new buffer matching the filetype of the server. Note, lspconfig does not offer a dedicated single file mode (this is not codified in the spec). Do not add `vim.fn.cwd` or `util.path.dirname` in `root_dir`. A future version of lspconfig will provide emulation of a single file mode until this is formally codified in the specification. A good fallback is `util.find_git_ancestor`, see other configurations for examples.

Additionally, the following options are often added:

* `init_options`: a table sent during initialization, corresponding to initializationOptions sent in [initializeParams](https://microsoft.github.io/language-server-protocol/specifications/specification-3-17/#initializeParams) as part of the first request sent from client to server during startup.
* `settings`: a table sent during [`workspace/didChangeConfiguration`](https://microsoft.github.io/language-server-protocol/specifications/specification-3-17/#didChangeConfigurationParams) shortly after server initialization. This is an undocumented convention for most language servers. There is often some duplication with initOptions.

A minimal example for adding a new language server is shown below for `pyright`, a python language server included in lspconfig:

```lua
-- Only `configs` must be required, util is optional if you are using the root resolver functions, which is usually the case.
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

-- Having server name defined here is the convention, this is often times also the first entry in the `cmd` table.
local server_name = 'pyright'

configs[server_name] = {
  default_config = {
    -- This should be executable on the command line, arguments (such as `--stdio`) are additional entries in the list.
    cmd = { 'pyright-langserver' },
    -- These are the filetypes that the server will either attach or start in response to opening. The user must have a filetype plugin matching the filetype, either via the built-in runtime files or installed via plugin.
    filetypes = { 'python' },
    -- The root directory that lspconfig uses to determine if it should start a new language server, or attach the current buffer to a previously running language server.
    root_dir = util.find_git_ancestor
    end,
  },
  docs = {
    -- extremely important: the package.json that contains language server settings, not the package.json that contains javascript dependencies for the project, or the package.json that contains vscode specific settings
    package_json = 'https://raw.githubusercontent.com/microsoft/pyright/master/packages/vscode-pyright/package.json',

    -- The description should include at minimum the link to the github project, and ideally the steps to install the language server.
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python

`pyright` can be installed via `npm`
`npm install -g pyright`
]],
  },
}
```

## Commit style

lspconfig, like neovim core, follows the [conventional commit style](https://www.conventionalcommits.org/en/v1.0.0-beta.2/) please submit your commits accordingly. Generally commits will be of the form:

```
feat: add lua-language-server support
fix(lua-language-server): update root directory pattern
docs: update README.md
```

with the commit body containing additional details.

## Lint

PRs are checked with Luacheck and stylua. Please run the linter locally before submitting a PR:

    make lint

## Generating docs

Github Actions automatically generates the `CONFIG.md`. Only modify `scripts/README_template.md` or the `docs` table in the server config (the lua file). Do not modify `CONFIG.md` directly.

To preview the generated `CONFIG.md` locally, run `scripts/docgen.lua` from
`nvim` (from the project root):

    nvim -R -Es +'set rtp+=$PWD' +'luafile scripts/docgen.lua'