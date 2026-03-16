ZPlayer = ZCharacter:__new{
    s_zType = "ZPlayer",
    i_layer = iT_LAYERS.PLAYER,
    n_MAX_SPEED = 80,
    n2_ACCEL = Vector2:__new(160, 120),
    n2_REV_ACCEL = Vector2:__new(160, 120),
    n2_DECEL = Vector2:__new(120, 100),

    v2_COLL_SIZE = Vector2:__new(),
    b_drawMotionBlur = true,
}

function ZPlayer : __newObj( _v2_refSpawnPos, _b_faceRight )
    local zo_player = ZPlayer:__new() 
    
    zo_player:__initFromAnim(
        Vector2:__copy(_v2_refSpawnPos),
        sa_PLAYER_ANIM
    )

    zo_player:__setFlip( not _b_faceRight )
    ObjManager:__addObj( zo_player )
end

function ZPlayer : __update()
    self:__updateInput()
    --Why doesn't this work?:
    --getmetatable(self).__update(self)
    --ZCharacter.__update(self)
end

function ZPlayer : __updateInput()
    if btnp(5) then
        self:__setFlip(true)
        local _v2_spawnPos = Vector2:__copy(self.v2_pos)
        _v2_spawnPos.x += self:__v2_getSize().x
        ZBullet:__newObj(_v2_spawnPos, true)
    end

    if btnp(4) then
        self:__setFlip(false)
        ZBullet:__newObj(self.v2_pos, false)
    end

    self.v2_frameAccelDir = Vector2:__v2_zero()

    if (btn(0)) then
        self.v2_frameAccelDir.x = -1
    end

    if(btn(1)) then
        self.v2_frameAccelDir.x = 1
    end

    if (btn(2)) then
        self.v2_frameAccelDir.y = -1
    end

    if (btn(3)) then
        self.v2_frameAccelDir.y = 1
    end
end

