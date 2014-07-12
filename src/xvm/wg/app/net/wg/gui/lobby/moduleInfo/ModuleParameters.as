package net.wg.gui.lobby.moduleInfo
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.text.TextLineMetrics;
   import scaleform.gfx.TextFieldEx;
   
   public class ModuleParameters extends UIComponent
   {
      
      public function ModuleParameters() {
         super();
      }
      
      private static const LINE_SPACING_CORRECTION:int = 1;
      
      private static function updateTextHeight(param1:TextField, param2:int) : void {
         var _loc3_:TextLineMetrics = param1.getLineMetrics(0);
         param1.height = (_loc3_.height + _loc3_.leading + LINE_SPACING_CORRECTION) * param2;
      }
      
      public var header:TextField;
      
      public var paramValue:TextField;
      
      public var paramType:TextField;
      
      protected var _bottomMargin:Number;
      
      private var _headerText:String = "";
      
      private const HEADER_TEXT_INV:String = "headerTextInv";
      
      public function get bottomMargin() : Number {
         return this._bottomMargin;
      }
      
      public function set bottomMargin(param1:Number) : void {
         this._bottomMargin = param1;
      }
      
      public function setParameters(param1:Array = null) : void {
         var _loc3_:Object = null;
         this.paramValue.htmlText = "";
         this.paramType.htmlText = "";
         var _loc2_:int = param1.length;
         if(_loc2_ > 0)
         {
            for each(_loc3_ in param1)
            {
               if(this.paramValue.htmlText.length > 0)
               {
                  TextFieldEx.appendHtml(this.paramValue,"\n");
               }
               TextFieldEx.appendHtml(this.paramValue,_loc3_.value);
               TextFieldEx.appendHtml(this.paramType,_loc3_.type);
            }
         }
         updateTextHeight(this.paramValue,_loc2_);
         updateTextHeight(this.paramType,_loc2_);
         height = this.paramValue.y + this.paramValue.height + this._bottomMargin;
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(this.HEADER_TEXT_INV))
         {
            this.header.htmlText = this._headerText;
         }
      }
      
      public function get headerText() : String {
         return this._headerText;
      }
      
      public function set headerText(param1:String) : void {
         this._headerText = param1;
         invalidate(this.HEADER_TEXT_INV);
      }
   }
}
