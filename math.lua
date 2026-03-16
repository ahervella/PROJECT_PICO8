function __n2_clampN2VecLength( _n2_vec, _n_maxLen )

    local _n_vecLenSqr = __n_sq( _n2_vec[1] ) + __n_sq( _n2_vec[2] )
    --printh( "_n_vecLenSqr: ".. _n_vecLenSqr )
    --printh( "_n_maxLen: ".. __n_sq( _n_maxLen ) )
    --printh( "")
    if( _n_vecLenSqr < __n_sq( _n_maxLen ) ) then
        return {_n2_vec[1], _n2_vec[2]}
    end

    local _n2_vecNorm = __n2_normalize( _n2_vec )
    __printN2( _n2_vecNorm, "Normalized")
    return { _n2_vecNorm[1] * _n_maxLen, _n2_vecNorm[2] * _n_maxLen }
end

function __n_sq( _n_val )
    return _n_val * _n_val
end

function __n_clampN( _n_val, _n_max, _n_min )
    if( _n_val > _n_max ) then
        return _n_max
    end

    if( _n_val < _n_min ) then
        return _n_min
    end

    return _n_val
end

function __n2_normalize( _n2_vec )
    local _angle = atan2( _n2_vec[1], _n2_vec[2] )
    return { cos(_angle), sin(_angle)}
end