//class ProgressElement_UI
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
    import net.wg.gui.lobby.battleResults.*;

    public dynamic class ProgressElement_UI extends net.wg.gui.lobby.battleResults.ProgressElement
    {
        public function ProgressElement_UI()
        {
            super();
            this.__setProp_progressTF_progressElement_Layer2_0();
            return;
        }

        internal function __setProp_progressTF_progressElement_Layer2_0():*
        {
            try
            {
                progressTF["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            progressTF.enabled = true;
            progressTF.label = "";
            progressTF.shadowColor = "Black";
            progressTF.textAlign = "left";
            progressTF.textColor = 9211006;
            progressTF.textFont = "$FieldFont";
            progressTF.textSize = 14;
            progressTF.useHtml = false;
            progressTF.visible = true;
            try
            {
                progressTF["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}


