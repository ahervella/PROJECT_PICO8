ZEnemy = ZCharacter:__new{
    s_zType = "ZEnemy",
    i_layer = iT_LAYERS.ENEMY,
    n_MAX_SPEED = 60,
    n2_ACCEL = Vector2:__new(60, 30),
    n2_REV_ACCEL = Vector2:__new(180, 90),
    n2_DECEL = Vector2:__new(20, 10),
    n_ALERT_RADIUS = 120,
    b_drawMotionBlur = true,
    v2_targetPlayerPos = nil
}

function ZEnemy : __postNew()
    self.n_stepDelayCounter = 0
    self.i_cachedFrameIndex = 0
    self.v2T_cachedFramePos = {}

    ZCharacter.__postNew(self)
end

function ZEnemy : __v2_getTargetRef()
    return self.v2_targetPlayerPos
end

function ZEnemy:__newObj( _v2_refSpawnPos, _b_faceRight )
    local _instance = ZEnemy:__new()
    local _v2_spawnPos = Vector2:__copy(_v2_refSpawnPos)

    _instance:__initFromAnim(
        _v2_spawnPos, __sa_ENEMY_ANIM()
    )
    _instance:__setFlip( _b_faceRight )

    ObjManager:__addObj(_instance )
   -- add( zoT_objs, _instance )
end

function ZEnemy : __collided( _zo_other )
    if _zo_other.i_layer == iT_LAYERS.BULLET then
        self.b_destroy = true
    end

    ZCharacter.__collided( self, _zo_other )
end

function ZEnemy : __update()
    --TODO: optimize by caching flip to check if we are already facing that direction
    --TODO: make sure to compensate sprite flip with "facing right"
    local _v2_playerPos = ObjManager:__v2_getPlayerPos()
    local _v2_vec2Player = Vector2:__sub( _v2_playerPos, self.v2_pos )

    if _v2_vec2Player:__n_lengthSqr() > __n_sq(self.n_ALERT_RADIUS) then
        self.v2_frameAccelDir = Vector2:__v2_zero()
    else
        self:__setFlip( _v2_playerPos.x < self.v2_pos.x )
        self.v2_frameAccelDir = _v2_vec2Player
    end

    ZCharacter.__update(self)
end