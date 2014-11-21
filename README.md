bikeDeploy
==========
###Bicycle deploy script (made from other people's work)
Deserved Credit: Player2 (opendayz.net), cen (opendayz.net), Axe Cop (epochmod.com), maca134 (epochservers.com), Sarge (opendayz.net)

Hello Friends,

This is an upload of what I use, which is based off of a script developed by Player2 on opendayz.net. Most of the relevant additions were made by Axe Cop, but this script is has gone through so many hands it is hard to track. I apologize for the instructions being only Epoch centric, that is what I use and it is tough to play "what if". I've seen this before, but still never seen a good writeup... now I have a writeup, but still not a good one.

Anyways, lets get this show on the road... GitHub frightens and confuses my caveman mind.

#Requirements
My custom scripts directory is called "dookieButter", be sure to edit to your liking. 


* Custom **compiles.sqf** (example pathed to .\dookieButter\)
  * Localized **fn_selfactions.sqf** in the mission file (example pathed to .\dookieButter\)
* maca134's right click item menu

1. Edit **init.sqf**

  Below
  ```
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
  ```
  Add the following
  ```
call compile preprocessFileLineNumbers "dookieButter\compiles.sqf";	
  ```

2. Create **compiles.sqf** within .\dookieButter

3. Edit **compiles.sqf**
  
  Paste the following:
  ```
// not so custom compiles.sqf
if (!isDedicated) then {
	fnc_usec_selfActions = 			compile preprocessFileLineNumbers "dookieButter\fn_selfActions.sqf";
	player_selectSlot =				compile preprocessFileLineNumbers "dookieButter\ui_selectSlot.sqf";
};
```
4. Extract **fn_selfActions.sqf** from dayz_code.pbo to .\dookieButter

5. Extract **ui_selectSlot.sqf** from dayz_code.pbo to .\dookieButter

6. Edit **ui_selectSlot.sqf**

  **Above**
  ```
_pos set [3,_height];
  ```
  Paste the following:
  ```
	// Add extra context menus
	_erc_cfgActions = (missionConfigFile >> "ExtraRc" >> _item);
	_erc_numActions = (count _erc_cfgActions);
	if (isClass _erc_cfgActions) then {
		for "_j" from 0 to (_erc_numActions - 1) do {
			_menu =  _parent displayCtrl (1600 + _j + _numActions);
			_menu ctrlShow true;
			_config =  (_erc_cfgActions select _j);
			_text =  getText (_config >> "text");
			_script =  getText (_config >> "script");
			_height = _height + (0.025 * safezoneH);
			uiNamespace setVariable ['uiControl', _control];
			_menu ctrlSetText _text;
			_menu ctrlSetEventHandler ["ButtonClick",_script];
		};
	};
	// End extra content menus

  ```
7. Edit **description.ext**

  At the bottom of the file
  
  Paste the following:
  ```
#include "dookieButter\extra_rc.hpp"
  ```
  
8. Create **extra_rc.hpp** within .\dookieButter

9. Edit **extra_rc.hpp**

  Paste the following: (we'll add more later)
  ```
class ExtraRc {
};

  ```

#Installation Instructions

1. Create custom script folder (i.e.: dookieButter) within the mission file structure

2. Copy **bike.sqf** and **bike2.sqf** to dookieButter

3. Edit **fn_selfActions.sqf**

  Below
  ```
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);
  ```
 
  Add the following
  ```
// ---------------------------------------Deployable Bike Start------------------------------------
if (_canDo && (speed player <= 1) && cursorTarget isKindOf "MMT_USMC" && (cursorTarget getVariable ["SpawnedBike",0] == 1)) then {
    if (s_player_deploybike2 < 0) then {
        s_player_deploybike2 = player addaction[("<t color=""#007ab7"">" + ("Re-Pack Bike") +"</t>"),"dookieButter\bike2.sqf","",5,false,true,"", ""];

    };
} else {
    player removeAction s_player_deploybike2;
    s_player_deploybike2 = -1;
};
// ---------------------------------------Deployable Bike End------------------------------------

  ```
4. Edit **extra_rc.hpp**
 
  If an entry for ItemToolbox already exists, it will require some clever editing. Otherwise below:
  ```
	class ItemToolbox {
		class BuildBike {
			text = "Unpack Bike";
			script = "execVM 'dookieButter\bike.sqf'";
		};
	};
  ```
5. Edit **server_functions.sqf** within the dayz_server.pbo

  Find the following
  ```
if(vehicle _x != _x && !(vehicle _x in PVDZE_serverObjectMonitor) && (isPlayer _x)  && !((typeOf vehicle _x) in DZE_safeVehicle)) then {
  ```
  This is buried within the inline function: **server_checkHackers**

  Change it to include: && (vehicle _x getVariable ["Sarge",0] != 1)
  ```
if(vehicle _x != _x && (vehicle _x getVariable ["Sarge",0] != 1) && !(vehicle _x in PVDZE_serverObjectMonitor) && (isPlayer _x) && !((typeOf vehicle _x) in DZE_safeVehicle)) then {
  ```

#References

* Original source I found buried in <a href="http://opendayz.net/threads/auto-refuel-deploy-able-bikes.13707/">here</a>
* Axe Cop's contribution located in <a href="http://epochmod.com/forum/index.php?/topic/3339-deployable-bike-scrollwheel-issue/">this thread</a> 
* maca134's <a href="http://epochservers.com/viewtopic.php?f=14&t=13">right click option</a>
* Sarge AI using the "Sarge" <a href="https://github.com/Swiss-Sarge/SAR_AI">variable</a> to avoid "Killed a Hacker" function

  If someone finds the original source, link me... PLEASE!

#Current bugs, nuisances, future addons, and exploits
* not enough hookers
