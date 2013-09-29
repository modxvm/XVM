package net.wg.infrastructure.base 
{
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.base.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class BaseDAAPIComponent extends net.wg.infrastructure.base.meta.impl.BaseDAAPIComponentMeta implements net.wg.infrastructure.interfaces.IDAAPIComponent
    {
        public function BaseDAAPIComponent()
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
            var loc1:*;
            try 
            {
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_POPULATE));
                this.onPopulate();
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_POPULATE));
            }
            catch (error:net.wg.infrastructure.exceptions.base.WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
            catch (error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
            }
            return;
        }

        public final function as_dispose():void
        {
            var loc1:*;
            try 
            {
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE));
                this.dispose();
                this.onDispose();
                this._disposed = true;
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE));
            }
            catch (error:net.wg.infrastructure.exceptions.base.WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
            catch (error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
            }
            return;
        }

        public final override function dispose():void
        {
            super.dispose();
            return;
        }

        internal var _disposed:Boolean=false;
    }
}
