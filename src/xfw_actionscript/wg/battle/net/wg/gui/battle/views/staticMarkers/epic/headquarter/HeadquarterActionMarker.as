package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
    import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
    import flash.geom.Point;

    public class HeadquarterActionMarker extends BaseActionMarker
    {

        private static const ARROW_POSITION:Point = new Point(0,0);

        private static const REPLY_POSITION:Point = new Point(25,-1);

        private static const DISTANCE_POSITION:Point = new Point(-43,15);

        public function HeadquarterActionMarker()
        {
            super();
        }

        override protected function get getReplyPosition() : Point
        {
            return REPLY_POSITION;
        }

        override protected function get getArrowPosition() : Point
        {
            return ARROW_POSITION;
        }

        override protected function get getDistanceToMarkerPosition() : Point
        {
            return DISTANCE_POSITION;
        }

        override protected function onDispose() : void
        {
            super.onDispose();
        }

        override public function setReplyCount(param1:int) : void
        {
            super.setReplyCount(param1);
        }
    }
}
