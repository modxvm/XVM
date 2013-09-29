package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface IBattleSessionWindowMeta extends flash.events.IEventDispatcher
    {
        function requestToAssignMemberS(arg1:Number):void;

        function requestToUnassignMemberS(arg1:Number):void;

        function canMoveToAssignedS():Boolean;

        function canMoveToUnassignedS():Boolean;

        function as_setStartTime(arg1:Number):void;

        function as_setInfo(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String, arg6:String, arg7:String):void;

        function as_setNationsLimits(arg1:Array):void;

        function as_setClassesLimits(arg1:Object, arg2:Boolean):void;

        function as_setCommonLimits(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void;
    }
}
