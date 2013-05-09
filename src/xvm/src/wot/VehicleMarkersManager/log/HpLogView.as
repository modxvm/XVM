import com.xvm.Logger;
import com.xvm.GraphicsUtil;

class wot.VehicleMarkersManager.log.HpLogView
{
    private static var FIELD_NAME:String = "__xvmHpLog";
    private var cfg:Object;
    
    private var tf:TextField;
    
    public function HpLogView(cfg:Object) 
    {
        this.cfg = cfg;
        
        tf = _root.createTextField(FIELD_NAME, 80 /*_root.getNextHighestDepth()*/, 500, 500, 500, 500);
        Logger.add("tf.getDepth() " + tf.getDepth());
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
        var tf:TextField = _root[FIELD_NAME];
        Logger.add("tf.getDepth() " + tf.getDepth());
        Logger.add("HpLogView update model");
        tf.htmlText = "updat\n";
        for (var i in model)
        {
            var player = model[i];
            Logger.add("" + player.pFullName + " " + player.vType + " " + player.curHealth);
            tf.htmlText += player.pFullName + " " + player.vType + " " + player.curHealth + "\n";
        }
        Logger.add("\n");
        Logger.add("txt: " + tf.htmlText);
        tf.htmlText = "";
        /**
         * VVM's separate sandbox can know about death
         * event only inside markers draw area.
         */
    }
}
