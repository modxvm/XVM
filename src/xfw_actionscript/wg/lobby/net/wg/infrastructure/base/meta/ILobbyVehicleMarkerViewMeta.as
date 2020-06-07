package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;

    public interface ILobbyVehicleMarkerViewMeta extends IEventDispatcher
    {

        function as_createMarker(param1:String, param2:String) : DisplayObject;

        function as_removeMarker() : void;
    }
}
