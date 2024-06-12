local wezterm = require("wezterm")
local act = wezterm.action

local mac = {}
mac.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.0,
}
--取消退出确认
mac.window_close_confirmation = "NeverPrompt"
--背景透明度
mac.window_background_opacity = 0.5
mac.macos_window_background_blur = 400
mac.font_size = 18.0
--取消windows的原生标题栏
mac.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- 滚动条尺寸为 15 ，其他方向不需要 pad
mac.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- 启用滚动条
mac.enable_scroll_bar = true
mac.colors = {
	background = "black",
}
mac.leader = { key = "b", mods = "CTRL" }
mac.keys = {
	-- 清屏
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({
				key = "L",
				mods = "CTRL",
			}),
		}),
	},
	{ -- 关闭当前窗口
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({
			confirm = true,
		}),
	},
	{ -- 新建窗口
		key = "n",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			label = "Zsh-NewWindow",
			args = { "/bin/zsh", "-l" },
		}),
	},

	-- select tab
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ mods = "LEADER", key = "s", action = wezterm.action.PaneSelect },

	--rename tab
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ mods = "LEADER", key = "w", action = wezterm.action.ShowTabNavigator },

	-- zoom pane
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },

	-- close pane
	{ key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

	-- split window
	{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

	-- rotate pane
	{ key = "n", mods = "CTRL", action = act.RotatePanes("Clockwise") },

	-- adjust pane size
	{ key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
}

local win = {}
win.window_background_image = "C:/Users/HQ/.config/wezterm/Modified.jpg"
win.window_close_confirmation = "NeverPrompt"
win.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
win.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.0,
}
win.font_size = 12.0
--取消windows的原生标题栏
win.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- 滚动条尺寸为 15 ，其他方向不需要 pad
win.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- 启用滚动条
win.enable_scroll_bar = true
win.colors = {
	background = "black",
}
win.leader = { key = "b", mods = "CTRL" }
win.keys = {
	-- 清屏
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({
				key = "L",
				mods = "CTRL",
			}),
		}),
	},
	{ -- 关闭当前窗口
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({
			confirm = true,
		}),
	},
	{ -- 新建窗口
		key = "n",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			label = "Zsh-NewWindow",
			args = { "powershell.exe", "-NoLogo" },
		}),
	},

	-- select tab
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ mods = "LEADER", key = "s", action = wezterm.action.PaneSelect },

	--rename tab
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ mods = "LEADER", key = "w", action = wezterm.action.ShowTabNavigator },

	-- zoom pane
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },

	-- close pane
	{ key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

	-- split window
	{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

	-- rotate pane
	{ key = "n", mods = "CTRL", action = act.RotatePanes("Clockwise") },

	-- adjust pane size
	{ key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
}
win.default_prog = { "powershell.exe", "-NoLogo" }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	return win
else
	return mac
end
