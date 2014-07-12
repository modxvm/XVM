package net.wg.gui.components.windows
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.Sprite;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScreenBg extends UIComponent implements IDisposable
   {
      
      public function ScreenBg() {
         super();
      }
      
      private static const STATE_INV:String = "stateChange";
      
      public var headerBg:Sprite = null;
      
      public var bgFx:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var _isShowHeaderBg:Boolean = true;
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override public function setSize(param1:Number, param2:Number) : void {
         super.setSize(param1,param2);
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = _width + 1;
            this.bg.height = _height + 1;
            this.headerBg.x = _width - this.headerBg.width >> 1;
            this.bgFx.x = _width - this.bgFx.width >> 1;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.headerBg.visible = this._isShowHeaderBg;
         }
      }
      
      public function set isShowHeaderBg(param1:Boolean) : void {
         if(param1 == this._isShowHeaderBg)
         {
            return;
         }
         this._isShowHeaderBg = param1;
         invalidate(STATE_INV);
      }
      
      public function get isShowHeaderBg() : Boolean {
         return this._isShowHeaderBg;
      }
      
      override protected function onDispose() : void {
         this.headerBg = null;
         this.bgFx = null;
         this.bg = null;
         super.onDispose();
      }
   }
}
