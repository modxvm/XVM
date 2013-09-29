package net.wg.gui.lobby.store 
{
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.utils.*;
    
    public class StoreHelper extends Object
    {
        public function StoreHelper()
        {
            super();
            if (App.instance) 
            {
                App.utils.asserter.assertNull(ms_instance, "StoreHelper already created.", net.wg.infrastructure.exceptions.LifecycleException);
            }
            return;
        }

        public function updateCountFields(arg1:flash.text.TextField, arg2:flash.text.TextField, arg3:net.wg.data.VO.StoreTableData):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.locale;
                if (arg3.requestType != net.wg.data.constants.FittingTypes.SHELL) 
                {
                    if (arg3.requestType == net.wg.data.constants.FittingTypes.VEHICLE) 
                    {
                        arg2.text = "";
                        arg1.text = "";
                    }
                    else 
                    {
                        arg1.text = loc1.integer(arg3.inventoryCount);
                        arg2.text = loc1.integer(arg3.vehicleCount);
                    }
                }
                else 
                {
                    arg1.text = loc1.integer(arg3.inventoryCount);
                    arg2.text = "";
                }
            }
            return;
        }

        public function initModuleIconAsDefault(arg1:net.wg.gui.components.advanced.ModuleIcon):void
        {
            if (arg1) 
            {
                arg1.moduleType.gotoAndStop(DEFAULT_FRAME_IDX);
                arg1.moduleLevel.gotoAndStop(DEFAULT_FRAME_IDX);
            }
            return;
        }

        public function initVehicleIcon(arg1:net.wg.gui.components.advanced.TankIcon, arg2:net.wg.data.VO.StoreTableData):void
        {
            if (arg1) 
            {
                arg1.nation = arg2.nation;
                arg1.level = arg2.level;
                arg1.image = arg2.type;
                arg1.tankType = arg2.tankType;
                arg1.isElite = arg2.isElite;
                arg1.isPremium = arg2.isPremium;
                arg1.tankNameBg.visible = false;
                arg1.favoriteMc.visible = false;
                arg1.tankNameField.visible = false;
                arg1.validateNow();
            }
            else 
            {
                DebugUtils.LOG_WARNING("vehicleIcon argument is null. It provides to some problems!");
            }
            return;
        }

        public static function getInstance():net.wg.gui.lobby.store.StoreHelper
        {
            if (ms_instance == null) 
            {
                ms_instance = new StoreHelper();
            }
            return ms_instance;
        }

        
        {
            ms_instance = null;
        }

        internal static const DEFAULT_FRAME_IDX:uint=1;

        internal static var ms_instance:net.wg.gui.lobby.store.StoreHelper=null;
    }
}
