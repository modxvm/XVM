package net.wg.gui.components.controls 
{
    import flash.events.*;
    import net.wg.gui.events.*;
    import scaleform.gfx.*;
    
    public class DragableListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function DragableListItemRenderer()
        {
            super();
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (!this.isDragging && this.dragEnabled) 
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                loc2 = loc1 != null ? loc1.mouseIdx : 0;
                loc3 = loc1 != null ? loc1.buttonIdx : 0;
                this.startDragX = owner.mouseX;
                this.isDragging = true;
                dispatchEvent(new net.wg.gui.events.ListEventEx(net.wg.gui.events.ListEventEx.ITEM_DRAG_START, false, false, index, -1, -1, null, null, loc2, loc3));
            }
            super.handleMousePress(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (this.isDragging && this.dragEnabled) 
            {
                this.isDragging = false;
                dispatchEvent(new net.wg.gui.events.ListEventEx(net.wg.gui.events.ListEventEx.ITEM_DRAG_STOP, false, false, index));
            }
            super.handleMouseRelease(arg1);
            if (Math.abs(this.startDragX - owner.mouseX) > this.DRAGGING_DELTA) 
                return;
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            if (this.isDragging && this.dragEnabled) 
            {
                this.isDragging = false;
                dispatchEvent(new net.wg.gui.events.ListEventEx(net.wg.gui.events.ListEventEx.ITEM_DRAG_STOP, false, false, index));
            }
            super.handleReleaseOutside(arg1);
            if (Math.abs(this.startDragX - owner.mouseX) > this.DRAGGING_DELTA) 
                return;
            return;
        }

        public function set dragEnabled(arg1:Boolean):void
        {
            if (arg1 == this._dragEnabled) 
                return;
            this._dragEnabled = arg1;
            return;
        }

        public function get dragEnabled():Boolean
        {
            return this._dragEnabled;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1) 
                this.empty = arg1.empty;
            return;
        }

        public function get empty():Boolean
        {
            return this._empty;
        }

        public function set empty(arg1:Boolean):void
        {
            if (this._empty == arg1) 
                return;
            this._empty = arg1;
            this._dataDirty = true;
            tabEnabled = focusable ? false : !this._empty;
            setState(enabled ? "up" : "disabled");
            return;
        }

        protected var isDragging:Boolean=false;

        internal var DRAGGING_DELTA:Number=10;

        internal var startDragX:Number=0;

        protected var _empty:Boolean=false;

        protected var _dataDirty:Boolean=false;

        internal var _dragEnabled:Boolean=false;
    }
}
