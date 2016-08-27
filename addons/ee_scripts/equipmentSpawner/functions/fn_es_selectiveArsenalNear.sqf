params ["_box"];
_return = false;
/*systemChat "check!!";*/
_objects = _box nearObjects ["B_CargoNet_01_ammo_F", 5];
if (!isNil {_objects}) then
{
  {
    if (_x getVariable ["EE_Scripts_is_selectiveArsenal", false]) then
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

_return
