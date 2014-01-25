package net.wg.gui.lobby.vehicleInfo
{
   import net.wg.infrastructure.base.meta.impl.VehicleInfoMeta;
   import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
   import net.wg.gui.components.advanced.TankIcon;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.data.DataProvider;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.IViewStackContent;


   public class VehicleInfo extends VehicleInfoMeta implements IVehicleInfoMeta
   {
          
      public function VehicleInfo() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = false;
         showWindowBg = false;
      }

      public var vehicleIcon:TankIcon;

      public var moduleName:TextField;

      public var descriptionField:TextAreaSimple;

      public var descriptionScrollBar:ScrollBar;

      public var tabs:ButtonBarEx;

      public var tabsUnderline:Sprite;

      public var view:ViewStack;

      public var closeBtn:SoundButtonEx;

      private var VehicleInfoPropsData:Object = null;

      private var VehicleInfoBaseData:Object = null;

      private var VehicleInfoCrewData:Object = null;

      private var uiInited:Boolean = false;

      public function as_setVehicleInfo(param1:Object) : void {
         var _loc2_:String = param1.vehicleName;
         this.window.title = _loc2_;
         this.moduleName.text = _loc2_;
         this.descriptionField.text = param1.vehicleDiscription;
         this.vehicleIcon.image = param1.vehicleImage;
         this.vehicleIcon.level = param1.vehicleLevel;
         this.vehicleIcon.nation = param1.vehicleNation;
         this.vehicleIcon.isElite = param1.vehicleElite;
         this.vehicleIcon.tankType = param1.vehicleType;
         this.VehicleInfoPropsData = param1.VehicleInfoPropsData;
         this.VehicleInfoBaseData = param1.VehicleInfoBaseData;
         this.VehicleInfoCrewData = param1.VehicleInfoCrewData;
         this.initUI();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         if(this.tabs.selectedIndex == -1 && (this.uiInited))
         {
            this.tabs.selectedIndex = 0;
         }
         super.draw();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         getVehicleInfoS();
         var _loc1_:Padding = new Padding(window.formBgPadding.top,window.formBgPadding.right,window.formBgPadding.bottom + 1,window.formBgPadding.left);
         window.contentPadding = _loc1_;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
         this.tabs.dispose();
         this.tabs = null;
         this.view.dispose();
         this.view = null;
      }

      private function initUI() : void {
         this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
         this.tabs.dataProvider = new DataProvider([
            {
               "label":MENU.VEHICLEINFO_TABS_PROPERTIES,
               "linkage":"VehicleInfoProps"
            }
         ,
            {
               "label":MENU.VEHICLEINFO_TABS_BASE,
               "linkage":"VehicleInfoBase"
            }
         ,
            {
               "label":MENU.VEHICLEINFO_TABS_CREW,
               "linkage":"VehicleInfoCrew"
            }
         ]);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
         this.uiInited = true;
         invalidate();
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.closeBtn);
      }

      private function onViewNeedUpdate(param1:ViewStackEvent) : void {
         var _loc2_:IViewStackContent = param1.view;
         var _loc3_:String = param1.linkage;
         _loc2_.update(this[_loc3_ + "Data"]);
      }

      private function onClose(param1:ButtonEvent) : void {
         onCancelClickS();
      }
   }

}