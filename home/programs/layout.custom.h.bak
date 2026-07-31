/* constants */
/* how tall the keyboard should be by default (can be overriden) */
#define KBD_PIXEL_HEIGHT 250

/* how tall the keyboard should be by default (can be overriden) */
#define KBD_PIXEL_LANDSCAPE_HEIGHT 120

/* spacing around each key */
#define KBD_KEY_BORDER 4

/* layout declarations */
enum layout_id {
	Landscape = 1,
	LandscapeSpecial = 2,
	Emoji = 3,
	Index,
	NumLayouts,
};

static struct key keys_landscape[], keys_landscape_special[], keys_emoji[];

static struct layout layouts[NumLayouts] = {
  [Landscape] = {keys_landscape, "latin", "landscape", true},
  [LandscapeSpecial] = {keys_landscape_special, "latin", "landscapespecial", true},
  [Emoji] = {keys_emoji, "latin", "emoji", false},
};

static struct key keys_emoji[] = {
  {"🙂", "🙏", 1.0, Copy, 0x1f642, 0, 0x1f64f}, // Emojis
  {"😀", "🙋", 1.0, Copy, 0x1f600, 0, 0x1f64b},
  {"😁", "✋", 1.0, Copy, 0x1f601, 0, 0x270B},
  {"😂", "🙇", 1.0, Copy, 0x1f602, 0, 0x1f647},
  {"😃", "👨", 1.0, Copy, 0x1f603, 0, 0x1f468},
  {"😄", "👩", 1.0, Copy, 0x1f604, 0, 0x1f469},
  {"😅", "👶", 1.0, Copy, 0x1f605, 0, 0x1f476},
  {"😆", "👻", 1.0, Copy, 0x1f606, 0, 0x1f47b},
  {"😇", "✨", 1.0, Copy, 0x1f607, 0, 0x2728},
  {"🤣", "💰", 1.0, Copy, 0x1f923, 0, 0x1f4b0},
  {"", "", 0.0, EndRow},
  {"😉", "🐕", 1.0, Copy, 0x1f609, 0, 0x1f415},
  {"😊", "🐈", 1.0, Copy, 0x1f60a, 0, 0x1f408},
  {"😋", "🐧", 1.0, Copy, 0x1f60b, 0, 0x1f427},
  {"😌", "🐇", 1.0, Copy, 0x1f60c, 0, 0x1f407},
  {"😍", "💔", 1.0, Copy, 0x1f60d, 0, 0x1f494},
  {"😘", "💕", 1.0, Copy, 0x1f618, 0, 0x1f495},
  {"😎", "❤", 1.0, Copy, 0x1f60e, 0, 0x2764},
  {"😐", "😏", 1.0, Copy, 0x1f610, 0, 0x1f60f},
  {"😒", "👀", 1.0, Copy, 0x1f612, 0, 0x1f440},
  {"😓", "💀", 1.0, Copy, 0x1f613, 0, 0x1f480},
  {"", "", 0.0, EndRow},
  {"⇧", "⇫", 1.0, Mod, Shift, .scheme = 1},
  {"😛", "😜", 1.0, Copy, 0x1f61b, 0, 0x1f61c},
  {"😮", "😝", 1.0, Copy, 0x1f62e, 0, 0x1f61d},
  {"😟", "😞", 1.0, Copy, 0x1f61f, 0, 0x1f61e},
  {"😠", "🥺", 1.0, Copy, 0x1f620, 0, 0x1f97a},
  {"😢", "👿", 1.0, Copy, 0x1f622, 0, 0x1f47f},
  {"😭", "😯", 1.0, Copy, 0x1f62d, 0, 0x1f62f},
  {"😳", "😕", 1.0, Copy, 0x1f633, 0, 0x1f615},
  {"😴", "😵", 1.0, Copy, 0x1f634, 0, 0x1f635},
  {"⌫", "⌫", 1.0, Code, KEY_BACKSPACE, .scheme = 1},
  {"", "", 0.0, EndRow},
  {"Abc", "Abc", 1.0, BackLayer, .scheme = 1},
  {"⌨͕", "⌨͔", 1.0, NextLayer, .scheme = 1},
  {"👆", "👊", 1.0, Copy, 0x1f446, 0, 0x1f44a},
  {"👇", "👌", 1.0, Copy, 0x1f447, 0, 0x1f44c},
  {"👈", "👏", 1.0, Copy, 0x1f448, 0, 0x1f44f},
  {"👉", "👐", 1.0, Copy, 0x1f449, 0, 0x1f450},
  {"👋", "🙌", 1.0, Copy, 0x1f44b, 0, 0x1f64c},
  {"👍", "✅", 1.0, Copy, 0x1f44d, 0, 0x2705},
  {"👎", "💪", 1.0, Copy, 0x1f44e, 0, 0x1f4aa},
  {"Enter", "Enter", 1.0, Code, KEY_ENTER, .scheme = 1},
  {"", "", 0.0, Last},
};

static struct key keys_landscape[] = {
  {"q", "Q", 1.0, Code, KEY_Q, .scheme = 1},
  {"w", "W", 1.0, Code, KEY_W, .scheme = 1},
  {"e", "E", 1.0, Code, KEY_E, .scheme = 1},
  {"r", "R", 1.0, Code, KEY_R, .scheme = 1},
  {"t", "T", 1.0, Code, KEY_T, .scheme = 1},
  {"y", "Y", 1.0, Code, KEY_Y, .scheme = 1},
  {"u", "U", 1.0, Code, KEY_U, .scheme = 1},
  {"i", "I", 1.0, Code, KEY_I, .scheme = 1},
  {"o", "O", 1.0, Code, KEY_O, .scheme = 1},
  {"p", "P", 1.0, Code, KEY_P, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"a", "A", 1.0, Code, KEY_A, .scheme = 1},
  {"s", "S", 1.0, Code, KEY_S, .scheme = 1},
  {"d", "D", 1.0, Code, KEY_D, .scheme = 1},
  {"f", "F", 1.0, Code, KEY_F, .scheme = 1},
  {"g", "G", 1.0, Code, KEY_G, .scheme = 1},
  {"h", "H", 1.0, Code, KEY_H, .scheme = 1},
  {"j", "J", 1.0, Code, KEY_J, .scheme = 1},
  {"k", "K", 1.0, Code, KEY_K, .scheme = 1},
  {"l", "L", 1.0, Code, KEY_L, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"⇧", "⇫", 1.5, Mod, Shift},
  {"z", "Z", 1.0, Code, KEY_Z, .scheme = 1},
  {"x", "X", 1.0, Code, KEY_X, .scheme = 1},
  {"c", "C", 1.0, Code, KEY_C, .scheme = 1},
  {"v", "V", 1.0, Code, KEY_V, .scheme = 1},
  {"b", "B", 1.0, Code, KEY_B, .scheme = 1},
  {"n", "N", 1.0, Code, KEY_N, .scheme = 1},
  {"m", "M", 1.0, Code, KEY_M, .scheme = 1},
  {"⌫", "⌫", 1.5, Code, KEY_BACKSPACE, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"?123", "?123", 1.0, Layout, 0, &layouts[LandscapeSpecial]},
  {"Ctr", "Ctr", 1.0, Mod, Ctrl, .scheme = 1},
  {",", ",", 1.0, Code, KEY_COMMA, .scheme = 1},
  {"🙂", "🙂", 1.0, Layout, 0, &layouts[Emoji]},
  {"", "", 5.0, Code, KEY_SPACE, .scheme = 1},
  {".", ".", 1.0, Code, KEY_DOT, .scheme = 1},
  {"Enter", "Enter", 2.0, Code, KEY_ENTER, .scheme = 1},

  /* end of layout */
  {"", "", 0.0, Last},
};

static struct key keys_landscape_special[] = {
  {"Esc", "Esc", 1.0, Code, KEY_ESC, .scheme = 1},
  {"1", "1", 1.0, Code, KEY_1, .scheme = 1},
  {"2", "2", 1.0, Code, KEY_2, .scheme = 1},
  {"3", "3", 1.0, Code, KEY_3, .scheme = 1},
  {"4", "4", 1.0, Code, KEY_4, .scheme = 1},
  {"5", "5", 1.0, Code, KEY_5, .scheme = 1},
  {"6", "6", 1.0, Code, KEY_6, .scheme = 1},
  {"7", "7", 1.0, Code, KEY_7, .scheme = 1},
  {"8", "8", 1.0, Code, KEY_8, .scheme = 1},
  {"9", "9", 1.0, Code, KEY_9, .scheme = 1},
  {"0", "0", 1.0, Code, KEY_0, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"`", "`", 0.5, Code, KEY_GRAVE, .scheme = 1},
  {"~", "~", 0.5, Code, KEY_GRAVE, .scheme = 1},
  {"!", "!", 1.0, Code, KEY_1, .scheme = 1},
  {"@", "@", 1.0, Code, KEY_2, .scheme = 1},
  {"#", "#", 1.0, Code, KEY_3, .scheme = 1},
  {"$", "$", 1.0, Code, KEY_4, .scheme = 1},
  {"%", "%", 1.0, Code, KEY_5, .scheme = 1},
  {"^", "^", 1.0, Code, KEY_6, .scheme = 1},
  {"&", "&", 1.0, Code, KEY_7, .scheme = 1},
  {"*", "*", 1.0, Code, KEY_8, .scheme = 1},
  {"-", "-", 1.0, Code, KEY_MINUS, .scheme = 1},
  {"=", "=", 1.0, Code, KEY_EQUAL, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"Abc", "Abc", 1.0, Layout, 0, &layouts[Landscape]},
  {"(", "(", 0.5, Code, KEY_9, .scheme = 1},
  {")", ")", 0.5, Code, KEY_0, .scheme = 1},
  {"[", "[", 0.5, Code, KEY_LEFTBRACE, .scheme = 1},
  {"]", "]", 0.5, Code, KEY_RIGHTBRACE, .scheme = 1},
  {"{", "{", 0.5, Code, KEY_LEFTBRACE, .scheme = 1},
  {"}", "}", 0.5, Code, KEY_RIGHTBRACE, .scheme = 1},
  {"\\", "\\", 0.75, Code, KEY_BACKSLASH, .scheme = 1},
  {"|", "|", 0.75, Code, KEY_BACKSLASH, .scheme = 1},
  {";", ";", 1.0, Code, KEY_SEMICOLON, .scheme = 1},
  {":", ":", 1.0, Code, KEY_SEMICOLON, .scheme = 1},
  {"'", "'", 1.0, Code, KEY_APOSTROPHE, .scheme = 1},
  {"\"", "\"", 1.0, Code, KEY_APOSTROPHE, .scheme = 1},
  {"/", ">", 1.0, Code, KEY_SLASH, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"↑", "↑", 1.5, Code, KEY_UP, .scheme = 1},
  {"↓", "↓", 1.5, Code, KEY_DOWN, .scheme = 1},
  {"_", "_", 1.0, Code, KEY_MINUS, .scheme = 1},
  {"+", "+", 1.0, Code, KEY_EQUAL, .scheme = 1},
  {"<", "<", 1.0, Code, KEY_COMMA, .scheme = 1},
  {">", ">", 1.0, Code, KEY_DOT, .scheme = 1},
  {"/", "/", 1.0, Code, KEY_SLASH, .scheme = 1},
  {"⌫", "⌫", 3.0, Code, KEY_BACKSPACE, .scheme = 1},
  {"", "", 0.0, EndRow},

  {"←", "←", 1.5, Code, KEY_LEFT, .scheme = 1},
  {"→", "→", 1.5, Code, KEY_RIGHT, .scheme = 1},
  {"Sup", "Sup", 1.0, Mod, Super, .scheme = 1},
  {"", "", 6.0, Code, KEY_SPACE, .scheme = 1},
  {"Enter", "Enter", 2.0, Code, KEY_ENTER, .scheme = 1},

  /* end of layout */
  {"", "", 0.0, Last},
};
