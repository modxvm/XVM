package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;


   public class GrayTransparentButton extends SoundButtonEx
   {
          
      public function GrayTransparentButton() {
         super();
      }

      public static const ICON_NO_ICON:String = "noIcon";

      public static const ICON_CROSS:String = "cross";

      public static const ICON_LOCK:String = "lock";

      public var iconContainer:MovieClip;

      private var _icon:String = "noIcon";

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
         if(this._icon)
         {
            this.iconContainer.gotoAndStop(this._icon);
            this.iconContainer.visible = true;
         }
         else
         {
            this.iconContainer.visible = false;
         }
      }
   }

}