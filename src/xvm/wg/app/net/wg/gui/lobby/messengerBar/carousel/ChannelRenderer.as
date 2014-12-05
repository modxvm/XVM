package net.wg.gui.lobby.messengerBar.carousel
{
    import scaleform.clik.controls.Button;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.utils.Padding;
    
    public class ChannelRenderer extends BaseChannelRenderer
    {
        
        public function ChannelRenderer()
        {
            super();
            visible = false;
        }
        
        private static var closeBtnPadding:uint = 23;
        
        public var closeButton:Button;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.closeButton.addEventListener(ButtonEvent.CLICK,onItemClose,false,0,true);
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            super.handleMouseRelease(param1);
            if(param1 is MouseEventEx && (App.utils.commons.isRightButton(param1)))
            {
                App.contextMenuMgr.showNew(String(_data.clientID),CONTEXT_MENU_HANDLER_TYPE.CHANNEL_LIST,this,{"canCloseCurrent":_data.canClose});
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                openButton.width = _width;
                this.closeButton.x = _width - closeBtnPadding;
            }
            visible = !(_data == null);
        }
        
        override protected function applyData() : void
        {
            var _loc1_:* = false;
            super.applyData();
            openButton.iconSource = _data.icon;
            _loc1_ = _data.canClose;
            this.closeButton.visible = _loc1_;
            var _loc2_:Padding = DEFAULT_TF_PADDING;
            _loc2_.right = 23;
            openButton.textFieldPadding = (_loc1_) || (_data.isInProgress)?_loc2_:DEFAULT_TF_PADDING;
        }
        
        override protected function onDispose() : void
        {
            this.closeButton.removeEventListener(ButtonEvent.CLICK,onItemClose);
            super.onDispose();
        }
    }
}
