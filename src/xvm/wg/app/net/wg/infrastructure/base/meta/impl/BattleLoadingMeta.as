package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class BattleLoadingMeta extends AbstractView
    {
        
        public function BattleLoadingMeta()
        {
            super();
        }
        
        public var onLoadComplete:Function = null;
        
        public function onLoadCompleteS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.onLoadComplete,"onLoadComplete" + Errors.CANT_NULL);
            return this.onLoadComplete();
        }
    }
}
