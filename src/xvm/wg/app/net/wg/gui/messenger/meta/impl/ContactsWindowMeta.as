package net.wg.gui.messenger.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ContactsWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ContactsWindowMeta()
        {
            super();
            return;
        }

        public function searchContactS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.searchContact, "searchContact" + net.wg.data.constants.Errors.CANT_NULL);
            this.searchContact(arg1);
            return;
        }

        public function addToFriendsS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.addToFriends, "addToFriends" + net.wg.data.constants.Errors.CANT_NULL);
            this.addToFriends(arg1, arg2);
            return;
        }

        public function addToIgnoredS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.addToIgnored, "addToIgnored" + net.wg.data.constants.Errors.CANT_NULL);
            this.addToIgnored(arg1, arg2);
            return;
        }

        public var searchContact:Function=null;

        public var addToFriends:Function=null;

        public var addToIgnored:Function=null;
    }
}
