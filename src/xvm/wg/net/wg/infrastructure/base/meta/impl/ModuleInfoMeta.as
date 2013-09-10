package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ModuleInfoMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ModuleInfoMeta()
        {
            super();
            return;
        }

        public function onCancelClickS():void
        {
            App.utils.asserter.assertNotNull(this.onCancelClick, "onCancelClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCancelClick();
            return;
        }

        public var onCancelClick:Function=null;
    }
}
