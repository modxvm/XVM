package net.wg.gui.lobby.store
{
   import flash.text.TextField;
   import net.wg.data.VO.StoreTableData;
   import net.wg.utils.ILocale;
   import net.wg.data.constants.FittingTypes;
   import net.wg.gui.components.advanced.ModuleIcon;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.infrastructure.exceptions.LifecycleException;


   public class StoreHelper extends Object
   {
          
      public function StoreHelper() {
         super();
         if(App.instance)
         {
            App.utils.asserter.assertNull(ms_instance,"StoreHelper already created.",LifecycleException);
         }
      }

      private static var ms_instance:StoreHelper = null;

      private static const DEFAULT_FRAME_IDX:uint = 1;

      public static function getInstance() : StoreHelper {
         if(ms_instance == null)
         {
            ms_instance = new StoreHelper();
         }
         return ms_instance;
      }

      public function updateCountFields(param1:TextField, param2:TextField, param3:StoreTableData) : void {
         var _loc4_:ILocale = null;
         if(App.instance)
         {
            _loc4_ = App.utils.locale;
            if(param3.requestType == FittingTypes.SHELL)
            {
               param1.text = _loc4_.integer(param3.inventoryCount);
               param2.text = "";
            }
            else
            {
               if(param3.requestType != FittingTypes.VEHICLE)
               {
                  param1.text = _loc4_.integer(param3.inventoryCount);
                  param2.text = _loc4_.integer(param3.vehicleCount);
               }
               else
               {
                  param2.text = "";
                  param1.text = "";
               }
            }
         }
      }

      public function initModuleIconAsDefault(param1:ModuleIcon) : void {
         if(param1)
         {
            param1.moduleType.gotoAndStop(DEFAULT_FRAME_IDX);
            param1.moduleLevel.gotoAndStop(DEFAULT_FRAME_IDX);
         }
      }

      public function initVehicleIcon(param1:TankIcon, param2:StoreTableData) : void {
         if(param1)
         {
            param1.nation = param2.nation;
            param1.level = param2.level;
            param1.image = param2.type;
            param1.tankType = param2.tankType;
            param1.isElite = param2.isElite;
            param1.isPremium = param2.isPremium;
            param1.tankNameBg.visible = false;
            param1.favoriteMc.visible = false;
            param1.tankNameField.visible = false;
            param1.validateNow();
         }
         else
         {
            DebugUtils.LOG_WARNING("vehicleIcon argument is null. It provides to some problems!");
         }
      }
   }

}