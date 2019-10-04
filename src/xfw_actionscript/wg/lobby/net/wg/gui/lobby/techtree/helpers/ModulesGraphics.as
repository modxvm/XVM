package net.wg.gui.lobby.techtree.helpers
{
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class ModulesGraphics extends LinesGraphics
    {

        public var premiumLineColor:Number;

        public var xRatio:Number = 0;

        public var rootRenderer:IRenderer;

        public function ModulesGraphics()
        {
            super();
        }

        override public function clearUp() : void
        {
            super.clearUp();
            var _loc1_:* = 0;
            if(this.rootRenderer != null)
            {
                _loc1_++;
            }
            this.removeExtraRenderers(_loc1_);
        }

        override public function setup() : void
        {
            super.setup();
            _colorIdxs.push(this.premiumLineColor);
        }

        override protected function onDispose() : void
        {
            this.clearUp();
            this.rootRenderer = null;
            _container = null;
            super.onDispose();
        }

        public function buildRendererLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
        {
            clearLinesAndArrows(param1);
            if(param2)
            {
                this.drawOutgoingLines(param1,param2);
            }
        }

        protected function removeExtraRenderers(param1:int) : void
        {
            var _loc2_:DisplayObject = null;
            var _loc3_:Number = 0;
            while(numChildren > param1)
            {
                _loc2_ = getChildAt(_loc3_);
                if(_loc2_ != this.rootRenderer)
                {
                    if(_loc2_ is IRenderer)
                    {
                        clearUpRenderer(IRenderer(_loc2_));
                    }
                    removeChildAt(_loc3_);
                }
                else
                {
                    _loc3_++;
                }
            }
        }

        private function drawOutgoingLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
        {
            var _loc3_:Number = param2.length;
            if(_loc3_ == 0)
            {
                return;
            }
            var _loc4_:Point = new Point(param1.getOutX(),param1.getY());
            var _loc5_:Array = [];
            var _loc6_:Array = [];
            var _loc7_:Object = null;
            var _loc8_:ResearchLineInfo = null;
            var _loc9_:Point = null;
            var _loc10_:IRenderer = null;
            var _loc11_:Number = 0;
            while(_loc11_ < _loc3_)
            {
                _loc10_ = param2[_loc11_];
                if(_loc10_ != null)
                {
                    _loc9_ = new Point(_loc10_.getInX(),_loc10_.getY());
                    _loc8_ = new ResearchLineInfo(param1,_loc10_,_loc9_,!(_loc10_.isFake() || param1.isPremium()));
                    if(_loc4_.y > _loc9_.y)
                    {
                        _loc5_.push(_loc8_);
                    }
                    else if(_loc4_.y < _loc9_.y)
                    {
                        _loc6_.push(_loc8_);
                    }
                    else
                    {
                        _loc7_ = _loc8_;
                    }
                }
                _loc11_++;
            }
            var _loc12_:Point = new Point(_loc4_.x + this.xRatio,_loc4_.y);
            var _loc13_:uint = Math.max(param1.getColorIndex(),this.rootRenderer.getColorIndex());
            this.drawUpLines(_loc5_,_loc12_,_loc13_);
            this.drawDownLines(_loc6_,_loc12_,_loc13_);
            if(_loc7_ != null)
            {
                if(_loc7_.drawArrow)
                {
                    drawLineAndArrow(param1,_colorIdxs[_loc13_],_loc4_,_loc7_.point);
                }
                else
                {
                    drawLine(param1,_colorIdxs[_loc13_],_loc4_,_loc7_.point);
                }
            }
            else
            {
                drawLine(param1,_colorIdxs[_loc13_],_loc4_,_loc12_);
            }
        }

        private function drawUpLines(param1:Array, param2:Point, param3:uint, param4:Boolean = false) : void
        {
            var _loc6_:IRenderer = null;
            var _loc7_:IRenderer = null;
            var _loc8_:Point = null;
            var _loc9_:Point = null;
            var _loc10_:ResearchLineInfo = null;
            var _loc5_:uint = param1.length;
            param1.sortOn("y",Array.NUMERIC);
            var _loc11_:Number = 0;
            while(_loc11_ < _loc5_)
            {
                _loc10_ = param1[_loc11_];
                _loc7_ = _loc10_.child;
                _loc6_ = _loc10_.parent;
                _loc8_ = new Point(param2.x,_loc10_.point.y);
                _loc9_ = new Point(param2.x,_loc11_ == _loc5_ - 1?param2.y:param1[_loc11_ + 1].point.y);
                drawLine(_loc6_,_colorIdxs[param3],_loc8_,_loc9_);
                if(!param4)
                {
                    if(_loc10_.drawArrow)
                    {
                        drawLineAndArrow(_loc6_,_colorIdxs[param3],_loc8_,_loc10_.point);
                    }
                    else
                    {
                        drawLine(_loc6_,_colorIdxs[param3],_loc8_,_loc10_.point);
                    }
                }
                _loc11_++;
            }
        }

        private function drawDownLines(param1:Array, param2:Point, param3:uint, param4:Boolean = false) : void
        {
            var _loc6_:IRenderer = null;
            var _loc7_:IRenderer = null;
            var _loc8_:Point = null;
            var _loc9_:Point = null;
            var _loc10_:ResearchLineInfo = null;
            var _loc5_:Number = param1.length;
            param1.sortOn("y",Array.NUMERIC | Array.DESCENDING);
            var _loc11_:Number = 0;
            while(_loc11_ < _loc5_)
            {
                _loc10_ = param1[_loc11_];
                _loc7_ = _loc10_.child;
                _loc6_ = _loc10_.parent;
                _loc8_ = new Point(param2.x,_loc10_.point.y);
                _loc9_ = new Point(param2.x,_loc11_ == _loc5_ - 1?param2.y:param1[_loc11_ + 1].point.y);
                drawLine(_loc6_,_colorIdxs[param3],_loc8_,_loc9_);
                if(!param4)
                {
                    if(_loc10_.drawArrow)
                    {
                        drawLineAndArrow(_loc6_,_colorIdxs[param3],_loc8_,_loc10_.point);
                    }
                    else
                    {
                        drawLine(_loc6_,_colorIdxs[param3],_loc8_,_loc10_.point);
                    }
                }
                _loc11_++;
            }
        }
    }
}

import flash.geom.Point;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;

class ResearchLineInfo extends Object
{

    public var point:Point;

    public var parent:IRenderer;

    public var child:IRenderer;

    public var drawArrow:Boolean;

    function ResearchLineInfo(param1:IRenderer, param2:IRenderer, param3:Point, param4:Boolean)
    {
        super();
        this.parent = param1;
        this.child = param2;
        this.point = param3;
        this.drawArrow = param4;
    }

    public function get y() : Number
    {
        return this.point.y;
    }
}
