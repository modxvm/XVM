package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Button;


   public class HyperLink extends Button
   {
          
      public function HyperLink() {
         super();
         buttonMode = true;
      }

      public var isUnderline:Boolean = true;

      override protected function updateText() : void {
         if(!(_label == null) && !(textField == null))
         {
            textField.text = _label;
            if(this.isUnderline)
            {
               textField.htmlText = "<u>" + textField.text + "</u>";
            }
         }
      }
   }

}