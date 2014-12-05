package net.wg.gui.lobby.header
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleSelectDropDownVO extends DAAPIDataClass
    {
        
        public function BattleSelectDropDownVO(param1:Object)
        {
            super(param1);
        }
        
        public var label:String = "";
        
        public var data:String = "";
        
        public var disabled:Boolean;
        
        public var description:String = "";
        
        public var icon:String = "";
        
        public var active:Boolean;
        
        public var isNew:Boolean;
        
        public function get enabled() : Boolean
        {
            return !this.disabled;
        }
    }
}
