package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;

    public interface ILobbyVehicleMarkerViewMeta extends IEventDispatcher
    {

        function as_createMarker(param1:String, param2:String, param3:int, param4:int) : DisplayObject;

        function as_removeMarker(param1:int) : void;
    }
}
