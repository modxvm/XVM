package net.wg.gui.lobby.messengerBar
{
    import net.wg.infrastructure.base.meta.impl.MessengerBarMeta;
    import net.wg.infrastructure.base.meta.IMessengerBarMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import net.wg.utils.IHelpLayout;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.data.Aliases;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.Stage;
    import net.wg.gui.events.MessengerBarEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import flash.events.EventPhase;
    import net.wg.infrastructure.base.interfaces.IAbstractWindowView;
    
    public class MessengerBar extends MessengerBarMeta implements IMessengerBarMeta, IDAAPIModule, IHelpLayoutComponent
    {
        
        public function MessengerBar()
        {
            this.stageDimensions = new Point();
            super();
        }
        
        private static var LAYOUT_INVALID:String = "layoutInv";
        
        public var channelCarousel:ChannelCarousel;
        
        public var notificationListBtn:NotificationListButton;
        
        public var channelButton:MessengerIconButton;
        
        public var contactsListBtn:ContactsListButton;
        
        public var bg:MovieClip;
        
        private var stageDimensions:Point;
        
        private var _paddingLeft:uint = 0;
        
        private var _paddingRight:uint = 0;
        
        private var _paddingBottom:uint = 0;
        
        private var _paddingTop:uint = 0;
        
        private var _notificationListBtnHL:DisplayObject;
        
        private var _contactsChannelBtnHL:DisplayObject;
        
        private var _channelCarouselHL:DisplayObject;
        
        public var fakeChnlBtn:MovieClip;
        
        public function showHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Rectangle = new Rectangle(this.notificationListBtn.x,this.notificationListBtn.y,this.notificationListBtn.width,this.notificationListBtn.height);
            var _loc3_:Object = _loc1_.getProps(_loc2_,LOBBY_HELP.CHAT_SERVICE_CHANNEL,Directions.LEFT);
            this._notificationListBtnHL = _loc1_.create(root,_loc3_,this);
            var _loc4_:Rectangle = new Rectangle(this.contactsListBtn.x + 1,this.contactsListBtn.y,this.channelButton.x + this.channelButton.width - this.contactsListBtn.x - 2,this.contactsListBtn.height - 2);
            var _loc5_:Object = _loc1_.getProps(_loc4_,LOBBY_HELP.CHAT_CONTACTS_CHANNEL,Directions.LEFT);
            this._contactsChannelBtnHL = _loc1_.create(root,_loc5_,this);
            var _loc6_:Rectangle = new Rectangle(this.channelCarousel.x + 3,this.channelCarousel.y + 3,this.channelCarousel.width - 20,this.channelCarousel.height - 5);
            var _loc7_:Object = _loc1_.getProps(_loc6_,LOBBY_HELP.CHANNELCAROUSEL_CHANNELS,Directions.LEFT);
            this._channelCarouselHL = _loc1_.create(root,_loc7_,this);
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            _loc1_.destroy(this._notificationListBtnHL);
            _loc1_.destroy(this._contactsChannelBtnHL);
            _loc1_.destroy(this._channelCarouselHL);
        }
        
        public function updateStage(param1:Number, param2:Number) : void
        {
            this.stageDimensions.x = param1;
            this.stageDimensions.y = param2;
            invalidate(LAYOUT_INVALID);
        }
        
        public function as_setInitData(param1:Object) : void
        {
            this.channelButton.htmlIconStr = param1.channelsHtmlIcon;
            this.contactsListBtn.button.htmlIconStr = param1.contactsHtmlIcon;
        }
        
        public function get paddingLeft() : uint
        {
            return this._paddingLeft;
        }
        
        public function set paddingLeft(param1:uint) : void
        {
            this._paddingLeft = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        public function get paddingRight() : uint
        {
            return this._paddingRight;
        }
        
        public function set paddingRight(param1:uint) : void
        {
            this._paddingRight = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        public function get paddingBottom() : uint
        {
            return this._paddingBottom;
        }
        
        public function set paddingBottom(param1:uint) : void
        {
            this._paddingBottom = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        public function get paddingTop() : uint
        {
            return this._paddingTop;
        }
        
        public function set paddingTop(param1:uint) : void
        {
            this._paddingTop = param1;
            invalidate(LAYOUT_INVALID);
        }
        
        override protected function preInitialize() : void
        {
            super.preInitialize();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.notificationListBtn,Aliases.NOTIFICATION_LIST_BUTTON);
            registerFlashComponentS(this.contactsListBtn,Aliases.CONTACTS_LIST_BUTTON);
            registerFlashComponentS(this.channelCarousel,Aliases.CHANNEL_CAROUSEL);
            this.channelButton.addEventListener(ButtonEvent.CLICK,this.onChannelButtonClick);
            this.contactsListBtn.addEventListener(ButtonEvent.CLICK,this.onContactsButtonClick);
            var _loc1_:Stage = App.stage;
            _loc1_.addEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW,this.handlePinChannelsWindow);
            _loc1_.addEventListener(MessengerBarEvent.PIN_CONTACTS_WINDOW,this.handlePinContactsWindow);
        }
        
        override protected function onDispose() : void
        {
            this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OVER,this.showInRoamingTooltip);
            this.fakeChnlBtn.removeEventListener(MouseEvent.ROLL_OUT,this.hideInRoamingTooltip);
            this.fakeChnlBtn.removeEventListener(MouseEvent.CLICK,this.hideInRoamingTooltip);
            this.channelButton.removeEventListener(ButtonEvent.CLICK,this.onChannelButtonClick);
            this.contactsListBtn.removeEventListener(ButtonEvent.CLICK,this.onContactsButtonClick);
            var _loc1_:Stage = App.stage;
            _loc1_.removeEventListener(MessengerBarEvent.PIN_CHANNELS_WINDOW,this.handlePinChannelsWindow);
            _loc1_.removeEventListener(MessengerBarEvent.PIN_CONTACTS_WINDOW,this.handlePinContactsWindow);
            this.channelCarousel = null;
            this.notificationListBtn = null;
            this.channelButton.dispose();
            this.channelButton = null;
            this.contactsListBtn = null;
            this.stageDimensions = null;
            this._notificationListBtnHL = null;
            this._contactsChannelBtnHL = null;
            this._channelCarouselHL = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.notificationListBtn.name,this.notificationListBtn,Constraints.RIGHT);
            constraints.addElement(this.channelButton.name,this.channelButton,Constraints.LEFT);
            constraints.addElement(this.fakeChnlBtn.name,this.fakeChnlBtn,Constraints.LEFT);
            constraints.addElement(this.contactsListBtn.name,this.contactsListBtn,Constraints.LEFT);
            this.channelButton.enabled = !App.globalVarsMgr.isInRoamingS();
            this.channelButton.tooltip = TOOLTIPS.LOBY_MESSENGER_CHANNELS_BUTTON;
            this.fakeChnlBtn.visible = App.globalVarsMgr.isInRoamingS();
            this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OVER,this.showInRoamingTooltip);
            this.fakeChnlBtn.addEventListener(MouseEvent.ROLL_OUT,this.hideInRoamingTooltip);
            this.fakeChnlBtn.addEventListener(MouseEvent.CLICK,this.hideInRoamingTooltip);
            this.fakeChnlBtn.x = this.channelButton.x;
            this.fakeChnlBtn.width = this.channelButton.width;
            this.fakeChnlBtn.height = this.channelButton.height;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                y = this.stageDimensions.y - this.height - this.paddingBottom;
                x = this.paddingLeft;
                width = this.stageDimensions.x - this.paddingLeft - this.paddingRight;
                this.bg.x = -this.paddingLeft;
                this.bg.width = this.stageDimensions.x;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                constraints.update(_width,_height);
                this.channelCarousel.x = this.channelButton?this.channelButton.x + this.channelButton.width:this.channelButton?this.channelButton.x + this.channelButton.width:0;
                this.channelCarousel.width = this.notificationListBtn.x - this.channelCarousel.x - 1;
            }
        }
        
        private function handlePinWindow(param1:MessengerBarEvent, param2:DisplayObject) : void
        {
            var _loc4_:IManagedContent = null;
            var _loc5_:Point = null;
            if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
            {
                return;
            }
            var _loc3_:IAbstractWindowView = param1.target as IAbstractWindowView;
            if(_loc3_ != null)
            {
                _loc4_ = _loc3_.window;
                _loc5_ = localToGlobal(new Point(param2.x + WindowOffsetsInBar.WINDOW_LEFT_OFFSET,-_loc4_.height));
                _loc4_.x = _loc5_.x;
                _loc4_.y = _loc5_.y;
            }
        }
        
        private function onChannelButtonClick(param1:ButtonEvent) : void
        {
            channelButtonClickS();
        }
        
        private function onContactsButtonClick(param1:ButtonEvent) : void
        {
            contactsButtonClickS();
        }
        
        private function handlePinChannelsWindow(param1:MessengerBarEvent) : void
        {
            this.handlePinWindow(param1,this.channelButton);
        }
        
        private function handlePinContactsWindow(param1:MessengerBarEvent) : void
        {
            this.handlePinWindow(param1,this.contactsListBtn);
        }
        
        private function showInRoamingTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.LOBY_MESSENGER_CHANNEL_BUTTON_INROAMING);
        }
        
        private function hideInRoamingTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
