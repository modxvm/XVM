/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapCirclesInternal implements ICloneable
    {
        public var base_commander_skill:Number;
        public var base_gun_reload_time:Number;
        public var base_loaders_skill:Number;
        public var base_radio_distance:Number;
        public var base_radioman_skill:Number;
        public var view_brothers_in_arms:Boolean;
        public var view_coated_optics:Boolean;
        public var view_commander_eagleEye:Number;
        public var view_consumable:Boolean;
        public var view_distance_vehicle:Number;
        public var view_radioman_finder:Number;
        public var view_radioman_inventor:Number;
        public var view_rammer:Boolean;
        public var view_stereoscope:Boolean;
        public var view_ventilation:Boolean;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
