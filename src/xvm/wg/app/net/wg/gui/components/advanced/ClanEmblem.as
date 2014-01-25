package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class ClanEmblem extends UIComponent
   {
          
      public function ClanEmblem() {
         super();
      }

      public var _iconWidth:int;

      public var _iconHeight:int;

      public var default_icon_mc:MovieClip = null;

      public var loader:UILoaderAlt = null;

      override protected function onDispose() : void {
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this.default_icon_mc = null;
         super.onDispose();
      }

      public function setImage(param1:String) : void {
         if(param1)
         {
            this.loader.source = "img://" + param1;
            this.default_icon_mc.visible = false;
         }
         else
         {
            this.loader.visible = false;
            this.default_icon_mc.visible = true;
            this.default_icon_mc.width = this._iconWidth;
            this.default_icon_mc.height = this._iconHeight;
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.default_icon_mc.visible = false;
      }
   }

}