package net.wg.gui.messenger.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class ChannelComponentMeta extends BaseDAAPIComponent
   {
          
      public function ChannelComponentMeta() {
         super();
      }

      public var isJoined:Function = null;

      public var sendMessage:Function = null;

      public var getHistory:Function = null;

      public var getMessageMaxLength:Function = null;

      public function isJoinedS() : Boolean {
         App.utils.asserter.assertNotNull(this.isJoined,"isJoined" + Errors.CANT_NULL);
         return this.isJoined();
      }

      public function sendMessageS(param1:String) : Boolean {
         App.utils.asserter.assertNotNull(this.sendMessage,"sendMessage" + Errors.CANT_NULL);
         return this.sendMessage(param1);
      }

      public function getHistoryS() : String {
         App.utils.asserter.assertNotNull(this.getHistory,"getHistory" + Errors.CANT_NULL);
         return this.getHistory();
      }

      public function getMessageMaxLengthS() : int {
         App.utils.asserter.assertNotNull(this.getMessageMaxLength,"getMessageMaxLength" + Errors.CANT_NULL);
         return this.getMessageMaxLength();
      }
   }

}