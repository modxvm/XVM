package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.lobby.epicBattles.data.EpicMetaLevelIconVO;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;

    public class EpicBattlesMetaLevel extends UIComponentEx
    {

        private static const IMAGE_SIZE_MAP:Object = {
            130:"130x130",
            150:"150x150",
            190:"190x190",
            270:"270x270",
            320:"320x320"
        };

        private static const SEASON_FONT_SIZE:Object = {
            130:12,
            150:14,
            190:18,
            270:28,
            320:32
        };

        private static const LEVEL_FONT_SIZE:Object = {
            130:22,
            150:26,
            190:35,
            270:50,
            320:65
        };

        private static const LABEL_PREFIX:String = "bg";

        public var levelTF:EpicLevelTextWrapper = null;

        public var prestigeLevelTF:EpicLevelTextWrapper = null;

        public var bgImage:Image = null;

        private var _size:int = 190;

        private var _data:EpicMetaLevelIconVO;

        private const LEVEL_V_OFFSET:Object = {
            130:-22,
            150:-25,
            190:-31,
            270:-45,
            320:-58
        };

        private const SEASON_V_OFFSET:Object = {
            130:26,
            150:31,
            190:40,
            270:55,
            320:66
        };

        private const SEASON_H_OFFSET:Array = [1,0,0,1,1];

        private const LEVEL_H_OFFSET:Object = {
            130:1,
            150:0,
            190:0,
            270:0,
            320:0
        };

        public function EpicBattlesMetaLevel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.bgImage.addEventListener(Event.CHANGE,this.onImageChangeHandler);
        }

        override protected function draw() : void
        {
            var _loc2_:String = null;
            super.draw();
            if(!this._data)
            {
                return;
            }
            var _loc1_:String = this._data.metLvlBGImageId.toString();
            if(isInvalid(InvalidationType.SIZE))
            {
                App.utils.asserter.assert(IMAGE_SIZE_MAP.hasOwnProperty(this._size.toString()),"Invalid image size");
                this.bgImage.source = RES_ICONS.getEpicMetaLvlIcon(IMAGE_SIZE_MAP[this._size],_loc1_);
                _loc2_ = LABEL_PREFIX + _loc1_;
                this.levelTF.gotoAndStop(_loc2_);
                this.prestigeLevelTF.gotoAndStop(_loc2_);
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.bgImage.visible = true;
                this.levelTF.setText(this._data.level);
                this.prestigeLevelTF.setText(this._data.cycleNumberHtmlText);
            }
            if(isInvalid(InvalidationType.SIZE,InvalidationType.DATA))
            {
                this.levelTF.setTextSize(SEASON_FONT_SIZE[this._size]);
                this.prestigeLevelTF.setTextSize(LEVEL_FONT_SIZE[this._size]);
                this.levelTF.x = (-this.levelTF.width >> 1) + this.SEASON_H_OFFSET[_loc1_];
                this.levelTF.y = this.SEASON_V_OFFSET[this._size];
                this.prestigeLevelTF.x = (-this.prestigeLevelTF.width >> 1) + this.LEVEL_H_OFFSET[this._size];
                this.prestigeLevelTF.y = this.LEVEL_V_OFFSET[this._size];
            }
        }

        override protected function onDispose() : void
        {
            stop();
            this.levelTF.dispose();
            this.levelTF = null;
            this.prestigeLevelTF.dispose();
            this.prestigeLevelTF = null;
            if(this.bgImage != null)
            {
                this.bgImage.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
                this.bgImage.dispose();
                this.bgImage = null;
            }
            this._data = null;
            super.onDispose();
        }

        public function setIconSize(param1:int) : void
        {
            this._size = param1;
            invalidateSize();
        }

        public function setData(param1:EpicMetaLevelIconVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this.bgImage.x = -this.bgImage.width >> 1;
            this.bgImage.y = -this.bgImage.height >> 1;
        }
    }
}
