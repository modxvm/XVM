package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class ProfileWindowMeta extends AbstractWindowView
    {
        
        public function ProfileWindowMeta() {
            super();
        }
        
        public var userAddFriend:Function = null;
        
        public var userSetIgnored:Function = null;
        
        public var userCreatePrivateChannel:Function = null;
        
        public function userAddFriendS() : void {
            App.utils.asserter.assertNotNull(this.userAddFriend,"userAddFriend" + Errors.CANT_NULL);
            this.userAddFriend();
        }
        
        public function userSetIgnoredS() : void {
            App.utils.asserter.assertNotNull(this.userSetIgnored,"userSetIgnored" + Errors.CANT_NULL);
            this.userSetIgnored();
        }
        
        public function userCreatePrivateChannelS() : void {
            App.utils.asserter.assertNotNull(this.userCreatePrivateChannel,"userCreatePrivateChannel" + Errors.CANT_NULL);
            this.userCreatePrivateChannel();
        }
    }
}
