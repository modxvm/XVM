package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BuildingCtxMenuVO extends DAAPIDataClass
   {
      
      public function BuildingCtxMenuVO(param1:Object) {
         super(param1);
      }
      
      public var actionID:String = "";
      
      public var menuItem:String = "";
      
      public var isEnabled:Boolean = false;
   }
}
