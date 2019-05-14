ps_char = "$"
if os.execute("isadmin.exe") then
    ps_char = "#"
end

env_username = os.getenv("USERNAME"):lower()
env_hostname = os.getenv("COMPUTERNAME"):lower()
env_homepath = os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH")

-- adapted from from clink-completions' git.lua
local function get_git_dir(path)

    -- return parent path for specified entry (either file or directory)
    local function pathname(path)
        local prefix = ""
        local i = path:find("[\\/:][^\\/:]*$")
        if i then
            prefix = path:sub(1, i-1)
        end

        return prefix
    end

    -- Checks if provided directory contains git directory
    local function has_git_dir(dir)
        return clink.is_dir(dir..'/.git') and dir..'/.git'
    end

    local function has_git_file(dir)
        local gitfile = io.open(dir..'/.git')
        if not gitfile then return false end

        local git_dir = gitfile:read():match('gitdir: (.*)')
        gitfile:close()

        return git_dir and dir..'/'..git_dir
    end

    -- Set default path to current directory
    if not path or path == '.' then path = clink.get_cwd() end

    -- Calculate parent path now otherwise we won't be
    -- able to do that inside of logical operator
    local parent_path = pathname(path)

    return has_git_dir(path)
        or has_git_file(path)
        -- Otherwise go up one level and make a recursive call
        or (parent_path ~= path and get_git_dir(parent_path) or nil)
end
    ---
-- Find out current branch
-- @return {nil|git branch name}
---
local function get_git_branch(git_dir)
    git_dir = git_dir or get_git_dir()

    -- If git directory not found then we're probably outside of repo
    -- or something went wrong. The same is when head_file is nil
    local head_file = git_dir and io.open(git_dir..'/HEAD')
    if not head_file then return end

    local HEAD = head_file:read()
    head_file:close()

    -- if HEAD matches branch expression, then we're on named branch
    -- otherwise it is a detached commit
    local branch_name = HEAD:match('ref: refs/heads/(.+)')

    return branch_name or 'HEAD detached at '..HEAD:sub(1, 7)
end

---
-- Get the status of working dir
-- @return {bool}
---
local function get_git_status()
    local file = io.popen("git --no-optional-locks status --porcelain 2>nul")
    for line in file:lines() do
        file:close()
        return false
    end
    file:close()

    return true
end

local function get_git_prompt_contents()

    -- Colors for git status
    local colors = {
        clean = "\x1b[1;37;40m",
        dirty = "\x1b[31;1m",
    }

    local git_dir = get_git_dir()
    if git_dir then
        -- if we're inside of git repo then try to detect current branch
        local branch = get_git_branch(git_dir)
        local color
        if branch then
            -- Has branch => therefore it is a git folder, now figure out status
            if get_git_status() then
                color = colors.clean
            else
                color = colors.dirty
            end

            return color.."("..branch..")"
        end
    end

    return ""
end

local function get_working_dir()

    local dir = clink.get_cwd()

    dir = dir:gsub(env_homepath, "~")

    return dir

end

function setup_custom_prompt()

    local token_table = {}

    token_table["{c}"] = env_hostname
    token_table["{u}"] = env_username
    token_table["{d}"] = get_working_dir
    token_table["{p}"] = ps_char
    token_table["{g}"] = get_git_prompt_contents

    local custom_prompt = "\n\xe2\x9c\xa8  \x1b[1;39;40m{u}@{c} {d} {g}\n\x1b[1;39;40m{p} \x1b[0m"

    for key, value in pairs(token_table) do
        custom_prompt = string.gsub(custom_prompt, key, value)
    end

    clink.prompt.value = custom_prompt
end

clink.prompt.register_filter(setup_custom_prompt, 1)
