params ["_moduleName","_logic","_className"];

private ["_box"];
_box = _logic getVariable "Box";
if (isNil {_box}) then
{
    _box = _className createVehicle position _logic;
};
_logic setVariable ["Box", _box, true];

_box allowDamage false;
_box setDir getDir _logic;
_box setPos getPos _logic;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearBackpackCargoGlobal _box;
[0, "main", format["Box %1 spawned", _box]] call EE_Scripts_fnc_debug;

_init = _logic getVariable ["Init", ""];
_logic setVariable ["Init", _init, true];
if (_init != "") then
{
  [_logic, _box, _className] execVM _init;
};

[0, "main", format["Box %1 init %2 called",_box, _init]] call EE_Scripts_fnc_debug;
_box
