package main

import rl "vendor:raylib"

text :: proc(
  font: rl.Font,
  text: cstring,
  position: rl.Vector2,
  fontSize: f32,
  spacing: f32,
  color: rl.Color,
) {
  textSize := rl.MeasureTextEx(font, text, fontSize, spacing)
  center := rl.Vector2{position.x - (textSize.x / 2), position.y - (textSize.y / 2)}
  rl.DrawTextEx(font, text, center, fontSize, spacing, color)
}

screenRelativePosition :: proc(percent_x: f32, percent_y: f32) -> rl.Vector2 {
  screen_width := f32(rl.GetScreenWidth())
  screen_height := f32(rl.GetScreenHeight())
  return rl.Vector2{screen_width * percent_x, screen_height * percent_y}
}
