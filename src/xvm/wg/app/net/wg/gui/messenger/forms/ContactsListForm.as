package net.wg.gui.messenger.forms
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.components.advanced.Accordion;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.prebattle.invites.SendInvitesEvent;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator;
    import flash.utils.getQualifiedClassName;
    import flash.display.InteractiveObject;
    
    public class ContactsListForm extends UIComponent implements IViewStackContent
    {
        
        public function ContactsListForm()
        {
            super();
        }
        
        private static var FRIENDS_ROSTER:String = "ContactsFriendsRosterUI";
        
        private static var CLAN_ROSTER:String = "ContactsClanRosterUI";
        
        private static var IGNORED_ROSTER:String = "ContactsIgnoredRosterUI";
        
        private static var MUTED_ROSTER:String = "ContactsMutedRosterUI";
        
        private static var INVALIDATE_VIEW:String = "invalidateView";
        
        public var accordion:Accordion;
        
        public var friendsDP:DAAPIDataProvider;
        
        public var clanDP:DAAPIDataProvider;
        
        public var ignoredDP:DAAPIDataProvider;
        
        public var mutedDP:DAAPIDataProvider;
        
        public function update(param1:Object) : void
        {
            if(param1)
            {
                this.friendsDP = param1.friendsDP;
                this.clanDP = param1.clanDP;
                this.ignoredDP = param1.ignoredDP;
                this.mutedDP = param1.mutedDP;
                this.updateViewData();
            }
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.accordion.removeEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
            this.accordion.removeEventListener(IndexEvent.INDEX_CHANGE,this.onViewChanged);
            if(this.friendsDP)
            {
                this.friendsDP.cleanUp();
                this.friendsDP = null;
            }
            if(this.clanDP)
            {
                this.clanDP.cleanUp();
                this.clanDP = null;
            }
            if(this.ignoredDP)
            {
                this.ignoredDP.cleanUp();
                this.ignoredDP = null;
            }
            if(this.mutedDP)
            {
                this.mutedDP.cleanUp();
                this.mutedDP = null;
            }
            if(this.accordion.dataProvider)
            {
                this.accordion.dataProvider.cleanUp();
                this.accordion.dataProvider = null;
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement("accordion",this.accordion,Constraints.ALL);
            this.accordion.addEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
            this.accordion.addEventListener(IndexEvent.INDEX_CHANGE,this.onViewChanged);
            this.initAccordion();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((constraints) && (isInvalid(InvalidationType.SIZE)))
            {
                constraints.update(_width,_height);
                this.updateViewSize();
            }
            if(isInvalid(INVALIDATE_VIEW))
            {
                this.updateViewData();
                this.updateViewSize();
            }
        }
        
        private function initAccordion() : void
        {
            var _loc1_:Array = [{"label":MESSENGER.DIALOGS_CONTACTS_TREE_FRIENDS,
            "linkage":FRIENDS_ROSTER
        },{"label":MESSENGER.DIALOGS_CONTACTS_TREE_CLAN,
        "linkage":CLAN_ROSTER
    },{"label":MESSENGER.DIALOGS_CONTACTS_TREE_IGNORED,
    "linkage":IGNORED_ROSTER
}];
if(App.voiceChatMgr.isVOIPEnabledS())
{
    _loc1_.push({"label":MESSENGER.DIALOGS_CONTACTS_TREE_MUTED,
    "linkage":MUTED_ROSTER
});
}
this.accordion.view.cache = true;
this.accordion.dataProvider = new DataProvider(_loc1_);
this.accordion.selectedIndex = 0;
}

private function onViewChanged(param1:IndexEvent) : void
{
invalidate(INVALIDATE_VIEW);
}

private function showContextMenu(param1:SendInvitesEvent) : void
{
if(param1.initItem)
{
App.contextMenuMgr.showUserContextMenu(this,param1.initItem,new PrbSendInviteCIGenerator());
}
}

private function updateViewData() : void
{
var _loc2_:String = null;
var _loc3_:DAAPIDataProvider = null;
var _loc1_:IViewStackContent = this.accordion.view.currentView as IViewStackContent;
if(_loc1_ != null)
{
_loc2_ = getQualifiedClassName(_loc1_);
switch(_loc2_)
{
    case FRIENDS_ROSTER:
        _loc3_ = this.friendsDP;
        break;
    case CLAN_ROSTER:
        _loc3_ = this.clanDP;
        break;
    case IGNORED_ROSTER:
        _loc3_ = this.ignoredDP;
        break;
    case MUTED_ROSTER:
        _loc3_ = this.mutedDP;
        break;
}
if(_loc3_)
{
    _loc1_.update(_loc3_);
}
}
}

private function updateViewSize() : void
{
var _loc1_:String = null;
var _loc2_:UIComponent = null;
for(_loc1_ in this.accordion.view.cachedViews)
{
_loc2_ = this.accordion.view.cachedViews[_loc1_] as UIComponent;
_loc2_.setSize(this.accordion.actualViewWidth,this.accordion.actualViewHeight);
if(_loc2_ == this.accordion.view.currentView)
{
    _loc2_.validateNow();
}
}
}

public function getComponentForFocus() : InteractiveObject
{
return null;
}

public function canShowAutomatically() : Boolean
{
return true;
}
}
}
