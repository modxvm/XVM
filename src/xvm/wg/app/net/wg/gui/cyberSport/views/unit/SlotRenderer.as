package net.wg.gui.cyberSport.views.unit
{
   import net.wg.gui.rally.controls.RallySlotRenderer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.rally.vo.RallySlotVO;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;


   public class SlotRenderer extends RallySlotRenderer
   {
          
      public function SlotRenderer() {
         super();
      }

      public var lockBackground:Sprite;

      public var ratingTF:TextField;

      public var levelLbl:TextField;

      public function get unitSlotData() : RallySlotVO {
         return slotData as RallySlotVO;
      }

      override protected function onRemoveClick(param1:ButtonEvent) : void {
         if(this.unitSlotData)
         {
            if(this.unitSlotData.player)
            {
               super.onRemoveClick(param1);
            }
            else
            {
               if(index > 4)
               {
                  dispatchEvent(new CSComponentEvent(CSComponentEvent.LOCK_SLOT_REQUEST,index));
               }
            }
         }
      }
   }

}