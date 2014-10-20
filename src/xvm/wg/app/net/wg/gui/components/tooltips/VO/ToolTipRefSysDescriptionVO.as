package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ToolTipRefSysDescriptionVO extends DAAPIDataClass
    {
        
        public function ToolTipRefSysDescriptionVO(param1:Object)
        {
            super(param1);
        }
        
        private static var BLOCKS_VOS:String = "blocksVOs";
        
        public var titleTF:String = "";
        
        public var actionTF:String = "";
        
        public var conditionsTF:String = "";
        
        public var awardsTitleTF:String = "";
        
        public var bottomTF:String = "";
        
        public var blocksVOs:Vector.<ToolTipRefSysAwardsBlockVO> = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == BLOCKS_VOS && !(param2 == null))
            {
                _loc3_ = param2 as Array;
                this.blocksVOs = new Vector.<ToolTipRefSysAwardsBlockVO>();
                for each(_loc4_ in _loc3_)
                {
                    this.blocksVOs.push(new ToolTipRefSysAwardsBlockVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ToolTipRefSysAwardsBlockVO = null;
            for each(_loc1_ in this.blocksVOs)
            {
                _loc1_.dispose();
            }
            this.blocksVOs.splice(0,this.blocksVOs.length);
            this.titleTF = null;
            this.actionTF = null;
            this.conditionsTF = null;
            this.awardsTitleTF = null;
            this.bottomTF = null;
            super.onDispose();
        }
    }
}
