package net.wg.gui.lobby.demonstration.data 
{
    import net.wg.data.daapi.base.*;
    import scaleform.clik.data.*;
    
    public class DemonstratorVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function DemonstratorVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get standard():scaleform.clik.data.DataProvider
        {
            return this._standard;
        }

        public function set standard(arg1:scaleform.clik.data.DataProvider):void
        {
            this._standard = arg1;
            return;
        }

        public function get assault():scaleform.clik.data.DataProvider
        {
            return this._assault;
        }

        public function set assault(arg1:scaleform.clik.data.DataProvider):void
        {
            this._assault = arg1;
            return;
        }

        public function get encounter():scaleform.clik.data.DataProvider
        {
            return this._encounter;
        }

        public function set encounter(arg1:scaleform.clik.data.DataProvider):void
        {
            this._encounter = arg1;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this._standard.cleanUp();
            this._assault.cleanUp();
            this._encounter.cleanUp();
            this._standard = null;
            this._assault = null;
            this._encounter = null;
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "standard":
                case "assault":
                case "encounter":
                {
                    this[arg1] = this.convertToDataProvider(arg2 as Array);
                    return false;
                }
                default:
                {
                    return true;
                }
            }
        }

        internal function convertToDataProvider(arg1:Array):scaleform.clik.data.DataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                loc1.push(new net.wg.gui.lobby.demonstration.data.MapItemVO(loc2));
            }
            return loc1;
        }

        internal var _standard:scaleform.clik.data.DataProvider;

        internal var _assault:scaleform.clik.data.DataProvider;

        internal var _encounter:scaleform.clik.data.DataProvider;
    }
}
