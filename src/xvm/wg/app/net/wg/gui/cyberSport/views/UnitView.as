package net.wg.gui.cyberSport.views
{
    import net.wg.infrastructure.base.meta.impl.CyberSportUnitMeta;
    import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.cyberSport.views.unit.TeamSection;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.gui.cyberSport.views.unit.WaitListSection;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import fl.transitions.easing.Strong;
    
    public class UnitView extends CyberSportUnitMeta implements ICyberSportUnitMeta
    {
        
        public function UnitView()
        {
            this.tweens = new Vector.<Tween>();
            super();
        }
        
        private static var ANIMATION_DELAY:uint = 700;
        
        private static var CHANGE_UNIT_STATE:int = 24;
        
        private static var SET_PLAYER_STATE:int = 6;
        
        private static var CLOSE_SLOT:int = 17;
        
        public var rosterTeamSection:RosterSettingsView;
        
        public var rosterTeamContext:Boolean = false;
        
        private var tweens:Vector.<Tween>;
        
        private var isRosterSettingsVisible:Boolean = false;
        
        public function preInitFadeAnimationCancel() : void
        {
            this.initFadeAnimation();
            cancelRosterSlotsSettingsS();
        }
        
        public function as_setOpened(param1:Boolean, param2:String) : void
        {
            if(rallyData)
            {
                waitingListSection.updateRallyStatus(param1,param2);
            }
        }
        
        public function as_setTotalLabel(param1:Boolean, param2:String, param3:int) : void
        {
            if(rallyData)
            {
                this.unitTeamSection.updateTotalLabel(param1,param2,param3);
            }
        }
        
        public function as_closeSlot(param1:uint, param2:uint, param3:String) : void
        {
            if(rallyData)
            {
                this.unitTeamSection.closeSlot(param1,false,param2,param3,true,-1);
            }
        }
        
        public function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint) : void
        {
            if(rallyData)
            {
                this.unitTeamSection.closeSlot(param1,param2,0,param3,false,param4);
            }
        }
        
        public function as_lockUnit(param1:Boolean, param2:Array) : void
        {
            if(rallyData)
            {
                this.unitTeamSection.updateLockedUnit(param1,param2);
            }
        }
        
        public function as_updateSlotSettings(param1:Array) : void
        {
            this.rosterTeamSection.setSelectedSettings = param1;
        }
        
        public function get unitTeamSection() : TeamSection
        {
            return teamSection as TeamSection;
        }
        
        override protected function getRallyViewAlias() : String
        {
            return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
        }
        
        override protected function getRallyVO(param1:Object) : IRallyVO
        {
            return new RallyVO(param1);
        }
        
        override protected function getTitleStr() : String
        {
            return CYBERSPORT.WINDOW_UNIT_UNITNAME;
        }
        
        override protected function coolDownControls(param1:Boolean, param2:int) : void
        {
            if(param2 == CHANGE_UNIT_STATE)
            {
                (waitingListSection as WaitListSection).enableCloseButton(param1);
                this.unitTeamSection.enableFreezeButton(param1);
                chatSection.enableEditCommitButton(param1);
            }
            else if(param2 == SET_PLAYER_STATE)
            {
                teamSection.enableFightButton(param1);
            }
            else if(param2 == CLOSE_SLOT)
            {
                teamSection.cooldownSlots(param1);
            }
            
            
            super.coolDownControls(param1,param2);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.rosterTeamSection.alpha = 0;
            this.rosterTeamSectionMouseEnabled = false;
            addEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequest);
            addEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequest);
            addEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequest);
            addEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onConfigureClick);
            addEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.showSettingsRosterWndHandler);
            addEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.applyRosterSettings);
            addEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.cancelRosterSettings);
            titleLbl.text = Values.EMPTY_STR;
            descrLbl.text = CYBERSPORT.WINDOW_UNIT_DESCRIPTION;
            backBtn.label = CYBERSPORT.WINDOW_UNIT_LEAVE;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequest);
            removeEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequest);
            removeEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onConfigureClick);
            removeEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.showSettingsRosterWndHandler);
            removeEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.applyRosterSettings);
            removeEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.cancelRosterSettings);
            removeEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequest);
            this.rosterTeamSection.dispose();
            this.rosterTeamSection = null;
            super.onDispose();
        }
        
        override protected function onChooseVehicleRequest(param1:RallyViewsEvent) : void
        {
            if(!this.rosterTeamContext)
            {
                chooseVehicleRequestS();
            }
        }
        
        private function initFadeAnimation() : void
        {
            if(!this.isRosterSettingsVisible)
            {
                this.fadeIn();
            }
            else
            {
                this.fadeOut();
            }
        }
        
        private function fadeIn() : void
        {
            var _loc1_:Array = rallyData.slotsArray;
            if(_loc1_)
            {
                this.rosterTeamSection.setData(_loc1_);
            }
            this.rosterTeamSection.animationIn();
            this.rosterTeamSectionMouseEnabled = true;
            this.playAnimation({"alpha":0});
        }
        
        private function fadeOut() : void
        {
            this.rosterTeamSection.animationOut();
            this.rosterTeamSectionMouseEnabled = false;
            this.playAnimation({"alpha":1});
        }
        
        private function playAnimation(param1:Object) : void
        {
            this.cleanTweens();
            this.tweens = Vector.<Tween>([new Tween(ANIMATION_DELAY,waitingListSection,param1,{"paused":false,
            "ease":Strong.easeOut,
            "onComplete":null
        }),new Tween(ANIMATION_DELAY,teamSection,param1,{"paused":false,
        "ease":Strong.easeOut,
        "onComplete":null
    }),new Tween(ANIMATION_DELAY,chatSection,param1,{"paused":false,
    "ease":Strong.easeOut,
    "onComplete":null
})]);
}

private function cleanTweens() : void
{
var _loc1_:Tween = null;
if(this.tweens)
{
    for each(_loc1_ in this.tweens)
    {
        _loc1_.paused = true;
        _loc1_ = null;
    }
}
}

private function set rosterTeamSectionMouseEnabled(param1:Boolean) : void
{
this.isRosterSettingsVisible = param1;
this.rosterTeamSection.mouseEnabled = param1;
this.rosterTeamSection.mouseChildren = param1;
teamSection.mouseEnabled = !param1;
teamSection.mouseChildren = !param1;
waitingListSection.mouseEnabled = !param1;
waitingListSection.mouseChildren = !param1;
chatSection.mouseEnabled = !param1;
chatSection.mouseChildren = !param1;
this.rosterTeamContext = param1;
}

private function onConfigureClick(param1:CSComponentEvent) : void
{
this.initFadeAnimation();
}

private function onToggleFreezeRequest(param1:CSComponentEvent) : void
{
toggleFreezeRequestS();
}

private function onToggleStatusRequest(param1:CSComponentEvent) : void
{
toggleStatusRequestS();
}

private function applyRosterSettings(param1:CSComponentEvent) : void
{
resultRosterSlotsSettingsS(this.rosterTeamSection.getSettingsResults());
this.initFadeAnimation();
}

private function cancelRosterSettings(param1:CSComponentEvent) : void
{
this.preInitFadeAnimationCancel();
}

private function showSettingsRosterWndHandler(param1:CSComponentEvent) : void
{
if(this.rosterTeamContext)
{
    showSettingsRosterS(param1.data);
}
}

private function onLockSlotRequest(param1:CSComponentEvent) : void
{
lockSlotRequestS(param1.data);
}
}
}
