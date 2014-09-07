package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
    import flash.display.MovieClip;
    import scaleform.clik.controls.StatusIndicator;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    import flash.events.Event;
    
    public class BuildingIndicator extends UIComponentEx implements IBuildingIndicator
    {
        
        public function BuildingIndicator()
        {
            this._visible = super.visible;
            super();
            this._components = new <DisplayObject>[this.buildingLevel,this.hpIndicator,this.defResIndicator,this._labels];
            gotoAndPlay("stop");
            this.buildingLevel.mouseEnabled = false;
            this.hpIndicator.mouseEnabled = false;
            this.defResIndicator.mouseEnabled = false;
            this._labels.mouseEnabled = false;
            this._labels.visible = false;
            this.mouseChildren = false;
            this._deltaTime = DURATION / this._numCycles;
        }
        
        private static var DURATION:int = 800;
        
        public var buildingLevel:MovieClip;
        
        public var hpIndicator:StatusIndicator;
        
        public var defResIndicator:StatusIndicator;
        
        private var _labels:IndicatorLabels;
        
        private var _currentHpValue:int = 0;
        
        private var _targetHpValue:int = 0;
        
        private var _deltaHpPerAnim:int = 0;
        
        private var _currentDefResValue:int = 0;
        
        private var _targetDefResValue:int = 0;
        
        private var _deltaDefResPerAnim:int = 0;
        
        private var _isHpInitialized:Boolean = false;
        
        private var _isDefresInitialized:Boolean = false;
        
        private var _numCycles:int = 20;
        
        private var _deltaTime:int = 0;
        
        private var _playAnimation:Boolean = true;
        
        private var _components:Vector.<DisplayObject>;
        
        private var _visible:Boolean;
        
        public function applyVOData(param1:BuildingBaseVO) : void
        {
            this.hpIndicator.maximum = param1.maxHpValue;
            this.defResIndicator.maximum = param1.maxDefResValue;
            this.setHpValue(param1.hpVal);
            this.setDefResValue(param1.defResVal);
            this.buildingLevel.gotoAndStop(param1.buildingLevel);
        }
        
        override protected function onDispose() : void
        {
            this._components.splice(0,this._components.length);
            this._components = null;
            App.utils.scheduler.cancelTask(this.updateHp);
            App.utils.scheduler.cancelTask(this.updateDefRes);
            this.hpIndicator.dispose();
            this.hpIndicator = null;
            this.defResIndicator.dispose();
            this.defResIndicator = null;
            this._labels = null;
            this.buildingLevel = null;
            super.onDispose();
        }
        
        override public function set visible(param1:Boolean) : void
        {
            var _loc2_:DisplayObject = null;
            for each(_loc2_ in this._components)
            {
                _loc2_.visible = param1;
            }
            this._visible = param1;
        }
        
        override public function get visible() : Boolean
        {
            return this._visible;
        }
        
        override protected function addedToStage(param1:Event) : void
        {
            super.addedToStage(param1);
        }
        
        private function setHpValue(param1:int) : void
        {
            if(!this._isHpInitialized || !this._playAnimation)
            {
                this.hpIndicator.value = this._currentHpValue = this._targetHpValue = param1;
                this._labels.hpValue.htmlText = App.utils.locale.integer(this._currentHpValue);
                this._isHpInitialized = true;
                App.utils.scheduler.cancelTask(this.updateHp);
                return;
            }
            this._targetHpValue = param1;
            this._currentHpValue = this.hpIndicator.value;
            var _loc2_:int = param1 - this._currentHpValue >= 0?1:-1;
            var _loc3_:int = Math.abs(param1 - this._currentHpValue);
            this._deltaHpPerAnim = _loc2_ * Math.ceil(_loc3_ / this._numCycles);
            App.utils.scheduler.scheduleTask(this.updateHp,this._deltaTime);
        }
        
        private function setDefResValue(param1:int) : void
        {
            if(!this._isDefresInitialized || !this._playAnimation)
            {
                this.defResIndicator.value = this._currentDefResValue = this._targetDefResValue = param1;
                this._labels.defResValue.htmlText = App.utils.locale.integer(this._currentDefResValue);
                this._isDefresInitialized = true;
                App.utils.scheduler.cancelTask(this.updateDefRes);
                return;
            }
            this._targetDefResValue = param1;
            this._currentDefResValue = this.defResIndicator.value;
            var _loc2_:int = param1 - this._currentDefResValue >= 0?1:-1;
            var _loc3_:int = Math.abs(param1 - this._currentDefResValue);
            this._deltaDefResPerAnim = _loc2_ * Math.ceil(_loc3_ / this._numCycles);
            App.utils.scheduler.scheduleTask(this.updateDefRes,this._deltaTime);
        }
        
        private function updateHp() : void
        {
            var _loc1_:int = this._deltaHpPerAnim >= 0?1:-1;
            if(_loc1_ * (this._currentHpValue + this._deltaHpPerAnim) < _loc1_ * this._targetHpValue)
            {
                this._currentHpValue = this._currentHpValue + this._deltaHpPerAnim;
                this.hpIndicator.value = this._currentHpValue;
                this._labels.hpValue.htmlText = App.utils.locale.integer(this._currentHpValue);
                App.utils.scheduler.scheduleTask(this.updateHp,this._deltaTime);
            }
            else
            {
                App.utils.scheduler.cancelTask(this.updateHp);
                this._currentHpValue = this._targetHpValue;
                this.hpIndicator.value = this._currentHpValue;
                this._labels.hpValue.htmlText = App.utils.locale.integer(this._currentHpValue);
            }
        }
        
        private function updateDefRes() : void
        {
            var _loc1_:int = this._deltaDefResPerAnim >= 0?1:-1;
            if(_loc1_ * (this._currentDefResValue + this._deltaDefResPerAnim) < _loc1_ * this._targetDefResValue)
            {
                this._currentDefResValue = this._currentDefResValue + this._deltaDefResPerAnim;
                this.defResIndicator.value = this._currentDefResValue;
                this._labels.defResValue.htmlText = App.utils.locale.integer(this._currentDefResValue);
                App.utils.scheduler.scheduleTask(this.updateDefRes,this._deltaTime);
            }
            else
            {
                App.utils.scheduler.cancelTask(this.updateDefRes);
                this._currentDefResValue = this._targetDefResValue;
                this.defResIndicator.value = this._currentDefResValue;
                this._labels.defResValue.htmlText = App.utils.locale.integer(this._currentDefResValue);
            }
        }
        
        public function get labels() : IndicatorLabels
        {
            return this._labels;
        }
        
        public function set labels(param1:IndicatorLabels) : void
        {
            this._labels = param1;
        }
        
        public function get defResIndicatorComponent() : StatusIndicator
        {
            return this.defResIndicator;
        }
        
        public function get playAnimation() : Boolean
        {
            return this._playAnimation;
        }
        
        public function set playAnimation(param1:Boolean) : void
        {
            this._playAnimation = param1;
        }
    }
}
