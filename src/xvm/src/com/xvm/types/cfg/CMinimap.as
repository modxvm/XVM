/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public class CMinimap extends Object
    {
        public var enabled:Boolean;
        public var mapBackgroundImageAlpha:Number;
        public var selfIconAlpha:Number;
        public var cameraAlpha:Number;
        public var iconScale:Number;
        public var zoom: CMinimapZoom;
        public var square:CMinimapSquare;
        public var circles: CMinimapCircles;
        public var lines:CMinimapLines;
        public var labels: CMinimapLabels;
    }
}
