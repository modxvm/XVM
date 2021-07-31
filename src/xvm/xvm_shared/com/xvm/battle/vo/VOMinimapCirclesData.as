/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xvm.vo.*;

    public class VOMinimapCirclesData extends VOBase
    {
        public var view_coated_optics:Boolean;
        public var base_loaders_skill:Number;
        public var base_radio_distance:Number;
        public var view_ventilation:Boolean;
        public var view_stereoscope:Boolean;
        public var view_radioman_inventor:Number;
        public var view_radioman_finder:Number;
        public var view_commander_eagleEye:Number;
        public var view_camouflage:*;
        public var is_full_crew:Boolean;
        public var base_commander_skill:Number;
        public var base_radioman_skill:Number;
        public var view_distance_vehicle:Number;
        public var view_consumable:Boolean;
        public var view_rammer:Boolean;
        public var base_gun_reload_time:Number;
        public var vehCD:Number;
        public var commander_sixthSense:Boolean;
        public var shell_range:Number;
        public var view_brothers_in_arms:Boolean;

        public var artillery_ranges:Array;
        public var artillery_shellsCD:Array;

        public function VOMinimapCirclesData(data:Object = null)
        {
            super(data);
        }

        public function artilleryRange(shellsCD: int):Number
        {
            if (!artillery_shellsCD || !artillery_ranges)
            {
                return 0;
            }
            return artillery_ranges[artillery_shellsCD.indexOf(shellsCD)];

        }

    }
}
