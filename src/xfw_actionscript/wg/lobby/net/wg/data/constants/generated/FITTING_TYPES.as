package net.wg.data.constants.generated
{
    public class FITTING_TYPES extends Object
    {

        public static const OPTIONAL_DEVICE:String = "optionalDevice";

        public static const EQUIPMENT:String = "equipment";

        public static const SHELL:String = "shell";

        public static const VEHICLE:String = "vehicle";

        public static const MODULE:String = "module";

        public static const ORDER:String = "order";

        public static const BOOSTER:String = "battleBooster";

        public static const CREW_BOOKS:String = "crewBooks";

        public static const CUSTOMIZATION:String = "customization";

        public static const BATTLE_ABILITY:String = "battleAbility";

        public static const STORE_SLOTS:Array = [VEHICLE,MODULE,SHELL,OPTIONAL_DEVICE,EQUIPMENT,BOOSTER];

        public static const ARTEFACT_SLOTS:Array = [OPTIONAL_DEVICE,EQUIPMENT];

        public static const VEHICLE_GUN:String = "vehicleGun";

        public static const VEHICLE_TURRET:String = "vehicleTurret";

        public static const VEHICLE_CHASSIS:String = "vehicleChassis";

        public static const VEHICLE_WHEELED_CHASSIS:String = "vehicleWheeledChassis";

        public static const VEHICLE_ENGINE:String = "vehicleEngine";

        public static const VEHICLE_RADIO:String = "vehicleRadio";

        public static const MANDATORY_SLOTS:Array = [VEHICLE_GUN,VEHICLE_TURRET,VEHICLE_CHASSIS,VEHICLE_ENGINE,VEHICLE_RADIO];

        public static const VEHICLE_CHASSIS_OVERRIDE:Array = [VEHICLE_CHASSIS,VEHICLE_WHEELED_CHASSIS];

        public static const MANDATORY_SLOTS_OVERRIDES:Array = [VEHICLE_CHASSIS_OVERRIDE];

        public static const RESERVE_SLOT1:String = "reserveSlot1";

        public static const RESERVE_SLOT2:String = "reserveSlot2";

        public static const RESERVE_SLOT3:String = "reserveSlot3";

        public static const RESERVES_SLOTS:Array = [RESERVE_SLOT1,RESERVE_SLOT2,RESERVE_SLOT3];

        public static const TARGET_OTHER:String = "other";

        public static const TARGET_HANGAR:String = "hangar";

        public static const TARGET_HANGAR_CANT_INSTALL:String = "hangarCantInstall";

        public static const TARGET_HANGAR_DUPLICATE:String = "hangarDuplicate";

        public static const TARGET_VEHICLE:String = "vehicle";

        public static const ITEM_TARGETS:Array = [TARGET_OTHER,TARGET_HANGAR,TARGET_HANGAR_CANT_INSTALL,TARGET_VEHICLE];

        public static const OPTIONAL_DEVICE_FITTING_ITEM_RENDERER:String = "OptDevFittingItemRendererUI";

        public static const GUN_TURRET_FITTING_ITEM_RENDERER:String = "GunTurretFittingItemRendererUI";

        public static const RESERVE_FITTING_ITEM_RENDERER:String = "ReserveFittingItemRendererUI";

        public static const ENGINE_CHASSIS_FITTING_ITEM_RENDERER:String = "EngineChassisFittingItemRendererUI";

        public static const RADIO_FITTING_ITEM_RENDERER:String = "RadioFittingItemRendererUI";

        public static const BOOSTER_FITTING_ITEM_RENDERER:String = "BoosterFittingItemRendererUI";

        public static const BATTLE_ABILITY_ITEM_RENDERER:String = "BattleAbilityItemRendererUI";

        public static const FITTING_RENDERERS:Array = [OPTIONAL_DEVICE_FITTING_ITEM_RENDERER,GUN_TURRET_FITTING_ITEM_RENDERER,RESERVE_FITTING_ITEM_RENDERER,ENGINE_CHASSIS_FITTING_ITEM_RENDERER,RADIO_FITTING_ITEM_RENDERER,BOOSTER_FITTING_ITEM_RENDERER,BATTLE_ABILITY_ITEM_RENDERER];

        public static const OPTIONAL_DEVICE_RENDERER_DATA_CLASS_NAME:String = "net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO";

        public static const MODULE_FITTING_RENDERER_DATA_CLASS_NAME:String = "net.wg.gui.lobby.modulesPanel.data.ModuleVO";

        public static const BOOSTER_FITTING_RENDERER_DATA_CLASS_NAME:String = "net.wg.gui.lobby.modulesPanel.data.BoosterFittingItemVO";

        public static const BATTLE_ABILITY_RENDERER_DATA_CLASS_NAME:String = "net.wg.gui.lobby.modulesPanel.data.BattleAbilityVO";

        public static const FITTING_RENDERER_DATA_NAMES:Array = [OPTIONAL_DEVICE_RENDERER_DATA_CLASS_NAME,MODULE_FITTING_RENDERER_DATA_CLASS_NAME,BOOSTER_FITTING_RENDERER_DATA_CLASS_NAME,BATTLE_ABILITY_RENDERER_DATA_CLASS_NAME];

        public static const HANGAR_POPOVER_TOP_MARGIN:int = 80;

        public static const VEHPREVIEW_POPOVER_MIN_AVAILABLE_HEIGHT:int = 575;

        public static const LARGE_POPOVER_WIDTH:int = 540;

        public static const MEDUIM_POPOVER_WIDTH:int = 500;

        public static const SHORT_POPOVER_WIDTH:int = 440;

        public static const RESERVE_POPOVER_WIDTH:int = 480;

        public function FITTING_TYPES()
        {
            super();
        }
    }
}
