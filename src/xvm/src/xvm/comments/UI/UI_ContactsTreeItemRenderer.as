/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments.UI
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import net.wg.gui.messenger.controls.ContactItem;
    import net.wg.gui.messenger.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;

    public class UI_ContactsTreeItemRenderer extends ContactsTreeItemRendererUI
    {
        public function UI_ContactsTreeItemRenderer()
        {
            //Logger.add("UI_ContactsTreeItemRenderer");
            super();
        }

        override protected function draw():void
        {
            try
            {
                //Logger.addObject(data, 3);

                if (isInvalid(InvalidationType.DATA))
                {
                    var myData:ITreeItemInfo = this.getData() as ITreeItemInfo;
                    if (myData && !myData.isBrunch && myData.data != null)
                    {
                        if (this.xvm_contactItem == null)
                        {
                            this.xvm_contactItem = new UI_ContactItem();
                        }
                    }
                }

                super.draw();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);

            var currentContentItem:UIComponent = this.getCurrentContentItem();
            if (!(currentContentItem is ContactItem))
                return;

            var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
            if (!d)
                return;

            var comment:String = d.data.xvm_contact_data.comment;
            if (!comment)
                return;

            //App.toolTipMgr.show(d.data.userPropsVO.userName + "\n" +
            //    "<font color='" + Utils.toHtmlColor(Defines.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(comment) + "</font>");
        }
    }
}
/*
data: { // net.wg.gui.messenger.data::ContactsListTreeItemInfo
  "id": 13494688,
  "isBrunch": false,
  "isOpened": false,
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
    "xvm_contact_data": {
      "nick": "nick",
      "comment": "comment"
    },
    "dbID": 7027996
  },
  "gui": { "id": 13494688 },
  "parent": {...}, // net.wg.gui.messenger.data::ContactsListTreeItemInfo
  "children": null,
  "parentItemData": null
}
*/

