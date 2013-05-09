import com.xvm.Logger;
import com.xvm.GraphicsUtil;

class wot.VehicleMarkersManager.log.HpLogView
{
    private var cfg:Object;
    
    private var tf:TextField;
    
    public function HpLogView(cfg:Object) 
    {
        this.cfg = cfg;
        
        tf = _root.createTextField("__xvmHpLog", _root.getNextHighestDepth(), 300, 300, 300, 300);
        //textField.verticalAlign = (direction == Defines.DIRECTION_DOWN) ? "top" : "bottom";
        tf.antiAliasType = "advanced";
        tf.multiline = true;
        tf.wordWrap = false;
        var shadow = cfg.shadow;
        if (shadow)
        {
            tf.filters = [ GraphicsUtil.createShadowFilter(shadow.distance, shadow.angle,
                parseInt(shadow.color), shadow.alpha, shadow.size, shadow.strength) ];
        }

        tf.html = true;
        /*
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".xvm_hplog{font-family:$FieldFont;font-size:15px;color:#f4efe8;}");
        tf.styleSheet = style;
        */
        tf.htmlText = "first Text%%";
    }
    
    public function update(model:Object) 
    {
        Logger.add("HpLogView update model");
        tf.htmlText = "updat\n";
        for (var i in model)
        {
            var player = model[i];
            Logger.add("" + player.pFullName + " " + player.vType + " " + player.curHealth);
            tf.htmlText += player.pFullName + " " + player.vType + " " + player.curHealth + "\n";
        }
        Logger.add("\n");
        tf.htmlText = "";
        /**
         * VVM's separate sandbox can know about death
         * event only inside markers draw area.
         */
    }
}
