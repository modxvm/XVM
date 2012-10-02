import wot.utils.Config;
import wot.utils.GraphicsUtil;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.DamageTextProxy;
import wot.VehicleMarkersManager.components.DamageTextAnimation;

class wot.VehicleMarkersManager.components.DamageTextComponent
{
    private var proxy:DamageTextProxy;

    private var damage:MovieClip;
    private var cfg:Object;
    
    public function DamageTextComponent(proxy:DamageTextProxy)
    {
        this.proxy = proxy;

        damage = proxy.createHolder();
    }

    public function showDamage(state_cfg:Object, newHealth:Number, delta:Number, flag:Number, damageType:Number)
    {
        cfg = state_cfg.damageText;

        if (!cfg.visible)
            return;

        var text:String = defineText(newHealth, delta);
        var color:Number = defineTextColor(flag, damageType);
        var tf:TextField = createTextField(text, color);

        if (cfg.shadow)
        {
            var sh_color:Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color));
            var sh_alpha:Number = proxy.formatDynamicAlpha(cfg.shadow.alpha);
            tf.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
        }
        
        var animation = new DamageTextAnimation(tf, cfg); // defines and starts
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.damageText;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        damage._visible = visible;
    }

    // PRIVATE METHODS
    
    private function createTextField(text:String, color:Number):TextField
    {
        var n = damage.getNextHighestDepth();
        var tf: TextField = damage.createTextField("txt" + n, n, 0, 0, 140, 20);

        tf.text = text;
        tf.antiAliasType = "advanced";
        tf.autoSize = "left";
        tf.border = false;
        tf.embedFonts = true;
        tf.setTextFormat(XvmHelper.createNewTextFormat(cfg.font));
        tf.textColor = color;
        tf._x = -(tf._width / 2.0);
        
        return tf;
    }
    
    private function defineTextColor(flag:Number, damageType:Number):Number
    {
        return Config.s_config.dmgPalette[damageType][flag];
    }
    
    private function defineText(newHealth:Number, delta:Number):String
    {
        var msg = (newHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
        var text = proxy.formatDynamicText(proxy.formatStaticText(msg), newHealth, delta);
        // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
        // so we're appending empty prefix and suffix to bypass this unexpected behavior
        return " " + text + " ";
    }
    
    private function draw(cfg:Object)
    {
        damage._x = cfg.x;
        damage._y = cfg.y;
    }
}
