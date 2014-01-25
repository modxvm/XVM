package net.wg.gui.lobby.barracks
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ListEvent;
   import net.wg.data.constants.Tooltips;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.CloseButton;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.VehicleTypes;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.controls.ButtonBar;
   import net.wg.infrastructure.exceptions.TypeCastException;
   import flash.events.Event;
   import net.wg.gui.events.CrewEvent;


   public class BarracksForm extends UIComponent
   {
          
      public function BarracksForm() {
         super();
      }

      private static const INVALIDATE_TANKMEN_FILTRER:String = "TankmenFilter";

      private static const LOCATIONFILTER_TANKS:String = "tanks";

      private static const LOCATIONFILTER_BARRACKS:String = "barracks";

      private static const LOCATIONFILTER_ALL:String = "None";

      private static function showTooltip(param1:ListEvent) : void {
         App.toolTipMgr.hide();
         if(param1.itemData.empty)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_EMPTY);
         }
         else
         {
            if(param1.itemData.buy)
            {
               App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_BUY);
            }
            else
            {
               App.toolTipMgr.showSpecial(Tooltips.TANKMAN,null,param1.itemData.tankmanID,false);
            }
         }
      }

      private static function hideTooltip(param1:ListEvent) : void {
         App.toolTipMgr.hide();
      }

      public var tankmenCountTF:TextField = null;

      public var placesCountTF:TextField = null;

      public var roleTF:TextField = null;

      public var tankTypeTF:TextField = null;

      public var locationTF:TextField = null;

      public var nationTF:TextField = null;

      public var titleBtn:TextFieldShort = null;

      public var scrollBar:ScrollBar = null;

      public var tankmenTileList:TileList = null;

      public var tank:DropdownMenu = null;

      public var nationDDM:DropdownMenu = null;

      public var roleButtonBar:ButtonBarEx = null;

      public var tankTypeButtonBar:ButtonBarEx = null;

      public var locationButtonBar:ButtonBarEx = null;

      public var closeButton:CloseButton = null;

      private var _nation:Number = 0;

      private var _role:String = "";

      private var _tankType:String = "";

      private var _location:String = "";

      private var _nationID:String = "";

      public function as_setTankmen(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Array) : void {
         var _loc9_:* = NaN;
         this.tankmenCountTF.text = MENU.BARRACKS_TANKMENCOUNT;
         this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"),this.tankmenCountTF.text.indexOf("}") + 1,String(param8.length));
         this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"),this.tankmenCountTF.text.indexOf("}") + 1,String(param1));
         if(param3 < param2)
         {
            _loc9_ = param2 - param3;
            param8.push(
               {
                  "empty":true,
                  "freePlaces":_loc9_
               }
            );
         }
         param8.push(
            {
               "buy":true,
               "price":param4,
               "defPrice":param5,
               "count":param7,
               "actionPrc":param6
            }
         );
         this.tankmenTileList.dataProvider = new DataProvider(param8);
         this.tankmenTileList.validateNow();
         this.tankmenTileList.selectedIndex = -1;
         this.placesCountTF.text = MENU.BARRACKS_PLACESCOUNT;
         this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"),this.placesCountTF.text.indexOf("}") + 1,String(Math.max(param2 - param3,0)));
         this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"),this.placesCountTF.text.indexOf("}") + 1,String(param2));
      }

      public function as_updateTanksList(param1:Array) : void {
         this.tank.dataProvider = new DataProvider(param1);
         this.tank.selectedIndex = 0;
         if(param1.length > 0)
         {
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
         }
         else
         {
            this.locationButtonBar.dataProvider[0].data = "";
         }
         this.tank.validateNow();
         this.tank.enabled = param1.length > 0;
      }

      public function as_setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String) : void {
         this._nation = param1;
         this._role = param2;
         this._tankType = param3;
         this._location = param4;
         this._nationID = param5;
         invalidate(INVALIDATE_TANKMEN_FILTRER);
      }

      override protected function configUI() : void {
         super.configUI();
         this.tank.addEventListener(ListEvent.INDEX_CHANGE,this.onFilterTankChange);
         this.roleTF.text = MENU.BARRACKS_MENU_ROLEFILTER_TEXTFIELD;
         this.roleButtonBar.dataProvider = new DataProvider([
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_ALL,
               "data":RolesState.ALL
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_COMMANDER,
               "data":RolesState.COMANDER
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_GUNNER,
               "data":RolesState.GUNNER
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_LOADER,
               "data":RolesState.LOADER
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_DRIVER,
               "data":RolesState.DRIVER
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_ROLEFILTER_RADIOMAN,
               "data":RolesState.RADIOMAN
            }
         ]);
         this.tankTypeTF.text = MENU.BARRACKS_MENU_TANKTYPEFILTER_TEXTFIELD;
         this.tankTypeButtonBar.dataProvider = new DataProvider([
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_ALL,
               "data":VehicleTypes.ALL
            }
         ,
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_LIGHTTANK,
               "data":VehicleTypes.LIGHT_TANK
            }
         ,
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_MEDIUMTANK,
               "data":VehicleTypes.MEDIUM_TANK
            }
         ,
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_HEAVYTANK,
               "data":VehicleTypes.HEAVY_TANK
            }
         ,
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_AT_SPG,
               "data":VehicleTypes.AT_SPG
            }
         ,
            {
               "label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_SPG,
               "data":VehicleTypes.SPG
            }
         ]);
         this.locationTF.text = MENU.BARRACKS_MENU_LOCATIONFILTER_TEXTFIELD;
         this.locationButtonBar.dataProvider = new DataProvider([
            {
               "label":"",
               "data":""
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_LOCATIONFILTER_TANKS,
               "data":LOCATIONFILTER_TANKS
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKS,
               "data":LOCATIONFILTER_BARRACKS
            }
         ,
            {
               "label":MENU.BARRACKS_MENU_LOCATIONFILTER_ALL,
               "data":LOCATIONFILTER_ALL
            }
         ]);
         this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OVER,showTooltip);
         this.tankmenTileList.addEventListener(ListEvent.ITEM_ROLL_OUT,hideTooltip);
         this.tankmenTileList.addEventListener(ListEvent.ITEM_PRESS,hideTooltip);
      }

      override protected function onDispose() : void {
         App.toolTipMgr.hide();
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OVER,showTooltip);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OUT,hideTooltip);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_PRESS,hideTooltip);
         this.roleButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
         this.tankTypeButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.tankListInvalidate);
         this.tank.removeEventListener(ListEvent.INDEX_CHANGE,this.onFilterTankChange);
         this.locationButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
         this.nationDDM.removeEventListener(ListEvent.INDEX_CHANGE,this.tankListInvalidate);
         this.roleButtonBar.dispose();
         this.tankTypeButtonBar.dispose();
         this.locationButtonBar.dispose();
         this.tankmenTileList.dispose();
         this.nationDDM.dispose();
         this.tank.dispose();
         this.scrollBar.dispose();
         this.titleBtn.dispose();
         this.scrollBar = null;
         this.titleBtn = null;
         this.tankmenTileList = null;
         this.tank = null;
         this.nationDDM = null;
         this.roleButtonBar = null;
         this.tankTypeButtonBar = null;
         this.locationButtonBar = null;
         this.roleTF = null;
         this.tankTypeTF = null;
         this.locationTF = null;
         this.nationTF = null;
         this.tankmenCountTF = null;
         this.placesCountTF = null;
         this._nation = 0;
         this._role = null;
         this._tankType = null;
         this._location = null;
         this._nationID = null;
         super.onDispose();
      }

      public function onPopulate() : void {
         this.nationDDM.dataProvider = new DataProvider([
            {
               "label":MENU.NATIONS_ALL,
               "data":-1
            }
         ].concat(App.utils.nations.getNationsData()));
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = 0;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         super.draw();
         if(isInvalid(INVALIDATE_TANKMEN_FILTRER))
         {
            this.updateSelectedIndex(this.nationDDM,this._nation);
            this.updateSelectedIndex(this.roleButtonBar,this._role);
            this.updateSelectedIndex(this.tankTypeButtonBar,this._tankType);
            this.onInvalidateTanksList();
            if(this._nationID)
            {
               this.locationButtonBar.selectedIndex = 0;
               _loc1_ = 0;
               _loc2_ = this.tank.dataProvider.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(this.tank.dataProvider[_loc3_].data.typeID == this._location && this.tank.dataProvider[_loc3_].data.nationID == this._nationID)
                  {
                     _loc1_ = _loc3_;
                     break;
                  }
                  _loc3_++;
               }
               this.tank.selectedIndex = _loc1_;
            }
            else
            {
               _loc1_ = 3;
               _loc4_ = this.locationButtonBar.dataProvider.length;
               _loc5_ = 1;
               while(_loc5_ < _loc4_)
               {
                  if(this.locationButtonBar.dataProvider[_loc5_].data == this._location)
                  {
                     _loc1_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
               this.locationButtonBar.selectedIndex = _loc1_;
            }
            if(!this.roleButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.roleButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
            }
            if(!this.tankTypeButtonBar.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.tankTypeButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.tankListInvalidate);
            }
            if(!this.tank.hasEventListener(IndexEvent.INDEX_CHANGE))
            {
               this.locationButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
            }
            if(!this.nationDDM.hasEventListener(ListEvent.INDEX_CHANGE))
            {
               this.nationDDM.addEventListener(ListEvent.INDEX_CHANGE,this.tankListInvalidate);
            }
            this.checkFilters();
         }
      }

      private function updateSelectedIndex(param1:Object, param2:Object) : void {
         var _loc5_:* = false;
         var _loc6_:String = null;
         if(App.instance)
         {
            _loc5_ = param1  is  ButtonBar || param1  is  DropdownMenu;
            _loc6_ = "object in ... must be ButtonBar or DropdownMenu";
            App.utils.asserter.assert(_loc5_,_loc6_,TypeCastException);
         }
         var _loc3_:int = param1.dataProvider.length;
         param1.selectedIndex = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.dataProvider[_loc4_].data == param2)
            {
               param1.selectedIndex = _loc4_;
               return;
            }
            _loc4_++;
         }
      }

      private function onFilterChange(param1:Event) : void {
         this.checkFilters();
      }

      private function checkFilters() : void {
         var _loc1_:Number = this.nationDDM.dataProvider[this.nationDDM.selectedIndex].data;
         var _loc2_:String = this.roleButtonBar.dataProvider[this.roleButtonBar.selectedIndex].data;
         var _loc3_:String = this.tankTypeButtonBar.dataProvider[this.tankTypeButtonBar.selectedIndex].data;
         var _loc4_:Object = this.locationButtonBar.dataProvider[this.locationButtonBar.selectedIndex].data;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(_loc4_  is  String || _loc4_ == null)
         {
            _loc6_ = _loc4_.toString();
         }
         else
         {
            _loc6_ = _loc4_.typeID;
            _loc5_ = _loc4_.nationID;
         }
         var _loc7_:Object =
            {
               "nation":_loc1_,
               "role":_loc2_,
               "tankType":_loc3_,
               "location":_loc6_,
               "nationID":_loc5_
            }
         ;
         dispatchEvent(new CrewEvent(CrewEvent.ON_CHANGE_BARRACKS_FILTER,_loc7_));
      }

      private function tankListInvalidate(param1:Event) : void {
         this.checkFilters();
         this.onInvalidateTanksList();
         this.checkFilters();
      }

      private function onInvalidateTanksList() : void {
         dispatchEvent(new CrewEvent(CrewEvent.ON_INVALID_TANK_LIST));
      }

      private function onFilterTankChange(param1:Event) : void {
         this.locationButtonBar.selectedIndex = 0;
         this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
         this.checkFilters();
      }
   }

}