package net.wg.gui.lobby.eventAwards.components
{
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenBgAnim extends EventAwardScreenAnim
    {

        public var bg:EventAwardScreenBgHolder;

        public function EventAwardScreenBgAnim()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.bg.width = _width;
                this.bg.height = _height;
            }
        }

        override protected function onDispose() : void
        {
            this.bg.dispose();
            this.bg = null;
            super.onDispose();
        }

        public function setBackground(param1:String) : void
        {
            this.bg.setBackground(param1);
        }
    }
}
