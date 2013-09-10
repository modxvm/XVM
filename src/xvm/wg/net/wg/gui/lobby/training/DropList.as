package net.wg.gui.lobby.training 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;
    
    public class DropList extends net.wg.gui.components.controls.ScrollingListEx implements net.wg.infrastructure.interfaces.IDropList
    {
        public function DropList()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.focusIndicator.visible = false;
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseOver, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseOut, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseOut, false);
            this.focusIndicator = null;
            super.dispose();
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            this._selectable = arg1;
            if (_renderers != null) 
            {
                loc1 = _renderers.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    (loc3 = getRendererAt(loc2)).selectable = this._selectable;
                    ++loc2;
                }
            }
            return;
        }

        public function highlightList():void
        {
            this.focusIndicator.visible = true;
            return;
        }

        public function hideHighLight():void
        {
            this.focusIndicator.visible = false;
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):void
        {
            this.focusIndicator.gotoAndPlay("dragOver");
            return;
        }

        internal function onMouseOut(arg1:flash.events.MouseEvent):void
        {
            this.focusIndicator.gotoAndPlay("dragOut");
            return;
        }

        public var focusIndicator:flash.display.MovieClip;

        internal var _selectable:Boolean=false;
    }
}
