package xvm.comments
{
    import com.xvm.*;
    import com.xvm.components.*;
    import net.wg.gui.components.windows.*;
    import net.wg.infrastructure.base.*;
    import scaleform.clik.events.*;

    public dynamic class EditCommentWindow extends WindowUI
    {
        // PUBLIC STATIC

        public static function show(data:Object):EditCommentWindow
        {
            var w:EditCommentWindow = new EditCommentWindow();
            var v:EditCommentView = new EditCommentView(data);
            v.setWindow(w);
            w.setWindowContent(v);
            App.utils.popupMgr.show(w);
            return w;
        }

        // CTOR

        public function EditCommentWindow()
        {
            //Logger.add("EditCommentWindow");
            super();
            this.useBottomBtns = true;
        }

        // OVERRIDES

        override protected function closeButtonClickHandler(param1:ButtonEvent):void
        {
            dispose();
            App.utils.popupMgr.remove(this);
        }

        override protected function onDispose():void
        {
            //Logger.add("dispose");
            super.onDispose();
        }
    }
}
