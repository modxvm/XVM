package net.wg.gui.components.tooltips
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.VO.ModuleVO;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.InvalidationType;
   
   public class ModuleItem extends UIComponent
   {
      
      public function ModuleItem() {
         super();
      }
      
      public var icon:UIComponent;
      
      public var textField:TextField;
      
      private var model:ModuleVO;
      
      public function setData(param1:ModuleVO) : void {
         this.model = param1;
         invalidateData();
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.icon.gotoAndStop(this.model.type);
            this.textField.htmlText = this.model.label;
         }
      }
      
      override protected function onDispose() : void {
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
   }
}
