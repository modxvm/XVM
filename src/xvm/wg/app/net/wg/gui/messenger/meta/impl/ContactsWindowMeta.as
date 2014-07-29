package net.wg.gui.messenger.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class ContactsWindowMeta extends AbstractWindowView
    {
        
        public function ContactsWindowMeta()
        {
            super();
        }
        
        public var searchContact:Function = null;
        
        public var addToFriends:Function = null;
        
        public var addToIgnored:Function = null;
        
        public var isEnabledInRoaming:Function = null;
        
        public function searchContactS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.searchContact,"searchContact" + Errors.CANT_NULL);
            this.searchContact(param1);
        }
        
        public function addToFriendsS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.addToFriends,"addToFriends" + Errors.CANT_NULL);
            this.addToFriends(param1,param2);
        }
        
        public function addToIgnoredS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.addToIgnored,"addToIgnored" + Errors.CANT_NULL);
            this.addToIgnored(param1,param2);
        }
        
        public function isEnabledInRoamingS(param1:Number) : Boolean
        {
            App.utils.asserter.assertNotNull(this.isEnabledInRoaming,"isEnabledInRoaming" + Errors.CANT_NULL);
            return this.isEnabledInRoaming(param1);
        }
    }
}
