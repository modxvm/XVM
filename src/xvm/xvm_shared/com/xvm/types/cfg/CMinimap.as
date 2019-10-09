/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimap implements ICloneable
    {
        public var circles:CMinimapCircles;
        public var circlesEnabled:*;
        public var directionLineAlpha:*;
        public var directionTriangleAlpha:*;
        public var enabled:*;
        public var iconAlpha:*;
        public var iconScale:*;
        public var labels:CMinimapLabels;
        public var labelsEnabled:*;
        public var lines:CMinimapLines;
        public var linesEnabled:*;
        public var mapBackgroundImageAlpha:*;
        public var mapSize:CExtraField;
        public var minimapAimIcon:String;
        public var minimapAimIconScale:*;
        public var selfIconAlpha:*;
        public var selfIconColor:*;
        public var selfIconScale:*;
        public var showCellClickAnimation:*;
        public var showDirectionLineAfterDeath:*;
        public var zoom:CMinimapZoom;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (circles)
            {
                circles.applyGlobalMacros();
            }
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            if (lines)
            {
                lines.applyGlobalMacros();
            }
            mapBackgroundImageAlpha = Macros.FormatNumberGlobal(mapBackgroundImageAlpha);
            minimapAimIcon = Macros.FormatStringGlobal(minimapAimIcon);
            minimapAimIconScale = Macros.FormatNumberGlobal(minimapAimIconScale);
            showCellClickAnimation = Macros.FormatBooleanGlobal(showCellClickAnimation, false);
            if (zoom)
            {
                zoom.applyGlobalMacros();
            }
        }
    }
}
