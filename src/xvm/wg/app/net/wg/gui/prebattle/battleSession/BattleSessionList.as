package net.wg.gui.prebattle.battleSession
{
   import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
   import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.display.MovieClip;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.events.ListEventEx;
   import net.wg.data.Aliases;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;


   public class BattleSessionList extends BattleSessionListMeta implements IBattleSessionListMeta
   {
          
      public function BattleSessionList() {
         super();
         showWindowBg = false;
         canMinimize = true;
         enabledCloseBtn = false;
         canResize = true;
         isCentered = false;
      }

      public var channelComponent:ChannelComponent;

      public var groupsScrollBar:ScrollBar;

      public var groupsList:ScrollingListEx;

      public var groupListBG:MovieClip;

      override public function setFocus() : void {
         super.setFocus();
         if(this.channelComponent)
         {
            this.channelComponent.setFocusToInput();
         }
      }

      public function as_refreshList(param1:Array) : void {
         this.groupsList.dataProvider = new DataProvider(param1);
      }

      override protected function configUI() : void {
         super.configUI();
         this.groupsList.addEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
         this.setConstraints();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.groupsList.removeEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         registerComponent(this.channelComponent,Aliases.CHANNEL_COMPONENT);
         window.setTitleIcon("teamList");
         window.title = CHAT.CHANNELS_SPECIAL_BATTLES;
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }

      override protected function draw() : void {
         super.draw();
      }

      private function setConstraints() : void {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("messageArea",this.channelComponent.messageArea,Constraints.ALL);
         constraints.addElement("messageInput",this.channelComponent.messageInput,Constraints.BOTTOM | Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("messageAreaScrollBar",this.channelComponent.messageAreaScrollBar,Constraints.TOP | Constraints.RIGHT);
         constraints.addElement("sendButton",this.channelComponent.sendButton,Constraints.BOTTOM | Constraints.RIGHT);
         constraints.addElement("groupsList",this.groupsList,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
         constraints.addElement("groupListBG",this.groupListBG,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
         constraints.addElement("groupsScrollBar",this.groupsScrollBar,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
      }

      private function handleTeamItemClick(param1:ListEventEx) : void {
         var _loc2_:BSListRendererVO = new BSListRendererVO(param1.itemData);
         requestToJoinTeamS(_loc2_.prbID,_loc2_.prbType);
      }
   }

}