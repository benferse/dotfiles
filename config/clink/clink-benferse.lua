ps_char = "$"
if os.execute("isadmin.exe") then
    ps_char = "#"
end

function setup_custom_prompt()

    local token_table = {}

    token_table["{c}"] = os.getenv("COMPUTERNAME")
    token_table["{u}"] = os.getenv("USERNAME")
    token_table["{d}"] = clink.get_cwd
    token_table["{p}"] = ps_char

    local custom_prompt = "\n\x1b[1;39;40m{u}@{c} {d}\n\x1b[1;39;40m{p} \x1b[0m"

    for key, value in pairs(token_table) do
        custom_prompt = string.gsub(custom_prompt, key, value)
    end

    clink.prompt.value = custom_prompt 
end

clink.prompt.register_filter(setup_custom_prompt, 1)