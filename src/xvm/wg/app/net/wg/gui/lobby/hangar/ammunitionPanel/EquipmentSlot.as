package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.data.constants.FittingTypes;


   public class EquipmentSlot extends DeviceSlot
   {
          
      public function EquipmentSlot() {
         super();
      }

      public var icon:UILoaderAlt;

      override protected function configUI() : void {
         super.configUI();
         if(this.icon)
         {
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
         }
      }

      override public function dispose() : void {
         this.icon.dispose();
         super.dispose();
      }

      public function setIcon(param1:String, param2:Boolean) : void {
         this.icon.source = param1;
         locked.visible = !param2;
      }

      override protected function applyIconData(param1:*) : void {
         if(param1)
         {
            this.setIcon(param1.icon,param1.removable);
         }
         else
         {
            this.setIcon(FittingTypes.EMPTY_ARTIFACT_ICON,true);
         }
      }
   }

}