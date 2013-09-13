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
    
    public dynamic class ButtonIconText extends net.wg.gui.components.controls.IconTextButton
    {
        public function ButtonIconText()
        {
            super();
            addFrameScript(9, this.frame10, 19, this.frame20, 29, this.frame30, 39, this.frame40, 49, this.frame50, 59, this.frame60);
            this.__setProp_disableMc_ButtonIconText_disable_0();
            this.__setProp_alertMC_ButtonIconText_alert_0();
            return;
        }

        internal function __setProp_disableMc_ButtonIconText_disable_0():*
        {
            try 
            {
                disableMc["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            disableMc.enabled = true;
            disableMc.enableInitCallback = false;
            disableMc.heightFill = 10;
            disableMc.repeat = "horizontal";
            disableMc.source = "BtnDisableBmp";
            disableMc.startPos = "TL";
            disableMc.visible = true;
            disableMc.widthFill = 100;
            try 
            {
                disableMc["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function __setProp_alertMC_ButtonIconText_alert_0():*
        {
            try 
            {
                alertMC["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            alertMC.enabled = true;
            alertMC.enableInitCallback = false;
            alertMC.visible = false;
            try 
            {
                alertMC["componentInspectorSetting"] = false;
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

        internal function frame50():*
        {
            stop();
            return;
        }

        internal function frame60():*
        {
            stop();
            return;
        }
    }
}
