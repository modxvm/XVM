package net.wg.gui.lobby.profile.pages.summary 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class LineTextFieldsLayout extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function LineTextFieldsLayout(arg1:uint, arg2:int)
        {
            this.leftPairs = new Vector.<Array>();
            this.rightPairs = new Vector.<Array>();
            super();
            this._maxWidth = arg1;
            this._centerAreaWidth = arg2;
            return;
        }

        public function layout():void
        {
            this.applyGap(this.leftPairs);
            this.applyGap(this.rightPairs, (this._maxWidth + this._centerAreaWidth) / 2);
            return;
        }

        internal function applyGap(arg1:__AS3__.vec.Vector.<Array>, arg2:int=0):void
        {
            var loc4:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc1:*=arg1.length;
            var loc2:*=flash.display.DisplayObject(arg1[0][0]).width;
            var loc3:*=Math.round(((this._maxWidth - this._centerAreaWidth) / 2 - loc1 * loc2) / (loc1 + 1));
            var loc5:*=0;
            while (loc5 < loc1) 
            {
                loc7 = (loc4 = arg1[loc5]).length;
                loc8 = 0;
                while (loc8 < loc7) 
                {
                    (loc6 = loc4[loc8]).x = arg2 + loc3 + loc5 * (loc2 + loc3);
                    ++loc8;
                }
                ++loc5;
            }
            return;
        }

        public function addLeftPair(arg1:flash.display.DisplayObject, arg2:flash.display.DisplayObject):void
        {
            this.leftPairs.push([arg1, arg2]);
            return;
        }

        public function addRightPair(arg1:flash.display.DisplayObject, arg2:flash.display.DisplayObject):void
        {
            this.rightPairs.push([arg1, arg2]);
            return;
        }

        public function set maxWidth(arg1:uint):void
        {
            this._maxWidth = arg1;
            return;
        }

        public function set centerAreaWidth(arg1:int):void
        {
            this._centerAreaWidth = arg1;
            return;
        }

        public function dispose():void
        {
            while (this.leftPairs.length > 0) 
            {
                this.leftPairs.splice((this.leftPairs.length - 1), 1);
            }
            while (this.rightPairs.length > 0) 
            {
                this.rightPairs.splice((this.rightPairs.length - 1), 1);
            }
            return;
        }

        internal var _maxWidth:uint;

        internal var _centerAreaWidth:int;

        internal var leftPairs:__AS3__.vec.Vector.<Array>;

        internal var rightPairs:__AS3__.vec.Vector.<Array>;
    }
}
