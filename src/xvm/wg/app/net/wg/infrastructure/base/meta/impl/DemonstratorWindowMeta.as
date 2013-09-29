package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class DemonstratorWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function DemonstratorWindowMeta()
        {
            super();
            return;
        }

        public function onMapSelectedS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.onMapSelected, "onMapSelected" + net.wg.data.constants.Errors.CANT_NULL);
            this.onMapSelected(arg1);
            return;
        }

        public var onMapSelected:Function=null;
    }
}
