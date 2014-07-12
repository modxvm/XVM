package net.wg.infrastructure.base
{
    import net.wg.infrastructure.base.meta.impl.WrapperViewMeta;
    import net.wg.infrastructure.base.meta.IWrapperViewMeta;
    import net.wg.infrastructure.interfaces.IWrapper;
    
    public class AbstractWrapperView extends WrapperViewMeta implements IWrapperViewMeta
    {
        
        public function AbstractWrapperView() {
            super();
        }
        
        private var _wrapper:IWrapper;
        
        public function get wrapper() : IWrapper {
            return this._wrapper;
        }
        
        public function set wrapper(param1:IWrapper) : void {
            this._wrapper = param1;
            invalidateSize();
        }
        
        override protected function onDispose() : void {
            if(this._wrapper)
            {
                this._wrapper.dispose();
                this._wrapper = null;
            }
            super.onDispose();
        }
    }
}
