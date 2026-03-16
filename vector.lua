Vector2 = {x = 0, y = 0}

function Vector2 : __new(_x, _y)
    local _instance = {x = _x, y = _y}
    self.__index = self
    setmetatable( _instance, self )
    return _instance
end

function Vector2 : __copy( _v2_og )
    return Vector2 : __new( _v2_og.x, _v2_og.y )
end

function Vector2 : __v2_zero()
    return Vector2 : __new( 0, 0 )
end

function Vector2 : __add( _v2_a, _v2_b )
    return Vector2: __new( _v2_a.x + _v2_b.x, _v2_a.y + _v2_b.y)
end

function Vector2 : __addToSelf( _v2_a )
    self.x += _v2_a.x
    self.y += _v2_a.y
end

function Vector2 : __subFromSelf( _v2_a )
    self.x -= _v2_a.x
    self.y -= _v2_a.y
end

function Vector2 : __sub( _v2_a, _v2_b )
    return Vector2: __new( _v2_a.x - _v2_b.x, _v2_a.y - _v2_b.y)
end

function Vector2 : __v2_normalize()
    if self.x == 0 and self.y == 0 then
        return Vector2:__v2_zero()
    end

    local _angle = atan2( self.x, self.y )
    return Vector2:__new(cos(_angle), sin(_angle))
end

function Vector2 : __v2_clamp( _v2_min, _v2_max )
    local _x = min(self.v2_val.x, _v2_max.y)
    local _y = min(self.v2_val.y, _v2_max.y)

    _x = max( _x, _v2_min.x)
    _y = max( _y, _v2_min.y)
    
    return Vector2:__new(_x, _y)
end

function Vector2 : __n_lengthSqr()
    return __n_sq( self.x ) + __n_sq( self.y )
end

function Vector2 : __v2_clampVecLength( _n_maxLen )

    local _n_vecLenSqr = __n_sq( self.x ) + __n_sq( self.y )

    if _n_vecLenSqr < __n_sq( _n_maxLen ) then
        return Vector2:__new( self.x, self.y )
    end

    local _n2_vecNorm = self:__v2_normalize()
    
    return Vector2:__new(_n2_vecNorm.x * _n_maxLen, _n2_vecNorm.y * _n_maxLen )
end

function Vector2 : __n_distSqr( _v2_other )
    return (Vector2:__sub( self, _v2_other)):__n_lengthSqr()
end

function Vector2 : __print( _s_label )
    printh(_s_label  .. ": x = " .. self.x .. ", y = " .. self.y)
end