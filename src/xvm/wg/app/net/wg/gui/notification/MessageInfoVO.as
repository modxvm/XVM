package net.wg.gui.notification
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class MessageInfoVO extends DAAPIDataClass
   {
          
      public function MessageInfoVO(param1:Object) {
         super(param1);
      }

      public var type:String = "";

      public var message:String = "";

      public var icon:String = "";

      public var defaultIcon:String = "";

      public var showMore:Object;

      private var _showMoreVO:MoreInfoVO;

      public var filters:Array;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "showMore")
         {
            this._showMoreVO = new MoreInfoVO(param2);
            this.showMore = param2;
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get showMoreVO() : MoreInfoVO {
         return this._showMoreVO;
      }
   }

}