package net.wg.gui.lobby.modulesPanel.components
{
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.modulesPanel.data.BoosterFittingItemVO;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.SoundTypes;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.events.MouseEvent;
    import net.wg.gui.events.DeviceEvent;
    import flash.display.DisplayObject;

    public class BoosterFittingItemRenderer extends FittingListItemRenderer
    {

        private static const AFFECTED_ALPHA:int = 1;

        private static const NOT_AFFECTED_ALPHA:Number = 0.5;

        private static const MAX_LINE_NUMBER:uint = 2;

        private static const DOTS:String = "...";

        private static const TARGET_VEHICLE:String = "vehicle";

        public var removeButton:ISoundButtonEx = null;

        public var buyButton:ISoundButtonEx = null;

        public var descField:TextField = null;

        public var notAffected:UILoaderAlt = null;

        public var targetField:TextField = null;

        public var moduleOverlay:MovieClip = null;

        public var moduleHighlight:MovieClip = null;

        private var _boosterItemVO:BoosterFittingItemVO = null;

        private var _descVisible:Boolean = true;

        public function BoosterFittingItemRenderer()
        {
            var _loc2_:DisplayObject = null;
            super();
            var _loc1_:Vector.<DisplayObject> = new <DisplayObject>[this.targetField,this.notAffected];
            for each(_loc2_ in _loc1_)
            {
                rightOffsets[_loc2_] = width - _loc2_.x;
            }
            _loc1_.splice(0,_loc1_.length);
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._boosterItemVO = BoosterFittingItemVO(param1);
        }

        override protected function onDispose() : void
        {
            this.buyButton.dispose();
            this.buyButton = null;
            this.removeButton.dispose();
            this.removeButton = null;
            this.notAffected.dispose();
            this.notAffected = null;
            this.descField = null;
            this.targetField = null;
            this._boosterItemVO = null;
            this.moduleHighlight = null;
            this.moduleOverlay = null;
            super.onDispose();
        }

        override protected function onBeforeDispose() : void
        {
            this.buyButton.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this.removeButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            super.onBeforeDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            errorField.visible = false;
            this.buyButton.focusTarget = this;
            this.buyButton.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this.buyButton.soundType = SoundTypes.ITEM_RDR;
            this.removeButton.focusTarget = this;
            this.removeButton.addEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.soundType = SoundTypes.ITEM_RDR;
            this.notAffected.visible = false;
            this.notAffected.mouseEnabled = this.notAffected.mouseChildren = false;
            this.moduleHighlight.mouseEnabled = this.moduleHighlight.mouseChildren = false;
            moduleType.mouseEnabled = moduleType.mouseChildren = false;
            this.moduleOverlay.mouseEnabled = this.moduleOverlay.mouseChildren = false;
            this.descField.mouseEnabled = false;
            this.notAffected.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTBIGICON;
        }

        override protected function setup() : void
        {
            var _loc1_:String = null;
            var _loc2_:* = false;
            var _loc3_:String = null;
            var _loc4_:* = false;
            var _loc5_:* = false;
            super.setup();
            if(this._boosterItemVO != null)
            {
                if(!this._boosterItemVO.isSelected)
                {
                    this.removeButton.visible = false;
                    this._descVisible = this.descField.visible = StringUtils.isNotEmpty(this._boosterItemVO.desc);
                    if(this._descVisible)
                    {
                        this.setTruncatedHtmlText(this.descField,this._boosterItemVO.desc,MAX_LINE_NUMBER);
                        App.utils.commons.updateTextFieldSize(this.descField,false,true);
                    }
                    selected = false;
                }
                else
                {
                    this.removeButton.visible = true;
                    this._descVisible = this.descField.visible = false;
                }
                this.buyButton.visible = this._boosterItemVO.buyButtonVisible;
                this.buyButton.label = this._boosterItemVO.buyButtonLabel;
                this.buyButton.tooltip = this._boosterItemVO.buyButtonTooltip;
                this.removeButton.label = this._boosterItemVO.removeButtonLabel;
                this.removeButton.tooltip = this._boosterItemVO.removeButtonTooltip;
                if(this._boosterItemVO.notAffectedTTC && !(_data && !enabled))
                {
                    this.descField.alpha = titleField.alpha = NOT_AFFECTED_ALPHA;
                }
                else
                {
                    this.descField.alpha = titleField.alpha = AFFECTED_ALPHA;
                }
                this.notAffected.visible = this._boosterItemVO.notAffectedTTC;
                _loc1_ = this._boosterItemVO.overlayType;
                _loc2_ = StringUtils.isNotEmpty(_loc1_);
                this.moduleOverlay.visible = _loc2_;
                if(_loc2_)
                {
                    this.moduleOverlay.gotoAndStop(_loc1_);
                }
                _loc3_ = this._boosterItemVO.highlightType;
                _loc4_ = StringUtils.isNotEmpty(_loc3_);
                this.moduleHighlight.visible = _loc4_;
                if(_loc4_)
                {
                    this.moduleHighlight.gotoAndStop(_loc3_);
                }
                _loc5_ = this._boosterItemVO.disabled;
                this.removeButton.soundEnabled = _loc5_;
                this.buyButton.soundEnabled = _loc5_;
            }
        }

        override protected function setupTarget() : void
        {
            super.setupTarget();
            if(this._boosterItemVO.targetVisible && this._boosterItemVO.target != TARGET_VEHICLE)
            {
                this.targetField.text = String(this._boosterItemVO.count);
                this.targetField.visible = true;
            }
            else
            {
                this.targetField.visible = false;
            }
        }

        private function setTruncatedHtmlText(param1:TextField, param2:String, param3:uint) : void
        {
            var _loc4_:String = param2;
            this.descField.htmlText = _loc4_;
            while(param1.numLines > param3)
            {
                _loc4_ = _loc4_.substr(0,_loc4_.length - 1);
                this.descField.htmlText = _loc4_ + DOTS;
            }
        }

        override protected function handleUserClick(param1:MouseEvent) : void
        {
            hideTooltip();
        }

        private function onBuyButtonClickHandler(param1:ButtonEvent) : void
        {
            param1.stopImmediatePropagation();
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_BUY,this._boosterItemVO.id));
        }

        private function onRemoveButtonClickHandler(param1:ButtonEvent) : void
        {
            param1.stopImmediatePropagation();
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,this._boosterItemVO.id));
        }
    }
}
