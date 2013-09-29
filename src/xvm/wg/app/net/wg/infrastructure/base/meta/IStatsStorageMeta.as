package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IStatsStorageMeta extends flash.events.IEventDispatcher
    {
        function as_setExperience(arg1:Number):void;

        function as_setTankmanId(arg1:Number):void;

        function as_setCredits(arg1:Number):void;

        function as_setGold(arg1:Number):void;

        function as_setPremium(arg1:Boolean):void;

        function as_setVehicle(arg1:Number):void;

        function as_setPlayerSpeaking(arg1:Number, arg2:Boolean, arg3:Boolean):void;

        function as_setAccountAttrs(arg1:Number):void;

        function as_setDenunciationsCount(arg1:Number):void;

        function as_setNations(arg1:Array):void;
    }
}
