package net.wg.gui.lobby.storage.categories.cards.configs
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.utils.StageSizeBoundaries;
    import flash.geom.Rectangle;

    public class CardImageConfig extends Object implements IDisposable
    {

        protected var _imagesByResolution:Object;

        public function CardImageConfig()
        {
            this._imagesByResolution = {};
            super();
        }

        public function initialize() : void
        {
            this._imagesByResolution[StageSizeBoundaries.WIDTH_1024] = this._imagesByResolution[StageSizeBoundaries.WIDTH_1366] = new CardImageSizeVO(new Rectangle(-1,-1,144,108),new Rectangle(-1,-1,144,108));
            this._imagesByResolution[StageSizeBoundaries.WIDTH_1600] = this._imagesByResolution[StageSizeBoundaries.WIDTH_1920] = new CardImageSizeVO(new Rectangle(-1,-1,180,135),new Rectangle(-1,-1,180,135));
        }

        public final function dispose() : void
        {
            this._imagesByResolution = App.utils.data.cleanupDynamicObject(this._imagesByResolution);
        }

        public function getConfig(param1:int) : CardImageSizeVO
        {
            return this._imagesByResolution[param1];
        }
    }
}
