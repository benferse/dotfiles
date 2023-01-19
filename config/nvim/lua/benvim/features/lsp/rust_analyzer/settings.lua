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
    },
    diagnostics = {
        enable = true,
        experimental = {
            enable = true,
        },
    },
}
