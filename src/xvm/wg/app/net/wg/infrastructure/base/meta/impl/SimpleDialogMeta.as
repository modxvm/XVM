package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class SimpleDialogMeta extends AbstractWindowView
    {
        
        public function SimpleDialogMeta()
        {
            super();
        }
        
        public var onButtonClick:Function = null;
        
        public function onButtonClickS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onButtonClick,"onButtonClick" + Errors.CANT_NULL);
            this.onButtonClick(param1);
        }
    }
}
