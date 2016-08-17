params ["_box"];
_curCount = _box getVariable "CurCount";
_return = false;
if (_curCount > 0)  then {
  _return = true;
};
_return
