package com.xvm.vo
{
    public interface IVOMacrosOptions
    {
        function get isAlive():Boolean;
        function get isReady():Boolean;
        function get isNotAvailable():Boolean;
        function get isStopRespawn():Boolean;
        function get isDead():Boolean;
        function get isSelected():Boolean;
        function get isCurrentPlayer():Boolean;
        function get isTeamKiller():Boolean;
        function get isSquadPersonal():Boolean;
        function get squadIndex():Number;
        function get position():Number;
        function get vehicleData():VOVehicleData;

        // internal use

        function getSubname():String;

        function setSubname(subname:String):void;
    }
}
