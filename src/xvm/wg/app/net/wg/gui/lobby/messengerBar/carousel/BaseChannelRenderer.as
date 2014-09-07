package net.wg.gui.lobby.messengerBar.carousel
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
    import scaleform.clik.data.ListData;
    
    public class BaseChannelRenderer extends UIComponent implements IListItemRenderer
    {
        
        public function BaseChannelRenderer()
        {
            super();
        }
        
        private static var prPadding:uint = 13;
        
        protected static function get DEFAULT_TF_PADDING() : Padding
        {
            return new Padding(3,5,3,5);
        }
        
        public var openButton:ChannelButton;
        
        protected var _data:ChannelListItemVO;
        
        public var progressIndicator:MovieClip;
        
        protected var _index:uint = 0;
        
        protected var _selectable:Boolean = true;
        
        protected var _owner:UIComponent = null;
        
        override protected function preInitialize() : void
        {
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.progressIndicator.mouseChildren = false;
            this.progressIndicator.mouseEnabled = false;
            this.progressIndicator.visible = false;
            addEventListener(MouseEvent.CLICK,this.handleMouseRelease);
            this.openButton.addEventListener(ButtonEvent.CLICK,this.onItemOpen,false,0,true);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.progressIndicator.x = _width - prPadding;
            }
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.applyData();
            }
        }
        
        protected function applyData() : void
        {
            this.openButton.label = this._data.label;
            this.openButton.blinking = this._data.isNotified;
            this.openButton.selected = this._data.isWindowOpened;
            this.openButton.selectedFocused = this._data.isWindowFocused;
            this.progressIndicator.visible = this._data.isInProgress;
            visible = true;
        }
        
        protected function handleMouseRelease(param1:MouseEvent) : void
        {
        }
        
        private function onItemOpen(param1:ButtonEvent = null) : void
        {
            dispatchEvent(new ChannelListEvent(ChannelListEvent.OPEN_CHANNEL,this._data.clientID,true));
        }
        
        protected function onItemClose(param1:ButtonEvent = null) : void
        {
            dispatchEvent(new ChannelListEvent(ChannelListEvent.CLOSE_CHANNEL,this._data.clientID,true));
        }
        
        public function get index() : uint
        {
            return this._index;
        }
        
        public function set index(param1:uint) : void
        {
            this._index = param1;
        }
        
        public function get owner() : UIComponent
        {
            return this._owner;
        }
        
        public function set owner(param1:UIComponent) : void
        {
            this._owner = param1;
        }
        
        public function get selectable() : Boolean
        {
            return this._selectable;
        }
        
        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
        }
        
        public function get selected() : Boolean
        {
            return this.openButton.selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            this.openButton.selected = param1;
        }
        
        public function setListData(param1:ListData) : void
        {
            this.index = param1.index;
            this.selected = param1.selected;
            this.openButton.label = param1.label || "";
        }
        
        public function setData(param1:Object) : void
        {
            if(param1)
            {
                this._data = new ChannelListItemVO(param1);
                invalidateData();
            }
        }
        
        public function getData() : Object
        {
            return this._data;
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.handleMouseRelease);
            this.openButton.removeEventListener(ButtonEvent.CLICK,this.onItemOpen);
            super.onDispose();
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
        }
    }
}
