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

        private var _vectorString2:Vector.<String>;

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
            if(this._vectorString2)
            {
                this._vectorString2.splice(0,this._vectorString2.length);
                this._vectorString2 = null;
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

        public final function as_setContainersVisible(param1:Boolean, param2:Array) : void
        {
            var _loc3_:Vector.<String> = this._vectorString2;
            this._vectorString2 = new Vector.<String>(0);
            var _loc4_:uint = param2.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                this._vectorString2[_loc5_] = param2[_loc5_];
                _loc5_++;
            }
            this.setContainersVisible(param1,this._vectorString2);
            if(_loc3_)
            {
                _loc3_.splice(0,_loc3_.length);
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

        protected function setContainersVisible(param1:Boolean, param2:Vector.<String>) : void
        {
            var _loc3_:String = "as_setContainersVisible" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
