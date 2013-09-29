package net.wg.infrastructure.base 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class BaseDAAPIModule extends net.wg.infrastructure.base.meta.impl.BaseDAAPIModuleMeta implements net.wg.infrastructure.interfaces.IDAAPIModule
    {
        public function BaseDAAPIModule()
        {
            super();
            return;
        }

        public function get disposed():Boolean
        {
            return this._disposed;
        }

        protected function onPopulate():void
        {
            return;
        }

        protected function onDispose():void
        {
            return;
        }

        public final function as_populate():void
        {
            dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_POPULATE));
            this.onPopulate();
            dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_POPULATE));
            return;
        }

        public final function as_dispose():void
        {
            dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE));
            this.onDispose();
            this._disposed = true;
            dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE));
            return;
        }

        protected final function assert(arg1:Boolean, arg2:String="failed assert"):void
        {
            App.utils.asserter.assert(arg1, arg2);
            return;
        }

        protected final function assertNotNull(arg1:Object, arg2:String="object"):void
        {
            App.utils.asserter.assertNotNull(arg1, arg2 + net.wg.data.constants.Errors.CANT_NULL);
            return;
        }

        protected final function assertNull(arg1:Object, arg2:String="object"):void
        {
            App.utils.asserter.assertNull(arg1, arg2 + net.wg.data.constants.Errors.MUST_NULL);
            return;
        }

        internal var _disposed:Boolean=false;
    }
}
