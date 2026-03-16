ZWall = ZObject:__new{
    s_zType = "ZWall",
    i_layer = iT_LAYERS.WALL,
    v2_wallSize = Vector2:__v2_zero()
}

function ZWall : __newWall(_v2_pos, _v2_wallSize)
    local _zw = ZWall:__new()
    _zw.v2_pos = Vector2:__copy(_v2_pos)
    _zw.v2_wallSize = Vector2:__copy( _v2_wallSize)
    _zw:__initCollCorners()

    ObjManager:__addObj( _zw )
end

function ZWall : __v2_getSize()
    return self.v2_wallSize
end

function ZWall : __draw()
    rectfill( self.v2_currTLColl.x,
    self.v2_currTLColl.y,
    self.v2_currBRColl.x-1,
    self.v2_currBRColl.y-1,
    1 )

    --self:__debugDrawColl()
end