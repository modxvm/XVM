package net.wg.gui.components.dogtag
{
    import flash.utils.Dictionary;
    import net.wg.gui.components.controls.Image;
    import net.wg.data.constants.Values;
    import flash.display.BitmapData;
    import net.wg.data.constants.Errors;

    public class ImageRepository extends Object
    {

        private static var _instance:ImageRepository;

        private static const BACKGROUND:String = "background";

        private static const ENGRAVING:String = "engraving";

        private var _images:Dictionary = null;

        public function ImageRepository()
        {
            super();
            this._images = new Dictionary();
        }

        public static function getInstance() : ImageRepository
        {
            if(!_instance)
            {
                _instance = new ImageRepository();
            }
            return _instance;
        }

        public function setImages(param1:Array) : void
        {
            var _loc3_:Image = null;
            var _loc2_:* = 0;
            while(_loc2_ < param1.length)
            {
                _loc3_ = new Image();
                if(param1[_loc2_].indexOf(BACKGROUND) != -1)
                {
                    _loc3_.source = RES_ICONS.maps_icons_dogtags_small_backgrounds_all_png(param1[_loc2_]);
                }
                if(param1[_loc2_].indexOf(ENGRAVING) != -1)
                {
                    _loc3_.source = RES_ICONS.maps_icons_dogtags_small_engravings_all_png(param1[_loc2_]);
                }
                if(_loc3_.source == Values.EMPTY_STR)
                {
                    App.utils.asserter.assert(false,"Unsupported image name convention");
                }
                this._images[param1[_loc2_]] = _loc3_;
                _loc2_++;
            }
        }

        public function getImageBitmapData(param1:String) : BitmapData
        {
            if(this._images[param1])
            {
                return this._images[param1].bitmapData;
            }
            App.utils.asserter.assertNotNull(this._images[param1],"preloaded image " + Errors.CANT_NULL);
            return null;
        }
    }
}
