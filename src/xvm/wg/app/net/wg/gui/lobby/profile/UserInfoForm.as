package net.wg.gui.lobby.profile
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ClanEmblem;
   
   public class UserInfoForm extends UIComponent
   {
      
      public function UserInfoForm() {
         this.USER_INFO_FRAME = 
            {
               "CLAN":1,
               "NORMAL":2
            };
         super();
      }
      
      public var nameField:TextField;
      
      public var clanField:TextField;
      
      public var clanJoinDataField:TextField;
      
      public var clanPositionField:TextField;
      
      public var registrationDateLabel:TextField;
      
      public var registrationDateField:TextField;
      
      public var lastBattleDateLabel:TextField;
      
      public var lastBattleDateField:TextField;
      
      public var clanEmblem:ClanEmblem;
      
      private var _data:Object;
      
      private var dataUpdated:Boolean = false;
      
      private var USER_INFO_FRAME:Object;
      
      override protected function draw() : void {
         if(this.dataUpdated)
         {
            this.dataUpdated = false;
         }
      }
      
      public function setData(param1:Object) : void {
         if((param1) && !(param1 == this._data))
         {
            this._data = param1;
            this.dataUpdated = true;
            invalidate();
         }
      }
   }
}
