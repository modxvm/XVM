package net.wg.gui.lobby.techtree.helpers 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class TitleAppearance extends Object
    {
        public function TitleAppearance(arg1:flash.display.DisplayObject=null)
        {
            super();
            this.title = arg1;
            return;
        }

        public function updateInTT(arg1:Number=1024, arg2:Number=768):void
        {
            if (this.title == null) 
            {
                return;
            }
            var loc1:*=arg2 >= TITLE_SHOW_FACTOR;
            this.title.visible = loc1;
            if (loc1) 
            {
                this.update(arg1, arg2);
            }
            return;
        }

        public function updateInResearch(arg1:Number=1024, arg2:Number=768, arg3:Number=0):void
        {
            if (this.title == null) 
            {
                return;
            }
            var loc1:*;
            if (loc1 = arg2 >= TITLE_SHOW_FACTOR) 
            {
                this.update(arg1, arg2);
            }
            else 
            {
                this.title.y = arg3;
            }
            return;
        }

        public function update(arg1:Number=1024, arg2:Number=768):void
        {
            var loc2:*=NaN;
            if (this.title == null) 
            {
                return;
            }
            var loc1:*=this.title.parent == null ? this.title.stage : this.title.parent;
            if (TITLE_FIX_POSITION_FACTOR <= arg2) 
            {
                loc2 = TITLE_FIX_POSITION_Y;
            }
            else 
            {
                loc2 = Math.min(TITLE_FIX_POSITION_Y, Math.round(arg2 * TITLE_FIX_POSITION_Y / TITLE_FIX_POSITION_FACTOR));
            }
            var loc3:*=loc1.globalToLocal(new flash.geom.Point(0, loc2));
            this.title.y = loc3.y;
            this.title.width = arg1;
            return;
        }

        public function clearUp():void
        {
            this.title = null;
            return;
        }

        public static const TITLE_SHOW_FACTOR:Number=864;

        public static const TITLE_FIX_POSITION_FACTOR:Number=1007;

        public static const TITLE_FIX_POSITION_Y:Number=174;

        internal var title:flash.display.DisplayObject;
    }
}
