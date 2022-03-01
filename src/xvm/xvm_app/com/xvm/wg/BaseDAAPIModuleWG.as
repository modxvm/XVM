package com.xvm.wg
{
    //import net.wg.infrastructure.base.meta.impl.BaseDAAPIModuleMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.data.constants.Errors;

    public class BaseDAAPIModuleWG extends BaseDAAPIModuleMetaWG implements IDAAPIModule
    {

        private var _disposed:Boolean = false;

        private var _isDAAPIInited:Boolean = false;

        public function BaseDAAPIModuleWG()
        {
            super();
        }

        public function dispose(): void
        {
            this._disposed = true;
        }

        public function get isDisposed() : Boolean
        {
            return this._disposed;
        }

        protected function onPopulate() : void
        {
            // virtual
        }

        protected function onDispose() : void
        {
            // virtual
        }

        public final function as_populate() : void
        {
            try
            {
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
                this._isDAAPIInited = true;
                this.onPopulate();
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
                return;
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
                return;
            }
            catch(error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
                return;
            }
        }

        public final function as_dispose() : void
        {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            this.onDispose();
            this._disposed = true;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
        }

        protected final function assert(param1:Boolean, param2:String = "failed assert") : void
        {
            App.utils.asserter.assert(param1, param2);
        }

        protected final function assertNotNull(param1:Object, param2:String = "object") : void
        {
            App.utils.asserter.assertNotNull(param1, param2 + Errors.CANT_NULL);
        }

        protected final function assertNull(param1:Object, param2:String = "object") : void
        {
            App.utils.asserter.assertNull(param1, param2 + Errors.MUST_NULL);
        }

        public function get isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
    }
}
