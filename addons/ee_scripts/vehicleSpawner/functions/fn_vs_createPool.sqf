params ["_min", "_max","_type","_cfg"];

_pool = [];
for [{_i = _min}, {_i <= _max}, {_i=_i+1}] do
{
    _level_array = _cfg select _i;
    {
      if (count _x > 0) then {
        _pool pushBack _x;
      };
    } forEach _level_array;
};
_pool
