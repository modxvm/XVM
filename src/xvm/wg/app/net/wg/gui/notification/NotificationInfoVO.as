package net.wg.gui.notification
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class NotificationInfoVO extends DAAPIDataClass
   {
          
      public function NotificationInfoVO(param1:Object) {
         super(param1);
      }

      public var message:Object;

      private var _messageVO:MessageInfoVO;

      public var priority:Boolean;

      public var auxData:Array;

      public var notify:Boolean;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "message")
         {
            this._messageVO = new MessageInfoVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get messageVO() : MessageInfoVO {
         return this._messageVO;
      }
   }

}