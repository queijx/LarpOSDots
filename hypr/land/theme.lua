hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 0,

		col = {

			active_border = "rgba(ffffff00)",
			inactive_border = "rgba(ffffff00)",
		},

		resize_on_border = false,

		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 0,
			render_power = 0,
			color = 0xff000000,
		},

		blur = {
			enabled = false,
			size = 0,
			passes = 0,
		},
	},

	animations = {
		enabled = false,
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})