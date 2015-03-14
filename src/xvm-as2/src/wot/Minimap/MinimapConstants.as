class wot.Minimap.MinimapConstants
{
    /**
     * icons Z indexes from Minimap.pyc:
     * _MARKER_RANGE = (100, 124)
     * _BACK_ICONS_RANGE = (125, 149)
     * _DEAD_VEHICLE_RANGE = (150, 199)
     * _VEHICLE_RANGE = (201, 250)
     * _FIXED_INDEXES = {CAMERA_NORMAL: 200,
     * 'self': 251,
     * CAMERA_STRATEGIC: 252,
     * 'cell': 253,
     * CAMERA_VIDEO: 260}
     */

    public static var MAX_DEAD_ZINDEX:Number = 199;
    public static var LABELS_ZINDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var SQUARE_1KM_ZINDEX:Number = MAX_DEAD_ZINDEX - 2;
    public static var CAMERA_NORMAL_ZINDEX:Number = 200;
    public static var SELF_ZINDEX:Number = 251;

    public static var STATIC_ICON_BASE:String = "base"; // Team colored capture base
    public static var STATIC_ICON_CONTROL:String = "control"; // Shared grey capture base
    public static var STATIC_ICON_SPAWN:String = "spawn"; // Spawn point. Diamond shaped with number at center.
    public static var STATIC_ICON_LAST_LIT:String = "lastLit"; // Lost vehicle marker

    // Entry type: enemy, ally, squadman, empty possible
    public static var MINIMAP_ENTRY_NAME_ENEMY:String = "enemy";
    public static var MINIMAP_ENTRY_NAME_ALLY:String = "ally";
    public static var MINIMAP_ENTRY_NAME_SQUAD:String = "squadman";
    public static var MINIMAP_ENTRY_NAME_SELF:String = ""; // Type of player himself and ?

    public static var MINIMAP_ENTRY_VEH_CLASS_LIGHT:String = "lightTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_MEDIUM:String = "mediumTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_HEAVY:String = "heavyTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_TD:String = "AT-SPG";
    public static var MINIMAP_ENTRY_VEH_CLASS_SPG:String = "SPG";
    public static var MINIMAP_ENTRY_VEH_CLASS_SUPER:String = "superheavyTank";

    public static var MAP_MIN_ZOOM_INDEX:Number = 0;
    public static var MAP_MAX_ZOOM_INDEX:Number = 25;
}
