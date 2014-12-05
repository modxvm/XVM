package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class IntelligenceClanFilterVO extends DAAPIDataClass
    {
        
        public function IntelligenceClanFilterVO(param1:Object)
        {
            super(param1);
        }
        
        public var minClanLevel:int = -1;
        
        public var maxClanLevel:int = -1;
        
        public var startDefenseHour:int = -1;
        
        public var yourOwnClanStartDefenseHour:int = -1;
        
        public var isWrongLocalTime:Boolean = false;
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
    }
}
