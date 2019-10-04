package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.ModuleInfoMeta;
    import net.wg.infrastructure.base.meta.IModuleInfoMeta;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import net.wg.gui.lobby.moduleInfo.ModuleParameters;
    import net.wg.gui.lobby.moduleInfo.ModuleEffects;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.utils.Padding;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.hangar.data.ModuleInfoActionVO;
    import net.wg.utils.IClassFactory;
    import flash.display.MovieClip;
    import flash.text.TextLineMetrics;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.ValObject;

    public class ModuleInfo extends ModuleInfoMeta implements IModuleInfoMeta
    {

        protected static const TF_GUTTER:int = 4;

        private static const ADDITIONAL_RIGHT_PADDING:int = 10;

        private static const PARAMS_BLOCK_PADDING:int = 10;

        private static const BOTTOM_PADDING:uint = 15;

        private static const MIDDLE_PADDING:uint = 5;

        private static const OTHER_PARAMS_HEIGHT:int = 45;

        private static const FIELD_ADD_PARAMS:String = "addParams";

        private static const FIELD_VALUE:String = "value";

        private static const FIELD_TYPE:String = "type";

        private static const FIELD_ADDITIONAL_INFO:String = "additionalInfo";

        private static const FIELD_OTHER_PARAMS:String = "otherParameters";

        private static const LINKAGE_ADDITIONAL_INFO:String = "additionalInfoUI";

        private static const LINKAGE_MODULE_COMPATIBILITY_MC:String = "ModuleCompatibilityMC_UI";

        public var moduleIcon:ExtraModuleIcon;

        public var moduleName:TextField;

        public var moduleDescription:TextField;

        public var moduleParams:ModuleParameters;

        public var moduleEffects:ModuleEffects;

        public var closeBottomBtn:SoundButtonEx;

        public var actionButtonBottom:SoundButtonEx;

        public var paramAddValue:TextField;

        public var paramAddType:TextField;

        private var _addedChildren:Array;

        private var _moduleInfo:Object;

        public function ModuleInfo()
        {
            super();
            this._addedChildren = [];
            TextFieldEx.setVerticalAlign(this.paramAddValue,TextFieldEx.VALIGN_BOTTOM);
            TextFieldEx.setVerticalAlign(this.paramAddType,TextFieldEx.VALIGN_BOTTOM);
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.closeBottomBtn);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.closeBottomBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
            this.actionButtonBottom.addEventListener(ButtonEvent.CLICK,this.onActionButtonBottomClickHandler);
            window.useBottomBtns = true;
            var _loc1_:Padding = window.contentPadding as Padding;
            App.utils.asserter.assertNotNull(_loc1_,Errors.CANT_NULL);
            _loc1_.right = _loc1_.right + ADDITIONAL_RIGHT_PADDING;
            window.contentPadding = _loc1_;
        }

        override protected function onDispose() : void
        {
            var _loc1_:DisplayObject = null;
            if(this.moduleIcon != null)
            {
                this.moduleIcon.dispose();
                this.moduleIcon = null;
            }
            this.moduleName = null;
            this.moduleDescription = null;
            if(this.moduleParams != null)
            {
                this.moduleParams.dispose();
                this.moduleParams = null;
            }
            if(this.moduleEffects != null)
            {
                this.moduleEffects.dispose();
                this.moduleEffects = null;
            }
            if(this.closeBottomBtn != null)
            {
                this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
                this.closeBottomBtn.dispose();
                this.closeBottomBtn = null;
            }
            if(this.actionButtonBottom != null)
            {
                this.actionButtonBottom.removeEventListener(ButtonEvent.CLICK,this.onActionButtonBottomClickHandler);
                this.actionButtonBottom.dispose();
                this.actionButtonBottom = null;
            }
            this.paramAddType = null;
            this.paramAddValue = null;
            App.utils.data.cleanupDynamicObject(this._moduleInfo);
            this._moduleInfo = null;
            for each(_loc1_ in this._addedChildren)
            {
                removeChild(_loc1_);
                if(_loc1_ is UIComponent)
                {
                    (_loc1_ as UIComponent).dispose();
                }
            }
            this._addedChildren.splice(0);
            this._addedChildren = null;
            super.onDispose();
        }

        override protected function setActionButton(param1:ModuleInfoActionVO) : void
        {
            var _loc2_:* = false;
            _loc2_ = param1.visible;
            this.actionButtonBottom.visible = _loc2_;
            if(_loc2_)
            {
                this.actionButtonBottom.label = param1.label;
            }
        }

        public function as_setModuleInfo(param1:Object) : void
        {
            window.title = param1.windowTitle;
            this.moduleInfo = param1;
        }

        public function get moduleInfo() : Object
        {
            return this._moduleInfo;
        }

        public function set moduleInfo(param1:Object) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = NaN;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            var _loc6_:* = false;
            var _loc7_:* = NaN;
            var _loc8_:Class = null;
            var _loc9_:ModuleParameters = null;
            var _loc10_:Object = null;
            var _loc11_:Object = null;
            var _loc12_:IClassFactory = null;
            var _loc13_:MovieClip = null;
            var _loc14_:TextLineMetrics = null;
            var _loc15_:* = 0;
            var _loc16_:TextField = null;
            var _loc17_:MovieClip = null;
            var _loc18_:TextField = null;
            this._moduleInfo = param1;
            if(this.moduleInfo)
            {
                _loc2_ = this.moduleInfo.type;
                this.moduleName.text = this.moduleInfo.name;
                _loc3_ = 0;
                if(_loc2_ == FITTING_TYPES.EQUIPMENT)
                {
                    this.moduleDescription.text = Values.EMPTY_STR;
                    if(this.moduleInfo.hasOwnProperty(FIELD_ADD_PARAMS))
                    {
                        TextFieldEx.appendHtml(this.paramAddValue,this.moduleInfo.addParams[FIELD_VALUE]);
                        TextFieldEx.appendHtml(this.paramAddType,this.moduleInfo.addParams[FIELD_TYPE]);
                    }
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
                this.moduleIcon.setValueLabel(this.moduleInfo.moduleLabel,this.moduleInfo.moduleLevel);
                this.moduleIcon.extraIconSource = this.moduleInfo[ValObject.EXTRA_MODULE_INFO];
                this.moduleIcon.setHighlightType(this.moduleInfo.highlightType);
                this.moduleIcon.setOverlayType(this.moduleInfo.overlayType);
                this.moduleParams.headerText = this.moduleInfo.parameters.headerText;
                this.moduleParams.setParameters(this.moduleInfo.parameters.params);
                this.moduleEffects.setEffects(this.moduleInfo.effects);
                _loc4_ = this.moduleParams.y + this.moduleParams.height;
                if(_loc2_ == FITTING_TYPES.VEHICLE_GUN)
                {
                    if(this.moduleInfo.hasOwnProperty(FIELD_OTHER_PARAMS))
                    {
                        _loc8_ = Object(this.moduleParams).constructor;
                        _loc9_ = new _loc8_();
                        _loc10_ = this.moduleInfo[FIELD_OTHER_PARAMS];
                        _loc9_.y = _loc4_;
                        _loc9_.x = this.moduleParams.x;
                        _loc9_.height = OTHER_PARAMS_HEIGHT;
                        addChild(_loc9_);
                        this._addedChildren.push(_loc9_);
                        _loc9_.headerText = _loc10_.headerText;
                        _loc9_.setParameters(_loc10_.params);
                        _loc4_ = _loc9_.y + _loc9_.actualHeight + PARAMS_BLOCK_PADDING;
                    }
                }
                _loc5_ = this.moduleInfo.compatible.length;
                _loc6_ = this.moduleInfo.hasOwnProperty(FIELD_ADDITIONAL_INFO);
                if(_loc5_ > 0)
                {
                    _loc12_ = App.utils.classFactory;
                    for each(_loc11_ in this.moduleInfo.compatible)
                    {
                        _loc13_ = _loc12_.getComponent(LINKAGE_MODULE_COMPATIBILITY_MC,MovieClip) as MovieClip;
                        App.utils.asserter.assertNotNull(_loc13_,Errors.CANT_NULL);
                        _loc13_.x = this.moduleParams.x;
                        _loc13_.y = _loc4_;
                        addChild(_loc13_);
                        this._addedChildren.push(_loc13_);
                        _loc13_.header.text = _loc11_.type;
                        _loc16_ = _loc13_.compValue;
                        _loc16_.htmlText = _loc11_.value;
                        _loc14_ = _loc16_.getLineMetrics(0);
                        _loc15_ = _loc14_.leading + _loc14_.descent;
                        _loc16_.height = _loc16_.textHeight + _loc15_;
                        _loc4_ = _loc4_ + (_loc13_.height + (_loc6_?MIDDLE_PADDING:BOTTOM_PADDING));
                    }
                }
                if(_loc6_)
                {
                    _loc17_ = _loc12_.getComponent(LINKAGE_ADDITIONAL_INFO,MovieClip) as MovieClip;
                    App.utils.asserter.assertNotNull(_loc17_,Errors.CANT_NULL);
                    _loc17_.x = this.moduleParams.x;
                    _loc17_.y = _loc4_;
                    _loc18_ = _loc17_.textField;
                    _loc18_.text = this.moduleInfo.additionalInfo;
                    addChild(_loc17_);
                    this._addedChildren.push(_loc17_);
                    _loc4_ = _loc4_ + (_loc17_.height + BOTTOM_PADDING);
                }
                _loc7_ = this.moduleEffects.y + this.moduleEffects.height;
                if(_loc4_ < _loc7_)
                {
                    _loc4_ = _loc7_;
                }
                this.closeBottomBtn.y = _loc4_ + MIDDLE_PADDING;
                this.actionButtonBottom.y = this.closeBottomBtn.y;
                height = _loc4_ + this.closeBottomBtn.height + MIDDLE_PADDING;
            }
        }

        private function onCloseBottomBtnClickHandler(param1:ButtonEvent) : void
        {
            onCancelClickS();
        }

        private function onActionButtonBottomClickHandler(param1:ButtonEvent) : void
        {
            onActionButtonClickS();
        }
    }
}
