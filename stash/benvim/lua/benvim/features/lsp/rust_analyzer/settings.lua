return {
    cargo = {
        buildScripts = {
            enable = true,
            invocationLocation = "workspace",
        },
    },
    checkOnSave = true,
    check = {
        command = "clippy",
        extraArgs = { "--offline", "--color=never" },
    },
    diagnostics = {
        enable = true,
        experimental = {
            enable = true,
        },
    },
}
