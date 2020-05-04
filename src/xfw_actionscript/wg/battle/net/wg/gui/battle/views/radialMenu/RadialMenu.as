package net.wg.gui.battle.views.radialMenu
{
    import net.wg.infrastructure.base.meta.impl.RadialMenuMeta;
    import net.wg.infrastructure.base.meta.IRadialMenuMeta;
    import net.wg.gui.battle.views.radialMenu.components.BackGround;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.data.constants.KeyProps;
    import net.wg.data.constants.InteractiveStates;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;

    public class RadialMenu extends RadialMenuMeta implements IRadialMenuMeta
    {

        private static const DEFAULT_NONE_KEY:String = "";

        private static const BACK_ALPHA:Number = 0.6;

        private static const INTERNAL_MENU_RADIUS:int = 50;

        private static const POINT_RADIUS:int = 160;

        private static const EFFECT_TIME:int = 900;

        private static const PAUSE_BEFORE_HIDE:int = 300;

        protected static const CIRCLE_DEGREES:int = 360;

        private static const OFFSET_ANGLE:int = 45;

        private static const HIDE_STATE:String = "hide";

        public var negativeBtn:RadialButton = null;

        public var toBaseBtn:RadialButton = null;

        public var helpBtn:RadialButton = null;

        public var reloadBtn:RadialButton = null;

        public var attackBtn:RadialButton = null;

        public var positiveBtn:RadialButton = null;

        public var background:BackGround = null;

        public var pane:BattleAtlasSprite = null;

        private var _stateMap:Dictionary;

        private var _state:String = "default";

        private var _stageWidth:int = 0;

        private var _stageHeight:int = 0;

        private var _wheelPosition:int = -1;

        private var _scaleKoefX:Number = 1;

        private var _scaleKoefY:Number = 1;

        private var _mouseOffset:Point;

        private var _isAction:Boolean = false;

        private var _buttons:Vector.<RadialButton> = null;

        private var _buttonsCount:int = 6;

        private var _hideWithAnimationState:Boolean = false;

        public function RadialMenu()
        {
            this._stateMap = new Dictionary();
            this._mouseOffset = new Point(0,0);
            super();
            this._buttons = this.getButtons();
            this._buttonsCount = this._buttons.length;
            this.internalHide();
            this.updateButtons();
        }

        protected static function hideButton(param1:Array) : void
        {
            var _loc2_:RadialButton = param1[0];
            _loc2_.state = HIDE_STATE;
        }

        protected function getButtons() : Vector.<RadialButton>
        {
            return new <RadialButton>[this.negativeBtn,this.toBaseBtn,this.helpBtn,this.reloadBtn,this.attackBtn,this.positiveBtn];
        }

        override protected function buildData(param1:Array) : void
        {
            var _loc3_:String = null;
            var _loc2_:int = param1.length;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_ = param1[_loc4_].state;
                this._stateMap[_loc3_] = param1[_loc4_].data;
                _loc4_++;
            }
        }

        override protected function show(param1:String, param2:Array, param3:Array) : void
        {
            this._isAction = false;
            this._state = param1;
            App.utils.scheduler.cancelTask(this.internalHide);
            App.utils.scheduler.cancelTask(hideButton);
            this.updateData();
            this.internalShow();
            x = param2[0];
            y = param2[1];
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.background.setSize(this._stageWidth,this._stageHeight);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.configBG();
        }

        protected function configBG() : void
        {
            this.pane.imageName = BATTLEATLAS.RADIAL_MENU_BACKGROUND;
            this.background.setBackgroundAlpha(BACK_ALPHA);
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.internalHide);
            App.utils.scheduler.cancelTask(hideButton);
            this.internalHide();
            this._buttons.length = 0;
            App.utils.data.cleanupDynamicObject(this._stateMap);
            this.negativeBtn.dispose();
            this.negativeBtn = null;
            this.toBaseBtn.dispose();
            this.toBaseBtn = null;
            this.helpBtn.dispose();
            this.helpBtn = null;
            this.reloadBtn.dispose();
            this.reloadBtn = null;
            this.attackBtn.dispose();
            this.attackBtn = null;
            this.positiveBtn.dispose();
            this.positiveBtn = null;
            this.background.dispose();
            this.background = null;
            this.pane = null;
            this._stateMap = null;
            this._mouseOffset = null;
            this._buttons = null;
            super.onDispose();
        }

        public function as_hide() : void
        {
            this.action();
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this._stageWidth = param1;
            this._stageHeight = param2;
            invalidate(InvalidationType.SIZE);
        }

        protected function updateData() : void
        {
            var _loc3_:Object = null;
            var _loc1_:Array = this._stateMap[this._state];
            var _loc2_:uint = 0;
            while(_loc2_ < this._buttonsCount)
            {
                _loc3_ = this.getButtonData(_loc1_,_loc2_);
                this.updateButton(this._buttons[_loc2_],_loc3_);
                _loc2_++;
            }
        }

        protected function updateButton(param1:RadialButton, param2:Object) : void
        {
            if(param2 != null)
            {
                param1.title = param2.title;
                param1.action = param2.action;
                param1.icon = param2.icon;
                if(!isNaN(param2.key) && param2.key != KeyProps.KEY_NONE)
                {
                    param1.hotKey = App.utils.commons.keyToString(param2.key).keyName;
                }
                else
                {
                    param1.hotKey = DEFAULT_NONE_KEY;
                }
            }
            param1.enabled = false;
        }

        protected final function getStateData(param1:String) : Array
        {
            return this._stateMap[param1];
        }

        protected function getButtonData(param1:Array, param2:uint) : Object
        {
            return param1[param2];
        }

        protected function selectButton(param1:RadialButton) : void
        {
            if(!param1.selected)
            {
                param1.state = InteractiveStates.OVER;
                param1.selected = true;
                onSelectS();
            }
        }

        protected function unSelectButton(param1:RadialButton) : void
        {
            if(param1.selected)
            {
                param1.state = InteractiveStates.OUT;
                param1.selected = false;
            }
        }

        protected function cancelButton(param1:RadialButton) : void
        {
            param1.state = InteractiveStates.UP;
            param1.selected = false;
        }

        protected function internalShow() : void
        {
            this._scaleKoefX = 1 / App.stage.scaleX;
            this._scaleKoefY = 1 / App.stage.scaleY;
            this._hideWithAnimationState = false;
            visible = true;
            if(this.pane != null)
            {
                this.pane.visible = true;
            }
            this.background.visible = true;
            var _loc1_:uint = 0;
            while(_loc1_ < this._buttonsCount)
            {
                this.cancelButton(this._buttons[_loc1_]);
                this._buttons[_loc1_].visible = true;
                _loc1_++;
            }
            if(App.stage)
            {
                App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
                App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDownHandler);
                App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            }
            this._mouseOffset.x = 0;
            this._mouseOffset.y = 0;
            this._wheelPosition = -1;
        }

        protected function hideWithAnimation() : void
        {
            App.utils.scheduler.scheduleTask(this.internalHide,EFFECT_TIME);
            this._hideWithAnimationState = true;
            if(App.stage)
            {
                App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
                App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDownHandler);
                App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            }
        }

        protected function internalHide() : void
        {
            visible = false;
            this._hideWithAnimationState = false;
            if(App.stage)
            {
                App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
                App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onButtonMouseDownHandler);
                App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            }
        }

        protected function updateButtons() : void
        {
            var _loc2_:RadialButton = null;
            var _loc3_:* = NaN;
            var _loc1_:Number = (CIRCLE_DEGREES - (OFFSET_ANGLE << 1)) / this._buttons.length;
            var _loc4_:uint = 0;
            while(_loc4_ < this._buttonsCount)
            {
                _loc2_ = this._buttons[_loc4_];
                _loc3_ = _loc1_ * _loc4_ + OFFSET_ANGLE;
                if(_loc4_ > this._buttonsCount >> 1 - 1)
                {
                    _loc3_ = -CIRCLE_DEGREES + _loc3_ + OFFSET_ANGLE;
                }
                _loc2_.angle = _loc3_;
                _loc4_++;
            }
        }

        protected function action() : void
        {
            var _loc1_:* = false;
            var _loc2_:RadialButton = null;
            var _loc3_:* = NaN;
            if(this.visible)
            {
                _loc1_ = false;
                _loc3_ = 0;
                while(_loc3_ < this._buttonsCount)
                {
                    _loc2_ = this._buttons[_loc3_];
                    if(_loc2_.selected)
                    {
                        App.utils.scheduler.scheduleTask(hideButton,PAUSE_BEFORE_HIDE,[_loc2_]);
                        this._isAction = true;
                        onActionS(_loc2_.action);
                        _loc1_ = true;
                    }
                    else
                    {
                        this._buttons[_loc3_].visible = false;
                    }
                    _loc3_++;
                }
                if(_loc1_)
                {
                    this.onHideFromSchedule();
                    this.background.visible = false;
                    this.hideWithAnimation();
                }
                else
                {
                    this.internalHide();
                }
            }
        }

        protected function onHideFromSchedule() : void
        {
            this.pane.visible = false;
        }

        override public function get visible() : Boolean
        {
            return !this._hideWithAnimationState && super.visible;
        }

        private function onButtonMouseDownHandler(param1:MouseEvent) : void
        {
            this.onButtonMouseDown(param1);
        }

        protected function onButtonMouseDown(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx)
            {
                if(MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON)
                {
                    this.internalHide();
                }
                else if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
                {
                    this.action();
                }
            }
        }

        private function onMouseMoveHandler(param1:MouseEvent) : void
        {
            this.onMouseMove(param1);
        }

        protected function onMouseMove(param1:MouseEvent) : void
        {
            var _loc2_:uint = 0;
            var _loc3_:Point = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:RadialButton = null;
            if(this.visible && !this._isAction)
            {
                this._wheelPosition = -1;
                _loc2_ = 0;
                _loc3_ = new Point(this.mouseX,this.mouseY);
                _loc4_ = _loc3_.x - this._mouseOffset.x;
                _loc5_ = _loc3_.y - this._mouseOffset.y;
                _loc6_ = Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_);
                if(_loc6_ > INTERNAL_MENU_RADIUS)
                {
                    _loc7_ = Math.atan2(_loc5_,_loc4_);
                    _loc8_ = POINT_RADIUS * Math.cos(_loc7_);
                    _loc9_ = POINT_RADIUS * Math.sin(_loc7_);
                    _loc3_.x = _loc8_;
                    _loc3_.y = _loc9_;
                    if(_loc6_ > POINT_RADIUS)
                    {
                        this._mouseOffset.x = this.mouseX - _loc8_;
                        this._mouseOffset.y = this.mouseY - _loc9_;
                    }
                    if(_loc6_ > INTERNAL_MENU_RADIUS)
                    {
                        _loc3_ = this.localToGlobal(_loc3_);
                        while(_loc2_ < this._buttonsCount)
                        {
                            _loc10_ = this._buttons[_loc2_];
                            if(_loc10_.hitAreaSpr.hitTestPoint(_loc3_.x * this._scaleKoefX,_loc3_.y * this._scaleKoefY,true))
                            {
                                this.selectButton(_loc10_);
                            }
                            else
                            {
                                this.unSelectButton(_loc10_);
                            }
                            _loc2_++;
                        }
                    }
                }
                else
                {
                    while(_loc2_ < this._buttonsCount)
                    {
                        this.unSelectButton(this._buttons[_loc2_]);
                        _loc2_++;
                    }
                    return;
                }
            }
        }

        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            this.onMouseWheel(param1);
        }

        protected function onMouseWheel(param1:MouseEvent) : void
        {
            var _loc2_:* = 0;
            var _loc3_:RadialButton = null;
            var _loc4_:uint = 0;
            if(this.visible && !this._isAction)
            {
                _loc2_ = param1.delta;
                if(this._wheelPosition == -1)
                {
                    _loc4_ = 0;
                    while(_loc4_ < this._buttonsCount)
                    {
                        _loc3_ = this._buttons[_loc4_];
                        if(_loc3_.selected)
                        {
                            this._wheelPosition = _loc4_;
                            break;
                        }
                        _loc4_++;
                    }
                }
                if(this._wheelPosition > -1)
                {
                    this.unSelectButton(this._buttons[this._wheelPosition]);
                }
                if(_loc2_ < 0)
                {
                    this._wheelPosition++;
                    if(this._wheelPosition >= this._buttonsCount)
                    {
                        this._wheelPosition = 0;
                    }
                }
                else
                {
                    this._wheelPosition--;
                    if(this._wheelPosition < 0)
                    {
                        this._wheelPosition = this._buttonsCount - 1;
                    }
                }
                this.selectButton(this._buttons[this._wheelPosition]);
            }
        }

        protected function get state() : String
        {
            return this._state;
        }

        protected function get isAction() : Boolean
        {
            return this._isAction;
        }

        protected function get buttons() : Vector.<RadialButton>
        {
            return this._buttons;
        }

        protected function get buttonsCount() : int
        {
            return this._buttonsCount;
        }

        protected function get scaleKoefX() : Number
        {
            return this._scaleKoefX;
        }

        protected function get scaleKoefY() : Number
        {
            return this._scaleKoefY;
        }
    }
}
