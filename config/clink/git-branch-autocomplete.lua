local checkoutAliases = {}

function string.starts(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

function string.ends(str, _end)
  return string.sub(str, string.len(str) - string.len(_end) + 1) == _end
end

function is_checkout_ac(text)
  if string.starts(text, "git checkout") then
    return true
  end

  for i, _alias in ipairs(checkoutAliases) do
    if string.starts(text, "git ".._alias) then
      return true
    end
  end

  return false
end

function get_branches()
  local handle = io.popen("git branch -r 2>&1")
  local result = handle:read("*a")
  handle:close()

  local branches = {}

  if string.starts(result, "fatal") == false then
    for branch in string.gmatch(result, "  %S+") do
      branch = string.gsub(branch, "  origin%/", "")

      if branch ~= "HEAD" then
        table.insert(branches, branch)
      end
    end
  end

  return branches
end

function git_branch_autocomplete(text, first, last)
  local matchCount = 0

  if is_checkout_ac(rl_state.line_buffer) then
    local branches = get_branches()

    for i, branch in ipairs(branches) do
      -- if string.len(text) == 0 then
      if string.starts(branch, text) then
        clink.add_match(branch)
        matchCount = matchCount + 1
      end
    end
  end

  return matchCount > 0
end



local handle = io.popen("git config --get-regex alias")
local result = handle:read("*a")
handle:close()

for alias in string.gmatch(result, "%.(%S+ %S+)") do
  -- table.insert(aliases, alias)
  if string.ends(alias, " checkout") then
    table.insert(checkoutAliases, string.gmatch(alias, "%S+")())
  end
end



clink.register_match_generator(git_branch_autocomplete, 1)
