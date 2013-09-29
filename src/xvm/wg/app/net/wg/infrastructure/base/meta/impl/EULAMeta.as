package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class EULAMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function EULAMeta()
        {
            super();
            return;
        }

        public function requestEULATextS():void
        {
            App.utils.asserter.assertNotNull(this.requestEULAText, "requestEULAText" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestEULAText();
            return;
        }

        public function onLinkClickS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.onLinkClick, "onLinkClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onLinkClick(arg1);
            return;
        }

        public function onApplyS():void
        {
            App.utils.asserter.assertNotNull(this.onApply, "onApply" + net.wg.data.constants.Errors.CANT_NULL);
            this.onApply();
            return;
        }

        public var requestEULAText:Function=null;

        public var onLinkClick:Function=null;

        public var onApply:Function=null;
    }
}
