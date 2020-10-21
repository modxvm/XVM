package net.wg.gui.lobby.eventItemPackTrade.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class EventItemPackTradeVO extends DAAPIDataClass
    {

        private static const ITEMS:String = "items";

        private static const STYLES:String = "styles";

        public var backDescription:String = "";

        public var header:String = "";

        public var inStock:String = "";

        public var tokens:int = 0;

        public var oldPrice:int = 0;

        public var newPrice:int = 0;

        public var percent:int = 0;

        public var btnLabel:String = "";

        public var btnEnabled:Boolean = true;

        public var btnTooltip:String = "";

        public var infoTitle:String = "";

        public var infoDescription:String = "";

        public var infoTooltip:String = "";

        public var items:Vector.<ItemVO> = null;

        public var styles:Vector.<ItemVO> = null;

        public function EventItemPackTradeVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:Array = null;
            var _loc6_:Object = null;
            if(param1 == ITEMS)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
                this.items = new Vector.<ItemVO>(0);
                for each(_loc4_ in _loc3_)
                {
                    this.items.push(new ItemVO(_loc4_));
                }
                return false;
            }
            if(param1 == STYLES)
            {
                _loc5_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc5_,param1 + Errors.CANT_NULL);
                this.styles = new Vector.<ItemVO>(0);
                for each(_loc6_ in _loc5_)
                {
                    this.styles.push(new ItemVO(_loc6_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            var _loc2_:IDisposable = null;
            if(this.items != null)
            {
                for each(_loc1_ in this.items)
                {
                    _loc1_.dispose();
                }
                this.items.splice(0,this.items.length);
                this.items = null;
            }
            if(this.styles != null)
            {
                for each(_loc2_ in this.styles)
                {
                    _loc2_.dispose();
                }
                this.styles.splice(0,this.styles.length);
                this.styles = null;
            }
            super.onDispose();
        }
    }
}
