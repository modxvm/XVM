package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.store.data.StoreViewInitVO;
    import net.wg.data.VO.CountersVo;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class StoreViewMeta extends AbstractScreen
    {

        public var onClose:Function;

        public var onTabChange:Function;

        public var onBackButtonClick:Function;

        private var _storeViewInitVO:StoreViewInitVO;

        private var _vectorCountersVo:Vector.<CountersVo>;

        private var _vectorString:Vector.<String>;

        public function StoreViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:CountersVo = null;
            if(this._storeViewInitVO)
            {
                this._storeViewInitVO.dispose();
                this._storeViewInitVO = null;
            }
            if(this._vectorCountersVo)
            {
                for each(_loc1_ in this._vectorCountersVo)
                {
                    _loc1_.dispose();
                }
                this._vectorCountersVo.splice(0,this._vectorCountersVo.length);
                this._vectorCountersVo = null;
            }
            if(this._vectorString)
            {
                this._vectorString.splice(0,this._vectorString.length);
                this._vectorString = null;
            }
            super.onDispose();
        }

        public function onCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
            this.onClose();
        }

        public function onTabChangeS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onTabChange,"onTabChange" + Errors.CANT_NULL);
            this.onTabChange(param1);
        }

        public function onBackButtonClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBackButtonClick,"onBackButtonClick" + Errors.CANT_NULL);
            this.onBackButtonClick();
        }

        public final function as_init(param1:Object) : void
        {
            var _loc2_:StoreViewInitVO = this._storeViewInitVO;
            this._storeViewInitVO = new StoreViewInitVO(param1);
            this.init(this._storeViewInitVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setBtnTabCounters(param1:Array) : void
        {
            var _loc5_:CountersVo = null;
            var _loc2_:Vector.<CountersVo> = this._vectorCountersVo;
            this._vectorCountersVo = new Vector.<CountersVo>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorCountersVo[_loc4_] = new CountersVo(param1[_loc4_]);
                _loc4_++;
            }
            this.setBtnTabCounters(this._vectorCountersVo);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.splice(0,_loc2_.length);
            }
        }

        public final function as_removeBtnTabCounters(param1:Array) : void
        {
            var _loc2_:Vector.<String> = this._vectorString;
            this._vectorString = new Vector.<String>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorString[_loc4_] = param1[_loc4_];
                _loc4_++;
            }
            this.removeBtnTabCounters(this._vectorString);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        protected function init(param1:StoreViewInitVO) : void
        {
            var _loc2_:String = "as_init" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setBtnTabCounters(param1:Vector.<CountersVo>) : void
        {
            var _loc2_:String = "as_setBtnTabCounters" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function removeBtnTabCounters(param1:Vector.<String>) : void
        {
            var _loc2_:String = "as_removeBtnTabCounters" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
