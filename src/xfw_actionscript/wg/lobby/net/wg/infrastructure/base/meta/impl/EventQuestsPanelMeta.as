package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.eventQuests.data.EventQuestVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventQuestsPanelMeta extends BaseDAAPIComponent
    {

        public var onQuestPanelClick:Function;

        private var _dataProviderEventQuestVO:DataProvider;

        public function EventQuestsPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:EventQuestVO = null;
            if(this._dataProviderEventQuestVO)
            {
                for each(_loc1_ in this._dataProviderEventQuestVO)
                {
                    _loc1_.dispose();
                }
                this._dataProviderEventQuestVO.cleanUp();
                this._dataProviderEventQuestVO = null;
            }
            super.onDispose();
        }

        public function onQuestPanelClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onQuestPanelClick,"onQuestPanelClick" + Errors.CANT_NULL);
            this.onQuestPanelClick();
        }

        public final function as_setListDataProvider(param1:Array) : void
        {
            var _loc5_:EventQuestVO = null;
            var _loc2_:DataProvider = this._dataProviderEventQuestVO;
            this._dataProviderEventQuestVO = new DataProvider();
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._dataProviderEventQuestVO[_loc4_] = new EventQuestVO(param1[_loc4_]);
                _loc4_++;
            }
            this.setListDataProvider(this._dataProviderEventQuestVO);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.cleanUp();
            }
        }

        protected function setListDataProvider(param1:DataProvider) : void
        {
            var _loc2_:String = "as_setListDataProvider" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
