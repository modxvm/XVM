/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.display.*;

    public class ContourIconComponent extends VehicleMarkerComponentBase
    {
        //// Fix markers centering
        //private static var MARKER_CENTER_OFFSET_X = -9.5;
        //private static var MARKER_CENTER_OFFSET_Y = {
            //$lightTank: -23.5,
            //$mediumTank: -24.5,
            //$heavyTank: -29.5,
            //$AT_SPG: -20.5,
            //$SPG: -20.5,
            //$dynamic: -22.5
        //}

        //private var m_hunt;
        //private var m_markerLabel;  // [proxy] "green", "gold", "blue", "yellow", "red", "purple"
        //private var m_markerState;  // [proxy.marker] "dead", "immediate_dead", ...
        //private var m_vehicleClass; // [proxy.marker.marker.icon] "lightTank", "mediumTank", ..., "dynamic" (speaker)

        public function ContourIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            //m_markerLabel = null;
            //m_markerState = null;
        }

        //private var m_contourIconLoaded:Boolean;
        //private var m_iconset: IconLoader;
        //public var onEnterFrame:Function;

//        public function init()
        //{
            //onEnterFrame = null;
//
            //m_contourIconLoaded = false;
//
            //if (proxy.initialized)
            //{
                //setupContourIconComponent(team);
            //}
            //else
            //{
                //// if loader is not initialized, wait one frame
                //onEnterFrame = function()
                //{
                    //delete this.onEnterFrame;
//
                    //if (!this.proxy.initialized)
                    //{
                        //Logger.add("INTERNAL ERROR: setupContourIconLoader(): proxy.iconLoader not initialized");
                        //return;
                    //}
//
                    //this.setupContourIconComponent(team);
                //}
            //}
        //}
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
//
        ///**
         //* Callback function called when contour icon is loaded
         //*/
        //function completeLoadContourIcon()
        //{
            //proxy.iconLoader._visible = false;
            //onEnterFrame = function()
            //{
                //delete this.onEnterFrame;
                //this.m_contourIconLoaded = true;
                //this.updateState(this.proxy.currentStateConfigRoot);
            //}
        //}
//
        ///**
         //* Update contour icon state
         //* @param	state_cfg Current state config section
         //* @see	completeLoadContourIcon
         //* @see	XVMUpdateStyle
         //*/
        //function updateState(state_cfg:Object)
        //{
            //if (!m_contourIconLoaded)
                //return;
//
            //try
            //{
                //var cfg = state_cfg.contourIcon;
//
                //if (cfg.amount >= 0)
                //{
                    //// TODO: Check performance, not necessary to execute every marker update
                    //var tintColor: Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color));
                    //var tintAmount: Number = Math.min(100, Math.max(0, cfg.amount)) * 0.01;
                    //GraphicsUtil.setColor(proxy.iconLoader, tintColor, tintAmount);
                //}
//
                //var visible = cfg.enabled;
                //if (visible)
                //{
                    //proxy.iconLoader._x = cfg.x - (proxy.iconLoader.content._width / 2.0);
                    //proxy.iconLoader._y = cfg.y - (proxy.iconLoader.content._height / 2.0);
                    //proxy.iconLoader._alpha = proxy.formatDynamicAlpha(cfg.alpha);
                //}
                //proxy.iconLoader._visible = visible;
            //}
            //catch (e)
            //{
                //Logger.err(e);
            //}
        //}
    }
}
