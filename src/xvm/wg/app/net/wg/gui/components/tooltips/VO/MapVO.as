package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class MapVO extends DAAPIDataClass
    {
        
        public function MapVO(param1:Object) {
            super(param1);
        }
        
        public var mapName:String = "";
        
        public var gameplayName:String = "";
        
        public var imageURL:String = "";
        
        public var description:String = "";
    }
}
