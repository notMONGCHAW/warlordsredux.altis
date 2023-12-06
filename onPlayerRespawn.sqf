params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
0 spawn KS_fnc_unflipVehicleAddAction;

_leader = (leader group _newUnit);
if ((_newUnit != _leader) && {(alive _leader) && {((_oldUnit distance2D _leader) < 200) && {isPlayer _leader}}}) then {
	deleteVehicle _oldUnit;
	call BIS_fnc_WL2_orderLastLoadout;
	_newUnit setVehiclePosition [getPosASL _leader, [], 2, "NONE"];
};

_vics = missionNamespace getVariable "BIS_WL_ownedVehicles";
{
	_list = missionNamespace getVariable "BIS_WL_ownedVehicles";
	_list deleteAt _x;
	missionNamespace setVariable ["BIS_WL_ownedVehicles", _list];
} forEach (_vics select {isNull _x});

"Died" call MRTM_fnc_statTracker;

if !(["(EU) #11", serverName] call BIS_fnc_inString) then {
	player addAction [
		"10K CP",
		{[player, "10K"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];}
	];
};