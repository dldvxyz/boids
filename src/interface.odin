package main

import "core:fmt"
import rl "vendor:raylib"

DrawUI :: proc(font: Font) {
  fps := rl.GetFPS()
  text(font, fmt.ctprintf("FPS: %v", fps), screen_relative_position(0.05, 0.05), 20, 0, rl.WHITE)
}
