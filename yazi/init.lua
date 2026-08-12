require("yaziline"):setup({
	color = th.mode.normal_main:bg(),
	secondary_color = th.mode.normal_alt:bg(),
	separator_style = "angly",
	default_files_color = "white",
	filename_max_length = 24,
	filename_truncate_length = 6,
	filename_truncate_separator = "...",
})
