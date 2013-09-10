package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ISkillDropMeta extends flash.events.IEventDispatcher
    {
        function calcDropSkillsParamsS(arg1:String, arg2:Number):Array;

        function dropSkillsS(arg1:Number):void;

        function as_setData(arg1:Object):void;

        function as_setGold(arg1:Number):void;

        function as_setCredits(arg1:Number):void;
    }
}
