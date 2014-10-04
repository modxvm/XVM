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
            w.setWindowContent(new EditCommentView(data));
            App.utils.popupMgr.show(w);
            return w;
        }

        // CTOR

        public function EditCommentWindow()
        {
            //Logger.add("EditCommentWindow");
            super();
        }

        // OVERRIDES

        override protected function closeButtonClickHandler(param1:ButtonEvent):void
        {
            Logger.add("closeButtonClickHandler");
            super.closeButtonClickHandler(param1);
            App.utils.popupMgr.remove(this);
        }

        override protected function onDispose():void
        {
            Logger.add("dispose");
            super.onDispose();
        }

        // PRIVATE


    }
}
/*
data: {
  "userName": "M_r_A",
  "himself": false,
  "chatRoster": 1,
  "displayName": "M_r_A",
  "group": "group_2",
  "colors": "8761728,6127961",
  "online": false,
  "uid": 7294494
}
*/
