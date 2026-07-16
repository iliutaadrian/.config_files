-- Fuzzy-find directories under cwd (fd + fzf), then cd into pick
local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

local function entry()
	local _permit = ya.hide()
	local cwd = get_cwd()

	local child, err = Command("sh")
		:arg({ "-c", "fd --type d --hidden --exclude .git --absolute-path | fzf" })
		:cwd(cwd)
		:stdout(Command.PIPED)
		:spawn()

	if not child then
		return ya.notify({ title = "fzf-dirs", content = tostring(err), timeout = 5, level = "error" })
	end

	local output = child:wait_with_output()
	local target = output and output.stdout:gsub("\n$", "") or ""
	if target ~= "" then
		ya.emit("cd", { target })
	end
end

return { entry = entry }
