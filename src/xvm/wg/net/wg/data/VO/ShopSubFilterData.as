package net.wg.data.VO 
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    import scaleform.clik.data.*;
    
    public class ShopSubFilterData extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ShopSubFilterData(arg1:Object)
        {
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=null;
            if (arg1 == "dataProvider") 
            {
                if (App.instance) 
                {
                    App.utils.asserter.assert(arg2 is Array, "value must extends an Array class.");
                }
                if (this._dataProvider) 
                {
                    this._dataProvider.cleanUp();
                }
                else 
                {
                    this._dataProvider = new scaleform.clik.data.DataProvider();
                }
                var loc2:*=0;
                var loc3:*=arg2;
                for each (loc1 in loc3) 
                {
                    this._dataProvider.push(new net.wg.data.VO.ShopVehicleFilterElementData(loc1));
                }
                return false;
            }
            return true;
        }

        public function get dataProvider():scaleform.clik.data.DataProvider
        {
            return this._dataProvider;
        }

        public function get current():String
        {
            return this._current;
        }

        public function set current(arg1:String):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = "invalid current value for filter data: " + arg1;
                if (arg1 == null) 
                {
                    DebugUtils.LOG_WARNING("value \"current\" for filter data" + net.wg.data.constants.Errors.CANT_NULL);
                }
                App.utils.asserter.assert(!(arg1 == "0"), loc1);
            }
            this._current = arg1;
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

        public function get requestTypes():Array
        {
            return this._requestTypes;
        }

        public function set requestTypes(arg1:Array):void
        {
            this._requestTypes = arg1;
            return;
        }

        public function get kind():String
        {
            return this._kind;
        }

        public function set kind(arg1:String):void
        {
            this._kind = arg1;
            return;
        }

        public function get fitsType():String
        {
            return this._fitsType;
        }

        public function set fitsType(arg1:String):void
        {
            this._fitsType = arg1;
            return;
        }

        internal var _current:String="";

        internal var _dataProvider:scaleform.clik.data.DataProvider=null;

        internal var _nation:int=-1;

        internal var _kind:String="";

        internal var _requestTypes:Array=null;

        internal var _fitsType:String="";
    }
}
