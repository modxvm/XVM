package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IStoreTableMeta;
   import scaleform.clik.interfaces.IUIComponent;


   public interface IStoreTable extends IStoreTableMeta, IDAAPIModule, IUIComponent
   {
          
      function setVehicleRendererLinkage(param1:String) : void;

      function setModuleRendererLinkage(param1:String) : void;

      function get name() : String;

      function updateHeaderCountTitle(param1:String) : void;

      function get visible() : Boolean;

      function set visible(param1:Boolean) : void;

      function get enableInitCallback() : Boolean;

      function set enableInitCallback(param1:Boolean) : void;

      function get rightOrientedCount() : Boolean;

      function set rightOrientedCount(param1:Boolean) : void;
   }

}