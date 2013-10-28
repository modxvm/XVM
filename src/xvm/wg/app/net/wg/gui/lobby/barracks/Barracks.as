package net.wg.gui.lobby.barracks
{
   import net.wg.infrastructure.base.meta.impl.BarracksMeta;
   import net.wg.infrastructure.base.meta.IBarracksMeta;
   import scaleform.clik.events.ListEvent;
   import net.wg.data.constants.Tooltips;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.TileList;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.events.CrewEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonBar;
   import net.wg.infrastructure.exceptions.TypeCastException;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;


   public class Barracks extends BarracksMeta implements IBarracksMeta
   {
          
      public function Barracks() {
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

      public var closeButton:CloseButton = null;

      public var scrollBar:ScrollBar = null;

      public var tankmenTileList:TileList = null;

      public var background:MovieClip = null;

      public var tank:DropdownMenu = null;

      public var nationDDM:DropdownMenu = null;

      public var roleButtonBar:ButtonBarEx = null;

      public var tankTypeButtonBar:ButtonBarEx = null;

      public var locationButtonBar:ButtonBarEx = null;

      private var _nation:Number = 0;

      private var _role:String = "";

      private var _tankType:String = "";

      private var _location:String = "";

      private var _nationID:String = "";

      private var myWidth:Number = 0;

      private var myHeight:Number = 0;

      override public function setViewSize(param1:Number, param2:Number) : void {
         this.myWidth = param1;
         this.myHeight = param2;
         invalidateSize();
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         this.setViewSize(param1,param2);
      }

      public function as_setTankmen(param1:Number, param2:Number, param3:Number, param4:String, param5:Number, param6:Array) : void {
         var _loc7_:* = NaN;
         this.tankmenCountTF.text = MENU.BARRACKS_TANKMENCOUNT;
         this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"),this.tankmenCountTF.text.indexOf("}") + 1,String(param6.length));
         this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"),this.tankmenCountTF.text.indexOf("}") + 1,String(param1));
         if(param3 < param2)
         {
            _loc7_ = param2 - param3;
            param6.push(
               {
                  "empty":true,
                  "freePlaces":_loc7_
               }
            );
         }
         param6.push(
            {
               "buy":true,
               "price":param4,
               "count":param5
            }
         );
         this.tankmenTileList.dataProvider = new DataProvider(param6);
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
         this.tankmenTileList.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
         this.tankmenTileList.addEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
         this.tankmenTileList.addEventListener(CrewEvent.DISMISS_TANKMAN,this.showDismissDialog);
         this.tankmenTileList.addEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG,this.onBuyBerth);
         this.tankmenTileList.addEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onBarracksClose);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         App.toolTipMgr.hide();
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OVER,showTooltip);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_ROLL_OUT,hideTooltip);
         this.tankmenTileList.removeEventListener(ListEvent.ITEM_PRESS,hideTooltip);
         this.tankmenTileList.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
         this.tankmenTileList.removeEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
         this.tankmenTileList.removeEventListener(CrewEvent.DISMISS_TANKMAN,this.showDismissDialog);
         this.tankmenTileList.removeEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG,this.onBuyBerth);
         this.tankmenTileList.removeEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onBarracksClose);
         this.roleButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
         this.tankTypeButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.tankListInvalidate);
         this.tank.removeEventListener(ListEvent.INDEX_CHANGE,this.onFilterTankChange);
         this.locationButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onFilterChange);
         this.nationDDM.removeEventListener(ListEvent.INDEX_CHANGE,this.tankListInvalidate);
         this.roleButtonBar.dispose();
         this.tankTypeButtonBar.dispose();
         this.locationButtonBar.dispose();
         this.tankmenTileList.dispose();
         this.closeButton.dispose();
         this.nationDDM.dispose();
         this.tank.dispose();
         this.scrollBar.dispose();
         this.titleBtn.dispose();
         this.scrollBar = null;
         this.titleBtn = null;
         this.closeButton = null;
         this.tankmenTileList = null;
         this.background = null;
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
         this.myWidth = 0;
         this.myHeight = 0;
         super.onDispose();
      }

      override protected function onPopulate() : void {
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
         if(isInvalid(InvalidationType.SIZE))
         {
            this.x = this.myWidth - _originalWidth >> 1;
            this.y = this.myHeight - _originalHeight >> 1;
         }
         if(isInvalid(INVALIDATE_TANKMEN_FILTRER))
         {
            this.updateSelectedIndex(this.nationDDM,this._nation);
            this.updateSelectedIndex(this.roleButtonBar,this._role);
            this.updateSelectedIndex(this.tankTypeButtonBar,this._tankType);
            invalidateTanksListS();
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
            if(!this.tank.hasEventListener(ListEvent.INDEX_CHANGE))
            {
               this.tank.addEventListener(ListEvent.INDEX_CHANGE,this.onFilterTankChange);
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
         var _loc3_:Boolean = param1  is  ButtonBar || param1  is  DropdownMenu;
         var _loc4_:* = "object in ... must be ButtonBar or DropdownMenu";
         assert(_loc3_,_loc4_,TypeCastException);
         var _loc5_:int = param1.dataProvider.length;
         param1.selectedIndex = 0;
         var _loc6_:Number = 0;
         while(_loc6_ < _loc5_)
         {
            if(param1.dataProvider[_loc6_].data == param2)
            {
               param1.selectedIndex = _loc6_;
               return;
            }
            _loc6_++;
         }
      }

      private function onBarracksClose(param1:ButtonEvent) : void {
         closeBarracksS();
      }

      private function openPersonalCaseHandler(param1:CrewEvent) : void {
         openPersonalCaseS(param1.initProp.tankmanID.toString(),param1.selectedTab);
      }

      private function onShowRecruitWindow(param1:CrewEvent) : void {
         onShowRecruitWindowClickS(param1.initProp,param1.menuEnabled);
      }

      private function onUnloadTankman(param1:CrewEvent) : void {
         unloadTankmanS(param1.initProp.compact);
      }

      private function showDismissDialog(param1:CrewEvent) : void {
         dismissTankmanS(param1.initProp.compact);
      }

      private function onBuyBerth(param1:CrewEvent) : void {
         buyBerthsS();
      }

      private function onFilterChange(param1:Event) : void {
         this.checkFilters();
      }

      private function checkFilters() : void {
         var _loc1_:Number = this.nationDDM.dataProvider[this.nationDDM.selectedIndex].data;
         var _loc2_:String = this.roleButtonBar.dataProvider[this.roleButtonBar.selectedIndex].data;
         var _loc3_:String = this.tankTypeButtonBar.dataProvider[this.tankTypeButtonBar.selectedIndex].data;
         var _loc4_:Object = this.locationButtonBar.dataProvider[this.locationButtonBar.selectedIndex].data;
         if(_loc4_  is  String || _loc4_ == null)
         {
            setFilterS(_loc1_,_loc2_,_loc3_,_loc4_.toString(),null);
         }
         else
         {
            setFilterS(_loc1_,_loc2_,_loc3_,_loc4_.typeID,_loc4_.nationID);
         }
      }

      private function tankListInvalidate(param1:Event) : void {
         this.checkFilters();
         invalidateTanksListS();
         this.checkFilters();
      }

      private function onFilterTankChange(param1:Event) : void {
         this.locationButtonBar.selectedIndex = 0;
         this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
         this.checkFilters();
      }

      private function handleEscape(param1:InputEvent) : void {
         closeBarracksS();
      }
   }

}