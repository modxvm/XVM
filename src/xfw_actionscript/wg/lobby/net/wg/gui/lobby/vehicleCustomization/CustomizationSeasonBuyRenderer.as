package net.wg.gui.lobby.vehicleCustomization
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.CustomizationSlotsLayout;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Linkages;
    import flash.text.TextFieldAutoSize;

    public class CustomizationSeasonBuyRenderer extends Sprite implements IDisposable
    {

        private static const RENDERERS_START_X:int = 17;

        private static const TITLE_Y_BIG:int = 17;

        private static const TITLE_Y_SMALL:int = 10;

        private static const IMAGE_Y_BIG:int = 22;

        private static const IMAGE_Y_SMALL:int = 13;

        private static const RENDERERS_START_BIG_Y:int = 57;

        private static const RENDERERS_START_SMALL_Y:int = 41;

        private static const RENDERERS_OFFSET_X:int = 20;

        private static const RENDERERS_OFFSET_SMALL_X:int = 16;

        private static const RENDERERS_OFFSET_SMALL_Y:int = -46;

        private static const RENDERERS_OFFSET_Y:int = -21;

        private static const TITTLE_OFFSET:int = 42;

        public var seasonIcon:Image = null;

        public var title:TextField = null;

        private var _slotsGroup:GroupEx = null;

        private var _isSmallWidth:Boolean = false;

        private var _isSmallHeight:Boolean = false;

        private var _title:String = "";

        private var _titleSmall:String = "";

        public function CustomizationSeasonBuyRenderer()
        {
            super();
            this.title.autoSize = TextFieldAutoSize.LEFT;
            this.title.x = TITTLE_OFFSET;
            this.title.y = TITLE_Y_BIG;
        }

        public final function dispose() : void
        {
            this.disposeSlotsGroup();
            this.seasonIcon.dispose();
            this.seasonIcon = null;
            this.title = null;
        }

        public function layoutContent() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:CustomizationSlotsLayout = null;
            if(this._slotsGroup)
            {
                this._isSmallWidth = App.appWidth <= CustomizationSlotsLayout.SMALL_SCREEN_WIDTH;
                this._isSmallHeight = App.appHeight < CustomizationSlotsLayout.SMALL_SCREEN_HEIGHT;
                _loc1_ = false;
                if(this._isSmallWidth || this._isSmallHeight)
                {
                    _loc1_ = true;
                }
                this._slotsGroup.width = this._isSmallWidth?CustomizationSlotsLayout.BACKGROUND_SMALL_WIDTH:CustomizationSlotsLayout.BACKGROUND_BIG_WIDTH;
                _loc2_ = _loc1_?RENDERERS_OFFSET_SMALL_X:RENDERERS_OFFSET_X;
                _loc3_ = _loc1_?RENDERERS_OFFSET_SMALL_Y:RENDERERS_OFFSET_Y;
                _loc4_ = new CustomizationSlotsLayout(CustomizationShared.computeItemSize(false,_loc1_).width,CustomizationShared.computeItemSize(true,_loc1_).width,_loc2_,_loc3_);
                this._slotsGroup.y = _loc1_?RENDERERS_START_SMALL_Y:RENDERERS_START_BIG_Y;
                this._slotsGroup.x = RENDERERS_START_X;
                this._slotsGroup.layout = _loc4_;
                this._slotsGroup.invalidate();
                this._slotsGroup.validateNow();
                this.seasonIcon.y = _loc1_?IMAGE_Y_SMALL:IMAGE_Y_BIG;
                this.updateTitle();
                this.title.y = _loc1_?TITLE_Y_SMALL:TITLE_Y_BIG;
            }
        }

        public function setDataProvider(param1:DataProvider) : void
        {
            if(this._slotsGroup == null)
            {
                this.createSlotsGroup();
            }
            this._slotsGroup.dataProvider = param1;
            this.layoutContent();
        }

        public function updateTitleText(param1:String, param2:String) : void
        {
            this._title = param1;
            this._titleSmall = param2;
            this.updateTitle();
        }

        private function updateTitle() : void
        {
            var _loc1_:* = false;
            if(this._isSmallWidth || this._isSmallHeight)
            {
                _loc1_ = true;
            }
            this.title.htmlText = _loc1_?this._titleSmall:this._title;
        }

        private function createSlotsGroup() : void
        {
            this.disposeSlotsGroup();
            this._slotsGroup = new GroupEx();
            this._slotsGroup.itemRendererLinkage = Linkages.CUSTOMIZATION_SEASON_BUY_RENDERER;
            addChild(this._slotsGroup);
        }

        private function disposeSlotsGroup() : void
        {
            if(this._slotsGroup != null)
            {
                removeChild(this._slotsGroup);
                this._slotsGroup.dispose();
                this._slotsGroup = null;
            }
        }
    }
}
