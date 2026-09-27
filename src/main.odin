#+feature dynamic-literals
package main

import rl "vendor:raylib"

FONT_DATA :: #load("./assets/Atkinson-Hyperlegible-Mono.ttf")
MAX_FONT_SIZE_USED :: 50

some_map := map[string]int {
  "A" = 1,
  "B" = 4,
  "C" = 9,
}

main :: proc() {
  // Window config
  rl.SetConfigFlags({.WINDOW_RESIZABLE, .WINDOW_HIGHDPI})
  rl.InitWindow(1280, 720, "Boids")
  defer rl.CloseWindow()

  rl.SetTargetFPS(60)
  rl.DisableCursor()

  // Load font
  base_font_size := MAX_FONT_SIZE_USED * i32(rl.GetWindowScaleDPI().y)
  font := rl.LoadFontFromMemory(
    ".ttf",
    raw_data(FONT_DATA),
    i32(len(FONT_DATA)),
    base_font_size,
    nil,
    0,
  )
  defer rl.UnloadFont(font)
  rl.SetTextureFilter(font.texture, rl.TextureFilter.BILINEAR)

  // Define the camera
  camera: rl.Camera3D = {{0, 10, 10}, {0, 0, 0}, {0, 1, 0}, 45, .PERSPECTIVE}

  // Main loop
  for (!rl.WindowShouldClose()) {
    rl.UpdateCamera(&camera, .FREE)

    rl.BeginDrawing()
    defer rl.EndDrawing()

    rl.ClearBackground(rl.GetColor(0x060606ff))

    rl.BeginMode3D(camera)
    defer rl.EndMode3D()

    rl.DrawCube({0, 0, 0}, 2, 2, 2, rl.BLUE)
    rl.DrawCubeWires({0, 0, 0}, 2, 2, 2, rl.MAROON)
    rl.DrawGrid(10, 1)
  }
}
