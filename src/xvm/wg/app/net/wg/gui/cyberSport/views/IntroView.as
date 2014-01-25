package net.wg.gui.cyberSport.views
{
   import net.wg.infrastructure.base.meta.impl.CyberSportIntroMeta;
   import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
   import net.wg.infrastructure.base.meta.ICyberSportBaseViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.SelectedVehiclesMsg;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.utils.ComplexTooltipHelper;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.cyberSport.views.events.CyberSportEvent;
   import flash.display.InteractiveObject;


   public class IntroView extends CyberSportIntroMeta implements ICyberSportIntroMeta, ICyberSportBaseViewMeta, IViewStackContent
   {
          
      public function IntroView() {
         this._selectedVehicles = [];
         super();
      }

      public var searchBtn:SoundButtonEx;

      public var createBtn:SoundButtonEx;

      public var autoMatchBtn:SoundButtonEx;

      public var titleLbl:TextField;

      public var descrLbl:TextField;

      public var searchTitleLbl:TextField;

      public var searchDescrLbl:TextField;

      public var createTitleLbl:TextField;

      public var createDescrLbl:TextField;

      public var autoTitleLbl:TextField;

      public var autoDescrLbl:TextField;

      public var autoBtnLbl:TextField;

      public var selectedVehiclesInfo:SelectedVehiclesMsg;

      public var chooseVehiclesButton:ButtonDnmIcon;

      private var _selectedVehicles:Array;

      private var _readyVehiclesSelected:Boolean = false;

      public function update(param1:Object) : void {
          
      }

      private var _pyAlias:String;

      public function as_setPyAlias(param1:String) : void {
         this._pyAlias = param1;
      }

      public function as_getPyAlias() : String {
         return this._pyAlias;
      }

      public function as_setSelectedVehicles(param1:Array, param2:String, param3:Boolean) : void {
         this._selectedVehicles = param1;
         this._readyVehiclesSelected = param3;
         this.selectedVehiclesInfo.update(param2,!param3);
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.titleLbl.text = CYBERSPORT.WINDOW_INTRO_TITLE;
         this.descrLbl.text = CYBERSPORT.WINDOW_INTRO_DESCRIPTION;
         this.searchTitleLbl.text = CYBERSPORT.WINDOW_INTRO_SEARCH_TITLE;
         this.searchDescrLbl.text = CYBERSPORT.WINDOW_INTRO_SEARCH_DESCRIPTION;
         this.createTitleLbl.text = CYBERSPORT.WINDOW_INTRO_CREATE_TITLE;
         this.createDescrLbl.text = CYBERSPORT.WINDOW_INTRO_CREATE_DESCRIPTION;
         this.autoTitleLbl.text = CYBERSPORT.WINDOW_INTRO_AUTO_TITLE;
         this.autoDescrLbl.text = CYBERSPORT.WINDOW_INTRO_AUTO_DESCRIPTION;
         this.autoBtnLbl.text = CYBERSPORT.WINDOW_INTRO_AUTO_BTNLBL;
         this.searchBtn.addEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.searchBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.searchBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.createBtn.addEventListener(ButtonEvent.CLICK,this.onCreateClick);
         this.createBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.createBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.autoMatchBtn.addEventListener(ButtonEvent.CLICK,this.onAutoSearchClick);
         this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.chooseVehiclesButton.addEventListener(ButtonEvent.CLICK,this.csVehicleBtnOnClick);
         this.chooseVehiclesButton.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.chooseVehiclesButton.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.selectedVehiclesInfo.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.selectedVehiclesInfo.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         var _loc2_:* = "";
         var _loc3_:* = "";
         switch(param1.currentTarget)
         {
            case this.searchBtn:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_SEARCH_BTN);
               break;
            case this.createBtn:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_CREATE_BTN);
               break;
            case this.chooseVehiclesButton:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_CHOOSEVEHICLES);
               break;
            case this.autoMatchBtn:
               _loc2_ = CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_TITLE;
               _loc3_ = this.autoMatchBtn.enabled?CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_ENABLED:CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_DISABLED;
               this.showTooltip(_loc2_,_loc3_);
               break;
            case this.selectedVehiclesInfo:
               App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_AUTOSEARCH_VEHICLES,null,this._selectedVehicles);
               break;
         }
      }

      private function onControlRollOut(param1:MouseEvent=null) : void {
         App.toolTipMgr.hide();
      }

      private function showTooltip(param1:String, param2:String) : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }

      private function onAutoSearchClick(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,
            {
               "state":CYBER_SPORT_ALIASES.INTRO_VIEW_UI,
               "cmpDescr":this._selectedVehicles
            }
         ));
      }

      override protected function draw() : void {
         super.draw();
         this.autoMatchBtn.enabled = this._readyVehiclesSelected;
         this.autoMatchBtn.mouseChildren = true;
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function onDispose() : void {
         this.searchBtn.removeEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.searchBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.searchBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.createBtn.removeEventListener(ButtonEvent.CLICK,this.onCreateClick);
         this.createBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.createBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.autoMatchBtn.removeEventListener(ButtonEvent.CLICK,this.onAutoSearchClick);
         this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.chooseVehiclesButton.removeEventListener(ButtonEvent.CLICK,this.csVehicleBtnOnClick);
         this.chooseVehiclesButton.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.chooseVehiclesButton.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.selectedVehiclesInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.selectedVehiclesInfo.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.searchBtn.dispose();
         this.searchBtn = null;
         this.createBtn.dispose();
         this.createBtn = null;
         this.autoMatchBtn.dispose();
         this.autoMatchBtn = null;
         this.chooseVehiclesButton.dispose();
         this.chooseVehiclesButton = null;
         super.onDispose();
      }

      private function onSearchClick(param1:ButtonEvent) : void {
         dispatchEvent(new CyberSportEvent(CyberSportEvent.LOAD_VIEW_REQUEST,CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI));
      }

      private function onCreateClick(param1:ButtonEvent) : void {
         dispatchEvent(new CyberSportEvent(CyberSportEvent.LOAD_VIEW_REQUEST,CYBER_SPORT_ALIASES.UNIT_VIEW_UI));
      }

      private function csVehicleBtnOnClick(param1:ButtonEvent) : void {
         showSelectorPopupS();
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}