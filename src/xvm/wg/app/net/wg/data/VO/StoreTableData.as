package net.wg.data.VO 
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    
    public class StoreTableData extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function StoreTableData(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function set level(arg1:int):void
        {
            this._level = arg1;
            return;
        }

        public function get nation():int
        {
            return this._nation;
        }

        public function set nation(arg1:int):void
        {
            this._nation = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get disabled():String
        {
            return this._disabled;
        }

        public function set disabled(arg1:String):void
        {
            this._disabled = arg1;
            return;
        }

        public function get statusLevel():String
        {
            return this._statusLevel;
        }

        public function get inventoryCount():int
        {
            return this._inventoryCount;
        }

        public function set statusLevel(arg1:String):void
        {
            this._statusLevel = arg1;
            return;
        }

        public function get removable():Boolean
        {
            return this._removable;
        }

        public function set removable(arg1:Boolean):void
        {
            this._removable = arg1;
            return;
        }

        public function get tankType():String
        {
            return this._tankType;
        }

        public function set tankType(arg1:String):void
        {
            this._tankType = arg1;
            return;
        }

        public function get isPremium():Boolean
        {
            return this._isPremium;
        }

        public function set isPremium(arg1:Boolean):void
        {
            this._isPremium = arg1;
            return;
        }

        public function set isElite(arg1:Boolean):void
        {
            this._isElite = arg1;
            return;
        }

        public function get itemTypeName():String
        {
            return this._itemTypeName;
        }

        public function set itemTypeName(arg1:String):void
        {
            this._itemTypeName = arg1;
            return;
        }

        public function get goldShellsForCredits():Boolean
        {
            return this._goldShellsForCredits;
        }

        public function set goldShellsForCredits(arg1:Boolean):void
        {
            this._goldShellsForCredits = arg1;
            return;
        }

        public function get tableVO():net.wg.data.VO.StoreTableVO
        {
            return this._tableVO;
        }

        public function set tableVO(arg1:net.wg.data.VO.StoreTableVO):void
        {
            if (App.instance) 
            {
                App.utils.asserter.assertNotNull(arg1, "tableVO argument " + net.wg.data.constants.Errors.CANT_NULL);
                this._tableVO = arg1;
            }
            return;
        }

        public function get extraModuleInfo():String
        {
            return this._extraModuleInfo;
        }

        public function set extraModuleInfo(arg1:String):void
        {
            this._extraModuleInfo = arg1;
            return;
        }

        public function get goldEqsForCredits():Boolean
        {
            return this._goldEqsForCredits;
        }

        public function set goldEqsForCredits(arg1:Boolean):void
        {
            this._goldEqsForCredits = arg1;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        public function get requestType():String
        {
            return this._requestType;
        }

        public function set requestType(arg1:String):void
        {
            this._requestType = arg1;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get desc():String
        {
            return this._desc;
        }

        public function set desc(arg1:String):void
        {
            this._desc = arg1;
            return;
        }

        public function get inventoryId():Number
        {
            return this._inventoryId;
        }

        public function set inventoryId(arg1:Number):void
        {
            this._inventoryId = arg1;
            return;
        }

        public function get isElite():Boolean
        {
            return this._isElite;
        }

        public function set inventoryCount(arg1:int):void
        {
            this._inventoryCount = arg1;
            return;
        }

        public function get vehicleCount():int
        {
            return this._vehicleCount;
        }

        public function set vehicleCount(arg1:int):void
        {
            this._vehicleCount = arg1;
            return;
        }

        public function get credits():int
        {
            return this._credits;
        }

        public function set credits(arg1:int):void
        {
            this._credits = arg1;
            return;
        }

        public function get gold():int
        {
            return this._gold;
        }

        public function set gold(arg1:int):void
        {
            this._gold = arg1;
            return;
        }

        public function get price():Array
        {
            return this._price;
        }

        public function set price(arg1:Array):void
        {
            this._price = arg1;
            return;
        }

        public function get currency():String
        {
            return this._currency;
        }

        public function set currency(arg1:String):void
        {
            this._currency = arg1;
            return;
        }

        public function get level():int
        {
            return this._level;
        }

        internal var _extraModuleInfo:String="";

        internal var _id:String="";

        internal var _requestType:String="";

        internal var _name:String="";

        internal var _desc:String="";

        internal var _inventoryId:Number=0;

        internal var _inventoryCount:int=0;

        internal var _vehicleCount:int=0;

        internal var _gold:int=0;

        internal var _price:Array=null;

        internal var _currency:String="";

        internal var _level:int=0;

        internal var _nation:int=0;

        internal var _type:String="";

        internal var _disabled:String="";

        internal var _statusLevel:String="";

        internal var _removable:Boolean=false;

        internal var _tankType:String="";

        internal var _isPremium:Boolean=false;

        internal var _isElite:Boolean=false;

        internal var _itemTypeName:String="";

        internal var _goldShellsForCredits:Boolean=false;

        internal var _goldEqsForCredits:Boolean=false;

        internal var _tableVO:net.wg.data.VO.StoreTableVO=null;

        internal var _credits:int=0;
    }
}
