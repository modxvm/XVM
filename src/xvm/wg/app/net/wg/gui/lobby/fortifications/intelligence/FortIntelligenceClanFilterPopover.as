package net.wg.gui.lobby.fortifications.intelligence
{
    import net.wg.infrastructure.base.meta.impl.FortIntelligenceClanFilterPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortIntelligenceClanFilterPopoverMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.RangeSlider;
    import net.wg.gui.components.controls.TimeNumericStepper;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popOvers.PopOver;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.popOvers.PopOverConst;
    import scaleform.clik.events.SliderEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import scaleform.clik.interfaces.IDataProvider;
    
    public class FortIntelligenceClanFilterPopover extends FortIntelligenceClanFilterPopoverMeta implements IFortIntelligenceClanFilterPopoverMeta
    {
        
        public function FortIntelligenceClanFilterPopover()
        {
            super();
            this._defaultFilterData = this.getHelper().defaultFilterData;
            this._lastSentData = this.getHelper().defaultFilterData;
        }
        
        private static var CONTENT_DEFAULT_WIDTH:int = 280;
        
        private static var BOTTOM_PADDING:int = 11;
        
        private static var PERIOD_DELIMITER:String = "-";
        
        public var headerTF:TextField;
        
        public var clanLevelTF:TextField;
        
        public var startHourRangeTF:TextField;
        
        public var rangeSlider:RangeSlider;
        
        public var defenseStartNumericStepper:TimeNumericStepper;
        
        public var defenseEndTF:TextField;
        
        public var availabilityTF:TextField;
        
        public var availabilityDropdown:DropdownMenu;
        
        public var defaultButton:SoundButtonEx;
        
        public var applyButton:SoundButtonEx;
        
        public var cancelButton:SoundButtonEx;
        
        public var bottomSeparator:Sprite;
        
        private var _lastSentData:IntelligenceClanFilterVO;
        
        private var _defaultFilterData:IntelligenceClanFilterVO;
        
        private var _isGlobalDataSet:Boolean;
        
        private var _currentData:IntelligenceClanFilterVO;
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
        
        private var _filterData:IntelligenceClanFilterVO;
        
        public function get filterData() : IntelligenceClanFilterVO
        {
            this.disposeFilterData();
            var _loc1_:Object = {};
            _loc1_.minClanLevel = int(this.rangeSlider.leftValue);
            _loc1_.maxClanLevel = int(this.rangeSlider.rightValue);
            _loc1_.startDefenseHour = int(this.defenseStartNumericStepper.value);
            var _loc2_:Object = this.availabilityDropdown.dataProvider.requestItemAt(this.availabilityDropdown.selectedIndex);
            _loc1_.availability = _loc2_?_loc2_.data:Values.DEFAULT_INT;
            this._filterData = new IntelligenceClanFilterVO(_loc1_);
            return this._filterData;
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyButton.mouseEnabledOnDisabled = true;
            this.rangeSlider.disablePatternMc.visible = false;
            this.rangeSlider.patternMc.visible = false;
            this.rangeSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.rangeSliderValueChangeHandler);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.applyButtonButtonClickHandler);
            this.defaultButton.addEventListener(ButtonEvent.CLICK,this.defaultButtonButtonClickHandler);
            this.defenseStartNumericStepper.addEventListener(Event.CHANGE,this.defenseStartNumericStepperChangeHandler);
            this.availabilityDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onAvailabilityDropDownChange);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.availabilityDropdown.dataProvider = new DataProvider(getAvailabilityProviderS());
        }
        
        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.SIZE))
            {
                setSize(CONTENT_DEFAULT_WIDTH > this.width?CONTENT_DEFAULT_WIDTH:this.width,this.applyButton.y + this.applyButton.height + BOTTOM_PADDING);
                this.bottomSeparator.width = this.width;
            }
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._isGlobalDataSet)
                {
                    this.setValues(this._currentData);
                    this._isGlobalDataSet = false;
                    assert(this._currentData.isEquals(this.filterData),"FortIntelligenceClanFilterPopover | draw | controls data not equal to set data");
                }
                else if(this.dataWasChangedByControls())
                {
                    this.disposeCurrentData();
                    this._currentData = new IntelligenceClanFilterVO(this.filterData.toHash());
                    this.setValues(this._currentData);
                }
                
            }
            if(isInvalid(FortInvalidationType.INVALID_ENABLING))
            {
                this.defaultButton.enabled = !this.isDefaultDataSet();
                this.applyButton.enabled = !this.lastSearchDataSet();
            }
            super.draw();
        }
        
        override protected function onDispose() : void
        {
            this.headerTF = null;
            this.clanLevelTF = null;
            this.startHourRangeTF = null;
            this.bottomSeparator = null;
            this.defenseEndTF = null;
            this.rangeSlider.dispose();
            this.defenseStartNumericStepper.dispose();
            this.rangeSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.rangeSliderValueChangeHandler);
            this.defenseStartNumericStepper.removeEventListener(Event.CHANGE,this.defenseStartNumericStepperChangeHandler);
            this.availabilityDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onAvailabilityDropDownChange);
            this.rangeSlider = null;
            this.defenseStartNumericStepper = null;
            this.availabilityDropdown = null;
            this.defaultButton.dispose();
            this.applyButton.dispose();
            this.cancelButton.dispose();
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.applyButtonButtonClickHandler);
            this.defaultButton.removeEventListener(ButtonEvent.CLICK,this.defaultButtonButtonClickHandler);
            this.defaultButton = null;
            this.applyButton = null;
            this.cancelButton = null;
            this._defaultFilterData.dispose();
            this._defaultFilterData = null;
            this.disposeLastSentData();
            this.disposeFilterData();
            this.disposeCurrentData();
            super.onDispose();
        }
        
        override protected function setData(param1:IntelligenceClanFilterVO) : void
        {
            this._isGlobalDataSet = true;
            assert(param1.maxClanLevel <= this._defaultFilterData.maxClanLevel && param1.maxClanLevel >= param1.minClanLevel,"FortIntelligenceClanFilterPopover | setData | incorrect maxClanLevel");
            assert(param1.minClanLevel <= this._defaultFilterData.maxClanLevel && param1.minClanLevel >= param1.minClanLevel,"FortIntelligenceClanFilterPopover | setData | incorrect minClanLevel");
            assert(param1.minClanLevel <= param1.maxClanLevel,"FortIntelligenceClanFilterPopover | setData | incorrect minClanLevel should be less or equal to maxClanLevel");
            this._currentData = new IntelligenceClanFilterVO(param1.toHash());
            if(this._lastSentData)
            {
                if(!param1.isEquals(this._defaultFilterData))
                {
                    this._lastSentData.dispose();
                    this._lastSentData = null;
                    this._lastSentData = new IntelligenceClanFilterVO(param1.toHash());
                }
            }
            else
            {
                this._lastSentData = new IntelligenceClanFilterVO(param1.toHash());
            }
            if(!param1.isEquals(this._defaultFilterData))
            {
                param1.dispose();
            }
            invalidate(InvalidationType.DATA);
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.applyButton);
        }
        
        public function getHelper() : FortIntelligenceWindowHelper
        {
            return FortIntelligenceWindowHelper.getInstance();
        }
        
        public function as_setDescriptionsText(param1:String, param2:String, param3:String, param4:String) : void
        {
            this.headerTF.htmlText = param1;
            this.clanLevelTF.htmlText = param2;
            this.startHourRangeTF.htmlText = param3;
            this.availabilityTF.htmlText = param4;
        }
        
        public function as_setButtonsText(param1:String, param2:String, param3:String) : void
        {
            this.applyButton.label = param2;
            this.defaultButton.label = param1;
            this.cancelButton.label = param3;
        }
        
        public function as_setButtonsTooltips(param1:String, param2:String) : void
        {
            this.applyButton.tooltip = param2;
            this.defaultButton.tooltip = param1;
        }
        
        private function dataWasChangedByControls() : Boolean
        {
            return !this._isGlobalDataSet && !(this._currentData && this._currentData.isEquals(this.filterData));
        }
        
        private function setValues(param1:IntelligenceClanFilterVO) : void
        {
            this.rangeSlider.leftValue = param1.minClanLevel;
            this.rangeSlider.rightValue = param1.maxClanLevel;
            this.defenseStartNumericStepper.value = param1.startDefenseHour;
            if(param1.startDefenseHour == TimeNumericStepper.DEFAULT_VALUE)
            {
                this.defenseEndTF.visible = false;
            }
            else
            {
                this.defenseEndTF.htmlText = PERIOD_DELIMITER + Values.SPACE_STR + FortCommonUtils.instance.getNextHourText(param1.startDefenseHour);
                this.defenseEndTF.visible = true;
            }
            this.availabilityDropdown.selectedIndex = this.getDPItemIndex(this.availabilityDropdown.dataProvider,param1.availability);
        }
        
        private function disposeFilterData() : void
        {
            if(this._filterData)
            {
                this._filterData.dispose();
                this._filterData = null;
            }
        }
        
        private function disposeCurrentData() : void
        {
            if(this._currentData)
            {
                this._currentData.dispose();
                this._currentData = null;
            }
        }
        
        private function disposeLastSentData() : void
        {
            if(this._lastSentData)
            {
                this._lastSentData.dispose();
                this._lastSentData = null;
            }
        }
        
        private function lastSearchDataSet() : Boolean
        {
            return (this._lastSentData) && (this._lastSentData.isEquals(this.filterData));
        }
        
        private function isDefaultDataSet() : Boolean
        {
            return this.filterData.isEquals(this._defaultFilterData);
        }
        
        private function getDPItemIndex(param1:IDataProvider, param2:*, param3:String = "data") : int
        {
            var _loc5_:Object = null;
            var _loc4_:* = -1;
            for each(_loc5_ in param1)
            {
                if((_loc5_.hasOwnProperty(param3)) && _loc5_[param3] == param2)
                {
                    _loc4_ = param1.indexOf(_loc5_);
                    break;
                }
            }
            return _loc4_;
        }
        
        private function cancelButtonClickHandler(param1:ButtonEvent) : void
        {
            App.popoverMgr.hide();
        }
        
        private function applyButtonButtonClickHandler(param1:ButtonEvent) : void
        {
            this.disposeLastSentData();
            this._lastSentData = new IntelligenceClanFilterVO(this.filterData.toHash());
            useFilterS(this.filterData,this.isDefaultDataSet());
            App.popoverMgr.hide();
        }
        
        private function defenseStartNumericStepperChangeHandler(param1:Event) : void
        {
            invalidate(InvalidationType.DATA);
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
        
        private function rangeSliderValueChangeHandler(param1:SliderEvent) : void
        {
            invalidate(InvalidationType.DATA);
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
        
        private function defaultButtonButtonClickHandler(param1:ButtonEvent) : void
        {
            this.setData(this._defaultFilterData);
        }
        
        private function onAvailabilityDropDownChange(param1:ListEvent) : void
        {
            invalidate(InvalidationType.DATA);
            invalidate(FortInvalidationType.INVALID_ENABLING);
        }
    }
}
