/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments.UI
{
    import com.xvm.*;
    //import com.xvm.utils.*;
    import flash.display.*;
    //import flash.events.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    //import net.wg.gui.messenger.controls.ContactItem;
    //import net.wg.gui.messenger.data.*;
    //import net.wg.infrastructure.interfaces.IUserProps;
    //import scaleform.clik.constants.*;
    //import scaleform.clik.core.UIComponent;
    //import xvm.comments.*;
    //import xvm.comments.data.*;

    public class UI_ContactItem extends ContactItemUI
    {
        private var panel:Sprite = null;
        private var nickImg:UILoaderAlt = null;
        private var commentImg:UILoaderAlt = null;

        public function UI_ContactItem()
        {
            //Logger.add("UI_ContactItem");
            super();
            /*
            if (nickImg == null)
                createControls();*/
        }

        override protected function draw():void
        {
            /*panel.x = width - x + 32;

            nickImg.visible = true;
            commentImg.visible = true;*/
            super.draw();
            /*try
            {
                // check
                if (!isInvalid(InvalidationType.DATA))
                {
                    super.draw();
                    return;
                }

                var nickImg_visible:Boolean = false;
                var commentImg_visible:Boolean = false;

                var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
                if (!d)
                {
                    super.draw();
                    return;
                }

                var id:Number = d.id as Number;
                if (d.isBrunch || !id)
                {
                    super.draw();
                    return;
                }

                // prepare
                d.data.xvm_comment = null;
                d.data.xvm_originalUserName = null;
                d.data.xvm_userName = null;

                var pd:PlayerCommentData = CommentsGlobalData.instance.getPlayerData(id);
                if (pd == null)
                {
                    super.draw();
                    return;
                }

                if (pd.nick != null && pd.nick != "")
                {
                    nickImg_visible = true;
                    d.data.xvm_originalUserName = d.data.userProps.userName;
                    d.data.xvm_userName = pd.nick;
                }

                if (pd.comment != null && pd.comment != "")
                {
                    commentImg_visible = true;
                    d.data.xvm_comment = pd.comment;
                }

                // draw
                nickImg.visible = nickImg_visible;
                commentImg.visible = commentImg_visible;

                super.draw();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }*/
        }

        // PRIVATE

        /*private function createControls():void
        {
            panel = this.addChildAt(new Sprite(), 0) as Sprite;

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
        }*/
    }
}
