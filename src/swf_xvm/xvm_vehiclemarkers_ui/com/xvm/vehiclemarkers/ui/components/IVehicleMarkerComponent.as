/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;

    internal interface IVehicleMarkerComponent
    {
        function init(e:XvmVehicleMarkerEvent):void;
        function onExInfo(e:XvmVehicleMarkerEvent):void;
        function update(e:XvmVehicleMarkerEvent):void;
    }
}
