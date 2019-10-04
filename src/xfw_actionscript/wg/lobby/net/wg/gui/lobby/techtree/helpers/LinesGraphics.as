package net.wg.gui.lobby.techtree.helpers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.display.Graphics;
    import flash.geom.ColorTransform;
    import net.wg.data.constants.Values;

    public class LinesGraphics extends Sprite implements IDisposable
    {

        private static const DEFAULT_ARROW_WIDTH:Number = 6;

        public var unlockedLineColor:Number;

        public var lockedLineColor:Number;

        public var lineThickness:Number = 1;

        public var arrowRenderer:String = "Arrow";

        protected var _colorIdxs:Array = null;

        protected var _container:INodesContainer = null;

        private var _uiid:uint = 4.294967295E9;

        public function LinesGraphics()
        {
            super();
        }

        public function clearLinesAndArrows(param1:IRenderer) : void
        {
            var _loc2_:DisplayObject = getChildByName(param1.getGraphicsName());
            if(_loc2_ == null)
            {
                return;
            }
            removeChild(_loc2_);
        }

        public function clearUp() : void
        {
        }

        public function clearUpRenderer(param1:IRenderer) : void
        {
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function drawLine(param1:IRenderer, param2:Number, param3:Point, param4:Point) : void
        {
            var _loc5_:Graphics = this.getSubSprite(param1).graphics;
            var _loc6_:Number = this.lineThickness * 0.5;
            var _loc7_:Number = this.getVectorAngle(param3,param4);
            var _loc8_:Number = _loc6_ * Math.cos(_loc7_);
            var _loc9_:Number = _loc6_ * Math.sin(_loc7_);
            _loc5_.lineStyle(this.lineThickness,param2);
            _loc5_.moveTo(param3.x + _loc8_,param3.y + _loc9_);
            _loc5_.lineTo(param4.x - _loc8_,param4.y - _loc9_);
        }

        public function drawLineAndArrow(param1:IRenderer, param2:Number, param3:Point, param4:Point) : void
        {
            var _loc5_:Number = this.getVectorAngle(param3,param4);
            var _loc6_:Object = {
                "x":param4.x,
                "y":param4.y,
                "rotation":_loc5_ * 180 / Math.PI
            };
            var _loc7_:Sprite = App.utils.classFactory.getComponent(this.arrowRenderer,Sprite,_loc6_);
            var _loc8_:ColorTransform = new ColorTransform();
            _loc8_.color = param2;
            _loc7_.transform.colorTransform = _loc8_;
            this.getSubSprite(param1).addChild(_loc7_);
            param4.x = param4.x - DEFAULT_ARROW_WIDTH * Math.cos(_loc5_);
            param4.y = param4.y - DEFAULT_ARROW_WIDTH * Math.sin(_loc5_);
            this.drawLine(param1,param2,param3,param4);
        }

        public function getVectorAngle(param1:Point, param2:Point) : Number
        {
            var _loc3_:Point = param2.subtract(param1);
            return Math.atan(_loc3_.y / _loc3_.x);
        }

        public function removeRenderer(param1:IRenderer) : void
        {
            this.clearUpRenderer(param1);
            this.clearLinesAndArrows(param1);
            if(contains(DisplayObject(param1)))
            {
                removeChild(DisplayObject(param1));
            }
        }

        public function setup() : void
        {
            this._colorIdxs = [this.unlockedLineColor,this.lockedLineColor];
        }

        protected function onDispose() : void
        {
            this._container = null;
            this._colorIdxs.splice(0,this._colorIdxs.length);
            this._colorIdxs = null;
        }

        protected function setBlendMode(param1:IRenderer, param2:String) : void
        {
            var _loc3_:DisplayObject = getChildByName(param1.getGraphicsName());
            if(_loc3_)
            {
                _loc3_.blendMode = param2;
            }
        }

        protected function getSubSprite(param1:IRenderer, param2:Boolean = true) : Sprite
        {
            var _loc3_:String = param1.getGraphicsName();
            var _loc4_:Sprite = getChildByName(_loc3_) as Sprite;
            if(_loc4_ == null && param2)
            {
                _loc4_ = new Sprite();
                _loc4_.name = _loc3_;
                addChildAt(_loc4_,0);
            }
            return _loc4_;
        }

        public function get container() : INodesContainer
        {
            return this._container;
        }

        public function set container(param1:INodesContainer) : void
        {
            this._container = param1;
        }

        public function get UIID() : uint
        {
            return this._uiid;
        }

        public function set UIID(param1:uint) : void
        {
            var _loc2_:String = null;
            if(this._uiid != Values.EMPTY_UIID)
            {
                _loc2_ = "UIID is unique value and can not be modified.";
                App.utils.asserter.assert(this._uiid == param1,_loc2_);
            }
            this._uiid = param1;
        }
    }
}
