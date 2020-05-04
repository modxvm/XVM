package net.wg.gui.lobby.eventAwards.components
{
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenAlignedToBottomBtnAnim extends EventAwardScreenBtnAnim
    {

        public static const BOTTOM:int = 105;

        public function EventAwardScreenAlignedToBottomBtnAnim()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                y = _screenHeight - BOTTOM;
            }
        }
    }
}
