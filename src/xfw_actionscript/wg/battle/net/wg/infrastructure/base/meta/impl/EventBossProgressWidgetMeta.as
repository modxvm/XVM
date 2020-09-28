package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.gui.battle.eventBattle.views.bossWidget.VO.DAAPIEventBossProgressWidgetVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventBossProgressWidgetMeta extends BattleDisplayable
    {

        private var _dAAPIEventBossProgressWidgetVO:DAAPIEventBossProgressWidgetVO;

        public function EventBossProgressWidgetMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._dAAPIEventBossProgressWidgetVO)
            {
                this._dAAPIEventBossProgressWidgetVO.dispose();
                this._dAAPIEventBossProgressWidgetVO = null;
            }
            super.onDispose();
        }

        public final function as_setWidgetData(param1:Object) : void
        {
            var _loc2_:DAAPIEventBossProgressWidgetVO = this._dAAPIEventBossProgressWidgetVO;
            this._dAAPIEventBossProgressWidgetVO = new DAAPIEventBossProgressWidgetVO(param1);
            this.setWidgetData(this._dAAPIEventBossProgressWidgetVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setWidgetData(param1:DAAPIEventBossProgressWidgetVO) : void
        {
            var _loc2_:String = "as_setWidgetData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
