package xvm.comments.UI
{
    import com.xvm.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.prebattle.invites.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    import xvm.comments.*;
    import xvm.comments.editors.*;

    public dynamic class UI_ContactsListForm extends ContactsListFormUI
    {
        public function UI_ContactsListForm()
        {
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            initAccordion();
            this.accordion.addEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
        }

        override protected function onDispose():void
        {
            super.onDispose();
            this.accordion.removeEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
        }

        override public function update(data:Object):void
        {
            super.update(data);
            if (data)
                updateViewData();
        }

        override protected function draw():void
        {
            if (isInvalid("invalidateView"))
                this.updateViewData();
            super.draw();
        }

        // PRIVATE

        private function initAccordion():void
        {
            var dp:Array = [
                { "label": MESSENGER.DIALOGS_CONTACTS_TREE_FRIENDS, "linkage": getQualifiedClassName(UI_ContactsFriendsRoster) },
                { "label": MESSENGER.DIALOGS_CONTACTS_TREE_CLAN,    "linkage": getQualifiedClassName(UI_ContactsClanRoster) },
                { "label": MESSENGER.DIALOGS_CONTACTS_TREE_IGNORED, "linkage": getQualifiedClassName(UI_ContactsIgnoredRoster) }];
            if (App.voiceChatMgr.isVOIPEnabledS())
                dp.push({ "label": MESSENGER.DIALOGS_CONTACTS_TREE_MUTED, "linkage": getQualifiedClassName(UI_ContactsMutedRoster) });
            this.accordion.dataProvider = new DataProvider(dp);
        }

        private function updateViewData() : void
        {
            var v:IViewStackContent = this.accordion.view.currentView as IViewStackContent;
            if (v != null)
            {
                if (v is UI_ContactsFriendsRoster)
                    v.update(this.friendsDP);
                else if (v is UI_ContactsClanRoster)
                    v.update(this.clanDP);
                else if (v is UI_ContactsIgnoredRoster)
                    v.update(this.ignoredDP);
                else if (v is UI_ContactsMutedRoster)
                    v.update(this.mutedDP);
            }
        }

        private function showContextMenu(e:SendInvitesEvent) : void
        {
/* TODO:0.9.6            if (e.initItem)
            {
                var menu:IContextMenu = App.contextMenuMgr.showUserContextMenu(this, e.initItem, new PrbSendInviteCIGeneratorX());
                DisplayObject(menu).addEventListener(ContextMenuEvent.ON_ITEM_SELECT, this.onContextMenuAction);
            }*/
        }

        private function onContextMenuAction(e:ContextMenuEvent):void
        {
            switch (e.id)
            {
                case PrbSendInviteCIGeneratorX.M_EDITDATA:
                    EditDataWindow.show(new EditDataView(e.memberItemData));
                    break;
            }
        }
    }
}
