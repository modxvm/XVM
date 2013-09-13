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
    import net.wg.gui.components.controls.*;
    
    public dynamic class TextInput extends net.wg.gui.components.controls.TextInput
    {
        public function TextInput()
        {
            super();
            addFrameScript(9, this.frame10, 19, this.frame20, 29, this.frame30, 39, this.frame40);
            this.__setProp_highlightMc_TextInput_highlight_0();
            return;
        }

        internal function __setProp_highlightMc_TextInput_highlight_0():*
        {
            try 
            {
                highlightMc["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            highlightMc.enabled = true;
            highlightMc.enableInitCallback = false;
            highlightMc.visible = false;
            try 
            {
                highlightMc["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function frame10():*
        {
            stop();
            return;
        }

        internal function frame20():*
        {
            stop();
            return;
        }

        internal function frame30():*
        {
            stop();
            return;
        }

        internal function frame40():*
        {
            stop();
            return;
        }
    }
}
