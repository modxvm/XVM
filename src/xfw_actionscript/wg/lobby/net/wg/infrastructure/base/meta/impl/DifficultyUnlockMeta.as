package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.data.constants.Errors;

    public class DifficultyUnlockMeta extends AbstractScreen
    {

        public var onCloseClick:Function;

        public var onDifficultyChangeClick:Function;

        public function DifficultyUnlockMeta()
        {
            super();
        }

        public function onCloseClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCloseClick,"onCloseClick" + Errors.CANT_NULL);
            this.onCloseClick();
        }

        public function onDifficultyChangeClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onDifficultyChangeClick,"onDifficultyChangeClick" + Errors.CANT_NULL);
            this.onDifficultyChangeClick();
        }
    }
}
