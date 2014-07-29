package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    
    public class GameInputManagerMeta extends BaseDAAPIModule
    {
        
        public function GameInputManagerMeta()
        {
            super();
        }
        
        public var handleGlobalKeyEvent:Function = null;
        
        public function handleGlobalKeyEventS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent,"handleGlobalKeyEvent" + Errors.CANT_NULL);
            this.handleGlobalKeyEvent(param1,param2);
        }
    }
}
