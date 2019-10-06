package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IMinimapMeta extends IEventDispatcher
    {

        function setAttentionToCellS(param1:Number, param2:Number, param3:Boolean) : void;

        function applyNewSizeS(param1:Number) : void;

        function as_setSize(param1:int) : void;

        function as_setVisible(param1:Boolean) : void;

        function as_setAlpha(param1:Number) : void;

        function as_showVehiclesName(param1:Boolean) : void;

        function as_setBackground(param1:String) : void;
    }
}
