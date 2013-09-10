package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ExchangeFreeToTankmanXpWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ExchangeFreeToTankmanXpWindowMeta()
        {
            super();
            return;
        }

        public function applyS():void
        {
            App.utils.asserter.assertNotNull(this.apply, "apply" + net.wg.data.constants.Errors.CANT_NULL);
            this.apply();
            return;
        }

        public function onValueChangedS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.onValueChanged, "onValueChanged" + net.wg.data.constants.Errors.CANT_NULL);
            this.onValueChanged(arg1);
            return;
        }

        public function calcValueRequestS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.calcValueRequest, "calcValueRequest" + net.wg.data.constants.Errors.CANT_NULL);
            this.calcValueRequest(arg1);
            return;
        }

        public var apply:Function=null;

        public var onValueChanged:Function=null;

        public var calcValueRequest:Function=null;
    }
}
