package net.wg.gui.components.common.ticker
{
   import net.wg.infrastructure.base.meta.impl.TickerMeta;
   import net.wg.infrastructure.base.meta.ITickerMeta;
   import flash.display.Sprite;
   import scaleform.clik.motion.Tween;
   import flash.events.MouseEvent;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Tooltips;


   public class Ticker extends TickerMeta implements ITickerMeta
   {
          
      public function Ticker() {
         this._rssItems = [];
         this._renderers = [];
         super();
         alpha = 0;
         visible = false;
      }

      public static const STATE_HANGAR:String = "hangar";

      public static const STATE_BATTLE:String = "battle";

      private static const INVALID_ITEMS:String = "invalidItems";

      private static const ITEMS_GAP:Number = 100;

      private static const HIDE_SHOW_SPEED:Number = 500;

      private static const UPDATE_INTERVAL:Number = 50;

      public var animationXSpeed:Number = 1;

      public var maskView:Sprite;

      public var container:Sprite;

      public var hit:Sprite;

      private var _showHideTween:Tween;

      private var _rssItems:Array;

      private var _renderers:Array;

      private var _itemIndex:int = -1;

      private var _intervalID:int = -1;

      public function as_setItems(param1:Array) : void {
         this._rssItems = param1;
         invalidate(INVALID_ITEMS);
      }

      public function get hasItems() : Boolean {
         return (this._rssItems) && this._rssItems.length > 0;
      }

      override protected function onDispose() : void {
         super.onDispose();
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         while(this._renderers.length)
         {
            this.removeRenderer();
         }
         if(this._rssItems)
         {
            this._rssItems.splice(0,this._rssItems.length);
         }
         if(this._renderers)
         {
            this._renderers.splice(0,this._renderers.length);
         }
         this.hit.mask = null;
         this.hit = null;
         this.container.mask = null;
         this.container = null;
         this.maskView = null;
         if(this._showHideTween)
         {
            this._showHideTween.paused = true;
            this._showHideTween = null;
         }
      }

      override protected function configUI() : void {
         super.configUI();
         hitArea = this.hit;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(INVALID_ITEMS)) && (this.hasItems))
         {
            this.startAnimation();
         }
      }

      private function startAnimation() : void {
         this.show();
         if(this._intervalID == -1)
         {
            this._intervalID = setInterval(this.animate,UPDATE_INTERVAL);
         }
      }

      private function pauseAnimation() : void {
         if(this._intervalID != -1)
         {
            clearInterval(this._intervalID);
            this._intervalID = -1;
         }
      }

      private function show() : void {
         visible = true;
         if(this._showHideTween)
         {
            this._showHideTween.paused = true;
            this._showHideTween = null;
         }
         this._showHideTween = new Tween(HIDE_SHOW_SPEED,this,{"alpha":1});
      }

      private function hide() : void {
         if(this._showHideTween)
         {
            this._showHideTween.paused = true;
            this._showHideTween = null;
         }
         this._showHideTween = new Tween(HIDE_SHOW_SPEED,this,{"alpha":0.0},{"onComplete":this.onHideTweenComplete});
      }

      private function onHideTweenComplete() : void {
         visible = false;
      }

      private function animate() : void {
         var _loc1_:TickerItem = null;
         var _loc2_:TickerItem = null;
         var _loc3_:TickerItem = null;
         if(this._renderers.length > 0)
         {
            for each (_loc1_ in this._renderers)
            {
               _loc1_.x = _loc1_.x - this.animationXSpeed;
            }
            _loc2_ = this._renderers[0];
            _loc3_ = this._renderers[this._renderers.length-1];
            if(_loc2_.x + _loc2_.width < 0)
            {
               this.removeRenderer();
            }
            if(_loc3_.x + _loc3_.width + ITEMS_GAP < this.maskView.width && (this.hasItems))
            {
               this.addRenderer();
            }
         }
         else
         {
            if(this._rssItems.length > 0)
            {
               this.addRenderer();
            }
            else
            {
               this.pauseAnimation();
               this.hide();
            }
         }
      }

      private function addRenderer() : void {
         var _loc2_:TickerItem = null;
         this._itemIndex++;
         if(this._itemIndex >= this._rssItems.length)
         {
            this._itemIndex = 0;
         }
         var _loc1_:Object = this._rssItems[this._itemIndex];
         _loc2_ = App.utils.classFactory.getComponent(Linkages.TICKER_ITEM,TickerItem);
         _loc2_.model = new RSSEntryVO(_loc1_);
         _loc2_.x = this.maskView.width;
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseInteraction);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseInteraction);
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.onItemMouseInteraction);
         this.container.addChild(_loc2_);
         this._renderers.push(_loc2_);
      }

      private function removeRenderer() : void {
         var _loc1_:TickerItem = this._renderers.shift();
         _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseInteraction);
         _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseInteraction);
         _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onItemMouseInteraction);
         _loc1_.dispose();
         this.container.removeChild(_loc1_);
      }

      private function onMouseOut(param1:MouseEvent) : void {
         this.startAnimation();
      }

      private function onMouseOver(param1:MouseEvent) : void {
         this.pauseAnimation();
      }

      private function onItemMouseInteraction(param1:MouseEvent) : void {
         var _loc2_:Object = (param1.currentTarget as TickerItem).model;
         switch(param1.type)
         {
            case MouseEvent.MOUSE_OVER:
               App.toolTipMgr.showSpecial(Tooltips.RSS_NEWS,null,_loc2_.title,_loc2_.summary);
               break;
            case MouseEvent.MOUSE_OUT:
               App.toolTipMgr.hide();
               break;
            case MouseEvent.MOUSE_DOWN:
               App.toolTipMgr.hide();
               showBrowserS(_loc2_.id);
               break;
         }
      }
   }

}