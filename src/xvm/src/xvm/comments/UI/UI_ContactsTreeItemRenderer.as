/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments.UI
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import net.wg.gui.messenger.data.*;
    import scaleform.clik.constants.*;
    import xvm.comments.*;
    import xvm.comments.data.*;

    public class UI_ContactsTreeItemRenderer extends ContactsTreeItemRendererUI
    {
        private var nickImg:UILoaderAlt = null;
        private var commentImg:UILoaderAlt = null;

        public function UI_ContactsTreeItemRenderer()
        {
            //Logger.add("UI_ContactsTreeItemRenderer");
            super();

            createControls();
        }

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.DATA))
            {
                var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
                if (d)
                {
                    var id:Number = d.id as Number;
                    if (d.isBrunch || !id)
                    {
                        nickImg.visible = false;
                        commentImg.visible = false;
                    }
                    else
                    {
                        try
                        {
                            var pd:PlayerCommentData = CommentsGlobalData.instance.getPlayerData(id);

                            if (pd != null)
                            {
                                if (pd.nick != null)
                                {
                                    d.data.xvm_originalUserName = d.data.userProps.userName;
                                    //d.data.userProps.userName = pd.nick;
                                    d.data.xvm_userName = pd.nick;
                                }

                                if (pd.comment != null)
                                {
                                    d.data.xvm_comment = pd.comment;
                                }
                            }
                            nickImg.visible = pd != null && pd.nick != null && pd.nick != "";
                            commentImg.visible = pd != null && pd.comment != null && pd.comment != "";
                        }
                        catch (ex:Error)
                        {
                            Logger.add(ex.getStackTrace());
                        }
                    }
                }
            }

            super.draw();
        }

        override protected function handleMouseRollOver(param1:MouseEvent):void
        {
            super.handleMouseRollOver(param1);
            var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
            if (!d)
                return;

            var comment:String = d.data.xvm_comment;
            if (!comment)
                return;

            //var userPropsVO:IUserProps = new ContactItemVO(d.data).userPropsVO;
            //var userName:String = App.utils.commons.getFullPlayerName(userPropsVO);
            var userName:String = d.data.xvm_originalUserName || d.data.userProps.userName;
            App.toolTipMgr.show(userName +
                (comment == null ? "" : "\n<font color='" + Utils.toHtmlColor(Defines.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(comment) + "</font>"));
        }

        // PRIVATE

        private function createControls():void
        {
            var mc:Sprite = this.addChildAt(new Sprite(), 0) as Sprite;
            mc.x = width - 32;

            this.nickImg = mc.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 6,
                y: 3,
                width: 10,
                height: 20,
                alpha: 0.5,
                source: "../maps/icons/messenger/iconContacts.png"
            })) as UILoaderAlt;

            this.commentImg = mc.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 14,
                y: 4,
                width: 16,
                height: 16,
                alpha: 0.5,
                source: "../maps/icons/messenger/service_channel_icon.png"
            })) as UILoaderAlt;
        }
    }
}
/*
data: { // net.wg.gui.messenger.data::ContactsListTreeItemInfo
  "parent": { // net.wg.gui.messenger.data::ContactsListTreeItemInfo
    "parent": null,
    "isBrunch": false,
    "isOpened": false,
    "children": null,
    "data": "[object Object]",
    "gui": "[object Object]",
    "id": 0,
    "parentItemData": null
  },
  "isBrunch": false,
  "isOpened": false,
  "children": null,
  "data": {
    "isOnline": false,
    "userProps": {
      "rgb": 5263440,
      "userName": "Tracks_Destroyer_RU",
      "tags": [
        "sub/none",
        "friend"
      ],
      "clanAbbrev": null,
      "region": null,
      "suffix": " <IMG SRC='img://gui/maps/icons/messenger/contactConfirmNeeded.png' width='16' height='16' vspace='-6' hspace='0'/>"
    },
    "note": "",
    "dbID": 7027996
  },
  "gui": {
    "id": 13494688
  },
  "id": 13494688,
  "parentItemData": null
}
*/

