package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import flash.events.MouseEvent;
    import org.idmedia.as3commons.util.StringUtils;

    public class ResultStatItem extends UIComponentEx
    {

        public var textField:TextField = null;

        public var description:AnimatedTextContainer = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _tooltipData:ToolTipVO = null;

        public function ResultStatItem()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            mouseChildren = false;
        }

        override protected function onBeforeDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.textField = null;
            this.description.dispose();
            this.description = null;
            this._tooltipMgr = null;
            this._tooltipData = null;
            super.onDispose();
        }

        public function setData(param1:String, param2:ToolTipVO = null) : void
        {
            this.description.text = param1;
            this._tooltipData = param2;
        }

        public function setValue(param1:int) : void
        {
            this.textField.text = App.utils.locale.integer(param1);
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._tooltipData == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._tooltipData.tooltip))
            {
                this._tooltipMgr.showComplex(this._tooltipData.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._tooltipData.specialAlias,null].concat(this._tooltipData.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
