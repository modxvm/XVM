package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.data.managers.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.motion.*;
    import scaleform.clik.utils.*;
    
    public class ToolTipBase extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IToolTip
    {
        public function ToolTipBase()
        {
            this.contentMargin = new scaleform.clik.utils.Padding(12, 17, 12, 17);
            this.bgShadowMargin = new scaleform.clik.utils.Padding(3, 5, 7, 5);
            super();
            visible = false;
            alpha = 0;
            this.x = -1000;
            this.y = -1000;
            return;
        }

        internal function fadeIn():void
        {
            var loc1:*=App.appWidth;
            var loc2:*=App.appHeight;
            var loc3:*=this._props.x == 0 ? App.stage.mouseX : this._props.x;
            var loc4:*=this._props.y == 0 ? App.stage.mouseY : this._props.y;
            loc3 = loc3 + this.CURSOR_OFFSET;
            if ((loc4 = loc4 + this.CURSOR_OFFSET) + this.actualHeight > loc2) 
            {
                loc4 = loc4 - this.actualHeight - this.CURSOR_OFFSET * 2;
            }
            if (loc4 < 0) 
            {
                loc4 = this.BORDER_OFFSET;
            }
            if (loc3 + this.actualWidth > loc1) 
            {
                loc3 = loc3 - this.actualWidth - this.CURSOR_OFFSET * 2;
            }
            if (loc3 < 0) 
            {
                loc3 = this.BORDER_OFFSET;
            }
            this.x = loc3 | 0;
            this.y = loc4 | 0;
            this.visible = true;
            this.tryClearTween();
            this.tween = new scaleform.clik.motion.Tween(300, this, {"alpha":1}, {"paused":false, "onComplete":this.onTweenComplete, "ease":fl.transitions.easing.Strong.easeInOut});
            return;
        }

        internal function onTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.tryClearTween();
            return;
        }

        internal function tryClearTween():void
        {
            if (this.tween) 
            {
                this.tween.paused = true;
                this.tween = null;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.clearDelayIntervalID();
            this.tryClearTween();
            return;
        }

        internal function clearDelayIntervalID():void
        {
            if (this.showDelayIntervalID != 0) 
            {
                flash.utils.clearTimeout(this.showDelayIntervalID);
                this.showDelayIntervalID = 0;
            }
            return;
        }

        protected function updateSize():void
        {
            this.background.width = this.content.width + this.contentMargin.horizontal + this.bgShadowMargin.horizontal | 0;
            this.background.height = this.content.height + this.contentMargin.vertical + this.bgShadowMargin.vertical | 0;
            return;
        }

        public override function toString():String
        {
            return "[WG ToolTipBase " + name + "]";
        }

        
        {
            COMPONENT_SHOP = "shop";
            COMPONENT_INVENTORY = "inventory";
            COMPONENT_CAROUSEL = "carousel";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this._data && !this.isRedrawed) 
            {
                this.redraw();
            }
            return;
        }

        public function build(arg1:Object, arg2:net.wg.data.managers.ITooltipProps):void
        {
            this._type = arg1.type;
            this._component = arg1.component;
            this._data = arg1.data;
            this._props = arg2;
            this.topPosition = this.bgShadowMargin.top + this.contentMargin.top;
            this.leftPartMaxW = 0;
            if (this.stage && !this.isRedrawed) 
            {
                this.redraw();
            }
            return;
        }

        protected function redraw():void
        {
            this.isRedrawed = true;
            this.updateSize();
            this.clearDelayIntervalID();
            var loc1:*=this._props && !(this._props.drawDelay == -1) ? this._props.drawDelay : this.SHOW_DELAY;
            this.showDelayIntervalID = flash.utils.setTimeout(this.startShow, loc1, this);
            return;
        }

        internal function startShow(... rest):void
        {
            this.clearDelayIntervalID();
            this.fadeIn();
            return;
        }

        internal const CURSOR_OFFSET:Number=10;

        internal const BORDER_OFFSET:Number=15;

        internal const SHOW_DELAY:Number=400;

        protected var _data:Object=null;

        protected var _type:String="";

        protected var _component:String="";

        public var background:flash.display.Sprite=null;

        public var content:flash.display.MovieClip=null;

        protected var seaprators:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.Separator>=null;

        protected var contentMargin:scaleform.clik.utils.Padding;

        protected var bgShadowMargin:scaleform.clik.utils.Padding;

        internal var tween:scaleform.clik.motion.Tween=null;

        protected var headerList:Array=null;

        protected var centerList:Array=null;

        protected var leftList:__AS3__.vec.Vector.<flash.text.TextField>=null;

        protected var rightList:Array=null;

        protected var hasIconList:Array=null;

        protected var hasIcon:Boolean=false;

        protected var leftPartMaxW:Number=0;

        protected var res:Object=null;

        internal var showDelayIntervalID:Number=0;

        protected var topPosition:Number=0;

        protected var _props:net.wg.data.managers.ITooltipProps=null;

        public static var COMPONENT_SHOP:String="shop";

        public static var COMPONENT_INVENTORY:String="inventory";

        public static var COMPONENT_CAROUSEL:String="carousel";

        protected var isRedrawed:Boolean=false;
    }
}
