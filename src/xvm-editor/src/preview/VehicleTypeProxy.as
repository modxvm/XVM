package preview
{

import flash.display.MovieClip;

import preview.*;

import utils.*;

public class VehicleTypeProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function VehicleTypeProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

    public function get isSpeaking():Boolean
    {
        return xvm.m_speaking;
    }

    public function get entityName():String
    {
        return xvm.m_entityName;
    }

    public function setMarkerLabel(markerLabel:String):void
    {
        marker.gotoAndStop(markerLabel);
    }

    public function get marker():MovieClip
    {
        return xvm.m_entityType == "ally" ? xvm.proxy.vehicleIconAlly : xvm.proxy.vehicleIconEnemy;
    }
}

}
