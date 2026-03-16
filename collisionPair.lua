CollisionPair =
{
    zo_objA = nil,
    zo_objB = nil,
    b_destroy = false
}

function CollisionPair : __new( _zo_objA, _zo_objB )
    local _instance = {
        zo_objA = _zo_objA,
        zo_objB = _zo_objB
     }

    self.__index = self
    setmetatable( _instance, self )
    return _instance
end

function CollisionPair : __update()
    if not self:__b_isColliding() then
        return
    end

    if (self.zo_objA.b_destroy or self.zo_objB.b_destroy) then
        self.b_destroy = true
        return
    end

    self.zo_objA:__collided(self.zo_objB)
    self.zo_objB:__collided(self.zo_objA)
end

function CollisionPair : __b_isColliding()
    if (self.zo_objA.v2_currTLColl.x <= self.zo_objB.v2_currBRColl.x
    and self.zo_objA.v2_currTLColl.y <= self.zo_objB.v2_currBRColl.y
    and self.zo_objA.v2_currBRColl.x >= self.zo_objB.v2_currTLColl.x
    and self.zo_objA.v2_currBRColl.y >= self.zo_objB.v2_currTLColl.y) then
        return true
    end

    return false
end