package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.lobby.epicBattles.data.EpicMetaLevelIconVO;

    public class EpicBattlesMetaLevel extends UIComponentEx
    {

        public var levelTF:TextField = null;

        public var prestigeLevelTF:TextField = null;

        public var bgImage:Image = null;

        public var topImage:Image = null;

        private var _level:String = "";

        private var _prestigeLevel:String = "";

        private var _bgSrc:String = "";

        private var _topSrc:String = "";

        public function EpicBattlesMetaLevel()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this.bgImage != null && this.topImage != null && isInvalid(InvalidationType.DATA))
            {
                this.bgImage.visible = true;
                this.bgImage.source = this._bgSrc;
                this.topImage.visible = StringUtils.isNotEmpty(this._topSrc);
                if(this.topImage.visible)
                {
                    this.topImage.source = this._topSrc;
                }
                this.levelTF.text = this._level;
                this.prestigeLevelTF.htmlText = this._prestigeLevel;
            }
        }

        override protected function onDispose() : void
        {
            stop();
            this.levelTF = null;
            this.prestigeLevelTF = null;
            if(this.bgImage != null)
            {
                this.bgImage.dispose();
                this.bgImage = null;
            }
            if(this.topImage != null)
            {
                this.topImage.dispose();
                this.topImage = null;
            }
            super.onDispose();
        }

        public function setData(param1:EpicMetaLevelIconVO) : void
        {
            this._bgSrc = param1.metLvlBGImageSrc;
            this._topSrc = param1.metLvlTopImageSrc;
            this._level = param1.level;
            this._prestigeLevel = param1.prestigeLevelHtmlText;
            invalidateData();
        }
    }
}
