package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import flash.events.MouseEvent;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class BuddiesHeader extends UIComponentEx
    {

        public var matterOnTank:MovieClip = null;

        public var matter:MovieClip = null;

        public var kills:MovieClip = null;

        public var damage:MovieClip = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _tooltipItems:Vector.<DisplayObject> = null;

        private var _data:ResultDataVO = null;

        public function BuddiesHeader()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
            this._tooltipItems = new <DisplayObject>[this.matterOnTank,this.matter,this.kills,this.damage];
        }

        override protected function configUI() : void
        {
            var _loc1_:DisplayObject = null;
            super.configUI();
            for each(_loc1_ in this._tooltipItems)
            {
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
        }

        public function setData(param1:ResultDataVO) : void
        {
            this._data = param1;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            switch(param1.currentTarget)
            {
                case this.matterOnTank:
                    this.showTooltip(this._data.matterOnTankTooltip);
                    break;
                case this.matter:
                    this.showTooltip(this._data.matterTooltip);
                    break;
                case this.kills:
                    this.showTooltip(this._data.killsTooltip);
                    break;
                case this.damage:
                    this.showTooltip(this._data.damageTooltip);
                    break;
            }
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:DisplayObject = null;
            for each(_loc1_ in this._tooltipItems)
            {
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._tooltipItems.splice(0,this._tooltipItems.length);
            this._tooltipItems = null;
            this.matterOnTank = null;
            this.matter = null;
            this.kills = null;
            this.damage = null;
            this._data = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        private function showTooltip(param1:ToolTipVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(param1.tooltip))
            {
                this._tooltipMgr.showComplex(param1.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[param1.specialAlias,null].concat(param1.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
