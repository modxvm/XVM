package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class MedalsList extends scaleform.clik.core.UIComponent
    {
        public function MedalsList()
        {
            super();
            this.renderers = [];
            this.stripes = [];
            this.stripesArea = new flash.display.MovieClip();
            addChild(this.stripesArea);
            this.contentArea = new flash.display.MovieClip();
            addChild(this.contentArea);
            return;
        }

        internal function drawLayout():void
        {
            var loc8:*=null;
            var loc1:*=this.renderers.length;
            var loc2:*=null;
            var loc3:*=Math.round(this.renderers[0].width);
            var loc4:*;
            if ((loc4 = (loc3 + this._gap) * loc1) > width) 
            {
                this._gap = Math.round((width - loc3 * loc1) / (loc1 - 1));
            }
            var loc5:*=Math.round(this._gap + loc3 + 2);
            var loc6:*=0;
            if (this._align != ALIGN_RIGHT) 
            {
                if (this._align == ALIGN_CENTER) 
                {
                    loc6 = Math.round((width - loc5 * loc1) / 2);
                }
            }
            else 
            {
                loc6 = Math.round(width - loc5);
            }
            var loc7:*=0;
            while (loc1 > loc7) 
            {
                loc2 = flash.display.MovieClip(this.renderers[loc7]);
                if (this._align == ALIGN_LEFT || this._align == ALIGN_CENTER) 
                {
                    loc2.x = Math.round(loc6 + Math.round(loc5 * loc7));
                }
                else if (this._align == ALIGN_RIGHT) 
                {
                    loc2.x = Math.round(loc6 - Math.round(loc5 * loc7));
                }
                loc2.y = Math.round((height - loc2.height) / 2);
                loc2.index = loc7;
                if (!(this._stripeRenderer == "") && loc2.data.isEpic) 
                {
                    if (loc8 = this.stripes[loc7]) 
                    {
                        loc8.x = loc2.x - Math.round((loc8.width - loc2.width) / 2);
                        loc8.y = loc2.y - Math.round((loc8.height - loc2.height) / 2);
                        loc8.visible = true;
                    }
                }
                loc2.visible = true;
                ++loc7;
            }
            return;
        }

        internal function createItemRenderer():scaleform.clik.interfaces.IListItemRenderer
        {
            var loc1:*=flash.utils.getDefinitionByName(this._itemRenderer) as Class;
            var loc2:*=new loc1() as scaleform.clik.interfaces.IListItemRenderer;
            if (loc2 == null) 
            {
                DebugUtils.LOG_DEBUG("Renderer class could not be created.");
                return null;
            }
            this.contentArea.addChild(loc2 as flash.display.DisplayObject);
            (loc2 as flash.display.DisplayObject).visible = false;
            loc2.focusTarget = this;
            this.setupRenderer(loc2);
            return loc2;
        }

        protected function setupRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = this;
            arg1.focusTarget = this;
            arg1.tabEnabled = false;
            arg1.doubleClickEnabled = true;
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleItemClick, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent, false, 0, true);
            if (arg1 is net.wg.gui.lobby.battleResults.CustomAchievement) 
            {
                net.wg.gui.lobby.battleResults.CustomAchievement(arg1).loader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete, false, 0, true);
            }
            return;
        }

        internal function onComplete(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            return;
        }

        protected function dispatchItemEvent(arg1:flash.events.Event):Boolean
        {
            var loc1:*=null;
            var loc7:*=null;
            var loc8:*=arg1.type;
            switch (loc8) 
            {
                case scaleform.clik.events.ButtonEvent.PRESS:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_PRESS;
                    break;
                }
                case scaleform.clik.events.ButtonEvent.CLICK:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_CLICK;
                    break;
                }
                case flash.events.MouseEvent.ROLL_OVER:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OVER;
                    break;
                }
                case flash.events.MouseEvent.ROLL_OUT:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OUT;
                    break;
                }
                case flash.events.MouseEvent.DOUBLE_CLICK:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_DOUBLE_CLICK;
                    break;
                }
                default:
                {
                    return true;
                }
            }
            var loc2:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc3:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc3 = (arg1 as scaleform.clik.events.ButtonEvent).controllerIdx;
            }
            else if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc3 = (arg1 as scaleform.gfx.MouseEventEx).mouseIdx;
            }
            var loc4:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc4 = (arg1 as scaleform.clik.events.ButtonEvent).buttonIdx;
            }
            else if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc4 = (arg1 as scaleform.gfx.MouseEventEx).buttonIdx;
            }
            var loc5:*=false;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc5 = (arg1 as scaleform.clik.events.ButtonEvent).isKeyboard;
            }
            var loc6:*=new scaleform.clik.events.ListEvent(loc1, false, true, loc2.index, 0, loc2.index, loc2, this.dataProvider[loc2.index], loc3, loc4, loc5);
            if (loc1 != scaleform.clik.events.ListEvent.ITEM_ROLL_OVER) 
            {
                if (loc1 == scaleform.clik.events.ListEvent.ITEM_ROLL_OUT) 
                {
                    this.hideTooltip();
                }
            }
            else if ((loc7 = this.dataProvider[loc2.index]).type != "markOfMastery") 
            {
                this.showToolTip(net.wg.data.constants.Tooltips.BATTLE_STATS_ACHIEVS, loc7);
            }
            else 
            {
                this.showToolTip(net.wg.data.constants.Tooltips.TANK_CLASS, loc7);
            }
            return dispatchEvent(loc6);
        }

        protected function showToolTip(arg1:String, arg2:Object):void
        {
            App.toolTipMgr.showSpecial(arg1, null, arg2.type, arg2.rank);
            return;
        }

        protected function hideTooltip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function handleItemClick(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target.index;
            if (isNaN(loc1)) 
            {
                return;
            }
            this.dispatchItemEvent(arg1);
            return;
        }

        internal function populateData(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=0;
            while (loc1 < this.renderers.length) 
            {
                loc2 = this.renderers[loc1];
                loc3 = arg1[loc1];
                loc2.setData(loc3);
                loc2.enabled = this.enabled;
                if (!(this._stripeRenderer == "") && loc3.isEpic) 
                {
                    loc5 = new (loc4 = flash.utils.getDefinitionByName(this._stripeRenderer) as Class)() as flash.display.MovieClip;
                    this.stripesArea.addChild(loc5);
                    if (loc5) 
                    {
                        this.stripes.push(loc5);
                        loc5.visible = false;
                    }
                }
                ++loc1;
            }
            return;
        }

        internal function onDataChange(arg1:flash.events.Event):void
        {
            invalidate();
            return;
        }

        protected override function initialize():void
        {
            this.dataProvider = new scaleform.clik.data.DataProvider();
            super.initialize();
            return;
        }

        public function invalidateFilters():void
        {
            invalidate(INVALIDATE_FILTERS);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public function updateFilters():void
        {
            var loc1:*=[];
            loc1 = loc1.concat([this._colorDodgeMulty, 0, 0, 0, 0]);
            loc1 = loc1.concat([0, this._colorDodgeMulty, 0, 0, 0]);
            loc1 = loc1.concat([0, 0, this._colorDodgeMulty, 0, 0]);
            loc1 = loc1.concat([0, 0, 0, 1, 0]);
            var loc2:*=new flash.filters.ColorMatrixFilter();
            loc2.matrix = loc1;
            var loc3:*=new flash.filters.DropShadowFilter(2, 90, 0, 0.75, 4, 4);
            this.contentArea.filters = [];
            this.contentArea.filters = [loc2, loc3];
            this.stripesArea.filters = [];
            this.stripesArea.filters = [new flash.filters.DropShadowFilter(2, 90, 0, 0.75, 4, 4)];
            return;
        }

        public function get dataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            if (this._dataProvider != null) 
            {
                this._dataProvider.removeEventListener(flash.events.Event.CHANGE, this.onDataChange, false);
            }
            this._dataProvider = arg1;
            if (this._dataProvider == null) 
            {
                return;
            }
            this._dataProvider.addEventListener(flash.events.Event.CHANGE, this.onDataChange, false, 0, true);
            invalidateData();
            return;
        }

        public function clear():void
        {
            while (this.renderers.length) 
            {
                this.renderers.pop().removeMovieClip();
            }
            while (this.stripes.length) 
            {
                this.stripes.pop().removeMovieClip();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            initSize();
            this.contentArea.height = height;
            this.contentArea.width = width;
            var loc1:*;
            this.contentArea.scaleY = loc1 = 1;
            this.contentArea.scaleX = loc1;
            this.stripesArea.height = height;
            this.stripesArea.width = width;
            this.stripesArea.scaleY = loc1 = 1;
            this.stripesArea.scaleX = loc1;
            invalidate(INVALIDATE_FILTERS);
            return;
        }

        protected override function draw():void
        {
            if (this._dataProvider) 
            {
                this.drawRenderers(this._dataProvider.length);
                if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                {
                    this._dataProvider.requestItemRange(0, (this._dataProvider.length - 1), this.populateData);
                }
                if (this.renderers.length) 
                {
                    this.drawLayout();
                }
            }
            if (isInvalid(INVALIDATE_FILTERS)) 
            {
                this.updateFilters();
            }
            return;
        }

        internal function drawRenderers(arg1:Number):void
        {
            while (this.renderers.length) 
            {
                this.contentArea.removeChild(this.renderers.pop());
            }
            while (this.stripes.length) 
            {
                this.stripesArea.removeChild(this.stripes.pop());
            }
            while (this.renderers.length < arg1) 
            {
                this.renderers.push(this.createItemRenderer());
            }
            return;
        }

        internal static const ALIGN_LEFT:String="left";

        internal static const ALIGN_RIGHT:String="right";

        internal static const ALIGN_CENTER:String="center";

        internal static const INVALIDATE_FILTERS:String="invFilt";

        public var _itemRenderer:String="";

        public var _stripeRenderer:String="";

        public var _align:String="left";

        public var _gap:Number=0;

        public var _colorDodgeMulty:Number=1.3;

        protected var _dataProvider:scaleform.clik.interfaces.IDataProvider;

        internal var renderers:Array;

        internal var stripes:Array;

        public var contentArea:flash.display.MovieClip;

        public var stripesArea:flash.display.MovieClip;
    }
}
