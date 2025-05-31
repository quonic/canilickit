package main

import "core:fmt"
import "core:strconv"
import "core:strings"
import "vendor:raylib"

// A "Can I Lick it?" Periodic Table

main :: proc() {
	raylib.InitWindow(1148, 620, "Can I Lick it?")

	// Set our game to run at 60 frames-per-second
	raylib.SetTargetFPS(60)

	// Main game loop
	for !raylib.WindowShouldClose() {
		// Update

		// Draw
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.BLACK)

		table_positions: raylib.Vector2 = {180, 100}
		raylib.DrawText("Can I Lick it?", 1148 / 3, 10, 40, raylib.WHITE)
		raylib.DrawText("Periodic Table", 1148 / 2, 60, 20, raylib.WHITE)
		for element, i in Elements {
			x: f32 = f32(element.group) * 50 + table_positions.x
			y: f32 = f32(element.period) * 50 + table_positions.y
			if (element.atomic_number >= 58 && element.atomic_number <= 71) {
				x = f32(element.group + element.atomic_number - 58) * 50 + table_positions.x
				y += 100
			}
			if (element.atomic_number >= 90 && element.atomic_number <= 103) {
				x = f32(element.group + element.atomic_number - 90) * 50 + table_positions.x
				y += 100
			}
			rec: raylib.Rectangle = {x, y, 40, 40}
			raylib.DrawRectangleLinesEx(rec, 1, raylib.WHITE)
			text_color: raylib.Color
			switch element.canLick {
			case .Sure:
				raylib.DrawRectangleRec(rec, raylib.GREEN)
				text_color = raylib.BLACK
			case .Maybe:
				raylib.DrawRectangleRec(rec, raylib.YELLOW)
				text_color = raylib.BLACK
			case .ShouldNot:
				raylib.DrawRectangleRec(rec, raylib.RED)
				text_color = raylib.LIGHTGRAY
			case .PleaseDont:
				raylib.DrawRectangleRec(rec, raylib.PURPLE)
				text_color = raylib.WHITE
			}
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				fmt.caprintf("%v", element.atomic_number),
				{rec.x + rec.width / 2 - 10, rec.y + 2},
				20,
				1,
				text_color,
			)
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				element.symbol,
				{rec.x + rec.width / 2 - 10, rec.y + 20},
				20,
				1,
				raylib.BLACK,
			)
		}

		// Draw the legend

		{
			raylib.DrawRectangle(10, 80, 200, 160, raylib.DARKGRAY)
			raylib.DrawText("Legend:", 20, 90, 20, raylib.WHITE)
			raylib.DrawRectangle(20, 120, 20, 20, raylib.GREEN)
			raylib.DrawText("Sure", 50, 120, 20, raylib.WHITE)
			raylib.DrawRectangle(20, 150, 20, 20, raylib.YELLOW)
			raylib.DrawText("Maybe", 50, 150, 20, raylib.WHITE)
			raylib.DrawRectangle(20, 180, 20, 20, raylib.RED)
			raylib.DrawText("Should Not", 50, 180, 20, raylib.WHITE)
			raylib.DrawRectangle(20, 210, 20, 20, raylib.PURPLE)
			raylib.DrawText("Please Don't", 50, 210, 20, raylib.WHITE)
		}
		raylib.EndDrawing()
	}

	// De-Initialization
	raylib.CloseWindow() // Close window and OpenGL context
}
