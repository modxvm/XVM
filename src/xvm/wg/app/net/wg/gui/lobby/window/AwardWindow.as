package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.AwardWindowMeta;
    import net.wg.infrastructure.base.meta.IAwardWindowMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.battleResults.MedalsList;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.TextAreaSimple;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.UILoaderEvent;
    import flash.display.InteractiveObject;
    import net.wg.data.VO.AwardWindowVO;
    import scaleform.clik.data.DataProvider;
    
    public class AwardWindow extends AwardWindowMeta implements IAwardWindowMeta
    {
        
        public function AwardWindow()
        {
            super();
            isCentered = true;
            isModal = false;
        }
        
        private static var DASH_LINE_HORIZONTAL_OFFSET:Number = 20;
        
        private static var DASH_LINE_VERTICAL_OFFSET_BEFORE:Number = 20;
        
        private static var DASH_LINE_VERTICAL_OFFSET_AFTER:Number = 14;
        
        private static var AWARD_IMAGE_BOTTOM_OFFSET:Number = 40;
        
        private static var MIN_BUTTON_WIDTH:Number = 136;
        
        public var backImage:UILoaderAlt;
        
        public var awardImage:UILoaderAlt;
        
        public var medalsList:MedalsList;
        
        public var headerTF:TextField;
        
        public var textArea:TextAreaSimple;
        
        public var additionalTF:TextField;
        
        public var dashLine:DashLine;
        
        public var okButton:SoundButtonEx;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.okButton.minWidth = MIN_BUTTON_WIDTH;
            this.okButton.autoSize = TextFieldAutoSize.CENTER;
            this.okButton.addEventListener(ButtonEvent.CLICK,this.okButtonClickHandler);
            this.awardImage.autoSize = false;
            this.awardImage.addEventListener(UILoaderEvent.COMPLETE,this.awardImageLoadedHandler);
            this.dashLine.x = DASH_LINE_HORIZONTAL_OFFSET;
            this.dashLine.width = width - DASH_LINE_HORIZONTAL_OFFSET * 2;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.okButton);
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
            setFocus(this.okButton);
        }
        
        override protected function onDispose() : void
        {
            this.okButton.removeEventListener(ButtonEvent.CLICK,this.okButtonClickHandler);
            this.okButton.dispose();
            this.okButton = null;
            this.dashLine.dispose();
            this.dashLine = null;
            this.backImage.dispose();
            this.backImage = null;
            this.awardImage.removeEventListener(UILoaderEvent.COMPLETE,this.awardImageLoadedHandler);
            this.awardImage.dispose();
            this.awardImage = null;
            this.textArea.dispose();
            this.textArea = null;
            this.medalsList.dispose();
            this.medalsList = null;
            this.headerTF = null;
            this.additionalTF = null;
            super.onDispose();
        }
        
        override protected function setData(param1:AwardWindowVO) : void
        {
            window.title = param1.windowTitle;
            this.backImage.source = param1.backImage;
            if(param1.hasAchievements)
            {
                this.medalsList.dataProvider = new DataProvider(param1.achievements);
                this.medalsList.visible = true;
                this.awardImage.visible = false;
            }
            else
            {
                this.awardImage.source = param1.awardImage;
                this.medalsList.visible = false;
                this.awardImage.visible = true;
            }
            this.headerTF.htmlText = param1.header;
            this.textArea.htmlText = param1.description;
            this.textArea.validateNow();
            this.textArea.position = 0;
            var _loc2_:Number = this.textArea.textField.textHeight;
            if(param1.additionalText.length > 0)
            {
                this.additionalTF.htmlText = param1.additionalText;
                this.additionalTF.visible = this.dashLine.visible = true;
                this.dashLine.y = this.textArea.y + _loc2_ + DASH_LINE_VERTICAL_OFFSET_BEFORE;
                this.additionalTF.y = this.dashLine.y + DASH_LINE_VERTICAL_OFFSET_AFTER;
            }
            else
            {
                this.additionalTF.visible = this.dashLine.visible = false;
            }
            this.okButton.label = param1.buttonText;
        }
        
        private function awardImageLoadedHandler(param1:UILoaderEvent) : void
        {
            this.awardImage.x = this.backImage.x + (this.backImage.width - this.awardImage.width) >> 1;
            this.awardImage.y = this.backImage.y + this.backImage.height - this.awardImage.height - AWARD_IMAGE_BOTTOM_OFFSET;
        }
        
        private function okButtonClickHandler(param1:ButtonEvent) : void
        {
            onOKClickS();
        }
    }
}
