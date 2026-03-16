ZCharacter = ZMoveable:__new{
    s_zType = "ZCharacter",
    i_layer = iT_LAYERS.PLAYER,
}


function ZCharacter:__initMoveable()
    printh("init char moveable")
    self.v2_currPosRef = self.v2_pos
    self.v2_currPosRef:__print("v2_currPosRef")
    self.v2_pos:__print("v2_pos")
    self.v2_targetPosRef = nil
end

function ZCharacter : __collided( _zo_other )
    if _zo_other.i_layer != iT_LAYERS.WALL then
        return 0
    end

    local _n_leftDPDist = abs(self.v2_currTLColl.x - _zo_other.v2_currBRColl.x )
    local _n_rightDPDist = abs(self.v2_currBRColl.x - _zo_other.v2_currTLColl.x )
    local _n_topDPDist = abs(self.v2_currTLColl.y - _zo_other.v2_currBRColl.y )
    local _n_botDPDist = abs(self.v2_currBRColl.y - _zo_other.v2_currTLColl.y )
    local min = min(min(_n_leftDPDist, _n_rightDPDist), min(_n_topDPDist, _n_botDPDist) )

    if _n_leftDPDist == min then
        self.v2_brakeDir.x = -1
        self:__applyPosDelta( Vector2:__new( _zo_other.v2_currBRColl.x - self.v2_currTLColl.x, 0 ) )
    elseif _n_rightDPDist == min then
        self.v2_brakeDir.x = 1
        self:__applyPosDelta( Vector2:__new( _zo_other.v2_currTLColl.x - self.v2_currBRColl.x, 0 ) )
    elseif _n_topDPDist == min then
        self.v2_brakeDir.y = -1
        self:__applyPosDelta( Vector2:__new( 0, _zo_other.v2_currBRColl.y - self.v2_currTLColl.y ) )
    else
        self.v2_brakeDir.y = 1
        self:__applyPosDelta( Vector2:__new( 0, _zo_other.v2_currTLColl.y - self.v2_currBRColl.y ) )
    end 
end