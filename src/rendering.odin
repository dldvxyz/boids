package main

import rl "vendor:raylib"

Render3D :: proc(camera: Camera3D, boid_model: Model, boids: [BOID_NUMBER]Boid) {
  rl.BeginMode3D(camera)
  defer rl.EndMode3D()

  rl.DrawPlane({0, 0, 0}, {700, 350}, GetColor(0x1f1f1fff))

  for i := 0; i < BOID_NUMBER; i += 1 {
    rl.DrawModelEx(
      boid_model,
      boids[i].position,
      boids[i].rotation_axis,
      boids[i].rotation_angle,
      4,
      rl.WHITE,
    )
  }
}
