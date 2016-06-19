/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimap extends Object
    {
        public var enabled:*;
        public var mapBackgroundImageAlpha:*;
        public var selfIconAlpha:*;
        public var iconAlpha:*;
        public var hideCameraTriangle:*;
        public var showCameraLineAfterDeath:*;
        public var cameraAlpha:*;
        public var iconScale:*;
        public var minimapAimIcon:String;
        public var minimapAimIconScale:*;
        public var zoom:CMinimapZoom;
        public var mapSize:CMinimapMapSize;
        public var useStandardCircles:*;
        public var useStandardLabels:*;
        public var useStandardLines:*;
        public var labels:CMinimapLabels;
        public var labelsData:*;
        public var circles:CMinimapCircles;
        public var lines:CMinimapLines;
    }
}
