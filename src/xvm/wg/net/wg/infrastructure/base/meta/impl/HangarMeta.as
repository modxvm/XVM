package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class HangarMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function HangarMeta()
        {
            super();
            return;
        }

        public function onEscapeS():void
        {
            App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + net.wg.data.constants.Errors.CANT_NULL);
            this.onEscape();
            return;
        }

        public function checkMoneyS():void
        {
            App.utils.asserter.assertNotNull(this.checkMoney, "checkMoney" + net.wg.data.constants.Errors.CANT_NULL);
            this.checkMoney();
            return;
        }

        public function showHelpLayoutS():void
        {
            App.utils.asserter.assertNotNull(this.showHelpLayout, "showHelpLayout" + net.wg.data.constants.Errors.CANT_NULL);
            this.showHelpLayout();
            return;
        }

        public function closeHelpLayoutS():void
        {
            App.utils.asserter.assertNotNull(this.closeHelpLayout, "closeHelpLayout" + net.wg.data.constants.Errors.CANT_NULL);
            this.closeHelpLayout();
            return;
        }

        public var onEscape:Function=null;

        public var checkMoney:Function=null;

        public var showHelpLayout:Function=null;

        public var closeHelpLayout:Function=null;
    }
}
