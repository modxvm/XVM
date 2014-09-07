package net.wg.gui.rally.views.room
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.rally.controls.CandidatesScrollingList;
    import net.wg.data.VoDAAPIDataProvider;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import flash.events.MouseEvent;
    import net.wg.gui.events.ListEventEx;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.VO.ExtendedUserVO;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.rally.helpers.PlayerCIGenerator;
    
    public class BaseWaitListSection extends UIComponent
    {
        
        public function BaseWaitListSection()
        {
            super();
            this.initializeDP();
        }
        
        public var lblCandidatesHeader:TextField;
        
        public var btnInviteFriend:SoundButtonEx;
        
        public var candidates:CandidatesScrollingList;
        
        protected var candidatesDP:VoDAAPIDataProvider;
        
        protected var _rallyData:IRallyVO;
        
        protected function initializeDP() : void
        {
        }
        
        protected function updateControls() : void
        {
        }
        
        protected function onControlRollOver(param1:MouseEvent) : void
        {
        }
        
        public function updateRallyStatus(param1:Boolean, param2:String) : void
        {
            this._rallyData.statusLbl = param2;
            this._rallyData.statusValue = param1;
            this.updateControls();
        }
        
        public function get rallyData() : IRallyVO
        {
            return this._rallyData;
        }
        
        public function set rallyData(param1:IRallyVO) : void
        {
            this._rallyData = param1;
            invalidateData();
        }
        
        public function getCandidatesDP() : VoDAAPIDataProvider
        {
            return this.candidatesDP;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            if(this.candidates)
            {
                this.candidates.dataProvider = this.candidatesDP;
                this.candidates.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
            }
            if(this.btnInviteFriend)
            {
                this.btnInviteFriend.addEventListener(ButtonEvent.CLICK,this.onInviteFriendClickHandler);
                this.btnInviteFriend.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                this.btnInviteFriend.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            }
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._rallyData?this._rallyData.isCommander:false;
                this.btnInviteFriend.visible = _loc1_;
                if(_loc1_)
                {
                    this.updateControls();
                }
            }
        }
        
        override protected function onDispose() : void
        {
            if(this.btnInviteFriend)
            {
                this.btnInviteFriend.removeEventListener(ButtonEvent.CLICK,this.onInviteFriendClickHandler);
                this.btnInviteFriend.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                this.btnInviteFriend.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                this.btnInviteFriend.dispose();
                this.btnInviteFriend = null;
            }
            if(this.candidates)
            {
                this.candidates.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
                this.candidates.dispose();
                this.candidates = null;
            }
            if(this._rallyData)
            {
                this._rallyData.dispose();
                this._rallyData = null;
            }
            this.candidatesDP = null;
            super.onDispose();
        }
        
        protected function onInviteFriendClick() : void
        {
        }
        
        private function onInviteFriendClickHandler(param1:ButtonEvent) : void
        {
            this.onInviteFriendClick();
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.INVITE_FRIEND_REQUEST));
        }
        
        protected function onListItemClick(param1:ListEventEx) : void
        {
            var _loc2_:ExtendedUserVO = param1.itemData as ExtendedUserVO;
            if((param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) && (_loc2_) && !_loc2_.himself)
            {
                App.contextMenuMgr.showUserContextMenu(this,_loc2_,new PlayerCIGenerator(this._rallyData.isCommander));
            }
        }
        
        protected function onControlRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
