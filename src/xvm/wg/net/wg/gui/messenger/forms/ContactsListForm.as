package net.wg.gui.messenger.forms 
{
    import flash.utils.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.prebattle.invites.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ContactsListForm extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function ContactsListForm()
        {
            super();
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1) 
            {
                this.friendsDP = arg1.friendsDP;
                this.clanDP = arg1.clanDP;
                this.ignoredDP = arg1.ignoredDP;
                this.mutedDP = arg1.mutedDP;
                this.updateViewData();
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.accordion.removeEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SHOW_CONTEXT_MENU, this.showContextMenu);
            this.accordion.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onViewChanged);
            if (this.friendsDP) 
            {
                this.friendsDP.cleanUp();
                this.friendsDP = null;
            }
            if (this.clanDP) 
            {
                this.clanDP.cleanUp();
                this.clanDP = null;
            }
            if (this.ignoredDP) 
            {
                this.ignoredDP.cleanUp();
                this.ignoredDP = null;
            }
            if (this.mutedDP) 
            {
                this.mutedDP.cleanUp();
                this.mutedDP = null;
            }
            if (this.accordion.dataProvider) 
            {
                this.accordion.dataProvider.cleanUp();
                this.accordion.dataProvider = null;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("accordion", this.accordion, scaleform.clik.utils.Constraints.ALL);
            this.accordion.addEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SHOW_CONTEXT_MENU, this.showContextMenu);
            this.accordion.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onViewChanged);
            this.initAccordion();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (constraints && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
                this.updateViewSize();
            }
            if (isInvalid(INVALIDATE_VIEW)) 
            {
                this.updateViewData();
                this.updateViewSize();
            }
            return;
        }

        internal function initAccordion():void
        {
            var loc1:*=[{"label":MESSENGER.DIALOGS_CONTACTS_TREE_FRIENDS, "linkage":FRIENDS_ROSTER}, {"label":MESSENGER.DIALOGS_CONTACTS_TREE_CLAN, "linkage":CLAN_ROSTER}, {"label":MESSENGER.DIALOGS_CONTACTS_TREE_IGNORED, "linkage":IGNORED_ROSTER}];
            if (App.voiceChatMgr.isVOIPEnabledS()) 
                loc1.push({"label":MESSENGER.DIALOGS_CONTACTS_TREE_MUTED, "linkage":MUTED_ROSTER});
            this.accordion.view.cache = true;
            this.accordion.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            this.accordion.selectedIndex = 0;
            return;
        }

        internal function onViewChanged(arg1:scaleform.clik.events.IndexEvent):void
        {
            invalidate(INVALIDATE_VIEW);
            return;
        }

        internal function showContextMenu(arg1:net.wg.gui.prebattle.invites.SendInvitesEvent):void
        {
            if (arg1.initItem) 
                App.contextMenuMgr.showUserContextMenu(this, arg1.initItem, new net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator());
            return;
        }

        internal function updateViewData():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.accordion.view.currentView as net.wg.infrastructure.interfaces.IViewStackContent;
            if (loc1 != null) 
            {
                loc2 = flash.utils.getQualifiedClassName(loc1);
                var loc4:*=loc2;
                switch (loc4) 
                {
                    case FRIENDS_ROSTER:
                        loc3 = this.friendsDP;
                        break;
                    case CLAN_ROSTER:
                        loc3 = this.clanDP;
                        break;
                    case IGNORED_ROSTER:
                        loc3 = this.ignoredDP;
                        break;
                    case MUTED_ROSTER:
                        loc3 = this.mutedDP;
                        break;
                    default:
                        break;
                }
                if (loc3) 
                    loc1.update(loc3);
            }
            return;
        }

        internal function updateViewSize():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.accordion.view.cachedViews;
            for (loc1 in loc4) 
            {
                loc2 = this.accordion.view.cachedViews[loc1] as scaleform.clik.core.UIComponent;
                loc2.setSize(this.accordion.actualViewWidth, this.accordion.actualViewHeight);
                if (loc2 != this.accordion.view.currentView) 
                    continue;
                loc2.validateNow();
            }
            return;
        }

        internal static const FRIENDS_ROSTER:String="ContactsFriendsRosterUI";

        internal static const CLAN_ROSTER:String="ContactsClanRosterUI";

        internal static const IGNORED_ROSTER:String="ContactsIgnoredRosterUI";

        internal static const MUTED_ROSTER:String="ContactsMutedRosterUI";

        internal static const INVALIDATE_VIEW:String="invalidateView";

        public var accordion:net.wg.gui.components.advanced.Accordion;

        public var friendsDP:net.wg.data.daapi.base.DAAPIDataProvider;

        public var clanDP:net.wg.data.daapi.base.DAAPIDataProvider;

        public var ignoredDP:net.wg.data.daapi.base.DAAPIDataProvider;

        public var mutedDP:net.wg.data.daapi.base.DAAPIDataProvider;
    }
}
