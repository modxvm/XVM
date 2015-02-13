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
    import net.wg.gui.messenger.controls.ContactItem;
    import net.wg.gui.messenger.data.*;
    import net.wg.infrastructure.interfaces.IUserProps;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.UIComponent;
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
        }

        override protected function draw():void
        {
            try
            {
                if (isInvalid(InvalidationType.DATA))
                {
                    var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
                    if (d)
                    {
                        var id:Number = d.id as Number;
                        if (!d.isBrunch && id)
                        {
                            // prepare
                            d.data.xvm_comment = null;
                            d.data.xvm_originalUserName = null;
                            d.data.xvm_userName = null;

                            var pd:PlayerCommentData = CommentsGlobalData.instance.getPlayerData(id);
                            if (pd != null)
                            {
                                if (pd.nick != null && pd.nick != "")
                                {
                                    d.data.xvm_originalUserName = d.data.userProps.userName;
                                    d.data.xvm_userName = pd.nick;
                                }

                                if (pd.comment != null && pd.comment != "")
                                {
                                    d.data.xvm_comment = pd.comment;
                                }
                            }
                        }
                    }
                }

                // draw
                super.draw();
return;

                var contactItem:ContactItem = this.getCurrentContentItem() as ContactItem;
                if (contactItem is ContactItemUI && !(contactItem is UI_ContactItem))
                {
                    var ci:ContactItem = this.xvm_contactItem;
                    this.xvm_contactItem = new UI_ContactItem();
                    this.xvm_contactItem.x = ci.x;
                    removeChild(ci);
                    addChild(this.xvm_contactItem);
                    this.xvm_currentContentItem = this.xvm_contactItem;
                    this.xvm_contactItem.update(data.data);
                    this.xvm_contactItem.validateNow();
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
return;
            var currentContentItem:UIComponent = this.getCurrentContentItem();
            if (!(currentContentItem is ContactItem))
                return;

            var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
            if (!d)
                return;

            var comment:String = d.data.xvm_comment;
            if (!comment)
                return;

            var userName:String = d.data.xvm_originalUserName || d.data.userPropsVO.userName;
            App.toolTipMgr.show(userName +
                (comment == null ? "" : "\n<font color='" + Utils.toHtmlColor(Defines.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(comment) + "</font>"));
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

