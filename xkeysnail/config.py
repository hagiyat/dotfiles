# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

define_multipurpose_modmap({
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL],
    Key.LEFT_CTRL: [Key.ESC, Key.LEFT_CTRL],
    Key.LEFT_ALT: [Key.MUHENKAN, Key.LEFT_ALT],
    Key.RIGHT_ALT: [Key.HENKAN, Key.RIGHT_ALT],
})

define_keymap(
    None, {
        K('esc'): [K('muhenkan'), K('esc')]
    }, "Esc and IME off"
)

