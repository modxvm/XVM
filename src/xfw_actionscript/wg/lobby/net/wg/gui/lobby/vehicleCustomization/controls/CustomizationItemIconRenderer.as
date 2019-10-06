package net.wg.gui.lobby.vehicleCustomization.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemIconRendererVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class CustomizationItemIconRenderer extends UIComponent
    {

        private static const NON_HISTORIC_ICON_OFFSET:int = -18;

        private static const ICON_WIDE_WIDTH:int = 76;

        private static const ICON_SHORT_WIDTH:int = 32;

        private static const ICON_HEIGHT:int = 32;

        private static const ICON_BACKGROUND_OFFSET:int = 2;

        public var nonHistoricIcon:Image = null;

        public var itemIcon:UILoaderAlt = null;

        public var iconBg:Sprite = null;

        private var _data:CustomizationItemIconRendererVO;

        private var _tooltipManager:ITooltipMgr;

        public function CustomizationItemIconRenderer()
        {
            this._tooltipManager = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.nonHistoricIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_NON_HISTORICAL;
            this.nonHistoricIcon.visible = false;
            this.itemIcon.visible = false;
            this.itemIcon.addEventListener(UILoaderEvent.COMPLETE,this.onItemIconCompleteHandler);
            this.iconBg.height = ICON_HEIGHT;
            this.iconBg.visible = false;
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = false;
            super.draw();
            if(this._data)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.nonHistoricIcon.visible = !this._data.isHistoric;
                    this.itemIcon.source = this._data.icon;
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    _loc1_ = (this._data.isWide?ICON_WIDE_WIDTH:ICON_SHORT_WIDTH) + ICON_BACKGROUND_OFFSET;
                    this.iconBg.width = _loc1_;
                    this.nonHistoricIcon.x = this.iconBg.x + _loc1_ + NON_HISTORIC_ICON_OFFSET ^ 0;
                    _loc2_ = this.itemIcon.width != this.itemIcon.height;
                    this.itemIcon.width = _loc2_?ICON_WIDE_WIDTH:ICON_SHORT_WIDTH;
                    this.itemIcon.height = ICON_HEIGHT;
                    this.itemIcon.x = _loc1_ - this.itemIcon.width >> 1;
                }
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.nonHistoricIcon.dispose();
            this.nonHistoricIcon = null;
            this.itemIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onItemIconCompleteHandler);
            this.itemIcon.dispose();
            this.itemIcon = null;
            this.iconBg = null;
            this._data = null;
            this._tooltipManager = null;
            super.onDispose();
        }

        public function setData(param1:Object) : void
        {
            this._data = CustomizationItemIconRendererVO(param1);
            invalidateData();
        }

        override public function get width() : Number
        {
            if(this._data)
            {
                return (this._data.isWide?ICON_WIDE_WIDTH:ICON_SHORT_WIDTH) + ICON_BACKGROUND_OFFSET;
            }
            return this.iconBg.width;
        }

        override public function get height() : Number
        {
            return this.iconBg.height;
        }

        private function onItemIconCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
            this.itemIcon.visible = true;
            this.iconBg.visible = true;
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data && this._data.id != Values.DEFAULT_INT)
            {
                this._tooltipManager.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM_ICON,null,this._data.id,false);
            }
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipManager.hide();
        }
    }
}
