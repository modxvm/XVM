package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITankCarouselMeta extends flash.events.IEventDispatcher
    {
        function showVehicleInfoS(arg1:String):void;

        function toResearchS(arg1:String):void;

        function vehicleSellS(arg1:String):void;

        function vehicleChangeS(arg1:String):void;

        function buySlotS():void;

        function buyTankClickS():void;

        function setVehiclesFilterS(arg1:Number, arg2:String, arg3:Boolean):void;

        function favoriteVehicleS(arg1:String, arg2:Boolean):void;

        function getVehicleTypeProviderS():Array;

        function as_vehiclesResponse(arg1:Object):void;

        function as_setCarouselFilter(arg1:Object):void;

        function as_changeVehicleByCompDescr(arg1:Number):void;
    }
}
