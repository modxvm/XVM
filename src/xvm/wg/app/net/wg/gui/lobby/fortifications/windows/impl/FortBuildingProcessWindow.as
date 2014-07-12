package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortBuildingProcessWindowMeta;
   import net.wg.infrastructure.base.meta.IFortBuildingProcessWindowMeta;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl.BuildingProcessInfo;
   import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessVO;
   import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessListItemVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Errors;
   import flash.events.Event;
   
   public class FortBuildingProcessWindow extends FortBuildingProcessWindowMeta implements IFortBuildingProcessWindowMeta
   {
      
      public function FortBuildingProcessWindow() {
         super();
         isModal = false;
         isCentered = true;
         this.textInfo.mouseEnabled = false;
         this.separator.mouseEnabled = false;
         this.textInfo.alpha = ALPHA_VALUE;
         this.buildingInfo.visible = false;
         this.buildingList.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onClickItemHandler);
         this.buildingList.addEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onDoubleClickItemHandler);
         this.buildingList.uniqKeyForAutoSelect = "buildingID";
         this.buildingInfo.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.requestFocusHandler);
      }
      
      private static const ALPHA_VALUE:Number = 0.33;
      
      private static const BUILDING_STATUS_AVAILABLE:uint = 3;
      
      public var separator:MovieClip;
      
      public var availableCount:TextField = null;
      
      public var buildingList:SortableTable = null;
      
      public var buildingInfo:BuildingProcessInfo = null;
      
      public var model:BuildingProcessVO = null;
      
      public var textInfo:TextField;
      
      override protected function responseBuildingInfo(param1:BuildingProcessInfoVO) : void {
         this.buildingInfo.addEventListener(BuildingProcessInfo.BUY_BUILDING,this.buyBuildingHandler);
         this.buildingInfo.visible = true;
         this.textInfo.visible = false;
         this.buildingInfo.setData(param1);
      }
      
      override protected function onDispose() : void {
         this.buildingList.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onClickItemHandler);
         this.buildingList.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onDoubleClickItemHandler);
         this.buildingList.dispose();
         this.buildingList = null;
         this.buildingInfo.removeEventListener(BuildingProcessInfo.BUY_BUILDING,this.buyBuildingHandler);
         this.buildingInfo.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.requestFocusHandler);
         this.buildingInfo.dispose();
         this.buildingInfo = null;
         this.availableCount = null;
         super.onDispose();
      }
      
      override protected function setData(param1:BuildingProcessVO) : void {
         var _loc2_:BuildingProcessListItemVO = null;
         if(this.buildingList)
         {
            _loc2_ = this.buildingList.getListSelectedItem() as BuildingProcessListItemVO;
         }
         this.model = param1;
         this.availableCount.htmlText = this.model.availableCount;
         this.buildingList.listDP = new DataProvider(this.model.listItems);
         window.title = this.model.windowTitle;
         this.textInfo.x = Math.round(this.buildingInfo.x + (this.buildingInfo.width - this.textInfo.width) / 2);
         this.textInfo.htmlText = this.model.textInfo;
         this.textInfo.visible = true;
         if(_loc2_)
         {
            requestBuildingInfoS(_loc2_.buildingID);
         }
      }
      
      private function findFirstAvailableBuilding() : void {
         var _loc3_:BuildingProcessListItemVO = null;
         var _loc1_:int = this.model.listItems.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = BuildingProcessListItemVO(this.model.listItems[_loc2_]);
            if(_loc3_.buildingStatus == BUILDING_STATUS_AVAILABLE)
            {
               this.buildingList.selectListItemByUniqKey("buildingID",_loc3_.buildingID);
               requestBuildingInfoS(_loc3_.buildingID);
               break;
            }
            _loc2_++;
         }
      }
      
      private function onClickItemHandler(param1:SortableTableListEvent) : void {
         var _loc2_:BuildingProcessListItemVO = this.buildingList.getListSelectedItem() as BuildingProcessListItemVO;
         App.utils.asserter.assertNotNull(_loc2_," [selectItem] buildingId can\'t be NULL " + Errors.CANT_NULL);
         requestBuildingInfoS(_loc2_.buildingID);
      }
      
      private function buyBuildingHandler(param1:Event) : void {
         var _loc2_:String = BuildingProcessInfo(param1.target).getBuildingId();
         App.utils.asserter.assertNotNull(_loc2_," [buyBuilding] buildingId can\'t be NULL " + Errors.CANT_NULL);
         if(_loc2_)
         {
            applyBuildingProcessS(_loc2_);
         }
      }
      
      private function requestFocusHandler(param1:FocusRequestEvent) : void {
         setFocus(param1.focusContainer.getComponentForFocus());
         this.buildingInfo.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.requestFocusHandler);
      }
      
      private function onDoubleClickItemHandler(param1:SortableTableListEvent) : void {
         var _loc2_:BuildingProcessListItemVO = this.buildingList.getListSelectedItem() as BuildingProcessListItemVO;
         App.utils.asserter.assertNotNull(_loc2_," [doubleCLICK on buildingItem] BuildingProcessListItemVO can\'t be NULL " + Errors.CANT_NULL);
         if((_loc2_.buildingID) && _loc2_.buildingStatus == BUILDING_STATUS_AVAILABLE)
         {
            applyBuildingProcessS(_loc2_.buildingID);
         }
      }
   }
}
