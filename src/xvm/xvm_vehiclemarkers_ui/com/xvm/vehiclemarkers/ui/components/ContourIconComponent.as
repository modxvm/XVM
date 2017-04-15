/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;
    import com.xvm.types.cfg.*;

    public class ContourIconComponent extends VehicleMarkerComponentBase
    {
        public function ContourIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersContourIcon = e.cfg.contourIcon;
                marker.vehicleIcon.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.vehicleIcon.x = cfg.x;
                    marker.vehicleIcon.y = cfg.y;
                    marker.vehicleIcon.alpha = cfg.alpha / 100.0;
                    if (cfg.amount)
                    {
                        var color:Number = isNaN(cfg.color) ? Macros.FormatNumber("{{c:system}}", e.playerState) : cfg.color;
                        GraphicsUtil.tint(marker.vehicleIcon, color, cfg.amount / 100.0);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }


//
        ///**
         //* @see .ctor
         //*/
        //function setupContourIconComponent(team:String)
        //{
            //// Alternative icon set
            //if (!m_iconset)
            //{
                //m_iconset = new IconLoader(this, completeLoadContourIcon);
                //m_iconset.init(proxy.iconLoader,
                    //[ proxy.source.split(Defines.WG_CONTOUR_ICON_PATH).join(Defines.XVMRES_ROOT + ((team == "ally")
                    //? Config.config.iconset.vehicleMarkerAlly
                    //: Config.config.iconset.vehicleMarkerEnemy)), proxy.source ]);
            //}
//
            //proxy.iconLoader.source = m_iconset.currentIcon;
        //}

    }
}
