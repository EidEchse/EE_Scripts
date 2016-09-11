params ["_box"];
_return = false;
/*systemChat "check!!";*/
if (!isNil "EE_Scripts_sa_boxClasses") then {
  {
    _className = _x;
    /*systemChat format ["Check for %1", _className];*/
    _objects = _box nearObjects [_className, 5];
    if (!isNil {_objects}) then
    {
      {
        _object = _x;
        if (_object getVariable ["EE_Scripts_is_selectiveArsenal", false]) then
        {
            /*systemChat "Arsenal found!!";*/
            _return = true;
        }else{
          /*systemChat "not an arsenal";*/
        };
      } forEach _objects;
    }else{
      /*systemChat "no objects found!!";*/
    };
  } forEach EE_Scripts_sa_boxClasses;
};
_return
