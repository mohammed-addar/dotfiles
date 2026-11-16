//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "dwmblocks-mem", 5, 1},

	{" ", "dwmblocks-vol", 0, 10},

	{" ", "dwmblocks-wifi", 10, 2},

	{" ", "dwmblocks-date", 60, 3},

	{" ", "dwmblocks-bat", 30, 4},

};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " 󰇙 ";
static unsigned int delimLen = 5;
