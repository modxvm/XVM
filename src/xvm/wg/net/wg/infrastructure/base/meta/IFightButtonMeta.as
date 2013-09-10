package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IFightButtonMeta extends flash.events.IEventDispatcher
    {
        function fightClickS(arg1:Number, arg2:String):void;

        function fightSelectClickS(arg1:String):void;

        function demoClickS():void;

        function as_disableFightButton(arg1:Boolean, arg2:String):void;

        function as_setFightButton(arg1:String, arg2:String, arg3:Array):void;

        function as_setDemonstratorButton(arg1:Boolean):void;
    }
}
