params ["_logic","_box","_unit"];
_respawn = _logic getVariable "Respawn";
waitUntil ({!alive _unit;});

_deleteUnits = _logic getVariable ["DeleteUnits", false];
if (!_deleteUnits) then {
  _curUnits = _logic getVariable "CurUnits";
  _logic setVariable ["CurUnits", _curUnits - [_unit], true];
  _i = floor _respawn;
  while{_i > 0} do
  {
    if ((_i mod 300) == 0) then{
      systemChat format["Next unit respawn available in %2 minutes.",_i / 60];
    };
    _i = _i - 1;
    sleep 1;
  };
  _curCount = _box getVariable "CurCount";
  _box setVariable ["CurCount", _curCount + 1, true];
  systemChat format["Number of units now acailable: %1",_curCount + 1];
  [_logic] call EE_Scripts_fnc_us_createActions;
}else{
  _logic setVariable ["DeleteUnits", true, true];
};
