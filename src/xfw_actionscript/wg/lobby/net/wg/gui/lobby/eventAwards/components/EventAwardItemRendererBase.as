package net.wg.gui.lobby.eventAwards.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class EventAwardItemRendererBase extends Sprite implements IDisposable
    {

        public function EventAwardItemRendererBase()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:Object) : void
        {
        }

        protected function onDispose() : void
        {
        }
    }
}
