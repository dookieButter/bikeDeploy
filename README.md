bikeDeploy
==========
###Bicycle deploy script (made from other people's work)
Deserves Credit: Player2 (opendayz.net), cen (opendayz.net), Axe Cop (epochmod.com), maca134 (epochservers.com), Sarge (opendayz.net)

Hello Friends,

This is an upload of what I use, which is based off of a script developed by Player2 on opendayz.net. Most of the relevant additions were made by Axe Cop, but this script is has gone through so many hands it is hard to track. I apologize for the instructions being only Epoch centric, that is what I use and it is tough to play "what if".

Anyways, lets get this show on the road... GitHub frightens and confuses me anyways.

#Instructions
My custom scripts directory is called "dookieButter", be sure to edit to your liking. I will add complete instructions for enabling the fn_selfActions.sqf when I am super bored and have the need to give people opportunities to correct me.

* Create custom script folder (i.e.: dookieButter) within the mission file structure

* Copy **bike.sqf** and **bike2.sqf** to dookieButter

* Edit **fn_selfActions.sqf** within the mission.pbo
 
Add the following
```
// ---------------------------------------Deployable Bike Start------------------------------------
_itemsPlayer = items player;
_hasToolbox = "ItemToolbox" in _itemsPlayer;
if (_canDo && (speed player <= 1) && _hasToolbox) then {
    if (s_player_deploybike < 0) then {
        s_player_deploybike = player addaction[("<t color=""#007ab7"">" + ("Deploy Bike (will use Toolbox)") +"</t>"),"dookieButter\bike.sqf","",5,false,true,"", ""];

    };
} else {
    player removeAction s_player_deploybike;
    s_player_deploybike = -1;
};

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
just below
```
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);
```
*  Edit **server_functions.sqf** within the dayz_server.pbo

Find the following
```
if(vehicle _x != _x && !(vehicle _x in PVDZE_serverObjectMonitor) && (isPlayer _x)  && !((typeOf vehicle _x) in DZE_safeVehicle)) then {
```
This is buried within the inline function: **server_checkHackers**

Change it to include: && (vehicle _x getVariable [""Sarge"",0] != 1)
```
if(vehicle _x != _x && !(vehicle _x in PVDZE_serverObjectMonitor) && (isPlayer _x)  && !((typeOf vehicle _x) in DZE_safeVehicle) && (vehicle _x getVariable [""Sarge"",0] != 1) ) then {
```

#References

- Original source I found buried in <a href="http://opendayz.net/threads/auto-refuel-deploy-able-bikes.13707/">here</a>
- Axe Cop's contribution located in <a href="http://epochmod.com/forum/index.php?/topic/3339-deployable-bike-scrollwheel-issue/">this thread</a> 
- maca134's <a href="http://epochservers.com/viewtopic.php?f=14&t=13">right click option</a> which is next to be implemented. 
- Sarge AI using the "Sarge" <a href="https://github.com/Swiss-Sarge/SAR_AI">variable</a> to avoid "Killed a Hacker" function

If someone finds the original source, link me... PLEASE!


#Current bugs, nuisances, future addons, and exploits
* Players can highlight bike, activate scroll wheel menu, run away and create toolbox without deleting the bike
* accidental scroll wheel activation of bike script
  * Solution: use maca134's right click function for deployment
* not enough hookers
