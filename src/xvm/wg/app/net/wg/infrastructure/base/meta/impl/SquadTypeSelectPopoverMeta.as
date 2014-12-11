package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    
    public class SquadTypeSelectPopoverMeta extends SmartPopOverView
    {
        
        public function SquadTypeSelectPopoverMeta()
        {
            super();
        }
        
        public var selectFight:Function = null;
        
        public var getTooltipData:Function = null;
        
        public function selectFightS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.selectFight,"selectFight" + Errors.CANT_NULL);
            this.selectFight(param1);
        }
        
        public function getTooltipDataS(param1:String) : String
        {
            App.utils.asserter.assertNotNull(this.getTooltipData,"getTooltipData" + Errors.CANT_NULL);
            return this.getTooltipData(param1);
        }
    }
}
