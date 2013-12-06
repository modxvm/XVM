package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.techtree.nodes.Renderer;


   public class ExperienceLabel extends NodeComponent
   {
          
      public function ExperienceLabel() {
         super();
      }

      public var xpLabel:String = "xpCostLabel";

      public var textField:TextField;

      public var xpIcon:XPIcon;

      override protected function configUI() : void {
         mouseEnabled = mouseChildren = false;
         super.configUI();
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         if(!(_owner == null) && (isInvalid(InvalidationType.DATA)))
         {
            _loc1_ = this.xpLabel.length > 0?_owner.getNamedValue(this.xpLabel,Renderer.NAMED_VALUE_TYPE_STRING).toString():"";
            this.setXpField(_loc1_);
            if(this.xpIcon != null)
            {
               this.xpIcon.validateNow();
            }
         }
         super.draw();
      }

      private function setXpField(param1:String) : void {
         if(this.textField != null)
         {
            this.textField.text = param1;
         }
      }
   }

}