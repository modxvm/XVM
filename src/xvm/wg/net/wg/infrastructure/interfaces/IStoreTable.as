package net.wg.infrastructure.interfaces 
{
    import net.wg.infrastructure.base.meta.*;
    import scaleform.clik.interfaces.*;
    
    public interface IStoreTable extends net.wg.infrastructure.base.meta.IStoreTableMeta, net.wg.infrastructure.interfaces.IDAAPIModule, scaleform.clik.interfaces.IUIComponent
    {
        function setVehicleRendererLinkage(arg1:String):void;

        function setModuleRendererLinkage(arg1:String):void;

        function get name():String;

        function updateHeaderCountTitle(arg1:String):void;

        function get visible():Boolean;

        function set visible(arg1:Boolean):void;

        function get enableInitCallback():Boolean;

        function set enableInitCallback(arg1:Boolean):void;

        function get rightOrientedCount():Boolean;

        function set rightOrientedCount(arg1:Boolean):void;
    }
}
