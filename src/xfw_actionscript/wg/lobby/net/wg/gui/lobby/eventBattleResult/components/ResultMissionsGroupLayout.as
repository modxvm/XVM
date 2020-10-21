package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.components.containers.GroupLayout;
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class ResultMissionsGroupLayout extends GroupLayout
    {

        private var _rendererWidth:int;

        private var _rendererHeight:int;

        private var _renderers:Vector.<UIComponentEx>;

        public function ResultMissionsGroupLayout(param1:int, param2:int)
        {
            super();
            this._rendererWidth = param1;
            this._rendererHeight = param2;
            this._renderers = new Vector.<UIComponentEx>();
        }

        override public function dispose() : void
        {
            this._renderers.splice(0,this._renderers.length);
            this._renderers = null;
            super.dispose();
        }

        override public function invokeLayout() : Object
        {
            var _loc1_:DisplayObject = null;
            var _loc3_:* = 0;
            var _loc5_:UIComponentEx = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            this._renderers.splice(0,this._renderers.length);
            var _loc2_:int = _target.numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                _loc1_ = _target.getChildAt(_loc3_);
                if(_loc1_ is UIComponentEx)
                {
                    this._renderers.push(_loc1_);
                }
                _loc3_++;
            }
            var _loc4_:int = this._renderers.length;
            if(_loc4_ > 0)
            {
                _loc6_ = gap;
                _loc7_ = _target.width;
                _loc8_ = _loc4_ * (this._rendererWidth + _loc6_) - _loc6_;
                _loc9_ = _loc7_ - _loc8_ >> 1;
                _loc3_ = 0;
                while(_loc3_ < _loc4_)
                {
                    _loc5_ = this._renderers[_loc3_];
                    _loc5_.x = _loc9_;
                    _loc5_.setSize(this._rendererWidth,this._rendererHeight);
                    _loc9_ = _loc9_ + (this._rendererWidth + _loc6_);
                    _loc3_++;
                }
                return new Point(_loc7_,_target.height);
            }
            return new Point(0,0);
        }

        public function get rendererWidth() : int
        {
            return this._rendererWidth;
        }

        public function set rendererWidth(param1:int) : void
        {
            this._rendererWidth = param1;
        }

        public function get rendererHeight() : int
        {
            return this._rendererHeight;
        }

        public function set rendererHeight(param1:int) : void
        {
            this._rendererHeight = param1;
        }
    }
}
