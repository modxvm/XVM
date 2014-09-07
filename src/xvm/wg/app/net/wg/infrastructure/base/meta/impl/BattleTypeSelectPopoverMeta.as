package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    
    public class BattleTypeSelectPopoverMeta extends SmartPopOverView
    {
        
        public function BattleTypeSelectPopoverMeta()
        {
            super();
        }
        
        public var selectFight:Function = null;
        
        public var demoClick:Function = null;
        
        public function selectFightS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.selectFight,"selectFight" + Errors.CANT_NULL);
            this.selectFight(param1);
        }
        
        public function demoClickS() : void
        {
            App.utils.asserter.assertNotNull(this.demoClick,"demoClick" + Errors.CANT_NULL);
            this.demoClick();
        }
    }
}
