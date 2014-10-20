package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ToolTipRefSysXPMultiplierVO extends DAAPIDataClass
    {
        
        public function ToolTipRefSysXPMultiplierVO(param1:Object)
        {
            super(param1);
        }
        
        private static var XP_BLOCKS_VOS:String = "xpBlocksVOs";
        
        public var titleText:String = "";
        
        public var descriptionText:String = "";
        
        public var conditionsText:String = "";
        
        public var bottomText:String = "";
        
        public var xpBlocksVOs:Vector.<ToolTipRefSysXPMultiplierBlockVO> = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == XP_BLOCKS_VOS && !(param2 == null))
            {
                _loc3_ = param2 as Array;
                this.xpBlocksVOs = new Vector.<ToolTipRefSysXPMultiplierBlockVO>();
                for each(_loc4_ in _loc3_)
                {
                    this.xpBlocksVOs.push(new ToolTipRefSysXPMultiplierBlockVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ToolTipRefSysXPMultiplierBlockVO = null;
            for each(_loc1_ in this.xpBlocksVOs)
            {
                _loc1_.dispose();
            }
            this.xpBlocksVOs.splice(0,this.xpBlocksVOs.length);
            this.titleText = null;
            this.descriptionText = null;
            this.conditionsText = null;
            this.bottomText = null;
            super.onDispose();
        }
    }
}
