package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class AccountPopoverBlockVo extends DAAPIDataClass
    {
        
        public function AccountPopoverBlockVo(param1:Object)
        {
            super(param1);
        }
        
        public var formation:String = "";
        
        public var formationName:String = "";
        
        public var position:String = "";
        
        public var emblemId:String = "";
        
        public var btnLabel:String = "";
        
        public var btnEnabled:Boolean = false;
    }
}
