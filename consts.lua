--camera needs to be first so that when we draw, we set the screenoffset before anything draws
iT_LAYERS = {
    CAMERA = 1,
    NONE = 2,
    ENEMY = 3,
    BULLET = 4,
    WALL = 5,
    PLAYER = 6,
}
i_LAYERS_COUNT = 6

i_SCREEN_MAX_PX = 128
i_SCREEN_HALF_MAX_PX = 64
v2_SCREEN_MAX_SIZE = Vector2:__new(i_SCREEN_MAX_PX, i_SCREEN_MAX_PX)
v2_SCREEN_CENTER = Vector2:__new(i_SCREEN_MAX_PX / 2, i_SCREEN_MAX_PX / 2)

--Motion Blur Variables--

iT_MB_OG_COLORS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
iT_MB_REP_COLORS = {0, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1 }


i_MB_OPAQUE_ITERATIONS = 0
i_MB_SHADOW_ITERATIONS = 2
n_MB_STEP_DELAY = 0.005
-------------------------