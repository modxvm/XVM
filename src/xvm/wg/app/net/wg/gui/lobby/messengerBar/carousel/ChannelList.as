package net.wg.gui.lobby.messengerBar.carousel
{
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
   import flash.events.Event;
   import scaleform.gfx.MouseEventEx;


   public class ChannelList extends TileList
   {
          
      public function ChannelList() {
         super();
      }

      override protected function setupRenderer(param1:IListItemRenderer) : void {
         super.setupRenderer(param1);
         var _loc2_:ChannelRenderer = param1 as ChannelRenderer;
         _loc2_.openButton.addEventListener(ButtonEvent.CLICK,this.onItemOpenClick);
         _loc2_.closeButton.addEventListener(ButtonEvent.CLICK,this.onItemCloseClick);
      }

      override protected function cleanUpRenderer(param1:IListItemRenderer) : void {
         super.cleanUpRenderer(param1);
         var _loc2_:ChannelRenderer = param1 as ChannelRenderer;
         _loc2_.openButton.removeEventListener(ButtonEvent.CLICK,this.onItemOpenClick);
         _loc2_.closeButton.removeEventListener(ButtonEvent.CLICK,this.onItemCloseClick);
      }

      private function onItemOpenClick(param1:ButtonEvent) : void {
         dispatchEvent(this.generateEvent(ChannelListEvent.OPEN_CHANNEL_CLICK,param1));
      }

      private function onItemCloseClick(param1:ButtonEvent) : void {
         dispatchEvent(this.generateEvent(ChannelListEvent.CLOSE_CHANNEL_CLICK,param1));
      }

      private function generateEvent(param1:String, param2:Event) : ChannelListEvent {
         var _loc3_:IListItemRenderer = param2.currentTarget.parent as IListItemRenderer;
         var _loc4_:uint = 0;
         if(param2  is  ButtonEvent)
         {
            _loc4_ = (param2 as ButtonEvent).controllerIdx;
         }
         else
         {
            if(param2  is  MouseEventEx)
            {
               _loc4_ = (param2 as MouseEventEx).mouseIdx;
            }
         }
         var _loc5_:uint = 0;
         if(param2  is  ButtonEvent)
         {
            _loc5_ = (param2 as ButtonEvent).buttonIdx;
         }
         else
         {
            if(param2  is  MouseEventEx)
            {
               _loc5_ = (param2 as MouseEventEx).buttonIdx;
            }
         }
         var _loc6_:* = false;
         if(param2  is  ButtonEvent)
         {
            _loc6_ = (param2 as ButtonEvent).isKeyboard;
         }
         var _loc7_:ChannelListEvent = new ChannelListEvent(param1,false,true,_loc3_.index,0,_loc3_.index,_loc3_,dataProvider.requestItemAt(_loc3_.index),_loc4_,_loc5_,_loc6_);
         return _loc7_;
      }
   }

}