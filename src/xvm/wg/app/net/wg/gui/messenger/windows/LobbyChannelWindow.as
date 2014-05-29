package net.wg.gui.messenger.windows
{
   import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;
   import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.display.Sprite;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.utils.Constraints;
   import flash.events.Event;
   import net.wg.gui.events.ListEventEx;
   import flash.display.DisplayObject;
   import net.wg.gui.messenger.data.ChannelMemberVO;
   import scaleform.gfx.MouseEventEx;
   import net.wg.data.components.ContextItemGenerator;


   public class LobbyChannelWindow extends LobbyChannelWindowMeta implements ILobbyChannelWindowMeta
   {
          
      public function LobbyChannelWindow() {
         super();
         this._membersDP = new DAAPIDataProvider();
      }

      private static const INVALID_LIST_VISIBILITY:String = "invalidListVisibility";

      public var membersList:ScrollingListEx;

      public var background:Sprite;

      protected var _membersDP:DAAPIDataProvider;

      private var _needToHideList:Boolean = false;

      public function as_getMembersDP() : Object {
         return this._membersDP;
      }

      public function as_hideMembersList() : void {
         this._needToHideList = true;
         invalidate(INVALID_LIST_VISIBILITY);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.contentPadding = new Padding(38,10,11,10);
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }

      override protected function configUI() : void {
         super.configUI();
         constraints.addElement("background",this.background,Constraints.ALL);
         constraints.addElement("membersList",this.membersList,Constraints.RIGHT | Constraints.TOP | Constraints.BOTTOM);
         this._membersDP.addEventListener(Event.CHANGE,this.onMembersDPChange);
         this.membersList.sbPadding = new Padding(0,0,0,0);
         this.membersList.addEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClick);
         this.membersList.dataProvider = this._membersDP;
      }

      override protected function draw() : void {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         if((isInvalid(INVALID_LIST_VISIBILITY)) && (this._needToHideList))
         {
            this._needToHideList = false;
            this.membersList.visible = false;
            _loc1_ = channelComponent.messageArea;
            _loc2_ = channelComponent.sendButton;
            _loc1_.width = _loc2_.x + _loc2_.width - _loc1_.x * 2;
            this.background.width = _loc2_.x + _loc2_.width;
            constraints.removeElement("background");
            constraints.removeElement("messageArea");
            constraints.addElement("background",this.background,Constraints.ALL);
            constraints.addElement("messageArea",channelComponent.messageArea,Constraints.ALL);
         }
         super.draw();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this._membersDP.removeEventListener(Event.CHANGE,this.onMembersDPChange);
         this.membersList.removeEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClick);
         this.membersList.disposeRenderers();
         this._membersDP.cleanUp();
         this._membersDP = null;
      }

      private function onMembersDPChange(param1:Event) : void {
          
      }

      private function onMemberItemClick(param1:ListEventEx) : void {
         var _loc2_:ChannelMemberVO = null;
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            _loc2_ = new ChannelMemberVO(param1.itemData);
            App.contextMenuMgr.showUserContextMenu(this,_loc2_,new ContextItemGenerator());
         }
      }
   }

}