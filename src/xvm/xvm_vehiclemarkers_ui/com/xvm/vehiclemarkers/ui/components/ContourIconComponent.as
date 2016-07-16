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
                marker.vehicleIcon.visible = Macros.FormatBoolean(cfg.enabled, e.playerState, true);
                if (marker.vehicleIcon.visible)
                {
                    marker.vehicleIcon.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.vehicleIcon.y = Macros.FormatNumber(cfg.y, e.playerState);
                    marker.vehicleIcon.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 1) / 100.0;
                }

                var tintAmount:Number = Macros.FormatNumber(cfg.amount, e.playerState, -1);
                if (tintAmount >= 0)
                {
                    var tintColor:Number = Macros.FormatNumber(cfg.color || "{{c:system}}", e.playerState, NaN, true);
                    GraphicsUtil.setColorTransform(marker.vehicleIcon, tintColor, tintAmount / 100.0);
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
