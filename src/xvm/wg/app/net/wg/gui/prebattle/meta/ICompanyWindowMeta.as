package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface ICompanyWindowMeta extends flash.events.IEventDispatcher
    {
        function requestToAssignS(arg1:Number):void;

        function requestToUnassignS(arg1:Number):void;

        function requestToChangeOpenedS(arg1:Boolean):void;

        function requestToChangeCommentS(arg1:String):void;

        function requestToChangeDivisionS(arg1:uint):void;

        function getCompanyNameS():String;

        function canMoveToAssignedS():Boolean;

        function canMoveToUnassignedS():Boolean;

        function canMakeOpenedClosedS():Boolean;

        function canChangeCommentS():Boolean;

        function canChangeDivisionS():Boolean;

        function as_setDivisionsList(arg1:Array, arg2:uint):void;

        function as_setOpened(arg1:Boolean):void;

        function as_setComment(arg1:String):void;

        function as_setDivision(arg1:uint):void;

        function as_setTotalLimitLabels(arg1:String, arg2:String):void;

        function as_setMaxCountLimitLabel(arg1:String):void;

        function as_setClassesLimits(arg1:Array):void;

        function as_setInvalidVehicles(arg1:Array):void;

        function as_setChangeSettingCoolDown(arg1:uint):void;
    }
}
