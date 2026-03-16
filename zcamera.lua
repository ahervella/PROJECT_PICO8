ZCamera = ZMoveable : __new{
    s_zType = "ZCamera",
    i_layer = iT_LAYERS.CAMERA,
    v2_currTLColl = Vector2:__v2_zero(),
    v2_currBRColl = Vector2:__v2_zero(),

    n_FACING_PLAYER_OFFSET = 10,
    v2_targetOffset = Vector2:__v2_zero(),
    v2_currOffset = Vector2:__v2_zero(),

    v2_moveThresholdSize = Vector2:__new(30, 30),
    n_recenterTime = 1,

    n_MAX_SPEED = ZPlayer.n_MAX_SPEED,
    n2_ACCEL = Vector2:__new(100, 100),
    n2_REV_ACCEL = Vector2:__new(400, 400),
    n2_DECEL = Vector2:__new(100, 100),
    b_skipedFirstFrame = false,
    b_firstDrawFrameFinished = true
}

function ZCamera : __newCam()
    local zo_cam = ZCamera:__new()
    local _v2_playerPos = ObjManager:__v2_getPlayerPos()
    zo_cam.v2_pos = Vector2:__sub(_v2_playerPos, v2_SCREEN_CENTER )
    camera(zo_cam.v2_pos.x, zo_cam.v2_pos.y)

    zo_cam.v2_currTLColl.x = _v2_playerPos.x - (zo_cam.v2_moveThresholdSize.x / 2)
    zo_cam.v2_currTLColl.y = _v2_playerPos.y - (zo_cam.v2_moveThresholdSize.y / 2)

    zo_cam.v2_currBRColl.x = _v2_playerPos.x + (zo_cam.v2_moveThresholdSize.x / 2)
    zo_cam.v2_currBRColl.y = _v2_playerPos.y + (zo_cam.v2_moveThresholdSize.y / 2)

    zo_cam.b_firstDrawFrameFinished = true

    ObjManager:__addObj( zo_cam )
end


function ZCamera : __v2_getPosRef()
    return self.v2_currOffset
end

function ZCamera : __v2_getTargetRef()
    return self.v2_targetOffset
end

function ZCamera : __setPosRef( _v2_val )
    self.v2_currOffset = _v2_val
end


function ZCamera : __update()
    
    if not self.b_skipedFirstFrame then
        self.b_skipedFirstFrame = true
        return     
    end

    local _player = ObjManager:__zPlayer_getPlayer()
    _player.v2_frameAccelDir:__print("player frame accel in cam")

    if _player.v2_frameAccelDir.x > 0 then
        self.v2_targetOffset.x = self.n_FACING_PLAYER_OFFSET
    elseif _player.v2_frameAccelDir.x < 0 then
        self.v2_targetOffset.x = -1 * self.n_FACING_PLAYER_OFFSET
    else
        self.v2_targetOffset.x = 0
    end
    
    self.v2_targetOffset:__print("target offset cam")

    ZMoveable.__update(self)
end

function ZCamera : __updateColliderPos()
end

function ZCamera : __draw()
    self.v2_pos = Vector2:__add( ObjManager:__v2_getPlayerPos(), self.v2_currOffset )
    camera(self.v2_pos.x - i_SCREEN_HALF_MAX_PX, self.v2_pos.y - i_SCREEN_HALF_MAX_PX)
end

function ZCamera : __b_getFlip() return false end

