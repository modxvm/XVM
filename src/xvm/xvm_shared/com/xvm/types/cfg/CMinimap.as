/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimap extends Object implements ICloneable
    {
        public var enabled:*;
        public var mapBackgroundImageAlpha:*;
        public var selfIconAlpha:*;
        public var selfIconScale:*;
        public var iconAlpha:*;
        public var iconScale:*;
        public var directionTriangleAlpha:*;
        public var directionLineAlpha:*;
        public var showDirectionLineAfterDeath:*;
        public var minimapAimIcon:String;
        public var minimapAimIconScale:*;
        public var zoom:CMinimapZoom;
        public var mapSize:CExtraField;
        public var circlesEnabled:*;
        public var labelsEnabled:*;
        public var linesEnabled:*;
        public var labels:CMinimapLabels;
        public var labelsData:*;
        public var circles:CMinimapCircles;
        public var lines:CMinimapLines;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
