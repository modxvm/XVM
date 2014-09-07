package net.wg.gui.components.advanced.calendar
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.interfaces.IDate;
    import flash.events.MouseEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ICalendarDayVO;
    import net.wg.data.constants.ComponentState;
    import scaleform.clik.constants.InvalidationType;
    
    public class DayRenderer extends SoundButtonEx implements IDate
    {
        
        public function DayRenderer()
        {
            super();
        }
        
        private static var PREFIX_TODAY:String = "today_";
        
        private static var PREFIX_SELECTED:String = "selected_";
        
        private static function onRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function showComplexTT(param1:String, param2:String = "") : void
        {
            var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).make();
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
        
        public var image:UILoaderAlt;
        
        private var _model:ICalendarDayVO;
        
        private var _date:Date;
        
        private var _isToday:Boolean = false;
        
        private var _selectable:Boolean = true;
        
        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabledOnDisabled = true;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT,onRollOut);
            if(enabled)
            {
                if(focused)
                {
                    setState(ComponentState.OVER);
                }
                else
                {
                    setState(ComponentState.OUT);
                }
            }
            else
            {
                setState(ComponentState.DISABLED);
            }
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
            this.image.dispose();
            this.image = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            this._date = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.updateImage();
            }
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            var _loc1_:* = "";
            if(this._isToday)
            {
                _loc1_ = _loc1_ + PREFIX_TODAY;
            }
            if(_selected)
            {
                _loc1_ = _loc1_ + PREFIX_SELECTED;
            }
            return Vector.<String>([_loc1_]);
        }
        
        public function get date() : Date
        {
            return this._date;
        }
        
        public function set date(param1:Date) : void
        {
            this._date = param1;
            this._isToday = this._date?App.utils.dateTime.isToday(this._date):false;
            label = this._date.date.toString();
            updateText();
            invalidateState();
        }
        
        public function get selectable() : Boolean
        {
            return this._selectable;
        }
        
        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
            this.updateEnabled();
        }
        
        private function updateImage() : void
        {
            if(this._model)
            {
                this.image.source = this._model.iconSource;
                this.image.visible = Boolean(this._model.iconSource);
            }
            else
            {
                this.image.visible = false;
            }
        }
        
        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this._model = param1 as ICalendarDayVO;
            this.updateEnabled();
            this.updateImage();
        }
        
        override protected function handleReleaseOutside(param1:MouseEvent) : void
        {
            if(enabled)
            {
                super.handleReleaseOutside(param1);
                focused = 0;
                selected = false;
                setState(ComponentState.OUT);
            }
        }
        
        private function updateEnabled() : void
        {
            if(this._model)
            {
                enabled = (this._model.available) && (this._selectable);
            }
            else
            {
                enabled = this._selectable;
            }
            invalidateState();
        }
        
        private function onRollOver(param1:MouseEvent) : void
        {
            if(this._model)
            {
                showComplexTT(this._model.tooltipHeader,this._model.tooltipBody);
            }
        }
    }
}
