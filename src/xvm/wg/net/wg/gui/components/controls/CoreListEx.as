package net.wg.gui.components.controls 
{
    import flash.events.*;
    import net.wg.gui.events.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class CoreListEx extends scaleform.clik.controls.CoreList
    {
        public function CoreListEx()
        {
            super();
            return;
        }

        protected function onItemStartDrag(arg1:net.wg.gui.events.ListEventEx):void
        {
            return;
        }

        protected function onItemStopDrag(arg1:net.wg.gui.events.ListEventEx):void
        {
            return;
        }

        protected override function setupRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = this;
            arg1.focusTarget = this;
            arg1.tabEnabled = false;
            arg1.doubleClickEnabled = true;
            arg1.enabled = this.enabled;
            if (arg1 is net.wg.gui.components.controls.SoundListItemRenderer) 
                (arg1 as net.wg.gui.components.controls.SoundListItemRenderer).useRightButton = this._useRightButton;
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleItemClick, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OVER, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.DRAG_OUT, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent, false, 0, true);
            arg1.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DRAG_START, this.onItemStartDrag, false, 0, true);
            arg1.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DRAG_STOP, this.onItemStopDrag, false, 0, true);
            if (_usingExternalRenderers) 
                arg1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel, false, 0, true);
            return;
        }

        protected override function cleanUpRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            arg1.owner = null;
            arg1.focusTarget = null;
            arg1.doubleClickEnabled = false;
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.dispatchItemEvent, false);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleItemClick, false);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.DRAG_OVER, this.dispatchItemEvent, false);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.DRAG_OUT, this.dispatchItemEvent, false);
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.dispatchItemEvent, false);
            arg1.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.dispatchItemEvent, false);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.dispatchItemEvent, false);
            arg1.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.dispatchItemEvent, false);
            arg1.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleMouseWheel, false);
            arg1.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DRAG_START, this.onItemStartDrag, false);
            arg1.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DRAG_STOP, this.onItemStopDrag, false);
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
                case scaleform.clik.events.ButtonEvent.DRAG_OVER:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_DRAG_OVER;
                    break;
                case scaleform.clik.events.ButtonEvent.DRAG_OUT:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_DRAG_OUT;
                    break;
                case scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE:
                    loc1 = net.wg.gui.events.ListEventEx.ITEM_RELEASE_OUTSIDE;
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
                default:
                    return true;
            }
            var loc2:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc3:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
                loc3 = (arg1 as scaleform.clik.events.ButtonEvent).controllerIdx;
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
            var loc6:*=new net.wg.gui.events.ListEventEx(loc1, false, true, loc2.index, 0, loc2.index, loc2, dataProvider.requestItemAt(loc2.index), loc3, loc4, loc5);
            return dispatchEvent(loc6);
        }

        public function set useRightButton(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._useRightButton == arg1) 
                return;
            this._useRightButton = arg1;
            if (_renderers) 
            {
                loc1 = 0;
                while (loc1 < _renderers.length) 
                {
                    loc2 = getRendererAt(loc1) as net.wg.gui.components.controls.SoundListItemRenderer;
                    if (loc2) 
                        loc2.useRightButton = this._useRightButton;
                    ++loc1;
                }
            }
            return;
        }

        public function get useRightButton():Boolean
        {
            return this._useRightButton;
        }

        public function set useRightButtonForSelect(arg1:Boolean):void
        {
            if (this._useRightButtonForSelect == arg1) 
                return;
            this._useRightButtonForSelect = arg1;
            return;
        }

        public function get useRightButtonForSelect():Boolean
        {
            return this._useRightButtonForSelect;
        }

        protected override function handleItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=(arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer).index;
            if (isNaN(loc1)) 
                return;
            if (this.dispatchItemEvent(arg1)) 
                if (this.useRightButton && this.useRightButtonForSelect || arg1.buttonIdx == 0) 
                    selectedIndex = loc1;
            return;
        }

        internal var _useRightButton:Boolean=false;

        internal var _useRightButtonForSelect:Boolean=false;
    }
}
