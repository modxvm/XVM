package net.wg.gui.lobby.hangar.maintenance.data 
{
    import net.wg.data.daapi.base.*;
    
    public class MaintenanceVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function MaintenanceVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function disposeShells():void
        {
            var loc1:*=null;
            if (this.shells) 
            {
                var loc2:*=0;
                var loc3:*=this.shells;
                for each (loc1 in loc3) 
                {
                    if (!loc1) 
                        continue;
                    loc1.dispose();
                }
                this.shells.splice(0);
                this.shells = null;
            }
            return;
        }

        public override function dispose():void
        {
            this.disposeShells();
            super.dispose();
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            if (arg1 == SHELLS_FIELD) 
            {
                this.shells = [];
                loc1 = arg2 as Array;
                loc4 = 0;
                loc5 = 0;
                var loc6:*=0;
                var loc7:*=loc1;
                for each (loc2 in loc7) 
                {
                    loc3 = new net.wg.gui.lobby.hangar.maintenance.data.ShellVO(loc2);
                    this.shells.push(loc3);
                    loc5 = loc5 + loc3.count;
                    if (loc4) 
                        continue;
                    loc4 = loc3.maxAmmo;
                }
                loc6 = 0;
                loc7 = this.shells;
                for each (loc3 in loc7) 
                {
                    loc3.possibleMax = loc4 - loc5;
                    loc3.totalLoaded = loc5;
                    loc3.list = this.shells.slice();
                    loc3.list.splice(this.shells.indexOf(loc3), 1);
                }
                return false;
            }
            return true;
        }

        protected override function onDataRead(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 == SHELLS_FIELD) 
            {
                loc1 = [];
                var loc3:*=0;
                var loc4:*=this.shells;
                for each (loc2 in loc4) 
                    loc1.push(loc2.toHash());
                arg2[arg1] = loc1;
                return false;
            }
            return true;
        }

        internal static const SHELLS_FIELD:String="shells";

        public var gold:Number;

        public var credits:Number;

        public var vehicleId:String="";

        public var repairCost:Number;

        public var maxRepairCost:Number;

        public var autoRepair:Boolean;

        public var autoShells:Boolean;

        public var autoEqip:Boolean;

        public var maxAmmo:int;

        public var casseteFieldText:String="";

        public var shells:Array=null;
    }
}
