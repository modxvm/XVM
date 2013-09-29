package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class SoundManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function SoundManagerMeta()
        {
            super();
            return;
        }

        public function soundEventHandlerS(arg1:String, arg2:String, arg3:String, arg4:String):void
        {
            App.utils.asserter.assertNotNull(this.soundEventHandler, "soundEventHandler" + net.wg.data.constants.Errors.CANT_NULL);
            this.soundEventHandler(arg1, arg2, arg3, arg4);
            return;
        }

        public var soundEventHandler:Function=null;
    }
}
