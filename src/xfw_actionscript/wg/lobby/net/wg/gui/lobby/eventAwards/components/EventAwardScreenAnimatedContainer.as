package net.wg.gui.lobby.eventAwards.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;

    public class EventAwardScreenAnimatedContainer extends MovieClip implements IDisposable
    {

        public var child:DisplayObject;

        public function EventAwardScreenAnimatedContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            stop();
            this.child = null;
        }

        public function set childX(param1:int) : void
        {
            this.child.x = param1;
        }

        public function set childY(param1:int) : void
        {
            this.child.y = param1;
        }
    }
}
