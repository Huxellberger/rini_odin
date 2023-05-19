// rini config bindings for odin
// original src: https://github.com/raysan5/rini all credit to Ramon Santamaria
// done by Jake Huxell, submit updates/PRs to https://github.com/Huxellberger

package rini;

import "core:c";

when ODIN_OS == .Windows {
	foreign import lib {
		"rini.lib",
		"system:Winmm.lib",
		"system:Gdi32.lib",
		"system:User32.lib",
		"system:Shell32.lib",
	}
}

VERSION :: "1.0";

// Don't change these unless you change the values in the lib as well!
RINI_MAX_KEY_SIZE :: 64;
RINI_MAX_TEXT_SIZE :: 64;
RINI_MAX_DESC_SIZE :: 128;

RIniConfigValue :: struct
{
	key : [RINI_MAX_KEY_SIZE]c.char,
	text : [RINI_MAX_TEXT_SIZE]c.char,
	desc : [RINI_MAX_DESC_SIZE]c.char,
}

RIniConfig :: struct
{
	values : ^RIniConfigValue,
	count : c.uint,
	capacity : c.uint,
}

@(default_calling_convention="c", link_prefix="rini_")
foreign lib
{
	load_config :: proc(fileName : cstring) -> RIniConfig --- // Load config from file (*.ini) or create a new config object (pass NULL)
		unload_config :: proc(config : ^RIniConfig) --- // Unload config data from memory
		save_config :: proc(config : RIniConfig, fileName : cstring, header : cstring) --- // Save config to file, with custom header
	
		get_config_value :: proc(config : RIniConfig, key : cstring) -> c.int --- // Get config value int for provided key, returns -1 if not found
		get_config_value_text :: proc(config : RIniConfig, key : cstring) -> cstring --- // Get config value text for provided key
		get_config_value_description :: proc(config : RIniConfig, key : cstring) -> cstring --- // Get config value description for provided key
	
		// Set config value int/text and description for existing key or create a new entry
		// NOTE: When setting a text value, if id does not exist, a new entry is automatically created
		// returns -1 on fail
		set_config_value :: proc(config : ^RIniConfig, key : cstring, value : c.int, desc : cstring) -> c.int ---
		set_config_value_text :: proc(config : ^RIniConfig, key : cstring, text : cstring, desc : cstring) -> c.int ---
		
		// Set config value description for existing key
		// WARNING: Key must exist to add description, if a description exists, it is updated
		// returns -1 on fail
		set_config_value_description :: proc(config : ^RIniConfig, key : cstring, desc : cstring) -> c.int ---
}

