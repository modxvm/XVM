package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class FightButtonMeta extends BaseDAAPIComponent
    {
        
        public function FightButtonMeta()
        {
            super();
        }
        
        public var fightClick:Function = null;
        
        public var demoClick:Function = null;
        
        public function fightClickS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.fightClick,"fightClick" + Errors.CANT_NULL);
            this.fightClick(param1,param2);
        }
        
        public function demoClickS() : void
        {
            App.utils.asserter.assertNotNull(this.demoClick,"demoClick" + Errors.CANT_NULL);
            this.demoClick();
        }
    }
}
