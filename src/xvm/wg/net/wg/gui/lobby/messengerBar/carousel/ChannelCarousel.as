package net.wg.gui.lobby.messengerBar.carousel 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.lobby.messengerBar.carousel.data.*;
    import net.wg.gui.lobby.messengerBar.carousel.events.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.interfaces.*;
    
    public class ChannelCarousel extends net.wg.infrastructure.base.meta.impl.ChannelCarouselMeta implements net.wg.infrastructure.base.meta.IChannelCarouselMeta, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function ChannelCarousel()
        {
            super();
            this._dataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            return;
        }

        public function as_getDataProvider():Object
        {
            return this._dataProvider;
        }

        public function showHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            var loc2:*=this.list.getRendererAt(0) as flash.display.DisplayObject;
            var loc3:*=loc1.getProps(loc2.width, loc2.height, net.wg.data.constants.Directions.LEFT, LOBBY_HELP.CHAT_CHANNEL_CAROUSEL, loc2.x, loc2.y);
            this._commonChannelHL = loc1.create(root, loc3, this.list);
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._commonChannelHL);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this._dataProvider.addEventListener(flash.events.Event.CHANGE, this.onDataChange);
            this.scrollBar.upArrow.preventAutosizing = true;
            this.scrollBar.downArrow.preventAutosizing = true;
            this.list.addEventListener(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.OPEN_CHANNEL_CLICK, this.onChannelOpenClick);
            this.list.addEventListener(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.CLOSE_CHANNEL_CLICK, this.onChannelCloseClick);
            this.list.dataProvider = this._dataProvider;
            App.stage.addEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, this.handlePinChannelWindow);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.background.width = _width;
                this.updateScrollBar();
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this._dataProvider.removeEventListener(flash.events.Event.CHANGE, this.onDataChange);
            this.list.removeEventListener(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.OPEN_CHANNEL_CLICK, this.onChannelOpenClick);
            this.list.removeEventListener(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.CLOSE_CHANNEL_CLICK, this.onChannelCloseClick);
            App.stage.removeEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, this.handlePinChannelWindow);
            this._dataProvider.cleanUp();
            this._dataProvider = null;
            if (this.list.dataProvider) 
            {
                this.list.dataProvider.cleanUp();
                this.list.dataProvider = null;
            }
            return;
        }

        internal function updateScrollBar():void
        {
            var loc1:*=false;
            this.list.x = HORIZONTAL_OFFSET_NO_SCROLL;
            this.list.width = _width - HORIZONTAL_OFFSET_NO_SCROLL * 2;
            this.list.validateNow();
            loc1 = this.list.dataProvider ? this.list.columnCount < this.list.dataProvider.length : false;
            this.scrollBar.width = _width - this.scrollBar.x * 2;
            this.scrollBar.visible = loc1;
            if (loc1) 
            {
                this.list.x = HORIZONTAL_OFFSET_SCROLL;
                this.list.width = _width - HORIZONTAL_OFFSET_SCROLL * 2;
            }
            return;
        }

        internal function findIndexByClientID(arg1:Number):Number
        {
            var loc3:*=null;
            var loc1:*=-1;
            var loc2:*=this._dataProvider.length;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                if ((loc3 = new net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO(this._dataProvider.requestItemAt(loc4))).clientID == arg1) 
                {
                    loc1 = loc4;
                    break;
                }
                ++loc4;
            }
            return loc1;
        }

        internal function onDataChange(arg1:flash.events.Event):void
        {
            invalidateSize();
            return;
        }

        internal function onChannelOpenClick(arg1:net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent):void
        {
            channelOpenClickS(arg1.itemData.clientID);
            return;
        }

        internal function onChannelCloseClick(arg1:net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent):void
        {
            channelCloseClickS(arg1.itemData.clientID);
            return;
        }

        internal function handlePinChannelWindow(arg1:net.wg.gui.events.MessengerBarEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=0;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            var loc11:*=false;
            if (arg1.eventPhase != flash.events.EventPhase.BUBBLING_PHASE) 
                return;
            var loc1:*=this.findIndexByClientID(arg1.clientID);
            if (loc1 > -1) 
            {
                loc2 = this.list.getRendererAt(loc1 - this.list.scrollPosition);
                loc3 = arg1.target as net.wg.infrastructure.base.AbstractWindowView;
                if (loc2 == null && loc3) 
                {
                    this.updateWindowVisibleProperty(loc3, false);
                    this.list.scrollToIndex(loc1);
                    App.utils.scheduler.envokeInNextFrame(this.handlePinChannelWindow, arg1);
                    return;
                }
                if (loc3) 
                {
                    this.updateWindowVisibleProperty(loc3, true);
                    loc5 = (loc4 = loc3.window).width;
                    loc6 = App.appWidth - x;
                    loc7 = App.appHeight - height;
                    loc9 = (loc8 = loc2.x) + loc2.width - loc5;
                    loc10 = new flash.geom.Point(0, -loc4.height);
                    if (loc7 < loc4.height) 
                        loc10.y = this.height - App.appHeight - net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.WINDOW_TOP_OFFSET;
                    loc11 = this.list.columnCount < this._dataProvider.length;
                    if (loc8 + loc5 < loc6) 
                        loc10.x = loc11 ? Math.round(loc8 + this.scrollBar.upArrow.width + net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.WINDOW_LEFT_OFFSET) : loc8 - net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.CHANNEL_WINDOW_LEFT_OFFSET;
                    else if (loc9 > 0) 
                        loc10.x = loc11 ? Math.round(loc9 + this.scrollBar.upArrow.width + net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.WINDOW_RIGHT_OFFSET) : loc9 + net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.CHANNEL_WINDOW_RIGHT_OFFSET;
                    else 
                        loc10.x = loc6 - loc5 - x >> 1;
                    loc10 = localToGlobal(loc10);
                    loc4.x = Math.round(loc10.x);
                    loc4.y = Math.round(loc10.y);
                }
            }
            return;
        }

        internal function updateWindowVisibleProperty(arg1:net.wg.infrastructure.interfaces.IAbstractWindowView, arg2:Boolean=false):void
        {
            var loc1:*=net.wg.gui.components.windows.Window(arg1.window);
            if (loc1.visible != arg2) 
                loc1.visible = arg2;
            return;
        }

        internal static const HORIZONTAL_OFFSET_NO_SCROLL:Number=5;

        internal static const HORIZONTAL_OFFSET_SCROLL:Number=24;

        public var list:net.wg.gui.lobby.messengerBar.carousel.ChannelList;

        public var scrollBar:net.wg.gui.lobby.messengerBar.carousel.ChannelCarouselScrollBar;

        public var background:flash.display.Sprite;

        protected var _dataProvider:net.wg.data.daapi.base.DAAPIDataProvider;

        internal var _commonChannelHL:flash.display.DisplayObject;
    }
}
