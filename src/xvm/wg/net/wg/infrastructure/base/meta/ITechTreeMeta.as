package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITechTreeMeta extends flash.events.IEventDispatcher
    {
        function requestNationTreeDataS():void;

        function getNationTreeDataS(arg1:String):Object;

        function goToNextVehicleS(arg1:Number):void;

        function onCloseTechTreeS():void;

        function as_setAvailableNations(arg1:Array):void;

        function as_setSelectedNation(arg1:String):void;

        function as_refreshNationTreeData(arg1:String):void;

        function as_setUnlockProps(arg1:Array):void;
    }
}
