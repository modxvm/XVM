/**
 * XVM Config - "battle" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CBattle extends Object
    {
        public var mirroredVehicleIcons:Boolean;      // Set false for alternative tank icon mirroring.
        public var showPostmortemTips:Boolean;        // Popup tooltip panel after death.
        public var removePanelsModeSwitcher:Boolean;  // Set true to hide mouse modes switcher.
        public var highlightVehicleIcon:Boolean;      // False - disable highlighting of selected vehicle icon and squad.
        public var useStandardMarkers:Boolean;        // Use original wot markers.
        public var clockFormat:String;                // Show the clock on the Debug Panel (near FPS). http://php.net/date
        public var clanIconsFolder:String;            // Folder with clan icons
        public var elements:Array;                    // Visual elements
    }
}
