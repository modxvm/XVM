package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    
    public class TransportingVO extends DAAPIDataClass
    {
        
        public function TransportingVO(param1:Object)
        {
            super(param1);
        }
        
        private static var SOURCE_BASE_VO:String = "sourceBaseVO";
        
        private static var TARGET_BASE_VO:String = "targetBaseVO";
        
        public var sourceBaseVO:BuildingBaseVO = null;
        
        public var targetBaseVO:BuildingBaseVO = null;
        
        public var maxTransportingSize:uint = 0;
        
        public var defResTep:uint = 0;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if([SOURCE_BASE_VO,TARGET_BASE_VO].indexOf(param1) != -1)
            {
                this[param1] = new BuildingBaseVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            this.sourceBaseVO.dispose();
            this.sourceBaseVO = null;
            this.targetBaseVO.dispose();
            this.targetBaseVO = null;
            super.onDispose();
        }
    }
}
