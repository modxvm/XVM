package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class EquipmentParamVO extends DAAPIDataClass
    {
        
        public function EquipmentParamVO(param1:Object) {
            super(param1);
        }
        
        public var headerText:String = "";
        
        public var params:Array;
    }
}
