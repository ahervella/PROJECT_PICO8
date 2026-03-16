SpriteLoop =
{
    sfT_frames = {},
    v2_size = Vector2:__new( 8, 8),
    v2_drawOffset = Vector2:__new( 0, 0),
    v2_finalDrawOffset = Vector2:__new( 0, 0),
    b_flip = false,
    b_finalFlip = false,
    b_loopFlip = false,
    n_currFrameTime = 0,
    n_currFrameIndex = 1,
    sf_currFrame = nil
}

function SpriteLoop : __new(
    _sfT_frames,
    _v2_size,
    _v2_drawOffset,
    _b_flip
)
    local _instance = {
        sfT_frames = _sfT_frames,
        v2_size = Vector2:__copy(_v2_size),
        v2_drawOffset = Vector2:__copy(_v2_drawOffset),
        v2_finalDrawOffset = Vector2:__copy(_v2_drawOffset),
        b_flip = _b_flip,
        b_finalFlip = _b_flip,
        sf_currFrame = _sfT_frames[1]
    }
    self.__index = self
    setmetatable( _instance, self )
    return _instance
end

function SpriteLoop : __setFlip(_b_loopFlip)
    if self.b_loopFlip == _b_loopFlip then
        return
    end

    self.b_loopFlip = _b_loopFlip

    if self.b_loopFlip then
        self.v2_finalDrawOffset.x = -self.v2_drawOffset.x
        self.b_finalFlip = not self.b_flip
    else
        self.v2_finalDrawOffset.x = self.v2_drawOffset.x
        self.b_finalFlip = self.b_flip
    end
end

function SpriteLoop : __updateSpriteLoop( _n_deltaTime )
    self.n_currFrameTime += _n_deltaTime

    if self.sf_currFrame.n_duration > self.n_currFrameTime then
        return
    end

    self.n_currFrameTime = self.n_currFrameTime - self.sf_currFrame.n_duration
    self.n_currFrameIndex += 1

    if self.n_currFrameIndex > #self.sfT_frames then
        self.n_currFrameIndex = 1
    end

    self.sf_currFrame = self.sfT_frames[self.n_currFrameIndex]
end

function SpriteLoop : __drawSpriteLoop(_v2_pos)
    sspr(
        self.sf_currFrame.v2_sheetPos.x,
        self.sf_currFrame.v2_sheetPos.y,
        self.v2_size.x,
        self.v2_size.y,
        self.v2_finalDrawOffset.x + _v2_pos.x,
        self.v2_finalDrawOffset.y + _v2_pos.y,
        self.v2_size.x,
        self.v2_size.y,
        self.b_finalFlip
    )
end

