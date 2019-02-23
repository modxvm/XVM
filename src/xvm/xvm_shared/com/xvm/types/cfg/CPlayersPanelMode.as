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
        public var fragsXOffsetLeft:*;
        public var fragsXOffsetRight:*;
        public var nickFormatLeft:String;
        public var nickFormatRight:String;
        public var nickMaxWidth:*;
        public var nickMinWidth:*;
        public var nickShadowLeft:CShadow;
        public var nickShadowRight:CShadow;
        public var nickXOffsetLeft:*;
        public var nickXOffsetRight:*;
        public var rankBadgeAlpha:*;
        public var rankBadgeWidth:*;
        public var rankBadgeXOffsetLeft:*;
        public var rankBadgeXOffsetRight:*;
        public var removeSquadIcon:*;
        public var squadIconAlpha:*;
        public var standardFields:Array;
        public var vehicleFormatLeft:String;
        public var vehicleFormatRight:String;
        public var vehicleIconXOffsetLeft:*;
        public var vehicleIconXOffsetRight:*;
        public var vehicleLevelAlpha:*;
        public var vehicleLevelXOffsetLeft:*;
        public var vehicleLevelXOffsetRight:*;
        public var vehicleShadowLeft:CShadow;
        public var vehicleShadowRight:CShadow;
        public var vehicleWidth:*;
        public var vehicleXOffsetLeft:*;
        public var vehicleXOffsetRight:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
