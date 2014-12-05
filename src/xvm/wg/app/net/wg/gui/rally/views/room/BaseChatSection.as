package net.wg.gui.rally.views.room
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.gui.rally.interfaces.IBaseChatSection;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import net.wg.gui.messenger.ChannelComponent;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.InputEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class BaseChatSection extends UIComponent implements IFocusContainer, IBaseChatSection
    {
        
        public function BaseChatSection()
        {
            super();
            this.channelComponent.externalButton = this.chatSubmitButton;
            this.channelComponent.messageArea.bgForm.visible = false;
        }
        
        protected static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var lblChatHeader:TextField;
        
        public var chatSubmitButton:IButtonIconLoader;
        
        public var channelComponent:ChannelComponent;
        
        protected var _rallyData:IRallyVO;
        
        protected var _inEditMode:Boolean = false;
        
        protected var _previousComment:String = "";
        
        protected function getHeader() : String
        {
            return "";
        }
        
        public function get rallyData() : IRallyVO
        {
            return this._rallyData;
        }
        
        public function set rallyData(param1:IRallyVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            this._rallyData = param1;
            invalidate(InvalidationType.DATA);
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.lblChatHeader.text = this.getHeader();
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            this.channelComponent.messageArea.bgForm.alpha = 0;
            this.channelComponent.messageArea.bgForm.visible = false;
            this.chatSubmitButton.tooltip = this.chatSubmitBtnTooltip;
            this.chatSubmitButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_ENTERWHITE;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(InputEvent.INPUT,this.handleInput,false);
            this.chatSubmitButton.dispose();
            this.chatSubmitButton = null;
            this.channelComponent = null;
            super.onDispose();
        }
        
        protected function updateFocus() : void
        {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.F1 && _loc2_.value == InputValue.KEY_UP)
            {
                param1.handled = true;
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.SHOW_FAQ_WINDOW));
            }
            super.handleInput(param1);
        }
        
        public function getChannelComponent() : ChannelComponent
        {
            return this.channelComponent;
        }
        
        public function setDescription(param1:String) : void
        {
        }
        
        public function get chatSubmitBtnTooltip() : String
        {
            return null;
        }
    }
}
