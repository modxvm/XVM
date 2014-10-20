package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ReferralReferrerIntroVO extends DAAPIDataClass
    {
        
        public function ReferralReferrerIntroVO(param1:Object)
        {
            super(param1);
        }
        
        private static var BLOCKSVOS:String = "blocksVOs";
        
        public var titleMsg:String = "";
        
        public var blocksVOs:Vector.<ReferralTextBlockVO> = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:ReferralTextBlockVO = null;
            if(param1 == BLOCKSVOS && !(param2 == null))
            {
                if(this.blocksVOs == null)
                {
                    this.blocksVOs = new Vector.<ReferralTextBlockVO>();
                }
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new ReferralTextBlockVO(_loc4_);
                    this.blocksVOs.push(_loc5_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ReferralTextBlockVO = null;
            if(this.blocksVOs)
            {
                for each(_loc1_ in this.blocksVOs)
                {
                    _loc1_.dispose();
                }
                this.blocksVOs.splice(0,this.blocksVOs.length);
                this.blocksVOs = null;
            }
            this.titleMsg = null;
            super.onDispose();
        }
    }
}
