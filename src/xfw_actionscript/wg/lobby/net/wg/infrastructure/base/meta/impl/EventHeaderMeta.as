package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventHeaderMeta extends BaseDAAPIComponent
    {

        public var menuItemClick:Function;

        private var _dataProviderHangarMenuTabItemVO:DataProvider;

        public function EventHeaderMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:HangarMenuTabItemVO = null;
            if(this._dataProviderHangarMenuTabItemVO)
            {
                for each(_loc1_ in this._dataProviderHangarMenuTabItemVO)
                {
                    _loc1_.dispose();
                }
                this._dataProviderHangarMenuTabItemVO.cleanUp();
                this._dataProviderHangarMenuTabItemVO = null;
            }
            super.onDispose();
        }

        public function menuItemClickS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.menuItemClick,"menuItemClick" + Errors.CANT_NULL);
            this.menuItemClick(param1);
        }

        public final function as_setHangarMenuData(param1:Array) : void
        {
            var _loc5_:HangarMenuTabItemVO = null;
            var _loc2_:DataProvider = this._dataProviderHangarMenuTabItemVO;
            this._dataProviderHangarMenuTabItemVO = new DataProvider();
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._dataProviderHangarMenuTabItemVO[_loc4_] = new HangarMenuTabItemVO(param1[_loc4_]);
                _loc4_++;
            }
            this.setHangarMenuData(this._dataProviderHangarMenuTabItemVO);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.cleanUp();
            }
        }

        protected function setHangarMenuData(param1:DataProvider) : void
        {
            var _loc2_:String = "as_setHangarMenuData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
