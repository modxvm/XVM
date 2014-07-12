package net.wg.gui.components.tooltips.finstats
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class EfficiencyCritsBlock extends UIComponent
   {
      
      public function EfficiencyCritsBlock() {
         super();
      }
      
      public var headerTF:TextField;
      
      public var contentTF:TextField;
      
      private var _header:String = "";
      
      private var _content:String = "";
      
      private var dirtyData:Boolean = false;
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override protected function draw() : void {
         super.draw();
         if(this.dirtyData)
         {
            this.headerTF.text = this._header;
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.contentTF.multiline = true;
            this.contentTF.wordWrap = true;
            this.contentTF.autoSize = TextFieldAutoSize.LEFT;
            this.contentTF.htmlText = this._content;
            this.contentTF.width = this.contentTF.textWidth + 5;
         }
      }
      
      public function setData(param1:String, param2:String) : void {
         this._header = param1;
         this._content = param2;
         this.dirtyData = true;
         validateNow();
      }
   }
}
