package net.wg.gui.lobby.hangar.tcarousel 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class ClanLockUI extends scaleform.clik.core.UIComponent
    {
        public function ClanLockUI()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.textField.text = this.updateClanLock();
            return;
        }

        public function set timer(arg1:Number):void
        {
            this._timer = arg1;
            invalidate();
            return;
        }

        public function get timer():Number
        {
            return this._timer;
        }

        internal function updateClanLock():String
        {
            var loc1:*="";
            var loc2:*=new Date();
            var loc3:*=Math.round(this._timer - loc2.valueOf() / 1000);
            if (loc3 > 0) 
            {
                loc1 = this.calcLockTime(loc3);
                this.visible = true;
            }
            else 
                this.visible = false;
            return loc1;
        }

        internal function calcLockTime(arg1:Number):String
        {
            var loc1:*="";
            arg1 = Math.ceil(arg1 / 60);
            var loc2:*=Math.floor(arg1 / 60);
            var loc3:*=Math.floor(arg1 - loc2 * 60);
            var loc4:*=loc2 < 10 ? "0" + loc2 : loc2.toString();
            var loc5:*=loc3 < 10 ? "0" + loc3 : loc3.toString();
            loc1 = loc4 + ":" + loc5;
            return loc1;
        }

        public override function toString():String
        {
            return "[WG ClanLockUi " + name + "]";
        }

        public var textField:flash.text.TextField;

        internal var _timer:Number;
    }
}
