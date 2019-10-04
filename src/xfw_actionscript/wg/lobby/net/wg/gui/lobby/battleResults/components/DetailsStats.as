package net.wg.gui.lobby.battleResults.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
    import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.data.constants.ArenaBonusTypes;
    import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
    import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
    import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
    import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;

    public class DetailsStats extends UIComponentEx
    {

        private static const BLOCK_PADDING:int = 20;

        private static const EPIC_PADDING:int = 40;

        private static const FADED_ALPHA:Number = 0.25;

        private static const FULL_ALPHA:Number = 1;

        public var vehicleStats:VehicleDetails;

        public var vehicleTimeStats:VehicleDetails;

        public var statsTitle:TextField;

        public var creditsTitle:TextField;

        public var crystalTitle:TextField;

        public var timeTitle:TextField;

        public var xpTitle:TextField;

        public var premLbl:TextField;

        public var noPremLbl:TextField;

        public var xpHeader:MovieClip;

        public var resHeader:MovieClip;

        public var crystalHeader:MovieClip;

        public var resTitle:TextField;

        public var fakeBg:MovieClip;

        public var topHeaderBg:DisplayObject;

        public var xpDetails:TotalIncomeDetails;

        public var creditsDetails:IncomeDetailsBase;

        public var resDetails:IncomeDetailsBase;

        public var crystalDetails:IncomeDetailsBase;

        private var _data:BattleResultsVO = null;

        private var _showResourceBlock:Boolean;

        private var _showCrystalBlock:Boolean = false;

        private var _timeAndXpBlock:Vector.<DisplayObject>;

        private var _resourcesBlock:Vector.<DisplayObject>;

        private var _crystalBlock:Vector.<DisplayObject>;

        private var _pageHeight:Number;

        private var _selectedIndex:int = 0;

        private var _timeTextValue:String = "#battle_results:details/time";

        public function DetailsStats()
        {
            super();
            this._timeAndXpBlock = new <DisplayObject>[this.xpHeader,this.timeTitle,this.xpTitle,this.vehicleTimeStats,this.xpDetails];
            this._resourcesBlock = new <DisplayObject>[this.resHeader,this.resTitle,this.resDetails];
            this._crystalBlock = new <DisplayObject>[this.crystalHeader,this.crystalTitle,this.crystalDetails];
        }

        override protected function draw() : void
        {
            var _loc1_:PersonalDataVO = null;
            var _loc2_:DisplayObject = null;
            super.draw();
            if(this._data)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    _loc1_ = this._data.personal;
                    this.premLbl.alpha = _loc1_.isPremium || _loc1_.isPremiumPlus?FULL_ALPHA:FADED_ALPHA;
                    this.premLbl.text = _loc1_.isPremium?BATTLE_RESULTS.DETAILS_PREM:BATTLE_RESULTS.DETAILS_PREMPLUS;
                    this.noPremLbl.alpha = !_loc1_.isPremium && !_loc1_.isPremiumPlus?FULL_ALPHA:FADED_ALPHA;
                    for each(_loc2_ in this._resourcesBlock)
                    {
                        _loc2_.visible = this._showResourceBlock;
                    }
                    if(this._showResourceBlock)
                    {
                        this.resTitle.text = BATTLE_RESULTS.DETAILS_RESOURCE;
                    }
                    for each(_loc2_ in this._crystalBlock)
                    {
                        _loc2_.visible = this._showCrystalBlock;
                    }
                    if(this._showCrystalBlock)
                    {
                        this.crystalTitle.text = BATTLE_RESULTS.DETAILS_CRYSTAL;
                    }
                }
                this.updateHeight();
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.statsTitle.text = BATTLE_RESULTS.DETAILS_STATS;
            this.creditsTitle.text = BATTLE_RESULTS.DETAILS_CREDITS;
            this.timeTitle.text = this._timeTextValue;
            this.xpTitle.text = BATTLE_RESULTS.DETAILS_XP;
            this.premLbl.text = BATTLE_RESULTS.DETAILS_PREMPLUS;
            this.noPremLbl.text = BATTLE_RESULTS.DETAILS_NOPREM;
            this.vehicleStats.state = VehicleDetails.STATE_NORMAL;
            this.vehicleTimeStats.state = VehicleDetails.STATE_TIME;
            this.vehicleStats.addEventListener(Event.RESIZE,this.onVehicleStatsResizeHandler);
            dispatchEvent(new Event(Event.RESIZE));
        }

        override protected function onDispose() : void
        {
            this._crystalBlock.splice(0,this._crystalBlock.length);
            this._crystalBlock = null;
            this._timeAndXpBlock.splice(0,this._timeAndXpBlock.length);
            this._timeAndXpBlock = null;
            this._resourcesBlock.splice(0,this._resourcesBlock.length);
            this._resourcesBlock = null;
            this.vehicleStats.removeEventListener(Event.RESIZE,this.onVehicleStatsResizeHandler);
            this.vehicleStats.dispose();
            this.creditsDetails.dispose();
            this.vehicleTimeStats.dispose();
            this.xpDetails.dispose();
            this.resDetails.dispose();
            this.crystalDetails.dispose();
            this.crystalDetails = null;
            this.crystalTitle = null;
            this.crystalHeader = null;
            this.vehicleStats = null;
            this.vehicleTimeStats = null;
            this.xpDetails = null;
            this.resDetails = null;
            this.creditsDetails = null;
            this.statsTitle = null;
            this.creditsTitle = null;
            this.timeTitle = null;
            this.xpTitle = null;
            this.premLbl = null;
            this.noPremLbl = null;
            this.xpHeader = null;
            this.resHeader = null;
            this.resTitle = null;
            this.fakeBg = null;
            this.topHeaderBg = null;
            this._data = null;
            super.onDispose();
        }

        public function setBattleResultsVO(param1:BattleResultsVO) : void
        {
            if(this._data == param1)
            {
                return;
            }
            this._data = param1;
            var _loc2_:PersonalDataVO = this._data.personal;
            var _loc3_:CommonStatsVO = this._data.common;
            var _loc4_:Boolean = _loc2_.isPremium || _loc2_.isPremiumPlus;
            var _loc5_:Number = _loc4_?FADED_ALPHA:FULL_ALPHA;
            var _loc6_:Number = _loc4_?FULL_ALPHA:FADED_ALPHA;
            this.xpDetails.setColumnsAlpha(_loc5_,_loc6_);
            this.creditsDetails.setColumnsAlpha(_loc5_,_loc6_);
            var _loc7_:Number = _loc3_.bonusType;
            this._showResourceBlock = _loc7_ == ArenaBonusTypes.SORTIE && !_loc2_.isLegionnaire;
            var _loc8_:Vector.<Vector.<DetailedStatsItemVO>> = _loc2_.crystalData;
            var _loc9_:Vector.<DetailedStatsItemVO> = _loc8_ && _loc8_.length?_loc8_[0]:null;
            this._showCrystalBlock = _loc9_ && _loc9_.length;
            this.setSelectedVehicleIndex(this._selectedIndex);
            if(_loc3_.epicMode)
            {
                this._timeTextValue = BATTLE_RESULTS.DETAILS_TIME_EPIC;
                this.timeTitle.text = BATTLE_RESULTS.DETAILS_TIME_EPIC;
            }
            this.vehicleTimeStats.data = _loc3_.timeStats;
            if(_loc2_.isMultiplierInfoVisible)
            {
                this.xpDetails.setMultiplierInfoTooltips(_loc2_.multiplierTooltipStr,_loc2_.premiumMultiplierTooltipStr,_loc2_.multiplierLineIdxPos);
            }
            if(this._showResourceBlock)
            {
                this.resDetails.setColumnsAlpha(_loc5_,_loc6_);
                this.resDetails.setData(_loc2_.resourceData);
            }
            if(this._showCrystalBlock)
            {
                this.crystalDetails.setData(_loc9_);
            }
            invalidateData();
        }

        public function setPageHeight(param1:Number) : void
        {
            this._pageHeight = param1;
        }

        public function setSelectedVehicleIndex(param1:int) : void
        {
            var _loc2_:PersonalDataVO = null;
            this._selectedIndex = param1;
            if(this._data != null)
            {
                _loc2_ = this._data.personal;
                this.vehicleStats.data = _loc2_.statValues[param1];
                this.creditsDetails.setData(_loc2_.creditsData[param1]);
                this.xpDetails.setData(_loc2_.xpData[param1]);
                this.xpDetails.setVisibilityInfoIcon(param1 == 0 && _loc2_.isMultiplierInfoVisible);
            }
        }

        private function updateHeight() : void
        {
            var _loc2_:DisplayObject = null;
            var _loc1_:IStatsUtilsManager = StatsUtilsManager.getInstance();
            if(this._showCrystalBlock)
            {
                _loc1_.positionBlockBelow(this.creditsDetails,this.crystalHeader,this._crystalBlock,BLOCK_PADDING);
                _loc2_ = this.crystalDetails.y + this.crystalDetails.height > this.vehicleStats.height?this.crystalDetails:this.vehicleStats;
            }
            else
            {
                _loc2_ = this.creditsDetails.height > this.vehicleStats.height?this.creditsDetails:this.vehicleStats;
            }
            _loc1_.positionBlockBelow(_loc2_,this.xpHeader,this._timeAndXpBlock,BLOCK_PADDING);
            if(this._showResourceBlock)
            {
                _loc1_.positionBlockBelow(this.xpDetails,this.resHeader,this._resourcesBlock,BLOCK_PADDING);
                height = this.fakeBg.height = this.resDetails.y + this.resDetails.height + BLOCK_PADDING;
            }
            else if(this._data.common.epicMode)
            {
                height = this.fakeBg.height = this.xpDetails.y + this.xpDetails.height + EPIC_PADDING;
            }
            else
            {
                height = this.fakeBg.height = this.xpDetails.y + this.xpDetails.height;
            }
        }

        private function onVehicleStatsResizeHandler(param1:Event) : void
        {
            var _loc2_:Vector.<VehicleStatsVO> = null;
            var _loc3_:* = false;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(this._data != null)
            {
                _loc2_ = this._data.common.playerVehicles;
                _loc3_ = _loc2_ != null && _loc2_.length > 1;
                if(_loc3_)
                {
                    _loc4_ = this.vehicleStats.y + this.vehicleStats.height - this.xpHeader.y;
                    _loc5_ = this._pageHeight - (this.xpDetails.y + this.xpDetails.height + BLOCK_PADDING);
                    StatsUtilsManager.getInstance().shiftBlockVertically(Math.max(_loc5_,_loc4_),this._timeAndXpBlock);
                }
                this.updateHeight();
            }
        }
    }
}
