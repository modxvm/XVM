/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimap extends Object
    {
        public var enabled:Boolean;
        public var mapBackgroundImageAlpha:Number;
        public var selfIconAlpha:Number;
        public var hideCameraTriangle:Boolean;
        public var showCameraLineAfterDeath:Boolean;
        public var cameraAlpha:Number;
        public var iconScale:Number;
        public var minimapAimIcon:String;
        public var minimapAimIconScale:Number;
        public var zoom: CMinimapZoom;
        public var square:CMinimapSquare;
        public var circles: CMinimapCircles;
        public var lines:CMinimapLines;
        public var labels: CMinimapLabels;
    }
}
