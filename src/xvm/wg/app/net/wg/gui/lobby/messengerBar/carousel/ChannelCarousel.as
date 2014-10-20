package net.wg.gui.lobby.messengerBar.carousel
{
    import net.wg.infrastructure.base.meta.impl.ChannelCarouselMeta;
    import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
    import net.wg.infrastructure.base.interfaces.IAbstractWindowView;
    import net.wg.gui.components.windows.Window;
    import net.wg.gui.components.common.containers.GroupEx;
    import flash.display.Sprite;
    import net.wg.gui.components.common.containers.HorizontalGroupLayout;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
    import flash.events.Event;
    import net.wg.gui.events.MessengerBarEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.events.EventPhase;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.infrastructure.base.AbstractWindowView;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import flash.geom.Point;
    import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
    
    public class ChannelCarousel extends ChannelCarouselMeta implements IChannelCarouselMeta
    {
        
        public function ChannelCarousel()
        {
            super();
            this._dataProvider = new DAAPIDataProvider();
            this._battlesDataProvider = new DAAPIDataProvider();
        }
        
        private static var HORIZONTAL_OFFSET_NO_SCROLL:Number = 5;
        
        private static var HORIZONTAL_OFFSET_SCROLL:Number = 24;
        
        private static var OFFSET_BETWEEN_LISTS:Number = 5;
        
        private static function findIndexByClientID(param1:Number, param2:DAAPIDataProvider) : int
        {
            var _loc5_:ChannelListItemVO = null;
            var _loc3_:Number = -1;
            var _loc4_:Number = param2.length;
            var _loc6_:Number = 0;
            while(_loc6_ < _loc4_)
            {
                _loc5_ = new ChannelListItemVO(param2.requestItemAt(_loc6_));
                if(_loc5_.clientID == param1)
                {
                    _loc3_ = _loc6_;
                    break;
                }
                _loc6_++;
            }
            return _loc3_;
        }
        
        private static function updateWindowVisibleProperty(param1:IAbstractWindowView, param2:Boolean = false) : void
        {
            var _loc3_:Window = Window(param1.window);
            if(_loc3_.visible != param2)
            {
                _loc3_.visible = param2;
            }
        }
        
        public var list:ChannelList;
        
        private var preBattlesGroup:GroupEx;
        
        public var scrollBar:ChannelCarouselScrollBar;
        
        public var background:Sprite;
        
        protected var _dataProvider:DAAPIDataProvider;
        
        protected var _battlesDataProvider:DAAPIDataProvider;
        
        override protected function configUI() : void
        {
            this.preBattlesGroup = new GroupEx();
            this.preBattlesGroup.layout = new HorizontalGroupLayout();
            this.preBattlesGroup.itemRendererClass = App.utils.classFactory.getClass(Linkages.PRE_BATTLE_CHANNEL_RENDERER);
            this.preBattlesGroup.y = this.list.y + this.list.padding.top;
            this.preBattlesGroup.x = 5;
            addChild(this.preBattlesGroup);
            super.configUI();
            this.scrollBar.upArrow.preventAutosizing = true;
            this.scrollBar.downArrow.preventAutosizing = true;
            addEventListener(ChannelListEvent.OPEN_CHANNEL,this.onChannelOpenClick,false,0,true);
            addEventListener(ChannelListEvent.CLOSE_CHANNEL,this.onChannelCloseClick,false,0,true);
            addEventListener(ChannelListEvent.MINIMIZE_ALL_CHANNELS,this.onChannelMinimize,false,0,true);
            addEventListener(ChannelListEvent.CLOSE_ALL_EXCEPT_CURRENT,this.onCloseAllExceptCurrent,false,0,true);
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataChange);
            this.preBattlesGroup.addEventListener(Event.RESIZE,this.preBattleGroupResizeHandler,false,0,true);
            this.list.dataProvider = this._dataProvider;
            this.preBattlesGroup.dataProvider = this._battlesDataProvider;
            App.stage.addEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.handlePinChannelWindow);
        }
        
        public function as_getDataProvider() : Object
        {
            return this._dataProvider;
        }
        
        public function as_getBattlesDataProvider() : Object
        {
            return this._battlesDataProvider;
        }
        
        override protected function draw() : void
        {
            var _loc1_:uint = 0;
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            var _loc4_:* = NaN;
            var _loc5_:* = false;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = this.preBattlesGroup.width;
                _loc2_ = this.preBattlesGroup.x;
                _loc3_ = _loc1_ > 0?OFFSET_BETWEEN_LISTS:0;
                _loc4_ = _width - _loc1_;
                _loc5_ = this.isScrollNeeded(_loc4_ - HORIZONTAL_OFFSET_NO_SCROLL * 2);
                this.scrollBar.visible = _loc5_;
                if(_loc5_)
                {
                    _loc6_ = _loc1_ + HORIZONTAL_OFFSET_SCROLL;
                    _loc7_ = _loc4_ - HORIZONTAL_OFFSET_SCROLL * 2;
                }
                else
                {
                    _loc6_ = _loc1_ + HORIZONTAL_OFFSET_NO_SCROLL;
                    _loc7_ = _loc4_ - HORIZONTAL_OFFSET_NO_SCROLL * 2;
                }
                this.list.x = _loc6_ + _loc3_;
                this.list.width = _loc7_ - _loc3_;
                this.scrollBar.width = _loc4_ - 2 * _loc2_ - _loc3_;
                this.scrollBar.x = _loc2_ + _loc1_ + _loc3_;
                this.background.width = this.scrollBar.width + HORIZONTAL_OFFSET_NO_SCROLL * 2;
                this.background.x = this.scrollBar.x - HORIZONTAL_OFFSET_NO_SCROLL;
            }
        }
        
        private function isScrollNeeded(param1:int) : Boolean
        {
            var _loc2_:IDataProvider = this.list.dataProvider;
            var _loc3_:uint = _loc2_?_loc2_.length:0;
            var _loc4_:int = FlexibleTileList.getAvailableItemWidth(_loc3_,this.list.minRendererWidth,this.list.maxRendererWidth,param1 - HORIZONTAL_OFFSET_NO_SCROLL * 2);
            var _loc5_:Number = param1 / _loc4_ >> 0;
            return _loc5_ < _loc3_;
        }
        
        private function preBattleGroupResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }
        
        override protected function onDispose() : void
        {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataChange);
            this.preBattlesGroup.removeEventListener(Event.RESIZE,this.preBattleGroupResizeHandler,false);
            removeEventListener(ChannelListEvent.OPEN_CHANNEL,this.onChannelOpenClick);
            removeEventListener(ChannelListEvent.CLOSE_CHANNEL,this.onChannelCloseClick);
            removeEventListener(ChannelListEvent.MINIMIZE_ALL_CHANNELS,this.onChannelMinimize);
            removeEventListener(ChannelListEvent.CLOSE_ALL_EXCEPT_CURRENT,this.onCloseAllExceptCurrent);
            App.stage.removeEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.handlePinChannelWindow);
            this._battlesDataProvider.cleanUp();
            this._battlesDataProvider = null;
            this._dataProvider.cleanUp();
            this._dataProvider = null;
            if(this.list.dataProvider)
            {
                this.list.dataProvider.cleanUp();
                this.list.dataProvider = null;
            }
            this.list.dispose();
            this.list = null;
            this.scrollBar = null;
            this.background = null;
            super.onDispose();
        }
        
        private function onDataChange(param1:Event) : void
        {
            invalidateSize();
        }
        
        private function onChannelOpenClick(param1:ChannelListEvent) : void
        {
            param1.stopImmediatePropagation();
            channelOpenClickS(param1.clientID);
        }
        
        private function onChannelCloseClick(param1:ChannelListEvent) : void
        {
            param1.stopImmediatePropagation();
            channelCloseClickS(param1.clientID);
        }
        
        private function onChannelMinimize(param1:ChannelListEvent) : void
        {
            param1.stopImmediatePropagation();
            minimizeAllChannelsS();
        }
        
        private function onCloseAllExceptCurrent(param1:ChannelListEvent) : void
        {
            param1.stopImmediatePropagation();
            closeAllExceptCurrentS(param1.clientID);
        }
        
        private function handlePinChannelWindow(param1:MessengerBarEvent) : void
        {
            if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
            {
                return;
            }
            var _loc2_:Number = -1;
            if(_loc2_ > -1)
            {
                this.setPreBattlesGroupItemCoordinates(_loc2_,param1);
            }
            else
            {
                _loc2_ = findIndexByClientID(param1.clientID,this._dataProvider);
                this.setChannelsListItemCoordinates(_loc2_,param1);
            }
        }
        
        private function setPreBattlesGroupItemCoordinates(param1:int, param2:MessengerBarEvent) : void
        {
            var _loc3_:IAbstractWindowView = IAbstractWindowView(param2.target);
            if(param1 < this.preBattlesGroup.numChildren)
            {
                updateWindowVisibleProperty(_loc3_,true);
                this.applyWindowPosition(_loc3_,this.preBattlesGroup.getChildAt(param1));
            }
            else
            {
                updateWindowVisibleProperty(_loc3_,false);
                App.utils.scheduler.envokeInNextFrame(this.handlePinChannelWindow,param2);
            }
        }
        
        private function setChannelsListItemCoordinates(param1:int, param2:MessengerBarEvent) : void
        {
            var _loc3_:IListItemRenderer = null;
            var _loc4_:IAbstractWindowView = null;
            if(param1 > -1)
            {
                _loc3_ = this.list.getRendererAt(param1 - this.list.scrollPosition);
                _loc4_ = param2.target as AbstractWindowView;
                if(_loc3_ == null && (_loc4_))
                {
                    updateWindowVisibleProperty(_loc4_,false);
                    this.list.scrollToIndex(param1);
                    App.utils.scheduler.envokeInNextFrame(this.handlePinChannelWindow,param2);
                }
                else if(_loc4_)
                {
                    updateWindowVisibleProperty(_loc4_,true);
                    this.applyWindowPosition(_loc4_,DisplayObject(_loc3_));
                }
                
            }
        }
        
        private function applyWindowPosition(param1:IAbstractWindowView, param2:DisplayObject) : void
        {
            var _loc3_:IWindow = IWindow(param1.window);
            var _loc4_:Number = _loc3_.width;
            var _loc5_:uint = App.appHeight - height;
            var _loc6_:Point = new Point(0,-_loc3_.height);
            if(_loc5_ < _loc3_.height)
            {
                _loc6_.y = this.height - App.appHeight - WindowOffsetsInBar.WINDOW_TOP_OFFSET;
            }
            var _loc7_:Number = param2.parent.localToGlobal(new Point(param2.x,param2.y)).x;
            var _loc8_:Number = _loc7_ + param2.width - _loc4_;
            if(_loc7_ + _loc4_ < App.appWidth)
            {
                _loc6_.x = _loc7_ - WindowOffsetsInBar.CHANNEL_WINDOW_LEFT_OFFSET;
            }
            else if(_loc8_ > 0)
            {
                _loc6_.x = _loc8_ + WindowOffsetsInBar.CHANNEL_WINDOW_RIGHT_OFFSET;
            }
            else
            {
                _loc6_.x = App.appWidth - _loc4_ >> 1;
            }
            
            _loc3_.x = Math.round(_loc6_.x);
            _loc3_.y = localToGlobal(_loc6_).y;
        }
    }
}
