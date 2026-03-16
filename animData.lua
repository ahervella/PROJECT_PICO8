sfT_PLAYER_FRAMES = {
    SpriteFrame:__new( Vector2:__new( 0, 0 ), 1 ),
    SpriteFrame:__new( Vector2:__new( 14, 0 ), 1 )
}

--Todo make default val compensation for offset, flip, playing etc.
sl_PLAYER_LOOP = SpriteLoop:__new(
    sfT_PLAYER_FRAMES,
    Vector2:__new( 14, 9 ),
    Vector2:__v2_zero(),
    false
)

sa_PLAYER_ANIM = SpriteAnim:__new(
    {sl_PLAYER_LOOP},
    true,
    false
)

------------------------

function __sfT_BULLET_FRAMES()
    return {
        SpriteFrame:__new( Vector2:__new( 32, 4), 1)
    }
end

function __sl_BULLET_LOOP()
    return SpriteLoop:__new(
        __sfT_BULLET_FRAMES(),
        Vector2:__new(8, 1),
        Vector2:__new(0, 4),
        false
    )
end

function __sa_BULLET_ANIM()
    return SpriteAnim:__new(
        {__sl_BULLET_LOOP()},
        true,
        false
    )
end

------------------------

function __sfT_ENEMY_FRAMES()
    return {
        SpriteFrame:__new( Vector2:__new(40, 0), 1)
    }
end

function __sl_ENEMY_LOOP()
    return SpriteLoop:__new(
        __sfT_ENEMY_FRAMES(),
        Vector2:__new(14, 12),
        Vector2:__v2_zero(),
        false
    )
end

function __sa_ENEMY_ANIM()
    return SpriteAnim:__new(
        {__sl_ENEMY_LOOP()},
        true,
        false
    )
end