package net.wg.gui.cyberSport.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class AutoSearchVO extends DAAPIDataClass
    {
        
        public function AutoSearchVO(param1:Object)
        {
            super(param1);
        }
        
        public var state:String = "";
        
        public var countDownSeconds:int = 0;
        
        public var contextMessage:String = "";
        
        public var playersReadiness:Array;
        
        public var canInvokeAutoSearch:Boolean = false;
        
        public var canInvokeBattleQueue:Boolean = false;
    }
}
