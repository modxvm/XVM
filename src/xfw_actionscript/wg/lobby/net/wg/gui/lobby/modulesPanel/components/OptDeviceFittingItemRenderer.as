package net.wg.gui.lobby.modulesPanel.components
{
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.BlackButton;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.SoundTypes;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.events.DeviceEvent;

    public class OptDeviceFittingItemRenderer extends FittingListItemRenderer
    {

        private static const AFFECTED_ALPHA:int = 1;

        private static const NOT_AFFECTED_ALPHA:Number = 0.5;

        private static const MAX_LINE_NUMBER:uint = 2;

        private static const DOTS:String = "...";

        private static const BG_HIGHLIGHT_GAP:int = 2;

        private static const BUTTON_OFFSET:int = 5;

        public var removeButton:ISoundButtonEx;

        public var destroyButton:BlackButton;

        public var upgradeButton:ISoundButtonEx;

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
            this.upgradeButton.dispose();
            this.upgradeButton = null;
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
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.destroyButton.removeEventListener(ButtonEvent.CLICK,this.onDestroyButtonClickHandler);
            this.removeButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.upgradeButton.removeEventListener(ButtonEvent.CLICK,this.onUpgradeButtonClickHandler);
            super.onBeforeDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.destroyButton.focusable = false;
            this.destroyButton.addEventListener(ButtonEvent.CLICK,this.onDestroyButtonClickHandler);
            this.destroyButton.soundType = SoundTypes.ITEM_RDR;
            this.destroyButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_DESTROY_HUMMER;
            this.removeButton.focusable = false;
            this.removeButton.addEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.soundType = SoundTypes.ITEM_RDR;
            this.upgradeButton.focusable = false;
            this.upgradeButton.addEventListener(ButtonEvent.CLICK,this.onUpgradeButtonClickHandler);
            this.upgradeButton.soundType = SoundTypes.ITEM_RDR;
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
                    this.destroyButton.tooltip = MENU.MODULEFITS_DESTROYBTN_TOOLTIP;
                }
                this.removeButton.visible = _loc1_;
                if(this.removeButton.visible)
                {
                    this.removeButton.label = this._optDevData.removeButtonLabel;
                    this.removeButton.tooltip = this._optDevData.removeButtonTooltip;
                }
                this.upgradeButton.visible = this._optDevData.isUpgradable && !this._optDevData.disabled;
                if(this.upgradeButton.visible)
                {
                    this.upgradeButton.label = this._optDevData.upgradeButtonLabel;
                    this.upgradeButton.tooltip = MENU.MODULEFITS_UPGRADEBTN_TOOLTIP;
                }
                this.descField.visible = !_loc1_ && !this.upgradeButton.visible && StringUtils.isNotEmpty(this._optDevData.desc);
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
                if(StringUtils.isNotEmpty(this._optDevData.overlayType))
                {
                    this.moduleOverlay.gotoAndStop(this._optDevData.overlayType);
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
                this.upgradeButton.soundEnabled = _loc4_;
                if(this.upgradeButton.visible)
                {
                    this.removeButton.x = this.upgradeButton.x + this.removeButton.width + BUTTON_OFFSET;
                }
                else
                {
                    this.removeButton.x = this.upgradeButton.x;
                }
                this.destroyButton.x = this.removeButton.x + this.removeButton.width + BUTTON_OFFSET;
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
            if(this.bgHighlightMc.visible)
            {
                this.bgHighlightMc.gotoAndStop(this._optDevData.bgHighlightType);
            }
            if(selected)
            {
                this.bgHighlightMc.x = this.bgHighlightMc.y = BG_HIGHLIGHT_GAP;
            }
            else
            {
                this.bgHighlightMc.y = BG_HIGHLIGHT_GAP;
            }
        }

        private function onDestroyButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_DESTROY,this._optDevData.id));
        }

        private function onRemoveButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,this._optDevData.id));
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(param1.target != this.removeButton && param1.target != this.destroyButton && param1.target != this.upgradeButton)
            {
                this.showItemTooltip();
            }
        }

        private function onUpgradeButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_UPGRADE,this._optDevData.id));
        }
    }
}
