package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.store.StoreComponentViewBase;
    import net.wg.gui.lobby.store.actions.data.StoreActionsViewVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class StoreActionsViewMeta extends StoreComponentViewBase
    {

        public var actionSelect:Function;

        public var onBattleTaskSelect:Function;

        public var onActionSeen:Function;

        private var _storeActionsViewVo:StoreActionsViewVo;

        private var _vectorStoreActionTimeVo:Vector.<StoreActionTimeVo>;

        public function StoreActionsViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:StoreActionTimeVo = null;
            if(this._storeActionsViewVo)
            {
                this._storeActionsViewVo.dispose();
                this._storeActionsViewVo = null;
            }
            if(this._vectorStoreActionTimeVo)
            {
                for each(_loc1_ in this._vectorStoreActionTimeVo)
                {
                    _loc1_.dispose();
                }
                this._vectorStoreActionTimeVo.splice(0,this._vectorStoreActionTimeVo.length);
                this._vectorStoreActionTimeVo = null;
            }
            super.onDispose();
        }

        public function actionSelectS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.actionSelect,"actionSelect" + Errors.CANT_NULL);
            this.actionSelect(param1);
        }

        public function onBattleTaskSelectS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onBattleTaskSelect,"onBattleTaskSelect" + Errors.CANT_NULL);
            this.onBattleTaskSelect(param1);
        }

        public function onActionSeenS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onActionSeen,"onActionSeen" + Errors.CANT_NULL);
            this.onActionSeen(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:StoreActionsViewVo = this._storeActionsViewVo;
            this._storeActionsViewVo = new StoreActionsViewVo(param1);
            this.setData(this._storeActionsViewVo);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_actionTimeUpdate(param1:Array) : void
        {
            var _loc5_:StoreActionTimeVo = null;
            var _loc2_:Vector.<StoreActionTimeVo> = this._vectorStoreActionTimeVo;
            this._vectorStoreActionTimeVo = new Vector.<StoreActionTimeVo>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorStoreActionTimeVo[_loc4_] = new StoreActionTimeVo(param1[_loc4_]);
                _loc4_++;
            }
            this.actionTimeUpdate(this._vectorStoreActionTimeVo);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.splice(0,_loc2_.length);
            }
        }

        protected function setData(param1:StoreActionsViewVo) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function actionTimeUpdate(param1:Vector.<StoreActionTimeVo>) : void
        {
            var _loc2_:String = "as_actionTimeUpdate" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
