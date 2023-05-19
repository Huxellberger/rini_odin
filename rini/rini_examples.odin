// Example to test functions are working as expected!
// Looks like there's a bug with the comments in this version that leaves them in the header on save. 
package rini;

CONFIG_LOC :: "example_config.ini";
EXAMPLE_KEY :: "MeaningOfLife";
EXAMPLE_VALUE_INT :: 42;
EXAMPLE_VALUE_TEXT :: "Kippers";
EXAMPLE_VALUE_DESC :: "Delicious Fish! Does it mean something greater?";
EXAMPLE_CONFIG_HEADER :: "This file was created from running rini_test.odin";

EXAMPLE_DIFFERENT_DESC :: "Haldo!";
EXAMPLE_SAVED_VALUE :: 43;

test_config_functions :: proc()
{
	myConfig := load_config(CONFIG_LOC);
	
	set_config_value(&myConfig, EXAMPLE_KEY, EXAMPLE_VALUE_INT, EXAMPLE_VALUE_DESC);
	assert(get_config_value(myConfig, EXAMPLE_KEY) == EXAMPLE_VALUE_INT, "Example value did not match!");
	
	set_config_value_text(&myConfig, EXAMPLE_KEY, EXAMPLE_VALUE_TEXT, EXAMPLE_VALUE_DESC);
	assert(get_config_value_text(myConfig, EXAMPLE_KEY) == EXAMPLE_VALUE_TEXT, "Example text value did not match!");
	
	set_config_value_description(&myConfig, EXAMPLE_KEY, EXAMPLE_DIFFERENT_DESC);
	assert(get_config_value_description(myConfig, EXAMPLE_KEY) == EXAMPLE_DIFFERENT_DESC, "Example desc did not match!");
	
	unload_config(&myConfig);
	
	myConfig = load_config(CONFIG_LOC);
	
	set_config_value(&myConfig, EXAMPLE_KEY, EXAMPLE_SAVED_VALUE, EXAMPLE_VALUE_DESC);
	
	save_config(myConfig, CONFIG_LOC, EXAMPLE_CONFIG_HEADER);
	unload_config(&myConfig);
	
	myConfig = load_config(CONFIG_LOC);
	
	assert(get_config_value(myConfig, EXAMPLE_KEY) == EXAMPLE_SAVED_VALUE, "Example saved value was invalid!");
	
	unload_config(&myConfig);
}
