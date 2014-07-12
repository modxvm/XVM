package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class RetrainCrewWindowMeta extends AbstractWindowView
    {
        
        public function RetrainCrewWindowMeta() {
            super();
        }
        
        public var submit:Function = null;
        
        public var changeRetrainType:Function = null;
        
        public function submitS(param1:Object) : void {
            App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
            this.submit(param1);
        }
        
        public function changeRetrainTypeS(param1:Number) : Object {
            App.utils.asserter.assertNotNull(this.changeRetrainType,"changeRetrainType" + Errors.CANT_NULL);
            return this.changeRetrainType(param1);
        }
    }
}
