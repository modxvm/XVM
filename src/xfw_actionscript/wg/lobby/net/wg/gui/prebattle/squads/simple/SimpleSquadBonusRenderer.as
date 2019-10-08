package net.wg.gui.prebattle.squads.simple
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadBonusVO;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.managers.ITooltipProps;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class SimpleSquadBonusRenderer extends UIComponentEx implements IUpdatable
    {

        private static const ICON_INFO_OFFSET:int = 12;

        private static const MAX_TOOLTIP_WIDTH:int = 310;

        public var iconInfo:Sprite = null;

        public var bonusValue:TextField = null;

        public var label:TextField = null;

        public var icon:Image = null;

        private var _dataVO:SimpleSquadBonusVO;

        public function SimpleSquadBonusRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.iconInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onIconInfoRollOverHandler);
            this.iconInfo.removeEventListener(MouseEvent.ROLL_OUT,this.onIconInfoRollOutHandler);
            this.iconInfo = null;
            this.icon.dispose();
            this.icon = null;
            this.bonusValue = null;
            this.label = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.label.autoSize = TextFieldAutoSize.LEFT;
            this.bonusValue.autoSize = TextFieldAutoSize.LEFT;
            this.iconInfo.addEventListener(MouseEvent.ROLL_OVER,this.onIconInfoRollOverHandler);
            this.iconInfo.addEventListener(MouseEvent.ROLL_OUT,this.onIconInfoRollOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._dataVO != null && isInvalid(InvalidationType.DATA))
            {
                this.icon.source = this._dataVO.icon;
                this.label.htmlText = this._dataVO.label;
                this.bonusValue.htmlText = this._dataVO.bonusValue;
                this.iconInfo.visible = StringUtils.isNotEmpty(this._dataVO.tooltip);
                if(this.iconInfo.visible)
                {
                    this.iconInfo.x = this.label.x + this.label.width + ICON_INFO_OFFSET;
                    setSize(this.iconInfo.x + this.iconInfo.width ^ 0,_height);
                }
                else
                {
                    setSize(this.label.x + this.label.width ^ 0,_height);
                }
            }
        }

        public function update(param1:Object) : void
        {
            this._dataVO = SimpleSquadBonusVO(param1);
            invalidateData();
        }

        private function onIconInfoRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ITooltipProps = null;
            if(StringUtils.isNotEmpty(this._dataVO.tooltip))
            {
                if(this._dataVO.tooltipType == TOOLTIPS_CONSTANTS.SPECIAL)
                {
                    App.toolTipMgr.showWulfTooltip(this._dataVO.tooltip);
                }
                else
                {
                    _loc2_ = App.toolTipMgr.getDefaultTooltipProps();
                    _loc2_ = ITooltipProps(_loc2_.clone());
                    _loc2_.maxWidth = MAX_TOOLTIP_WIDTH;
                    App.toolTipMgr.showComplex(this._dataVO.tooltip,_loc2_);
                }
            }
        }

        private function onIconInfoRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
