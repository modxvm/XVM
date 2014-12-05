package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class QuestsSeasonsViewMeta extends BaseDAAPIComponent
    {
        
        public function QuestsSeasonsViewMeta()
        {
            super();
        }
        
        public var onShowAwardsClick:Function = null;
        
        public var onTileClick:Function = null;
        
        public var onSlotClick:Function = null;
        
        public function onShowAwardsClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onShowAwardsClick,"onShowAwardsClick" + Errors.CANT_NULL);
            this.onShowAwardsClick(param1);
        }
        
        public function onTileClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onTileClick,"onTileClick" + Errors.CANT_NULL);
            this.onTileClick(param1);
        }
        
        public function onSlotClickS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onSlotClick,"onSlotClick" + Errors.CANT_NULL);
            this.onSlotClick(param1);
        }
    }
}
