package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class HeaderTutorialDialogMeta extends AbstractWindowView
    {
        
        public function HeaderTutorialDialogMeta()
        {
            super();
        }
        
        public var onButtonClick:Function = null;
        
        public function onButtonClickS(param1:String, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onButtonClick,"onButtonClick" + Errors.CANT_NULL);
            this.onButtonClick(param1,param2);
        }
    }
}
