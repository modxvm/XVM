package net.wg.gui.components.windows
{
    import net.wg.infrastructure.base.meta.impl.ModuleInfoMeta;
    import net.wg.infrastructure.base.meta.IModuleInfoMeta;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import net.wg.gui.lobby.moduleInfo.ModuleParameters;
    import net.wg.gui.lobby.moduleInfo.ModuleEffects;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.InteractiveObject;
    import net.wg.utils.IClassFactory;
    import flash.display.MovieClip;
    import flash.text.TextLineMetrics;
    import net.wg.data.constants.FittingTypes;
    import net.wg.data.constants.ValObject;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.utils.Padding;
    import flash.display.DisplayObject;
    import scaleform.clik.core.UIComponent;
    
    public class ModuleInfo extends ModuleInfoMeta implements IModuleInfoMeta
    {
        
        public function ModuleInfo() {
            super();
            this.addedChildren = [];
        }
        
        private static var BOTTOM_PADDING:uint = 15;
        
        private static var MIDDLE_PADDING:uint = 5;
        
        protected static var TF_GUTTER:int = 4;
        
        public var moduleIcon:ExtraModuleIcon;
        
        public var moduleName:TextField;
        
        public var moduleDescription:TextField;
        
        public var moduleParams:ModuleParameters;
        
        public var moduleEffects:ModuleEffects;
        
        public var closeBottomBtn:SoundButtonEx;
        
        private var addedChildren:Array;
        
        private var _moduleInfo:Object;
        
        public function get moduleInfo() : Object {
            return this._moduleInfo;
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void {
            super.onInitModalFocus(param1);
            setFocus(this.closeBottomBtn);
        }
        
        public function set moduleInfo(param1:Object) : void {
            var _loc2_:String = null;
            var _loc3_:* = NaN;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            var _loc6_:* = false;
            var _loc7_:* = NaN;
            var _loc8_:String = null;
            var _loc9_:* = 0;
            var _loc10_:Class = null;
            var _loc11_:ModuleParameters = null;
            var _loc12_:Object = null;
            var _loc13_:Object = null;
            var _loc14_:IClassFactory = null;
            var _loc15_:MovieClip = null;
            var _loc16_:TextField = null;
            var _loc17_:TextLineMetrics = null;
            var _loc18_:* = 0;
            var _loc19_:MovieClip = null;
            var _loc20_:TextField = null;
            this._moduleInfo = param1;
            if(this.moduleInfo)
            {
                _loc2_ = this.moduleInfo.type;
                this.moduleName.text = this.moduleInfo.name;
                _loc3_ = 0;
                if(_loc2_ == FittingTypes.EQUIPMENT)
                {
                    this.moduleDescription.text = "";
                }
                else
                {
                    this.moduleDescription.text = this.moduleInfo.description;
                    _loc3_ = this.moduleDescription.textHeight - this.moduleDescription.height + TF_GUTTER;
                    if(_loc3_ > 0)
                    {
                        this.moduleDescription.height = this.moduleDescription.height + _loc3_;
                        this.moduleParams.y = this.moduleParams.y + _loc3_;
                        this.moduleEffects.y = this.moduleEffects.y + _loc3_;
                    }
                }
                this.moduleIcon.setValues(_loc2_,this.moduleInfo.level);
                this.moduleIcon.extraIconSource = this.moduleInfo[ValObject.EXTRA_MODULE_INFO];
                this.moduleParams.headerText = this.moduleInfo.parameters.headerText;
                this.moduleParams.setParameters(this.moduleInfo.parameters.params);
                this.moduleEffects.setEffects(this.moduleInfo.effects);
                _loc4_ = this.moduleParams.y + this.moduleParams.height;
                if(_loc2_ == FittingTypes.VEHICLE_GUN)
                {
                    _loc8_ = "otherParameters";
                    if(this.moduleInfo.hasOwnProperty(_loc8_))
                    {
                        _loc9_ = 10;
                        _loc10_ = Object(this.moduleParams).constructor;
                        _loc11_ = new _loc10_();
                        _loc12_ = this.moduleInfo[_loc8_];
                        _loc11_.y = _loc4_;
                        _loc11_.x = this.moduleParams.x;
                        _loc11_.height = 45;
                        addChild(_loc11_);
                        this.addedChildren.push(_loc11_);
                        _loc11_.headerText = _loc12_.headerText;
                        _loc11_.setParameters(_loc12_.params);
                        _loc4_ = _loc11_.y + _loc11_.actualHeight + _loc9_;
                    }
                }
                _loc5_ = this.moduleInfo.compatible.length;
                _loc6_ = this.moduleInfo.hasOwnProperty("additionalInfo");
                if(_loc5_ > 0)
                {
                    _loc14_ = App.utils.classFactory;
                    for each(_loc13_ in this.moduleInfo.compatible)
                    {
                        _loc15_ = _loc14_.getObject("ModuleCompatibilityMC") as MovieClip;
                        _loc15_.x = this.moduleParams.x;
                        _loc15_.y = _loc4_;
                        addChild(_loc15_);
                        this.addedChildren.push(_loc15_);
                        _loc15_.header.text = _loc13_.type;
                        _loc16_ = _loc15_.compValue;
                        _loc16_.htmlText = _loc13_.value;
                        _loc17_ = _loc16_.getLineMetrics(0);
                        _loc18_ = _loc17_.leading + _loc17_.descent;
                        _loc16_.height = _loc16_.textHeight + _loc18_;
                        _loc4_ = _loc4_ + (_loc15_.height + (_loc6_?MIDDLE_PADDING:BOTTOM_PADDING));
                    }
                }
                if(_loc6_)
                {
                    _loc19_ = _loc14_.getObject("additionalInfoUI") as MovieClip;
                    _loc19_.x = this.moduleParams.x;
                    _loc19_.y = _loc4_;
                    _loc20_ = _loc19_.textField;
                    _loc20_.text = this.moduleInfo.additionalInfo;
                    addChild(_loc19_);
                    this.addedChildren.push(_loc19_);
                    _loc4_ = _loc4_ + (_loc19_.height + BOTTOM_PADDING);
                }
                _loc7_ = this.moduleEffects.y + this.moduleEffects.height;
                if(_loc4_ < _loc7_)
                {
                    _loc4_ = _loc7_;
                }
                this.closeBottomBtn.y = _loc4_ + MIDDLE_PADDING;
                height = _loc4_ + this.closeBottomBtn.height + MIDDLE_PADDING;
            }
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            this.closeBottomBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
            window.useBottomBtns = true;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.right = _loc1_.right + 10;
            window.contentPadding = _loc1_;
        }
        
        override protected function onDispose() : void {
            var _loc1_:DisplayObject = null;
            this._moduleInfo = null;
            this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
            for each(_loc1_ in this.addedChildren)
            {
                removeChild(_loc1_);
                if(_loc1_ is UIComponent)
                {
                    (_loc1_ as UIComponent).dispose();
                }
            }
            this.addedChildren.splice(0);
            this.addedChildren = null;
            super.onDispose();
        }
        
        private function onClose(param1:ButtonEvent) : void {
            onCancelClickS();
        }
        
        public function as_setModuleInfo(param1:Object) : void {
            window.title = param1.windowTitle;
            this.moduleInfo = param1;
        }
    }
}
