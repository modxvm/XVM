package net.wg.gui.lobby.header
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.advanced.ClanEmblem;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.header.vo.AccountPopoverBlockVo;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    
    public class AccountPopoverBlock extends UIComponent
    {
        
        public function AccountPopoverBlock()
        {
            super();
        }
        
        public var emblem:ClanEmblem = null;
        
        public var textFieldHeader:TextField = null;
        
        public var textFieldName:TextField = null;
        
        public var textFieldPosition:TextField = null;
        
        public var doActionBtn:SoundButtonEx = null;
        
        private var data:AccountPopoverBlockVo = null;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                this.updateData();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateSize();
            }
            super.draw();
        }
        
        private function updateSize() : void
        {
            var _loc1_:Number = this.doActionBtn.visible?this.doActionBtn.y + this.doActionBtn.height:this.textFieldPosition.y + this.textFieldPosition.textHeight;
            this.height = _loc1_ ^ 0;
        }
        
        private function updateData() : void
        {
            this.emblem.setImage(this.data.emblemId);
            this.textFieldHeader.text = this.data.formation;
            this.textFieldName.text = this.data.formationName;
            this.textFieldName.height = this.textFieldName.textHeight + 5 ^ 0;
            this.textFieldPosition.y = this.textFieldName.y + this.textFieldName.height - 5;
            this.textFieldPosition.text = this.data.position;
            this.textFieldPosition.height = this.textFieldPosition.textHeight + 5 ^ 0;
            this.doActionBtn.y = this.textFieldPosition.y + this.textFieldPosition.height + 8;
            if((this.data.btnLabel) && !(this.data.btnLabel == Values.EMPTY_STR))
            {
                this.doActionBtn.label = this.data.btnLabel;
            }
            this.emblem.visible = Boolean(this.data.emblemId);
        }
        
        override protected function onDispose() : void
        {
            this.emblem.dispose();
            this.emblem = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        public function setData(param1:AccountPopoverBlockVo) : void
        {
            this.data = param1;
            this.doActionBtn.visible = (this.data.btnLabel) && !(this.data.btnLabel == Values.EMPTY_STR);
            this.doActionBtn.enabled = this.data.btnEnabled;
            invalidateData();
        }
    }
}
