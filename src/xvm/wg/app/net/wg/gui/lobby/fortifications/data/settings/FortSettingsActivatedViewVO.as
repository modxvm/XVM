package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortSettingsActivatedViewVO extends DAAPIDataClass
    {
        
        public function FortSettingsActivatedViewVO(param1:Object)
        {
            super(param1);
        }
        
        private static var PEREPHERY_CONTAINER_VO:String = "perepheryContainerVO";
        
        private static var SETTINGS_BLOCKS_VO:String = "settingsBlockVOs";
        
        public var perepheryContainerVO:PeripheryContainerVO = null;
        
        public var settingsBlockVOs:Vector.<FortSettingsBlockVO> = null;
        
        public var canDisableDefencePeriod:Boolean = true;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:FortSettingsBlockVO = null;
            if(param1 == SETTINGS_BLOCKS_VO && !(param2 == null))
            {
                this.settingsBlockVOs = new Vector.<FortSettingsBlockVO>();
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new FortSettingsBlockVO(_loc4_);
                    this.settingsBlockVOs.push(_loc5_);
                }
                return false;
            }
            if(param1 == PEREPHERY_CONTAINER_VO)
            {
                this.perepheryContainerVO = new PeripheryContainerVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            if(this.settingsBlockVOs)
            {
                this.settingsBlockVOs.splice(0,this.settingsBlockVOs.length);
                this.settingsBlockVOs = null;
            }
            super.onDispose();
        }
    }
}
