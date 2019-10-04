package net.wg.gui.lobby.battleResults.components
{
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UserNameField;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.ListEvent;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.interfaces.IUserProps;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
    import net.wg.infrastructure.events.FocusRequestEvent;

    public class TeamMemberStatsView extends TeamMemberStatsViewBase
    {

        private static const TEAM_KILLER_COLOR:uint = 647935;

        private static const NAME_COLOR:uint = 15856113;

        private static const STATS_DY:uint = 65;

        private static const INVALIDATE_CLOSE_BTN:String = "invalidateCloseBtn";

        private static const GAP_STATS_TO_BTN:uint = 20;

        private static const STATS_SCROLLPANE_WIDTH:uint = 470;

        public var list:ScrollingListEx = null;

        public var tankIcon:UILoaderAlt = null;

        public var tankFlag:MovieClip = null;

        public var playerNameLbl:UserNameField = null;

        public var vehicleName:TextField = null;

        public var vehicleStateLbl:TextField = null;

        public var statsScrollPane:ResizableScrollPane = null;

        public var closeBtn:SoundButtonEx = null;

        public var separator:MovieClip = null;

        public var myArea:MovieClip = null;

        public var deadBg:MovieClip = null;

        public var medalBg:MovieClip = null;

        public var selectVehicleTitle:TextField;

        public var selectVehicleDropdown:DropdownMenu;

        public var achievements:MedalsList = null;

        private var _initialStatsY:int = 0;

        private var _initialCloseBtnY:int = 0;

        private var _toolTip:String = null;

        private var _selectedVehicleIndex:int = 0;

        private var _isCloseBtnVisible:Boolean;

        private var _vehicleStats:VehicleDetails = null;

        public function TeamMemberStatsView()
        {
            var _loc1_:* = NaN;
            super();
            _loc1_ = scaleX;
            var _loc2_:Number = scaleY;
            scaleX = 1;
            scaleY = 1;
            this.initTargetScale(_loc1_,_loc2_);
        }

        override public function getComponentForFocus() : InteractiveObject
        {
            return this.list;
        }

        override public function invalidateMedalsListData() : void
        {
            this.achievements.invalidateData();
        }

        override public function setVehicleIdxInGarageDropdown(param1:int) : void
        {
            if(this._selectedVehicleIndex == param1)
            {
                return;
            }
            this._selectedVehicleIndex = param1;
            if(this.selectVehicleDropdown.dataProvider != null)
            {
                this.selectVehicleDropdown.selectedIndex = this._selectedVehicleIndex;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._vehicleStats = VehicleDetails(this.statsScrollPane.target);
            this.statsScrollPane.width = STATS_SCROLLPANE_WIDTH;
            this.selectVehicleTitle.text = BATTLE_RESULTS.SELECTVEHICLE;
            this._initialStatsY = this.statsScrollPane.y;
            this._initialCloseBtnY = this.closeBtn.y;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.selectVehicleDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onSelectVehicleDropdownIndexChangeHandler);
        }

        override protected function onDispose() : void
        {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleLabelRollOverHandler);
            this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleLabelRollOutHandler);
            this.vehicleStateLbl = null;
            this.selectVehicleTitle = null;
            this.selectVehicleDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onSelectVehicleDropdownIndexChangeHandler);
            this.selectVehicleDropdown.dispose();
            this.selectVehicleDropdown = null;
            this.list = null;
            this.tankIcon.dispose();
            this.tankIcon = null;
            this.tankFlag = null;
            this.separator = null;
            this.playerNameLbl.dispose();
            this.playerNameLbl = null;
            this.vehicleName = null;
            this._vehicleStats = null;
            this.statsScrollPane.dispose();
            this.statsScrollPane = null;
            this.myArea = null;
            this.deadBg = null;
            this.medalBg = null;
            this.achievements.dispose();
            this.achievements = null;
            this._toolTip = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = false;
            var _loc3_:IUserProps = null;
            var _loc4_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this._vehicleStats.state = VehicleDetails.STATE_WIDE;
                this.statsScrollPane.y = this._initialStatsY;
                this.closeBtn.y = this._initialCloseBtnY;
                this.achievements.visible = false;
                if(data)
                {
                    this.initVehicleSelection(data);
                    this.playerNameLbl.userVO = data.userVO;
                    this.vehicleName.htmlText = data.vehicleFullName;
                    this.vehicleName.textColor = this.playerNameLbl.textColor = data.isTeamKiller?TEAM_KILLER_COLOR:NAME_COLOR;
                    this.vehicleStateLbl.text = data.vehicleStateStr;
                    if(data.isPrematureLeave || data.killerID <= 0)
                    {
                        this.vehicleStateLbl.text = data.vehicleStateStr;
                    }
                    else if(data.killerID > 0)
                    {
                        _loc3_ = App.utils.commons.getUserProps(data.killerNameStr,data.killerClanNameStr,data.killerRegionNameStr);
                        _loc3_.prefix = data.vehicleStatePrefixStr;
                        _loc3_.suffix = data.vehicleStateSuffixStr;
                        _loc3_.isTeamKiller = data.isKilledByTeamKiller;
                        _loc4_ = App.utils.commons.formatPlayerName(this.vehicleStateLbl,_loc3_);
                        if(_loc4_)
                        {
                            this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleLabelRollOverHandler);
                            this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleLabelRollOutHandler);
                            this._toolTip = _loc3_.prefix + data.killerFullNameStr + _loc3_.suffix;
                        }
                        App.utils.commons.formatPlayerName(this.vehicleStateLbl,_loc3_);
                    }
                    this.applyVehicleData();
                    this.deadBg.visible = data.deathReason > Values.DEFAULT_INT;
                    _loc1_ = this._initialStatsY;
                    _loc2_ = data.medalsCount > 0;
                    this.medalBg.visible = _loc2_;
                    if(_loc2_)
                    {
                        _loc1_ = _loc1_ + STATS_DY;
                        this.achievements.visible = true;
                        this.achievements.dataProvider = data.achievements;
                        this.achievements.validateNow();
                    }
                    this.statsScrollPane.y = _loc1_;
                    this.statsScrollPane.height = this.closeBtn.y - GAP_STATS_TO_BTN - _loc1_;
                }
                else
                {
                    this.tankIcon.source = Values.EMPTY_STR;
                    this.tankFlag.visible = false;
                    this.playerNameLbl.userVO = null;
                    this.vehicleName.text = Values.EMPTY_STR;
                    this.vehicleStateLbl.text = Values.EMPTY_STR;
                    this._vehicleStats.data = null;
                    this.deadBg.visible = false;
                    this.medalBg.visible = false;
                    this.separator.visible = false;
                }
            }
            if(isInvalid(INVALIDATE_CLOSE_BTN))
            {
                this.closeBtn.visible = this._isCloseBtnVisible;
            }
        }

        private function initTargetScale(param1:Number, param2:Number) : void
        {
            hitArea.scaleX = param1;
            hitArea.scaleY = param2;
            this.deadBg.scaleX = param1;
            this.medalBg.scaleX = param1;
            this.closeBtn.x = this.closeBtn.x * param1 | 0;
            this.statsScrollPane.x = this.statsScrollPane.x * param1 | 0;
        }

        private function initVehicleSelection(param1:TeamMemberItemVO) : void
        {
            var _loc3_:* = false;
            var _loc2_:Array = param1.vehicles;
            _loc3_ = _loc2_.length > 1;
            this.selectVehicleTitle.visible = _loc3_;
            this.selectVehicleDropdown.visible = _loc3_;
            this.vehicleStateLbl.visible = !_loc3_;
            this.vehicleName.visible = !_loc3_;
            if(_loc3_)
            {
                this.selectVehicleDropdown.dataProvider = new DataProvider(_loc2_);
                this.selectVehicleDropdown.selectedIndex = this._selectedVehicleIndex;
            }
        }

        private function applyVehicleData() : void
        {
            var _loc1_:VehicleItemVO = null;
            var _loc2_:String = null;
            if(this._selectedVehicleIndex < data.statValues.length)
            {
                this._vehicleStats.data = data.statValues[this._selectedVehicleIndex];
                _loc1_ = VehicleItemVO(data.vehicles[this._selectedVehicleIndex]);
                this.tankIcon.source = _loc1_.icon;
                _loc2_ = _loc1_.flag;
                this.tankFlag.visible = _loc2_.length > 0;
                if(_loc2_ != null)
                {
                    this.tankFlag.gotoAndStop(_loc2_);
                }
            }
        }

        override public function get isCloseBtnVisible() : Boolean
        {
            return this._isCloseBtnVisible;
        }

        override public function set isCloseBtnVisible(param1:Boolean) : void
        {
            if(this._isCloseBtnVisible == param1)
            {
                return;
            }
            this._isCloseBtnVisible = param1;
            invalidate(INVALIDATE_CLOSE_BTN);
        }

        private function onVehicleLabelRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(this._toolTip);
        }

        private function onVehicleLabelRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onSelectVehicleDropdownIndexChangeHandler(param1:ListEvent) : void
        {
            this._selectedVehicleIndex = param1.index;
            if(data != null)
            {
                this.applyVehicleData();
            }
        }

        private function onCloseButtonClickHandler(param1:ButtonEvent) : void
        {
            this.list.selectedIndex = -1;
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
    }
}
