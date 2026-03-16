LayerWrapper =
{
    i_layer = -1,
    zoT_layerObjs = {},
    lpT_layerPairs = {}
}

function LayerWrapper : __new( _i_layer )
    local _instance = {
        i_layer = _i_layer,
        zoT_layerObjs = {},
        lpT_layerPairs = {}
     }

    self.__index = self
    setmetatable( _instance, self )

    for _lp in all(ObjManager.lpT_layerPairs) do
        if _lp.i_layerA == _i_layer or _lp.i_layerB == _i_layer then
            add(_instance.lpT_layerPairs, _lp)
        end
    end

    return _instance
end

function LayerWrapper : __update()
    --TODO: Want to experiment if trying to iterate backwards and remove via
    --index is much faster, but apparently this is safe according to PICO-8 manual

    for _zo in all(self.zoT_layerObjs) do
        if _zo.b_destroy then
            del(self.zoT_layerObjs, _zo)
        else
            _zo:__update()
        end
    end
end

function LayerWrapper : __draw()
    for _zo in all(self.zoT_layerObjs) do
        if not _zo.b_destroy then
            _zo:__draw()
        end
    end
end

function LayerWrapper : __addObjToWrapper( _zo_obj )
    add(self.zoT_layerObjs, _zo_obj)
    for _lp_layerPair in all(self.lpT_layerPairs) do
        _lp_layerPair:__addObjToLayerPair( _zo_obj )
    end
end