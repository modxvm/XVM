package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class FightButtonMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function FightButtonMeta()
        {
            super();
            return;
        }

        public function fightClickS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.fightClick, "fightClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.fightClick(arg1, arg2);
            return;
        }

        public function fightSelectClickS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.fightSelectClick, "fightSelectClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.fightSelectClick(arg1);
            return;
        }

        public function demoClickS():void
        {
            App.utils.asserter.assertNotNull(this.demoClick, "demoClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.demoClick();
            return;
        }

        public var fightClick:Function=null;

        public var fightSelectClick:Function=null;

        public var demoClick:Function=null;
    }
}
