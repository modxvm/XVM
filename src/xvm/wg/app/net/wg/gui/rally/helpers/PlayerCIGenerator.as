package net.wg.gui.rally.helpers
{
    import net.wg.data.components.ContextItemGenerator;
    import org.idmedia.as3commons.util.Map;
    import net.wg.data.daapi.PlayerInfo;
    
    public class PlayerCIGenerator extends ContextItemGenerator
    {
        
        public function PlayerCIGenerator(param1:Boolean = false, param2:Boolean = false)
        {
            this.isCommander = param1;
            this.canGiveLeadership = param2;
            super();
        }
        
        public var isCommander:Boolean;
        
        public var canGiveLeadership:Boolean;
        
        override protected function createSimpleDataIDs(param1:PlayerInfo, param2:String, param3:String, param4:String, param5:String, param6:Boolean = false) : Map
        {
            var _loc7_:Map = super.createSimpleDataIDs(param1,param2,param3,param4,param5,param6);
            if(this.isCommander)
            {
                _loc7_.put("kickPlayerFromUnit",{});
                _loc7_.put("giveLeadership",{"enabled":this.canGiveLeadership});
            }
            return _loc7_;
        }
    }
}
