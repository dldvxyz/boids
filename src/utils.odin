package main

import rl "vendor:raylib"

text :: proc(
  font: Font,
  text: cstring,
  position: Vector2,
  fontSize: f32,
  spacing: f32,
  color: rl.Color,
) {
  textSize := rl.MeasureTextEx(font, text, fontSize, spacing)
  center := Vector2{position.x - (textSize.x / 2), position.y - (textSize.y / 2)}
  rl.DrawTextEx(font, text, center, fontSize, spacing, color)
}

screen_relative_position :: proc(percent_x: f32, percent_y: f32) -> Vector2 {
  screen_width := cast(f32)rl.GetScreenWidth()
  screen_height := cast(f32)rl.GetScreenHeight()
  return Vector2{screen_width * percent_x, screen_height * percent_y}
}
