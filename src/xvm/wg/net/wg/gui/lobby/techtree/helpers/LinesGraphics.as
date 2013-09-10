package net.wg.gui.lobby.techtree.helpers 
{
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class LinesGraphics extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function LinesGraphics()
        {
            super();
            scale9Grid = new flash.geom.Rectangle(0, 0, 1, 1);
            this.getComponent = App.utils.classFactory.getComponent;
            return;
        }

        public function get container():net.wg.gui.lobby.techtree.interfaces.INodesContainer
        {
            return this._container;
        }

        public function set container(arg1:net.wg.gui.lobby.techtree.interfaces.INodesContainer):void
        {
            this._container = arg1;
            return;
        }

        public function getVectorAxeXAngle(arg1:flash.geom.Point, arg2:flash.geom.Point):Number
        {
            var loc1:*=NaN;
            var loc2:*;
            if ((loc2 = arg2.subtract(arg1)).y != 0) 
                if (loc2.x != 0) 
                    loc1 = Math.round(180 * Math.atan(loc2.y / loc2.x) / Math.PI);
                else 
                    loc1 = arg1.y > arg2.y ? -90 : 90;
            else 
                loc1 = 0;
            return loc1;
        }

        public function getArrowPosition(arg1:flash.geom.Point, arg2:Number):flash.geom.Point
        {
            var loc1:*=arg1.clone();
            if (arg2 != 0) 
                if (Math.abs(arg2) == 90) 
                    loc1.x = loc1.x + this.lineRatio;
            else 
                loc1.y = loc1.y + this.lineRatio;
            return loc1;
        }

        public function drawLine(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Number, arg3:flash.geom.Point, arg4:flash.geom.Point, arg5:String=null):void
        {
            var loc1:*;
            (loc1 = this.getSubSprite(arg1, arg5, true).graphics).lineStyle(this.lineThickness, arg2, 1);
            loc1.moveTo(arg3.x, arg3.y);
            loc1.lineTo(arg4.x, arg4.y);
            return;
        }

        public function drawArrow(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Number, arg3:flash.geom.Point, arg4:Number=0, arg5:String=null):void
        {
            var loc3:*=null;
            var loc1:*={"x":arg3.x, "y":arg3.y, "rotation":arg4};
            var loc2:*=this.getComponent(this.arrowRenderer, flash.display.Sprite, loc1);
            if (arg2) 
            {
                (loc3 = new flash.geom.ColorTransform()).color = arg2;
                loc2.transform.colorTransform = loc3;
            }
            this.getSubSprite(arg1, arg5, true).addChild(loc2);
            return;
        }

        public function drawArrowEx(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Number, arg3:flash.geom.Point, arg4:flash.geom.Point, arg5:String=null):void
        {
            var loc1:*=this.getVectorAxeXAngle(arg3, arg4);
            var loc2:*=this.getArrowPosition(arg4, loc1);
            this.drawArrow(arg1, arg2, loc2, loc1, arg5);
            return;
        }

        public function clearLinesAndArrows(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:String=null):void
        {
            var loc2:*=null;
            var loc1:*=getChildByName(LINES_AND_ARROWS_NAME + arg1.index) as flash.display.Sprite;
            if (loc1 == null) 
                return;
            if (!(arg2 == null) && arg2.length > 0) 
                if ((loc2 = this.getSubSprite(arg1, arg2, false)) != null) 
                    loc1.removeChild(loc2);
            else 
                removeChild(loc1);
            return;
        }

        public function setup():void
        {
            this.colorIdxs = [this.unlockedLineColor, this.next2unlockLineColor, this.lockedLineColor];
            this.lineRatio = 0.5 * this.lineThickness;
            return;
        }

        public function dispose():void
        {
            this._container = null;
            this.getComponent = null;
            return;
        }

        public function clearUp():void
        {
            return;
        }

        public function clearUpRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            return;
        }

        public function removeRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            this.clearUpRenderer(arg1);
            this.clearLinesAndArrows(arg1);
            if (contains(flash.display.DisplayObject(arg1))) 
                removeChild(flash.display.DisplayObject(arg1));
            return;
        }

        internal function getSubSprite(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:String=null, arg3:Boolean=true):flash.display.Sprite
        {
            var loc4:*=null;
            var loc1:*=LINES_AND_ARROWS_NAME + arg1.index;
            var loc2:*;
            if ((loc2 = getChildByName(loc1) as flash.display.Sprite) == null && arg3) 
            {
                (loc2 = new flash.display.Sprite()).name = loc1;
                addChild(loc2);
                loc4 = flash.display.DisplayObject(arg1);
                if (getChildIndex(loc2) > getChildIndex(loc4)) 
                    swapChildren(loc4, loc2);
            }
            var loc3:*=loc2;
            if (!(arg2 == null) && !(loc2 == null)) 
                if ((loc3 = loc2.getChildByName(arg2) as flash.display.Sprite) == null && arg3) 
                {
                    (loc3 = new flash.display.Sprite()).name = arg2;
                    loc2.addChild(loc3);
                }
            return loc3;
        }

        public static const LINES_AND_ARROWS_NAME:String="linesAndArrows";

        protected var colorIdxs:Array;

        protected var lineRatio:Number=0.5;

        protected var _container:net.wg.gui.lobby.techtree.interfaces.INodesContainer=null;

        protected var getComponent:Function=null;

        public var unlockedLineColor:Number;

        public var next2unlockLineColor:Number;

        public var lockedLineColor:Number;

        public var lineThickness:Number=1;

        public var arrowRenderer:String="Arrow";
    }
}
