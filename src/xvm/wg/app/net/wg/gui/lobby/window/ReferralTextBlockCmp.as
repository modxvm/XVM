package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.IReferralTextBlockCmp;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.data.VO.ReferralTextBlockVO;
    import flash.events.TextEvent;
    import flash.events.Event;
    
    public class ReferralTextBlockCmp extends UIComponentEx implements IReferralTextBlockCmp
    {
        
        public function ReferralTextBlockCmp()
        {
            super();
        }
        
        public static var LINK_BTN_CLICK:String = "linkButtonClick";
        
        private static var UPDATE_PADDINGS:String = "updatePaddings";
        
        private static var INVITES_MANAGEMENT:String = "invitesManagementURL";
        
        public var largeIcon:UILoaderAlt = null;
        
        public var titleTF:TextField = null;
        
        public var bodyTF:TextField = null;
        
        private var _paddingX:int = 0;
        
        private var _paddingY:int = 0;
        
        public function update(param1:Object) : void
        {
            var _loc2_:ReferralTextBlockVO = ReferralTextBlockVO(param1);
            this.updateIconPosition();
            this.largeIcon.source = _loc2_.iconSource;
            this.titleTF.htmlText = _loc2_.titleTF;
            this.bodyTF.htmlText = _loc2_.bodyTF;
            App.utils.styleSheetManager.setLinkStyle(this.bodyTF);
            if(_loc2_.showLinkBtn)
            {
                this.bodyTF.addEventListener(TextEvent.LINK,this.bodyTF_clickHandler);
            }
        }
        
        public function get paddingX() : int
        {
            return this._paddingX;
        }
        
        public function set paddingX(param1:int) : void
        {
            this._paddingX = param1;
            invalidate(UPDATE_PADDINGS);
        }
        
        public function get paddingY() : int
        {
            return this._paddingY;
        }
        
        public function set paddingY(param1:int) : void
        {
            this._paddingY = param1;
            invalidate(UPDATE_PADDINGS);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(UPDATE_PADDINGS))
            {
                this.updateIconPosition();
            }
        }
        
        override protected function onDispose() : void
        {
            this.bodyTF.removeEventListener(TextEvent.LINK,this.bodyTF_clickHandler);
            this.largeIcon.dispose();
            this.largeIcon = null;
            super.onDispose();
        }
        
        private function updateIconPosition() : void
        {
            this.largeIcon.x = this._paddingX;
            this.largeIcon.y = this._paddingY;
        }
        
        private function bodyTF_clickHandler(param1:TextEvent) : void
        {
            if(param1.text == INVITES_MANAGEMENT)
            {
                dispatchEvent(new Event(LINK_BTN_CLICK,true));
            }
        }
    }
}
