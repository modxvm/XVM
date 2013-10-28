package net.wg.gui.lobby.customization
{
   import flash.text.TextField;
   import flash.events.Event;


   public class CamouflageGroupView extends BaseTimedCustomizationGroupView
   {
          
      public function CamouflageGroupView() {
         super();
      }

      public var hintLabel:TextField;

      private var defaultLbl:String = "";

      public function setDefaultLabel(param1:String) : void {
         this.defaultLbl = param1;
         this.hintLabel.htmlText = this.defaultLbl;
      }

      override protected function handleItemDataChanged(param1:Event=null) : void {
         var _loc2_:Object = null;
         var _loc3_:CustomizationEvent = null;
         this.hintLabel.htmlText = this.defaultLbl;
         if(selectedItemIdx > -1)
         {
            _loc2_ = itemsDP.requestItemAt(selectedItemIdx);
            if((_loc2_) && (_loc2_.id) && selectedPriceIdx > -1)
            {
               _loc3_ = new CustomizationEvent(CustomizationEvent.SELECT_NEW);
               _loc3_.data = _loc2_;
               _loc3_.index = selectedItemIdx;
               dispatchEvent(_loc3_);
               this.hintLabel.htmlText = _loc2_.invisibilityLbl;
            }
         }
      }
   }

}