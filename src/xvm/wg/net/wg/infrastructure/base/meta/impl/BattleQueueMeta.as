package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BattleQueueMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function BattleQueueMeta()
        {
            super();
            return;
        }

        public function startClickS():void
        {
            App.utils.asserter.assertNotNull(this.startClick, "startClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.startClick();
            return;
        }

        public function exitClickS():void
        {
            App.utils.asserter.assertNotNull(this.exitClick, "exitClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.exitClick();
            return;
        }

        public function onEscapeS():void
        {
            App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + net.wg.data.constants.Errors.CANT_NULL);
            this.onEscape();
            return;
        }

        public var startClick:Function=null;

        public var exitClick:Function=null;

        public var onEscape:Function=null;
    }
}
