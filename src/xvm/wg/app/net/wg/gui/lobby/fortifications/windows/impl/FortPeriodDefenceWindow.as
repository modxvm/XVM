package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortPeriodDefenceWindowMeta;
    import net.wg.infrastructure.base.meta.IFortPeriodDefenceWindowMeta;
    import net.wg.utils.ILocale;
    import net.wg.utils.IUtils;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IDateTime;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.TimeNumericStepper;
    import net.wg.gui.lobby.fortifications.cmp.main.impl.FortTimeAlertIcon;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import scaleform.clik.utils.Padding;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.fortifications.data.PeriodDefenceVO;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Values;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.utils.IAssertable;
    
    public class FortPeriodDefenceWindow extends FortPeriodDefenceWindowMeta implements IFortPeriodDefenceWindowMeta
    {
        
        public function FortPeriodDefenceWindow()
        {
            this.tooltipInfoByTextField = {};
            super();
            isModal = true;
            canDrag = false;
        }
        
        private static var PADDING_AFTER_TEXT:int = 5;
        
        private static var DATA_CHANGED:String = "dataChanged";
        
        private static var DEFAULT_PADDING_TOP:int = 33;
        
        private static var DEFAULT_PADDING_BOTTOM:int = 20;
        
        private static var DEFAULT_PADDING_RIGHT:int = 11;
        
        private static var DEFAULT_PADDING_LEFT:int = 10;
        
        private static function get locale() : ILocale
        {
            return App.utils.locale;
        }
        
        private static function get utils() : IUtils
        {
            return App.utils;
        }
        
        private static function get tooltipMgr() : ITooltipMgr
        {
            return App.toolTipMgr;
        }
        
        private static function get dateTime() : IDateTime
        {
            return App.utils.dateTime;
        }
        
        private static function elementMouseOutHandler(param1:MouseEvent) : void
        {
            tooltipMgr.hide();
        }
        
        public var headerTF:TextField;
        
        public var peripheryTF:TextField;
        
        public var peripheryDescrTF:TextField;
        
        public var hourDefenceTF:TextField;
        
        public var hourDefenceTimeTF:TextField;
        
        public var hourDefenceDescrTF:TextField;
        
        public var holidayTF:TextField;
        
        public var holidayDescrTF:TextField;
        
        public var dashTF:TextField;
        
        public var bgIcon:UILoaderAlt;
        
        public var peripheryDD:DropdownMenu;
        
        public var holidayDD:DropdownMenu;
        
        public var acceptBtn:SoundButtonEx;
        
        public var cancelBtn:ISoundButtonEx;
        
        public var timeStepper:TimeNumericStepper;
        
        public var timeAlert:FortTimeAlertIcon = null;
        
        private var helper:FortPeriodDefenceWindowHelper;
        
        private var isPeripherySelected:Boolean = true;
        
        private var isHolidaySelected:Boolean = true;
        
        private var isWrongLocalTime:Boolean = false;
        
        private var tooltipInfoByTextField:Object;
        
        private var textFieldsWithTooltip:Vector.<TextField>;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.timeAlert.visible = false;
            App.utils.commons.moveDsiplObjToEndOfText(this.timeAlert,this.hourDefenceTimeTF);
        }
        
        override public function setWindow(param1:IWindow) : void
        {
            var _loc2_:Padding = null;
            super.setWindow(param1);
            if(window)
            {
                _loc2_ = new Padding();
                _loc2_.top = DEFAULT_PADDING_TOP;
                _loc2_.bottom = this.cancelBtn.height + DEFAULT_PADDING_BOTTOM;
                _loc2_.right = DEFAULT_PADDING_RIGHT;
                _loc2_.left = DEFAULT_PADDING_LEFT;
                window.formBgPadding = _loc2_;
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.acceptBtn.mouseEnabledOnDisabled = true;
            this.tooltipInfoByTextField[this.peripheryTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_PERIPHERY);
            this.tooltipInfoByTextField[this.peripheryDescrTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_PERIPHERY);
            this.tooltipInfoByTextField[this.holidayTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOLIDAY);
            this.tooltipInfoByTextField[this.holidayDescrTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOLIDAY);
            this.tooltipInfoByTextField[this.hourDefenceTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOURDEFENCE);
            this.tooltipInfoByTextField[this.hourDefenceDescrTF.name] = new TooltipInfo(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOURDEFENCE);
            this.textFieldsWithTooltip = new <TextField>[this.peripheryTF,this.peripheryDescrTF,this.holidayTF,this.holidayDescrTF,this.hourDefenceTF,this.hourDefenceDescrTF];
            this.addListeners();
            this.helper = new FortPeriodDefenceWindowHelper();
            var _loc1_:Vector.<TextField> = new <TextField>[this.peripheryTF,this.holidayTF,this.hourDefenceTF];
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_.length)
            {
                _loc1_[_loc2_].autoSize = TextFieldAutoSize.LEFT;
                _loc2_++;
            }
        }
        
        override protected function setTexts(param1:PeriodDefenceVO) : void
        {
            window.title = param1.windowLbl;
            this.headerTF.htmlText = param1.headerLbl;
            this.peripheryTF.htmlText = param1.peripheryLbl;
            this.peripheryDescrTF.htmlText = param1.peripheryDescr;
            this.hourDefenceTF.htmlText = param1.hourDefenceLbl;
            this.hourDefenceDescrTF.htmlText = param1.hourDefenceDescr;
            this.holidayTF.htmlText = param1.holidayLbl;
            this.holidayDescrTF.htmlText = param1.holidayDescr;
            this.acceptBtn.label = param1.acceptBtn;
            this.cancelBtn.label = param1.cancelBtn;
            var _loc2_:String = new ComplexTooltipHelper().addHeader(Values.EMPTY_STR).addBody(locale.makeString(FORTIFICATIONS.PERIODDEFENCEWINDOW_NOTNOW_BODY)).make();
            this.cancelBtn.tooltip = _loc2_;
            this.updatePositions();
        }
        
        private function updatePositions() : void
        {
            this.peripheryDD.x = this.peripheryTF.x + this.peripheryTF.width + PADDING_AFTER_TEXT;
            this.timeStepper.x = this.hourDefenceTF.x + this.hourDefenceTF.width + PADDING_AFTER_TEXT;
            this.dashTF.x = this.timeStepper.x + this.timeStepper.width;
            this.hourDefenceTimeTF.x = this.dashTF.x + this.dashTF.width;
            this.holidayDD.x = this.holidayTF.x + this.holidayTF.width + PADDING_AFTER_TEXT;
        }
        
        override protected function onDispose() : void
        {
            this.tooltipMgr.hide();
            this.removeListeners();
            while(this.textFieldsWithTooltip.length > 0)
            {
                this.textFieldsWithTooltip.pop();
            }
            this.textFieldsWithTooltip = null;
            this.tooltipInfoByTextField = App.utils.commons.cleanupDynamicObject(this.tooltipInfoByTextField);
            this.bgIcon.dispose();
            this.bgIcon = null;
            this.peripheryDD.dispose();
            this.peripheryDD = null;
            this.holidayDD.dispose();
            this.holidayDD = null;
            this.headerTF = null;
            this.peripheryTF = null;
            this.peripheryDescrTF = null;
            this.hourDefenceTF = null;
            this.hourDefenceTimeTF = null;
            this.hourDefenceDescrTF = null;
            this.holidayTF = null;
            this.holidayDescrTF = null;
            this.dashTF = null;
            this.acceptBtn.dispose();
            this.acceptBtn = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.timeStepper.dispose();
            this.timeStepper = null;
            this.helper = null;
            this.timeAlert.dispose();
            this.timeAlert = null;
            super.onDispose();
        }
        
        override protected function setData(param1:PeriodDefenceVO) : void
        {
            this.setPeripheryData(param1.peripheryData,param1.peripherySelectedID);
            this.setHolidayData(param1.holidayData,param1.holidaySelectedID);
            this.setHourPeriodDefense(param1);
            this.tooltipMgr.hide();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.peripheryDD);
        }
        
        private function addListeners() : void
        {
            this.timeStepper.addEventListener(Event.CHANGE,this.timeStepperChangeHandler);
            this.timeStepper.addEventListener(ComponentEvent.STATE_CHANGE,this.timeStepperStateChangeHandler);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            this.acceptBtn.addEventListener(ButtonEvent.CLICK,this.acceptBtnClickHandler);
            this.holidayDD.addEventListener(ListEvent.INDEX_CHANGE,this.holidayDDSelectHandler);
            this.peripheryDD.addEventListener(ListEvent.INDEX_CHANGE,this.peripheryDDSelectHandler);
            addEventListener(DATA_CHANGED,this.dataChangeHandler);
            this.acceptBtn.addEventListener(MouseEvent.MOUSE_OVER,this.acceptBtnMouseOverHandler);
            this.acceptBtn.addEventListener(MouseEvent.MOUSE_OUT,elementMouseOutHandler);
            var _loc1_:* = 0;
            while(_loc1_ < this.textFieldsWithTooltip.length)
            {
                this.textFieldsWithTooltip[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.descriptionTextMouseOverHandler);
                this.textFieldsWithTooltip[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,elementMouseOutHandler);
                _loc1_++;
            }
        }
        
        private function removeListeners() : void
        {
            this.timeStepper.removeEventListener(Event.CHANGE,this.timeStepperChangeHandler);
            this.timeStepper.removeEventListener(ComponentEvent.STATE_CHANGE,this.timeStepperStateChangeHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            this.acceptBtn.removeEventListener(ButtonEvent.CLICK,this.acceptBtnClickHandler);
            this.acceptBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.acceptBtnMouseOverHandler);
            this.acceptBtn.removeEventListener(MouseEvent.MOUSE_OUT,elementMouseOutHandler);
            this.holidayDD.removeEventListener(ListEvent.INDEX_CHANGE,this.holidayDDSelectHandler);
            this.peripheryDD.removeEventListener(ListEvent.INDEX_CHANGE,this.peripheryDDSelectHandler);
            removeEventListener(DATA_CHANGED,this.dataChangeHandler);
            var _loc1_:* = 0;
            while(_loc1_ < this.textFieldsWithTooltip.length)
            {
                this.textFieldsWithTooltip[_loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.descriptionTextMouseOverHandler);
                this.textFieldsWithTooltip[_loc1_].removeEventListener(MouseEvent.MOUSE_OUT,elementMouseOutHandler);
                _loc1_++;
            }
        }
        
        private function setPeripheryData(param1:Array, param2:int) : void
        {
            this.helper.setDataInDropDown(this.peripheryDD,param1,param2);
            this.isPeripherySelected = param2 >= 0;
            dispatchEvent(new Event(DATA_CHANGED));
        }
        
        private function setHolidayData(param1:Array, param2:int) : void
        {
            this.helper.setDataInDropDown(this.holidayDD,param1,param2);
            this.isHolidaySelected = param2 >= 0;
            dispatchEvent(new Event(DATA_CHANGED));
        }
        
        private function setHourPeriodDefense(param1:PeriodDefenceVO) : void
        {
            this.timeStepper.value = param1.hour;
            this.timeStepper.skipValues = param1.skipValues;
            this.hourDefenceTimeTF.visible = this.dashTF.visible = !this.timeStepper.currentValueIsDefault;
            this.hourDefenceTimeTF.text = FortCommonUtils.instance.getNextHourText(param1.hour);
            this.isWrongLocalTime = param1.isWrongLocalTime;
            this.timeAlert.showAlert((this.hourDefenceTimeTF.visible) && (this.isWrongLocalTime));
        }
        
        private function get btnIsEnabled() : Boolean
        {
            return (this.isPeripherySelected) && (this.isHolidaySelected) && !this.timeStepper.currentValueIsDefault;
        }
        
        private function timeStepperStateChangeHandler(param1:ComponentEvent) : void
        {
            this.hourDefenceTimeTF.visible = this.dashTF.visible = true;
            this.timeAlert.showAlert(this.isWrongLocalTime);
        }
        
        private function timeStepperChangeHandler(param1:Event) : void
        {
            if(!this.hourDefenceTimeTF.visible)
            {
                this.hourDefenceTimeTF.visible = this.dashTF.visible = true;
            }
            this.timeAlert.showAlert(this.isWrongLocalTime);
            this.hourDefenceTimeTF.text = FortCommonUtils.instance.getNextHourText(this.timeStepper.value);
            dispatchEvent(new Event(DATA_CHANGED));
        }
        
        private function cancelButtonClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function acceptBtnClickHandler(param1:ButtonEvent) : void
        {
            var _loc5_:IDataProvider = null;
            var _loc6_:IDataProvider = null;
            var _loc2_:* = -1;
            var _loc3_:* = -1;
            if(this.peripheryDD.selectedIndex >= 0)
            {
                _loc5_ = this.peripheryDD.dataProvider;
                _loc3_ = _loc5_[this.peripheryDD.selectedIndex].id;
            }
            if(this.holidayDD.selectedIndex >= 0)
            {
                _loc6_ = this.holidayDD.dataProvider;
                _loc2_ = _loc6_[this.holidayDD.selectedIndex].id;
            }
            var _loc4_:PeriodDefenceVO = new PeriodDefenceVO({"peripherySelectedID":_loc3_,
            "holidaySelectedID":_loc2_,
            "hour":this.timeStepper.value
        });
        onApplyS(_loc4_);
    }
    
    private function holidayDDSelectHandler(param1:ListEvent) : void
    {
        if(!this.isHolidaySelected)
        {
            this.isHolidaySelected = true;
            this.helper.removeDefaultDataDropDown(param1.index,this.holidayDD);
        }
        dispatchEvent(new Event(DATA_CHANGED));
    }
    
    private function peripheryDDSelectHandler(param1:ListEvent) : void
    {
        if(!this.isPeripherySelected)
        {
            this.isPeripherySelected = true;
            this.helper.removeDefaultDataDropDown(param1.index,this.peripheryDD);
        }
        dispatchEvent(new Event(DATA_CHANGED));
    }
    
    private function dataChangeHandler(param1:Event) : void
    {
        this.acceptBtn.enabled = this.btnIsEnabled;
        if(this.btnIsEnabled)
        {
            setFocus(this.acceptBtn);
        }
    }
    
    private function acceptBtnMouseOverHandler(param1:MouseEvent) : void
    {
        if(this.btnIsEnabled)
        {
            this.tooltipMgr.show(FORTIFICATIONS.PERIODDEFENCEWINDOW_BTN_POINTSAREFILLED_BODY);
        }
        else
        {
            this.tooltipMgr.show(FORTIFICATIONS.PERIODDEFENCEWINDOW_BTN_POINTSARENOTFILLED_BODY);
        }
    }
    
    private function get asserter() : IAssertable
    {
        return App.utils.asserter;
    }
    
    private function get tooltipMgr() : ITooltipMgr
    {
        return App.toolTipMgr;
    }
    
    private function descriptionTextMouseOverHandler(param1:MouseEvent) : void
    {
        var _loc2_:* = "Not such element in tooltipInfoByTextField";
        var _loc3_:TooltipInfo = this.tooltipInfoByTextField[param1.currentTarget.name];
        this.asserter.assert(!(_loc3_ == null),_loc2_);
        var _loc4_:String = new ComplexTooltipHelper().addHeader(_loc3_.header).addBody(_loc3_.body).make();
        this.tooltipMgr.showComplex(_loc4_);
    }
}
}
import net.wg.utils.ILocale;

class TooltipInfo extends Object
{

function TooltipInfo(param1:String)
{
    super();
    this._tooltipBase = param1;
}

private static var HEADER:String = "/header";

private static var BODY:String = "/body";

private var _tooltipBase:String;

public function get header() : String
{
    return this.locale.makeString(this._tooltipBase + HEADER);
}

public function get body() : String
{
    return this.locale.makeString(this._tooltipBase + BODY);
}

private function get locale() : ILocale
{
    return App.utils.locale;
}
}
