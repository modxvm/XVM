package net.wg.gui.rally.views.list
{
   import net.wg.infrastructure.base.meta.impl.BaseRallyListViewMeta;
   import net.wg.infrastructure.base.meta.IBaseRallyListViewMeta;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.data.VoDAAPIDataProvider;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.rally.interfaces.IRallyListItemVO;
   import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class BaseRallyListView extends BaseRallyListViewMeta implements IBaseRallyListViewMeta
   {
      
      public function BaseRallyListView() {
         super();
      }
      
      public var rallyTable:SortableTable;
      
      public var detailsSection:BaseRallyDetailsSection;
      
      protected var listDataProvider:VoDAAPIDataProvider;
      
      protected function convertToRallyVO(param1:Object) : IRallyVO {
         return null;
      }
      
      protected function getRallyTooltipLinkage() : String {
         return null;
      }
      
      public function as_selectByIndex(param1:int) : void {
         if(this.rallyTable.listSelectedIndex != param1)
         {
            this.rallyTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectRally);
            this.rallyTable.listSelectedIndex = param1;
            this.rallyTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectRally);
         }
         this.requestRallyData(param1);
      }
      
      public function as_selectByID(param1:Number) : void {
         var _loc2_:IRallyListItemVO = null;
         for each(_loc2_ in this.rallyTable.listDP)
         {
            if(_loc2_.mgrID == param1)
            {
               this.rallyTable.listSelectedIndex = this.rallyTable.listDP.indexOf(_loc2_);
               getRallyDetailsS(_loc2_.rallyIndex);
               return;
            }
         }
         this.detailsSection.setData(null);
         this.rallyTable.listSelectedIndex = -1;
      }
      
      public function as_getSearchDP() : Object {
         return this.listDataProvider;
      }
      
      public function as_setVehiclesTitle(param1:String) : void {
         this.detailsSection.vehiclesLabel = param1;
      }
      
      override protected function configUI() : void {
         if(this.rallyTable)
         {
            this.rallyTable.listSelectedIndex = -1;
         }
         super.configUI();
         if(this.rallyTable)
         {
            this.rallyTable.listDP = this.listDataProvider;
            this.listDataProvider.addEventListener(ManualSearchEvent.DATA_UPDATED,this.handleDataUpdated,false,0,true);
            this.rallyTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectRally);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onListItemDoubleClick);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_ROLL_OVER,this.onItemRollOver);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_ROLL_OUT,onControlRollOut);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_PRESS,this.onListItemPress);
         }
         if(this.detailsSection)
         {
            this.detailsSection.addEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRequest);
            this.detailsSection.addEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onJoinRequest);
         }
      }
      
      override protected function onDispose() : void {
         if(this.rallyTable)
         {
            this.listDataProvider.removeEventListener(ManualSearchEvent.DATA_UPDATED,this.handleDataUpdated);
            this.listDataProvider = null;
            this.rallyTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectRally);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onListItemDoubleClick);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_ROLL_OVER,this.onItemRollOver);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_ROLL_OUT,onControlRollOut);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_PRESS,this.onListItemPress);
            this.rallyTable.dispose();
            this.rallyTable = null;
         }
         if(this.detailsSection)
         {
            this.detailsSection.removeEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRequest);
            this.detailsSection.removeEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onJoinRequest);
            this.detailsSection.dispose();
            this.detailsSection = null;
         }
         App.utils.scheduler.cancelTask(this.requestRallyData);
         super.onDispose();
      }
      
      protected function onSelectRally(param1:SortableTableListEvent) : void {
         var _loc2_:int = param1.index;
         if(!isNaN(_loc2_))
         {
            App.utils.scheduler.envokeInNextFrame(this.requestRallyData,_loc2_);
         }
      }
      
      protected function requestRallyData(param1:int) : void {
         var _loc2_:Object = getRallyDetailsS(param1);
         this.detailsSection.setData(_loc2_ != null?this.convertToRallyVO(_loc2_):null);
      }
      
      protected function onListItemDoubleClick(param1:SortableTableListEvent) : void {
         var _loc3_:Object = null;
         var _loc2_:IRallyListItemVO = param1.itemData as IRallyListItemVO;
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON && (_loc2_))
         {
            _loc3_ = 
               {
                  "alias":getRallyViewAlias(),
                  "itemId":_loc2_.mgrID,
                  "peripheryID":_loc2_.peripheryID,
                  "slotIndex":-1
               };
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
         }
      }
      
      protected function onListItemPress(param1:SortableTableListEvent) : void {
         App.toolTipMgr.hide();
      }
      
      protected function onItemRollOver(param1:SortableTableListEvent) : void {
         var _loc2_:IRallyListItemVO = param1.itemData as IRallyListItemVO;
         if(_loc2_)
         {
            App.toolTipMgr.showSpecial(this.getRallyTooltipLinkage(),null,_loc2_.mgrID);
         }
      }
      
      protected function onJoinRequest(param1:RallyViewsEvent) : void {
         var _loc3_:Object = null;
         var _loc2_:IRallyListItemVO = this.rallyTable.getListSelectedItem() as IRallyListItemVO;
         if((_loc2_) && !(_loc2_.mgrID == 0))
         {
            _loc3_ = 
               {
                  "alias":getRallyViewAlias(),
                  "itemId":_loc2_.mgrID,
                  "peripheryID":_loc2_.peripheryID,
                  "slotIndex":(param1.data?param1.data:-1)
               };
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
         }
      }
      
      private function handleDataUpdated(param1:ManualSearchEvent) : void {
         var _loc2_:Number = Math.min(Math.max(0,this.listDataProvider.length - this.rallyTable.totalRenderers),this.rallyTable.scrollPosition);
         IManualSearchDataProvider(this.listDataProvider).requestUpdatedItems(_loc2_,Math.min(this.listDataProvider.length - 1,_loc2_ + this.rallyTable.totalRenderers - 1),this.updateData);
      }
      
      private function updateData(param1:Array) : void {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:IUpdatable = null;
         var _loc2_:int = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = param1[_loc6_];
            _loc3_ = _loc4_[0];
            _loc5_ = this.rallyTable.getRendererAt(_loc3_,this.rallyTable.scrollPosition) as IUpdatable;
            if(_loc5_)
            {
               _loc5_.update(_loc4_[1]);
            }
            _loc6_++;
         }
      }
   }
}
