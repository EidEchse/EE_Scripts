params ["_logic", "_unit"];
_respawn = _logic getVariable "Respawn";
_box = _logic getVariable "Box";

waitUntil ({!alive _unit;});

_deleteUnits = _logic getVariable ["DeleteUnits", false];
if (!_deleteUnits) then {
  _curUnits = _logic getVariable "CurUnits";
  _logic setVariable ["CurUnits", _curUnits - [_unit], true];
  _i = floor _respawn;
  if (_i > 1) then
  {
    (format["Next unit respawn available in %1 minutes.", _i]) remoteExec ["hint", [0,-2] select isDedicated];
  }else{
    (format["Next unit respawn available in less than %1 minute.", 1]) remoteExec ["systemChat", [0,-2] select isDedicated];
  };
  while{_i > 0} do
  {
    if (_i > 1) then
    {
      (format["Next unit respawn available in %1 minutes.", _i]) remoteExec ["systemChat", [0,-2] select isDedicated];
    }else{
      (format["Next unit respawn available in less than %1 minute.", 1]) remoteExec ["systemChat", [0,-2] select isDedicated];
    };

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

    [_logic] spawn EE_Scripts_fnc_us_createActions;
    sleep 60;
    _i = _i - 1;
    waitUntil {count (allPlayers - entities "HeadlessClient_F") > 0};
  };
  _logic setVariable ["NextRespawn", 0, true];
  _curCount = _box getVariable "CurCount";
  (format["Now available units: %1", _curCount + 1]) remoteExec ["hint", [0,-2] select isDedicated];
  sleep 10;
  if (_i > 1) then
  {
    (format["Next unit respawn available in %1 minutes.", _i]) remoteExec ["hint", [0,-2] select isDedicated];
  }else{
    (format["Next unit respawn available in less than %1 minute.", 1]) remoteExec ["systemChat", [0,-2] select isDedicated];
  };
};
_curCount = _box getVariable "CurCount";
_box setVariable ["CurCount", _curCount + 1, true];
[_logic] spawn EE_Scripts_fnc_us_createActions;
