package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.pveEvent.views.vehicleMarkers.EventVehicleMarker;
    import net.wg.gui.battle.pveEvent.views.vehicleMarkers.EventVehicleMarkerMessage;
    import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterMarker;
    import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyMarker;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseMarker;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorWarning.SectorWarningMarker;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointMarker;
    import net.wg.gui.battle.views.staticMarkers.flag.FlagIcon;
    import net.wg.gui.battle.views.staticMarkers.flag.FlagMarker;
    import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
    import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointIcon;
    import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointMarker;
    import net.wg.gui.battle.views.staticMarkers.safeZone.SafeZoneMarker;
    import net.wg.gui.battle.views.vehicleMarkers.AnimateExplosion;
    import net.wg.gui.battle.views.vehicleMarkers.DamageLabel;
    import net.wg.gui.battle.views.vehicleMarkers.FlagContainer;
    import net.wg.gui.battle.views.vehicleMarkers.FortConsumablesMarker;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedPart;
    import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
    import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
    import net.wg.gui.battle.views.vehicleMarkers.IVehicleMarkersManager;
    import net.wg.gui.battle.views.vehicleMarkers.StaticArtyMarker;
    import net.wg.gui.battle.views.vehicleMarkers.StaticObjectMarker;
    import net.wg.gui.battle.views.vehicleMarkers.TargetMarker;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleIconAnimation;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersLinkages;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleStatusContainerMarker;
    import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
    import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
    import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
    import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.ArrowMarkerContainer;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.GlowMarkerContainer;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleEngineerEffectMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
    import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
    import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
    import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;

    public class ClassManagerBattleMarkersMeta extends Object
    {

        public static const NET_WG_GUI_BATTLE_PVEEVENT_VIEWS_VEHICLEMARKERS_EVENTVEHICLEMARKER:Class = EventVehicleMarker;

        public static const NET_WG_GUI_BATTLE_PVEEVENT_VIEWS_VEHICLEMARKERS_EVENTVEHICLEMARKERMESSAGE:Class = EventVehicleMarkerMessage;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERICON:Class = HeadquarterIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERMARKER:Class = HeadquarterMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYICON:Class = ResupplyIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYMARKER:Class = ResupplyMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEICON:Class = SectorBaseIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEMARKER:Class = SectorBaseMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWARNING_SECTORWARNINGMARKER:Class = SectorWarningMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTICON:Class = SectorWaypointIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTMARKER:Class = SectorWaypointMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGICON:Class = FlagIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGMARKER:Class = FlagMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_CONSTANT_FLAGMARKERSTATE:Class = FlagMarkerState;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTICON:Class = RepairPointIcon;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTMARKER:Class = RepairPointMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SAFEZONE_SAFEZONEMARKER:Class = SafeZoneMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_DAMAGELABEL:Class = DamageLabel;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FLAGCONTAINER:Class = FlagContainer;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FORTCONSUMABLESMARKER:Class = FortConsumablesMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBAR:Class = HealthBar;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HPFIELDCONTAINER:Class = HPFieldContainer;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IMARKERMANAGERHANDLER:Class = IMarkerManagerHandler;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IVEHICLEMARKERSMANAGER:Class = IVehicleMarkersManager;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICARTYMARKER:Class = StaticArtyMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICOBJECTMARKER:Class = StaticObjectMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_TARGETMARKER:Class = TargetMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEICONANIMATION:Class = VehicleIconAnimation;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKER:Class = net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSCONSTANTS:Class = VehicleMarkersConstants;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSLINKAGES:Class = VehicleMarkersLinkages;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSMANAGER:Class = VehicleMarkersManager;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLESTATUSCONTAINERMARKER:Class = VehicleStatusContainerMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VMATLASITEMNAME:Class = VMAtlasItemName;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_STATUSANIMATIONEVENT:Class = StatusAnimationEvent;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_TIMELINEEVENT:Class = TimelineEvent;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_VEHICLEMARKERSMANAGEREVENT:Class = VehicleMarkersManagerEvent;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_ARROWMARKERCONTAINER:Class = ArrowMarkerContainer;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_GLOWMARKERCONTAINER:Class = GlowMarkerContainer;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEANIMATEDSTATUSBASEMARKER:Class = VehicleAnimatedStatusBaseMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEENGINEEREFFECTMARKER:Class = VehicleEngineerEffectMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIREMARKER:Class = VehicleInspireMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIRETARGETMARKER:Class = VehicleInspireTargetMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTUNMARKER:Class = VehicleStunMarker;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_CROSSOFFSET:Class = CrossOffset;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_HPDISPLAYMODE:Class = HPDisplayMode;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERPART:Class = VehicleMarkerPart;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;

        public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERVO:Class = VehicleMarkerVO;

        public function ClassManagerBattleMarkersMeta()
        {
            super();
        }
    }
}
