package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class StatisticsLabelDataVO extends DAAPIDataClass
    {
        
        public function StatisticsLabelDataVO(param1:Object)
        {
            super(param1);
        }
        
        public var label:String = "";
        
        public var data:Object;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "data")
            {
                this.parceData(param2);
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        protected function parceData(param1:Object) : void
        {
            this.data = param1;
        }
    }
}
