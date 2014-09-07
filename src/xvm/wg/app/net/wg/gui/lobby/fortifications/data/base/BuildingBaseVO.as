package net.wg.gui.lobby.fortifications.data.base
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BuildingBaseVO extends DAAPIDataClass
    {
        
        public function BuildingBaseVO(param1:Object)
        {
            super(param1);
        }
        
        public var defResVal:int = 0;
        
        public var hpVal:int = 0;
        
        public var buildingLevel:int = 0;
        
        public var uid:String = "";
        
        public var maxHpValue:uint = 0;
        
        public var maxDefResValue:uint = 0;
        
        public var animationType:int = -1;
    }
}
