package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TmenXpPanelMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function TmenXpPanelMeta()
        {
            super();
            return;
        }

        public function accelerateTmenXpS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.accelerateTmenXp, "accelerateTmenXp" + net.wg.data.constants.Errors.CANT_NULL);
            this.accelerateTmenXp(arg1);
            return;
        }

        public var accelerateTmenXp:Function=null;
    }
}
