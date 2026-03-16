SpriteFrame = {
    v2_sheetPos = Vector2 : __new( 0, 0 ),
    n_duration = 1/30
}

function SpriteFrame : __new(
    _v2_sheetPos,
    _n_duration
)
    local _instance = {
        v2_sheetPos = Vector2:__copy(_v2_sheetPos),
        n_duration = _n_duration
    }
    self.__index = self
    setmetatable( _instance, self )
    return _instance
end