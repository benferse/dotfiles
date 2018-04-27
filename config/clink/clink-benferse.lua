function setup_custom_prompt()

    local token_table = {}

    token_table["{c}"] = os.getenv("COMPUTERNAME")
    token_table["{u}"] = os.getenv("USERNAME")
    token_table["{d}"] = clink.get_cwd

    local custom_prompt = "\n{u}@{c} {d}\n# "

    for key, value in pairs(token_table) do
        custom_prompt = string.gsub(custom_prompt, key, value)
    end

    clink.prompt.value = custom_prompt 
end

clink.prompt.register_filter(setup_custom_prompt, 1)