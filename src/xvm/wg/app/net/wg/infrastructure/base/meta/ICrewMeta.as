package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ICrewMeta extends flash.events.IEventDispatcher
    {
        function onShowRecruitWindowClickS(arg1:Object, arg2:Boolean):void;

        function unloadTankmanS(arg1:String):void;

        function unloadAllTankmanS():void;

        function equipTankmanS(arg1:String, arg2:Number):void;

        function openPersonalCaseS(arg1:String, arg2:uint):void;

        function updateTankmenS():void;

        function as_tankmenResponse(arg1:Array, arg2:Array):void;
    }
}
