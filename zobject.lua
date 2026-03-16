n_zo_id_counter = 0

ZObject = {
    s_zType = "ZObject",
    n_id = 0,
    i_layer = iT_LAYERS.NONE,
    b_destroy = false,
    v2_pos = Vector2:__v2_zero(),
    sa_spriteAnim = nil,
    
    v2_currSpeed = Vector2:__v2_zero(),

    v2_currTLColl = Vector2:__v2_zero(),
    v2_currBRColl = Vector2:__v2_zero(),

    n_MAX_SPEED = nil
 }

-- We should think of this ZObject not as a data type here,
-- But rather like the OG blueprint that we make copies from
-- Which Lua calls a "prototype"

function ZObject : __new( _instance )
    -- If passedInst is null, make it an empty table
    --printh( "hello" .. #_instance)--.v2_currSpeed.x )
    _instance = _instance or {}

    -- The self parameter (the class original) will set it's index to itself so
    -- that all of the defined functions here can be part
    -- of the metatable without having to manually define each one
    -- into the meta table. This will not be recursion because the
    -- __index table is not recursive unless it has another __index
    -- (and yes, the __index variable is a specific lua keyword field)

    -- Set this prototype's (class's) __index to itself
    self.__index = self

    -- setting the metatable will now make _balance
    -- be an entry in the _instance table

    -- Q) When we set the metatable, how does it now that
    -- different instances can have their own field states?
    -- A)it's not, they are all references to the OG. Only
    -- until you do _instance.id, it makes the instances own
    -- id... it's more of a default value unless you edit the
    -- original prototypes value (like blueprints or prefabs)

    -- this means you could redefine the methods you create
    -- for ZObject at run time... which is sick for effects!
    setmetatable( _instance, self )

    -- this will make the next instance of a ZObject
    -- have a unique id, which is now different
    -- from _instance.id
    if b_mainInitialized then
        _instance.n_id = n_zo_id_counter
        n_zo_id_counter += 1
        printh( "Creating " .. _instance.s_zType .. " instance with Id" .. _instance.n_id)
        _instance:__postNew()
    else
        printh("Creating " .. _instance.s_zType .. " Prototype")
    end

    return _instance
end

function ZObject : __postNew()
end


function ZObject : __newObj( _v2_refSpawnPos, _b_faceRight )
end

function ZObject : __initFromAnim(
    _v2_pos,
    _sa_spriteAnim
)
    self.v2_pos = Vector2:__copy(_v2_pos)
    self.sa_spriteAnim = _sa_spriteAnim
    self:__initCollCorners()
end

function ZObject : __update()
end

function ZObject : __draw()
    self.sa_spriteAnim:__drawSpriteAnim(self.v2_pos)
    self:__debugDrawColl()
end

function ZObject : __setFlip( _b_flip )
    self.sa_spriteAnim:__setFlip( _b_flip )
end

function ZObject : __b_getFlip()
    return self.sa_spriteAnim.b_flip
end

function ZObject : __v2_getSize()
    return Vector2:__copy(self.sa_spriteAnim.slT_loops[1].v2_size)
end

function ZObject : __v2_getFinalDrawOffset()
    return Vector2:__copy(self.sa_spriteAnim.slT_loops[1].v2_finalDrawOffset)
end

function ZObject : __initCollCorners()
    self.v2_currTLColl = Vector2:__copy(self.v2_pos)
    self.v2_currBRColl = Vector2:__add(self.v2_pos, self:__v2_getSize())
end

function ZObject : __collided( _zo_other )
end

function ZObject : __debugDrawColl()
    circ( self.v2_pos.x, self.v2_pos.y, 2, 1)

    --the rect method draws the bottom right corner relative to
    --bottom right of the pixel coord (which is at the top left)
    -- such that rect(1, 1, 2, 2, 3) draws a 2x2 box
    --our BR coll is relative to size such that if our
    -- TL is (1,1) and our BR is (2,2), the our width is 1x1

    -- so to draw the outside border of the top left, we sub 1x1 from it

    rect( self.v2_currTLColl.x-1,
    self.v2_currTLColl.y-1,
    self.v2_currBRColl.x,
    self.v2_currBRColl.y,
    3 )
end