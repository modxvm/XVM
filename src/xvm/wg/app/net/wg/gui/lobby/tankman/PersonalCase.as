package net.wg.gui.lobby.tankman
{
   import flash.geom.Point;
   import net.wg.gui.components.advanced.TabButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.carousels.SkillsCarousel;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.controls.StatusIndicator;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.carousels.CarouselBase;
   import scaleform.clik.utils.Padding;
   import net.wg.utils.IUtils;
   import net.wg.data.constants.Linkages;
   import flash.events.EventDispatcher;
   import flash.events.Event;


   public class PersonalCase extends PersonalCaseBase
   {
          
      public function PersonalCase() {
         super();
         isModal = false;
         isCentered = true;
         canClose = true;
         showWindowBg = false;
      }

      private static const UPDATE_SCROLLING_LIST:String = "updateScrollingList";

      private static const SKILLS_CAROUSEL_ITEM_SIDE:uint = 60;

      private static const SKILLS_CAROUSEL_ITEM_MARGIN:uint = 3;

      private static const SKILLS_CAROUSEL_POSITION:Point;

      public var tabButtonVisibleFalse:TabButton;

      public var drop_skills_button_bg_line:Sprite;

      public var s_tab_line:Sprite;

      public var _name:TextField;

      public var rank:TextField;

      public var role:TextField;

      public var levelValue:TextField;

      public var vehicleType:TextField;

      public var inTankLabel:TextField;

      public var inTankValue:TextField;

      public var tabs:ButtonBarEx;

      public var view:ViewStack;

      public var skills_mc:SkillsCarousel;

      public var unloadBtn:SoundButtonEx;

      public var dismissBtn:SoundButtonEx;

      public var closeBtn:SoundButtonEx;

      public var bg_switcher:MovieClip;

      public var icon1:UILoaderAlt;

      public var rankIcon:UILoaderAlt;

      public var accTeachingOfSkillBtn:SoundButtonEx;

      public var usingLevelLoadingBar:StatusIndicator;

      public var contourIcon:UILoaderAlt;

      public var roleIcon:MovieClip;

      public var skillsBtn:MovieClip;

      public var dropSkillsButton:IconTextButton;

      public var descrSkillButton:TextField;

      private var currentView:IViewStackContent;

      private var currentNation:String = "";

      private var isUpdateList:Boolean = false;

      private var tankmanInBattle:Boolean = false;

      override protected function onDispose() : void {
         App.toolTipMgr.hide();
         this.unloadBtn.removeEventListener(ButtonEvent.CLICK,this.unloadBtnClick);
         this.unloadBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
         this.unloadBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.hideTooltip);
         this.unloadBtn.removeEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.dismissBtn.removeEventListener(ButtonEvent.CLICK,this.dismissBtnClick);
         this.dismissBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
         this.dismissBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.hideTooltip);
         this.dismissBtn.removeEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.skillsBtn.removeEventListener(ButtonEvent.CLICK,this.onSkillsBtnClick);
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.tabs_clikIndexChangeHandler);
         this.tabs.dispose();
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
         this.dropSkillsButton.removeEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClick);
         this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
         this.view.dispose();
         this.view = null;
         this.skills_mc.removeEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.changeTabToTwoHandler);
         this.skills_mc.dispose();
         this.skills_mc = null;
         this.tabButtonVisibleFalse.dispose();
         this.tabButtonVisibleFalse = null;
         this.icon1.dispose();
         this.rankIcon.dispose();
         this.contourIcon.dispose();
         if(this.currentView)
         {
            IDisposable(this.currentView).dispose();
            this.currentView = null;
         }
         data = null;
         stats = null;
         retrainingData = null;
         skillsModel = null;
         documentsData = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_SCROLLING_LIST)) && (this.isUpdateList))
         {
            this.skills_mc.dataProvider = new DataProvider(data.skills);
            this.skills_mc.invalidate(CarouselBase.INIT_CAROUSEL);
            this.isUpdateList = false;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.top = 32;
         _loc1_.bottom = 18;
         _loc1_.left = 11;
         window.contentPadding = _loc1_;
         window.useBottomBtns = true;
      }

      override protected function configUI() : void {
         super.configUI();
         this.tabButtonVisibleFalse.visible = false;
         this.view.targetGroup = "tabs";
         this.unloadBtn.addEventListener(ButtonEvent.CLICK,this.unloadBtnClick);
         this.unloadBtn.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
         this.unloadBtn.addEventListener(MouseEvent.MOUSE_OUT,this.hideTooltip);
         this.unloadBtn.addEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.unloadBtn.label = MENU.BARRACKS_BTNUNLOAD;
         this.dismissBtn.label = MENU.BARRACKS_BTNDISSMISS;
         this.closeBtn.label = MENU.TANKMANPERSONALCASE_CLOSEBTN;
         this.dismissBtn.addEventListener(ButtonEvent.CLICK,this.dismissBtnClick);
         this.dismissBtn.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
         this.dismissBtn.addEventListener(MouseEvent.MOUSE_OUT,this.hideTooltip);
         this.dismissBtn.addEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
         this.tabs.buttonWidth = 100;
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.tabs_clikIndexChangeHandler);
         this.accTeachingOfSkillBtn.visible = false;
         this.accTeachingOfSkillBtn.enabled = false;
         this.dropSkillsButton.addEventListener(ButtonEvent.CLICK,this.onDropSkillsButtonClick);
         this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
         getDossierDataS();
         getCommonDataS();
         getRetrainingDataS();
         getSkillsDataS();
         getDocumentsDataS();
      }

      override public function setFocus() : void {
         super.setFocus();
         App.utils.focusHandler.setFocus(this);
      }

      override public function as_setCommonData(param1:Object) : void {
         super.as_setCommonData(param1);
         if(isFirtsRun)
         {
            this.tabs.selectedIndex = autoSelectTab;
            this.runtimeShowByIndex(autoSelectTab);
            isFirtsRun = false;
         }
      }

      override public function as_setDossierData(param1:Object) : void {
         super.as_setDossierData(param1);
      }

      override public function as_setRetrainingData(param1:Object) : void {
         super.as_setRetrainingData(param1);
      }

      private function initSkillsCarousel() : void {
         if(!this.skills_mc.visible)
         {
            this.skills_mc.visible = true;
            this.skills_mc.slotImageHeight = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.slotImageWidth = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.margin = SKILLS_CAROUSEL_ITEM_MARGIN;
            this.addChild(this.skills_mc);
            this.skills_mc.x = SKILLS_CAROUSEL_POSITION.x;
            this.skills_mc.y = SKILLS_CAROUSEL_POSITION.y;
            if(!this.skills_mc.hasEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO))
            {
               this.skills_mc.addEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.changeTabToTwoHandler);
            }
         }
         this.isUpdateList = true;
         invalidate(UPDATE_SCROLLING_LIST);
      }

      override protected function updateCommonElements() : void {
         var _loc1_:IUtils = App.utils;
         this.currentNation = _loc1_.nations.getNationName(data.nationID);
         data.wg_freeXpToTankman = App.globalVarsMgr.isFreeXpToTankmanS();
         this.tankmanInBattle = !(data.currentVehicle == null) && (data.currentVehicle.currentVehicleLocked);
         this.initializeSkillBtn(this.tankmanInBattle);
         if(!this.skillsBtn.visible)
         {
            this.initSkillsCarousel();
         }
         else
         {
            this.skills_mc.visible = false;
         }
         this.initializeDropSkillsButton(this.__isEnableDropSkillsButton());
         if((data.wg_freeXpToTankman) && data.skills.length > 0 && data.skillsCountForLearn == 0 && Number(data.specializationLevel) == 100)
         {
            this.accTeachingOfSkillBtn.visible = true;
            this.accTeachingOfSkillBtn.enabled = true;
            this.accTeachingOfSkillBtn.addEventListener(ButtonEvent.CLICK,this.onTeachSkillBtnClick);
         }
         else
         {
            this.accTeachingOfSkillBtn.visible = false;
            this.accTeachingOfSkillBtn.enabled = false;
         }
         this.initializeGeneralProperties();
         if(window)
         {
            window.title = this._name.text + ", " + data.role + " - " + _loc1_.locale.makeString(MENU.TANKMANPERSONALCASE_TITLE);
         }
         this.initializeTabButton();
         validateNow();
      }

      private function onTeachSkillBtnClick(param1:ButtonEvent) : void {
         openExchangeFreeToTankmanXpWindowS();
      }

      private function initializeTabButton() : void {
         var _loc2_:IViewStackContent = null;
         var _loc1_:Array = [];
         if(data.currentVehicle == null || !data.currentVehicle.currentVehicleLocked)
         {
            if(this.tabs.dataProvider.length <= 1)
            {
               _loc1_ = [
                  {
                     "label":MENU.TANKMANPERSONALCASE_TABBATTLEINFO,
                     "linkage":Linkages.PERSONAL_CASE_STATS
                  }
               ,
                  {
                     "label":MENU.TANKMANPERSONALCASE_TABTRAINING,
                     "linkage":Linkages.PERSONAL_CASE_RETRAINING
                  }
               ,
                  {
                     "label":MENU.TANKMANPERSONALCASE_TABSKILLS,
                     "linkage":Linkages.PERSONAL_CASE_SKILLS
                  }
               ,
                  {
                     "label":MENU.TANKMANPERSONALCASE_TABDOCS,
                     "linkage":Linkages.PERSONAL_CASE_DOCS
                  }
               ];
               this.tabs.dataProvider = new DataProvider(_loc1_);
            }
         }
         else
         {
            _loc1_ = [
               {
                  "label":MENU.TANKMANPERSONALCASE_TABBATTLEINFO,
                  "linkage":Linkages.PERSONAL_CASE_STATS
               }
            ];
            this.tabs.dataProvider = new DataProvider(_loc1_);
         }
         if(this.tabs.selectedIndex == -1)
         {
            this.view.show(Linkages.PERSONAL_CASE_STATS);
            this.tabs.selectedIndex = 0;
            this.tabs.validateNow();
         }
         else
         {
            this.runtimeShowByIndex(this.tabs.selectedIndex);
            _loc2_ = IViewStackContent(this.view.currentView);
            this.runtimeUpdateByInstance(_loc2_);
         }
      }

      private function initializeGeneralProperties() : void {
         if(!(data.iconFile == null) && !(data.iconFile == this.icon1.source))
         {
            this.icon1.visible = true;
            this.icon1.source = data.iconFile;
         }
         if(!(data.rankIconFile == null) && !(data.rankIconFile == this.rankIcon.source))
         {
            this.rankIcon.visible = true;
            this.rankIcon.source = data.rankIconFile;
         }
         if(data.nativeVehicle.contourIconFile != null)
         {
            this.contourIcon.visible = true;
         }
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
         if(data.inTank)
         {
            this.inTankLabel.visible = this.inTankValue.visible = true;
            this.inTankLabel.text = MENU.TANKMANPERSONALCASE_CREW;
            this.inTankValue.htmlText = data.currentVehicle.currentVehicleName + (" <font color=\'#ff0000\'>" + data.currentVehicle.currentVehicleLockMessage + "</font>");
         }
         else
         {
            this.inTankLabel.visible = this.inTankValue.visible = false;
         }
         this.unloadBtn.enabled = this.enableButtons(!data.inTank,this.tankmanInBattle);
         if(data.inTank)
         {
            this.dismissBtn.enabled = this.enableButtons(data.currentVehicle.currentVehicleLocked,data.currentVehicle.currentVehicleBroken);
         }
         else
         {
            this.dismissBtn.enabled = true;
         }
      }

      private function enableButtons(param1:Boolean, param2:Boolean) : Boolean {
         if(param1)
         {
            return false;
         }
         if(param2)
         {
            return false;
         }
         return true;
      }

      private function __isEnableDropSkillsButton() : Boolean {
         if((data.currentVehicle) && ((data.currentVehicle.currentVehicleLocked) || (data.currentVehicle.currentVehicleBroken)))
         {
            return false;
         }
         var _loc1_:* = 0;
         while(_loc1_ < data.skills.length)
         {
            if(!data.skills[_loc1_].isNewSkill)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }

      private function initializeDropSkillsButton(param1:Boolean) : void {
         this.dropSkillsButton.enabled = param1;
      }

      private function initializeSkillBtn(param1:Boolean) : void {
         this.skillsBtn.visible = data.skills.length == 0;
         this.skillsBtn.enabled = !param1;
         this.skillsBtn.bg.flag_switcher.gotoAndPlay(this.currentNation);
         this.skillsBtn.addEventListener(ButtonEvent.CLICK,this.onSkillsBtnClick);
      }

      private function onViewNeedUpdate(param1:ViewStackEvent) : void {
         var _loc2_:IViewStackContent = param1.view;
         if(_loc2_  is  PersonalCaseStats && !EventDispatcher(_loc2_).hasEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO))
         {
            EventDispatcher(_loc2_).addEventListener(PersonalCaseEvent.CHANGE_TAB_ON_TWO,this.changeTabToTwoHandler);
            EventDispatcher(_loc2_).addEventListener(PersonalCaseEvent.GET_TANKMAN_ID,this.getTankmanIDHandler);
         }
         else
         {
            if(_loc2_  is  CrewTankmanRetraining && !EventDispatcher(_loc2_).hasEventListener(PersonalCaseEvent.APPLY_RETRAINING))
            {
               EventDispatcher(_loc2_).addEventListener(PersonalCaseEvent.APPLY_RETRAINING,this.applyRetrainingHandler);
            }
            else
            {
               if(_loc2_  is  PersonalCaseSkills && !EventDispatcher(_loc2_).hasEventListener(PersonalCaseEvent.TRAINING_SKILL))
               {
                  EventDispatcher(_loc2_).addEventListener(PersonalCaseEvent.TRAINING_SKILL,this.trainingSkillHandler);
               }
               else
               {
                  if(_loc2_  is  PersonalCaseDocs && !EventDispatcher(_loc2_).hasEventListener(PersonalCaseEvent.CHANGE_PASSPORT))
                  {
                     EventDispatcher(_loc2_).addEventListener(PersonalCaseEvent.CHANGE_PASSPORT,this.changePassportHandler);
                  }
               }
            }
         }
         this.currentView = param1.view;
         this.runtimeUpdateByInstance(this.currentView);
      }

      override protected function runtimeUpdateByModel(param1:Class, param2:Object) : void {
         if(this.currentView  is  param1)
         {
            this.currentView.update(param2);
         }
      }

      private function runtimeUpdateByInstance(param1:IViewStackContent=null) : void {
         if(param1 == null)
         {
            return;
         }
         if(param1  is  PersonalCaseStats && (stats))
         {
            param1.update(stats);
         }
         if((param1  is  CrewTankmanRetraining) && (retrainingData) && (rentainingTabUpdated))
         {
            param1.update(retrainingData);
            rentainingTabUpdated = false;
         }
         if(param1  is  PersonalCaseSkills && (skillsModel))
         {
            param1.update(skillsModel);
         }
         if(param1  is  PersonalCaseDocs && (documentsData))
         {
            param1.update(documentsData);
         }
      }

      private function runtimeShowByIndex(param1:int=0) : void {
         var _loc2_:Boolean = (data.inTank) && !data.currentVehicle.currentVehicleLocked;
         if(param1 == 0)
         {
            this.view.show(Linkages.PERSONAL_CASE_STATS);
         }
         else
         {
            if(param1 == 1 && (_loc2_))
            {
               this.view.show(Linkages.PERSONAL_CASE_RETRAINING);
            }
            else
            {
               if(param1 == 2 && (_loc2_))
               {
                  this.view.show(Linkages.PERSONAL_CASE_SKILLS);
               }
               else
               {
                  if(param1 == 3 && (_loc2_))
                  {
                     this.view.show(Linkages.PERSONAL_CASE_DOCS);
                  }
               }
            }
         }
         this.currentView = this.view.currentView as IViewStackContent;
         this.runtimeUpdateByInstance(this.currentView);
      }

      private function applyRetrainingHandler(param1:PersonalCaseEvent) : void {
         retrainingTankmanS(param1.retrainingTankmanData.inventoryID,param1.retrainingTankmanData.innaitonID,param1.retrainingTankmanData.tankmanCostTypeIndex);
      }

      private function trainingSkillHandler(param1:PersonalCaseEvent) : void {
         addTankmanSkillS(data.inventoryID,param1.trainingSkillName);
      }

      private function tabs_clikIndexChangeHandler(param1:IndexEvent) : void {
         this.runtimeShowByIndex(param1.index);
      }

      private function onDropSkillsButtonClick(param1:ButtonEvent) : void {
         dropSkillsS();
      }

      private function onClose(param1:ButtonEvent) : void {
         onWindowCloseS();
      }

      private function hideTooltip(param1:Event) : void {
         App.toolTipMgr.hide();
      }

      private function showTooltip(param1:MouseEvent) : void {
         var _loc2_:* = "";
         if(param1.target == this.unloadBtn)
         {
            _loc2_ = TOOLTIPS.BARRACKS_TANKMEN_UNLOAD;
         }
         else
         {
            if(param1.target == this.dismissBtn)
            {
               _loc2_ = TOOLTIPS.BARRACKS_TANKMEN_DISMISS;
            }
         }
         App.toolTipMgr.showComplex(_loc2_);
      }

      private function unloadBtnClick(param1:ButtonEvent) : void {
         unloadTankmanS(data.inventoryID,data.currentVehicle.inventoryID);
      }

      private function dismissBtnClick(param1:ButtonEvent) : void {
         dismissTankmanS(data.inventoryID);
      }

      private function onSkillsBtnClick(param1:ButtonEvent) : void {
         this.changeTabToTwoHandler();
      }

      private function changePassportHandler(param1:PersonalCaseEvent) : void {
         changeTankmanPassportS(data.inventoryID,param1.newTankmanFirstName.id,param1.newTankmanLastName.id,param1.newIcon.id);
      }

      private function changeTabToTwoHandler(param1:PersonalCaseEvent=null) : void {
         var _loc2_:Boolean = !data.currentVehicle || (data.currentVehicle) && !data.currentVehicle.currentVehicleLocked;
         if(!(this.tabs.selectedIndex == 2) && (_loc2_) && this.tabs.dataProvider.length > 1)
         {
            this.tabs.selectedIndex = 2;
            this.runtimeShowByIndex(this.tabs.selectedIndex);
         }
      }

      private function getTankmanIDHandler(param1:PersonalCaseEvent) : void {
         if(data.skills.length > 0)
         {
            param1.tankmanIdDelegate(data.inventoryID,data.skills[data.skills.length-1].name);
         }
         else
         {
            param1.tankmanIdDelegate(data.inventoryID,"empty");
         }
      }
   }

}