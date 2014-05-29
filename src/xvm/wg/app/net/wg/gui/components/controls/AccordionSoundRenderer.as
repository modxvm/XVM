package net.wg.gui.components.controls
{
   import net.wg.infrastructure.interfaces.IAccordionItemRenderer;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.components.AccordionRendererData;
   import flash.events.MouseEvent;
   import net.wg.gui.events.AccordionRendererEvent;


   public class AccordionSoundRenderer extends SoundListItemRenderer implements IAccordionItemRenderer
   {
          
      public function AccordionSoundRenderer() {
         super();
         focusable = false;
         toggle = false;
      }

      private var _enableConstraints:Boolean = false;

      public function set enableConstraints(param1:Boolean) : void {
         this._enableConstraints = param1;
      }

      override protected function configUI() : void {
         soundType = SoundTypes.ACCORDION;
         constraintsDisabled = !this._enableConstraints;
         super.configUI();
      }

      override public function set data(param1:Object) : void {
         var _loc2_:AccordionRendererData = param1 as AccordionRendererData;
         if(_loc2_)
         {
            this.enabled = _loc2_.enabled;
            label = _loc2_.label;
         }
         super.data = param1;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.buttonMode = param1;
         mouseEnabled = true;
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         dispatchEvent(new AccordionRendererEvent(AccordionRendererEvent.ACCORDION_RENDERER_ROLL_OVER));
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         dispatchEvent(new AccordionRendererEvent(AccordionRendererEvent.ACCORDION_RENDERER_ROLL_OUT));
      }
   }

}