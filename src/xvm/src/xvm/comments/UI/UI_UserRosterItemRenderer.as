package xvm.comments.UI
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.MouseEvent;
    import net.wg.gui.events.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import xvm.comments.*;

    public dynamic class UI_UserRosterItemRenderer extends UserRosterItemRendererUI
    {
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

                super.draw();
                if (_baseDisposed)
                    return;

                if (dataDirty)
                {
                    var comment:String = CommentsGlobalData.instance.getComment(data.uid);
                    commentImg.visible = comment != null;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override protected function handleMouseRollOver(param1:MouseEvent):void
        {
            super.handleMouseRollOver(param1);
            var comment:String = CommentsGlobalData.instance.getComment(data.uid);
            if (comment != null)
                App.toolTipMgr.show(data.displayName + "\n<font color='" + Utils.toHtmlColor(Defines.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(comment) + "</font>");
        }

        // PRIVATE

        private function createControls():void
        {
            this.textField.width -= 16;

            this.commentImg = this.addChildAt(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: this.actualWidth - 16,
                width: 16,
                height:16,
                alpha: 0.5,
                source: "../maps/icons/messenger/service_channel_icon.png"
            }), 0) as UILoaderAlt;
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
