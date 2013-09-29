package net.wg.gui.lobby.dialogs 
{
    public class ItemStatusData extends Object
    {
        public function ItemStatusData(arg1:String=null, arg2:Boolean=false)
        {
            super();
            this.id = arg1;
            this.status = arg2;
            return;
        }

        public var id:String;

        public var status:Boolean;
    }
}
