#+feature dynamic-literals
package main

import "core:math/rand"
import rl "vendor:raylib"

FONT_BYTES :: #load("../assets/Atkinson-Hyperlegible-Mono.ttf")

MAX_FONT_SIZE_USED :: 32
SHIFT_CAMERA_SPEED: f32 : 2
BOID_NUMBER :: 200

Boid :: struct {
  position:       Vector3,
  rotation_axis:  Vector3,
  rotation_angle: f32,
}

main :: proc() {
  // Window config
  rl.SetTraceLogLevel(.WARNING)
  rl.SetConfigFlags({.WINDOW_RESIZABLE, .WINDOW_HIGHDPI})
  rl.InitWindow(width = 1280, height = 720, title = "Boids")
  defer rl.CloseWindow()

  rl.SetTargetFPS(60)
  rl.DisableCursor()

  // Load font
  base_font_size := MAX_FONT_SIZE_USED * cast(i32)rl.GetWindowScaleDPI().y
  font := rl.LoadFontFromMemory(
    ".ttf",
    raw_data(FONT_BYTES),
    cast(i32)len(FONT_BYTES),
    base_font_size,
    nil,
    0,
  )
  defer rl.UnloadFont(font)
  rl.SetTextureFilter(font.texture, .BILINEAR)

  // Load boid model
  boid_model := rl.LoadModel("./assets/boid.glb")
  defer rl.UnloadModel(boid_model)

  // Define the camera
  camera: rl.Camera3D = {{0, 250, 300}, {0, 0, 50}, {0, 1, 0}, 45, .PERSPECTIVE}

  boids: [BOID_NUMBER]Boid
  rotation_axis_choice: [3]Vector3 = {{0, 0, 1}, {0, 1, 0}, {1, 0, 0}}
  for i := 0; i < BOID_NUMBER; i += 1 {
    boids[i].position = {
      rand.float32_range(-350, 350),
      rand.float32() * 50,
      rand.float32_range(-175, 175),
    }
    boids[i].rotation_axis = rand.choice(rotation_axis_choice[:])
    boids[i].rotation_angle = rand.float32_range(0, 90)
  }

  // Main loop
  for (!rl.WindowShouldClose()) {
    rl.BeginDrawing()
    defer rl.EndDrawing()

    UpdateCamera(&camera)

    rl.ClearBackground(GetColor(0x060606ff))

    Render3D(camera, boid_model, boids)

    DrawUI(font)
  }
}

UpdateCamera :: proc(camera: ^Camera3D) {
  speed_multiplier := IsKeyDown(.LEFT_SHIFT) || IsKeyDown(.RIGHT_SHIFT) ? SHIFT_CAMERA_SPEED : 1
  if IsKeyDown(.W) || IsKeyDown(.UP) do CameraMoveForward(camera, 2 * speed_multiplier, false)
  if IsKeyDown(.S) || IsKeyDown(.DOWN) do CameraMoveForward(camera, -2 * speed_multiplier, false)
  if IsKeyDown(.A) || IsKeyDown(.LEFT) do CameraMoveRight(camera, -2 * speed_multiplier, false)
  if IsKeyDown(.D) || IsKeyDown(.RIGHT) do CameraMoveRight(camera, 2 * speed_multiplier, false)
  if IsKeyDown(.Q) do CameraMoveUp(camera, 2 * speed_multiplier)
  if IsKeyDown(.E) do CameraMoveUp(camera, -2 * speed_multiplier)

  mouse_delta := GetMouseDelta()
  UpdateCameraPro(camera, {0, 0, 0}, {mouse_delta.x * 0.1, mouse_delta.y * 0.1, 0}, 0)
}
