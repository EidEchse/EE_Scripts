params ["_logic"];
_module = _logic getVariable "Module";
_debug = _logic getVariable "Debug";

_boxClassDefault = _logic getVariable "BoxClassDefault";
_boxClass = _logic getVariable ["BoxClass", ""];
_box = _logic getVariable "Box";

if (_boxClass == "") then
{
  _boxClass = _boxClassDefault;
  _logic setVariable ["BoxClass", _boxClass];
};

if (isNil {_box}) then
{
    _box = _boxClass createVehicle position _logic;
    _logic setVariable ["Box", _box];
};

[_box, false] remoteExec ["allowDamage", _box];
_box setDir getDir _logic;
_box setPos getPos _logic;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;
["DEBUG", _module, format["Box %1 spawned", _box], _debug] spawn EE_Scripts_fnc_debug;

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init];
if (_init != "") then
{
  [_logic, _box, _boxClass] execVM _init;
};

["DEBUG", _module, format["Box %1 init %2 called",_box, _init], _debug] spawn EE_Scripts_fnc_debug;
_box
