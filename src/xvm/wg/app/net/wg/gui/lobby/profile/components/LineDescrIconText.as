package net.wg.gui.lobby.profile.components
{
   import flash.text.TextField;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.managers.IToolTipParams;


   public class LineDescrIconText extends LineIconText
   {
          
      public function LineDescrIconText() {
         super();
         buttonMode = true;
      }

      public static const DESCRIPTION_TEXT_INVALID:String = "dInvalid";

      private static function hideToolTip() : void {
         App.toolTipMgr.hide();
      }

      private var _description:String = "";

      private var _tooltip:String = null;

      public var textField:TextField;

      private var _myEnabled:Boolean = true;

      private var _isToolTipShowing:Boolean;

      override protected function configUI() : void {
         super.configUI();
      }

      public function get description() : String {
         return this._description;
      }

      public function set description(param1:String) : void {
         this._description = param1;
         invalidate(DESCRIPTION_TEXT_INVALID);
      }

      override public function get width() : Number {
         return this.textField.x + this.textField.width;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(DESCRIPTION_TEXT_INVALID))
         {
            this.textField.multiline = true;
            this.textField.text = this._description;
            dispatchEvent(new Event(Event.RESIZE,true));
         }
      }

      override protected function applyText() : void {
         if(this._myEnabled)
         {
            gotoAndPlay("up");
            super.applyText();
         }
         else
         {
            gotoAndPlay("disabled");
            textComponent.text = "--";
         }
         invalidate(DESCRIPTION_TEXT_INVALID);
      }

      protected function mouseRollOutHandler(param1:MouseEvent) : void {
         this._isToolTipShowing = false;
         hideToolTip();
      }

      protected function mouseRollOverHandler(param1:MouseEvent) : void {
         this._isToolTipShowing = true;
         this.showToolTip(null);
      }

      protected function showToolTip(param1:IToolTipParams) : void {
         if(this._tooltip)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }

      override public function dispose() : void {
         this.disposeHandlers();
         super.dispose();
      }

      private function disposeHandlers() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }

      public function get tooltip() : String {
         return this._tooltip;
      }

      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
         this.disposeHandlers();
         if(this._isToolTipShowing)
         {
            hideToolTip();
            this.showToolTip(null);
         }
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }

      override public function set enabled(param1:Boolean) : void {
         if(param1 != this._myEnabled)
         {
            this._myEnabled = param1;
            invalidate(TEXT_INVALID);
         }
      }

      override public function get enabled() : Boolean {
         return this._myEnabled;
      }
   }

}