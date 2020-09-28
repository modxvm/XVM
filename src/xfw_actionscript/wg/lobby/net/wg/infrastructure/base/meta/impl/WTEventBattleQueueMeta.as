package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.lobby.battlequeue.BattleQueueTypeInfoVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.battlequeue.WTEventChangeVehicleWidgetVO;
    import net.wg.gui.lobby.battlequeue.BattleQueueItemVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class WTEventBattleQueueMeta extends AbstractView
    {

        public var startClick:Function;

        public var exitClick:Function;

        public var onEscape:Function;

        public var onSwitchVehicleClick:Function;

        public var onChangeWidgetHided:Function;

        private var _battleQueueTypeInfoVO:BattleQueueTypeInfoVO;

        private var _dataProviderBattleQueueItemVO:DataProvider;

        private var _wTEventChangeVehicleWidgetVO:WTEventChangeVehicleWidgetVO;

        public function WTEventBattleQueueMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:BattleQueueItemVO = null;
            if(this._battleQueueTypeInfoVO)
            {
                this._battleQueueTypeInfoVO.dispose();
                this._battleQueueTypeInfoVO = null;
            }
            if(this._dataProviderBattleQueueItemVO)
            {
                for each(_loc1_ in this._dataProviderBattleQueueItemVO)
                {
                    _loc1_.dispose();
                }
                this._dataProviderBattleQueueItemVO.cleanUp();
                this._dataProviderBattleQueueItemVO = null;
            }
            if(this._wTEventChangeVehicleWidgetVO)
            {
                this._wTEventChangeVehicleWidgetVO.dispose();
                this._wTEventChangeVehicleWidgetVO = null;
            }
            super.onDispose();
        }

        public function startClickS() : void
        {
            App.utils.asserter.assertNotNull(this.startClick,"startClick" + Errors.CANT_NULL);
            this.startClick();
        }

        public function exitClickS() : void
        {
            App.utils.asserter.assertNotNull(this.exitClick,"exitClick" + Errors.CANT_NULL);
            this.exitClick();
        }

        public function onEscapeS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
            this.onEscape();
        }

        public function onSwitchVehicleClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onSwitchVehicleClick,"onSwitchVehicleClick" + Errors.CANT_NULL);
            this.onSwitchVehicleClick();
        }

        public function onChangeWidgetHidedS() : void
        {
            App.utils.asserter.assertNotNull(this.onChangeWidgetHided,"onChangeWidgetHided" + Errors.CANT_NULL);
            this.onChangeWidgetHided();
        }

        public final function as_setTypeInfo(param1:Object) : void
        {
            var _loc2_:BattleQueueTypeInfoVO = this._battleQueueTypeInfoVO;
            this._battleQueueTypeInfoVO = new BattleQueueTypeInfoVO(param1);
            this.setTypeInfo(this._battleQueueTypeInfoVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setDP(param1:Array) : void
        {
            var _loc5_:BattleQueueItemVO = null;
            var _loc2_:DataProvider = this._dataProviderBattleQueueItemVO;
            this._dataProviderBattleQueueItemVO = new DataProvider();
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._dataProviderBattleQueueItemVO[_loc4_] = new BattleQueueItemVO(param1[_loc4_]);
                _loc4_++;
            }
            this.setDP(this._dataProviderBattleQueueItemVO);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.cleanUp();
            }
        }

        public final function as_showSwitchVehicle(param1:Object) : void
        {
            var _loc2_:WTEventChangeVehicleWidgetVO = this._wTEventChangeVehicleWidgetVO;
            this._wTEventChangeVehicleWidgetVO = new WTEventChangeVehicleWidgetVO(param1);
            this.showSwitchVehicle(this._wTEventChangeVehicleWidgetVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setTypeInfo(param1:BattleQueueTypeInfoVO) : void
        {
            var _loc2_:String = "as_setTypeInfo" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setDP(param1:DataProvider) : void
        {
            var _loc2_:String = "as_setDP" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function showSwitchVehicle(param1:WTEventChangeVehicleWidgetVO) : void
        {
            var _loc2_:String = "as_showSwitchVehicle" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
