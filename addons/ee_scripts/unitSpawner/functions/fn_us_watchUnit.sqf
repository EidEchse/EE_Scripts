params ["_logic", "_unit"];
_respawn = _logic getVariable "Respawn";
_box = _logic getVariable "Box";

waitUntil ({!alive _unit;});

_deleteUnits = _logic getVariable ["DeleteUnits", false];
if (!_deleteUnits) then {
  _curUnits = _logic getVariable "CurUnits";
  _logic setVariable ["CurUnits", _curUnits - [_unit], true];
  _i = floor _respawn;
  while{_i > 0} do
  {
    systemChat format["Next unit respawn available in %1 minutes.", _i];
    _nextRespawn = _logic getVariable ["NextRespawn", 0];
    if (_nextRespawn ==  0) then
    {
      _logic setVariable ["NextRespawn", _i, true];
    }else{
      if (_i <  _nextRespawn) then
      {
        _logic setVariable ["NextRespawn", _i, true];
      };
    };

    [_logic] call EE_Scripts_fnc_us_createActions;
    sleep 60;
    _i = _i - 1;
    waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
  };
  _logic setVariable ["NextRespawn", 0, true];
  _curCount = _box getVariable "CurCount";
  systemChat format["Number of units now acailable: %1",_curCount + 1];
};
_curCount = _box getVariable "CurCount";
_box setVariable ["CurCount", _curCount + 1, true];
[_logic] call EE_Scripts_fnc_us_createActions;
