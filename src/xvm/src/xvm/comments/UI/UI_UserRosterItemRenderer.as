package xvm.comments.UI
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.events.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import xvm.comments.*;
    import xvm.comments.data.*;

    public dynamic class UI_UserRosterItemRenderer extends UserRosterItemRendererUI
    {
        private var nickImg:UILoaderAlt = null;
        private var commentImg:UILoaderAlt = null;

        public function UI_UserRosterItemRenderer()
        {
            //Logger.add("UI_UserRosterItemRenderer");
            super();

            createControls();
        }

        override protected function draw():void
        {
            try
            {
                //Logger.add("draw");
                var dataDirty:Boolean = isInvalid("update_data") && data;

                if (_baseDisposed)
                    return;

                //Logger.addObject(data);

                if (dataDirty)
                {
                    var pd:PlayerCommentData = CommentsGlobalData.instance.getPlayerData(data.uid);

                    if (pd != null && pd.nick != null)
                    {
                        data.originalDisplayName = data.displayName;
                        data.displayName = pd.nick;
                    }
                    nickImg.visible = pd != null && pd.nick != null && pd.nick != "";
                    commentImg.visible = pd != null && pd.comment != null && pd.comment != "";
                }

                super.draw();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override protected function handleMouseRollOver(param1:MouseEvent):void
        {
            super.handleMouseRollOver(param1);
            var pd:PlayerCommentData = CommentsGlobalData.instance.getPlayerData(data.uid);
            if (pd != null)
            {
                var comment:String = pd.comment;
                App.toolTipMgr.show((data.originalDisplayName || data.displayName) +
                    (pd.comment == null ? "" : "\n<font color='" + Utils.toHtmlColor(Defines.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(pd.comment) + "</font>"));
            }
        }

        // PRIVATE

        private function createControls():void
        {
            var mc:Sprite = this.addChildAt(new Sprite(), 0) as Sprite;
            mc.x = this.actualWidth - 24;
            mc.width = 24;
            mc.scaleX = 1 / scaleX;
            mc.scaleY = 1 / scaleY;

            this.nickImg = mc.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 12,
                width: 5,
                height:16,
                alpha: 0.5,
                //source: "../maps/icons/library/okIcon.png"
                source: "../maps/icons/messenger/iconContacts.png"
            })) as UILoaderAlt;

            this.commentImg = mc.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 16,
                width: 16,
                height:16,
                alpha: 0.5,
                source: "../maps/icons/messenger/service_channel_icon.png"
            })) as UILoaderAlt;
        }
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
