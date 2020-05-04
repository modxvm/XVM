package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.utils.ILocale;
    import net.wg.utils.ICommons;

    public class ProgressContainer extends MovieClip implements IDisposable
    {

        private static const DIVIDER:String = "/";

        public var textCurrent:TextField = null;

        public var textTotal:TextField = null;

        public var textDivider:TextField = null;

        private var _locale:ILocale;

        private var _commons:ICommons;

        public function ProgressContainer()
        {
            this._locale = App.utils.locale;
            this._commons = App.utils.commons;
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setProgress(param1:int, param2:int) : void
        {
            this.textCurrent.text = this._locale.integer(param1);
            this.textTotal.text = this._locale.integer(param2);
            this.textDivider.text = DIVIDER;
            this._commons.updateTextFieldSize(this.textTotal,true,false);
            this.textTotal.x = -this.textTotal.width | 0;
            this.textDivider.x = this.textTotal.x - this.textDivider.width | 0;
            this.textCurrent.x = this.textDivider.x - this.textCurrent.width | 0;
        }

        protected function onDispose() : void
        {
            this.textCurrent = null;
            this.textTotal = null;
            this.textDivider = null;
            this._locale = null;
            this._commons = null;
        }
    }
}
