/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelMode implements ICloneable
    {
        public var enabled:*;
        public var expandAreaWidth:*;
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;
        public var fixedPosition:*;
        public var fragsFormatLeft:String;
        public var fragsFormatRight:String;
        public var fragsShadowLeft:CShadow;
        public var fragsShadowRight:CShadow;
        public var fragsWidth:*;
        public var fragsOffsetXLeft:*;
        public var fragsOffsetXRight:*;
        public var nickFormatLeft:String;
        public var nickFormatRight:String;
        public var nickMaxWidth:*;
        public var nickMinWidth:*;
        public var nickShadowLeft:CShadow;
        public var nickShadowRight:CShadow;
        public var nickOffsetXLeft:*;
        public var nickOffsetXRight:*;
        public var rankBadgeAlpha:*;
        public var rankBadgeWidth:*;
        public var rankBadgeOffsetXLeft:*;
        public var rankBadgeOffsetXRight:*;
        public var removeSquadIcon:*;
        public var removeSpottedIndicator:*;
        public var squadIconAlpha:*;
        public var standardFields:Array;
        public var vehicleFormatLeft:String;
        public var vehicleFormatRight:String;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;
        public var vehicleLevelAlpha:*;
        public var vehicleLevelOffsetXLeft:*;
        public var vehicleLevelOffsetXRight:*;
        public var vehicleShadowLeft:CShadow;
        public var vehicleShadowRight:CShadow;
        public var vehicleWidth:*;
        public var vehicleOffsetXLeft:*;
        public var vehicleOffsetXRight:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
