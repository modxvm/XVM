package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BattleLoadingMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function BattleLoadingMeta()
        {
            super();
            return;
        }

        public function getDataS():void
        {
            App.utils.asserter.assertNotNull(this.getData, "getData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getData();
            return;
        }

        public var getData:Function=null;
    }
}
