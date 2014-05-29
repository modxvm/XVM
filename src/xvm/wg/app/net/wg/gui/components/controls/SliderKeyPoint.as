package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.events.MouseEvent;


   public class SliderKeyPoint extends UIComponent
   {
          
      public function SliderKeyPoint() {
         super();
         buttonMode = useHandCursor = true;
      }

      public var labelTF:TextField;

      private var _tooltip:String;

      private var _index:int = -1;

      private var _label:String = "";

      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         super.onDispose();
      }

      private function onOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onOver(param1:MouseEvent) : void {
         if(this._tooltip)
         {
            App.toolTipMgr.show(this._tooltip);
         }
      }

      public function get tooltip() : String {
         return this._tooltip;
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
      }

      public function get index() : int {
         return this._index;
      }

      public function set index(param1:int) : void {
         this._index = param1;
      }

      public function get label() : String {
         return this._label;
      }

      public function set label(param1:String) : void {
         this._label = param1;
         if(this.labelTF)
         {
            this.labelTF.htmlText = this._label;
         }
      }
   }

}