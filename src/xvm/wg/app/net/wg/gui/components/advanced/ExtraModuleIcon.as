package net.wg.gui.components.advanced
{
   import net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import flash.events.Event;


   public class ExtraModuleIcon extends ModuleIcon
   {
          
      public function ExtraModuleIcon() {
         super();
      }

      private var extraIcon:ExtraIcon;

      private var _extraIconSource:String;

      public function get extraIconSource() : String {
         return this._extraIconSource;
      }

      public function set extraIconSource(param1:String) : void {
         this._extraIconSource = param1;
         if(!this.extraIcon)
         {
            this.extraIcon = new ExtraIcon();
            this.extraIcon.visible = false;
            this.extraIcon.addEventListener(SimpleLoader.LOADED,this.onExtraIconLoaded,false,0,true);
            addChild(this.extraIcon);
         }
         this.extraIcon.setSource(this._extraIconSource);
      }

      override public function dispose() : void {
         this.extraIcon.dispose();
         super.dispose();
      }

      private function onExtraIconLoaded(param1:Event) : void {
         this.extraIcon.x = Math.round(moduleType.width - this.extraIcon.width - 6);
         this.extraIcon.y = Math.round(moduleType.height - this.extraIcon.height - 5);
         this.extraIcon.visible = true;
      }
   }

}