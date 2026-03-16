ObjManager = 
{
    lwT_layerWrappers = {},
    lpT_layerPairs = 
    {
        LayerPair:__new(iT_LAYERS.PLAYER, iT_LAYERS.ENEMY),
        LayerPair:__new(iT_LAYERS.BULLET, iT_LAYERS.ENEMY),
        LayerPair:__new(iT_LAYERS.PLAYER, iT_LAYERS.WALL),
        LayerPair:__new(iT_LAYERS.ENEMY, iT_LAYERS.WALL),
        LayerPair:__new(iT_LAYERS.BULLET, iT_LAYERS.WALL),
    }
}

function ObjManager : __init()
    for _i_layer = 1, i_LAYERS_COUNT do
        add( self.lwT_layerWrappers, LayerWrapper:__new(_i_layer), _i_layer)
    end
end

function ObjManager : __update()
    for _lw in all(self.lwT_layerWrappers) do
        _lw:__update()
    end

    for _lp in all(self.lpT_layerPairs) do
        _lp:__update()
    end
end

function ObjManager : __draw()
    for _lw in all(self.lwT_layerWrappers) do
        _lw:__draw()
    end
end

function ObjManager : __addObj( _zo_obj )
    self.lwT_layerWrappers[_zo_obj.i_layer]:__addObjToWrapper( _zo_obj )
end

function ObjManager : __zPlayer_getPlayer()
    return self.lwT_layerWrappers[iT_LAYERS.PLAYER].zoT_layerObjs[1]
end

function ObjManager : __v2_getPlayerPos()
    return self.lwT_layerWrappers[iT_LAYERS.PLAYER].zoT_layerObjs[1].v2_pos
end







