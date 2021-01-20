package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class ContainerManagerMeta extends BaseDAAPIModule
    {

        public var isModalViewsIsExists:Function;

        private var _vectorint:Vector.<int>;

        private var _vectorint1:Vector.<int>;

        public function ContainerManagerMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vectorint)
            {
                this._vectorint.splice(0,this._vectorint.length);
                this._vectorint = null;
            }
            if(this._vectorint1)
            {
                this._vectorint1.splice(0,this._vectorint1.length);
                this._vectorint1 = null;
            }
            super.onDispose();
        }

        public function isModalViewsIsExistsS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isModalViewsIsExists,"isModalViewsIsExists" + Errors.CANT_NULL);
            return this.isModalViewsIsExists();
        }

        public final function as_showContainers(param1:Array) : void
        {
            var _loc2_:Vector.<int> = this._vectorint;
            this._vectorint = new Vector.<int>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorint[_loc4_] = param1[_loc4_];
                _loc4_++;
            }
            this.showContainers(this._vectorint);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        public final function as_hideContainers(param1:Array) : void
        {
            var _loc2_:Vector.<int> = this._vectorint1;
            this._vectorint1 = new Vector.<int>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorint1[_loc4_] = param1[_loc4_];
                _loc4_++;
            }
            this.hideContainers(this._vectorint1);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        protected function showContainers(param1:Vector.<int>) : void
        {
            var _loc2_:String = "as_showContainers" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function hideContainers(param1:Vector.<int>) : void
        {
            var _loc2_:String = "as_hideContainers" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
