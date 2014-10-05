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
            try
            {
                var w:EditCommentWindow = new EditCommentWindow();
                var v:EditCommentView = new EditCommentView(data);
                v.setWindow(w);
                w.setWindowContent(v);
                App.utils.popupMgr.show(w);
                return w;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return null;
        }

        // CTOR

        public function EditCommentWindow()
        {
            //Logger.add("EditCommentWindow");
            super();
            this.useTabs = true;
            this.useBottomBtns = true;
            this.title = Locale.get("Edit comment");
            addEventListener(ComponentEvent.HIDE, close);
        }

        // PUBLIC

        public function close():void
        {
            App.utils.popupMgr.remove(this);
            dispose();
        }
    }
}
