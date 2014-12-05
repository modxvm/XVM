package net.wg.gui.prebattle.battleSession
{
    import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
    import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.MovieClip;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.data.DataProvider;
    import flash.display.InteractiveObject;
    import net.wg.gui.events.ListEventEx;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.events.MessengerBarEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    
    public class BattleSessionList extends BattleSessionListMeta implements IBattleSessionListMeta
    {
        
        public function BattleSessionList()
        {
            this.contentPadding = new Padding(38,13,8,13);
            super();
            showWindowBgForm = false;
            canMinimize = true;
            enabledCloseBtn = false;
            isCentered = false;
        }
        
        public var groupsScrollBar:ScrollBar;
        
        public var groupsList:ScrollingListEx;
        
        public var groupListBG:MovieClip;
        
        private var contentPadding:Padding;
        
        public function as_refreshList(param1:Array) : void
        {
            this.groupsList.dataProvider = new DataProvider(param1);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.groupsList.addEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
            this.setConstraints();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.groupsList.removeEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
            removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            window.setTitleIcon("teamList");
            window.title = CHAT.CHANNELS_SPECIAL_BATTLES;
            geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override public function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var param3:Number = this.groupListBG.width + this.contentPadding.left + this.contentPadding.right;
            var param4:Number = this.groupListBG.height + this.contentPadding.top + this.contentPadding.bottom;
            super.as_setGeometry(param1,param2,param3,param4);
        }
        
        private function setConstraints() : void
        {
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement("groupsList",this.groupsList,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement("groupListBG",this.groupListBG,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement("groupsScrollBar",this.groupsScrollBar,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
        }
        
        private function onRequestFocusHandler(param1:FocusRequestEvent) : void
        {
            setFocus(param1.focusContainer.getComponentForFocus());
        }
        
        private function handleTeamItemClick(param1:ListEventEx) : void
        {
            var _loc2_:BSListRendererVO = new BSListRendererVO(param1.itemData);
            requestToJoinTeamS(_loc2_.prbID,_loc2_.prbType);
        }
    }
}
