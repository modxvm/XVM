package net.wg.gui.lobby.techtree.helpers
{
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.techtree.controls.LevelsContainer;
    import fl.transitions.easing.Strong;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.constants.ColorIndex;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.constants.OutLiteral;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
    
    public class NTGraphics extends LinesGraphics
    {
        
        public function NTGraphics() {
            this.parentIDs = {};
            super();
        }
        
        private var tween:Tween = null;
        
        private var parentIDs:Object;
        
        public var levels:LevelsContainer;
        
        public var inButtonOffset:Number = 0;
        
        public var outButtonOffset:Number = 0;
        
        public function hide() : void {
            if(this.tween != null)
            {
                this.tween.reset();
                this.tween = null;
            }
            alpha = 0;
        }
        
        public function show() : void {
            this.tween = new Tween(150,this,{"alpha":1},{
                "paused":false,
                "ease":Strong.easeIn
            });
    }
    
    public function drawTopLines(param1:IRenderer, param2:Boolean) : void {
        var _loc9_:Point = null;
        var _loc11_:* = NaN;
        var _loc13_:* = NaN;
        var _loc14_:Object = null;
        var _loc15_:IRenderer = null;
        var _loc3_:Object = param1.getDisplayInfo();
        if(_loc3_ == null || _loc3_.lines == null)
        {
            return;
        }
        var _loc4_:Object = _loc3_.lines[0];
        var _loc5_:Number = param1.getID();
        clearLinesAndArrows(param1);
        if(_loc4_ == null)
        {
            return;
        }
        var _loc6_:Array = _loc4_.outPin;
        var _loc7_:Array = _loc4_.inPins;
        var _loc8_:Point = new Point(_loc6_[0],_loc6_[1]);
        var _loc10_:Number = _loc7_.length;
        var _loc12_:Number = Number.MAX_VALUE;
        var _loc16_:Array = [];
        var _loc17_:Array = [];
        _loc13_ = 0;
        while(_loc13_ < _loc10_)
        {
            _loc14_ = _loc7_[_loc13_];
            _loc9_ = new Point(_loc14_.inPin[0],_loc14_.inPin[1]);
            if(!isNaN(_loc14_.childID))
            {
                if(_loc8_.y > _loc9_.y)
                {
                    _loc16_.push(new TopLineInfo(_loc14_.childID,_loc9_));
                }
                else if(_loc8_.y < _loc9_.y)
                {
                    _loc17_.push(new TopLineInfo(_loc14_.childID,_loc9_));
                }
                else if(_loc8_.y == _loc9_.y)
                {
                    _loc15_ = _container.getNodeByID(_loc14_.childID);
                    _loc11_ = colorIdxs[_loc15_.getColorIdx(_loc5_)];
                    drawLine(param1,_loc11_,_loc8_,_loc9_);
                    drawArrowEx(param1,_loc11_,_loc8_,_loc9_);
                }
                
                
                _loc12_ = Math.min(_loc12_,_loc9_.x);
            }
            _loc13_++;
        }
        var _loc18_:Point = new Point(_loc8_.x + (_loc12_ - _loc8_.x >> 1),0);
        _loc9_ = _loc18_.clone();
        _loc16_.sortOn("y",Array.NUMERIC);
        _loc17_.sortOn("y",Array.NUMERIC | Array.DESCENDING);
        var _loc19_:Number = ColorIndex.DEFAULT;
        var _loc20_:Number = ColorIndex.DEFAULT;
        var _loc21_:Number = ColorIndex.DEFAULT;
        _loc10_ = _loc16_.length;
        _loc13_ = 0;
        while(_loc13_ < _loc10_)
        {
            _loc14_ = _loc16_[_loc13_];
            _loc15_ = _container.getNodeByID(_loc14_.id);
            _loc21_ = _loc15_.getColorIdx(_loc5_);
            _loc19_ = Math.min(_loc19_,_loc21_);
            _loc11_ = colorIdxs[_loc21_];
            _loc9_.y = _loc13_ == _loc10_ - 1?_loc8_.y:_loc16_[_loc13_ + 1].point.y;
            _loc18_.y = _loc14_.point.y;
            drawLine(param1,_loc11_,_loc18_,_loc14_.point);
            drawArrow(param1,_loc11_,_loc14_.point);
            drawLine(param1,colorIdxs[_loc19_],_loc18_,_loc9_);
            if(!param2)
            {
                _loc15_.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged,false,0,true);
            }
            _loc13_++;
        }
        _loc10_ = _loc17_.length;
        _loc13_ = 0;
        while(_loc13_ < _loc10_)
        {
            _loc14_ = _loc17_[_loc13_];
            _loc15_ = _container.getNodeByID(_loc14_.id);
            _loc21_ = _loc15_.getColorIdx(_loc5_);
            _loc20_ = Math.min(_loc20_,_loc21_);
            _loc11_ = colorIdxs[_loc21_];
            _loc9_.y = _loc13_ == _loc10_ - 1?_loc8_.y:_loc17_[_loc13_ + 1].point.y;
            _loc18_.y = _loc14_.point.y;
            drawLine(param1,_loc11_,_loc18_,_loc14_.point);
            drawArrow(param1,_loc11_,_loc14_.point);
            drawLine(param1,colorIdxs[_loc20_],_loc18_,_loc9_);
            if(!param2)
            {
                _loc15_.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged,false,0,true);
            }
            _loc13_++;
        }
        _loc18_.y = _loc8_.y;
        drawLine(param1,colorIdxs[Math.min(_loc19_,_loc20_)],_loc8_,_loc18_);
    }
    
    public function drawLineSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
        if(param1 == null || param2 == null)
        {
            return;
        }
        var _loc4_:String = param2.outLiteral;
        clearLinesAndArrows(param1,_loc4_);
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
    
    public function drawNodeLines(param1:IRenderer, param2:Boolean) : void {
        var _loc5_:Object = null;
        var _loc3_:Object = param1.getDisplayInfo();
        if(_loc3_ == null)
        {
            return;
        }
        if(!param2)
        {
            param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleNodeStateChanged,false,0,true);
        }
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
    }
    
    public function drawLevelsDelimiters(param1:Vector.<Distance>, param2:Number, param3:Number) : Number {
        if(this.levels == null)
        {
            return 0;
        }
        return this.levels.updateLevels(param1,param2,param3);
    }
    
    override protected function onDispose() : void {
        this.tween = null;
        this.clearUp();
        super.onDispose();
    }
    
    override public function clearUp() : void {
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
        this.parentIDs = {};
    }
    
    override public function clearUpRenderer(param1:IRenderer) : void {
        param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleRootChildStateChanged);
        param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleNodeStateChanged);
    }
    
    public function clearCache() : void {
        this.parentIDs = {};
    }
    
    private function addParentID(param1:IRenderer, param2:IRenderer) : void {
        var _loc3_:Number = param2.getID();
        if(this.parentIDs[_loc3_] == undefined)
        {
            this.parentIDs[_loc3_] = [];
        }
        var _loc4_:Array = this.parentIDs[_loc3_];
        _loc3_ = param1.getID();
        if(_loc4_.indexOf(_loc3_) == -1)
        {
            _loc4_.push(_loc3_);
        }
    }
    
    private function drawSingleLine(param1:IRenderer, param2:Array, param3:Object, param4:Boolean) : void {
        var _loc10_:Point = null;
        var _loc11_:Array = null;
        var _loc12_:* = NaN;
        var _loc5_:IRenderer = container.getNodeByID(param3.childID);
        if(!_loc5_)
        {
            return;
        }
        var _loc6_:Array = param3.inPin;
        var _loc7_:Array = param3.viaPins;
        var _loc8_:Number = colorIdxs[Math.max(param1.getColorIdx(),_loc5_.getColorIdx(param1.getID()))];
        var _loc9_:Point = new Point(param2[0],param2[1]);
        if(_loc7_.length > 0)
        {
            _loc12_ = 0;
            while(_loc12_ < _loc7_.length)
            {
                _loc11_ = _loc7_[_loc12_];
                _loc10_ = new Point(_loc11_[0],_loc11_[1]);
                drawLine(param1,_loc8_,_loc9_,_loc10_);
                _loc9_ = _loc10_;
                _loc12_++;
            }
            _loc10_ = new Point(_loc6_[0],_loc6_[1]);
            drawLine(param1,_loc8_,_loc9_,_loc10_);
            drawArrowEx(param1,_loc8_,_loc9_,_loc10_);
        }
        else
        {
            _loc10_ = new Point(_loc6_[0],_loc6_[1]);
            drawLine(param1,_loc8_,_loc9_,_loc10_);
            drawArrowEx(param1,_loc8_,_loc9_,_loc10_);
        }
        if(!param4)
        {
            this.addParentID(param1,_loc5_);
        }
    }
    
    private function drawLineRSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
        var _loc8_:Point = null;
        var _loc9_:Point = null;
        var _loc10_:Array = null;
        var _loc11_:Array = null;
        var _loc12_:Array = null;
        var _loc13_:Object = null;
        var _loc14_:Object = null;
        var _loc18_:* = NaN;
        var _loc19_:IRenderer = null;
        var _loc21_:* = NaN;
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
        var _loc17_:Number = ColorIndex.DEFAULT;
        var _loc20_:Number = param1.getID();
        _loc18_ = 0;
        while(_loc18_ < _loc6_)
        {
            _loc13_ = _loc5_[_loc18_];
            _loc11_ = _loc13_.inPin;
            _loc10_ = _loc13_.viaPins;
            _loc19_ = container.getNodeByID(_loc13_.childID);
            if(_loc19_)
            {
                _loc17_ = Math.max(param1.getColorIdx(),_loc19_.getColorIdx(_loc20_));
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
        _loc15_.sortOn("childIdx",Array.NUMERIC | Array.DESCENDING);
        _loc6_ = _loc15_.length;
        _loc18_ = 0;
        while(_loc18_ < _loc6_)
        {
            _loc14_ = _loc15_[_loc18_];
            _loc17_ = _loc14_.childIdx;
            _loc13_ = _loc5_[_loc14_.idx];
            _loc8_ = new Point(_loc13_.inPin[0],_loc13_.inPin[1]);
            _loc10_ = _loc13_.viaPins;
            _loc21_ = 0;
            while(_loc21_ < _loc10_.length - 1)
            {
                _loc11_ = _loc10_[_loc21_];
                _loc12_ = _loc10_[_loc21_ + 1];
                drawLine(param1,colorIdxs[_loc17_],new Point(_loc11_[0],_loc11_[1]),new Point(_loc12_[0],_loc12_[1]));
                _loc21_++;
            }
            if(_loc10_.length > 0)
            {
                _loc11_ = _loc10_[_loc10_.length - 1];
                _loc9_ = new Point(_loc11_[0],_loc11_[1]);
                drawLine(param1,colorIdxs[_loc17_],_loc9_,_loc8_);
                drawArrowEx(param1,colorIdxs[_loc17_],_loc9_,_loc8_);
            }
            _loc8_ = new Point(_loc14_.x,_loc7_.y);
            drawLine(param1,colorIdxs[_loc17_],_loc7_,_loc8_);
            if(_loc14_.drawArrow)
            {
                drawArrowEx(param1,colorIdxs[_loc17_],_loc7_,_loc8_);
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
    
    private function drawLineTMSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
        var _loc4_:Array = param2.outPin;
        var _loc5_:Array = param2.inPins;
        var _loc6_:Object = _loc5_[0];
        var _loc7_:IRenderer = container.getNodeByID(_loc6_.childID);
        if(!(_loc7_ == null) && (_loc7_.isButtonVisible()) && this.inButtonOffset > 0)
        {
            _loc6_ = {
                "childID":_loc6_.childID,
                "inPin":[Number(_loc6_.inPin[0]),Number(_loc6_.inPin[1]) + this.inButtonOffset],
                "viaPins":_loc6_.viaPins
            };
    }
    this.drawSingleLine(param1,_loc4_,_loc6_,param3);
    if(_loc5_.length > 1)
    {
    }
}

private function drawLineTRSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
    var _loc4_:Array = param2.outPin;
    var _loc5_:Array = param2.inPins;
    var _loc6_:Object = _loc5_[0];
    this.drawSingleLine(param1,_loc4_,_loc6_,param3);
    if(_loc5_.length > 1)
    {
    }
}

private function drawLineBMSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
    var _loc4_:Array = param2.outPin;
    var _loc5_:Array = param2.inPins;
    if((param1.isButtonVisible()) && this.outButtonOffset > 0)
    {
        _loc4_ = [Number(_loc4_[0]),Number(_loc4_[1]) + this.outButtonOffset];
    }
    this.drawSingleLine(param1,_loc4_,_loc5_[0],param3);
    if(_loc5_.length > 1)
    {
    }
}

private function drawLineBRSet(param1:IRenderer, param2:Object, param3:Boolean) : void {
    var _loc4_:Array = param2.outPin;
    var _loc5_:Array = param2.inPins;
    var _loc6_:Object = _loc5_[0];
    this.drawSingleLine(param1,_loc4_,_loc6_,param3);
    if(_loc5_.length > 1)
    {
    }
}

private function handleRootChildStateChanged(param1:TechTreeEvent) : void {
    var _loc2_:IRenderer = container.getRootNode();
    if(!(_loc2_ == null) && (NodeStateCollection.isRedrawNTLines(param1.primary)))
    {
        this.drawTopLines(_loc2_,true);
    }
}

private function handleNodeStateChanged(param1:TechTreeEvent) : void {
    var _loc2_:IRenderer = null;
    var _loc3_:Array = null;
    var _loc4_:* = NaN;
    var _loc5_:IRenderer = null;
    var _loc6_:* = NaN;
    if(NodeStateCollection.isRedrawNTLines(param1.primary))
    {
        _loc2_ = param1.target as IRenderer;
        if(_loc2_ != null)
        {
            this.drawNodeLines(_loc2_,true);
            _loc3_ = this.parentIDs[_loc2_.getID()];
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
}
import flash.geom.Point;

class TopLineInfo extends Object
{

function TopLineInfo(param1:Number, param2:Point = null) {
super();
this.id = param1;
this.point = param2;
}

public var id:Number;

public var point:Point;

public function get y() : Number {
return this.point.y;
}
}
class RSetLineInfo extends Object
{

function RSetLineInfo(param1:Number, param2:Number, param3:Boolean, param4:Number) {
super();
this.idx = param1;
this.x = param2;
this.drawArrow = param3;
this.childIdx = param4;
}

public var idx:Number;

public var x:Number;

public var drawArrow:Boolean;

public var childIdx:Number;
}
