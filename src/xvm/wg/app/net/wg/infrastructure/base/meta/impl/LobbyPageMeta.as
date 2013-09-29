package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class LobbyPageMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function LobbyPageMeta()
        {
            super();
            return;
        }

        public function moveSpaceS(arg1:Number, arg2:Number, arg3:Number):void
        {
            App.utils.asserter.assertNotNull(this.moveSpace, "moveSpace" + net.wg.data.constants.Errors.CANT_NULL);
            this.moveSpace(arg1, arg2, arg3);
            return;
        }

        public var moveSpace:Function=null;
    }
}
