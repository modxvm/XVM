package net.wg.gui.lobby.techtree.helpers
{
    import flash.display.BlendMode;
    import net.wg.gui.lobby.techtree.controls.LevelsContainer;
    import scaleform.clik.motion.Tween;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.constants.OutLiteral;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.constants.ColorIndex;
    import fl.transitions.easing.Strong;
    import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;

    public class NTGraphics extends LinesGraphics
    {

        private static const NT_ARROWS_BLEND_MODE:String = BlendMode.ADD;

        public var levels:LevelsContainer;

        private var _tween:Tween = null;

        private var _tweenWrapper:TweenWrapper = null;

        private var _parentIDs:Object;

        public function NTGraphics()
        {
            this._parentIDs = {};
            super();
            this._tweenWrapper = new TweenWrapper(this);
        }

        override public function clearUp() : void
        {
            var _loc3_:DisplayObject = null;
            super.clearUp();
            var _loc1_:Number = 0;
            var _loc2_:Number = 0;
            if(this.levels != null)
            {
                _loc2_++;
            }
            while(numChildren > _loc2_)
            {
                _loc3_ = getChildAt(_loc1_);
                if(_loc3_ != this.levels)
                {
                    if(_loc3_ is IRenderer)
                    {
                        this.clearUpRenderer(IRenderer(_loc3_));
                    }
                    removeChildAt(_loc1_);
                }
                else
                {
                    _loc1_++;
                }
            }
            this.levels.dispose();
            this._parentIDs = {};
        }

        override public function clearUpRenderer(param1:IRenderer) : void
        {
            param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged);
            param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleNodeStateChanged);
        }

        override protected function onDispose() : void
        {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
            this._tweenWrapper.dispose();
            this._tweenWrapper = null;
            this.clearUp();
            super.onDispose();
        }

        public function clearCache() : void
        {
            this._parentIDs = {};
        }

        public function drawLevelsDelimiters(param1:Vector.<Distance>, param2:Number, param3:Number) : Number
        {
            if(this.levels == null)
            {
                return 0;
            }
            this.setChildIndex(this.levels,0);
            return this.levels.updateLevels(param1,param2,param3);
        }

        public function drawLineSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            if(param1 == null || param2 == null)
            {
                return;
            }
            var _loc4_:String = param2.outLiteral;
            switch(_loc4_)
            {
                case OutLiteral.RIGHT_MIDDLE:
                    this.drawLineRSet(param1,param2,param3);
                    break;
                case OutLiteral.TOP_MIDDLE:
                    this.drawLineTMSet(param1,param2,param3);
                    break;
                case OutLiteral.BOTTOM_MIDDLE:
                    this.drawLineBMSet(param1,param2,param3);
                    break;
                case OutLiteral.TOP_RIGHT:
                    this.drawLineTRSet(param1,param2,param3);
                    break;
                case OutLiteral.BOTTOM_RIGHT:
                    this.drawLineBRSet(param1,param2,param3);
                    break;
            }
        }

        public function drawNodeLines(param1:IRenderer, param2:Boolean) : void
        {
            var _loc5_:Object = null;
            var _loc3_:Object = param1.getDisplayInfo();
            if(_loc3_ == null)
            {
                return;
            }
            clearLinesAndArrows(param1);
            var _loc4_:Array = _loc3_.lines;
            var _loc6_:Number = _loc4_.length;
            var _loc7_:Number = 0;
            while(_loc7_ < _loc6_)
            {
                _loc5_ = _loc4_[_loc7_];
                if(_loc5_ == null)
                {
                    return;
                }
                this.drawLineSet(param1,_loc5_,param2);
                _loc7_++;
            }
            setBlendMode(param1,NT_ARROWS_BLEND_MODE);
            if(!param2)
            {
                param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleNodeStateChanged,false,0,true);
            }
        }

        public function drawTopLines(param1:IRenderer, param2:Boolean) : void
        {
            var _loc8_:Point = null;
            var _loc9_:uint = 0;
            var _loc10_:* = NaN;
            var _loc13_:* = NaN;
            var _loc14_:Object = null;
            var _loc15_:IRenderer = null;
            var _loc21_:uint = 0;
            var _loc3_:Object = param1.getDisplayInfo();
            if(_loc3_ == null || _loc3_.lines == null)
            {
                return;
            }
            var _loc4_:Object = _loc3_.lines[0];
            clearLinesAndArrows(param1);
            if(_loc4_ == null)
            {
                return;
            }
            var _loc5_:Array = _loc4_.outPin;
            var _loc6_:Array = _loc4_.inPins;
            var _loc7_:Point = new Point(_loc5_[0],_loc5_[1]);
            var _loc11_:Number = _loc6_.length;
            var _loc12_:Number = Number.MAX_VALUE;
            var _loc16_:Array = [];
            var _loc17_:Array = [];
            _loc13_ = 0;
            while(_loc13_ < _loc11_)
            {
                _loc14_ = _loc6_[_loc13_];
                _loc8_ = new Point(_loc14_.inPin[0],_loc14_.inPin[1]);
                if(!isNaN(_loc14_.childID))
                {
                    if(_loc7_.y > _loc8_.y)
                    {
                        _loc16_.push(new TopLineInfo(_loc14_.childID,_loc8_));
                    }
                    else if(_loc7_.y < _loc8_.y)
                    {
                        _loc17_.push(new TopLineInfo(_loc14_.childID,_loc8_));
                    }
                    else if(_loc7_.y == _loc8_.y)
                    {
                        _loc15_ = _container.getNodeByID(_loc14_.childID);
                        _loc9_ = _loc15_.getColorIndex(param1);
                        _loc10_ = _colorIdxs[_loc9_];
                        drawLineAndArrow(param1,_loc10_,_loc7_,_loc8_);
                    }
                    _loc12_ = Math.min(_loc12_,_loc8_.x);
                }
                _loc13_++;
            }
            var _loc18_:Point = new Point(_loc7_.x + (_loc12_ - _loc7_.x >> 1),0);
            _loc8_ = _loc18_.clone();
            _loc16_.sortOn("y",Array.NUMERIC);
            _loc17_.sortOn("y",Array.NUMERIC | Array.DESCENDING);
            var _loc19_:uint = ColorIndex.DEFAULT;
            var _loc20_:uint = ColorIndex.DEFAULT;
            _loc11_ = _loc16_.length;
            _loc13_ = 0;
            while(_loc13_ < _loc11_)
            {
                _loc14_ = _loc16_[_loc13_];
                _loc15_ = _container.getNodeByID(_loc14_.id);
                _loc9_ = _loc15_.getColorIndex(param1);
                _loc19_ = Math.min(_loc19_,_loc9_);
                _loc10_ = _colorIdxs[_loc9_];
                _loc8_.y = _loc13_ == _loc11_ - 1?_loc7_.y:_loc16_[_loc13_ + 1].point.y;
                _loc18_.y = _loc14_.point.y;
                drawLineAndArrow(param1,_loc10_,_loc18_,_loc14_.point);
                drawLine(param1,_colorIdxs[_loc19_],_loc18_,_loc8_);
                if(!param2)
                {
                    _loc15_.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged,false,0,true);
                }
                _loc13_++;
            }
            _loc11_ = _loc17_.length;
            _loc13_ = 0;
            while(_loc13_ < _loc11_)
            {
                _loc14_ = _loc17_[_loc13_];
                _loc15_ = _container.getNodeByID(_loc14_.id);
                _loc9_ = _loc15_.getColorIndex(param1);
                _loc20_ = Math.min(_loc20_,_loc9_);
                _loc10_ = _colorIdxs[_loc9_];
                _loc8_.y = _loc13_ == _loc11_ - 1?_loc7_.y:_loc17_[_loc13_ + 1].point.y;
                _loc18_.y = _loc14_.point.y;
                drawLineAndArrow(param1,_loc10_,_loc18_,_loc14_.point);
                drawLine(param1,_colorIdxs[_loc20_],_loc18_,_loc8_);
                if(!param2)
                {
                    _loc15_.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged,false,0,true);
                }
                _loc13_++;
            }
            _loc18_.y = _loc7_.y;
            _loc21_ = Math.min(_loc19_,_loc20_);
            drawLine(param1,_colorIdxs[_loc21_],_loc7_,_loc18_);
            setBlendMode(param1,NT_ARROWS_BLEND_MODE);
        }

        public function hide() : void
        {
            if(this._tween != null)
            {
                this._tween.paused = true;
                this._tween.dispose();
                this._tween = null;
            }
            alpha = 0;
        }

        public function show() : void
        {
            this._tween = new Tween(150,this._tweenWrapper,{"alpha":1},{
                "paused":false,
                "ease":Strong.easeIn
            });
        }

        private function addParentID(param1:IRenderer, param2:IRenderer) : void
        {
            var _loc3_:Number = param2.getID();
            if(this._parentIDs[_loc3_] == undefined)
            {
                this._parentIDs[_loc3_] = [];
            }
            var _loc4_:Array = this._parentIDs[_loc3_];
            _loc3_ = param1.getID();
            if(_loc4_.indexOf(_loc3_) == -1)
            {
                _loc4_.push(_loc3_);
            }
        }

        private function drawSingleLine(param1:IRenderer, param2:Array, param3:Object, param4:Boolean) : void
        {
            var _loc11_:Point = null;
            var _loc12_:Array = null;
            var _loc13_:* = NaN;
            var _loc5_:IRenderer = container.getNodeByID(param3.childID);
            if(!_loc5_)
            {
                return;
            }
            var _loc6_:Array = param3.inPin;
            var _loc7_:Array = param3.viaPins;
            var _loc8_:uint = _loc5_.getColorIndex(param1);
            var _loc9_:Number = _colorIdxs[_loc8_];
            var _loc10_:Point = new Point(param2[0],param2[1]);
            if(_loc7_.length > 0)
            {
                _loc13_ = 0;
                while(_loc13_ < _loc7_.length)
                {
                    _loc12_ = _loc7_[_loc13_];
                    _loc11_ = new Point(_loc12_[0],_loc12_[1]);
                    drawLine(param1,_loc9_,_loc10_,_loc11_);
                    _loc10_ = _loc11_;
                    _loc13_++;
                }
                _loc11_ = new Point(_loc6_[0],_loc6_[1]);
                drawLineAndArrow(param1,_loc9_,_loc10_,_loc11_);
            }
            else
            {
                _loc11_ = new Point(_loc6_[0],_loc6_[1]);
                drawLineAndArrow(param1,_loc9_,_loc10_,_loc11_);
            }
            if(!param4)
            {
                this.addParentID(param1,_loc5_);
            }
        }

        private function drawLineRSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            var _loc8_:Point = null;
            var _loc9_:Point = null;
            var _loc10_:Array = null;
            var _loc11_:Array = null;
            var _loc12_:Array = null;
            var _loc13_:Object = null;
            var _loc14_:Object = null;
            var _loc18_:uint = 0;
            var _loc19_:IRenderer = null;
            var _loc20_:uint = 0;
            var _loc4_:Array = param2.outPin;
            var _loc5_:Array = param2.inPins;
            var _loc6_:Number = _loc5_.length;
            if(_loc6_ < 2)
            {
                if(_loc6_ == 1)
                {
                    this.drawSingleLine(param1,_loc4_,_loc5_[0],param3);
                }
                return;
            }
            var _loc7_:Point = new Point(_loc4_[0],_loc4_[1]);
            var _loc15_:Array = [];
            var _loc16_:Array = [];
            var _loc17_:uint = ColorIndex.DEFAULT;
            _loc18_ = 0;
            while(_loc18_ < _loc6_)
            {
                _loc13_ = _loc5_[_loc18_];
                _loc11_ = _loc13_.inPin;
                _loc10_ = _loc13_.viaPins;
                _loc19_ = container.getNodeByID(_loc13_.childID);
                if(_loc19_)
                {
                    _loc17_ = _loc19_.getColorIndex(param1);
                    if(_loc10_.length > 0)
                    {
                        _loc8_ = new Point(_loc10_[0][0],_loc10_[0][1]);
                        if(_loc7_.y == _loc8_.y)
                        {
                            _loc15_.push(new RSetLineInfo(_loc18_,_loc8_.x,false,_loc17_));
                        }
                        else
                        {
                            _loc16_.push(_loc18_);
                        }
                    }
                    else if(_loc7_.y == _loc11_[1])
                    {
                        _loc15_.push(new RSetLineInfo(_loc18_,_loc11_[0],true,_loc17_));
                    }
                    else
                    {
                        _loc16_.push(_loc18_);
                    }
                }
                _loc18_++;
            }
            _loc15_.sortOn("childIdx",Array.NUMERIC);
            _loc6_ = _loc15_.length;
            _loc18_ = 0;
            while(_loc18_ < _loc6_)
            {
                _loc14_ = _loc15_[_loc18_];
                _loc17_ = _loc14_.childIdx;
                _loc13_ = _loc5_[_loc14_.idx];
                _loc10_ = _loc13_.viaPins;
                _loc20_ = 0;
                while(_loc20_ < _loc10_.length - 1)
                {
                    _loc11_ = _loc10_[_loc20_];
                    _loc9_ = new Point(_loc11_[0],_loc11_[1]);
                    _loc12_ = _loc10_[_loc20_ + 1];
                    _loc8_ = new Point(_loc12_[0],_loc12_[1]);
                    drawLine(param1,_colorIdxs[_loc17_],_loc9_,_loc8_);
                    _loc20_++;
                }
                if(_loc10_.length > 0)
                {
                    _loc11_ = _loc10_[_loc10_.length - 1];
                    _loc9_ = new Point(_loc11_[0],_loc11_[1]);
                    _loc8_ = new Point(_loc13_.inPin[0],_loc13_.inPin[1]);
                    drawLineAndArrow(param1,_colorIdxs[_loc17_],_loc9_,_loc8_);
                }
                _loc8_ = new Point(_loc14_.x,_loc7_.y);
                if(_loc7_.x < _loc8_.x)
                {
                    if(_loc14_.drawArrow)
                    {
                        drawLineAndArrow(param1,_colorIdxs[_loc17_],_loc7_,_loc8_);
                    }
                    else
                    {
                        drawLine(param1,_colorIdxs[_loc17_],_loc7_,_loc8_);
                    }
                    _loc7_ = _loc8_;
                }
                if(!param3)
                {
                    this.addParentID(param1,_loc19_);
                }
                _loc18_++;
            }
            _loc6_ = _loc16_.length;
            _loc18_ = 0;
            while(_loc18_ < _loc6_)
            {
                this.drawSingleLine(param1,_loc4_,_loc5_[_loc16_[_loc18_]],param3);
                _loc18_++;
            }
        }

        private function drawLineTMSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            var _loc4_:Array = param2.outPin;
            var _loc5_:Array = param2.inPins;
            var _loc6_:Object = _loc5_[0];
            var _loc7_:IRenderer = container.getNodeByID(_loc6_.childID);
            if(_loc7_ != null && _loc7_.bottomArrowOffset > 0)
            {
                _loc6_ = {
                    "childID":_loc6_.childID,
                    "inPin":[Number(_loc6_.inPin[0]),Number(_loc6_.inPin[1]) + _loc7_.bottomArrowOffset],
                    "viaPins":_loc6_.viaPins
                };
            }
            this.drawSingleLine(param1,_loc4_,_loc6_,param3);
            if(_loc5_.length > 1)
            {
            }
        }

        private function drawLineTRSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            var _loc4_:Array = param2.outPin;
            var _loc5_:Array = param2.inPins;
            var _loc6_:Object = _loc5_[0];
            this.drawSingleLine(param1,_loc4_,_loc6_,param3);
            if(_loc5_.length > 1)
            {
            }
        }

        private function drawLineBMSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            var _loc4_:Array = param2.outPin;
            var _loc5_:Array = param2.inPins;
            if(param1.bottomArrowOffset > 0)
            {
                _loc4_ = [Number(_loc4_[0]),Number(_loc4_[1]) + param1.bottomArrowOffset];
            }
            this.drawSingleLine(param1,_loc4_,_loc5_[0],param3);
            if(_loc5_.length > 1)
            {
            }
        }

        private function drawLineBRSet(param1:IRenderer, param2:Object, param3:Boolean) : void
        {
            var _loc4_:Array = param2.outPin;
            var _loc5_:Array = param2.inPins;
            var _loc6_:Object = _loc5_[0];
            this.drawSingleLine(param1,_loc4_,_loc6_,param3);
            if(_loc5_.length > 1)
            {
            }
        }

        private function handleRootChildStateChanged(param1:TechTreeEvent) : void
        {
            var _loc2_:IRenderer = container.rootRenderer;
            if(_loc2_ != null && NodeStateCollection.instance.isRedrawNTLines(param1.nodeState))
            {
                this.drawTopLines(_loc2_,true);
            }
        }

        private function handleNodeStateChanged(param1:TechTreeEvent) : void
        {
            var _loc2_:IRenderer = null;
            var _loc3_:Array = null;
            var _loc4_:* = NaN;
            var _loc5_:IRenderer = null;
            var _loc6_:* = NaN;
            if(NodeStateCollection.instance.isRedrawNTLines(param1.nodeState))
            {
                _loc2_ = param1.target as IRenderer;
                if(_loc2_ == null)
                {
                    return;
                }
                _loc3_ = this._parentIDs[_loc2_.getID()];
                if(_loc3_ != null)
                {
                    _loc4_ = _loc3_.length;
                    _loc6_ = 0;
                    while(_loc6_ < _loc4_)
                    {
                        _loc5_ = container.getNodeByID(_loc3_[_loc6_]);
                        if(_loc5_ != null)
                        {
                            this.drawNodeLines(_loc5_,true);
                        }
                        _loc6_++;
                    }
                }
            }
        }
    }
}

import flash.geom.Point;

class TopLineInfo extends Object
{

    public var id:Number;

    public var point:Point;

    function TopLineInfo(param1:Number, param2:Point = null)
    {
        super();
        this.id = param1;
        this.point = param2;
    }

    public function get y() : Number
    {
        return this.point.y;
    }
}

class RSetLineInfo extends Object
{

    public var idx:Number;

    public var x:Number;

    public var drawArrow:Boolean;

    public var childIdx:Number;

    function RSetLineInfo(param1:Number, param2:Number, param3:Boolean, param4:Number)
    {
        super();
        this.idx = param1;
        this.x = param2;
        this.drawArrow = param3;
        this.childIdx = param4;
    }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.gui.lobby.techtree.helpers.NTGraphics;

class TweenWrapper extends Object implements IDisposable
{

    private var _target:NTGraphics = null;

    function TweenWrapper(param1:NTGraphics)
    {
        super();
        this._target = param1;
    }

    public final function dispose() : void
    {
        this._target = null;
    }

    public function get alpha() : Number
    {
        return this._target.alpha;
    }

    public function set alpha(param1:Number) : void
    {
        this._target.alpha = param1;
    }
}
