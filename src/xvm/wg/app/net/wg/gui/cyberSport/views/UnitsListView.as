package net.wg.gui.cyberSport.views
{
   import net.wg.infrastructure.base.meta.impl.CyberSportUnitsListMeta;
   import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
   import net.wg.infrastructure.base.meta.ICyberSportBaseViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.cyberSport.controls.PerpageScrollingList;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.cyberSport.views.unit.JoinUnitSection;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.views.events.CyberSportEvent;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import net.wg.data.constants.Tooltips;
   import flash.events.Event;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class UnitsListView extends CyberSportUnitsListMeta implements ICyberSportUnitsListMeta, ICyberSportBaseViewMeta, IViewStackContent
   {
          
      public function UnitsListView() {
         super();
      }

      private static const REFRESH_BUTTON_OFFSET:Number = 14;

      private static const MAXIMUM_REQUESTS:int = 3;

      public var unitsList:PerpageScrollingList;

      public var suitedTanksBtn:ButtonDnmIcon = null;

      public var refreshBtn:ButtonDnmIcon = null;

      public var searchResultsTF:TextField;

      public var selectVehiclesTF:TextField;

      public var scrBar:ScrollBar;

      public var joinUnitSection:JoinUnitSection;

      private var _unitMgrID:Number = 0;

      private var _selectedVehiclesCount:int = 0;

      public function update(param1:Object) : void {
          
      }

      private var _pyAlias:String;

      public function as_setPyAlias(param1:String) : void {
         this._pyAlias = param1;
      }

      public function as_setRefreshCoolDown(param1:Number) : void {
         this.enableRefreshButton(false);
         App.utils.scheduler.scheduleTask(this.enableRefreshButton,param1 * 1000,true);
      }

      public function as_getPyAlias() : String {
         return this._pyAlias;
      }

      public function as_setTeamsData(param1:Array, param2:Number) : void {
         this.unitsList.totalCommands = param2;
         this.unitsList.setData(param1);
         invalidateData();
      }

      public function as_appendTeamsData(param1:Array) : void {
         this.unitsList.appendData(param1);
         this.unitsList.selectedIndex = -1;
      }

      override protected function configUI() : void {
         super.configUI();
         this.unitsList.setPagesMaximum(MAXIMUM_REQUESTS);
         this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onRefreshClick);
         this.suitedTanksBtn.addEventListener(ButtonEvent.CLICK,this.onSuitedTanksBtnClick);
         this.unitsList.addEventListener(ListEventEx.INDEX_CHANGE,this.selectTeam);
         this.unitsList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onListItemDoubleClick);
         this.unitsList.addEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST,this.onLoadPreviousRequest);
         this.unitsList.addEventListener(CSComponentEvent.LOAD_NEXT_REQUEST,this.onLoadNextRequest);
         this.unitsList.addEventListener(ListEventEx.ITEM_ROLL_OVER,this.onItemRollOver);
         this.unitsList.addEventListener(ListEventEx.ITEM_ROLL_OUT,this.onItemRollOut);
         this.suitedTanksBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.suitedTanksBtn.addEventListener(MouseEvent.ROLL_OUT,this.onItemRollOut);
         this.refreshBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.refreshBtn.addEventListener(MouseEvent.ROLL_OUT,this.onItemRollOut);
         this.joinUnitSection.addEventListener(CSComponentEvent.JOIN_UNIT_REQUEST,this.onJoinRequest);
         this.joinUnitSection.addEventListener(CSComponentEvent.ASSIGN_SLOT_REQUEST,this.onJoinRequest);
         App.utils.focusHandler.setFocus(this.unitsList);
      }

      private function onJoinRequest(param1:CSComponentEvent) : void {
         dispatchEvent(new CyberSportEvent(CyberSportEvent.LOAD_VIEW_REQUEST,CYBER_SPORT_ALIASES.UNIT_VIEW_UI,this._unitMgrID,param1.data?param1.data:-1));
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function onDispose() : void {
         this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onRefreshClick);
         this.suitedTanksBtn.removeEventListener(ButtonEvent.CLICK,this.onSuitedTanksBtnClick);
         this.unitsList.removeEventListener(ListEventEx.INDEX_CHANGE,this.selectTeam);
         this.unitsList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onListItemDoubleClick);
         this.unitsList.removeEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST,this.onLoadPreviousRequest);
         this.unitsList.removeEventListener(CSComponentEvent.LOAD_NEXT_REQUEST,this.onLoadNextRequest);
         this.unitsList.removeEventListener(ListEventEx.ITEM_ROLL_OVER,this.onItemRollOver);
         this.unitsList.removeEventListener(ListEventEx.ITEM_ROLL_OUT,this.onItemRollOut);
         this.joinUnitSection.removeEventListener(CSComponentEvent.JOIN_UNIT_REQUEST,this.onJoinRequest);
         this.joinUnitSection.removeEventListener(CSComponentEvent.ASSIGN_SLOT_REQUEST,this.onJoinRequest);
         this.suitedTanksBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.suitedTanksBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onItemRollOut);
         this.refreshBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.refreshBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onItemRollOut);
         App.utils.scheduler.cancelTask(this.enableRefreshButton);
         this.unitsList.dispose();
         this.unitsList = null;
         this.joinUnitSection.dispose();
         this.joinUnitSection = null;
         super.onDispose();
      }

      private function onRefreshClick(param1:ButtonEvent) : void {
         refreshTeamsS();
      }

      private function onSuitedTanksBtnClick(param1:ButtonEvent) : void {
         filterVehiclesS();
      }

      private function selectTeam(param1:ListEvent) : void {
         var _loc2_:CSCommandVO = param1.itemData as CSCommandVO;
         if((_loc2_) && !_loc2_.isLoadMoreState)
         {
            this._unitMgrID = _loc2_.unitMgrID;
            getTeamDataS(_loc2_.cfdUnitID);
         }
      }

      private function onListItemDoubleClick(param1:ListEvent) : void {
         var _loc2_:CSCommandVO = param1.itemData as CSCommandVO;
         if((_loc2_) && !_loc2_.isLoadMoreState)
         {
            this._unitMgrID = _loc2_.unitMgrID;
            dispatchEvent(new CyberSportEvent(CyberSportEvent.LOAD_VIEW_REQUEST,CYBER_SPORT_ALIASES.UNIT_VIEW_UI,this._unitMgrID,-1));
         }
      }

      private function onLoadNextRequest(param1:CSComponentEvent) : void {
         loadNextS();
      }

      private function onLoadPreviousRequest(param1:CSComponentEvent) : void {
         loadPreviousS();
      }

      public function as_setSelectedUnit(param1:Object) : void {
         this.joinUnitSection.setData(new UnitVO(param1));
      }

      public function as_selectUnitInList(param1:Number) : void {
         var _loc2_:CSCommandVO = null;
         for each (_loc2_ in this.unitsList.dataProvider)
         {
            if(_loc2_.unitMgrID == param1)
            {
               this.unitsList.selectedIndex = this.unitsList.dataProvider.indexOf(_loc2_);
               getTeamDataS(_loc2_.cfdUnitID);
               return;
            }
         }
      }

      public function as_clearSelectedUnit() : void {
         this.joinUnitSection.setData(null);
         this.unitsList.selectedIndex = -1;
      }

      private function onItemRollOver(param1:ListEventEx) : void {
         var _loc2_:CSCommandVO = param1.itemData as CSCommandVO;
         if((_loc2_) && !_loc2_.isLoadMoreState)
         {
            App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_TEAM,null,_loc2_.unitMgrID);
         }
      }

      private function onItemRollOut(param1:Event) : void {
         App.toolTipMgr.hide();
      }

      public function as_setSelectedVehiclesInfo(param1:String, param2:int) : void {
         this.selectVehiclesTF.htmlText = param1;
         this._selectedVehiclesCount = param2;
      }

      public function as_setSearchResultText(param1:String) : void {
         this.searchResultsTF.htmlText = param1;
         this.refreshBtn.x = this.searchResultsTF.x + this.searchResultsTF.textWidth + REFRESH_BUTTON_OFFSET;
      }

      private function enableRefreshButton(param1:Boolean) : void {
         this.refreshBtn.enabled = param1;
         this.suitedTanksBtn.enabled = param1;
         this.unitsList.setNavInCoolDown(!param1);
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         var _loc2_:* = "";
         var _loc3_:* = "";
         switch(param1.currentTarget)
         {
            case this.suitedTanksBtn:
               _loc2_ = TOOLTIPS.CYBERSPORT_UNITLIST_FILTERBYVEHICLE_HEADER;
               _loc3_ = this._selectedVehiclesCount == 0?TOOLTIPS.CYBERSPORT_UNITLIST_FILTERBYVEHICLE_NOVEHICLESSELECTED:TOOLTIPS.CYBERSPORT_UNITLIST_FILTERBYVEHICLE_SOMEVEHICLESSELECTED;
               this.showTooltip(_loc2_,_loc3_);
               break;
            case this.refreshBtn:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_REFRESH);
               break;
         }
      }

      private function showTooltip(param1:String, param2:String) : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
   }

}