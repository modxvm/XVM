package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.events.UILoaderEvent;
    
    public class HBC_Squad extends HeaderButtonContentItem
    {
        
        public function HBC_Squad()
        {
            super();
            _minScreenPadding.left = 13;
            _minScreenPadding.right = 11;
            _additionalScreenPadding.left = 4;
            _additionalScreenPadding.right = -2;
            _maxFontSize = 14;
            _hideDisplayObjList.push(this.icon);
        }
        
        public var textField:TextField = null;
        
        public var icon:UILoaderAlt = null;
        
        private var _squadDataVo:HBC_SquadDataVo = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            this.icon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
        }
        
        private function onIcoLoaded(param1:UILoaderEvent) : void
        {
            this.updateData();
        }
        
        override protected function updateSize() : void
        {
            bounds.width = this.icon.visible?this.icon.x + this.icon.width:this.textField.x + this.textField.width;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            if(data)
            {
                this.textField.text = this._squadDataVo.buttonName;
            }
            else
            {
                this.textField.text = MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
            }
            if(this.isNeedUpdateFont())
            {
                updateFontSize(this.textField,useFontSize);
                needUpdateFontSize = false;
            }
            this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
            this.icon.x = this.textField.width + ICON_MARGIN ^ 0;
            super.updateData();
        }
        
        override protected function onDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            super.onDispose();
        }
        
        override public function set data(param1:Object) : void
        {
            this._squadDataVo = HBC_SquadDataVo(param1);
            super.data = param1;
        }
        
        override protected function isNeedUpdateFont() : Boolean
        {
            return (super.isNeedUpdateFont()) || !(useFontSize == this.textField.getTextFormat().size);
        }
    }
}
