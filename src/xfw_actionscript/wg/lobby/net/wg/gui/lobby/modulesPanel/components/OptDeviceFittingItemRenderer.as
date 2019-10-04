package net.wg.gui.lobby.modulesPanel.components
{
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundTypes;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.DeviceEvent;

    public class OptDeviceFittingItemRenderer extends FittingListItemRenderer
    {

        private static const AFFECTED_ALPHA:int = 1;

        private static const NOT_AFFECTED_ALPHA:Number = 0.5;

        private static const MAX_LINE_NUMBER:uint = 2;

        private static const DOTS:String = "...";

        private static const BG_HIGHLIGHT_GAP:int = 2;

        public var removeButton:ISoundButtonEx;

        public var destroyButton:ISoundButtonEx;

        public var locked:MovieClip;

        public var descField:TextField;

        public var bgHighlightMc:MovieClip = null;

        public var moduleOverlay:MovieClip = null;

        private var _optDevData:OptionalDeviceVO;

        private var _commons:ICommons;

        private var _toolTipMgr:ITooltipMgr;

        public function OptDeviceFittingItemRenderer()
        {
            this._commons = App.utils.commons;
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._optDevData = OptionalDeviceVO(param1);
        }

        override protected function showItemTooltip() : void
        {
            if(this._optDevData)
            {
                if(this._optDevData.notAffectedTTC)
                {
                    this._toolTipMgr.showComplex(this._optDevData.notAffectedTTCTooltip);
                }
                else
                {
                    super.showItemTooltip();
                }
            }
        }

        override protected function onDispose() : void
        {
            this.destroyButton.dispose();
            this.destroyButton = null;
            this.removeButton.dispose();
            this.removeButton = null;
            this.descField = null;
            this.locked = null;
            this._optDevData = null;
            this.bgHighlightMc = null;
            this.moduleOverlay = null;
            this._commons = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function onBeforeDispose() : void
        {
            this.destroyButton.removeEventListener(ButtonEvent.CLICK,this.onDestroyButtonClickHandler);
            this.destroyButton.removeEventListener(MouseEvent.ROLL_OVER,this.onDestroyButtonRollOverHandler);
            this.destroyButton.removeEventListener(MouseEvent.ROLL_OUT,this.onDestroyButtonRollOutHandler);
            this.removeButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.removeEventListener(MouseEvent.ROLL_OVER,this.onRemoveButtonRollOverHandler);
            this.removeButton.removeEventListener(MouseEvent.ROLL_OUT,this.onRemoveButtonRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.destroyButton.focusTarget = this;
            this.destroyButton.addEventListener(ButtonEvent.CLICK,this.onDestroyButtonClickHandler);
            this.destroyButton.addEventListener(MouseEvent.ROLL_OVER,this.onDestroyButtonRollOverHandler);
            this.destroyButton.addEventListener(MouseEvent.ROLL_OUT,this.onDestroyButtonRollOutHandler);
            this.destroyButton.soundType = SoundTypes.ITEM_RDR;
            this.removeButton.focusTarget = this;
            this.removeButton.addEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.addEventListener(MouseEvent.ROLL_OVER,this.onRemoveButtonRollOverHandler);
            this.removeButton.addEventListener(MouseEvent.ROLL_OUT,this.onRemoveButtonRollOutHandler);
            this.removeButton.soundType = SoundTypes.ITEM_RDR;
            this.locked.visible = false;
            this.locked.mouseEnabled = this.locked.mouseChildren = false;
            this.descField.mouseEnabled = false;
        }

        override protected function setup() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = false;
            var _loc3_:* = NaN;
            var _loc4_:* = false;
            super.setup();
            if(this._optDevData != null)
            {
                _loc1_ = this._optDevData.isSelected;
                _loc2_ = !this._optDevData.removable;
                this.locked.visible = _loc2_;
                this.destroyButton.visible = _loc2_ && _loc1_;
                if(this.destroyButton.visible)
                {
                    this.destroyButton.label = MENU.MODULEFITS_DESTROYNAME;
                }
                this.removeButton.visible = _loc1_;
                if(this.removeButton.visible)
                {
                    this.removeButton.label = this._optDevData.removeButtonLabel;
                    this.removeButton.tooltip = this._optDevData.removeButtonTooltip;
                }
                this.descField.visible = !_loc1_ && StringUtils.isNotEmpty(this._optDevData.desc);
                if(this.descField.visible)
                {
                    this.setTruncatedHtmlText(this.descField,this._optDevData.desc,MAX_LINE_NUMBER);
                    this._commons.updateTextFieldSize(this.descField,false,true);
                    if(!this._optDevData.notAffectedTTC)
                    {
                        layoutErrorField(this.descField);
                    }
                }
                _loc3_ = this._optDevData.notAffectedTTC?NOT_AFFECTED_ALPHA:AFFECTED_ALPHA;
                this.descField.alpha = titleField.alpha = moduleType.alpha = _loc3_;
                errorField.visible = this._optDevData.notAffectedTTC || !this._optDevData.isSelected && StringUtils.isNotEmpty(this._optDevData.status);
                if(errorField.visible)
                {
                    errorField.htmlText = this._optDevData.status;
                    this._commons.updateTextFieldSize(errorField,false,true);
                }
                if(StringUtils.isNotEmpty(this._optDevData.highlightType))
                {
                    this.moduleOverlay.gotoAndStop(this._optDevData.highlightType);
                    this.moduleOverlay.visible = true;
                }
                else
                {
                    this.moduleOverlay.visible = false;
                }
                this.updateBgHighlight();
                _loc4_ = this._optDevData.disabled;
                this.destroyButton.soundEnabled = _loc4_;
                this.removeButton.soundEnabled = _loc4_;
            }
        }

        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            if(initialized && this._optDevData)
            {
                this.updateBgHighlight();
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.LAYOUT))
            {
                this.showItemTooltip();
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

        private function updateBgHighlight() : void
        {
            this.bgHighlightMc.visible = StringUtils.isNotEmpty(this._optDevData.bgHighlightType);
            if(selected)
            {
                this.bgHighlightMc.x = this.bgHighlightMc.y = BG_HIGHLIGHT_GAP;
            }
            else
            {
                this.bgHighlightMc.y = BG_HIGHLIGHT_GAP;
            }
        }

        private function onDestroyButtonRollOverHandler(param1:MouseEvent) : void
        {
            hideTooltip();
        }

        private function onDestroyButtonRollOutHandler(param1:MouseEvent) : void
        {
            invalidate(InvalidationType.LAYOUT);
        }

        private function onRemoveButtonRollOverHandler(param1:MouseEvent) : void
        {
            hideTooltip();
        }

        private function onRemoveButtonRollOutHandler(param1:MouseEvent) : void
        {
            invalidate(InvalidationType.LAYOUT);
        }

        private function onDestroyButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_DESTROY,this._optDevData.id));
        }

        private function onRemoveButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,this._optDevData.id));
        }
    }
}
