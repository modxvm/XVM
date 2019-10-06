package net.wg.gui.messenger.data
{
    public class ContactListMainInfo extends Object
    {

        public var dbID:Number;

        public var name:String;

        public function ContactListMainInfo(param1:String, param2:Number)
        {
            super();
            this.dbID = param2;
            this.name = param1;
        }
    }
}
