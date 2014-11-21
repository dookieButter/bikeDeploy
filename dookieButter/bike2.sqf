private ["_finished","_finishedTime","_object"];

if (dayz_combat == 1) then { 
    cutText [format["You are in Combat and cannot re-build your bike."], "PLAIN DOWN"];
} else {
	_object = cursortarget;
	player removeAction s_player_deploybike2;
	player addWeapon "ItemToolbox";
	
	player playActionNow "Medic";
	[player,"repair",0,false,10] call dayz_zombieSpeak;
	[player,10,true,(getPosATL player)] spawn player_alertZombies;

	re_interrupt = false;
	re_doLoop = true;

	_finished = false;
	_finishedTime = diag_tickTime+3;

	while {re_doLoop} do {
		if (diag_tickTime >= _finishedTime) then {
			re_doLoop = false;
			_finished = true;
		};
		if (re_interrupt) then {
			re_doLoop = false;
		};
		sleep 0.1;
	};
	if (_finished) then {
		if (_object distance player < 3) then {
			deletevehicle _object;
			sleep 6;
			cutText [format["You have packed your bike and been given back your toolbox"], "PLAIN DOWN"];
		} else {
			re_interrupt = false;
			player switchMove "";
			player playActionNow "stop";
			player removeWeapon "ItemToolbox";
			cutText ["\n\nToo far away to pack bike.", "PLAIN DOWN"];
		};
	} else {
		re_interrupt = false;
		player switchMove "";
		player playActionNow "stop";
		player removeWeapon "ItemToolbox";
		cutText ["\n\nCanceled packing a bike.", "PLAIN DOWN"];
	};
};