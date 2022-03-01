package com.xvm.wg
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.utils.Dictionary;

    internal class WeakRef extends Object implements IDisposable
    {
        private var _dict:Dictionary = null;

        private var _target:* = null;

        private var _lock:Boolean = false;

        private var _disposed:Boolean = false;

        public function WeakRef(param1:*, param2:Boolean = false)
        {
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(param1, param2);
        }

        private function _init(param1:*, param2:Boolean):void
        {
            this._dict = new Dictionary(true);
            this._dict[param1] = 1;
            if(param2)
            {
                this._lock = param2;
                this._target = param1;
            }
        }

        public function get target() : *
        {
            var _loc1_:* = undefined;
            if(this._lock)
            {
                return this._target;
            }
            for(_loc1_ in this._dict)
            {
                return _loc1_;
            }
            return null;
        }

        public function dispose() : void
        {
            var _loc1_:* = undefined;
            this.unlock();
            for(_loc1_ in this._dict)
            {
                delete this._dict[_loc1_];
            }
            this._dict = null;
            this._disposed = false;
        }

        public function get isDisposed() : Boolean
        {
            return this._disposed;
        }

        public function get isLock() : Boolean
        {
            return this._lock;
        }

        public function lock() : Boolean
        {
            var _loc1_:* = undefined;
            if(!this._lock)
            {
                _loc1_ = this.target;
                if(_loc1_ != null)
                {
                    this._target = _loc1_;
                    this._lock = true;
                }
            }
            return this._lock;
        }

        public function unlock() : void
        {
            if(this._lock)
            {
                this._target = null;
                this._lock = false;
            }
        }
    }
}