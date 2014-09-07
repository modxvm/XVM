package net.wg.gui.lobby.messengerBar
{
    import net.wg.infrastructure.base.meta.impl.ContactsListButtonMeta;
    import net.wg.infrastructure.base.meta.IContactsListButtonMeta;
    import scaleform.clik.constants.InvalidationType;
    
    public class ContactsListButton extends ContactsListButtonMeta implements IContactsListButtonMeta
    {
        
        public function ContactsListButton()
        {
            super();
        }
        
        public var button:MessengerIconButton;
        
        private var _contactsCount:int = 0;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.button.tooltip = TOOLTIPS.LOBY_MESSENGER_CONTACTS_BUTTON;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.button.label = this._contactsCount > 0?this._contactsCount.toString():"";
            }
        }
        
        public function as_setContactsCount(param1:Number) : void
        {
            this._contactsCount = param1;
            invalidateData();
        }
    }
}
