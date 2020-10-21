package net.wg.gui.lobby.eventCoins
{
    import net.wg.infrastructure.base.meta.impl.EventCoinsCounterMeta;
    import net.wg.infrastructure.base.meta.IEventCoinsCounterMeta;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventCoins extends EventCoinsCounterMeta implements IEventCoinsCounterMeta
    {

        private static const TEXT_SPACE:int = 3;

        private static const ICON_SPACE:int = -1;

        public var textField:TextField = null;

        public var countField:TextField = null;

        public var icon:Sprite = null;

        public var background:Sprite = null;

        private var _coins:int = -1;

        private var _toolTipMgr:ITooltipMgr;

        private var _toolTipVO:ToolTipVO = null;

        public function EventCoins()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.textField.text = EVENT.HANGAR_COINS;
            App.utils.commons.updateTextFieldSize(this.textField,true,false);
        }

        override protected function setCoinsTooltip(param1:ToolTipVO) : void
        {
            this._toolTipVO = param1;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._coins != Values.DEFAULT_INT && isInvalid(InvalidationType.DATA))
            {
                this.countField.text = this._coins.toString();
                this.icon.x = this.countField.x + this.countField.width - this.countField.textWidth - ICON_SPACE - this.icon.width | 0;
                this.textField.x = this.icon.x - TEXT_SPACE - this.textField.width | 0;
            }
        }

        override protected function onDispose() : void
        {
            this._toolTipMgr = null;
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.textField = null;
            this.countField = null;
            this.icon = null;
            this.background = null;
            this._toolTipVO = null;
            super.onDispose();
        }

        public function as_setCoinsCount(param1:int) : void
        {
            this._coins = param1;
            invalidateData();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._toolTipVO == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._toolTipVO.tooltip))
            {
                this._toolTipMgr.showComplex(this._toolTipVO.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._toolTipVO.specialAlias,null].concat(this._toolTipVO.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
