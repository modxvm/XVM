import wot.utils.GlobalEventDispatcher;
import wot.utils.Defines;
import wot.utils.Utils;

class wot.battleloading.TipField
{
    private var form_mc:MovieClip;

    public function TipField(form_mc:MovieClip)
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("set_info", this, setInfoFieldData);
        setInfoFieldData( { } );
    }

    private function setInfoFieldData(event)
    {
        //Logger.addObject(event, "SetInfoFieldData(event)");
        var info: TextField = form_mc.helpTip;
        var tip: TextField = form_mc.tipText;

        info.text = "XVM v" + Defines.XVM_VERSION + "     " + Defines.XVM_INTRO;

        if (event.ver && Utils.compareVersions(String(event.ver), Defines.XVM_VERSION) == 1)
        {
            info.textColor = 0x60FF60;
            info.text = "XVM: New version: v" + String(event.ver) + " (current is v" + Defines.XVM_VERSION + ")";
            if (event.message && event.message != "")
                setTipText(event.message);
        }

        if (event.warning != undefined)
        {
            info.textColor = 0xFFD040;
            if (event.warning != "")
                setTipText(event.warning);
        }

        if (event.error != undefined)
        {
            info.textColor = 0xFF4040;
            if (event.error != "")
                setTipText(event.error, true);
        }
    }

    private function setTipText(text, isError)
    {
        var tip: TextField = form_mc.tipText;
        var tf: TextFormat = tip.getNewTextFormat();
        tf.align = "left";
        tf.size = 12;
        tf.leading = 0;
        tip.setNewTextFormat(tf);
        tip.text = text;
        if (isError)
        {
            tf.color = 0xFF4040;
            var pos = text.indexOf(">>>");
            if (pos != -1)
                tip.setTextFormat(pos, pos + 3, tf);
            pos = text.indexOf("<<<");
            if (pos != -1)
                tip.setTextFormat(pos, pos + 3, tf);
        }
    }
}