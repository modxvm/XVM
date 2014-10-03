package xvm.comments.UI
{
    import com.xvm.*;

    public dynamic class UI_ContactsListForm extends ContactsListFormUI
    {
        public function UI_ContactsListForm()
        {
            //Logger.add("UI_ContactsListForm");
            super();
        }

        override protected function draw():void
        {
            super.draw();
            //Logger.addObject(this.friendsDP);
        }
    }
}
