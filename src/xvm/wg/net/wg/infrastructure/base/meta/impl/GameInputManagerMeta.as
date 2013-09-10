package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class GameInputManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function GameInputManagerMeta()
        {
            super();
            return;
        }

        public function handleGlobalKeyEventS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent, "handleGlobalKeyEvent" + net.wg.data.constants.Errors.CANT_NULL);
            this.handleGlobalKeyEvent(arg1, arg2);
            return;
        }

        public var handleGlobalKeyEvent:Function=null;
    }
}
