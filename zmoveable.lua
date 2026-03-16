ZMoveable = ZObject:__new{
    s_zType = "ZMoveable",
    n_MAX_SPEED = nil,
    n2_ACCEL = nil,
    n2_REV_ACCEL = nil,
    n2_DECEL = nil,

    n_ACCEL_TIME = nil,
    n_REV_ACCEL_TIME = nil,
    n_DECEL_TIME = nil,

    n_CALC_MAX_ACCEL = nil,
    n_CALC_MAX_REV_ACCEL = nil,
    n_CALC_MAX_DECEL = nil,

    v2_currAccel = nil,
    v2_currDecel = nil,

    v2_cachedTargetRefDist = Vector2:__v2_zero(),
    v2_frameAccelDir = Vector2:__v2_zero(),
    v2_frameAccel = Vector2:__v2_zero(),
    v2_frameAccelDelta = Vector2:__v2_zero(),

    b_thisFrameIsRevAccel = false,
    b_firstDrawFrameFinished = false,
    
    v2_brakeDir = Vector2:__v2_zero(),

    ---MotionBlur---
    b_drawMotionBlur = false,
    n_stepDelayCounter = 0,
    v2T_cachedFramePos = {},
    i_cachedFrameIndex = 0,
}

function ZMoveable : __postNew()
    self.n_stepDelayCounter = 0
    self.i_cachedFrameIndex = 0
    self.v2T_cachedFramePos = {}

    if self.n2_REV_ACCEL == nil then
        if self.n2_ACCEL != nil then
            self.n2_REV_ACCEL = Vector2:__new( self.n2_ACCEL.x * 2, self.n2_ACCEL.y * 2 )
        end
    end


    if not self.n_ACCEL_TIME == nil then
        self.n_CALC_MAX_ACCEL = self.n_MAX_SPEED / self.n_ACCEL_TIME
    end

    if not self.n_REV_ACCEL_TIME == nil then
        self.n_CALC_MAX_REV_ACCEL = self.n_MAX_SPEED / self.n_REV_ACCEL_TIME
    end

    if not self.n_DECEL_TIME == nil then
        self.n_CALC_MAX_DECEL = self.n_MAX_SPEED / self.n_DECEL_TIME
    end
end


function ZMoveable : __v2_getPosRef()
    return self.v2_pos
end

function ZMoveable : __v2_getTargetRef()
    return nil
end

function ZMoveable : __setPosRef( _v2_val )
    self.v2_pos = _v2_val
end


function ZMoveable : __update()
    ZObject.__update(self)
    self:__computeAccel()
    self:__updatePos()
end

function ZMoveable : __updatePos()
    if not self.b_firstDrawFrameFinished then
        return
    end
    self.__updatePos = ZMoveable.__updatePosPostFirstFrame
    self:__updatePosPostFirstFrame()
    --printh("only changing this once")
end

function ZMoveable : __updatePosPostFirstFrame()
    self:__applySpeedToPos()
end

function ZMoveable : __draw()
    self.b_firstDrawFrameFinished = true
    self:__drawMotionBlur()
    self:__drawMoveable()
end

function ZMoveable : __drawMoveable()
    self.b_firstDrawFrameFinished = true
    self.__drawMoveable = ZObject.__draw
    ZObject.__draw(self)
end

--[[
function ZMoveable : __computeVelV2()
    self.v2_frameAccelDir = self.v2_frameAccelDir:__v2_normalize()

    for k in all({"x", "y"}) do
        if self.v2_frameAccelDir[k] == 0 then
            if self.v2_currSpeed[k] == 0 then
                goto continue
            end

            if self.v2_currSpeed[k] > 0 then
                self.v2_currSpeed[k] -= self.n_CALC_DECEL * n_deltaTimeUpdate * self.v2_frameAccelDir[k]
                if self.v2_currSpeed[k] < 0 then 
                    self.v2_currSpeed[k] = 0
                end
            else
                self.v2_currSpeed[k] += self.n_CALC_DECEL * n_deltaTimeUpdate * self.v2_frameAccelDir[k]
                if self.v2_currSpeed[k] > 0 then 
                    self.v2_currSpeed[k] = 0
                end
            end
        end
        
        ::continue::
        
        self.v2_CALC_ACCEL[k] = self.v2_currSpeed[k] / self.n_ACCEL_TIME
        self.v2_CALC_DECEL[k] = self.v2_currSpeed[k] / self.n_DECEL_TIME
    end

    
end


function ZMoveable : __computeAccelOLD()
    if self.n2_ACCEL == nil then
        return
    end

    if self:__v2_getPosRef() == nil then
        return
    end

    if self:__v2_getTargetRef() != nil then
        self.v2_frameAccelDir = Vector2:__sub( self:__v2_getTargetRef(), self:__v2_getPosRef() )
    end

    self.v2_frameAccelDir = self.v2_frameAccelDir:__v2_normalize()

    self.v2_frameAccel = Vector2:__new(
        self.v2_frameAccelDir.x * self.n2_ACCEL.x,
        self.v2_frameAccelDir.y * self.n2_ACCEL.y )

    for k in all({"x", "y"}) do

        if self.v2_frameAccel[k] == 0 and self.v2_currSpeed[k] != 0 then
        
            if self.v2_currSpeed[k] > 0 then
                    
                self.v2_currSpeed[k] -= self.n2_DECEL[k] * n_deltaTimeUpdate
                if self.v2_currSpeed[k] < 0 then
                    self.v2_currSpeed[k] = 0
                end
            else
                self.v2_currSpeed[k] += self.n2_DECEL[k] * n_deltaTimeUpdate
                if self.v2_currSpeed[k] > 0 then
                    self.v2_currSpeed[k] = 0
                end
            end

        else
            self.v2_currSpeed[k] += self.v2_frameAccel[k] * n_deltaTimeUpdate

        end
    end
end
]]

function ZMoveable : __computeAccel()
    if self.n2_ACCEL == nil then
        return
    end

    if self:__v2_getPosRef() == nil then
        return
    end

    if self:__v2_getTargetRef() != nil then
        self.v2_cachedTargetRefDist = Vector2:__sub( self:__v2_getTargetRef(), self:__v2_getPosRef() )
        self.v2_frameAccelDir = self.v2_cachedTargetRefDist:__v2_normalize()
    else
        self.v2_frameAccelDir = self.v2_frameAccelDir:__v2_normalize()
    end


    if self.s_zType == "ZCamera" then
        self.v2_cachedTargetRefDist:__print("camera cached target ref dist")
        self.v2_frameAccelDir:__print("camera framce accel dir")
        self.v2_currSpeed:__print("camera curr speed")
        self.v2_frameAccelDelta:__print("camera frame accel delta")
        self.v2_frameAccel:__print("camera frame accel dir")
    end

    for k in all({"x", "y"}) do

        if self.v2_frameAccelDir[k] == 0 then
        
            if self.v2_currSpeed[k] == 0 then
                goto cont
            end


            self.v2_frameAccelDelta[k] = self.n2_DECEL[k] * n_deltaTimeUpdate

            if self.v2_currSpeed[k] > 0 then
                self.v2_currSpeed[k] -= self.v2_frameAccelDelta[k]
                if self.v2_currSpeed[k] < 0 then
                    self.v2_currSpeed[k] = 0
                end
            else
                self.v2_currSpeed[k] += self.v2_frameAccelDelta[k]
                if self.v2_currSpeed[k] > 0 then
                    self.v2_currSpeed[k] = 0
                end
            end
            goto cont
        end

        self.b_thisFrameIsRevAccel = (self.v2_currSpeed[k] > 0 and self.v2_frameAccelDir[k] < 0 ) or ( self.v2_currSpeed[k] < 0 and self.v2_frameAccelDir[k] > 0)
        
        if (self.b_thisFrameIsRevAccel) then

            self.v2_frameAccel[k] = self.v2_frameAccelDir[k] * self.n2_REV_ACCEL[k]
        else
            self.v2_frameAccel[k] = self.v2_frameAccelDir[k] * self.n2_ACCEL[k]
        end

        self.v2_frameAccelDelta[k] = self.v2_frameAccel[k] * n_deltaTimeUpdate
        self.v2_currSpeed[k] += self.v2_frameAccelDelta[k]

        ::cont::
    end
    --self.v2_currSpeed:__print("Compute Accel end of frame speed")
end

function ZMoveable : __applySpeedToPos()
    if self.v2_brakeDir.x > 0 and self.v2_currSpeed.x > 0 then
        self.v2_currSpeed.x = 0
    end

    if self.v2_brakeDir.x < 0 and self.v2_currSpeed.x < 0 then
        self.v2_currSpeed.x = 0
    end

    if self.v2_brakeDir.y > 0 and self.v2_currSpeed.y > 0 then
        self.v2_currSpeed.y = 0
    end

    if self.v2_brakeDir.y < 0 and self.v2_currSpeed.y < 0 then
        self.v2_currSpeed.y = 0
    end

    if self.n_MAX_SPEED != nil then
        self.v2_currSpeed = self.v2_currSpeed:__v2_clampVecLength( self.n_MAX_SPEED )
    end


    --self.v2_currSpeed:__print("Apply Speed to Pos end of frame speed")

    local _deltaX = self.v2_currSpeed.x * n_deltaTimeUpdate
    local _deltaY = self.v2_currSpeed.y * n_deltaTimeUpdate
    local _v2_delta = Vector2:__new( _deltaX, _deltaY)


    self:__applyPosDelta( _v2_delta )

    if self.s_zType == "ZCamera" then
      _v2_delta:__print( "camera pos delta" )
    end


    self.v2_brakeDir = Vector2:__v2_zero()
end

--[[
function ZMoveable : __applyPosDeltaOLD( _v2_posDelta )

    if self:__b_getFlip() then
        self.v2_pos.x -= _v2_posDelta.x
        self.v2_currTLColl.x -= _v2_posDelta.x
        self.v2_currBRColl.x -= _v2_posDelta.x
    else
        self.v2_pos.x += _v2_posDelta.x
        self.v2_currTLColl.x += _v2_posDelta.x
        self.v2_currBRColl.x += _v2_posDelta.x
    end
    
    self.v2_pos.y += _v2_posDelta.y

    self.v2_currTLColl.y += _v2_posDelta.y
    self.v2_currBRColl.y += _v2_posDelta.y
end
]]

function ZMoveable : __applyPosDelta( _v2_posDelta )
    local _v2_finalPos = Vector2:__add( _v2_posDelta, self:__v2_getPosRef() )

    if ( (self:__v2_getTargetRef() != nil) and (not self.b_thisFrameIsRevAccel)) then
        for k in all({"x", "y"}) do
            if (_v2_posDelta[k] > 0 and self.v2_cachedTargetRefDist[k] < _v2_posDelta[k]) or (_v2_posDelta[k] < 0 and self.v2_cachedTargetRefDist[k] > _v2_posDelta[k]) then
                _v2_finalPos[k] = self:__v2_getTargetRef()[k]
            end
        end
    end

    self:__setPosRef( _v2_finalPos )
    self:__updateColliderPos()
end

function ZMoveable : __updateColliderPos()
    --TODO optimize
    ZObject.__initCollCorners(self)
end

function ZMoveable : __moveTo( _v2_newPos )
    self:__applyPosDelta( Vector2:__sub(_v2_newPos, self.v2_pos))
end

function ZMoveable : __stopMoving()
    self.b_stopMoving = true
end

function ZMoveable : __drawMotionBlur()
    if not self.b_drawMotionBlur then
        return
    end

    for i=1, #iT_MB_OG_COLORS do
        pal(iT_MB_OG_COLORS[i], iT_MB_REP_COLORS[i] )
    end

    for i=1, #self.v2T_cachedFramePos do
        if i == i_MB_SHADOW_ITERATIONS + 1 then
            for i=1, #iT_MB_OG_COLORS do
                pal(iT_MB_OG_COLORS[i], iT_MB_OG_COLORS[i] )
            end
        end
        self.sa_spriteAnim:__drawSpriteAnim( self.v2T_cachedFramePos[i] )
        
    end

    if i_MB_OPAQUE_ITERATIONS == 0 then
        for i=1, #iT_MB_OG_COLORS do
            pal(iT_MB_OG_COLORS[i], iT_MB_OG_COLORS[i] )
        end
    end

    
    if( t() - self.n_stepDelayCounter < n_MB_STEP_DELAY ) then
        return
    end

    self.n_stepDelayCounter = t()
    

    if self.i_cachedFrameIndex < ( i_MB_OPAQUE_ITERATIONS + i_MB_SHADOW_ITERATIONS ) then
        self.i_cachedFrameIndex += 1
    else
        deli(self.v2T_cachedFramePos, 1)
    end

    add( self.v2T_cachedFramePos, Vector2:__copy(self.v2_pos) )

end