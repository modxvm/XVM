package net.wg.gui.components.controls
{


   public class DropDownImageText extends DropdownMenu
   {
          
      public function DropDownImageText() {
         super();
      }

      public var icon:UILoaderAlt;

      override protected function configUI() : void {
         super.configUI();
      }

      override public function dispose() : void {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         super.dispose();
      }

      override protected function populateText(param1:Object) : void {
         super.populateText(param1);
         this.icon.visible = true;
         if(param1)
         {
            this.icon.source = param1.icon;
         }
      }

      override public function toString() : String {
         return "[WG DropDownImageText " + name + "]";
      }
   }

}