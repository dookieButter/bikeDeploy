bikeDeploy
==========
###Bicycle deploy script (made from other people's work)
Deserves Credit: Player2 (opendayz.net), cen (opendayz.net), Axe Cop (epochmod.com), maca134 (epochservers.com)



Hello Friends,

This is an upload of what I use, which is based off of a script developed by Player2 on opendayz.net. Most of the relevant additions were made by Axe Cop, but this script is has gone through so many hands it is hard to track. If I miss credit for someone, let me know and post a source. The biggest reason I am posting this, is because when I rebuild a server... this is one of the most difficult things to track down how I did it the first time. I've tried to use other "improved" scripts, but after trying to apply them along with fixes... they still broke the game, or were dangerous.

Anyways, lets get this show on the road... GitHub frightens and confuses me anyways.
- Original source I found buried in here: http://opendayz.net/threads/auto-refuel-deploy-able-bikes.13707/
- Axe Cop's Contribution thread: http://epochmod.com/forum/index.php?/topic/3339-deployable-bike-scrollwheel-issue/
- maca134's right click option which isn't implemented... yet: http://epochservers.com/viewtopic.php?f=14&t=13

If someone finds the original source, link me... PLEASE!

#Instructions
My custom scripts directory is called "dookieButter", be sure to edit to your liking. I will add complete instructions for enabling the fn_selfActions.sqf when I am super bored and have the need to give people opportunities to correct me.

* Create custom script folder (i.e.: dookieButter) within the mission file structure

* Copy **bike.sqf** and **bike2.sqf** to dookieButter

* Add the following
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
just below (in fn_selfActions.sqf)
```
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);
```
*  Edit **variables.sqf** (I pull the whole thing into my mission.pbo instead of amending it)

Find the following
```
DZE_safeVehicle = ["ParachuteWest","ParachuteC"];
```
Edit to include "MMT_USMC"
```
DZE_safeVehicle = ["ParachuteWest","ParachuteC","MMT_USMC"];
```

#Current bugs, nuisances, future addons, and exploits
* Players can highlight bike, activate scroll wheel menu, run away and create toolbox without deleting the bike
* accidental scroll wheel activation of bike script
  * Solution: use maca134's right click function for deployment
* not enough hookers
* add search for sarge variable instead of specifically defining what bike I spawn
