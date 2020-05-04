package net.wg.gui.lobby.vehiclePreview20.utils
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import net.wg.utils.StageSizeBoundaries;

    public class VehiclePreviewAdaptive extends Object
    {

        public static const SCREEN_SMALL_MESSAGE_FONT_SIZE:uint = 18;

        public static const SCREEN_MESSAGE_FONT_SIZE:uint = 24;

        public static const SCREEN_SMALL_BOTTOM_GAP:uint = 20;

        public static const SCREEN_BOTTOM_GAP:uint = 50;

        public function VehiclePreviewAdaptive()
        {
            super();
        }

        public static function tweakMessageTextField(param1:TextField) : void
        {
            var _loc2_:TextFormat = param1.getTextFormat();
            if(isSmall)
            {
                _loc2_.size = SCREEN_SMALL_MESSAGE_FONT_SIZE;
            }
            else
            {
                _loc2_.size = SCREEN_MESSAGE_FONT_SIZE;
            }
            param1.setTextFormat(_loc2_);
        }

        public static function get isSmall() : Boolean
        {
            return App.appWidth < StageSizeBoundaries.WIDTH_1600 || App.appHeight < StageSizeBoundaries.HEIGHT_837;
        }

        public static function get bottomPanelGap() : int
        {
            return isSmall?SCREEN_SMALL_BOTTOM_GAP:SCREEN_BOTTOM_GAP;
        }
    }
}
