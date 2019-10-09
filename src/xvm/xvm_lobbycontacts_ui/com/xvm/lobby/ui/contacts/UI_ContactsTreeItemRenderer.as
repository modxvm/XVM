﻿/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.contacts
{
    import com.xfw.*;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.messenger.controls.ContactItem;
    import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
    import net.wg.gui.messenger.data.ITreeItemInfo;
    import scaleform.clik.constants.InvalidationType;

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
                if (isInvalid(InvalidationType.DATA))
                {
                    var myData:ITreeItemInfo = this.getData() as ITreeItemInfo;
                    if (myData)
                    {
                        if (!myData.isBrunch)
                        {
                            if (myData.data)
                            {
                                if (this.xfw_contactItem == null)
                                {
                                    this.xfw_contactItem = new UI_ContactItem();
                                }
                            }
                        }
                    }
                }

                nickImg.visible = false;
                commentImg.visible = false;

                super.draw();

                if (this.xfw_currentContentItem is ContactItem)
                {
                    var d:ContactsListTreeItemInfo = data as ContactsListTreeItemInfo;
                    if (d != null)
                    {
                        if (d.data.xvm_contact_data)
                        {
                            nickImg.visible = Boolean(d.data.xvm_contact_data.nick);
                            commentImg.visible = Boolean(d.data.xvm_contact_data.comment);
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
                source: "../maps/icons/library/pen.png",
                visible: false
            })) as UILoaderAlt;
        }
    }
}
