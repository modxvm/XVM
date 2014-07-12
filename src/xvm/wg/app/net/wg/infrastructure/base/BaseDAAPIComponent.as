package net.wg.infrastructure.base
{
    import net.wg.infrastructure.base.meta.impl.BaseDAAPIComponentMeta;
    import net.wg.infrastructure.interfaces.IDAAPIComponent;
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    import net.wg.infrastructure.events.LifeCycleEvent;
    
    public class BaseDAAPIComponent extends BaseDAAPIComponentMeta implements IDAAPIComponent
    {
        
        public function BaseDAAPIComponent() {
            super();
        }
        
        private var _disposed:Boolean = false;
        
        public final function as_populate() : void {
            try
            {
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
                this.onPopulate();
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
        }
        
        public final function as_dispose() : void {
            try
            {
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
                dispose();
                this._disposed = true;
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
        }
        
        public function get disposed() : Boolean {
            return this._disposed;
        }
        
        protected function onPopulate() : void {
        }
    }
}
