package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import net.wg.gui.events.StateManagerEvent;
   import scaleform.clik.events.ComponentEvent;
   import net.wg.data.constants.SoundTypes;


   public class FightListItemRenderer extends SoundListItemRenderer
   {
          
      public function FightListItemRenderer() {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
      }

      protected function setup() : void {
         this.textField.text = data.label;
         this.enabled = !data.disabled;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress,false,0,true);
      }

      private function onMouseOverHdlr(param1:MouseEvent) : void {
          
      }

      protected function onMouseOver(param1:MouseEvent) : void {
         if(data.tooltip)
         {
            App.toolTipMgr.showComplex(this.data.tooltip);
         }
      }

      protected function onMouseOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      protected function onMousePress(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      override public function setData(param1:Object) : void {
         super.setData(param1);
         this.setup();
      }

      override protected function updateAfterStateChange() : void {
         if(!initialized)
         {
            return;
         }
         this.setup();
         dispatchEvent(new StateManagerEvent(ComponentEvent.STATE_CHANGE,state));
      }
   }

}