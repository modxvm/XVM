/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vo
{
    public interface IVOMacrosOptions
    {
        function get vehicleID():Number;
        function get playerName():String;
        function get playerFakeName():String;
        function get clanAbbrev():String;
        function get isAlly():Boolean;
        function get isEnemy():Boolean;
        function get isAlive():Boolean;
        function get isDead():Boolean;
        function get isReady():Boolean;
        function get isOffline():Boolean;
        function get isNotAvailable():Boolean;
        function get isStopRespawn():Boolean;
        function get isSelected():Boolean;
        function get isCurrentPlayer():Boolean;
        function get isFriend():Boolean;
        function get isIgnored():Boolean;
        function get isMuted():Boolean;
        function get isChatBan():Boolean;
        function get isTeamKiller():Boolean;
        function get isSquadPersonal():Boolean;
        function get squadIndex():Number;
        function get rankLevel():Number;
        function get index():int;
        function get position():Number;
        function get vehCD():int;
        function get vehicleData():VOVehicleData;
        function get marksOnGun():Number;

        // internal use

        function getSubname():String;

        function setSubname(subname:String):void;
    }
}
