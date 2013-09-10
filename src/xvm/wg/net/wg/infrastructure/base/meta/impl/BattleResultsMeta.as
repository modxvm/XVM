package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BattleResultsMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function BattleResultsMeta()
        {
            super();
            return;
        }

        public function saveSortingS(arg1:String, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.saveSorting, "saveSorting" + net.wg.data.constants.Errors.CANT_NULL);
            this.saveSorting(arg1, arg2);
            return;
        }

        public function showQuestsWindowS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showQuestsWindow, "showQuestsWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showQuestsWindow(arg1);
            return;
        }

        public var saveSorting:Function=null;

        public var showQuestsWindow:Function=null;
    }
}
