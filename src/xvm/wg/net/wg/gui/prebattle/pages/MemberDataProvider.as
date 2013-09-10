package net.wg.gui.prebattle.pages 
{
    import net.wg.gui.lobby.customization.data.*;
    
    public dynamic class MemberDataProvider extends net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider
    {
        public function MemberDataProvider(arg1:Array=null)
        {
            super(arg1);
            return;
        }

        internal var _id:Number=-1;

        internal var _prefix:String="Messenger.ChannelMembers";

        public var _length:Number=0;
    }
}
