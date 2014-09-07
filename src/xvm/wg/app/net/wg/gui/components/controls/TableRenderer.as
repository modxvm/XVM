package net.wg.gui.components.controls
{
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ComponentEvent;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import flash.geom.Point;
    
    public class TableRenderer extends SoundListItemRenderer implements ITableRenderer
    {
        
        public function TableRenderer()
        {
            this.statesPassive = Vector.<String>(["passive_"]);
            super();
        }
        
        public static var INV_PASSIVE:String = "invPassive";
        
        private static var TIME_CLICK:uint = 220;
        
        public var rendererBg:MovieClip;
        
        public var disableMc:BitmapFill;
        
        protected var _rendererBgLabelsHash:Object;
        
        protected var statesPassive:Vector.<String>;
        
        private var _isPassive:Boolean = false;
        
        private var firstClick:Boolean = false;
        
        override public function set buttonMode(param1:Boolean) : void
        {
            super.buttonMode = this._isPassive?false:param1;
        }
        
        public function get isPassive() : Boolean
        {
            return this._isPassive;
        }
        
        public function set isPassive(param1:Boolean) : void
        {
            this._isPassive = param1;
            invalidate(INV_PASSIVE);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            preventAutosizing = true;
            if(this.disableMc)
            {
                this.disableMc.widthFill = Math.round(this.width);
                this.disableMc.heightFill = Math.round(this.height);
            }
            constraints = null;
        }
        
        override public function setSize(param1:Number, param2:Number) : void
        {
            _width = param1;
            _height = param2;
            invalidateSize();
        }
        
        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.STATE))
            {
                if(_newFrame)
                {
                    gotoAndPlay(_newFrame);
                    this.setBackgroundState();
                    if(_baseDisposed)
                    {
                        return;
                    }
                    _newFrame = null;
                }
                if((focusIndicator) && (_newFocusIndicatorFrame))
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                updateAfterStateChange();
                dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
                invalidate(InvalidationType.DATA,InvalidationType.SIZE);
            }
            if(isInvalid(InvalidationType.DATA))
            {
                updateText();
                if(autoSize != TextFieldAutoSize.NONE)
                {
                    invalidateSize();
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                if(!preventAutosizing)
                {
                    alignForAutoSize();
                }
                this.rendererBg.width = _width;
            }
            if(isInvalid(INV_PASSIVE))
            {
                if(this._isPassive)
                {
                    if(App.soundMgr)
                    {
                        App.soundMgr.removeSoundHdlrs(this);
                    }
                }
                else if(App.soundMgr)
                {
                    App.soundMgr.addSoundsHdlrs(this);
                }
                
            }
            this.updateDisable();
        }
        
        override protected function initialize() : void
        {
            super.initialize();
            this._rendererBgLabelsHash = generateLabelHash(this.rendererBg);
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            if(this._isPassive)
            {
                return this.statesPassive;
            }
            return _selected?statesSelected:statesDefault;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:String = null;
            this.stopSimulationDoubleClick();
            for(_loc1_ in this._rendererBgLabelsHash)
            {
                delete this._rendererBgLabelsHash[_loc1_];
                true;
            }
            this._rendererBgLabelsHash = null;
            this.rendererBg = null;
            super.onDispose();
        }
        
        protected function setBackgroundState() : void
        {
            if(this._rendererBgLabelsHash[_newFrame])
            {
                this.rendererBg.gotoAndPlay(_newFrame);
            }
            else
            {
                this.setDefaultBgState();
            }
        }
        
        protected function updateDisable() : void
        {
            if(this.disableMc != null)
            {
                this.disableMc.visible = (_data) && !enabled;
                this.disableMc.scaleX = 1 / this.scaleX;
                this.disableMc.scaleY = 1 / this.scaleY;
                this.disableMc.widthFill = Math.round(this.width * this.scaleX);
                this.disableMc.heightFill = Math.round(this.height * this.scaleY);
            }
        }
        
        protected function startSimulationDoubleClick() : void
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.simulationDoubleClickHandler);
        }
        
        protected function stopSimulationDoubleClick() : void
        {
            App.utils.scheduler.cancelTask(this.clearFirstClick);
            this.stageRemoveListener();
            this.removeEventListener(MouseEvent.MOUSE_DOWN,this.simulationDoubleClickHandler);
        }
        
        private function stageAddListener() : void
        {
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.simulationDoubleClickHandler);
        }
        
        private function stageRemoveListener() : void
        {
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.simulationDoubleClickHandler);
        }
        
        private function setDefaultBgState() : void
        {
            var _loc4_:String = null;
            var _loc5_:String = null;
            var _loc1_:Vector.<String> = this.getStatePrefixes();
            var _loc2_:uint = _loc1_.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = _loc1_[_loc3_];
                _loc5_ = _loc4_ + "up";
                if(this._rendererBgLabelsHash[_loc5_])
                {
                    this.rendererBg.gotoAndPlay(_loc5_);
                    return;
                }
                _loc3_++;
            }
        }
        
        private function clearFirstClick() : void
        {
            this.firstClick = false;
            this.stageRemoveListener();
        }
        
        private function simulationDoubleClickHandler(param1:MouseEvent) : void
        {
            var _loc3_:MouseEventEx = null;
            var _loc4_:uint = 0;
            var _loc5_:uint = 0;
            var _loc6_:MouseEventEx = null;
            var _loc2_:Point = new Point(mouseX,mouseY);
            _loc2_ = this.localToGlobal(_loc2_);
            if(this.hitTestPoint(_loc2_.x,_loc2_.y,true))
            {
                if(this.firstClick)
                {
                    this.stageRemoveListener();
                    App.utils.scheduler.cancelTask(this.clearFirstClick);
                    this.firstClick = false;
                    _loc3_ = param1 as MouseEventEx;
                    _loc4_ = _loc3_ == null?0:_loc3_.mouseIdx;
                    _loc5_ = _loc3_ == null?0:_loc3_.buttonIdx;
                    _loc6_ = new MouseEventEx(MouseEvent.DOUBLE_CLICK);
                    _loc6_.mouseIdx = _loc4_;
                    _loc6_.buttonIdx = _loc5_;
                    dispatchEvent(_loc6_);
                }
                else
                {
                    this.firstClick = true;
                    param1.preventDefault();
                    param1.stopImmediatePropagation();
                    this.stageAddListener();
                    App.utils.scheduler.scheduleTask(this.clearFirstClick,TIME_CLICK);
                }
            }
            else
            {
                this.firstClick = false;
            }
        }
    }
}
