package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class DashLine extends scaleform.clik.core.UIComponent
    {
        public function DashLine()
        {
            this.maskObj = new flash.display.Sprite();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addChild(this.maskObj);
            this.background.mask = this.maskObj;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.background.width = width;
                invalidate(REDRAW_INV);
            }
            if (isInvalid(REDRAW_INV)) 
            {
                loc1 = this.maskObj.graphics;
                loc1.clear();
                loc1.beginFill(0);
                loc2 = 0;
                loc3 = 0;
                loc4 = 0;
                while (loc2 < _width) 
                {
                    if ((loc4 = loc2 + this._dashLength) <= _width) 
                    {
                        loc3 = this._dashLength;
                    }
                    else 
                    {
                        loc3 = _width - loc4;
                    }
                    loc1.drawRect(loc2, 0, loc3, _height);
                    loc2 = loc2 + (loc3 + this._gap);
                }
            }
            return;
        }

        public function get gap():uint
        {
            return this._gap;
        }

        public function set gap(arg1:uint):void
        {
            this._gap = arg1;
            invalidate(REDRAW_INV);
            return;
        }

        public function get dashLength():uint
        {
            return this._dashLength;
        }

        public function set dashLength(arg1:uint):void
        {
            this._dashLength = arg1;
            invalidate(REDRAW_INV);
            return;
        }

        internal static const REDRAW_INV:String="redrawInv";

        public var background:flash.display.MovieClip;

        internal var maskObj:flash.display.Sprite;

        internal var _gap:uint=2;

        internal var _dashLength:uint=1;
    }
}
