package net.wg.gui.lobby.settings.components 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.settings.components.evnts.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class KeysScrollingList extends net.wg.gui.components.controls.ScrollingListPx
    {
        public function KeysScrollingList()
        {
            super();
            scrollPosition = 0;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
            {
                createScrollBar();
                invalidate(SCROLL_POSITION_INV);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE, SCROLL_POSITION_INV)) 
            {
                drawScrollBar();
                (loc5 = maskObject.graphics).beginFill(0, 1);
                loc5.drawRect(0, 0, _width, _height);
                loc5.endFill();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.DATA) && _renderers == null) 
            {
                _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
                if (_dataProvider) 
                    this.drawRenderers(_dataProvider.length);
            }
            if (isInvalid(SCROLL_UPDATE_INV)) 
                applyScrollBarUpdating();
            return;
        }

        public function updateDataProvider():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            if (_dataProvider && _renderers) 
            {
                loc1 = _renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = getRendererAt(loc2);
                    loc4 = _dataProvider[loc2];
                    loc3.setListData(new scaleform.clik.data.ListData(loc2, itemToLabel(loc4), false));
                    loc3.setData(loc4);
                    ++loc2;
                }
            }
            return;
        }

        protected override function createRendererByDataIndex(arg1:int):void
        {
            var loc1:*=this.createRenderer(arg1);
            if (loc1 == null) 
                return;
            container.addChild(loc1 as flash.display.DisplayObject);
            _renderers.push(loc1);
            var loc2:*=_dataProvider[arg1];
            loc1.setListData(new scaleform.clik.data.ListData(arg1, itemToLabel(loc2), false));
            loc1.setData(loc2);
            loc1.owner = this;
            loc1.validateNow();
            totalHeight = totalHeight + loc2.rendererYOffset;
            loc1.y = totalHeight;
            totalHeight = totalHeight + Math.round(loc1.height);
            return;
        }

        protected override function createRenderer(arg1:uint):scaleform.clik.interfaces.IListItemRenderer
        {
            var loc1:*=super.createRenderer(arg1);
            if (loc1 != null) 
            {
                this.setupRenderer(loc1);
                return loc1;
            }
            return null;
        }

        protected override function drawRenderers(arg1:Number):void
        {
            if (_itemRenderer == null) 
            {
                trace("Renderer class not defined.");
                return;
            }
            totalHeight = 0;
            var loc1:*=0;
            while (loc1 < arg1) 
            {
                this.createRendererByDataIndex(loc1);
                ++loc1;
            }
            return;
        }

        protected override function setupRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = this;
            arg1.focusTarget = this;
            arg1.tabEnabled = false;
            arg1.doubleClickEnabled = true;
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, handleItemClick, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, this.dispatchItemEvent, false, 0, true);
            if (_usingExternalRenderers) 
                arg1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel, false, 0, true);
            return;
        }

        protected override function cleanUpRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = null;
            arg1.focusTarget = null;
            arg1.doubleClickEnabled = false;
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, handleItemClick);
            arg1.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent);
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel);
            arg1.removeEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, this.dispatchItemEvent);
            net.wg.gui.lobby.settings.components.KeysItemRenderer(arg1).dispose();
            return;
        }

        protected override function dispatchItemEvent(arg1:flash.events.Event):Boolean
        {
            var loc1:*=null;
            var loc7:*=arg1.type;
            switch (loc7) 
            {
                case scaleform.clik.events.ButtonEvent.PRESS:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_PRESS;
                    break;
                case scaleform.clik.events.ButtonEvent.CLICK:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_CLICK;
                    break;
                case flash.events.MouseEvent.ROLL_OVER:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_ROLL_OVER;
                    break;
                case flash.events.MouseEvent.ROLL_OUT:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_ROLL_OUT;
                    break;
                case flash.events.MouseEvent.DOUBLE_CLICK:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK;
                    break;
                case net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_TEXT_CHANGE;
                    break;
                default:
                    return true;
            }
            var loc2:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc3:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc3 = (arg1 as scaleform.clik.events.ButtonEvent).controllerIdx;
            else if (arg1 is net.wg.gui.lobby.settings.components.evnts.KeyInputEvents) 
                loc3 = net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(arg1).keyCode;
            else if (arg1 is scaleform.gfx.MouseEventEx) 
                loc3 = (arg1 as scaleform.gfx.MouseEventEx).mouseIdx;
            var loc4:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc4 = (arg1 as scaleform.clik.events.ButtonEvent).buttonIdx;
            else if (arg1 is scaleform.gfx.MouseEventEx) 
                loc4 = (arg1 as scaleform.gfx.MouseEventEx).buttonIdx;
            var loc5:*=false;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc5 = (arg1 as scaleform.clik.events.ButtonEvent).isKeyboard;
            var loc6:*=new net.wg.gui.events.ListEventEx(loc1, false, true, loc2.index, 0, loc2.index, loc2, dataProvider[loc2.index], loc3, loc4, loc5);
            return dispatchEvent(loc6);
        }

        protected override function scrollList(arg1:int):void
        {
            if (this.isSelected()) 
                return;
            super.scrollList(arg1);
            return;
        }

        public override function scrollToIndex(arg1:uint):void
        {
            if (this.isSelected()) 
                return;
            super.scrollToIndex(arg1);
            return;
        }

        internal function isSelected():Boolean
        {
            var loc3:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = getRendererAt(loc2) as net.wg.gui.lobby.settings.components.KeysItemRenderer;
                if (loc3.isSelected()) 
                    return true;
                ++loc2;
            }
            return false;
        }

        public function restoreDefault():void
        {
            var loc3:*=null;
            var loc1:*=dataProvider.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (!dataProvider[loc2].header && !(dataProvider[loc2].key == dataProvider[loc2].keyDefault)) 
                {
                    dataProvider[loc2].key = dataProvider[loc2].keyDefault;
                    loc3 = new net.wg.gui.events.ListEventEx(net.wg.gui.events.ListEventEx.ITEM_TEXT_CHANGE, false, true, 0, 0, 0, null, dataProvider[loc2], dataProvider[loc2].key);
                    dispatchEvent(loc3);
                }
                ++loc2;
            }
            dataProvider.invalidate();
            return;
        }

        public function keysWasChanged():Boolean
        {
            var loc1:*=false;
            var loc2:*=dataProvider.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (!dataProvider[loc3].header && !(dataProvider[loc3].key == dataProvider[loc3].keyDefault)) 
                {
                    loc1 = true;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public override function dispose():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            super.dispose();
            if (_renderers != null) 
            {
                loc1 = _renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = getRendererAt(loc2);
                    this.cleanUpRenderer(loc3);
                    loc4 = loc3 as flash.display.DisplayObject;
                    if (container.contains(loc4)) 
                        container.removeChild(loc4);
                    ++loc2;
                }
            }
            _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
            return;
        }

        public override function toString():String
        {
            return "[Wargaming KeysScrollingList " + name + "]";
        }
    }
}
