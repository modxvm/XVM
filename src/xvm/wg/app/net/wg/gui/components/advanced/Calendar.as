package net.wg.gui.components.advanced
{
    import net.wg.infrastructure.base.meta.impl.CalendarMeta;
    import net.wg.infrastructure.base.meta.ICalendarMeta;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.calendar.DayRenderer;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.ui.InputDetails;
    import net.wg.data.constants.Time;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.NavigationCode;
    import net.wg.gui.interfaces.IDate;
    import net.wg.utils.IDateTime;
    import net.wg.gui.components.advanced.calendar.WeekDayRenderer;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.advanced.events.CalendarEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    
    public class Calendar extends CalendarMeta implements ICalendarMeta, IFocusContainer
    {
        
        public function Calendar()
        {
            this._rawMonthEvents = [];
            this._monthEvents = [];
            super();
            this._displayDate = App.utils.dateTime.now();
        }
        
        private static var INVALID_DISPLAY_DATE:String = "invalidDisplayDate";
        
        private static var INVALID_SELECTED_DATE:String = "invalidSelectedDate";
        
        private static var INVALID_HEADER:String = "invalidHeader";
        
        private static var INVALID_WEEK_START_DAY:String = "invalidWeekStartDay";
        
        private static var INVALID_WEEK_DAY_RENDERER:String = "invalidWeekDayRenderer";
        
        private static var INVALID_DAY_RENDERER:String = "invalidDayRenderer";
        
        private static var INVALID_DAYS_LAYOUT:String = "invalidDaysLayout";
        
        private static var INVALID_MONTH_EVENTS:String = "invalidMonthEvents";
        
        private static var INVALID_AVAILABLE_RANGE:String = "invalidAvailableRange";
        
        private static function showComplexTT(param1:String, param2:String = "") : void
        {
            var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).make();
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
        
        public var monthTF:TextField;
        
        public var messageTF:TextField;
        
        public var prevMonthButton:ButtonDnmIcon;
        
        public var nextMonthButton:ButtonDnmIcon;
        
        public var weekDaysContainer:Sprite;
        
        public var monthDaysContainer:Sprite;
        
        public var headerSeparator:Sprite;
        
        private var _weekDayRenderer:String = "CalendarWeekDayUI";
        
        private var _dayRenderer:String = "CalendarDayUI";
        
        private var _showYear:Boolean = false;
        
        private var _weekStart:int = -1;
        
        private var _dayXStep:Number = 36;
        
        private var _dayYStep:Number = 36;
        
        private var _message:String = "";
        
        private var _displayDate:Date;
        
        private var _selectedDate:Date;
        
        private var _minAvailableDate:Date;
        
        private var _maxAvailableDate:Date;
        
        private var _dayVOClass:Class;
        
        private var _rawMonthEvents:Array;
        
        private var _monthEvents:Array;
        
        private var _outOfBoundsTTHeader:String = "";
        
        private var _outOfBoundsTTBody:String = "";
        
        private var _selectedRenderer:DayRenderer;
        
        public var needToInitFocus:Boolean = true;
        
        private var _isFocusInitialized:Boolean = false;
        
        private var _prevMonthNeedFocusUpdate:Boolean = false;
        
        private var _nextMonthNeedFocusUpdate:Boolean = false;
        
        private var _componentForFocus:InteractiveObject;
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            this.prevMonthButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_PREVIOUSPAGE;
            this.nextMonthButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_NEXTPAGE;
            this.prevMonthButton.autoRepeat = true;
            this.nextMonthButton.autoRepeat = true;
            this.prevMonthButton.addEventListener(ButtonEvent.CLICK,this.onMonthChangeClick);
            this.nextMonthButton.addEventListener(ButtonEvent.CLICK,this.onMonthChangeClick);
            this.prevMonthButton.addEventListener(MouseEvent.ROLL_OVER,this.onPrevMonthBtnRollOverHandler);
            this.prevMonthButton.addEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
            this.nextMonthButton.addEventListener(MouseEvent.ROLL_OVER,this.onNextMonthBtnRollOverHandler);
            this.nextMonthButton.addEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
            if(this.weekStart == -1)
            {
                this.weekStart = App.utils.dateTime.getAS3FirstDayOfWeek();
            }
            this.showYear = true;
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(InputEvent.INPUT,this.handleInput,false);
            this.prevMonthButton.removeEventListener(ButtonEvent.CLICK,this.onMonthChangeClick);
            this.nextMonthButton.removeEventListener(ButtonEvent.CLICK,this.onMonthChangeClick);
            this.prevMonthButton.removeEventListener(MouseEvent.ROLL_OVER,this.onPrevMonthBtnRollOverHandler);
            this.prevMonthButton.removeEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
            this.nextMonthButton.removeEventListener(MouseEvent.ROLL_OVER,this.onNextMonthBtnRollOverHandler);
            this.nextMonthButton.removeEventListener(MouseEvent.ROLL_OUT,this.onMonthBtnsRollOutHandler);
            this.prevMonthButton.dispose();
            this.prevMonthButton = null;
            this.nextMonthButton.dispose();
            this.nextMonthButton = null;
            this.clearWeekDays();
            this.clearMonthDays();
            this.monthTF = null;
            this.messageTF = null;
            this.weekDaysContainer = null;
            this.monthDaysContainer = null;
            this.headerSeparator = null;
            this._dayVOClass = null;
            if(this._rawMonthEvents)
            {
                this._rawMonthEvents.splice(0);
                this._rawMonthEvents = null;
            }
            if(this._componentForFocus)
            {
                this._componentForFocus = null;
            }
            this.disposeMonthEvents();
            this._displayDate = null;
            this._selectedDate = null;
            this._minAvailableDate = null;
            this._maxAvailableDate = null;
            this._selectedRenderer = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(isInvalid(INVALID_DISPLAY_DATE,INVALID_HEADER))
            {
                _loc1_ = App.utils.dateTime.getMonthName(this._displayDate.month,false);
                if(this._showYear)
                {
                    this.monthTF.text = _loc1_ + " " + this._displayDate.fullYear;
                }
                else
                {
                    this.monthTF.text = _loc1_;
                }
            }
            if(isInvalid(INVALID_WEEK_START_DAY,INVALID_WEEK_DAY_RENDERER,INVALID_DAYS_LAYOUT))
            {
                this.redrawWeekDays();
            }
            if(isInvalid(INVALID_DISPLAY_DATE,INVALID_WEEK_START_DAY,INVALID_WEEK_DAY_RENDERER))
            {
                this.updateHighlightedWeekDay();
            }
            if(isInvalid(INVALID_DISPLAY_DATE,INVALID_DAY_RENDERER,INVALID_DAYS_LAYOUT))
            {
                if((this._componentForFocus) && this._componentForFocus.parent == this.monthDaysContainer)
                {
                    this.requestNewFocus(this);
                }
                this.redrawMonthDays();
                this.updateFocus();
            }
            if(isInvalid(INVALID_MONTH_EVENTS))
            {
                this.tryToParseEvents();
                this.applyEventsToDayRenderers();
            }
            if(isInvalid(INVALID_MONTH_EVENTS,INVALID_DISPLAY_DATE))
            {
                this.applyEventsToDayRenderers();
            }
            if(isInvalid(INVALID_AVAILABLE_RANGE,INVALID_DISPLAY_DATE))
            {
                this.updateAvailableRange();
                this.updateNavigationButtons();
            }
            if(isInvalid(INVALID_SELECTED_DATE,INVALID_DISPLAY_DATE,INVALID_DAY_RENDERER))
            {
                this.updateSelectedRenderer();
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            var _loc3_:Date = null;
            var _loc4_:* = 0;
            var _loc5_:* = false;
            var _loc6_:* = false;
            var _loc7_:* = false;
            var _loc8_:* = false;
            var _loc9_:InputDetails = null;
            var _loc10_:* = false;
            var _loc11_:* = false;
            var _loc12_:* = false;
            var _loc13_:Date = null;
            if(param1.handled)
            {
                return;
            }
            var _loc2_:DayRenderer = this.getFocusedRenderer();
            if(_loc2_)
            {
                _loc3_ = _loc2_.date;
                _loc4_ = App.utils.dateTime.getMonthDaysCount(this._displayDate);
                _loc5_ = _loc3_.date <= Time.DAYS_IN_WEEK;
                _loc6_ = _loc3_.date > _loc4_ - Time.DAYS_IN_WEEK;
                _loc7_ = _loc2_ == this.getFirstMonthDayRenderer();
                _loc8_ = _loc2_ == this.getLastMonthDayRenderer();
                _loc9_ = param1.details;
                _loc10_ = _loc9_.value == InputValue.KEY_DOWN || _loc9_.value == InputValue.KEY_HOLD;
                _loc11_ = false;
                _loc12_ = false;
                if(_loc10_)
                {
                    switch(_loc9_.navEquivalent)
                    {
                        case NavigationCode.UP:
                            if(_loc5_)
                            {
                                _loc12_ = true;
                            }
                            break;
                        case NavigationCode.DOWN:
                            if(_loc6_)
                            {
                                _loc11_ = true;
                            }
                            break;
                        case NavigationCode.LEFT:
                            if(_loc7_)
                            {
                                _loc12_ = true;
                            }
                            else if(this.getDayColumnByDate(_loc3_) == 0)
                            {
                                _loc13_ = App.utils.dateTime.shiftDate(_loc3_,-Time.DAY);
                            }
                            
                            break;
                        case NavigationCode.RIGHT:
                            if(_loc8_)
                            {
                                _loc11_ = true;
                            }
                            else if(this.getDayColumnByDate(_loc3_) == Time.DAYS_IN_WEEK - 1)
                            {
                                _loc13_ = App.utils.dateTime.shiftDate(_loc3_,Time.DAY);
                            }
                            
                            break;
                    }
                }
                if(_loc13_)
                {
                    this.requestNewFocus(this.getRendererByDate(_loc13_));
                    param1.handled = true;
                }
                else if((_loc11_) && (this.canNavigateToNextMonth))
                {
                    this._nextMonthNeedFocusUpdate = true;
                    this.changeDisplayDate(this.getNextMonth());
                    param1.handled = true;
                }
                else if((_loc12_) && (this.canNavigateToPrevMonth))
                {
                    this._prevMonthNeedFocusUpdate = true;
                    this.changeDisplayDate(this.getPrevMonth());
                    param1.handled = true;
                }
                
                
            }
        }
        
        private function updateSelectedRenderer() : void
        {
            if(this._selectedRenderer)
            {
                this._selectedRenderer.selected = false;
            }
            this._selectedRenderer = this.getRendererByDate(this._selectedDate);
            if(this._selectedRenderer)
            {
                this._selectedRenderer.selected = true;
            }
        }
        
        private function applyEventsToDayRenderers() : void
        {
            var _loc1_:DayRenderer = null;
            var _loc4_:IDate = null;
            var _loc2_:uint = App.utils.dateTime.getMonthDaysCount(this._displayDate);
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc1_ = this.monthDaysContainer.getChildAt(_loc3_) as DayRenderer;
                _loc1_.data = null;
                _loc3_++;
            }
            if((this._monthEvents) && this._monthEvents.length > 0)
            {
                for each(_loc4_ in this._monthEvents)
                {
                    _loc1_ = this.getRendererByDate(_loc4_.date);
                    if(_loc1_)
                    {
                        _loc1_.data = _loc4_;
                    }
                }
            }
        }
        
        private function updateAvailableRange() : void
        {
            var _loc3_:DayRenderer = null;
            var _loc4_:Date = null;
            var _loc1_:IDateTime = App.utils.dateTime;
            var _loc2_:uint = _loc1_.getMonthDaysCount(this._displayDate);
            var _loc5_:* = true;
            var _loc6_:* = 0;
            while(_loc6_ < _loc2_)
            {
                _loc3_ = this.monthDaysContainer.getChildAt(_loc6_) as DayRenderer;
                _loc4_ = _loc3_.date;
                _loc5_ = true;
                if(this._minAvailableDate)
                {
                    _loc5_ = (_loc1_.isSameDay(_loc4_,this._minAvailableDate)) || _loc1_.timeDiff(_loc4_,this._minAvailableDate) > 0;
                }
                if((_loc5_) && (this._maxAvailableDate))
                {
                    _loc5_ = (_loc1_.isSameDay(_loc4_,this._maxAvailableDate)) || _loc1_.timeDiff(_loc4_,this._maxAvailableDate) < 0;
                }
                _loc3_.selectable = _loc5_;
                _loc6_++;
            }
        }
        
        private function updateNavigationButtons() : void
        {
            this.prevMonthButton.visible = this.canNavigateToPrevMonth;
            this.nextMonthButton.visible = this.canNavigateToNextMonth;
        }
        
        private function updateHighlightedWeekDay() : void
        {
            var _loc3_:WeekDayRenderer = null;
            var _loc1_:Boolean = App.utils.dateTime.isCurrentMonth(this._displayDate);
            var _loc2_:uint = App.utils.dateTime.now().day;
            var _loc4_:* = 0;
            while(_loc4_ < this.weekDaysContainer.numChildren)
            {
                _loc3_ = this.weekDaysContainer.getChildAt(_loc4_) as WeekDayRenderer;
                if(_loc1_)
                {
                    if(this.getDayNumByColumn(_loc4_) == _loc2_)
                    {
                        _loc3_.state = WeekDayRenderer.STATE_HIGHLIGHTED;
                    }
                    else
                    {
                        _loc3_.state = WeekDayRenderer.STATE_NORMAL;
                    }
                }
                else
                {
                    _loc3_.state = WeekDayRenderer.STATE_NORMAL;
                }
                _loc4_++;
            }
        }
        
        private function redrawWeekDays() : void
        {
            var _loc1_:WeekDayRenderer = null;
            this.clearWeekDays();
            var _loc2_:Class = App.utils.classFactory.getClass(this._weekDayRenderer);
            var _loc3_:Array = App.utils.getWeekDayNamesS(false);
            var _loc4_:* = 0;
            while(_loc4_ < Time.DAYS_IN_WEEK)
            {
                _loc1_ = App.utils.classFactory.getComponent(this._weekDayRenderer,_loc2_);
                _loc1_.x = _loc4_ * this._dayXStep;
                _loc1_.label = _loc3_[_loc4_];
                this.weekDaysContainer.addChild(_loc1_);
                _loc4_++;
            }
        }
        
        private function clearWeekDays() : void
        {
            var _loc1_:WeekDayRenderer = null;
            while(this.weekDaysContainer.numChildren)
            {
                _loc1_ = this.weekDaysContainer.getChildAt(0) as WeekDayRenderer;
                this.weekDaysContainer.removeChild(_loc1_);
            }
        }
        
        private function redrawMonthDays() : void
        {
            var _loc1_:DayRenderer = null;
            this.clearMonthDays();
            var _loc2_:Class = App.utils.classFactory.getClass(this._dayRenderer);
            var _loc3_:uint = App.utils.dateTime.getMonthDaysCount(this._displayDate);
            var _loc4_:Date = App.utils.dateTime.cloneDate(this._displayDate);
            _loc4_.date = 1;
            var _loc5_:uint = this.getWeekShift(this._displayDate);
            var _loc6_:* = 0;
            while(_loc6_ < _loc3_)
            {
                _loc1_ = App.utils.classFactory.getComponent(this._dayRenderer,_loc2_);
                _loc1_.x = this.getDayColumnByDate(_loc4_) * this._dayXStep;
                _loc1_.y = this.getDayRowByDate(_loc4_,_loc5_) * this._dayYStep;
                this.monthDaysContainer.addChild(_loc1_);
                _loc1_.date = _loc4_;
                _loc1_.addEventListener(ButtonEvent.CLICK,this.onDayClick);
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onDayOver);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onDayOut);
                _loc4_ = App.utils.dateTime.shiftDate(_loc4_,Time.DAY);
                _loc6_++;
            }
        }
        
        private function clearMonthDays() : void
        {
            var _loc1_:DayRenderer = null;
            if(this._selectedRenderer)
            {
                this._selectedRenderer = null;
            }
            while(this.monthDaysContainer.numChildren)
            {
                _loc1_ = this.monthDaysContainer.getChildAt(0) as DayRenderer;
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onDayClick);
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onDayOver);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onDayOut);
                this.monthDaysContainer.removeChild(_loc1_);
                _loc1_.dispose();
            }
        }
        
        private function tryToParseEvents() : void
        {
            var _loc1_:Object = null;
            var _loc2_:* = undefined;
            this.disposeMonthEvents();
            if((this._rawMonthEvents) && (this._dayVOClass))
            {
                this._monthEvents = [];
                for each(_loc1_ in this._rawMonthEvents)
                {
                    _loc2_ = new this._dayVOClass(_loc1_);
                    this._monthEvents.push(_loc2_);
                }
            }
        }
        
        private function disposeMonthEvents() : void
        {
            var _loc1_:IDisposable = null;
            if(this._monthEvents)
            {
                for each(_loc1_ in this._monthEvents)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this._monthEvents.splice(0);
                this._monthEvents = null;
            }
        }
        
        private function changeDisplayDate(param1:Date) : void
        {
            this.displayDate = param1;
            this.dispatchCalendarEvent(CalendarEvent.MONTH_CHANGED);
            if(isDAAPIInited)
            {
                onMonthChangedS(App.utils.dateTime.toPyTimestamp(this._displayDate));
            }
        }
        
        private function dispatchCalendarEvent(param1:String) : void
        {
            dispatchEvent(new CalendarEvent(param1,App.utils.dateTime.cloneDate(this._displayDate),this._selectedDate?App.utils.dateTime.cloneDate(this._selectedDate):null));
        }
        
        private function getDayNumByColumn(param1:uint) : uint
        {
            var _loc2_:int = this._weekStart + (param1 < Time.DAYS_IN_WEEK - this._weekStart?param1:param1 - Time.DAYS_IN_WEEK);
            return _loc2_;
        }
        
        private function getDayColumnByDate(param1:Date) : Number
        {
            var _loc2_:uint = this._weekStart > param1.day?Time.DAYS_IN_WEEK - this._weekStart + param1.day:param1.day - this._weekStart;
            return _loc2_;
        }
        
        private function getDayRowByDate(param1:Date, param2:Number = -1) : Number
        {
            if(param2 == -1)
            {
                param2 = this.getWeekShift(param1);
            }
            var _loc3_:uint = (param1.date - 1 + param2) / Time.DAYS_IN_WEEK;
            return _loc3_;
        }
        
        private function getWeekShift(param1:Date) : uint
        {
            var _loc2_:Date = App.utils.dateTime.cloneDate(param1);
            _loc2_.date = 1;
            var _loc3_:uint = _loc2_.day < this._weekStart?Time.DAYS_IN_WEEK - this._weekStart + _loc2_.day:_loc2_.day - this._weekStart;
            return _loc3_;
        }
        
        private function getRendererByDate(param1:Date) : DayRenderer
        {
            var _loc2_:DayRenderer = null;
            if((param1) && (App.utils.dateTime.isSameMonth(this._displayDate,param1)))
            {
                _loc2_ = this.monthDaysContainer.getChildAt(int(param1.date - 1)) as DayRenderer;
            }
            return _loc2_;
        }
        
        private function updateFocus() : void
        {
            if(!this._isFocusInitialized && (this.needToInitFocus))
            {
                this.requestNewFocus(this.getElementForInitialFocus());
                this._isFocusInitialized = true;
            }
            else if(this._nextMonthNeedFocusUpdate)
            {
                this.requestNewFocus(this.getFirstMonthDayRenderer());
                this._nextMonthNeedFocusUpdate = false;
            }
            else if(this._prevMonthNeedFocusUpdate)
            {
                this.requestNewFocus(this.getLastMonthDayRenderer());
                this._prevMonthNeedFocusUpdate = false;
            }
            
            
        }
        
        private function getElementForInitialFocus() : InteractiveObject
        {
            var _loc2_:InteractiveObject = null;
            var _loc3_:Date = null;
            var _loc1_:Date = App.utils.dateTime.now();
            if(App.utils.dateTime.isSameMonth(_loc1_,this._displayDate))
            {
                _loc2_ = this.getRendererByDate(App.utils.dateTime.now());
            }
            else
            {
                _loc3_ = App.utils.dateTime.cloneDate(this._displayDate);
                _loc3_.date = 1;
                _loc2_ = this.getRendererByDate(_loc3_);
            }
            return _loc2_;
        }
        
        private function getFocusedRenderer() : DayRenderer
        {
            var _loc1_:DayRenderer = null;
            var _loc2_:DayRenderer = null;
            var _loc3_:* = 0;
            var _loc4_:int = this.monthDaysContainer.numChildren;
            while(_loc3_ < _loc4_)
            {
                _loc1_ = this.monthDaysContainer.getChildAt(_loc3_) as DayRenderer;
                if(_loc1_.focused)
                {
                    _loc2_ = _loc1_;
                    break;
                }
                _loc3_++;
            }
            return _loc2_;
        }
        
        private function getFirstMonthDayRenderer() : DayRenderer
        {
            var _loc1_:DayRenderer = null;
            if(this.monthDaysContainer.numChildren > 0)
            {
                _loc1_ = this.monthDaysContainer.getChildAt(0) as DayRenderer;
            }
            return _loc1_;
        }
        
        private function getLastMonthDayRenderer() : DayRenderer
        {
            var _loc1_:DayRenderer = null;
            if(this.monthDaysContainer.numChildren > 0)
            {
                _loc1_ = this.monthDaysContainer.getChildAt(this.monthDaysContainer.numChildren - 1) as DayRenderer;
            }
            return _loc1_;
        }
        
        private function getNextMonth() : Date
        {
            var _loc1_:Date = null;
            if(this._displayDate.month != Time.MONTHS_IN_YEAR - 1)
            {
                _loc1_ = new Date(this._displayDate.fullYear,this._displayDate.month + 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours,this._displayDate.minutes,this._displayDate.seconds);
            }
            else
            {
                _loc1_ = new Date(this._displayDate.fullYear + 1,0,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours,this._displayDate.minutes,this._displayDate.seconds);
            }
            return _loc1_;
        }
        
        private function getPrevMonth() : Date
        {
            var _loc1_:Date = null;
            if(this._displayDate.month != 0)
            {
                _loc1_ = new Date(this._displayDate.fullYear,this._displayDate.month - 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours);
            }
            else
            {
                _loc1_ = new Date(this._displayDate.fullYear - 1,Time.MONTHS_IN_YEAR - 1,Time.FIRST_DAY_IN_MONTH,this._displayDate.hours);
            }
            return _loc1_;
        }
        
        private function onMonthChangeClick(param1:ButtonEvent) : void
        {
            var _loc2_:* = param1.currentTarget == this.nextMonthButton;
            if(_loc2_)
            {
                this.changeDisplayDate(this.getNextMonth());
            }
            else
            {
                this.changeDisplayDate(this.getPrevMonth());
            }
        }
        
        private function onDayClick(param1:ButtonEvent) : void
        {
            var _loc2_:DayRenderer = param1.currentTarget as DayRenderer;
            this.selectedDate = App.utils.dateTime.cloneDate(_loc2_.date);
            this.dispatchCalendarEvent(CalendarEvent.DAY_SELECTED);
            if(isDAAPIInited)
            {
                onDateSelectedS(App.utils.dateTime.toPyTimestamp(this._selectedDate));
            }
        }
        
        private function onDayOver(param1:MouseEvent) : void
        {
            if(!this._outOfBoundsTTHeader || !this._outOfBoundsTTBody)
            {
                return;
            }
            var _loc2_:Date = (param1.currentTarget as DayRenderer).date;
            var _loc3_:IDateTime = App.utils.dateTime;
            var _loc4_:* = false;
            var _loc5_:* = false;
            if(this._minAvailableDate)
            {
                if(_loc3_.timeDiff(_loc2_,this._minAvailableDate) < 0 && !_loc3_.isSameDay(_loc2_,this._minAvailableDate))
                {
                    _loc4_ = true;
                }
            }
            if(this._maxAvailableDate)
            {
                if(_loc3_.timeDiff(_loc2_,this._maxAvailableDate) > 0 && !_loc3_.isSameDay(_loc2_,this._maxAvailableDate))
                {
                    _loc5_ = true;
                }
            }
            if((_loc4_) || (_loc5_))
            {
                showComplexTT(this._outOfBoundsTTHeader,this._outOfBoundsTTBody);
            }
        }
        
        private function onDayOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function requestNewFocus(param1:InteractiveObject) : void
        {
            this._componentForFocus = param1;
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this._componentForFocus;
        }
        
        public function setOutOfBoundsTooltip(param1:String, param2:String) : void
        {
            this._outOfBoundsTTHeader = param1;
            this._outOfBoundsTTBody = param2;
        }
        
        public function get canNavigateToPrevMonth() : Boolean
        {
            return !(this._minAvailableDate && App.utils.dateTime.isSameMonth(this._minAvailableDate,this._displayDate));
        }
        
        public function get canNavigateToNextMonth() : Boolean
        {
            return !(this._maxAvailableDate && App.utils.dateTime.isSameMonth(this._maxAvailableDate,this._displayDate));
        }
        
        public function get displayDate() : Date
        {
            return this._displayDate;
        }
        
        public function set displayDate(param1:Date) : void
        {
            this._displayDate = param1;
            invalidate(INVALID_DISPLAY_DATE);
        }
        
        public function get weekDayRenderer() : String
        {
            return this._weekDayRenderer;
        }
        
        public function set weekDayRenderer(param1:String) : void
        {
            this._weekDayRenderer = param1;
            invalidate(INVALID_WEEK_DAY_RENDERER);
        }
        
        public function get dayRenderer() : String
        {
            return this._dayRenderer;
        }
        
        public function set dayRenderer(param1:String) : void
        {
            this._dayRenderer = param1;
            invalidate(INVALID_DAY_RENDERER);
        }
        
        public function get showYear() : Boolean
        {
            return this._showYear;
        }
        
        public function set showYear(param1:Boolean) : void
        {
            this._showYear = param1;
            invalidate(INVALID_HEADER);
        }
        
        public function get weekStart() : int
        {
            return this._weekStart;
        }
        
        public function set weekStart(param1:int) : void
        {
            this._weekStart = param1;
            invalidate(INVALID_WEEK_START_DAY);
        }
        
        public function get dayXStep() : Number
        {
            return this._dayXStep;
        }
        
        public function set dayXStep(param1:Number) : void
        {
            this._dayXStep = param1;
            invalidate(INVALID_DAYS_LAYOUT);
        }
        
        public function get dayYStep() : Number
        {
            return this._dayYStep;
        }
        
        public function set dayYStep(param1:Number) : void
        {
            this._dayYStep = param1;
            invalidate(INVALID_DAYS_LAYOUT);
        }
        
        public function get selectedDate() : Date
        {
            return this._selectedDate;
        }
        
        public function set selectedDate(param1:Date) : void
        {
            this._selectedDate = param1;
            invalidate(INVALID_SELECTED_DATE);
        }
        
        public function get minAvailableDate() : Date
        {
            return this._minAvailableDate;
        }
        
        public function set minAvailableDate(param1:Date) : void
        {
            this._minAvailableDate = param1;
            invalidate(INVALID_AVAILABLE_RANGE);
        }
        
        public function get maxAvailableDate() : Date
        {
            return this._maxAvailableDate;
        }
        
        public function set maxAvailableDate(param1:Date) : void
        {
            this._maxAvailableDate = param1;
            invalidate(INVALID_AVAILABLE_RANGE);
        }
        
        public function get year() : int
        {
            return this._displayDate.fullYear;
        }
        
        public function set year(param1:int) : void
        {
            if(param1 == -1 || param1 == this._displayDate.fullYear)
            {
                return;
            }
            var _loc2_:Date = App.utils.dateTime.cloneDate(this._displayDate);
            _loc2_.fullYear = param1;
            this.selectedDate = _loc2_;
        }
        
        public function get month() : int
        {
            return this._displayDate.month;
        }
        
        public function set month(param1:int) : void
        {
            if(param1 == -1 || param1 == this._displayDate.month)
            {
                return;
            }
            var _loc2_:Date = App.utils.dateTime.cloneDate(this._displayDate);
            _loc2_.month = param1;
            this.selectedDate = _loc2_;
        }
        
        public function get dayVOClass() : Class
        {
            return this._dayVOClass;
        }
        
        public function set dayVOClass(param1:Class) : void
        {
            this._dayVOClass = param1;
            invalidate(INVALID_MONTH_EVENTS);
        }
        
        public function get monthEvents() : Array
        {
            return this._monthEvents;
        }
        
        public function set monthEvents(param1:Array) : void
        {
            this._monthEvents = param1;
            invalidate(INVALID_MONTH_EVENTS);
        }
        
        public function get message() : String
        {
            return this._message;
        }
        
        public function set message(param1:String) : void
        {
            this._message = param1;
            this.messageTF.htmlText = this._message;
        }
        
        public function as_openMonth(param1:Number) : void
        {
            this.displayDate = App.utils.dateTime.fromPyTimestamp(param1);
        }
        
        public function as_selectDate(param1:Number) : void
        {
            this.selectedDate = App.utils.dateTime.fromPyTimestamp(param1);
        }
        
        public function as_updateMonthEvents(param1:Array) : void
        {
            this._rawMonthEvents = param1;
            invalidate(INVALID_MONTH_EVENTS);
        }
        
        public function as_setCalendarMessage(param1:String) : void
        {
            this.message = param1;
        }
        
        public function as_setMinAvailableDate(param1:Number) : void
        {
            this.minAvailableDate = App.utils.dateTime.fromPyTimestamp(param1);
        }
        
        public function as_setMaxAvailableDate(param1:Number) : void
        {
            this.maxAvailableDate = App.utils.dateTime.fromPyTimestamp(param1);
        }
        
        private function onPrevMonthBtnRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.CALENDAR_PREVMONTH);
        }
        
        private function onNextMonthBtnRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.CALENDAR_NEXTMONTH);
        }
        
        private function onMonthBtnsRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
