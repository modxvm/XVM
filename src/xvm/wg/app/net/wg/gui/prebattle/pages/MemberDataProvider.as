package net.wg.gui.prebattle.pages
{
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   
   public dynamic class MemberDataProvider extends DAAPIItemsDataProvider
   {
      
      public function MemberDataProvider(param1:Array = null) {
         super(param1);
      }
      
      private var _id:Number = -1;
      
      private var _prefix:String = "Messenger.ChannelMembers";
      
      public var _length:Number = 0;
   }
}
