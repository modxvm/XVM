package net.wg.gui.lobby.messengerBar.carousel
{
    import scaleform.clik.controls.Button;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.data.components.ContextItem;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
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
        
        private static var MINIMIZE_ALL:String = "mA";
        
        private static var CLOSE_CURRENT:String = "clC";
        
        private static var CLOSE_ALL_EXCEPT_CURRENT:String = "clAdE";
        
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
                App.contextMenuMgr.show(Vector.<IContextItem>([new ContextItem(MINIMIZE_ALL,MENU.CONTEXTMENU_MESSENGER_MINIMIZEALL),new ContextItem(CLOSE_CURRENT,MENU.CONTEXTMENU_MESSENGER_CLOSECURRENT,{"enabled":_data.canClose}),new ContextItem(CLOSE_ALL_EXCEPT_CURRENT,MENU.CONTEXTMENU_MESSENGER_CLOSEALLEXCEPTCURRENT)]),this,this.onContextMenuItemSelect);
            }
        }
        
        private function onContextMenuItemSelect(param1:ContextMenuEvent) : void
        {
            switch(param1.id)
            {
                case MINIMIZE_ALL:
                    dispatchEvent(new ChannelListEvent(ChannelListEvent.MINIMIZE_ALL_CHANNELS,NaN,true));
                    break;
                case CLOSE_CURRENT:
                    onItemClose();
                    break;
                case CLOSE_ALL_EXCEPT_CURRENT:
                    dispatchEvent(new ChannelListEvent(ChannelListEvent.CLOSE_ALL_EXCEPT_CURRENT,_data.clientID,true));
                    break;
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
