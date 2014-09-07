package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortFixedPlayersVO extends DAAPIDataClass
    {
        
        public function FortFixedPlayersVO(param1:Object)
        {
            super(param1);
        }
        
        private static var ROSTERS:String = "rosters";
        
        public var buildingId:int = -1;
        
        public var windowTitle:String = "";
        
        public var buttonLbl:String = "";
        
        public var isEnableBtn:Boolean = false;
        
        public var isVisibleBtn:Boolean = false;
        
        public var countLabel:String = "";
        
        public var playerIsAssigned:String = "";
        
        public var btnTooltipData:String = "";
        
        public var rosters:Array = null;
        
        public var generalTooltipData:String = "";
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:ClanListRendererVO = null;
            if(param1 == ROSTERS)
            {
                this.rosters = [];
                for each(_loc3_ in param2)
                {
                    _loc4_ = new ClanListRendererVO(_loc3_);
                    this.rosters.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
