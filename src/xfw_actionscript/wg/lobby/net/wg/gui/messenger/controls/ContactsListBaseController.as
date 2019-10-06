package net.wg.gui.messenger.controls
{
    import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
    import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
    import net.wg.gui.messenger.evnts.ContactsTreeEvent;
    import flash.display.InteractiveObject;

    public class ContactsListBaseController extends DropListDelegateCtrlr
    {

        public function ContactsListBaseController(param1:Vector.<InteractiveObject>, param2:Class, param3:String)
        {
            super(param1,param2,param3);
        }

        protected function fireDragStartEvent(param1:Number) : void
        {
            var _loc2_:IDropListDelegate = null;
            var _loc3_:ContactsTreeEvent = null;
            for each(_loc2_ in _delegates)
            {
                _loc3_ = new ContactsTreeEvent(ContactsTreeEvent.CONTACT_DRAG_START);
                _loc3_.data = param1;
                _loc2_.getHitArea().dispatchEvent(_loc3_);
            }
        }

        protected function fireDragEndEvent() : void
        {
            var _loc1_:IDropListDelegate = null;
            var _loc2_:ContactsTreeEvent = null;
            for each(_loc1_ in _delegates)
            {
                _loc2_ = new ContactsTreeEvent(ContactsTreeEvent.CONTACT_DRAG_END);
                _loc1_.getHitArea().dispatchEvent(_loc2_);
            }
        }
    }
}
