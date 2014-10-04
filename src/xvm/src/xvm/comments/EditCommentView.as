package xvm.comments
{
    import net.wg.infrastructure.base.AbstractWindowView;

    public class EditCommentView extends AbstractWindowView
    {
        private var data:Object;

        public function EditCommentView(data)
        {
            super();

            this.width = 300;
            this.height = 300;

            this.data = data;
        }

        override protected function configUI():void
        {
            super.configUI();

            window.title = Locale.get("Comment") + ": " + data.displayName;
            window.useBottomBtns = true;
        }

        override public function handleWindowClose():void
        {
            super.handleWindowClose();
        }
    }
}
