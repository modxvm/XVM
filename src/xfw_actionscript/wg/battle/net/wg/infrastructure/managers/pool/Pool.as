package net.wg.infrastructure.managers.pool
{
    import flash.events.EventDispatcher;
    import net.wg.infrastructure.interfaces.pool.IPool;
    import net.wg.infrastructure.interfaces.pool.IPoolItem;
    import net.wg.infrastructure.events.PoolItemEvent;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.ArgumentException;

    public class Pool extends EventDispatcher implements IPool
    {

        private static const EXPAND_COEF:Number = 1;

        private var _items:Vector.<IPoolItem>;

        private var _numAvailableItems:uint;

        private var _creator:Function;

        private var _fixed:Boolean;

        public function Pool(param1:uint, param2:Function, param3:Boolean = true)
        {
            super();
            this.assert(param1 > 0,"Pool numItems can\'t be equal to zero",ArgumentException);
            this._creator = param2;
            this._fixed = param3;
            this._items = new Vector.<IPoolItem>(param1,true);
            this.fillEmptyItems(0,param1);
            this._numAvailableItems = param1;
        }

        public final function dispose() : void
        {
            var _loc2_:IPoolItem = null;
            var _loc1_:int = this._items.length - 1;
            while(_loc1_ >= 0)
            {
                _loc2_ = this._items[_loc1_];
                _loc2_.isInPool = false;
                _loc2_.removeEventListener(PoolItemEvent.ITEM_TURN_OUT,this.onItemTurnOutHandler);
                _loc2_.dispose();
                _loc1_--;
            }
            this._items.fixed = false;
            this._items.splice(0,this._items.length);
            this._items = null;
            this._creator = null;
            this.onDispose();
        }

        public function getItem() : IPoolItem
        {
            if(this._numAvailableItems == 0)
            {
                if(this._fixed)
                {
                    this.assert(false,"Pool" + Errors.CANT_EMPTY + " Total items: " + this._items.length + ". available items: " + this._numAvailableItems + ". Item type: " + this.getItemTypeStr());
                }
                else
                {
                    DebugUtils.LOG_DEBUG("Pool expanded. Item type: " + this.getItemTypeStr());
                    this.expand();
                }
            }
            return this._items[this._numAvailableItems-- - 1];
        }

        public function releaseItem(param1:IPoolItem) : void
        {
            param1.cleanUp();
            var _loc2_:int = this._items.indexOf(param1);
            if(_loc2_ < 0)
            {
                this.assert(false,"Item \'" + param1 + "\' cant find in Pool.",ArgumentException);
            }
            var _loc3_:IPoolItem = this._items[this._numAvailableItems];
            var _loc4_:* = this._numAvailableItems++;
            this._items[_loc4_] = param1;
            this._items[_loc2_] = _loc3_;
        }

        protected function onDispose() : void
        {
        }

        private function assert(param1:Boolean, param2:String, param3:Class = null) : void
        {
            App.utils.asserter.assert(param1,param2,param3);
        }

        private function getItemTypeStr() : String
        {
            return this._items.length > 0?String(this._items[0]):"";
        }

        private function initItem(param1:IPoolItem) : void
        {
            param1.isInPool = true;
            param1.addEventListener(PoolItemEvent.ITEM_TURN_OUT,this.onItemTurnOutHandler);
        }

        private function fillEmptyItems(param1:int, param2:int) : void
        {
            var _loc5_:IPoolItem = null;
            var _loc3_:int = param1;
            var _loc4_:int = param1 + param2;
            while(_loc3_ < _loc4_)
            {
                _loc5_ = this._creator();
                this._items[_loc3_] = _loc5_;
                this.initItem(_loc5_);
                _loc3_++;
            }
        }

        private function expand() : void
        {
            var _loc5_:* = 0;
            var _loc1_:int = this._items.length;
            var _loc2_:int = _loc1_ * EXPAND_COEF;
            var _loc3_:int = _loc1_ + _loc2_;
            var _loc4_:Vector.<IPoolItem> = this._items;
            this._items = new Vector.<IPoolItem>(_loc3_,true);
            this.fillEmptyItems(0,_loc2_);
            _loc5_ = _loc2_;
            while(_loc5_ < _loc3_)
            {
                this._items[_loc5_] = _loc4_[_loc5_ - _loc2_];
                _loc5_++;
            }
            this._numAvailableItems = this._numAvailableItems + _loc2_;
            _loc4_.fixed = false;
            _loc4_.splice(0,_loc4_.length);
        }

        private function onItemTurnOutHandler(param1:PoolItemEvent) : void
        {
            this.releaseItem(param1.item);
        }
    }
}
