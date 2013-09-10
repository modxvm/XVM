package net.wg.gui.lobby.messengerBar.carousel.events 
{
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class ChannelListEvent extends scaleform.clik.events.ListEvent
    {
        public function ChannelListEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:int=-1, arg5:int=-1, arg6:int=-1, arg7:scaleform.clik.interfaces.IListItemRenderer=null, arg8:Object=null, arg9:uint=0, arg10:uint=0, arg11:Boolean=false)
        {
            super(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            return;
        }

        public static const OPEN_CHANNEL_CLICK:String="openChannelClick";

        public static const CLOSE_CHANNEL_CLICK:String="closeChannelClick";
    }
}
