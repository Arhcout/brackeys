#include <raylib.h>

#if defined(PLATFORM_WEB)
#include <emscripten/emscripten.h>
#endif

const int screenWidth = 800;
const int screenHeight = 450;

void Update(void){
  BeginDrawing();

    ClearBackground(RAYWHITE);
    DrawText("Hello world!", 190, 200, 20, RED);

  EndDrawing();
}

int main(void){

  InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");

#if defined(PLATFORM_WEB)
  emscripten_set_main_loop(Update, 0, 1);
#else
  SetTargetFPS(60);

  while (!WindowShouldClose())
  {
    Update();
  }
#endif

  CloseWindow();
  return 0;
}
