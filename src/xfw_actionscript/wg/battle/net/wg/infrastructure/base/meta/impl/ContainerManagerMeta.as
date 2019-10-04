package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class ContainerManagerMeta extends BaseDAAPIModule
    {

        public var isModalViewsIsExists:Function;

        private var _vectorString:Vector.<String>;

        private var _vectorString1:Vector.<String>;

        public function ContainerManagerMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vectorString)
            {
                this._vectorString.splice(0,this._vectorString.length);
                this._vectorString = null;
            }
            if(this._vectorString1)
            {
                this._vectorString1.splice(0,this._vectorString1.length);
                this._vectorString1 = null;
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
            var _loc2_:Vector.<String> = this._vectorString;
            this._vectorString = new Vector.<String>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorString[_loc4_] = param1[_loc4_];
                _loc4_++;
            }
            this.showContainers(this._vectorString);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        public final function as_hideContainers(param1:Array) : void
        {
            var _loc2_:Vector.<String> = this._vectorString1;
            this._vectorString1 = new Vector.<String>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorString1[_loc4_] = param1[_loc4_];
                _loc4_++;
            }
            this.hideContainers(this._vectorString1);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        protected function showContainers(param1:Vector.<String>) : void
        {
            var _loc2_:String = "as_showContainers" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function hideContainers(param1:Vector.<String>) : void
        {
            var _loc2_:String = "as_hideContainers" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
