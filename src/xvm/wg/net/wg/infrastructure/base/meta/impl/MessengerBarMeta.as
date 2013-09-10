package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class MessengerBarMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function MessengerBarMeta()
        {
            super();
            return;
        }

        public function channelButtonClickS():void
        {
            App.utils.asserter.assertNotNull(this.channelButtonClick, "channelButtonClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.channelButtonClick();
            return;
        }

        public function contactsButtonClickS():void
        {
            App.utils.asserter.assertNotNull(this.contactsButtonClick, "contactsButtonClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.contactsButtonClick();
            return;
        }

        public var channelButtonClick:Function=null;

        public var contactsButtonClick:Function=null;
    }
}
