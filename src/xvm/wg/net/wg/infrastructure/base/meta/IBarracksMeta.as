package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBarracksMeta extends flash.events.IEventDispatcher
    {
        function invalidateTanksListS():void;

        function setFilterS(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void;

        function onShowRecruitWindowClickS(arg1:Object, arg2:Boolean):void;

        function unloadTankmanS(arg1:String):void;

        function dismissTankmanS(arg1:String):void;

        function buyBerthsS():void;

        function closeBarracksS():void;

        function setTankmenFilterS():void;

        function openPersonalCaseS(arg1:String, arg2:uint):void;

        function as_setTankmen(arg1:Number, arg2:Number, arg3:Number, arg4:String, arg5:Number, arg6:Array):void;

        function as_updateTanksList(arg1:Array):void;

        function as_setTankmenFilter(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void;
    }
}
