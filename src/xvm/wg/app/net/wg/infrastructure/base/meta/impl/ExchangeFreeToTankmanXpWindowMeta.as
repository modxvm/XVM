package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class ExchangeFreeToTankmanXpWindowMeta extends AbstractWindowView
    {
        
        public function ExchangeFreeToTankmanXpWindowMeta() {
            super();
        }
        
        public var apply:Function = null;
        
        public var onValueChanged:Function = null;
        
        public var calcValueRequest:Function = null;
        
        public function applyS() : void {
            App.utils.asserter.assertNotNull(this.apply,"apply" + Errors.CANT_NULL);
            this.apply();
        }
        
        public function onValueChangedS(param1:Object) : void {
            App.utils.asserter.assertNotNull(this.onValueChanged,"onValueChanged" + Errors.CANT_NULL);
            this.onValueChanged(param1);
        }
        
        public function calcValueRequestS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.calcValueRequest,"calcValueRequest" + Errors.CANT_NULL);
            this.calcValueRequest(param1);
        }
    }
}
