package net.wg.gui.historicalBattles
{
    import net.wg.infrastructure.base.meta.impl.HistoricalBattlesListWindowMeta;
    import net.wg.infrastructure.base.meta.IHistoricalBattlesListWindowMeta;
    import net.wg.gui.historicalBattles.controls.BattlesCarousel;
    import net.wg.gui.historicalBattles.controls.TeamsVehicleList;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.cyberSport.controls.GrayButtonText;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.historicalBattles.data.HistoricalBattleVO;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.historicalBattles.events.TeamsVehicleListEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.historicalBattles.data.BattleListItemVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import scaleform.clik.data.DataProvider;
    
    public class HistoricalBattlesListWindow extends HistoricalBattlesListWindowMeta implements IHistoricalBattlesListWindowMeta
    {
        
        public function HistoricalBattlesListWindow() {
            super();
            canMinimize = true;
        }
        
        private static var DESCRIPTION_BUTTON_OFFSET:Number = 24;
        
        private static var DESCRIPTION_MAX_HEIGHT:Number = 180;
        
        private static var RIGHT_MARGIN:Number = 990;
        
        public var carousel:BattlesCarousel;
        
        public var teamsVehicleList:TeamsVehicleList;
        
        public var mapImage:UILoaderAlt;
        
        public var showFullDescrButton:GrayButtonText;
        
        public var priceDD:DropdownMenu;
        
        public var priceInfoIcon:MovieClip;
        
        public var fightButton:SoundButtonEx;
        
        public var fightButtonWarnIco:Sprite;
        
        public var headerTF:TextField;
        
        public var dateTF:TextField;
        
        public var timerTF:TextField;
        
        public var statusTF:TextField;
        
        public var descriptionTitleTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var teamBTF:TextField;
        
        public var teamATF:TextField;
        
        public var mapNameTF:TextField;
        
        public var mapInfoTF:TextField;
        
        public var priceInfoTF:TextField;
        
        public var remainingTimeTF:TextField;
        
        private var model:HistoricalBattleVO;
        
        private var selectedVehicleID:int = -1;
        
        private var vehicleIDFromPy:int = -1;
        
        private var selectedBattleID:int = -1;
        
        private var fbTTHeader:String = "";
        
        private var fbTTBody:String = "";
        
        private var dateTTHeader:String = "";
        
        private var dateTTBody:String = "";
        
        private var _listEnabled:Boolean = true;
        
        private var _priceDDEnabled:Boolean = true;
        
        override protected function configUI() : void {
            super.configUI();
            this.descriptionTitleTF.text = HISTORICAL_BATTLES.LABEL_DESCRIPTIONTITLE;
            this.priceInfoIcon.visible = false;
            this.carousel.addEventListener(ListEvent.INDEX_CHANGE,this.onCarouselItemSelect);
            this.showFullDescrButton.addEventListener(ButtonEvent.CLICK,this.onShowFullDescrClick);
            this.fightButton.addEventListener(ButtonEvent.CLICK,this.onFightButtonClick);
            this.teamsVehicleList.addEventListener(TeamsVehicleListEvent.VEHICLE_SELECTED,this.onVehicleChanged);
            this.priceDD.addEventListener(ListEvent.INDEX_CHANGE,this.onPriceItemSelect);
            this.fightButton.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.mapImage.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.priceInfoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.dateTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.timerTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.fightButton.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.mapImage.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.priceInfoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.dateTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.timerTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.updateCarouselSelection();
        }
        
        private function onPriceItemSelect(param1:ListEvent) : void {
            onPriceSelectedS(this.priceDD.selectedIndex);
        }
        
        private function onVehicleChanged(param1:TeamsVehicleListEvent) : void {
            this.selectedVehicleID = param1.vehicleID;
            this.updatePriceInfoIcon();
            onVehicleSelectedS(param1.vehicleID != -1?this.selectedVehicleID:this.vehicleIDFromPy);
        }
        
        private function onFightButtonClick(param1:ButtonEvent) : void {
            requestToEnqueueS();
        }
        
        private function onShowFullDescrClick(param1:ButtonEvent) : void {
            showFullDescriptionS();
        }
        
        private function onCarouselItemSelect(param1:ListEvent) : void {
            var _loc2_:BattleListItemVO = param1.itemData as BattleListItemVO;
            this.selectedBattleID = _loc2_.id;
            onBattleSelectedS(this.selectedBattleID);
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.model))
            {
                this.headerTF.text = this.model.name;
                this.descriptionTF.htmlText = this.model.descriptionText;
                this.mapNameTF.text = this.model.mapName;
                this.mapInfoTF.htmlText = this.model.mapInfo;
                this.mapImage.source = this.model.mapImage;
                this.teamATF.text = this.model.sideA?this.model.sideA:HISTORICAL_BATTLES.LABEL_TEAMA;
                this.teamBTF.text = this.model.sideB?this.model.sideB:HISTORICAL_BATTLES.LABEL_TEAMB;
                this.remainingTimeTF.visible = this.model.isFuture;
                this.priceInfoTF.visible = !this.model.isFuture;
                this.priceDD.visible = !this.model.isFuture;
                this.showFullDescrButton.visible = Boolean(this.model.descriptionURL);
                this.updatePriceInfoIcon();
                this.updateListEnabled();
                this.descriptionTF.height = Math.min(this.descriptionTF.textHeight + 5,DESCRIPTION_MAX_HEIGHT);
                this.showFullDescrButton.y = this.descriptionTF.y + this.descriptionTF.height + DESCRIPTION_BUTTON_OFFSET;
            }
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = HISTORICAL_BATTLES.WINDOW_MAIN_TITLE;
        }
        
        override public function handleInput(param1:InputEvent) : void {
            if(param1.handled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                if(window.getCloseBtn().enabled)
                {
                    param1.handled = true;
                    onWindowCloseS();
                }
            }
            else
            {
                super.handleInput(param1);
            }
        }
        
        override protected function onDispose() : void {
            this.disposeModel();
            this.fightButton.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.mapImage.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.priceInfoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.dateTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.timerTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.fightButton.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.mapImage.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.priceInfoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.dateTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.timerTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.carousel.removeEventListener(ListEvent.INDEX_CHANGE,this.onCarouselItemSelect);
            this.carousel.dispose();
            this.carousel = null;
            this.teamsVehicleList.removeEventListener(TeamsVehicleListEvent.VEHICLE_SELECTED,this.onVehicleChanged);
            this.teamsVehicleList.dispose();
            this.teamsVehicleList = null;
            this.showFullDescrButton.removeEventListener(ButtonEvent.CLICK,this.onShowFullDescrClick);
            this.showFullDescrButton.dispose();
            this.showFullDescrButton = null;
            this.fightButton.removeEventListener(ButtonEvent.CLICK,this.onFightButtonClick);
            this.fightButton.dispose();
            this.fightButton = null;
            this.priceDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onPriceItemSelect);
            this.priceDD.dispose();
            this.priceDD = null;
            this.mapImage.dispose();
            this.mapImage = null;
            super.onDispose();
        }
        
        private function disposeCarouselDP() : void {
            if(this.carousel.dataProvider)
            {
                this.carousel.dataProvider.cleanUp();
                this.carousel.dataProvider = null;
            }
        }
        
        private function disposeModel() : void {
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        private function updatePriceInfoIcon() : void {
            if(this.model)
            {
                this.priceInfoIcon.visible = !this.model.isFuture && !(this.selectedVehicleID == -1);
            }
            else
            {
                this.priceInfoIcon.visible = false;
            }
        }
        
        private function updateListEnabled() : void {
            this.teamsVehicleList.selectable = this.model?!this.model.isFuture && (this._listEnabled):false;
        }
        
        private function updatePriceDDEnabled() : void {
            this.priceDD.enabled = !(this.selectedVehicleID == -1) && (this._priceDDEnabled);
        }
        
        private function onControlRollOut(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function onControlRollOver(param1:MouseEvent) : void {
            switch(param1.currentTarget)
            {
                case this.fightButton:
                    this.showComplexTT(this.fbTTHeader,this.fbTTBody);
                    break;
                case this.mapImage:
                    App.toolTipMgr.showSpecial(Tooltips.MAP,null,this.model.arenaID);
                    break;
                case this.priceInfoIcon:
                    App.toolTipMgr.showSpecial(Tooltips.HISTORICAL_AMMO,null,this.model.id,this.selectedVehicleID);
                    break;
                case this.dateTF:
                case this.timerTF:
                    this.showComplexTT(this.dateTTHeader,this.dateTTBody);
                    break;
            }
        }
        
        private function showComplexTT(param1:String, param2:String = "") : void {
            var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).make();
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
        
        private function updateCarouselSelection() : void {
            var _loc2_:BattleListItemVO = null;
            var _loc3_:* = 0;
            var _loc1_:* = -1;
            for each(_loc2_ in this.carousel.dataProvider)
            {
                if(_loc2_.id == this.selectedBattleID)
                {
                    _loc1_ = this.carousel.dataProvider.indexOf(_loc2_);
                    break;
                }
            }
            _loc3_ = this.carousel.selectedIndex;
            if(_loc1_ > -1)
            {
                this.carousel.selectedIndex = _loc1_;
            }
            else if(this.carousel.dataProvider.length > 0)
            {
                this.carousel.selectedIndex = 0;
            }
            
            if(_loc3_ == this.carousel.selectedIndex)
            {
                this.selectedBattleID = BattleListItemVO(this.carousel.dataProvider.requestItemAt(this.carousel.selectedIndex)).id;
                onBattleSelectedS(this.selectedBattleID);
            }
        }
        
        override public function as_getGeometry() : Array {
            if(window)
            {
                return [window.x,window.y,-1,-1];
            }
            return null;
        }
        
        public function as_setCarouselData(param1:Array) : void {
            var _loc2_:BattleListItemVO = null;
            this.disposeCarouselDP();
            var _loc3_:Array = [];
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc2_ = new BattleListItemVO(param1[_loc4_]);
                _loc3_.push(_loc2_);
                _loc4_++;
            }
            this.carousel.dataProvider = new DataProvider(_loc3_);
            if(initialized)
            {
                this.updateCarouselSelection();
            }
        }
        
        public function as_setBattleData(param1:Object) : void {
            this.disposeModel();
            this.model = new HistoricalBattleVO(param1);
            invalidateData();
        }
        
        public function as_setTeamsData(param1:Array, param2:Array) : void {
            var _loc3_:* = false;
            this.teamsVehicleList.setTeamsData(param1,param2);
            if(!this.model.isFuture)
            {
                _loc3_ = this.teamsVehicleList.selectVehicleByCD(this.selectedVehicleID);
                if(!_loc3_)
                {
                    this.vehicleIDFromPy = -1;
                }
            }
            else
            {
                this.teamsVehicleList.selectVehicleByCD(-1);
            }
        }
        
        public function as_setStatusMessage(param1:String) : void {
            this.statusTF.htmlText = param1;
        }
        
        public function as_selectVehicle(param1:Number) : void {
            var _loc2_:* = false;
            this.vehicleIDFromPy = param1;
            if((this.model) && !this.model.isFuture)
            {
                _loc2_ = this.teamsVehicleList.selectVehicleByCD(param1);
                if(!_loc2_ && this.selectedVehicleID == -1)
                {
                    onVehicleSelectedS(this.vehicleIDFromPy);
                }
            }
            else
            {
                onVehicleSelectedS(this.vehicleIDFromPy);
            }
        }
        
        public function as_setPrices(param1:Array, param2:Number) : void {
            this.priceDD.dataProvider = new DataProvider(param1);
            this.priceDD.selectedIndex = param2;
            this.updatePriceDDEnabled();
        }
        
        public function as_setPriceInfo(param1:String) : void {
            this.priceInfoTF.htmlText = param1;
        }
        
        public function as_updateFightButton(param1:Boolean, param2:String, param3:String, param4:Boolean) : void {
            this.fightButton.enabled = param1;
            this.fightButtonWarnIco.visible = param4;
            this.fbTTHeader = param2;
            this.fbTTBody = param3;
        }
        
        override public function as_enableEnqueueBtn(param1:Boolean) : void {
            this.fightButton.enabled = param1;
        }
        
        override public function as_enableLeaveBtn(param1:Boolean) : void {
        }
        
        public function as_setCarouselEnabled(param1:Boolean) : void {
            this.carousel.enabled = param1;
        }
        
        public function as_setListEnabled(param1:Boolean) : void {
            this._listEnabled = param1;
            this.updateListEnabled();
        }
        
        public function as_setPriceDDEnabled(param1:Boolean) : void {
            this._priceDDEnabled = param1;
            this.updatePriceDDEnabled();
        }
        
        public function as_setCloseBtnEnabled(param1:Boolean) : void {
            enabledCloseBtn = param1;
        }
        
        public function as_selectBattle(param1:Number) : void {
            this.selectedBattleID = param1;
            if(initialized)
            {
                this.updateCarouselSelection();
            }
        }
        
        public function as_setDate(param1:String, param2:String, param3:String) : void {
            this.dateTF.htmlText = param1;
            this.dateTF.width = this.dateTF.textWidth;
            this.dateTF.x = RIGHT_MARGIN - this.dateTF.width;
            this.dateTTHeader = param2;
            this.dateTTBody = param3;
        }
        
        public function as_updateTimer(param1:String, param2:String) : void {
            this.timerTF.htmlText = param1;
            this.timerTF.width = this.timerTF.textWidth;
            this.timerTF.x = RIGHT_MARGIN - this.timerTF.width;
            this.timerTF.visible = (param1) && param1.length > 0;
            this.remainingTimeTF.htmlText = param2;
        }
    }
}
