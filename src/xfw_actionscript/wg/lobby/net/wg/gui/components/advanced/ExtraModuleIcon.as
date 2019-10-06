package net.wg.gui.components.advanced
{
    import net.wg.data.constants.Linkages;

    public class ExtraModuleIcon extends ModuleIcon
    {

        private static const VEHICLE_GUN:String = "vehicleGun";

        private static const VEHICLE_CHASSIS:String = "vehicleChassis";

        private static const VEHICLE_WHEELED_CHASSIS:String = "vehicleWheeledChassis";

        public function ExtraModuleIcon()
        {
            super();
        }

        override protected function onDispose() : void
        {
            ModuleTypesUIWithFill(moduleType).hideExtraIcon();
            super.onDispose();
        }

        private function showExtraIcon(param1:String) : void
        {
            ModuleTypesUIWithFill(moduleType).setExtraIcon(param1);
            ModuleTypesUIWithFill(moduleType).showExtraIcon();
        }

        public function set extraIconSource(param1:String) : void
        {
            ModuleTypesUIWithFill(moduleType).hideExtraIcon();
            switch(moduleType.currentLabel)
            {
                case VEHICLE_GUN:
                    if(param1 == RES_ICONS.MAPS_ICONS_MODULES_MAGAZINEGUNICON)
                    {
                        this.showExtraIcon(Linkages.MAGAZINE_GUN_ICON);
                    }
                    else if(param1 == RES_ICONS.MAPS_ICONS_MODULES_AUTOLOADERGUN)
                    {
                        this.showExtraIcon(Linkages.AUTOLOADED_GUN_ICON);
                    }
                    break;
                case VEHICLE_WHEELED_CHASSIS:
                    if(param1 == RES_ICONS.MAPS_ICONS_MODULES_HYDRAULICWHEELEDCHASSISICON)
                    {
                        this.showExtraIcon(Linkages.HYDRAULIC_WHEELED_CHASSIS_ICON);
                    }
                    break;
                case VEHICLE_CHASSIS:
                    if(param1 == RES_ICONS.MAPS_ICONS_MODULES_HYDRAULICCHASSISICON)
                    {
                        this.showExtraIcon(Linkages.HYDRAULIC_CHASSIS_ICON);
                    }
                    break;
            }
        }
    }
}
