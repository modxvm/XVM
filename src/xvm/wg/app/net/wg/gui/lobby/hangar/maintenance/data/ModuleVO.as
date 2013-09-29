package net.wg.gui.lobby.hangar.maintenance.data 
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    
    public class ModuleVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ModuleVO(arg1:Object)
        {
            super(arg1);
            this._originalHash = arg1;
            return;
        }

        public function clone(arg1:int):net.wg.gui.lobby.hangar.maintenance.data.ModuleVO
        {
            var loc1:*=new net.wg.gui.lobby.hangar.maintenance.data.ModuleVO(this._originalHash);
            loc1.slotIndex = arg1;
            return loc1;
        }

        public function get status():String
        {
            return this.target == 1 && !(this.slotIndex == this.index) ? MENU.MODULEFITS_WRONG_SLOT : this.fits[this.slotIndex];
        }

        public function get price():int
        {
            return this.prices[this.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0];
        }

        public override function dispose():void
        {
            this.prices.splice(0);
            this.fits.splice(0);
            this._originalHash = null;
            super.dispose();
            return;
        }

        internal var _originalHash:Object;

        public var id:String="";

        public var name:String="";

        public var desc:String="";

        public var target:int;

        public var compactDescr:int;

        public var prices:Array=null;

        public var currency:String="";

        public var icon:String="";

        public var index:int;

        public var slotIndex:int=0;

        public var inventoryCount:int;

        public var vehicleCount:int;

        public var count:int;

        public var fits:Array=null;

        public var goldEqsForCredits:Boolean;
    }
}
