local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("Cascadia Mono NF")
config.font_size = 14.0

config.window_background_opacity = 0.80
config.macos_window_background_blur = 7

config.initial_cols = 140
config.initial_rows = 40

config.window_decorations = "RESIZE"

-- Detect system appearance and set color scheme accordingly
local function get_appearance()
if wezterm.gui then
return wezterm.gui.get_appearance()
end
return "Dark"
end

local function scheme_for_appearance(appearance)
if appearance:find("Dark") then
return "Catppuccin Mocha"
else
return "Catppuccin Latte"
end
end

config.color_scheme = scheme_for_appearance(get_appearance())

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function user_and_host()
	return os.getenv("USER") .. "@" .. wezterm.hostname()
end

tabline.setup({
	options = { theme = config.color_scheme },
	sections = {
		tabline_z = { user_and_host },
	},
})
tabline.apply_to_config(config, {})

return config
