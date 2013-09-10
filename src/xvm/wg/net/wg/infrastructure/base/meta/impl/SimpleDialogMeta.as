package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class SimpleDialogMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function SimpleDialogMeta()
        {
            super();
            return;
        }

        public function onButtonClickS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.onButtonClick, "onButtonClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onButtonClick(arg1);
            return;
        }

        public var onButtonClick:Function=null;
    }
}
