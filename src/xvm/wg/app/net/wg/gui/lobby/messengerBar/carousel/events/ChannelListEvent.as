package net.wg.gui.lobby.messengerBar.carousel.events
{
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;


   public class ChannelListEvent extends ListEvent
   {
          
      public function ChannelListEvent(param1:String, param2:Boolean=false, param3:Boolean=true, param4:int=undefined, param5:int=undefined, param6:int=undefined, param7:IListItemRenderer=null, param8:Object=null, param9:uint=undefined, param10:uint=undefined, param11:Boolean=false) {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }

      public static const OPEN_CHANNEL_CLICK:String = "openChannelClick";

      public static const CLOSE_CHANNEL_CLICK:String = "closeChannelClick";
   }

}