package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
   import flash.display.MovieClip;


   public class BuildingTexture extends UIComponentEx implements IBuildingTexture
   {
          
      public function BuildingTexture() {
         super();
         this.buildingShape.mouseChildren = this.buildingShape.mouseEnabled = false;
         this.buildingShape.visible = false;
      }

      public var buildingShape:MovieClip;

      public function setState(param1:String) : void {
         gotoAndStop(param1);
      }

      public function getBuildingShape() : MovieClip {
         return this.buildingShape;
      }

      override protected function onDispose() : void {
         this.buildingShape = null;
         super.onDispose();
      }
   }

}