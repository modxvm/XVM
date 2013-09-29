package 
{
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.text.ime.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import net.wg.gui.lobby.battleloading.*;
    
    public dynamic class RightItemRendererUI extends net.wg.gui.lobby.battleloading.PlayerItemRenderer
    {
        public function RightItemRendererUI()
        {
            super();
            this.__setProp_iconLoader_RightItemRenderer_icons_0();
            return;
        }

        internal function __setProp_iconLoader_RightItemRenderer_icons_0():*
        {
            try 
            {
                iconLoader["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            iconLoader.autoSize = false;
            iconLoader.enableInitCallback = false;
            iconLoader.maintainAspectRatio = false;
            iconLoader.source = "";
            iconLoader.sourceAlt = "../maps/icons/vehicle/contour/noImage.png";
            iconLoader.visible = true;
            try 
            {
                iconLoader["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}
