LayerPair =
{
    i_layerA = -1,
    i_layerB = -1,
    cpT_collPairs = {}
}

function LayerPair : __new( _i_layerA, _i_layerB )
    local _instance = {
        i_layerA = _i_layerA,
        i_layerB = _i_layerB,
        cpT_collPairs = {},
     }

    self.__index = self
    setmetatable( _instance, self )
    return _instance
end

function LayerPair : __update()
    for _cp in all(self.cpT_collPairs) do
        if _cp.b_destroy then
            del(self.cpT_collPairs, _cp)
        else
            _cp:__update()
        end
    end
end

function LayerPair : __lw_getLayerAObjs()
    return ObjManager.lwT_layerWrappers[self.i_layerA].zoT_layerObjs
end

function LayerPair : __lw_getLayerBObjs()
    return ObjManager.lwT_layerWrappers[self.i_layerB].zoT_layerObjs
end

function LayerPair : __addObjToLayerPair( _zo_obj )
    local _zoT_otherLayerList
    if _zo_obj.i_layer == self.i_layerA  then
        _zoT_otherLayerList = self:__lw_getLayerBObjs()
    else
        _zoT_otherLayerList = self:__lw_getLayerAObjs()
    end

    for _zo_other in all(_zoT_otherLayerList) do
        local _cp = CollisionPair:__new( _zo_obj, _zo_other )
        add(self.cpT_collPairs, _cp)
    end
end