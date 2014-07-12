package net.wg.gui.lobby.techtree.helpers
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class TitleAppearance extends Object
    {
        
        public function TitleAppearance(param1:DisplayObject = null) {
            super();
            this.title = param1;
        }
        
        public static var TITLE_SHOW_FACTOR:Number = 864;
        
        public static var TITLE_FIX_POSITION_FACTOR:Number = 1007;
        
        public static var TITLE_FIX_POSITION_Y:Number = 174;
        
        private var title:DisplayObject;
        
        public function updateInTT(param1:Number = 1024, param2:Number = 768) : void {
            if(this.title == null)
            {
                return;
            }
            var _loc3_:* = param2 >= TITLE_SHOW_FACTOR;
            this.title.visible = _loc3_;
            if(_loc3_)
            {
                this.update(param1,param2);
            }
        }
        
        public function updateInResearch(param1:Number = 1024, param2:Number = 768, param3:Number = 0) : void {
            if(this.title == null)
            {
                return;
            }
            var _loc4_:* = param2 >= TITLE_SHOW_FACTOR;
            if(_loc4_)
            {
                this.update(param1,param2);
            }
            else
            {
                this.title.y = param3;
            }
        }
        
        public function update(param1:Number = 1024, param2:Number = 768) : void {
            var _loc4_:* = NaN;
            if(this.title == null)
            {
                return;
            }
            var _loc3_:DisplayObject = this.title.parent != null?this.title.parent:this.title.stage;
            if(TITLE_FIX_POSITION_FACTOR <= param2)
            {
                _loc4_ = TITLE_FIX_POSITION_Y;
            }
            else
            {
                _loc4_ = Math.min(TITLE_FIX_POSITION_Y,Math.round(param2 * TITLE_FIX_POSITION_Y / TITLE_FIX_POSITION_FACTOR));
            }
            var _loc5_:Point = _loc3_.globalToLocal(new Point(0,_loc4_));
            this.title.y = _loc5_.y;
            this.title.width = param1;
        }
        
        public function clearUp() : void {
            this.title = null;
        }
    }
}
