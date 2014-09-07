package net.wg.gui.lobby.GUIEditor
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    public class SelectRectangle extends Sprite implements IDisposable
    {
        
        public function SelectRectangle()
        {
            var _loc2_:uint = 0;
            var _loc3_:DisplayObject = null;
            this.squares = new Vector.<MovieClip>();
            super();
            var _loc1_:Class = App.utils.classFactory.getClass("SquareForSelect");
            if(_loc1_ != null)
            {
                _loc2_ = 8;
                while(_loc2_ > 0)
                {
                    _loc3_ = new _loc1_();
                    addChild(_loc3_);
                    this.squares.push(_loc3_);
                    _loc2_--;
                }
            }
        }
        
        private var squares:Vector.<MovieClip>;
        
        public function update(param1:DisplayObject) : void
        {
            var _loc2_:Number = 0;
            var _loc3_:Number = 0;
            var _loc4_:DisplayObjectContainer = App.stage;
            var _loc5_:Rectangle = param1.getBounds(_loc4_);
            if(param1.width == 1 && param1.height == 1)
            {
                _loc2_ = _loc5_.width;
                _loc3_ = _loc5_.height;
            }
            else
            {
                _loc2_ = param1.width * param1.scaleX;
                _loc3_ = param1.height * param1.scaleY;
            }
            this.drawRect(_loc2_,_loc3_);
            this.setsquaresPositions(_loc2_,_loc3_);
        }
        
        public function dispose() : void
        {
            graphics.clear();
            while(this.squares.length > 0)
            {
                removeChildAt(0);
                this.squares.shift();
            }
            this.squares = null;
        }
        
        private function drawRect(param1:Number, param2:Number) : void
        {
            graphics.clear();
            graphics.lineStyle(1,4560867);
            graphics.drawRect(0,0,param1,param2);
        }
        
        private function setsquaresPositions(param1:Number, param2:Number) : void
        {
            var _loc3_:Number = this.squares[0].width;
            var _loc4_:Number = this.squares[0].height;
            var _loc5_:Number = _loc3_ >> 1;
            var _loc6_:Number = _loc4_ >> 1;
            var _loc7_:Number = param1 >> 1;
            var _loc8_:Number = param2 >> 1;
            this.squares[1].x = _loc7_ - _loc5_;
            this.squares[1].y = 0;
            this.squares[2].x = param1 - _loc3_;
            this.squares[2].y = 0;
            this.squares[3].x = 0;
            this.squares[3].y = _loc8_ - _loc6_;
            this.squares[4].x = param1 - _loc3_;
            this.squares[4].y = _loc8_ - _loc6_;
            this.squares[5].x = 0;
            this.squares[5].y = param2 - _loc4_;
            this.squares[6].x = _loc7_ - _loc5_;
            this.squares[6].y = param2 - _loc4_;
            this.squares[7].x = param1 - _loc3_;
            this.squares[7].y = param2 - _loc4_;
        }
    }
}
