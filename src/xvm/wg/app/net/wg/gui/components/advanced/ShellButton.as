package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.SoundButton;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;


   public class ShellButton extends SoundButton
   {
          
      public function ShellButton() {
         super();
         soundType = SoundTypes.FITTING_BUTTON;
         soundId = "tankShell";
         this.count = "";
      }

      public var id:String;

      private var _shellType:String;

      private var _shellIcon:String = "";

      private var _count:String;

      private var _inventoryCount:String;

      public var count_txt:TextField;

      public var countBg:MovieClip;

      public var iconLoader:UILoaderAlt;

      override protected function configUI() : void {
         super.configUI();
         _stateMap =
            {
               "up":["up"],
               "over":["over"],
               "down":["down"],
               "release":["release","over"],
               "out":["out","up"],
               "disabled":["disabled"],
               "selecting":["selecting","over"],
               "kb_selecting":["kb_selecting","up"],
               "kb_release":["kb_release","out","up"],
               "kb_down":["kb_down","down"]
            }
         ;
         if(hitMc != null)
         {
            this.hitArea = hitMc;
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.count_txt = null;
         this.countBg = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if(this.iconLoader)
         {
            this.iconLoader.visible = !(this.shellIcon == "");
            if(this.shellIcon != "")
            {
               this.iconLoader.source = this.shellIcon;
            }
         }
         if(this.count_txt)
         {
            this.count_txt.text = this._count;
            this.countBg.visible = !(this._count == "");
         }
      }

      public function get shellIcon() : String {
         return this._shellIcon;
      }

      public function set shellIcon(param1:String) : void {
         this._shellIcon = param1;
         invalidate();
      }

      public function get shellType() : String {
         return this._shellType;
      }

      public function set shellType(param1:String) : void {
         this._shellType = param1;
      }

      public function get inventoryCount() : String {
         return this._inventoryCount;
      }

      public function set inventoryCount(param1:String) : void {
         this._inventoryCount = param1;
      }

      public function get count() : String {
         return this._count;
      }

      public function set count(param1:String) : void {
         this._count = param1;
      }

      public function clear() : void {
         this.id = null;
         this.count = "";
         this.shellIcon = "";
         label = "";
      }

      private function onOver(param1:MouseEvent) : void {
         App.toolTipMgr.showSpecial("hangarShell",null,this.id,this.inventoryCount,this.count);
      }

      public function onOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}