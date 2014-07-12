package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    
    public class CrewOperationsPopOverMeta extends SmartPopOverView
    {
        
        public function CrewOperationsPopOverMeta() {
            super();
        }
        
        public var invokeOperation:Function = null;
        
        public function invokeOperationS(param1:String) : void {
            App.utils.asserter.assertNotNull(this.invokeOperation,"invokeOperation" + Errors.CANT_NULL);
            this.invokeOperation(param1);
        }
    }
}
