package net.wg.gui.components.common.ticker
{
    import net.wg.infrastructure.base.meta.impl.TickerMeta;
    import net.wg.infrastructure.base.meta.ITickerMeta;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.events.MouseEvent;
    import flash.utils.setInterval;
    import flash.utils.clearInterval;
    import net.wg.gui.components.common.ticker.events.BattleTickerEvent;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class Ticker extends TickerMeta implements ITickerMeta
    {

        public static const ALIAS:String = "Ticker";

        private static const INVALID_ITEMS:String = "invalidItems";

        private static const ITEMS_GAP:Number = 100;

        private static const HIDE_SHOW_SPEED:Number = 500;

        private static const UPDATE_INTERVAL:Number = 50;

        public static const TICKER_Y_PADDING:int = 2;

        public var animationXSpeed:Number = 1;

        public var maskView:Sprite;

        public var container:Sprite;

        public var hit:Sprite;

        protected var _isBattle:Boolean = false;

        private var _showHideTween:Tween;

        private var _rssItems:Vector.<RSSEntryVO>;

        private var _renderers:Vector.<TickerItem>;

        private var _itemIndex:int = -1;

        private var _intervalID:int = -1;

        public function Ticker()
        {
            this._rssItems = new Vector.<RSSEntryVO>();
            this._renderers = new Vector.<TickerItem>();
            super();
            alpha = 0;
            visible = false;
        }

        override protected function onDispose() : void
        {
            this.pauseAnimation();
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            while(this._renderers.length)
            {
                this.removeRenderer();
            }
            this._rssItems = null;
            if(this._renderers)
            {
                this._renderers.splice(0,this._renderers.length);
            }
            this._renderers = null;
            this.hit.mask = null;
            this.hit = null;
            this.container.mask = null;
            this.container = null;
            this.maskView = null;
            if(this._showHideTween)
            {
                this._showHideTween.paused = true;
                this._showHideTween.dispose();
                this._showHideTween = null;
            }
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            hitArea = this.hit;
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_ITEMS) && this.hasItems)
            {
                this.startAnimation();
            }
        }

        override protected function setItems(param1:Vector.<RSSEntryVO>) : void
        {
            this._rssItems = param1;
            invalidate(INVALID_ITEMS);
        }

        private function startAnimation() : void
        {
            this.show();
            if(this._intervalID == -1)
            {
                this._intervalID = setInterval(this.animate,UPDATE_INTERVAL);
            }
        }

        private function pauseAnimation() : void
        {
            if(this._intervalID != -1)
            {
                clearInterval(this._intervalID);
                this._intervalID = -1;
            }
        }

        private function show() : void
        {
            visible = true;
            if(this._showHideTween)
            {
                this._showHideTween.paused = true;
                this._showHideTween.dispose();
                this._showHideTween = null;
            }
            this._showHideTween = new Tween(HIDE_SHOW_SPEED,this,{"alpha":1});
            if(this._isBattle)
            {
                dispatchEvent(new BattleTickerEvent(BattleTickerEvent.SHOW));
            }
        }

        private function hide() : void
        {
            if(this._showHideTween)
            {
                this._showHideTween.paused = true;
                this._showHideTween.dispose();
                this._showHideTween = null;
            }
            this._showHideTween = new Tween(HIDE_SHOW_SPEED,this,{"alpha":0.0},{"onComplete":this.onHideTweenComplete});
        }

        private function onHideTweenComplete() : void
        {
            visible = false;
            dispatchEvent(new BattleTickerEvent(BattleTickerEvent.HIDE));
        }

        private function animate() : void
        {
            var _loc1_:TickerItem = null;
            var _loc2_:TickerItem = null;
            var _loc3_:TickerItem = null;
            if(this._renderers.length > 0)
            {
                for each(_loc1_ in this._renderers)
                {
                    _loc1_.x = _loc1_.x - this.animationXSpeed;
                }
                _loc2_ = this._renderers[0];
                _loc3_ = this._renderers[this._renderers.length - 1];
                if(_loc2_.x + _loc2_.width < 0)
                {
                    this.removeRenderer();
                }
                if(_loc3_.x + _loc3_.width + ITEMS_GAP < this.maskView.width && this.hasItems)
                {
                    this.addRenderer();
                }
            }
            else if(this._rssItems.length > 0)
            {
                this.addRenderer();
            }
            else
            {
                this.pauseAnimation();
                this.hide();
            }
        }

        private function addRenderer() : void
        {
            this._itemIndex++;
            if(this._itemIndex >= this._rssItems.length)
            {
                this._itemIndex = 0;
            }
            var _loc1_:TickerItem = App.utils.classFactory.getComponent(Linkages.TICKER_ITEM,TickerItem);
            _loc1_.model = this._rssItems[this._itemIndex];
            _loc1_.x = this.maskView.width;
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
            if(!this._isBattle)
            {
                _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onItemMouseDownHandler);
            }
            this.container.addChild(_loc1_);
            this._renderers.push(_loc1_);
        }

        private function removeRenderer() : void
        {
            var _loc1_:TickerItem = this._renderers.shift();
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
            if(!this._isBattle)
            {
                _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onItemMouseDownHandler);
            }
            _loc1_.dispose();
            this.container.removeChild(_loc1_);
        }

        public function set isTickerVisible(param1:Boolean) : void
        {
            if(param1)
            {
                invalidate(INVALID_ITEMS);
            }
            else
            {
                this.hide();
            }
        }

        public function get hasItems() : Boolean
        {
            return this._rssItems && this._rssItems.length > 0;
        }

        public function get tickerHeight() : Number
        {
            return this.hit.height;
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this.startAnimation();
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            this.pauseAnimation();
        }

        private function onItemMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc3_:RSSEntryVO = null;
            var _loc2_:TickerItem = param1.currentTarget as TickerItem;
            if(_loc2_)
            {
                _loc3_ = _loc2_.model;
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.RSS_NEWS,null,_loc3_.title,_loc3_.summary);
            }
        }

        private function onItemMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onItemMouseDownHandler(param1:MouseEvent) : void
        {
            var _loc3_:RSSEntryVO = null;
            var _loc2_:TickerItem = param1.currentTarget as TickerItem;
            if(_loc2_)
            {
                _loc3_ = _loc2_.model;
                App.toolTipMgr.hide();
                showBrowserS(_loc3_.id);
            }
        }
    }
}
