package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IResearchMeta extends flash.events.IEventDispatcher
    {
        function requestNationDataS():Boolean;

        function getResearchItemsDataS(arg1:Number, arg2:Boolean):Object;

        function onResearchItemsDrawnS():void;

        function request4InstallS(arg1:Number):void;

        function requestModuleInfoS(arg1:String):void;

        function goToTechTreeS(arg1:String):void;

        function exitFromResearchS():void;

        function as_drawResearchItems(arg1:String, arg2:Number):void;

        function as_setFreeXP(arg1:Number):void;

        function as_setInstalledItems(arg1:Array):void;
    }
}
