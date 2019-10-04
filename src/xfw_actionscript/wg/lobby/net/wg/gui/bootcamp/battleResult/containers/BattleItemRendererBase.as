package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import flash.events.Event;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class BattleItemRendererBase extends UIComponentEx implements IUpdatable
    {

        private var _data:BattleItemRendrerVO;

        public function BattleItemRendererBase()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            stop();
        }

        override protected function onDispose() : void
        {
            this._data = null;
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.applyData(this._data);
            }
        }

        public function update(param1:Object) : void
        {
            this._data = BattleItemRendrerVO(param1);
            invalidateData();
        }

        protected function applyData(param1:BattleItemRendrerVO) : void
        {
            throw new AbstractException(Errors.ABSTRACT_INVOKE);
        }

        private function onMouseOverHandler(param1:Event) : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BOOTCAMP_AWARD_MEDAL,null,this._data.label,this._data.description,this._data.iconTooltip);
        }

        private function onMouseOutHandler(param1:Event) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
