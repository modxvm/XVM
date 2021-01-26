package net.wg.gui.lobby.hangar.quests
{
    import net.wg.gui.components.containers.inject.GFInjectComponent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;

    public class BobHangarWidget extends GFInjectComponent implements IHeaderFlagsEntryPoint
    {

        private static const WIDTH:int = 320;

        private static const HEIGHT:int = 240;

        private static const MARGIN_X:int = -(WIDTH >> 1);

        public function BobHangarWidget()
        {
            super();
        }

        override protected function configUI() : void
        {
            setSize(WIDTH,HEIGHT);
        }

        public function get marginX() : int
        {
            return MARGIN_X;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                x = MARGIN_X;
                dispatchEvent(new Event(Event.RESIZE));
            }
        }
    }
}
