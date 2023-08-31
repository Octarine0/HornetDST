name = "Hornet"
description = "A character template for Don't Starve Together."
author = "Pyrotech95 & The Deadly Cow"
version = "0.1.0" -- First number is major version, second number minor version. The third number represents bugfix versions

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = "/files/file/950-extended-sample-character/"

api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"character",
}

configuration_options =
{
	{
		name = "HORNET_HEALTH",
		label = "Hornet's health stat",
		options = {
			{description = "Zote(50)", data = 50},
			{description = "much less (70)", data = 70},
			{description = "less (80)", data = 80},
			{description = "Default (100)", data = 100},
			{description = "more (120)", data = 120},
			{description = "much more (150)", data = 150},
		},
		default = 100,
	},
	{
		name = "HORNET_SANITY",
		label = "Hornet's sanity stat",
		options = {
			{description = "Zote(80)", data = 80},
			{description = "much less (100)", data = 100},
			{description = "less (120)", data = 120},
			{description = "Default (150)", data = 150},
			{description = "more (180)", data = 180},
			{description = "much more (200)", data = 200},
		},
		default = 150,
	},
	{
		name = "HORNET_HUNGER",
		label = "Hornet's hunger stat",
		options = {
			{description = "Zote(80)", data = 80},
			{description = "Much less (100)", data = 100},
			{description = "Less (120)", data = 120},
			{description = "Default (150)", data = 150},
			{description = "More (180)", data = 180},
			{description = "Much more (200)", data = 200},
		},
		default = 150,
	},
	{
		name = "HORNET_MOVESPEED",
		label = "How fast hornet moves",
		options = {
		{description = "Zote", data = 0.95},
		{description = "Wilson Speed", data = 1},
		{description = "Fast Wilson", data = 1.05},
		{description = "Very fast Wilson", data = 1.1},
		{description = "Very Slow Hornet", data = 1.15},
		{description = "Slow Hornet", data = 1.2},
		{description = "Hornet", data = 1.25},
		{description = "Fast Hornet", data = 1.3},
		{description = "Very Fast Hornet", data = 1.35},
		{description = "Very Slow Radiance", data = 1.4},
		{description = "Slow Radiance", data = 1.45},
		{description = "Radiance", data = 1.5},
		},
		default = 1.25,
	},
	{
		name = "HORNET_DAMAGEMULT",
		label = "hornet's damage multiplier",
		options = {
		{description = "Zote (0.9)", data = 0.9},
		{description = "Weak (0.95)", data = 0.95},
		{description = "Hornet (1)", data = 1},
		{description = "Strong Hornet (1.05)", data = 1.05},
		{description = "Very Strong Hornet (1.1)", data = 1.1},
		{description = "Very Weak Radiance (1.15)", data = 1.15},
		{description = "Weak Radiance (1.2)", data = 1.2},
		{description = "Radiance (1.3)", data = 1.3},
		{description = "Buffed Radiance (1.4)", data = 1.4},
		{description = "Too Radiant (1.5)", data = 1.5},
		},
		default = 1,
	},
	--{
		--name = "HORNET_FONT",
		--label = "Option for enabling or disabling Hornet's custom font.",
		--options = {
		--{description = "Enabled", data = "enabled"},
		--{description = "Disabled", data = "disabled"},
		--},
		--default = "enabled",
	--},
	--{
		--name = "HORNET_CHARM",
		--label = "Options for Allowing hornet to use charms from the Hollow Knight mod (If present).",
		--options =	{
		--{description = "Enabled, crafting enabled", data = "crenabled"},
		--{description = "Enabled, crafting disabled", data = "enabled"},
		--{description = "Disabled", data = "disabled"},
		--},
		--default = "enabled",
	--},
}
