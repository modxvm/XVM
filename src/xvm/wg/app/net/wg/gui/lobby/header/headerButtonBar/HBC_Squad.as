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
        
        private static var DEF_TEXT_COLOR:Number = 9211006;
        
        private static var EVENT_TEXT_COLOR:Number = 15073279;
        
        public var textField:TextField = null;
        
        public var icon:UILoaderAlt = null;
        
        private var _squadDataVo:HBC_SquadDataVo = null;
        
        private var _iconWidth:Number = 0;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            this.icon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
        }
        
        private function onIcoLoaded(param1:UILoaderEvent) : void
        {
            if(this._iconWidth == 0)
            {
                this._iconWidth = this.icon.width;
            }
            this.updateData();
            this.updateSize();
        }
        
        override protected function updateSize() : void
        {
            var _loc1_:Number = this._iconWidth?this._iconWidth:this.icon.width;
            bounds.width = (this.icon.source) && (this.icon.visible)?this.icon.x + _loc1_:this.textField.x + this.textField.width;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            if(data)
            {
                this.icon.source = this._squadDataVo.isEventSquad?RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_EVENTSQUAD:RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
                this.textField.text = this._squadDataVo.buttonName;
                this.textField.textColor = this._squadDataVo.isEventSquad?EVENT_TEXT_COLOR:DEF_TEXT_COLOR;
            }
            else
            {
                this.icon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
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
