SpriteAnim = {
    slT_loops = {},
    b_flip = false,
    b_playing = false,
}

function SpriteAnim : __new( 
    _slT_loops,
    _b_playing,
    _b_flip
)
    local _instance = {
        slT_loops = _slT_loops,
        b_playing = _b_playing
    }
    self.__index = self
    setmetatable( _instance, self )
    if _b_flip then
        _instance:__flip()
    end
    return _instance
end

function SpriteAnim : __setFlip(_b_flip)
    for _, _spriteLoop in pairs(self.slT_loops) do
        _spriteLoop:__setFlip(_b_flip)
    end
end

function SpriteAnim : __updateSpriteAnim( _n_deltaTime )
    if not self.b_playing then
        return
    end

    for _, __spriteLoop in pairs(self.slT_loops) do
        _spriteLoop:__updateSpriteLoop( _n_deltaTime )
    end
end

function SpriteAnim : __drawSpriteAnim( _v2_pos )
    for _ , _spriteLoop in pairs(self.slT_loops) do
        _spriteLoop:__drawSpriteLoop( _v2_pos )
    end
end