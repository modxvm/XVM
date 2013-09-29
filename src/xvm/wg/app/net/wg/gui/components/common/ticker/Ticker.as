package net.wg.gui.components.common.ticker 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.motion.*;
    
    public class Ticker extends net.wg.infrastructure.base.meta.impl.TickerMeta implements net.wg.infrastructure.base.meta.ITickerMeta
    {
        public function Ticker()
        {
            this._rssItems = [];
            this._renderers = [];
            super();
            alpha = 0;
            visible = false;
            return;
        }

        public function as_setItems(arg1:Array):void
        {
            this._rssItems = arg1;
            invalidate(INVALID_ITEMS);
            return;
        }

        public function get hasItems():Boolean
        {
            return this._rssItems && this._rssItems.length > 0;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            while (this._renderers.length) 
            {
                this.removeRenderer();
            }
            this._showHideTween = null;
            if (this._rssItems) 
            {
                this._rssItems.splice(0, this._rssItems.length);
            }
            if (this._renderers) 
            {
                this._renderers.splice(0, this._renderers.length);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            hitArea = this.hit;
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_ITEMS) && this.hasItems) 
            {
                this.startAnimation();
            }
            return;
        }

        internal function startAnimation():void
        {
            this.show();
            if (this._intervalID == -1) 
            {
                this._intervalID = flash.utils.setInterval(this.animate, UPDATE_INTERVAL);
            }
            return;
        }

        internal function pauseAnimation():void
        {
            if (this._intervalID != -1) 
            {
                flash.utils.clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            return;
        }

        internal function show():void
        {
            visible = true;
            this._showHideTween = new scaleform.clik.motion.Tween(HIDE_SHOW_SPEED, this, {"alpha":1});
            return;
        }

        internal function hide():void
        {
            this._showHideTween = new scaleform.clik.motion.Tween(HIDE_SHOW_SPEED, this, {"alpha":0}, {"onComplete":this.onHideTweenComplete});
            return;
        }

        internal function onHideTweenComplete():void
        {
            visible = false;
            return;
        }

        internal function animate():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._renderers.length > 0) 
            {
                var loc4:*=0;
                var loc5:*=this._renderers;
                for each (loc1 in loc5) 
                {
                    loc1.x = loc1.x - this.animationXSpeed;
                }
                loc2 = this._renderers[0];
                loc3 = this._renderers[(this._renderers.length - 1)];
                if (loc2.x + loc2.width < 0) 
                {
                    this.removeRenderer();
                }
                if (loc3.x + loc3.width + ITEMS_GAP < this.maskView.width && this.hasItems) 
                {
                    this.addRenderer();
                }
            }
            else if (this._rssItems.length > 0) 
            {
                this.addRenderer();
            }
            else 
            {
                this.pauseAnimation();
                this.hide();
            }
            return;
        }

        internal function addRenderer():void
        {
            var loc3:*;
            var loc4:*=((loc3 = this)._itemIndex + 1);
            loc3._itemIndex = loc4;
            if (this._itemIndex >= this._rssItems.length) 
            {
                this._itemIndex = 0;
            }
            var loc1:*=this._rssItems[this._itemIndex];
            var loc2:*=App.utils.classFactory.getComponent(net.wg.data.constants.Linkages.TICKER_ITEM, net.wg.gui.components.common.ticker.TickerItem);
            loc2.model = new net.wg.gui.components.common.ticker.RSSEntryVO(loc1);
            loc2.x = this.maskView.width;
            loc2.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onItemMouseInteraction);
            loc2.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onItemMouseInteraction);
            loc2.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onItemMouseInteraction);
            this.container.addChild(loc2);
            this._renderers.push(loc2);
            return;
        }

        internal function removeRenderer():void
        {
            var loc1:*=this._renderers.shift();
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onItemMouseInteraction);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onItemMouseInteraction);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onItemMouseInteraction);
            loc1.dispose();
            this.container.removeChild(loc1);
            return;
        }

        internal function onMouseOut(arg1:flash.events.MouseEvent):void
        {
            this.startAnimation();
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):void
        {
            this.pauseAnimation();
            return;
        }

        internal function onItemMouseInteraction(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=(arg1.currentTarget as net.wg.gui.components.common.ticker.TickerItem).model;
            var loc2:*=arg1.type;
            switch (loc2) 
            {
                case flash.events.MouseEvent.MOUSE_OVER:
                {
                    App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.RSS_NEWS, null, loc1.title, loc1.summary);
                    break;
                }
                case flash.events.MouseEvent.MOUSE_OUT:
                {
                    App.toolTipMgr.hide();
                    break;
                }
                case flash.events.MouseEvent.MOUSE_DOWN:
                {
                    App.toolTipMgr.hide();
                    showBrowserS(loc1.id);
                    break;
                }
            }
            return;
        }

        public static const STATE_HANGAR:String="hangar";

        public static const STATE_BATTLE:String="battle";

        internal static const INVALID_ITEMS:String="invalidItems";

        internal static const ITEMS_GAP:Number=100;

        internal static const HIDE_SHOW_SPEED:Number=500;

        internal static const UPDATE_INTERVAL:Number=50;

        public var animationXSpeed:Number=1;

        public var maskView:flash.display.Sprite;

        public var container:flash.display.Sprite;

        public var hit:flash.display.Sprite;

        internal var _showHideTween:scaleform.clik.motion.Tween;

        internal var _rssItems:Array;

        internal var _renderers:Array;

        internal var _itemIndex:int=-1;

        internal var _intervalID:int=-1;
    }
}
