package net.wg.gui.lobby.storage.categories.cards.configs
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Rectangle;

    public class CardImageSizeVO extends Object implements IDisposable
    {

        private var _imageSize:Rectangle;

        private var _imageSizeWide:Rectangle;

        public function CardImageSizeVO(param1:Rectangle, param2:Rectangle)
        {
            super();
            this._imageSize = param1;
            this._imageSizeWide = param2;
        }

        public function getRect(param1:Boolean) : Rectangle
        {
            return param1?this._imageSizeWide:this._imageSize;
        }

        public function dispose() : void
        {
            this._imageSize = null;
            this._imageSizeWide = null;
        }
    }
}
