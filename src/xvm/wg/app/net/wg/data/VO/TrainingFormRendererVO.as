package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class TrainingFormRendererVO extends DAAPIDataClass
    {
        
        public function TrainingFormRendererVO(param1:Object)
        {
            super(param1);
        }
        
        public var creatorIgrType:int = 0;
        
        public var creatorClan:String = "";
        
        public var creatorRegion:String = "";
        
        public var creatorName:String = "";
        
        public var comment:String = "";
        
        public var arena:String = "";
        
        public var count:Number = 0;
        
        public var total:Number = 0;
        
        public var owner:String = "";
        
        public var icon:String = "";
        
        public var disabled:Boolean;
        
        public var id:Number = 0;
    }
}
