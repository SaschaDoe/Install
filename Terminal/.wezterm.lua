local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- This will hold the configuration.
local config = {
	audible_bell = "Disabled",
	check_for_updates = false,
	color_scheme = "Dracula",
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	font_size = 12.0,
	launch_menu = {},
	leader = { key = "a", mods = "CTRL" },
	disable_default_key_bindings = true,
	keys = {
		{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "j", mods = "CTRL", action = wezterm.action({ ScrollByLine = 1 }) }, -- Scroll down
		{ key = "k", mods = "CTRL", action = wezterm.action({ ScrollByLine = -1 }) }, -- Scroll up

		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
		{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
		{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

		{ key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
		{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "c", mods = "SHIFT|CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
		{ key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
		{ key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
	},
	set_environment_variables = {},
}
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
	local tab, pane, window = window:spawn_tab {
		cwd = "D:\\projects"
	}
end)

return config
