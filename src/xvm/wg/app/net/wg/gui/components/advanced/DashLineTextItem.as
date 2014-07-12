package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.data.managers.IToolTipParams;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.InvalidationType;
   
   public class DashLineTextItem extends UIComponent
   {
      
      public function DashLineTextItem() {
         super();
      }
      
      public static const LABEL_INV:String = "lblInv";
      
      public static const VALUE_INV:String = "valInv";
      
      public static const dashLinePadding:uint = 1;
      
      private static function hideToolTip() : void {
         App.toolTipMgr.hide();
      }
      
      public var labelTextField:TextField;
      
      public var valueTextField:TextField;
      
      public var dashLine:DashLine;
      
      private var _label:String = "";
      
      private var _value:String = "0";
      
      private var _tooltip:String;
      
      protected var _myEnabled:Boolean = true;
      
      private var _toolTipParams:IToolTipParams;
      
      protected function mouseRollOutHandler(param1:MouseEvent) : void {
         hideToolTip();
      }
      
      protected function mouseRollOverHandler(param1:MouseEvent) : void {
         this.showToolTip(null);
      }
      
      protected function showToolTip(param1:IToolTipParams) : void {
         if(this._tooltip)
         {
            if(this._toolTipParams)
            {
               App.toolTipMgr.showComplexWithParams(this._tooltip,this._toolTipParams);
            }
            else
            {
               App.toolTipMgr.showComplex(this._tooltip);
            }
         }
      }
      
      public function set toolTipParams(param1:IToolTipParams) : void {
         this._toolTipParams = param1;
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(VALUE_INV))
         {
            if(this._myEnabled)
            {
               gotoAndPlay("up");
               this.valueTextField.autoSize = TextFieldAutoSize.LEFT;
               this.valueTextField.htmlText = this._value;
            }
            else
            {
               gotoAndPlay("disabled");
               this.valueTextField.autoSize = TextFieldAutoSize.LEFT;
               this.valueTextField.htmlText = "--";
            }
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(LABEL_INV))
         {
            this.labelTextField.autoSize = TextFieldAutoSize.LEFT;
            this.labelTextField.text = this._label;
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applySizeChanges();
         }
      }
      
      protected function applySizeChanges() : void {
         this.dashLine.width = Math.round(_width - this.labelTextField.width - this.valueTextField.width - dashLinePadding * 2);
         this.dashLine.x = Math.round(this.labelTextField.width + dashLinePadding);
         this.valueTextField.x = Math.round(_width - this.valueTextField.width);
      }
      
      public function get label() : String {
         return this._label;
      }
      
      public function set label(param1:String) : void {
         if(this._label != param1)
         {
            this._label = param1;
            invalidate(LABEL_INV);
         }
      }
      
      public function get value() : String {
         return this._value;
      }
      
      public function set value(param1:String) : void {
         if(this._value != param1)
         {
            this._value = param1;
            invalidate(VALUE_INV);
         }
      }
      
      public function get tooltip() : String {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
         this.disposeListeners();
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }
      
      private function disposeListeners() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false);
      }
      
      override public function set enabled(param1:Boolean) : void {
         if(param1 != this._myEnabled)
         {
            this._myEnabled = param1;
            invalidate(VALUE_INV);
            invalidate(LABEL_INV);
         }
      }
      
      override public function get enabled() : Boolean {
         return this._myEnabled;
      }
      
      override protected function onDispose() : void {
         this.dashLine.dispose();
         this.dashLine = null;
         this.disposeListeners();
         this.labelTextField = null;
         this.valueTextField = null;
         if(this._toolTipParams)
         {
            this._toolTipParams.dispose();
         }
         this._toolTipParams = null;
         super.onDispose();
      }
   }
}
