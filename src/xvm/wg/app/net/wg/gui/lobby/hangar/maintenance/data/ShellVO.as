package net.wg.gui.lobby.hangar.maintenance.data 
{
    import net.wg.data.daapi.base.*;
    import net.wg.gui.events.*;
    
    public class ShellVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ShellVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get userCount():int
        {
            return this._userCount;
        }

        public function set userCount(arg1:int):void
        {
            var loc1:*=null;
            var loc3:*=null;
            this._userCount = arg1;
            var loc2:*=this.userCount;
            var loc5:*=0;
            var loc6:*=this.list;
            for each (loc1 in loc6) 
            {
                loc2 = loc2 + loc1.userCount;
                if (!(loc3 == null || loc1.userCount > loc3.userCount)) 
                {
                    continue;
                }
                loc3 = loc1;
            }
            if (loc2 > this.maxAmmo) 
            {
                this._userCount = this._userCount - (loc2 - this.maxAmmo);
                loc2 = loc2 - (loc2 - this.maxAmmo);
            }
            var loc4:*=(loc4 = loc2 - this.maxAmmo) > 0 ? loc4 : 0;
            this.possibleMax = this.maxAmmo - loc2 + loc4 + this.userCount;
            loc5 = 0;
            loc6 = this.list;
            for each (loc1 in loc6) 
            {
                loc1.possibleMax = this.maxAmmo - loc2 + loc4 + loc1.userCount;
                loc1.setUserCount(loc1.userCount - (loc1 != loc3 ? 0 : loc4));
            }
            dispatchEvent(new net.wg.gui.events.ShellRendererEvent(net.wg.gui.events.ShellRendererEvent.USER_COUNT_CHANGED));
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            if (arg1 == USER_COUNT_FIELD) 
            {
                this.setUserCount(int(arg2));
                return false;
            }
            return true;
        }

        public function setUserCount(arg1:int):void
        {
            this._userCount = arg1;
            dispatchEvent(new net.wg.gui.events.ShellRendererEvent(net.wg.gui.events.ShellRendererEvent.USER_COUNT_CHANGED));
            return;
        }

        public function get price():int
        {
            var loc1:*=this.currency != "credits" ? 1 : 0;
            return this.prices[loc1];
        }

        public function get buyShellsCount():int
        {
            var loc1:*=this.count - this.userCount + this.inventoryCount;
            return loc1 < 0 ? -loc1 : 0;
        }

        public override function dispose():void
        {
            if (this.prices) 
            {
                this.prices.splice(0);
                this.prices = null;
            }
            if (this.list) 
            {
                this.list.splice(0);
                this.list = null;
            }
            super.dispose();
            return;
        }

        internal static const USER_COUNT_FIELD:String="userCount";

        public var id:String="";

        public var compactDescr:int;

        public var type:String="";

        public var icon:String="";

        public var count:int;

        public var step:int;

        public var inventoryCount:int;

        public var goldShellsForCredits:Boolean;

        public var prices:Array=null;

        public var currency:String="";

        public var ammoName:String="";

        public var tableName:String="";

        public var maxAmmo:int;

        public var list:Array=null;

        public var possibleMax:int;

        public var totalLoaded:int;

        internal var _userCount:int;
    }
}
