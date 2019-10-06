package net.wg.infrastructure.tutorial.builders.bootcamp
{
    import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
    import flash.utils.Dictionary;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
    import scaleform.clik.motion.Tween;
    import flash.display.DisplayObject;
    import net.wg.gui.components.advanced.vo.TutorialDisplayEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialTweenEffectVO;
    import fl.motion.easing.Cubic;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.data.daapi.base.DAAPIDataClass;
    import flash.events.Event;

    public class TutorialAmmunitionEffectBuilder extends TutorialEffectBuilder
    {

        private static const MODULES_SLOT_SPACING:Number = 3;

        private static const SEPARATOR_WIDTH:Number = 18;

        private static const SLOT_SPACING:Number = 2;

        private static const SHIFT_DURATION:Number = 250;

        private var _displayObjects:Dictionary;

        private var _optionalDevices:Vector.<Sprite> = null;

        private var _equipment:Vector.<Sprite> = null;

        private var _shells:Vector.<Sprite> = null;

        private var _modules:Vector.<Sprite> = null;

        private var _components:Vector.<Sprite>;

        private var _ammunitionPanel:AmmunitionPanel;

        private var _module1:Sprite = null;

        private var _optionalDevice1:Sprite = null;

        private var _equipment1:Sprite = null;

        private var _shell1:Sprite = null;

        private var _tweenFactory:TweenFactory;

        private var _tweens:Vector.<Tween>;

        private var _appearComponent:DisplayObject;

        private var _displayVO:TutorialDisplayEffectVO;

        private var _tweenVO:TutorialTweenEffectVO;

        public function TutorialAmmunitionEffectBuilder()
        {
            this._displayObjects = new Dictionary();
            this._components = new Vector.<Sprite>(0);
            this._tweenFactory = new TweenFactory();
            this._tweens = new Vector.<Tween>(0);
            super();
        }

        override protected function createEffect(param1:Object) : void
        {
            super.createEffect(param1);
            this.updateLayout();
        }

        override protected function onViewResize() : void
        {
        }

        override protected function onDispose() : void
        {
            this._optionalDevices.splice(0,this._optionalDevices.length);
            this._optionalDevices = null;
            this._equipment.splice(0,this._equipment.length);
            this._equipment = null;
            this._shells.splice(0,this._shells.length);
            this._shells = null;
            this._modules.splice(0,this._modules.length);
            this._modules = null;
            App.utils.data.cleanupDynamicObject(this._displayObjects);
            this._displayObjects = null;
            this._ammunitionPanel = null;
            this._module1 = null;
            this._optionalDevice1 = null;
            this._equipment1 = null;
            this._shell1 = null;
            this._tweenFactory = null;
            this.disposeTweens();
            this._tweens = null;
            this._appearComponent = null;
            this.disposeModel(this._displayVO);
            this._displayVO = null;
            this.disposeModel(this._tweenVO);
            this._tweenVO = null;
            this._components.splice(0,this._components.length);
            this._components = null;
            super.onDispose();
        }

        public function tweenToX(param1:Sprite, param2:Number) : void
        {
            var _loc3_:Tween = new Tween(SHIFT_DURATION,param1,{"x":param2},{
                "paused":false,
                "ease":Cubic.easeOut
            });
            _loc3_.fastTransform = false;
            this._tweens.push(_loc3_);
        }

        protected function updateLayout(param1:DisplayObject = null) : void
        {
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc10_:* = 0;
            var _loc11_:* = 0;
            var _loc12_:* = 0;
            var _loc13_:* = NaN;
            var _loc14_:* = false;
            if(!this._ammunitionPanel)
            {
                this.setPanel(AmmunitionPanel(this.component));
            }
            var _loc2_:* = param1 != null;
            var _loc3_:* = !this._module1.visible;
            var _loc4_:* = !this._optionalDevice1.visible;
            var _loc5_:* = !this._equipment1.visible;
            var _loc6_:* = !this._shell1.visible;
            if(_loc2_)
            {
                this.disposeTweens();
            }
            var _loc7_:Boolean = _loc3_ || _loc4_ || _loc6_ || _loc5_;
            if(_loc7_)
            {
                _loc8_ = 0;
                _loc9_ = this._module1.width;
                _loc10_ = this._optionalDevice1.width;
                _loc11_ = this._shell1.width;
                _loc12_ = this._equipment1.width;
                if(!_loc3_)
                {
                    _loc8_ = _loc8_ + this._modules.length * (_loc9_ + MODULES_SLOT_SPACING);
                }
                if(!_loc4_)
                {
                    _loc8_ = _loc8_ + (SEPARATOR_WIDTH + this._optionalDevices.length * (_loc10_ + SLOT_SPACING));
                }
                if(!_loc6_)
                {
                    _loc8_ = _loc8_ + (SEPARATOR_WIDTH + this._shells.length * (_loc11_ + SLOT_SPACING));
                }
                if(!_loc5_)
                {
                    _loc8_ = _loc8_ + (SEPARATOR_WIDTH + this._equipment.length * (_loc12_ + SLOT_SPACING));
                }
                _loc13_ = this._ammunitionPanel.width - _loc8_ >> 1;
                if(!_loc3_)
                {
                    _loc14_ = !_loc2_ || this._modules.indexOf(param1) != -1;
                    _loc13_ = this.setGroupPos(this._modules,_loc13_,_loc9_,MODULES_SLOT_SPACING,_loc14_);
                    _loc13_ = _loc13_ + SEPARATOR_WIDTH;
                }
                if(!_loc4_)
                {
                    _loc14_ = !_loc2_ || this._optionalDevices.indexOf(param1) != -1;
                    _loc13_ = this.setGroupPos(this._optionalDevices,_loc13_,_loc10_,SLOT_SPACING,_loc14_);
                    _loc13_ = _loc13_ + SEPARATOR_WIDTH;
                }
                if(!_loc6_)
                {
                    _loc13_ = this.setGroupPos(this._shells,_loc13_,_loc11_,SLOT_SPACING,true);
                    _loc13_ = _loc13_ + SEPARATOR_WIDTH;
                }
                if(!_loc5_)
                {
                    _loc14_ = !_loc2_ || this._equipment.indexOf(param1) != -1;
                    this.setGroupPos(this._equipment,_loc13_,_loc12_,SLOT_SPACING,_loc14_);
                }
            }
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }

        private function setGroupPos(param1:Vector.<Sprite>, param2:int, param3:int, param4:int, param5:Boolean) : int
        {
            var _loc7_:Sprite = null;
            var _loc6_:int = param2;
            for each(_loc7_ in param1)
            {
                if(param5)
                {
                    _loc7_.x = _loc6_;
                }
                else
                {
                    this.tweenToX(_loc7_,_loc6_);
                }
                _loc6_ = _loc6_ + (param3 + param4);
            }
            return _loc6_ - param4;
        }

        private function setPanel(param1:AmmunitionPanel) : void
        {
            var _loc3_:DisplayObject = null;
            this._ammunitionPanel = param1;
            this._module1 = param1.gun;
            this._optionalDevice1 = param1.optionalDevice1;
            this._equipment1 = param1.equipment1;
            this._shell1 = param1.shell1;
            this._modules = new <Sprite>[this._module1,param1.turret,param1.chassis,param1.engine,param1.radio];
            this._optionalDevices = new <Sprite>[this._optionalDevice1,param1.optionalDevice2,param1.optionalDevice3];
            this._equipment = new <Sprite>[this._equipment1,param1.equipment2,param1.equipment3];
            this._shells = new <Sprite>[this._shell1,param1.shell2,param1.shell3];
            this._components = this._modules.concat(this._optionalDevices,this._equipment,this._shells);
            var _loc2_:Array = [this._module1,this._optionalDevice1,this._equipment1,this._shell1];
            for each(_loc3_ in _loc2_)
            {
                _loc3_.addEventListener(ComponentEvent.SHOW,this.onComponentShowHandler);
                _loc3_.addEventListener(ComponentEvent.HIDE,this.onComponentHideHandler);
            }
            _loc2_.splice(0);
        }

        private function disposeModel(param1:DAAPIDataClass) : void
        {
            if(param1 != null)
            {
                param1.dispose();
            }
        }

        private function onComponentHideHandler(param1:Event) : void
        {
            this.updateLayout();
        }

        private function onComponentShowHandler(param1:Event) : void
        {
            this.updateLayout(DisplayObject(param1.target));
        }
    }
}
