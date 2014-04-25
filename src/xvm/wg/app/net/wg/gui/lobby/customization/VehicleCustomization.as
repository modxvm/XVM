package net.wg.gui.lobby.customization
{
   import net.wg.infrastructure.base.meta.impl.VehicleCustomizationMeta;
   import net.wg.infrastructure.base.meta.IVehicleCustomizationMeta;
   import net.wg.gui.events.AccordionRendererEvent;
   import flash.events.Event;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.components.advanced.Accordion;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.customization.data.CamouflagesDataProvider;
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import net.wg.gui.events.LobbyEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ListEvent;


   public class VehicleCustomization extends VehicleCustomizationMeta implements IVehicleCustomizationMeta
   {
          
      public function VehicleCustomization() {
         super();
         _instance = this;
         this._sectionsDataProvider = new DataProvider();
         this._priceDataProvider = new DataProvider();
         this.camouflageDP = new CamouflagesDataProvider([]);
         this.emblemLeftDP = new DAAPIItemsDataProvider([]);
         this.emblemRightDP = new DAAPIItemsDataProvider([]);
         this.inscriptionLeftDP = new DAAPIItemsDataProvider([]);
         this.inscriptionRightDP = new DAAPIItemsDataProvider([]);
         this.camouflageGroupsDataProvider = new DAAPIDataProvider();
         this.camouflageRentalPackageDP = new RentalPackageDAAPIDataProvider();
         this.emblemLeftGroupsDataProvider = new DAAPIDataProvider();
         this.emblemRightGroupsDataProvider = new DAAPIDataProvider();
         this.emblemLeftRentalPackageDP = new RentalPackageDAAPIDataProvider();
         this.emblemRightRentalPackageDP = new RentalPackageDAAPIDataProvider();
         this.inscriptionLeftGroupsDataProvider = new DAAPIDataProvider();
         this.inscriptionRightGroupsDataProvider = new DAAPIDataProvider();
         this.inscriptionLeftRentalPackageDP = new RentalPackageDAAPIDataProvider();
         this.inscriptionRightRentalPackageDP = new RentalPackageDAAPIDataProvider();
         this._sectionsData = {};
      }

      private static var _instance:VehicleCustomization = null;

      public static function get instance() : VehicleCustomization {
         return _instance;
      }

      private static function showToolTip(param1:AccordionRendererEvent) : void {
         if(!param1.target.enabled && (App.globalVarsMgr.isInRoamingS()))
         {
            App.toolTipMgr.show(TOOLTIPS.CUSTOMIZATION_TABS_INROAMING);
         }
      }

      private static function hideToolTip(param1:Event) : void {
         App.toolTipMgr.hide();
      }

      private const SECTION_VIEW:String = "SectionView";

      public var textColor:Number = 16777215;

      public var errorColor:Number = 16711680;

      public var background:MovieClip = null;

      public var titleBtn:TextFieldShort = null;

      public var windowCloseButton:CloseButton = null;

      public var accordion:Accordion = null;

      public var currentView:ViewStack = null;

      public var priceList:TileList = null;

      public var totalCreditsField:IconText = null;

      public var totalGoldField:IconText = null;

      public var applyButton:SoundButtonEx = null;

      public var closeButton:SoundButtonEx = null;

      public var camouflageDP:CamouflagesDataProvider = null;

      public var emblemLeftDP:DAAPIItemsDataProvider = null;

      public var emblemRightDP:DAAPIItemsDataProvider = null;

      public var inscriptionLeftDP:DAAPIItemsDataProvider = null;

      public var inscriptionRightDP:DAAPIItemsDataProvider = null;

      public var camouflageRentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var emblemLeftRentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var emblemRightRentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var inscriptionLeftRentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var inscriptionRightRentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var camouflageGroupsDataProvider:DAAPIDataProvider = null;

      public var emblemLeftGroupsDataProvider:DAAPIDataProvider = null;

      public var emblemRightGroupsDataProvider:DAAPIDataProvider = null;

      public var inscriptionLeftGroupsDataProvider:DAAPIDataProvider = null;

      public var inscriptionRightGroupsDataProvider:DAAPIDataProvider = null;

      private var _sectionsDataProvider:DataProvider = null;

      private var _priceDataProvider:DataProvider = null;

      private var _selectedSections:Array = null;

      private var _sectionsData:Object = null;

      private var _actionsLocked:Boolean = false;

      private var _accountCredits:Number;

      private var _accountGold:Number;

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(param1.details.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeWindowS();
         }
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         y = param2 - this.background.height + 13;
      }

      public function showView(param1:String) : MovieClip {
         return this.currentView.show(param1);
      }

      public function as_onServerResponsesReceived() : void {
         var _loc1_:Object = null;
         var _loc2_:Number = 0;
         while(_loc2_ < this._priceDataProvider.length)
         {
            _loc1_ = this._priceDataProvider[_loc2_];
            _loc1_.price = null;
            _loc1_.selected = false;
            _loc1_.enabled = false;
            _loc2_++;
         }
         this._priceDataProvider.invalidate();
         this.totalCreditsField.textColor = this.textColor;
         this.totalCreditsField.text = App.utils.locale.integer(0);
         this.totalGoldField.textColor = this.textColor;
         this.totalGoldField.text = App.utils.locale.gold(0);
         this._sectionsData = {};
         this.applyButton.enabled = false;
      }

      public function as_onInit(param1:Array) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         if(param1.length > 0)
         {
            _loc3_ = param1.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = param1[_loc2_];
               _loc5_ = _loc4_.sectionName;
               this._sectionsDataProvider.push(
                  {
                     "label":_loc4_.sectionLabel,
                     "section":_loc5_,
                     "data":_loc5_ + this.SECTION_VIEW,
                     "linkage":_loc4_.linkage,
                     "enabled":_loc4_.enabled
                  }
               );
               this._priceDataProvider.push(
                  {
                     "label":_loc4_.priceLabel,
                     "section":_loc5_,
                     "price":
                        {
                           "isGold":false,
                           "cost":0
                        }
                     ,
                     "priceOverride":null,
                     "selected":false,
                     "enabled":false,
                     "type":_loc4_.type
                  }
               );
               _loc2_++;
            }
            this.accordion.invalidate();
            this._priceDataProvider.invalidate();
         }
      }

      public function as_setActionsLocked(param1:Boolean) : void {
         if(this._actionsLocked == param1)
         {
            return;
         }
         this._actionsLocked = param1;
         this.calculateTotalPrice();
         var _loc2_:CustomizationEvent = new CustomizationEvent(CustomizationEvent.CHANGE_ACTIONS_LOCK);
         _loc2_.locked = param1;
         dispatchEvent(_loc2_);
      }

      public function as_onChangeSuccess() : void {
         this.accordion.view.currentView.onChangeSuccess();
      }

      public function as_onCurrentChanged(param1:String) : void {
         if(param1 == this._sectionsDataProvider[this.accordion.selectedIndex].section)
         {
            this.accordion.view.currentView.onCurrentChanged();
         }
      }

      public function as_onDropSuccess() : void {
         this.accordion.view.currentView.onDropSuccess();
      }

      public function as_onResetNewItem() : void {
         this.as_onServerResponsesReceived();
         this.accordion.view.currentView.dispatchEvent(new CustomizationEvent(CustomizationEvent.RESET_NEW_ITEM));
      }

      public function as_setCredits(param1:Number) : void {
         this._accountCredits = param1;
         this.calculateTotalPrice();
      }

      public function as_setGold(param1:Number) : void {
         this._accountGold = param1;
         this.calculateTotalPrice();
      }

      public function as_refreshData() : void {
         this._sectionsData = {};
         this.camouflageRentalPackageDP.invalidate();
         this.emblemLeftRentalPackageDP.invalidate();
         this.emblemRightRentalPackageDP.invalidate();
         this.inscriptionLeftRentalPackageDP.invalidate();
         this.inscriptionRightRentalPackageDP.invalidate();
         this.camouflageGroupsDataProvider.invalidate();
         this.emblemLeftGroupsDataProvider.invalidate();
         this.emblemRightGroupsDataProvider.invalidate();
         this.inscriptionLeftGroupsDataProvider.invalidate();
         this.inscriptionRightGroupsDataProvider.invalidate();
         this.as_refreshItemsData();
         this.accordion.view.currentView.refreshSelection(true);
      }

      public function as_refreshItemsData() : void {
         this.camouflageDP.invalidateRemote(true);
         this.emblemLeftDP.invalidateRemote(true);
         this.emblemRightDP.invalidateRemote(true);
         this.inscriptionLeftDP.invalidateRemote(true);
         this.inscriptionRightDP.invalidateRemote(true);
      }

      public function isActionsLocked() : Boolean {
         return this._actionsLocked;
      }

      public function getSectionData(param1:String) : Object {
         return this._sectionsData[param1];
      }

      public function resetSectionData(param1:String) : void {
         this._sectionsData[param1] = null;
      }

      public function setSectionData(param1:String, param2:Boolean, param3:Object) : void {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Object = null;
         var _loc12_:Object = null;
         var _loc13_:* = false;
         this._sectionsData[param1] = param3;
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < this._priceDataProvider.length)
         {
            _loc10_ = this._priceDataProvider[_loc8_];
            if((_loc10_.hasOwnProperty("fake")) && _loc10_.section == param1)
            {
               _loc5_ = _loc10_;
               break;
            }
            _loc8_++;
         }
         if(_loc5_ != null)
         {
            this._priceDataProvider.splice(_loc8_,1);
            _loc5_ = null;
         }
         var _loc11_:Object = null;
         _loc8_ = 0;
         while(_loc8_ < this._priceDataProvider.length)
         {
            _loc10_ = this._priceDataProvider[_loc8_];
            if(_loc10_.section != param1)
            {
               if(this._sectionsData[_loc10_.section])
               {
                  _loc11_ = this._sectionsData[_loc10_.section]._new;
               }
            }
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < this._priceDataProvider.length)
         {
            _loc10_ = this._priceDataProvider[_loc8_];
            if(this._sectionsData[_loc10_.section])
            {
               _loc11_ = this._sectionsData[_loc10_.section]._new;
            }
            if(_loc10_.section == param1)
            {
               if(param3.price  is  Array && param3.price.length > 0)
               {
                  _loc9_ = 0;
                  while(_loc9_ < param3.price.length)
                  {
                     _loc4_ = param3.price[_loc9_];
                     if(_loc4_.isGold)
                     {
                        _loc6_.push(_loc4_);
                     }
                     else
                     {
                        _loc7_.push(_loc4_);
                     }
                     _loc9_++;
                  }
                  if(_loc6_.length > 0 && _loc7_.length > 0)
                  {
                     _loc5_ =
                        {
                           "label":_loc10_.label,
                           "section":_loc10_.section,
                           "price":this.getSumCost(_loc7_),
                           "priceOverride":null,
                           "selected":true,
                           "enabled":true,
                           "fake":true
                        }
                     ;
                     _loc10_.price = this.getSumCost(_loc6_);
                  }
                  else
                  {
                     _loc10_.price = this.getSumCost(param3.price);
                  }
               }
               else
               {
                  _loc10_.price = param3.price;
               }
               _loc10_.selected = param2;
               if(param3.hasOwnProperty("selectedItems"))
               {
                  _loc13_ = false;
                  for each (_loc12_ in param3.selectedItems)
                  {
                     if(_loc12_)
                     {
                        _loc13_ = _loc12_.id > 0;
                     }
                     if(_loc13_)
                     {
                        break;
                     }
                  }
                  _loc10_.enabled = _loc13_;
               }
               else
               {
                  _loc10_.enabled = param3._new.id > 0;
               }
            }
            _loc8_++;
         }
         if(_loc5_ != null)
         {
            this._priceDataProvider.splice(0,0,_loc5_);
         }
         this._priceDataProvider.invalidate();
         this.calculateTotalPrice();
      }

      override protected function configUI() : void {
         super.configUI();
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         this.windowCloseButton.addEventListener(ButtonEvent.CLICK,this.onWindowClose);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onWindowClose);
         this.accordion.addEventListener(IndexEvent.INDEX_CHANGE,this.onViewChange,false,-100);
         this.accordion.addEventListener(MouseEvent.CLICK,hideToolTip);
         this.accordion.addEventListener(AccordionRendererEvent.ACCORDION_RENDERER_ROLL_OVER,showToolTip);
         this.accordion.addEventListener(AccordionRendererEvent.ACCORDION_RENDERER_ROLL_OUT,hideToolTip);
         this.accordion.view.cache = true;
         this.accordion.buttonWidth = this.accordion.width;
         this.accordion.dataProvider = this._sectionsDataProvider;
         this.accordion.selectedIndex = 0;
         this.priceList.dataProvider = this._priceDataProvider;
         this.priceList.addEventListener(ListEvent.ITEM_CLICK,this.handleClickPriceItem);
         this.applyButton.enabled = false;
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyButton);
         setFocus(this.closeButton);
      }

      override protected function onDispose() : void {
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         this.windowCloseButton.removeEventListener(ButtonEvent.CLICK,this.onWindowClose);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onWindowClose);
         this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyButton);
         this.accordion.removeEventListener(IndexEvent.INDEX_CHANGE,this.onViewChange);
         this.accordion.addEventListener(MouseEvent.CLICK,hideToolTip);
         this.accordion.removeEventListener(MouseEvent.ROLL_OVER,showToolTip);
         this.accordion.removeEventListener(MouseEvent.ROLL_OUT,hideToolTip);
         this.accordion.dispose();
         this.accordion = null;
         this.priceList.removeEventListener(ListEvent.ITEM_CLICK,this.handleClickPriceItem);
         this.priceList.dispose();
         this.priceList = null;
         this.currentView.dispose();
         this.currentView = null;
         _instance = null;
         this._sectionsDataProvider.cleanUp();
         this._sectionsDataProvider = null;
         this._priceDataProvider.cleanUp();
         this._priceDataProvider = null;
         this.camouflageDP = null;
         this.emblemLeftDP = null;
         this.emblemRightDP = null;
         this.inscriptionLeftDP = null;
         this.inscriptionRightDP = null;
         this.camouflageGroupsDataProvider = null;
         this.camouflageRentalPackageDP = null;
         this.emblemLeftGroupsDataProvider = null;
         this.emblemRightGroupsDataProvider = null;
         this.emblemLeftRentalPackageDP = null;
         this.emblemRightRentalPackageDP = null;
         this.inscriptionLeftGroupsDataProvider = null;
         this.inscriptionRightGroupsDataProvider = null;
         this.inscriptionLeftRentalPackageDP = null;
         this.inscriptionRightRentalPackageDP = null;
         this._sectionsData = null;
         this._selectedSections.splice(0);
         this._selectedSections = null;
         super.onDispose();
      }

      private function onViewChange(param1:IndexEvent) : void {
         if((this.accordion.view.currentView) && (this.accordion.view.currentView.initialized))
         {
            this.showView(this.accordion.view.currentView.getViewLinkage());
            this.accordion.view.currentView.refreshSelection(true);
            this.accordion.view.currentView.requestCurrentItem();
         }
      }

      private function onWindowClose(param1:ButtonEvent) : void {
         closeWindowS();
      }

      private function handleClickPriceItem(param1:ListEvent) : void {
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc2_:Object = param1.itemData;
         var _loc3_:Boolean = _loc2_.price.isGold;
         var _loc4_:String = _loc2_.section;
         if(_loc4_ == BaseTimedCustomizationSectionView.CAMOUFLAGE)
         {
            _loc5_ = this.getSectionData(_loc4_).selectedItems;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc6_ = _loc5_[_loc7_];
               if((_loc6_) && _loc3_ == _loc6_.price.isGold)
               {
                  _loc8_ = _loc2_.selected?_loc6_.id:-1;
                  setNewItemIdS(_loc2_.section,_loc8_,_loc7_,_loc6_.priceIndex);
               }
               _loc7_++;
            }
         }
         this.calculateTotalPrice();
      }

      private function onClickApplyButton(param1:ButtonEvent) : void {
         applyCustomizationS(this._selectedSections);
      }

      private function getSumCost(param1:Array) : Object {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc2_:Object =
            {
               "isGold":false,
               "cost":0
            }
         ;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc2_.isGold = _loc4_.isGold;
            _loc2_.cost = _loc2_.cost + _loc4_.cost;
            _loc3_++;
         }
         return _loc2_;
      }

      private function calculateTotalPrice() : void {
         var _loc6_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:* = NaN;
         var _loc11_:Object = null;
         var _loc12_:* = NaN;
         var _loc13_:Object = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:* = false;
         var _loc4_:* = true;
         var _loc5_:* = true;
         var _loc7_:Object = {};
         _loc10_ = 0;
         while(_loc10_ < this._priceDataProvider.length)
         {
            _loc8_ = this._priceDataProvider[_loc10_];
            _loc8_.priceOverride = null;
            if(!(_loc8_.type  in  _loc7_))
            {
               _loc7_[_loc8_.type] = [];
            }
            if((_loc8_) && (_loc8_.price.isGold))
            {
               _loc9_ = this._sectionsData[_loc8_.section]._new;
               if((_loc9_) && _loc7_[_loc8_.type].indexOf(_loc9_.id) == -1)
               {
                  _loc7_[_loc8_.type].push(_loc9_.id);
               }
               else
               {
                  if(_loc9_)
                  {
                     _loc8_.priceOverride =
                        {
                           "isGold":true,
                           "cost":0
                        }
                     ;
                  }
               }
            }
            _loc10_++;
         }
         this._selectedSections = [];
         _loc10_ = 0;
         while(_loc10_ < this._priceDataProvider.length)
         {
            _loc11_ = this._priceDataProvider[_loc10_];
            if(_loc11_.selected)
            {
               _loc3_ = false;
               _loc6_ = _loc11_.priceOverride?_loc11_.priceOverride:_loc11_.price;
               if(_loc6_ != null)
               {
                  if(_loc6_  is  Array)
                  {
                     _loc12_ = 0;
                     while(_loc12_ < _loc6_.lengh)
                     {
                        _loc13_ = _loc6_[_loc12_];
                        if(_loc13_ != null)
                        {
                           if(_loc6_.isGold)
                           {
                              _loc3_ = true;
                              _loc2_ = _loc2_ + _loc13_.cost;
                           }
                           else
                           {
                              _loc1_ = _loc1_ + _loc13_.cost;
                           }
                        }
                        _loc12_++;
                     }
                  }
                  else
                  {
                     if(_loc6_.isGold)
                     {
                        _loc3_ = true;
                        _loc2_ = _loc2_ + _loc6_.cost;
                     }
                     else
                     {
                        _loc1_ = _loc1_ + _loc6_.cost;
                     }
                  }
               }
               this._selectedSections.push(
                  {
                     "sectionName":_loc11_.section,
                     "isGold":_loc3_
                  }
               );
            }
            _loc10_++;
         }
         if(_loc1_ <= this._accountCredits)
         {
            this.totalCreditsField.textColor = this.textColor;
         }
         else
         {
            this.totalCreditsField.textColor = this.errorColor;
            _loc4_ = false;
         }
         if(_loc2_ <= this._accountGold)
         {
            this.totalGoldField.textColor = this.textColor;
         }
         else
         {
            this.totalGoldField.textColor = this.errorColor;
            _loc5_ = false;
         }
         this.totalCreditsField.text = App.utils.locale.integer(_loc1_);
         this.totalGoldField.text = App.utils.locale.gold(_loc2_);
         this.applyButton.enabled = !this._actionsLocked && (_loc5_) && (_loc4_) && _loc1_ >= 0 && _loc2_ >= 0 && this._selectedSections.length > 0;
      }
   }

}