function setup_custom_prompt()

    local cwd = clink.get_cwd()
    local username = os.getenv('USERNAME')
    local computer = os.getenv('COMPUTERNAME')
    local template = "{u}@{c} {d}\n# " 

    local with_cwd = string.gsub(template, "{d}", cwd)
    local with_user = string.gsub(with_cwd, "{u}", username)
    local with_comp = string.gsub(with_user, "{c}", computer)

    clink.prompt.value = with_comp
end

clink.prompt.register_filter(setup_custom_prompt, 1)