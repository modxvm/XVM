package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class AwardWindowVO extends DAAPIDataClass
    {
        
        public function AwardWindowVO(param1:Object)
        {
            super(param1);
        }
        
        public var backImage:String = "";
        
        public var awardImage:String = "";
        
        public var windowTitle:String = "";
        
        public var header:String = "";
        
        public var description:String = "";
        
        public var additionalText:String = "";
    }
}
