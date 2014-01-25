package net.wg.gui.lobby.customization
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollingListAutoScroll;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
   import scaleform.clik.events.ListEvent;
   import flash.events.MouseEvent;
   import flash.display.InteractiveObject;


   public class BaseTimedCustomizationSectionView extends UIComponent implements IViewStackContent
   {
          
      public function BaseTimedCustomizationSectionView() {
         super();
         this.form = VehicleCustomization.instance;
         this.currentItemData = this.getEmptyDataItem();
         this.newItemData = this.getEmptyDataItem();
         this._groupsDataProvider = this.getGroupsDP();
         this._groupsDataProvider.triggerInvalidation();
      }

      public static const CAMOUFLAGE:String = "camouflage";

      public static const CAMOUFLAGE_GROUP_VIEW:String = "CamouflageGroupViewUI";

      public static const EMBLEM_LEFT:String = "emblemLeft";

      public static const EMBLEM_RIGHT:String = "emblemRight";

      public static const EMBLEM_GROUP_VIEW:String = "EmblemGroupViewUI";

      public static const EMBLEM_GROUP_VIEW_COPY:String = "EmblemGroupViewUICopy";

      public static const INSCRIPTION_LEFT:String = "inscriptionLeft";

      public static const INSCRIPTION_RIGHT:String = "inscriptionRight";

      public static const INSCRIPTION_GROUP_VIEW:String = "InscriptionGroupViewUI";

      public static const INSCRIPTION_GROUP_VIEW_COPY:String = "InscriptionGroupViewUICopy";

      public var form:VehicleCustomization = null;

      public var view:BaseTimedCustomizationGroupView = null;

      public var currentItemRenderer:CustomizationItemRenderer = null;

      public var newItemRenderer:CustomizationItemRenderer = null;

      public var dropButton:CamoDropButton = null;

      public var timeLeftField:TextField = null;

      public var list:ScrollingListAutoScroll = null;

      private var _currentItemData:Object = null;

      private var _newItemData:Object = null;

      protected var _groupsDataProvider:DAAPIDataProvider = null;

      private var _data:Object = null;

      public function onCurrentChanged() : void {
         this.requestCurrentItem();
         if(this.view != null)
         {
            this.view.invalidateListData();
         }
      }

      public function onChangeSuccess() : void {
         if((this.newItemData) && (this.newItemData.id))
         {
            this.currentItemData = this.newItemData;
            this.currentItemRenderer.setData(this.currentItemData);
            this.currentItemRenderer.enabled = true;
            if(this.dropButton != null)
            {
               this.dropButton.visible = true;
            }
            if(this.timeLeftField != null)
            {
               this.timeLeftField.text = "";
            }
            this.newItemData = this.getEmptyDataItem();
            this.newItemRenderer.setData(this.newItemData);
            this.newItemRenderer.enabled = false;
            if(this.view != null)
            {
               this.view.invalidateListData(true);
            }
         }
      }

      public function onDropSuccess() : void {
         this.currentItemData = this.getEmptyDataItem();
         this.currentItemRenderer.setData(this.currentItemData);
         this.currentItemRenderer.enabled = false;
         if(this.dropButton != null)
         {
            this.dropButton.visible = false;
         }
         if(this.timeLeftField != null)
         {
            this.timeLeftField.text = "";
         }
         if(this.view != null)
         {
            this.view.invalidateListData(true);
         }
         this.requestCurrentItem();
      }

      public function get currentItemData() : Object {
         return this._currentItemData;
      }

      public function set currentItemData(param1:Object) : void {
         this._currentItemData = param1;
      }

      public function get newItemData() : Object {
         return this._newItemData;
      }

      public function set newItemData(param1:Object) : void {
         this._newItemData = param1;
      }

      public function requestCurrentItem() : void {
         this.currentItemData = this.form.getCurrentItemS(this.getSectionName());
         if((this.currentItemData) && !(this.timeLeftField == null))
         {
            this.timeLeftField.text = this.currentItemData.timeLeft;
         }
         this.currentItemRenderer.setData(this.currentItemData);
         var _loc1_:Boolean = (this.currentItemData) && this.currentItemData.id == null;
         if(!_loc1_ && (this.currentItemData.hasOwnProperty("canDrop")))
         {
            _loc1_ = !Boolean(this.currentItemData.canDrop);
         }
         this.currentItemRenderer.enabled = !_loc1_;
         if(this.dropButton != null)
         {
            this.dropButton.visible = !_loc1_;
            this.dropButton.enabled = !(this.form == null) && !this.form.isActionsLocked();
         }
      }

      public function requestItemAt(param1:int) : void {
         var _loc3_:Object = null;
         var _loc2_:Object = this._groupsDataProvider.requestItemAt(param1);
         if((this.view) && (_loc2_))
         {
            this.view.selectedGroupName = _loc2_.name;
            if(this.form != null)
            {
               _loc3_ = this.form.getSectionData(this.getSectionName());
               if(_loc3_ != null)
               {
                  this.view.setListSelectedIndex(_loc3_.groupName,_loc2_.isIGR,_loc3_._new);
               }
               else
               {
                  this.view.setListSelectedIndex(_loc2_.name,_loc2_.isIGR,null);
               }
            }
            this.view.invalidateListData(false);
         }
      }

      public function onGetTimeLeftString(param1:String) : void {
         this.timeLeftField.text = param1;
      }

      public function getListLabelFieldName() : String {
         return "userString";
      }

      public function getEmptyDataItem() : Object {
         return null;
      }

      public function getGroupsDP() : DAAPIDataProvider {
         return null;
      }

      public function getItemsDP() : DAAPIItemsDataProvider {
         return null;
      }

      public function getRentalPackagesDP() : RentalPackageDAAPIDataProvider {
         return null;
      }

      public function getViewLinkage() : String {
         return "";
      }

      public function getTimeSectionLabel() : String {
         return "";
      }

      public function getDropButtonTooltip() : String {
         return "";
      }

      public function getSectionName() : String {
         return "";
      }

      override protected function onDispose() : void {
         if(this.form != null)
         {
            this.form.removeEventListener(CustomizationEvent.CHANGE_ACTIONS_LOCK,this.onChangeActionLock);
            this.form.removeEventListener(CustomizationEvent.RESET_NEW_ITEM,this.onResetNewItem);
            this.form = null;
         }
         if(this.view)
         {
            this.view.removeEventListener(CustomizationEvent.SELECT_NEW,this.onSelectNewItem);
            this.view = null;
         }
         if(this.list != null)
         {
            this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.handleChangeGroupSelectedIndex);
            this.list.dataProvider = null;
            this.list.dispose();
            this.list = null;
         }
         if(this.currentItemRenderer != null)
         {
            this.currentItemRenderer.setData(null);
            this.currentItemRenderer.dispose();
            this.currentItemRenderer = null;
         }
         if(this.dropButton != null)
         {
            this.dropButton.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverDropButton);
            this.dropButton.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutDropButton);
            this.dropButton.removeEventListener(CustomizationEvent.DROP_ITEM,this.onClickDropButton);
            this.dropButton.dispose();
            this.dropButton = null;
         }
         if(this.newItemRenderer != null)
         {
            this.newItemRenderer.setData(null);
            this.newItemRenderer.dispose();
            this.newItemRenderer = null;
         }
         this._currentItemData = null;
         this._newItemData = null;
         this._groupsDataProvider = null;
         this._data = null;
         super.onDispose();
      }

      public function update(param1:Object) : void {
         this._data = param1;
      }

      public function get data() : Object {
         return this._data;
      }

      public function lockControls(param1:Boolean) : void {
         this.dropButton.enabled = !param1;
      }

      public function refreshSelection(param1:Boolean=false) : void {
         var _loc4_:* = 0;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Number = 0;
         var _loc3_:Object = this.form.getSectionData(this.getSectionName());
         if(_loc3_ != null)
         {
            if(_loc3_._new.id != null)
            {
               this.newItemData = _loc3_._new;
            }
            if(_loc3_.selectedGroupIdx != null)
            {
               _loc2_ = _loc3_.selectedGroupIdx;
            }
         }
         var _loc5_:int = this._groupsDataProvider.length;
         if(!this._groupsDataProvider.requestItemAt(_loc2_).enabled)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = this._groupsDataProvider.requestItemAt(_loc4_);
               if(_loc6_.enabled)
               {
                  _loc2_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
         this.list.selectedIndex = _loc2_;
         if(((param1) && (this.view)) && (this.view.rentalPackageDP) && (this.view.rentalPackageList))
         {
            _loc7_ = this.view.rentalPackageDP.requestItemAt(this.view.rentalPackageList.selectedIndex);
            if((_loc7_) && !_loc7_.enabled)
            {
               _loc5_ = this.view.rentalPackageDP.length;
               _loc4_ = 0;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = this.view.rentalPackageDP.requestItemAt(_loc4_);
                  if(_loc6_.enabled)
                  {
                     this.view.rentalPackageList.selectedIndex = _loc4_;
                     break;
                  }
                  _loc4_++;
               }
            }
         }
      }

      override protected function configUI() : void {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         mouseChildren = true;
         mouseEnabled = true;
         if(this.form != null)
         {
            _loc1_ = this.form.getSectionData(this.getSectionName());
            if(_loc1_ != null)
            {
               if(_loc1_._new.id != null)
               {
                  this.newItemData = _loc1_._new;
               }
            }
            this.form.addEventListener(CustomizationEvent.CHANGE_ACTIONS_LOCK,this.onChangeActionLock);
            this.form.addEventListener(CustomizationEvent.RESET_NEW_ITEM,this.onResetNewItem);
            _loc2_ = this.getViewLinkage();
            this.view = BaseTimedCustomizationGroupView(this.form.showView(_loc2_));
            this.view.timeLabel = this.getTimeSectionLabel();
            this.view.itemsDP = this.getItemsDP();
            this.view.rentalPackageDP = this.getRentalPackagesDP();
            this.view.rentalPackageDP.triggerInvalidation();
            this.view.addEventListener(CustomizationEvent.SELECT_NEW,this.onSelectNewItem);
            this.view.initData();
         }
         if(this.list != null)
         {
            this.list.labelField = this.getListLabelFieldName();
            this.list.dataProvider = this._groupsDataProvider;
            this.refreshSelection();
            this.list.addEventListener(ListEvent.INDEX_CHANGE,this.handleChangeGroupSelectedIndex);
         }
         if(this.currentItemRenderer != null)
         {
            this.currentItemRenderer.setData(this.currentItemData);
            this.currentItemRenderer.enabled = false;
         }
         if(this.dropButton != null)
         {
            this.dropButton.visible = false;
            this.dropButton.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverDropButton);
            this.dropButton.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutDropButton);
            this.dropButton.addEventListener(CustomizationEvent.DROP_ITEM,this.onClickDropButton);
         }
         if(this.newItemRenderer != null)
         {
            this.newItemRenderer.setData(this.newItemData);
            this.newItemRenderer.enabled = (this.newItemData) && (this.newItemData.id);
         }
         super.configUI();
         this.requestCurrentItem();
      }

      protected function handleChangeGroupSelectedIndex(param1:ListEvent) : void {
         this.requestItemAt(param1.index);
      }

      private function setNewItemView(param1:int, param2:Object, param3:int) : void {
         var _loc4_:* = 0;
         _loc4_ = param2.id;
         if(this.currentItemData.id == _loc4_)
         {
            this.newItemData = this.getEmptyDataItem();
            param1 = -1;
         }
         else
         {
            this.newItemData = param2;
         }
         this.newItemData.index = param1;
         this.newItemData.priceIndex = this.view.selectedPriceIdx;
         this.newItemRenderer.setData(this.newItemData);
         this.newItemRenderer.enabled = !(param1 == -1);
         this.form.setNewItemIdS(this.getSectionName(),_loc4_,param3,this.view.selectedPriceIdx);
         this.form.setSectionData(this.getSectionName(),!(param1 == -1),
            {
               "selectedIdx":param1,
               "selectedGroupIdx":this.list.selectedIndex,
               "groupName":this.view.selectedGroupName,
               "price":this.newItemData.price,
               "_new":this.newItemData,
               "isIGR":this._groupsDataProvider.requestItemAt(this.list.selectedIndex).isIGR
            }
         );
      }

      private function onSelectNewItem(param1:CustomizationEvent) : void {
         this.setNewItemView(param1.index,param1.data,0);
      }

      private function onRollOverDropButton(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(this.getDropButtonTooltip());
      }

      private function onRollOutDropButton(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onChangeActionLock(param1:CustomizationEvent) : void {
         this.dropButton.enabled = !param1.locked;
      }

      private function onResetNewItem(param1:CustomizationEvent) : void {
         this.newItemData = this.getEmptyDataItem();
         this.newItemRenderer.setData(this.newItemData);
         this.newItemRenderer.enabled = false;
         if(this.view != null)
         {
            this.view.list.selectedIndex = -1;
         }
      }

      private function onClickDropButton(param1:CustomizationEvent) : void {
         App.toolTipMgr.hide();
         if(this.form)
         {
            this.form.dropCurrentItemInSection(this.getSectionName(),param1.kind);
         }
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}