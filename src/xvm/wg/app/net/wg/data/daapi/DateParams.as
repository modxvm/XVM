package net.wg.data.daapi
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class DateParams extends DAAPIDataClass
    {
        
        public function DateParams(param1:Object)
        {
            super(param1);
        }
        
        public var year:int = -1;
        
        public var month:int = -1;
        
        public var date:int = -1;
        
        public var hour:int = -1;
        
        public var minute:int = -1;
        
        public var second:int = -1;
        
        public var millisecond:int = -1;
    }
}
