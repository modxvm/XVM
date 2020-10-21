package net.wg.gui.lobby.eventStylesTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.ICommons;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;

    public class StyleInfoPanel extends Sprite implements IDisposable
    {

        private static const OFFSET:int = -50;

        private static const UPDATABLE_WIDTH:int = 300;

        public var titleTF:TextField = null;

        public var uniqTF:TextField = null;

        public var image:UILoaderAlt = null;

        public var mapTitleTF:TextField = null;

        public var mapTF:TextField = null;

        public var tankNameTitleTF:TextField = null;

        public var tankNameTF:TextField = null;

        public var modeTitleTF:TextField = null;

        public var modeTF:TextField = null;

        public var bonusTitleTF:TextField = null;

        public var bonusTF:TextField = null;

        private var _commons:ICommons;

        public function StyleInfoPanel()
        {
            this._commons = App.utils.commons;
            super();
            this.configUI();
        }

        public function setData(param1:SkinVO) : void
        {
            this.titleTF.text = param1.name;
            this.image.source = param1.image;
            this.tankNameTF.width = UPDATABLE_WIDTH;
            this.tankNameTF.text = param1.suitableTank;
            this.bonusTF.text = param1.bonus;
            this._commons.updateTextFieldSize(this.tankNameTF,true,false);
            this._commons.updateTextFieldSize(this.bonusTF,true,false);
            this.tankNameTF.x = OFFSET - this.tankNameTF.width >> 0;
            this.tankNameTitleTF.x = this.tankNameTF.x - this.tankNameTitleTF.width >> 0;
            this.bonusTF.x = OFFSET - this.bonusTF.width >> 0;
            this.bonusTitleTF.x = this.bonusTF.x - this.bonusTitleTF.width >> 0;
        }

        private function configUI() : void
        {
            this.uniqTF.text = EVENT.TRADESTYLES_INFOUNIQUE;
            this.mapTitleTF.text = EVENT.TRADESTYLES_INFOMAP;
            this.mapTF.text = EVENT.TRADESTYLES_INFOMAPANY;
            this.tankNameTitleTF.text = EVENT.TRADESTYLES_INFOVEHTYPE;
            this.modeTitleTF.text = EVENT.TRADESTYLES_INFOMODE;
            this.modeTF.text = EVENT.TRADESTYLES_INFOMODEANY;
            this.bonusTitleTF.text = EVENT.TRADESTYLES_INFOBONUS;
            this._commons.updateTextFieldSize(this.mapTitleTF,true,false);
            this._commons.updateTextFieldSize(this.mapTF,true,false);
            this._commons.updateTextFieldSize(this.tankNameTitleTF,true,false);
            this._commons.updateTextFieldSize(this.modeTitleTF,true,false);
            this._commons.updateTextFieldSize(this.modeTF,true,false);
            this._commons.updateTextFieldSize(this.bonusTitleTF,true,false);
            this.mapTF.x = OFFSET - this.mapTF.width >> 0;
            this.mapTitleTF.x = this.mapTF.x - this.mapTitleTF.width >> 0;
            this.modeTF.x = OFFSET - this.modeTF.width >> 0;
            this.modeTitleTF.x = this.mapTF.x - this.modeTitleTF.width >> 0;
        }

        public final function dispose() : void
        {
            this.titleTF = null;
            this.uniqTF = null;
            this.image.dispose();
            this.image = null;
            this.mapTitleTF = null;
            this.mapTF = null;
            this.tankNameTitleTF = null;
            this.tankNameTF = null;
            this.modeTitleTF = null;
            this.modeTF = null;
            this.bonusTitleTF = null;
            this.bonusTF = null;
            this._commons = null;
        }
    }
}
