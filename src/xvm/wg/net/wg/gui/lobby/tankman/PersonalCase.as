package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class PersonalCase extends net.wg.gui.lobby.tankman.PersonalCaseBase
    {
        public function PersonalCase()
        {
            super();
            isModal = false;
            isCentered = true;
            canClose = true;
            showWindowBg = false;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            App.utils.focusHandler.setFocus(this);
            return;
        }

        public override function as_setCommonData(arg1:Object):void
        {
            super.as_setCommonData(arg1);
            if (isFirtsRun) 
            {
                this.tabs.selectedIndex = autoSelectTab;
                this.runtimeShowByIndex(autoSelectTab);
                isFirtsRun = false;
            }
            return;
        }

        public override function as_setDossierData(arg1:Object):void
        {
            super.as_setDossierData(arg1);
            return;
        }

        public override function as_setRetrainingData(arg1:Object):void
        {
            super.as_setRetrainingData(arg1);
            return;
        }

        internal function initSkillsCarousel():void
        {
            if (!this.skills_mc.visible) 
            {
                this.skills_mc.visible = true;
                this.skills_mc.slotImageHeight = SKILLS_CAROUSEL_ITEM_SIDE;
                this.skills_mc.slotImageWidth = SKILLS_CAROUSEL_ITEM_SIDE;
                this.skills_mc.margin = SKILLS_CAROUSEL_ITEM_MARGIN;
                this.addChild(this.skills_mc);
                this.skills_mc.x = SKILLS_CAROUSEL_POSITION.x;
                this.skills_mc.y = SKILLS_CAROUSEL_POSITION.y;
                if (!this.skills_mc.hasEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO)) 
                    this.skills_mc.addEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO, this.changeTabToTwoHandler);
            }
            this.isUpdateList = true;
            invalidate(UPDATE_SCROLLING_LIST);
            return;
        }

        protected override function updateCommonElements():void
        {
            var loc1:*=App.utils;
            this.currentNation = loc1.nations.getNationName(data.nationID);
            data.wg_freeXpToTankman = App.globalVarsMgr.isFreeXpToTankmanS();
            this.tankmanInBattle = !(data.currentVehicle == null) && data.currentVehicle.currentVehicleLocked;
            this.initializeSkillBtn(this.tankmanInBattle);
            if (this.skillsBtn.visible) 
                this.skills_mc.visible = false;
            else 
                this.initSkillsCarousel();
            this.initializeDropSkillsButton(this.__isEnableDropSkillsButton());
            if (data.wg_freeXpToTankman && data.skills.length > 0 && data.skillsCountForLearn == 0 && Number(data.specializationLevel) == 100) 
            {
                this.accTeachingOfSkillBtn.visible = true;
                this.accTeachingOfSkillBtn.enabled = true;
                this.accTeachingOfSkillBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onTeachSkillBtnClick);
            }
            else 
            {
                this.accTeachingOfSkillBtn.visible = false;
                this.accTeachingOfSkillBtn.enabled = false;
            }
            this.initializeGeneralProperties();
            if (window) 
                window.title = this._name.text + ", " + data.role + " - " + loc1.locale.makeString(MENU.TANKMANPERSONALCASE_TITLE);
            this.initializeTabButton();
            validateNow();
            return;
        }

        internal function onTeachSkillBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            openExchangeFreeToTankmanXpWindowS();
            return;
        }

        internal function initializeTabButton():void
        {
            var loc2:*=null;
            var loc1:*=[];
            if (data.currentVehicle == null || !data.currentVehicle.currentVehicleLocked) 
                if (this.tabs.dataProvider.length <= 1) 
                {
                    loc1 = [{"label":MENU.TANKMANPERSONALCASE_TABBATTLEINFO, "linkage":net.wg.data.constants.Linkages.PERSONAL_CASE_STATS}, {"label":MENU.TANKMANPERSONALCASE_TABTRAINING, "linkage":net.wg.data.constants.Linkages.PERSONAL_CASE_RETRAINING}, {"label":MENU.TANKMANPERSONALCASE_TABSKILLS, "linkage":net.wg.data.constants.Linkages.PERSONAL_CASE_SKILLS}, {"label":MENU.TANKMANPERSONALCASE_TABDOCS, "linkage":net.wg.data.constants.Linkages.PERSONAL_CASE_DOCS}];
                    this.tabs.dataProvider = new scaleform.clik.data.DataProvider(loc1);
                }
            else 
            {
                loc1 = [{"label":MENU.TANKMANPERSONALCASE_TABBATTLEINFO, "linkage":net.wg.data.constants.Linkages.PERSONAL_CASE_STATS}];
                this.tabs.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            }
            if (this.tabs.selectedIndex != -1) 
            {
                this.runtimeShowByIndex(this.tabs.selectedIndex);
                loc2 = net.wg.infrastructure.interfaces.IViewStackContent(this.view.currentView);
                this.runtimeUpdateByInstance(loc2);
            }
            else 
            {
                this.view.show(net.wg.data.constants.Linkages.PERSONAL_CASE_STATS);
                this.tabs.selectedIndex = 0;
                this.tabs.validateNow();
            }
            return;
        }

        internal function initializeGeneralProperties():void
        {
            if (!(data.iconFile == null) && !(data.iconFile == this.icon1.source)) 
            {
                this.icon1.visible = true;
                this.icon1.source = data.iconFile;
            }
            if (!(data.rankIconFile == null) && !(data.rankIconFile == this.rankIcon.source)) 
            {
                this.rankIcon.visible = true;
                this.rankIcon.source = data.rankIconFile;
            }
            if (data.nativeVehicle.contourIconFile != null) 
                this.contourIcon.visible = true;
            this._name.text = data.firstname + " " + data.lastname;
            this.rank.text = data.rank;
            this.role.text = data.role;
            this.levelValue.text = data.specializationLevel + "%";
            this.vehicleType.text = data.nativeVehicle.userName;
            this.contourIcon.source = data.nativeVehicle.contourIconFile;
            this.usingLevelLoadingBar.maximum = 100;
            this.usingLevelLoadingBar.minimum = 0;
            this.usingLevelLoadingBar.position = Number(data.specializationLevel);
            this.roleIcon.gotoAndStop(data.roleType);
            this.bg_switcher.gotoAndPlay(this.currentNation);
            this.descrSkillButton.visible = true;
            this.descrSkillButton.text = App.utils.locale.makeString(DIALOGS.ADDSKILLWINDOW_LABEL);
            if (data.inTank) 
            {
                var loc1:*;
                this.inTankValue.visible = loc1 = true;
                this.inTankLabel.visible = loc1;
                this.inTankLabel.text = MENU.TANKMANPERSONALCASE_CREW;
                this.inTankValue.htmlText = data.currentVehicle.currentVehicleName + (" <font color=\'#ff0000\'>" + data.currentVehicle.currentVehicleLockMessage + "</font>");
            }
            else 
            {
                this.inTankValue.visible = loc1 = false;
                this.inTankLabel.visible = loc1;
            }
            this.unloadBtn.enabled = this.enableButtons(!data.inTank, this.tankmanInBattle);
            if (data.inTank) 
                this.dismissBtn.enabled = this.enableButtons(data.currentVehicle.currentVehicleLocked, data.currentVehicle.currentVehicleBroken);
            else 
                this.dismissBtn.enabled = true;
            return;
        }

        internal function enableButtons(arg1:Boolean, arg2:Boolean):Boolean
        {
            if (arg1) 
                return false;
            if (arg2) 
                return false;
            return true;
        }

        internal function __isEnableDropSkillsButton():Boolean
        {
            if (data.currentVehicle && (data.currentVehicle.currentVehicleLocked || data.currentVehicle.currentVehicleBroken)) 
                return false;
            var loc1:*=0;
            while (loc1 < data.skills.length) 
            {
                if (!data.skills[loc1].isNewSkill) 
                    return true;
                ++loc1;
            }
            return false;
        }

        internal function initializeDropSkillsButton(arg1:Boolean):void
        {
            this.dropSkillsButton.enabled = arg1;
            return;
        }

        internal function initializeSkillBtn(arg1:Boolean):void
        {
            this.skillsBtn.visible = data.skills.length == 0;
            this.skillsBtn.enabled = !arg1;
            this.skillsBtn.bg.flag_switcher.gotoAndPlay(this.currentNation);
            this.skillsBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSkillsBtnClick);
            return;
        }

        internal function onViewNeedUpdate(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=arg1.view;
            if (loc1 is net.wg.gui.lobby.tankman.PersonalCaseStats && !flash.events.EventDispatcher(loc1).hasEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO)) 
            {
                flash.events.EventDispatcher(loc1).addEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO, this.changeTabToTwoHandler);
                flash.events.EventDispatcher(loc1).addEventListener(net.wg.gui.events.PersonalCaseEvent.GET_TANKMAN_ID, this.getTankmanIDHandler);
            }
            else if (loc1 is net.wg.gui.lobby.tankman.CrewTankmanRetraining && !flash.events.EventDispatcher(loc1).hasEventListener(net.wg.gui.events.PersonalCaseEvent.APPLY_RETRAINING)) 
                flash.events.EventDispatcher(loc1).addEventListener(net.wg.gui.events.PersonalCaseEvent.APPLY_RETRAINING, this.applyRetrainingHandler);
            else if (loc1 is net.wg.gui.lobby.tankman.PersonalCaseSkills && !flash.events.EventDispatcher(loc1).hasEventListener(net.wg.gui.events.PersonalCaseEvent.TRAINING_SKILL)) 
                flash.events.EventDispatcher(loc1).addEventListener(net.wg.gui.events.PersonalCaseEvent.TRAINING_SKILL, this.trainingSkillHandler);
            else if (loc1 is net.wg.gui.lobby.tankman.PersonalCaseDocs && !flash.events.EventDispatcher(loc1).hasEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_PASSPORT)) 
                flash.events.EventDispatcher(loc1).addEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_PASSPORT, this.changePassportHandler);
            this.currentView = arg1.view;
            this.runtimeUpdateByInstance(this.currentView);
            return;
        }

        protected override function runtimeUpdateByModel(arg1:Class, arg2:Object):void
        {
            if (this.currentView is arg1) 
                this.currentView.update(arg2);
            return;
        }

        internal function runtimeUpdateByInstance(arg1:net.wg.infrastructure.interfaces.IViewStackContent=null):void
        {
            if (arg1 == null) 
                return;
            if (arg1 is net.wg.gui.lobby.tankman.PersonalCaseStats && stats) 
                arg1.update(stats);
            if (arg1 is net.wg.gui.lobby.tankman.CrewTankmanRetraining && retrainingData && rentainingTabUpdated) 
            {
                arg1.update(retrainingData);
                rentainingTabUpdated = false;
            }
            if (arg1 is net.wg.gui.lobby.tankman.PersonalCaseSkills && skillsModel) 
                arg1.update(skillsModel);
            if (arg1 is net.wg.gui.lobby.tankman.PersonalCaseDocs && documentsData) 
                arg1.update(documentsData);
            return;
        }

        internal function runtimeShowByIndex(arg1:int=0):void
        {
            var loc1:*=data.inTank && !data.currentVehicle.currentVehicleLocked;
            if (arg1 != 0) 
                if (arg1 == 1 && loc1) 
                    this.view.show(net.wg.data.constants.Linkages.PERSONAL_CASE_RETRAINING);
                else if (arg1 == 2 && loc1) 
                    this.view.show(net.wg.data.constants.Linkages.PERSONAL_CASE_SKILLS);
                else if (arg1 == 3 && loc1) 
                    this.view.show(net.wg.data.constants.Linkages.PERSONAL_CASE_DOCS);
            else 
                this.view.show(net.wg.data.constants.Linkages.PERSONAL_CASE_STATS);
            this.currentView = this.view.currentView as net.wg.infrastructure.interfaces.IViewStackContent;
            this.runtimeUpdateByInstance(this.currentView);
            return;
        }

        internal function applyRetrainingHandler(arg1:net.wg.gui.events.PersonalCaseEvent):void
        {
            retrainingTankmanS(arg1.retrainingTankmanData.inventoryID, arg1.retrainingTankmanData.innaitonID, arg1.retrainingTankmanData.tankmanCostTypeIndex);
            return;
        }

        internal function trainingSkillHandler(arg1:net.wg.gui.events.PersonalCaseEvent):void
        {
            addTankmanSkillS(data.inventoryID, arg1.trainingSkillName);
            return;
        }

        internal function tabs_clikIndexChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.runtimeShowByIndex(arg1.index);
            return;
        }

        internal function onDropSkillsButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dropSkillsS();
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function hideTooltip(arg1:scaleform.clik.events.ButtonEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            var loc1:*="";
            if (arg1.target != this.unloadBtn) 
                if (arg1.target == this.dismissBtn) 
                    loc1 = TOOLTIPS.BARRACKS_TANKMEN_DISMISS;
            else 
                loc1 = TOOLTIPS.BARRACKS_TANKMEN_UNLOAD;
            App.toolTipMgr.showComplex(loc1);
            return;
        }

        internal function unloadBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            unloadTankmanS(data.inventoryID, data.currentVehicle.inventoryID);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.tabButtonVisibleFalse.visible = false;
            this.view.targetGroup = "tabs";
            this.unloadBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.unloadBtnClick);
            this.unloadBtn.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.showTooltip);
            this.unloadBtn.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.hideTooltip);
            this.unloadBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hideTooltip);
            this.unloadBtn.label = MENU.BARRACKS_BTNUNLOAD;
            this.dismissBtn.label = MENU.BARRACKS_BTNDISSMISS;
            this.closeBtn.label = MENU.TANKMANPERSONALCASE_CLOSEBTN;
            this.dismissBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.dismissBtnClick);
            this.dismissBtn.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.showTooltip);
            this.dismissBtn.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.hideTooltip);
            this.dismissBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hideTooltip);
            this.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.tabs.buttonWidth = 100;
            this.tabs.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.tabs_clikIndexChangeHandler);
            this.accTeachingOfSkillBtn.visible = false;
            this.accTeachingOfSkillBtn.enabled = false;
            this.dropSkillsButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDropSkillsButtonClick);
            this.view.addEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdate);
            getDossierDataS();
            getCommonDataS();
            getRetrainingDataS();
            getSkillsDataS();
            getDocumentsDataS();
            return;
        }

        internal function onSkillsBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.changeTabToTwoHandler();
            return;
        }

        internal function changePassportHandler(arg1:net.wg.gui.events.PersonalCaseEvent):void
        {
            changeTankmanPassportS(data.inventoryID, arg1.newTankmanFirstName.id, arg1.newTankmanLastName.id, arg1.newIcon.id);
            return;
        }

        internal function changeTabToTwoHandler(arg1:net.wg.gui.events.PersonalCaseEvent=null):void
        {
            var loc1:*=!data.currentVehicle || data.currentVehicle && !data.currentVehicle.currentVehicleLocked;
            if (!(this.tabs.selectedIndex == 2) && loc1 && this.tabs.dataProvider.length > 1) 
            {
                this.tabs.selectedIndex = 2;
                this.runtimeShowByIndex(this.tabs.selectedIndex);
            }
            return;
        }

        internal function getTankmanIDHandler(arg1:net.wg.gui.events.PersonalCaseEvent):void
        {
            if (data.skills.length > 0) 
                arg1.tankmanIdDelegate(data.inventoryID, data.skills[(data.skills.length - 1)].name);
            else 
                arg1.tankmanIdDelegate(data.inventoryID, "empty");
            return;
        }

        protected override function onDispose():void
        {
            App.toolTipMgr.hide();
            this.unloadBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.unloadBtnClick);
            this.unloadBtn.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.showTooltip);
            this.unloadBtn.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.hideTooltip);
            this.unloadBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hideTooltip);
            this.dismissBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.dismissBtnClick);
            this.dismissBtn.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.showTooltip);
            this.dismissBtn.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.hideTooltip);
            this.dismissBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hideTooltip);
            this.skillsBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSkillsBtnClick);
            this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.tabs_clikIndexChangeHandler);
            this.tabs.dispose();
            this.closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.dropSkillsButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDropSkillsButtonClick);
            this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdate);
            this.view.dispose();
            this.view = null;
            this.skills_mc.removeEventListener(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO, this.changeTabToTwoHandler);
            this.skills_mc.dispose();
            this.skills_mc = null;
            this.icon1.dispose();
            this.rankIcon.dispose();
            this.contourIcon.dispose();
            if (this.currentView) 
            {
                net.wg.infrastructure.interfaces.entity.IDisposable(this.currentView).dispose();
                this.currentView = null;
            }
            data = null;
            stats = null;
            retrainingData = null;
            skillsModel = null;
            documentsData = null;
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_SCROLLING_LIST) && this.isUpdateList) 
            {
                this.skills_mc.dataProvider = new scaleform.clik.data.DataProvider(data.skills);
                this.skills_mc.invalidate(net.wg.gui.components.carousels.CarouselBase.INIT_CAROUSEL);
                this.isUpdateList = false;
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.top = 32;
            loc1.bottom = 18;
            loc1.left = 11;
            window.contentPadding = loc1;
            window.useBottomBtns = true;
            return;
        }

        internal function dismissBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dismissTankmanS(data.inventoryID);
            return;
        }

        internal static const SKILLS_CAROUSEL_POSITION:flash.geom.Point=new flash.geom.Point(21, 320);

        internal static const UPDATE_SCROLLING_LIST:String="updateScrollingList";

        internal static const SKILLS_CAROUSEL_ITEM_SIDE:uint=60;

        internal static const SKILLS_CAROUSEL_ITEM_MARGIN:uint=3;

        public var rank:flash.text.TextField;

        public var role:flash.text.TextField;

        public var levelValue:flash.text.TextField;

        public var inTankLabel:flash.text.TextField;

        public var inTankValue:flash.text.TextField;

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx;

        public var view:net.wg.gui.components.advanced.ViewStack;

        public var skills_mc:net.wg.gui.components.carousels.SkillsCarousel;

        public var unloadBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var dismissBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var bg_switcher:flash.display.MovieClip;

        public var icon1:net.wg.gui.components.controls.UILoaderAlt;

        public var tabButtonVisibleFalse:net.wg.gui.components.advanced.TabButton;

        public var accTeachingOfSkillBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var usingLevelLoadingBar:scaleform.clik.controls.StatusIndicator;

        public var contourIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var roleIcon:flash.display.MovieClip;

        public var skillsBtn:flash.display.MovieClip;

        public var dropSkillsButton:net.wg.gui.components.controls.IconTextButton;

        internal var currentView:net.wg.infrastructure.interfaces.IViewStackContent;

        internal var currentNation:String="";

        internal var isUpdateList:Boolean=false;

        internal var tankmanInBattle:Boolean=false;

        public var descrSkillButton:flash.text.TextField;

        public var vehicleType:flash.text.TextField;

        public var drop_skills_button_bg_line:flash.display.Sprite;

        public var s_tab_line:flash.display.Sprite;

        public var _name:flash.text.TextField;

        public var rankIcon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
