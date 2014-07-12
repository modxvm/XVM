package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class FreeXPInfoWindowMeta extends AbstractWindowView
    {
        
        public function FreeXPInfoWindowMeta() {
            super();
        }
        
        public var onSubmitButton:Function = null;
        
        public var onCancelButton:Function = null;
        
        public function onSubmitButtonS() : void {
            App.utils.asserter.assertNotNull(this.onSubmitButton,"onSubmitButton" + Errors.CANT_NULL);
            this.onSubmitButton();
        }
        
        public function onCancelButtonS() : void {
            App.utils.asserter.assertNotNull(this.onCancelButton,"onCancelButton" + Errors.CANT_NULL);
            this.onCancelButton();
        }
    }
}
