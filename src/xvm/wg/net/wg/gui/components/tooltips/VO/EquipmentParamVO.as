package net.wg.gui.components.tooltips.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class EquipmentParamVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function EquipmentParamVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var headerText:String="";

        public var params:Array;
    }
}
