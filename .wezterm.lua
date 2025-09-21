-- Pull in the wezterm API
local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- current colorscheme
-- config.color_scheme = "Rose-Pine"
config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 14

config.enable_tab_bar = false

-- Wayland-specific window styling
config.enable_wayland = true -- Explicitly enable Wayland support
config.use_fancy_tab_bar = false -- Use tab bar as title bar replacement
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "NONE"
config.window_background_opacity = 0.80
config.text_background_opacity = 1.0
config.kde_window_background_blur = true

-- Enable blur support (requires compositor support)

-- KDE Wayland optimizations
config.front_end = "WebGpu" -- Better performance on Wayland
config.webgpu_power_preference = "HighPerformance" -- Use discrete GPU if available

-- Wayland-specific rendering improvements
config.enable_kitty_graphics = true -- Better image support
-- config.term = "wezterm" -- Proper terminal identification

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.enable_tab_bar = true

-- KDE integration improvements
config.window_close_confirmation = "NeverPrompt" -- Let KDE handle confirmations
config.check_for_updates = false -- Disable if using system package manager

-- Clipboard integration for Wayland
config.selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%"

-- Better scrolling on Wayland
config.alternate_buffer_wheel_scroll_speed = 3

-- KDE-friendly keybindings (optional)
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "F13", mods = "", timeout_milliseconds = 1000 }

-- Pane management keybindings using Hyper key (CTRL+ALT+SUPER+SHIFT)
config.keys = {
	-- Pane splitting
	{
		key = "\\",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Pane navigation (vim-style)
	{
		key = "h",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	-- Pane resizing (using Shift+letter for capital letters)
	{
		key = "H",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},

	-- Close current pane
	{
		key = "w",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Zoom/unzoom pane
	{
		key = "z",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- Rotate panes
	{
		key = "r",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{
		key = "R",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.RotatePanes("CounterClockwise"),
	},

	-- Create new tab
	{
		key = "t",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Tab navigation
	{
		key = "1",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateTab(4),
	},

	-- New window
	{
		key = "Enter",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.SpawnWindow,
	},

	-- Command palette
	{
		key = "p",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "f",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.Search({ CaseSensitiveString = "" }),
	},
	{
		key = "c",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "x",
		mods = "CTRL|ALT|SUPER",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}

-- Optional: Visual improvements for pane management
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Optional: Add padding since we removed system decorations
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- Performance optimizations for KDE Wayland
config.max_fps = 144 -- Match your display refresh rate
config.animation_fps = 60
config.cursor_blink_rate = 500

-- and finally, return the configuration to wezterm
return config
