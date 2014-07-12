package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class DemonstratorWindowMeta extends AbstractWindowView
    {
        
        public function DemonstratorWindowMeta() {
            super();
        }
        
        public var onMapSelected:Function = null;
        
        public function onMapSelectedS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.onMapSelected,"onMapSelected" + Errors.CANT_NULL);
            this.onMapSelected(param1);
        }
    }
}
