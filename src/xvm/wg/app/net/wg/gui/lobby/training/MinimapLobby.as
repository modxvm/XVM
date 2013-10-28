package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.base.meta.impl.MinimapLobbyMeta;
   import net.wg.infrastructure.base.meta.IMinimapLobbyMeta;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.interfaces.IMinimapEntry;
   import flash.display.DisplayObject;


   public class MinimapLobby extends MinimapLobbyMeta implements IMinimapLobbyMeta
   {
          
      public function MinimapLobby() {
         super();
      }

      private static const MINIMAP_SIZE:Number = 300;

      public var scope:String = "inRoom";

      public var map:UILoaderAlt;

      override public function setMapS(param1:Number) : void {
         App.utils.asserter.assert(!isNaN(param1),"arenaID" + Errors.CANT_NAN);
         super.setMapS(param1);
      }

      public function as_clear() : void {
         this.clearAll();
      }

      private function clearAll() : void {
         while(icons.numChildren > 0)
         {
            icons.removeChildAt(0);
         }
      }

      public function as_changeMap(param1:String) : void {
         this.map.visible = true;
         this.map.source = param1;
      }

      public function as_addPoint(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void {
         var _loc6_:Object =
            {
               "x":param1,
               "y":param2,
               "scaleX":1.5,
               "scaleY":-1.5
            }
         ;
         var _loc7_:IMinimapEntry = App.utils.classFactory.getComponent(Linkages.MINIMAP_ENTRY,IMinimapEntry,_loc6_);
         icons.addChild(_loc7_ as DisplayObject);
         _loc7_.init("points",param3,param4,param5);
      }

      override protected function configUI() : void {
         super.configUI();
         icons.mask = iconsMask;
      }

      override protected function onDispose() : void {
         icons.mask = null;
         this.map.dispose();
         this.map = null;
         this.clearAll();
         super.onDispose();
      }
   }

}