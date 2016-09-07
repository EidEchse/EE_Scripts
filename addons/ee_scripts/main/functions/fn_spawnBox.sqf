params ["_moduleName","_logic","_className"];
if (isNil {EE_Scripts_main_debug}) then {EE_Scripts_main_debug = "WARNING"};

_boxClass = _logic getVariable ["BoxClass", _className];
if (_boxClass == "") then
{
  _boxClass = _className;
};
_logic setVariable ["BoxClass", _boxClass, true];

_box = _logic getVariable "Box";
if (isNil {_box}) then
{
    _box = _boxClass createVehicle position _logic;
};
_logic setVariable ["Box", _box, true];

[_box, [false]] remoteExec ["allowDamage", 0, _box];
_box setDir getDir _logic;
_box setPos getPos _logic;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;
["DEBUG", "main", format["Box %1 spawned", _box], EE_Scripts_main_debug] spawn EE_Scripts_fnc_debug;

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init, true];
if (_init != "") then
{
  [_logic, _box, _boxClass] execVM _init;
};

["DEBUG", "main", format["Box %1 init %2 called",_box, _init], EE_Scripts_main_debug] spawn EE_Scripts_fnc_debug;
_box
