package net.wg.gui.battle.views.destroyTimers.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class DestroyTimerContainer extends MovieClip implements IDisposable
    {

        public var progressBar:MovieClip = null;

        public var iconSpr:Sprite = null;

        public var textField:TextField = null;

        public function DestroyTimerContainer()
        {
            super();
            TextFieldEx.setNoTranslate(this.textField,true);
        }

        protected function onDispose() : void
        {
            this.progressBar = null;
            this.iconSpr = null;
            this.textField = null;
        }

        public final function dispose() : void
        {
            this.onDispose();
        }
    }
}
