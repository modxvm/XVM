/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.contacts.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import net.wg.gui.messenger.controls.*;
    import net.wg.gui.messenger.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;

    public class UI_ContactsTreeItemRenderer extends ContactsTreeItemRendererUI
    {
        private var panel:Sprite = null;
        private var nickImg:UILoaderAlt = null;
        private var commentImg:UILoaderAlt = null;

        public function UI_ContactsTreeItemRenderer()
        {
            //Logger.add("UI_ContactsTreeItemRenderer");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            createControls();
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
                        if (this.xfw_contactItem == null)
                        {
                            this.xfw_contactItem = new UI_ContactItem();
                        }
                    }
                }

                nickImg.visible = false;
                commentImg.visible = false;

                super.draw();

                if (this.xfw_currentContentItem is ContactItem)
                {
                    var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
                    if (d && d.data.xvm_contact_data)
                    {
                        var nick:String = d.data.xvm_contact_data.nick;
                        var comment:String = d.data.xvm_contact_data.comment;
                        nickImg.visible = nick != null && nick != "";
                        commentImg.visible = comment != null && comment != "";
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);

            var currentContentItem:UIComponent = this.getCurrentContentItem();
            if (!(currentContentItem is ContactItem))
                return;

            var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
            if (!d || !d.data.xvm_contact_data)
                return;

            var comment:String = d.data.xvm_contact_data.comment;
            if (!comment)
                return;

            App.toolTipMgr.show(d.data.userProps.userName + "\n\n" +
                "<font color='" + XfwUtils.toHtmlColor(XfwConst.UICOLOR_LABEL) + "'>" + Utils.fixImgTag(comment) + "</font>");
        }

        // PRIVATE

        private function createControls():void
        {
            panel = this.addChildAt(new Sprite(), 0) as Sprite;
            panel.x = width - 34;

            this.nickImg = panel.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 6,
                y: 3,
                width: 10,
                height: 20,
                alpha: 0.5,
                source: "../maps/icons/messenger/iconContacts.png",
                visible: false
            })) as UILoaderAlt;

            this.commentImg = panel.addChild(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                x: 14,
                y: 4,
                width: 16,
                height: 16,
                alpha: 0.5,
                source: "../maps/icons/messenger/service_channel_icon.png",
                visible: false
            })) as UILoaderAlt;
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

