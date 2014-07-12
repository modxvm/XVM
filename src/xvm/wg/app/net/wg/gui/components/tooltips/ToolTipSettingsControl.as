package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.tooltips.VO.SettingsControlVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    
    public class ToolTipSettingsControl extends ToolTipSpecial
    {
        
        public function ToolTipSettingsControl() {
            super();
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            this.recommendedTF = content.recommendedTF;
            this.warningTF = content.warningTF;
            this.warnIcon = content.warnIcon;
            this.whiteBg = content.whiteBg;
            contentMargin.bottom = 18;
            contentMargin.right = 0;
        }
        
        private static var MAX_WIDTH:Number = 283;
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var recommendedTF:TextField;
        
        public var warningTF:TextField;
        
        public var warnIcon:Sprite;
        
        public var whiteBg:Sprite;
        
        private var model:SettingsControlVO;
        
        override protected function redraw() : void {
            var _loc1_:Separator = null;
            var _loc2_:String = null;
            var _loc3_:String = null;
            this.disposeModel();
            this.model = new SettingsControlVO(_data);
            separators = new Vector.<Separator>();
            this.headerTF.htmlText = Utils.instance.htmlWrapper(this.model.name,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.width = MAX_WIDTH - (contentMargin.left + contentMargin.right);
            this.headerTF.height = this.headerTF.textHeight + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
            this.descriptionTF.y = topPosition;
            this.descriptionTF.htmlText = Utils.instance.htmlWrapper(this.model.descr,Utils.instance.COLOR_NORMAL,12,"$TextFont");
            this.descriptionTF.height = this.descriptionTF.textHeight + 5;
            topPosition = topPosition + (this.descriptionTF.height + Utils.instance.MARGIN_AFTER_BLOCK);
            if(this.model.recommended)
            {
                _loc1_ = Utils.instance.createSeparate(content);
                _loc1_.y = topPosition ^ 0;
                this.whiteBg.y = topPosition ^ 0;
                separators.push(_loc1_);
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                _loc2_ = App.utils.locale.makeString(this.model.recommended);
                _loc3_ = App.utils.locale.makeString(TOOLTIPS.SETTINGSCONTROL_RECOMMENDED,{"value":_loc2_});
                this.recommendedTF.htmlText = Utils.instance.htmlWrapper(_loc3_,Utils.instance.COLOR_ADD_INFO,12,"$TextFont");
                this.recommendedTF.y = topPosition;
                topPosition = topPosition + (this.recommendedTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
                _loc1_ = Utils.instance.createSeparate(content);
                _loc1_.y = topPosition ^ 0;
                separators.push(_loc1_);
                this.whiteBg.height = topPosition - this.whiteBg.y;
                topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
                this.whiteBg.visible = true;
            }
            else
            {
                this.whiteBg.visible = false;
            }
            if((this.model.status) && (this.model.status.text))
            {
                this.warnIcon.visible = true;
                this.warningTF.visible = true;
                this.warnIcon.y = topPosition;
                this.warningTF.y = topPosition + 2;
                this.warningTF.x = this.warnIcon.x + this.warnIcon.width + 4;
                this.warningTF.htmlText = Utils.instance.htmlWrapper(this.model.status.text,Utils.instance.COLOR_WARNING,12,"$TextFont");
                this.warningTF.height = this.warningTF.textHeight + 5;
            }
            else
            {
                this.warnIcon.visible = false;
                this.warningTF.visible = false;
            }
            super.redraw();
        }
        
        override protected function updateSize() : void {
            super.updateSize();
            if((this.whiteBg) && (this.whiteBg.visible))
            {
                this.whiteBg.width = bgShadowMargin.left + contentWidth;
            }
        }
        
        override protected function onDispose() : void {
            this.disposeModel();
            super.onDispose();
        }
        
        private function disposeModel() : void {
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
    }
}
