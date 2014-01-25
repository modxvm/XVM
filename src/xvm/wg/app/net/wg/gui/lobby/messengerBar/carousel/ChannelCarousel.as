package net.wg.gui.lobby.messengerBar.carousel
{
   import net.wg.infrastructure.base.meta.impl.ChannelCarouselMeta;
   import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import flash.display.Sprite;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import flash.display.DisplayObject;
   import net.wg.utils.IHelpLayout;
   import net.wg.data.constants.Directions;
   import flash.events.Event;
   import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import scaleform.clik.interfaces.IListItemRenderer;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IWindow;
   import flash.geom.Point;
   import flash.events.EventPhase;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
   import net.wg.gui.components.windows.Window;


   public class ChannelCarousel extends ChannelCarouselMeta implements IChannelCarouselMeta, IHelpLayoutComponent
   {
          
      public function ChannelCarousel() {
         super();
         this._dataProvider = new DAAPIDataProvider();
      }

      private static const HORIZONTAL_OFFSET_NO_SCROLL:Number = 5;

      private static const HORIZONTAL_OFFSET_SCROLL:Number = 24;

      public var list:ChannelList;

      public var scrollBar:ChannelCarouselScrollBar;

      public var background:Sprite;

      protected var _dataProvider:DAAPIDataProvider;

      private var _commonChannelHL:DisplayObject;

      public function as_getDataProvider() : Object {
         return this._dataProvider;
      }

      public function showHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         var _loc2_:DisplayObject = this.list.getRendererAt(0) as DisplayObject;
         var _loc3_:Object = _loc1_.getProps(_loc2_.width,_loc2_.height,Directions.LEFT,LOBBY_HELP.CHAT_CHANNEL_CAROUSEL,_loc2_.x,_loc2_.y);
         this._commonChannelHL = _loc1_.create(root,_loc3_,this.list);
      }

      public function closeHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         _loc1_.destroy(this._commonChannelHL);
      }

      override protected function configUI() : void {
         super.configUI();
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataChange);
         this.scrollBar.upArrow.preventAutosizing = true;
         this.scrollBar.downArrow.preventAutosizing = true;
         this.list.addEventListener(ChannelListEvent.OPEN_CHANNEL_CLICK,this.onChannelOpenClick);
         this.list.addEventListener(ChannelListEvent.CLOSE_CHANNEL_CLICK,this.onChannelCloseClick);
         this.list.dataProvider = this._dataProvider;
         App.stage.addEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.handlePinChannelWindow);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = _width;
            this.updateScrollBar();
         }
      }

      override protected function onDispose() : void {
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataChange);
         this.list.removeEventListener(ChannelListEvent.OPEN_CHANNEL_CLICK,this.onChannelOpenClick);
         this.list.removeEventListener(ChannelListEvent.CLOSE_CHANNEL_CLICK,this.onChannelCloseClick);
         App.stage.removeEventListener(MessengerBarEvent.PIN_CAROUSEL_WINDOW,this.handlePinChannelWindow);
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
         this._commonChannelHL = null;
         super.onDispose();
      }

      private function updateScrollBar() : void {
         var _loc1_:* = false;
         this.list.x = HORIZONTAL_OFFSET_NO_SCROLL;
         this.list.width = _width - HORIZONTAL_OFFSET_NO_SCROLL * 2;
         this.list.validateNow();
         _loc1_ = this.list.dataProvider?this.list.columnCount < this.list.dataProvider.length:false;
         this.scrollBar.width = _width - this.scrollBar.x * 2;
         this.scrollBar.visible = _loc1_;
         if(_loc1_)
         {
            this.list.x = HORIZONTAL_OFFSET_SCROLL;
            this.list.width = _width - HORIZONTAL_OFFSET_SCROLL * 2;
         }
      }

      private function findIndexByClientID(param1:Number) : Number {
         var _loc4_:ChannelListItemVO = null;
         var _loc2_:Number = -1;
         var _loc3_:Number = this._dataProvider.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new ChannelListItemVO(this._dataProvider.requestItemAt(_loc5_));
            if(_loc4_.clientID == param1)
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }

      private function onDataChange(param1:Event) : void {
         invalidateSize();
      }

      private function onChannelOpenClick(param1:ChannelListEvent) : void {
         channelOpenClickS(param1.itemData.clientID);
      }

      private function onChannelCloseClick(param1:ChannelListEvent) : void {
         channelCloseClickS(param1.itemData.clientID);
      }

      private function handlePinChannelWindow(param1:MessengerBarEvent) : void {
         var _loc3_:IListItemRenderer = null;
         var _loc4_:IAbstractWindowView = null;
         var _loc5_:IWindow = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:Point = null;
         var _loc12_:* = false;
         if(param1.eventPhase != EventPhase.BUBBLING_PHASE)
         {
            return;
         }
         var _loc2_:Number = this.findIndexByClientID(param1.clientID);
         if(_loc2_ > -1)
         {
            _loc3_ = this.list.getRendererAt(_loc2_ - this.list.scrollPosition);
            _loc4_ = param1.target as AbstractWindowView;
            if(_loc3_ == null && (_loc4_))
            {
               this.updateWindowVisibleProperty(_loc4_,false);
               this.list.scrollToIndex(_loc2_);
               App.utils.scheduler.envokeInNextFrame(this.handlePinChannelWindow,param1);
               return;
            }
            if(_loc4_)
            {
               this.updateWindowVisibleProperty(_loc4_,true);
               _loc5_ = IWindow(_loc4_.window);
               _loc6_ = _loc5_.width;
               _loc7_ = App.appWidth - x;
               _loc8_ = App.appHeight - height;
               _loc9_ = _loc3_.x;
               _loc10_ = _loc9_ + _loc3_.width - _loc6_;
               _loc11_ = new Point(0,-_loc5_.height);
               if(_loc8_ < _loc5_.height)
               {
                  _loc11_.y = this.height - App.appHeight - WindowOffsetsInBar.WINDOW_TOP_OFFSET;
               }
               _loc12_ = this.list.columnCount < this._dataProvider.length;
               if(_loc9_ + _loc6_ < _loc7_)
               {
                  _loc11_.x = _loc12_?Math.round(_loc9_ + this.scrollBar.upArrow.width + WindowOffsetsInBar.WINDOW_LEFT_OFFSET):_loc9_ - WindowOffsetsInBar.CHANNEL_WINDOW_LEFT_OFFSET;
               }
               else
               {
                  if(_loc10_ > 0)
                  {
                     _loc11_.x = _loc12_?Math.round(_loc10_ + this.scrollBar.upArrow.width + WindowOffsetsInBar.WINDOW_RIGHT_OFFSET):_loc10_ + WindowOffsetsInBar.CHANNEL_WINDOW_RIGHT_OFFSET;
                  }
                  else
                  {
                     _loc11_.x = _loc7_ - _loc6_ - x >> 1;
                  }
               }
               _loc11_ = localToGlobal(_loc11_);
               _loc5_.x = Math.round(_loc11_.x);
               _loc5_.y = Math.round(_loc11_.y);
            }
         }
      }

      private function updateWindowVisibleProperty(param1:IAbstractWindowView, param2:Boolean=false) : void {
         var _loc3_:Window = Window(param1.window);
         if(_loc3_.visible != param2)
         {
            _loc3_.visible = param2;
         }
      }
   }

}