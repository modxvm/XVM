package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.AwardWindowMeta;
    import net.wg.infrastructure.base.meta.IAwardWindowMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.UILoaderEvent;
    import flash.display.InteractiveObject;
    import net.wg.data.VO.AwardWindowVO;
    
    public class AwardWindow extends AwardWindowMeta implements IAwardWindowMeta
    {
        
        public function AwardWindow()
        {
            super();
            isCentered = true;
            isModal = false;
        }
        
        private static var DASH_LINE_OFFSET:Number = 20;
        
        private static var AWARD_IMAGE_BOTTOM_OFFSET:Number = 40;
        
        public var backImage:UILoaderAlt;
        
        public var awardImage:UILoaderAlt;
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var additionalTF:TextField;
        
        public var dashLine:DashLine;
        
        public var okButton:SoundButtonEx;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.okButton.label = MENU.AWARDWINDOW_OKBUTTON;
            this.okButton.addEventListener(ButtonEvent.CLICK,this.okButtonClickHandler);
            this.awardImage.autoSize = false;
            this.awardImage.addEventListener(UILoaderEvent.COMPLETE,this.awardImageLoadedHandler);
            this.dashLine.x = DASH_LINE_OFFSET;
            this.dashLine.width = width - DASH_LINE_OFFSET * 2;
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
            this.headerTF = null;
            this.descriptionTF = null;
            this.additionalTF = null;
            super.onDispose();
        }
        
        override protected function setData(param1:AwardWindowVO) : void
        {
            window.title = param1.windowTitle;
            this.backImage.source = param1.backImage;
            this.awardImage.source = param1.awardImage;
            this.headerTF.htmlText = param1.header;
            this.descriptionTF.htmlText = param1.description;
            this.additionalTF.htmlText = param1.additionalText;
            this.dashLine.visible = this.additionalTF.text.length > 0;
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
