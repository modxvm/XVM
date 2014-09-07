package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class PeripheryPopoverVO extends DAAPIDataClass
    {
        
        public function PeripheryPopoverVO(param1:Object)
        {
            super(param1);
        }
        
        public var descriptionText:String = "";
        
        public var serverText:String = "";
        
        public var applyBtnLabel:String = "";
        
        public var cancelBtnLabel:String = "";
        
        public var servers:Array = null;
        
        public var currentServer:int = -1;
        
        override protected function onDispose() : void
        {
            this.descriptionText = null;
            this.serverText = null;
            this.applyBtnLabel = null;
            this.cancelBtnLabel = null;
            this.servers.splice(0,this.servers.length);
            this.servers = null;
        }
    }
}
