ZBullet = ZMoveable:__new{
    s_zType = "ZBullet",
    i_layer = iT_LAYERS.BULLET,
    n_MAX_SPEED = 500
}

function ZBullet:__newObj( _v2_refSpawnPos, _b_faceRight )
    printh("Spawning bullet)")
    local _instance = ZBullet:__new()
    local _v2_spawnPos = Vector2:__copy(_v2_refSpawnPos)

    if _b_faceRight then
        _instance.v2_currSpeed = Vector2:__new(self.n_MAX_SPEED, 0) 
    else
        
        _v2_spawnPos.x -= __sl_BULLET_LOOP().v2_size.x
        
        _instance.v2_currSpeed = Vector2:__new( -self.n_MAX_SPEED, 0)
    end

    printh( "Spawn pos of bullet: x=" .. _v2_spawnPos.x .. ", y=" .. _v2_spawnPos.y)
    _instance:__initFromAnim(
        _v2_spawnPos, __sa_BULLET_ANIM()
    )
    
    _instance:__setFlip( not _b_faceRight )

    ObjManager:__addObj( _instance )
end

function ZBullet:__update()
    ZMoveable.__update(self)

    if (self.v2_pos.x > i_SCREEN_MAX_PX + self:__v2_getSize().x or self.v2_pos.x <  -self:__v2_getSize().x) then
        self.b_destroy = true
    end
end

function ZBullet:__initCollCorners()
    ZObject.__initCollCorners(self)
    self.v2_currTLColl = Vector2:__add(self.v2_currTLColl, self:__v2_getFinalDrawOffset())
    self.v2_currTLColl = Vector2:__sub(self.v2_currTLColl, Vector2:__new(1, 1))
    self.v2_currBRColl = Vector2:__add(self.v2_currBRColl, self:__v2_getFinalDrawOffset())
    self.v2_currTLColl = Vector2:__add(self.v2_currBRColl, Vector2:__new(1, 1))
end

function ZBullet : __collided( _zo_other )
    if _zo_other.i_layer == iT_LAYERS.ENEMY or _zo_other.i_layer == iT_LAYERS.WALL then
        self.b_destroy = true
    end
end

function ZBullet : __applyPosDelta( _v2_posDelta )
    if self:__b_getFlip() then
        _v2_posDelta.x = -1 * _v2_posDelta.x
    end

    ZMoveable.__applyPosDelta( self, _v2_posDelta )
end