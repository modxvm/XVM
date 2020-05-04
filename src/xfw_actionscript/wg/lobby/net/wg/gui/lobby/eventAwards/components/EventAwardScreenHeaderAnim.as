package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.eventAwards.data.EventAwardHeaderVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenHeaderAnim extends EventAwardScreenAnim
    {

        public var header:EventAwardScreenAnimatedTextContainer;

        public var headerExtra:EventAwardScreenAnimatedTextContainer;

        protected var data:EventAwardHeaderVO;

        public function EventAwardScreenHeaderAnim()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            this.data = new EventAwardHeaderVO(param1);
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.header.autoSize = TextFieldAutoSize.CENTER;
            this.headerExtra.autoSize = TextFieldAutoSize.CENTER;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.validateData();
            }
        }

        override protected function onDispose() : void
        {
            this.data.dispose();
            this.data = null;
            this.header.dispose();
            this.header = null;
            this.headerExtra.dispose();
            this.headerExtra = null;
            super.onDispose();
        }

        protected function validateData() : void
        {
            if(this.data != null)
            {
                this.header.setHtmlText(this.data.header);
                this.headerExtra.setHtmlText(this.data.headerExtra);
            }
        }
    }
}
