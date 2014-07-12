package net.wg.gui.lobby.dialogs
{
    public class ItemStatusData extends Object
    {
        
        public function ItemStatusData(param1:String = null, param2:Boolean = false) {
            super();
            this.id = param1;
            this.status = param2;
        }
        
        public var id:String;
        
        public var status:Boolean;
    }
}
