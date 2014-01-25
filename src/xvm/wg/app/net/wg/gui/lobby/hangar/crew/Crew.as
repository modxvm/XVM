package net.wg.gui.lobby.hangar.crew
{
   import net.wg.infrastructure.base.meta.impl.CrewMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import net.wg.infrastructure.base.meta.ICrewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.events.ListEventEx;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   import net.wg.gui.events.CrewEvent;


   public class Crew extends CrewMeta implements IHelpLayoutComponent, ICrewMeta, IDAAPIModule
   {
          
      public function Crew() {
         super();
      }

      private static const INVALIDATE_LIST:String = "invalidateList";

      private static const INVALIDATE_ENABLE:String = "invalidateEnable";

      private static function setupDataProvider(param1:Array) : IDataProvider {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each (_loc3_ in param1)
         {
            _loc2_.push(new RecruitRendererVO(_loc3_));
         }
         return _loc2_;
      }

      private static function showTooltip(param1:ListEventEx) : void {
         if(param1.itemData.tankmanID)
         {
            App.toolTipMgr.showSpecial(Tooltips.TANKMAN,null,param1.itemData.tankmanID,true);
         }
      }

      private static function hideTooltip(param1:ListEventEx) : void {
         App.toolTipMgr.hide();
      }

      public var list:ScrollingListEx;

      public var maskMC:MovieClip;

      public var bg:MovieClip;

      public var helpDirection:String = "R";

      public var helpText:String = "";

      public var helpConnectorLength:Number = 12;

      private var _helpLayout:DisplayObject = null;

      public function as_tankmenResponse(param1:Array, param2:Array) : void {
         var _loc3_:Array = null;
         var _loc7_:Object = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Object = null;
         _loc3_ = [];
         var _loc4_:uint = param1.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1[_loc5_].tankmanID)
            {
               for each (_loc10_ in param2)
               {
                  if(_loc10_.tankmanID == param1[_loc5_].tankmanID)
                  {
                     _loc7_ = _loc10_;
                     break;
                  }
               }
            }
            else
            {
               _loc7_ =
                  {
                     "iconFile":(param1[_loc5_].nationID == 0?"ussr-empty.png":"germany-empty.png"),
                     "role":param1[_loc5_].role,
                     "roleIconFile":param1[_loc5_].roleIcon,
                     "firstname":(param1[_loc5_].firstname?param1[_loc5_].firstname:""),
                     "lastname":(param1[_loc5_].lastname?param1[_loc5_].lastname:""),
                     "rank":(param1[_loc5_].rank?param1[_loc5_].rank:""),
                     "specializationLevel":-1,
                     "vehicleType":param1[_loc5_].vehicleType,
                     "tankType":param1[_loc5_].tankType,
                     "tankmanID":NaN
                  }
               ;
            }
            _loc7_.slot = param1[_loc5_].slot;
            _loc7_.curVehicleType = param1[_loc5_].tankType;
            _loc7_.curVehicleName = param1[_loc5_].vehicleType;
            _loc7_.roles = param1[_loc5_].roles;
            _loc7_.vehicleElite = param1[_loc5_].vehicleElite;
            _loc7_.recruitList = [];
            _loc7_.recruitList.push(
               {
                  "specializationLevel":101,
                  "recruit":true,
                  "roleType":param1[_loc5_].roleType,
                  "role":param1[_loc5_].role,
                  "roleIconFile":param1[_loc5_].roleIcon,
                  "vehicleType":param1[_loc5_].vehicleType,
                  "typeID":param1[_loc5_].typeID,
                  "nationID":param1[_loc5_].nationID,
                  "iconFile":(param1[_loc5_].nationID == 0?"ussr-empty.png":"germany-empty.png"),
                  "tankType":param1[_loc5_].tankType
               }
            );
            _loc8_ = param2.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               if(param2[_loc9_].roleType == param1[_loc5_].roleType && param2[_loc9_].nationID == param1[_loc5_].nationID)
               {
                  if(param2[_loc9_].tankmanID == param1[_loc5_].tankmanID)
                  {
                     param2[_loc9_].selected = true;
                  }
                  if(!param2[_loc9_].inTank || param2[_loc9_].tankmanID == param1[_loc5_].tankmanID)
                  {
                     _loc7_.recruitList.push(param2[_loc9_]);
                  }
               }
               _loc9_++;
            }
            _loc3_.push(new RecruitRendererVO(_loc7_));
            _loc5_++;
         }
         var _loc6_:Number = 61;
         this.maskMC.height = this.bg.height = _loc3_.length * _loc6_;
         this.list.mask = this.maskMC;
         this.list.dataProvider.cleanUp();
         this.list.dataProvider = new DataProvider(_loc3_);
         this.list.selectedIndex = -1;
         invalidate(INVALIDATE_ENABLE);
      }

      public function showHelpLayout() : void {
         var _loc1_:Object =
            {
               "borderWidth":204,
               "borderHeight":height,
               "direction":this.helpDirection,
               "text":LOBBY_HELP.HANGAR_CREW,
               "x":0,
               "y":0,
               "connectorLength":this.helpConnectorLength
            }
         ;
         this.setHelpLayout(App.utils.helpLayout.create(this.root,_loc1_,this));
      }

      public function closeHelpLayout() : void {
         if(this.getHelpLayout() != null)
         {
            App.utils.helpLayout.destroy(this.getHelpLayout());
         }
      }

      override public function get enabled() : Boolean {
         return super.enabled;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         invalidate(INVALIDATE_ENABLE);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         invalidate(INVALIDATE_LIST);
      }

      override protected function onDispose() : void {
         this.list.removeEventListener(ListEventEx.ITEM_ROLL_OVER,showTooltip);
         this.list.removeEventListener(ListEventEx.ITEM_ROLL_OUT,hideTooltip);
         this.list.removeEventListener(ListEventEx.ITEM_PRESS,hideTooltip);
         App.stage.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
         App.stage.removeEventListener(CrewEvent.EQUIP_TANKMAN,this.onEquipTankman);
         removeEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
         removeEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
         this.list.dispose();
         this.list = null;
         this.bg = null;
         if(this._helpLayout)
         {
            this.closeHelpLayout();
         }
         this.maskMC = null;
         this._helpLayout = null;
         super.onDispose();
      }

      override protected function configUI() : void {
         super.configUI();
         mouseEnabled = false;
         addEventListener(CrewEvent.UNLOAD_TANKMAN,this.onUnloadTankman);
         addEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.openPersonalCaseHandler);
         App.stage.addEventListener(CrewEvent.EQUIP_TANKMAN,this.onEquipTankman);
         App.stage.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onShowRecruitWindow);
         this.list.addEventListener(ListEventEx.ITEM_ROLL_OVER,showTooltip);
         this.list.addEventListener(ListEventEx.ITEM_ROLL_OUT,hideTooltip);
         this.list.addEventListener(ListEventEx.ITEM_PRESS,hideTooltip);
         this.list.mouseEnabled = false;
         this.list.validateNow();
      }

      override protected function draw() : void {
         if(isInvalid(INVALIDATE_LIST))
         {
            updateTankmenS();
         }
         if(isInvalid(INVALIDATE_ENABLE))
         {
            this.list.validateNow();
            this.list.enabled = this.enabled;
            this.list.mouseEnabled = this.enabled;
         }
      }

      protected function setHelpLayout(param1:DisplayObject) : void {
         this._helpLayout = param1;
      }

      protected function getHelpLayout() : DisplayObject {
         return this._helpLayout;
      }

      private function onEquipTankman(param1:CrewEvent) : void {
         equipTankmanS(param1.initProp.tankmanID,param1.initProp.slot);
      }

      private function onUnloadTankman(param1:CrewEvent) : void {
         unloadTankmanS(param1.initProp.tankmanID);
      }

      private function onShowRecruitWindow(param1:CrewEvent) : void {
         onShowRecruitWindowClickS(param1.initProp,param1.menuEnabled);
      }

      private function openPersonalCaseHandler(param1:CrewEvent) : void {
         openPersonalCaseS(param1.initProp.tankmanID.toString(),param1.selectedTab);
      }
   }

}