/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.battleloading
{
    import com.xfw.*;

    public class XvmItemRendererDefaults
    {
        public var SQUAD_X:int;
        public var RANKICON_X:int;
        public var NAME_FIELD_X:int;
        public var NAME_FIELD_WIDTH:int;
        public var VEHICLE_FIELD_X:int;
        public var VEHICLE_FIELD_WIDTH:int;
        public var VEHICLE_ICON_X:int;
        public var VEHICLE_LEVEL_X:int;
        public var VEHICLE_TYPE_ICON_X:int;
        public var EXTRA_FIELDS_X:int;

        public static const DEFAULTS_LEFT_TABLE:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 250,
            VEHICLE_FIELD_WIDTH: 250,
            SQUAD_X: 65,
            RANKICON_X: 62,
            NAME_FIELD_X: 86,
            VEHICLE_FIELD_X: 120,
            VEHICLE_ICON_X: 402,
            VEHICLE_LEVEL_X: 421,
            VEHICLE_TYPE_ICON_X: 371,
            EXTRA_FIELDS_X: 10
        }, XvmItemRendererDefaults);

        public static const DEFAULTS_RIGHT_TABLE:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 250,
            VEHICLE_FIELD_WIDTH: 250,
            SQUAD_X: 934,
            RANKICON_X: 931,
            NAME_FIELD_X: 680,
            VEHICLE_FIELD_X: 644,
            VEHICLE_ICON_X: 612,
            VEHICLE_LEVEL_X: 592,
            VEHICLE_TYPE_ICON_X: 618,
            EXTRA_FIELDS_X: 1011
        }, XvmItemRendererDefaults);

        public static const DEFAULTS_LEFT_TIP:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 100,
            VEHICLE_FIELD_WIDTH: 100,
            SQUAD_X: 8,
            RANKICON_X: 5,
            NAME_FIELD_X: 29,
            VEHICLE_FIELD_X: 84,
            VEHICLE_ICON_X: 201,
            VEHICLE_LEVEL_X: 220,
            VEHICLE_TYPE_ICON_X: 182,
            EXTRA_FIELDS_X: 0
        }, XvmItemRendererDefaults);

        public static const DEFAULTS_RIGHT_TIP:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 100,
            VEHICLE_FIELD_WIDTH: 100,
            SQUAD_X: 992,
            RANKICON_X: 989,
            NAME_FIELD_X: 888,
            VEHICLE_FIELD_X: 831,
            VEHICLE_ICON_X: 815,
            VEHICLE_LEVEL_X: 798,
            VEHICLE_TYPE_ICON_X: 810,
            EXTRA_FIELDS_X: 1011
        }, XvmItemRendererDefaults);
    }
}
