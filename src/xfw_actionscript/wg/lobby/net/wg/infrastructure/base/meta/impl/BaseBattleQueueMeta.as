package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;

    public class BaseBattleQueueMeta extends AbstractView
    {

        public var exitClick:Function;

        public var onEscape:Function;

        public function BaseBattleQueueMeta()
        {
            super();
        }

        public function exitClickS() : void
        {
            App.utils.asserter.assertNotNull(this.exitClick,"exitClick" + Errors.CANT_NULL);
            this.exitClick();
        }

        public function onEscapeS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
            this.onEscape();
        }
    }
}
