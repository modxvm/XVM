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
            var loc2:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=this._userCount;
            this._userCount = arg1;
            var loc3:*=this.userCount;
            var loc6:*=0;
            var loc7:*=this.list;
            for each (loc2 in loc7) 
            {
                loc3 = loc3 + loc2.userCount;
                if (!(loc4 == null || loc2.userCount > loc4.userCount)) 
                    continue;
                loc4 = loc2;
            }
            if (loc3 > this.maxAmmo) 
                this._userCount = this.maxAmmo - loc3 + this.userCount;
            else 
            {
                loc5 = (loc5 = loc3 - this.maxAmmo) > 0 ? loc5 : 0;
                this.possibleMax = this.maxAmmo - loc3 + loc5 + this.userCount;
                loc6 = 0;
                loc7 = this.list;
                for each (loc2 in loc7) 
                {
                    loc2.possibleMax = this.maxAmmo - loc3 + loc5 + loc2.userCount;
                    loc2.setUserCount(loc2.userCount - (loc2 != loc4 ? 0 : loc5));
                }
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
