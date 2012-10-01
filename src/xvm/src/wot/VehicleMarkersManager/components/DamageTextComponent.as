import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import wot.utils.Config;
import wot.utils.GraphicsUtil;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.DamageTextProxy;

class wot.VehicleMarkersManager.components.DamageTextComponent
{
    private var proxy:DamageTextProxy;

    private var damage:MovieClip;
    
    public function DamageTextComponent(proxy:DamageTextProxy)
    {
        this.proxy = proxy;

        damage = proxy.createHolder();
    }

    public function showDamage(state_cfg:Object, newHealth:Number, delta:Number, flag:Number, damageType:Number)
    {
        var cfg = state_cfg.damageText;

        if (!cfg.visible)
            return;

        var n = damage.getNextHighestDepth();
        var tf: TextField = damage.createTextField("txt" + n, n, 0, 0, 140, 20);
        var animation: TimelineLite = new TimelineLite({ onComplete:removeTextField, onCompleteParams:[ tf ] });

        tf.text = defineText(cfg, newHealth, delta);
        tf.antiAliasType = "advanced";
        tf.autoSize = "left";
        tf.border = false;
        tf.embedFonts = true;
        tf.setTextFormat(XvmHelper.createNewTextFormat(cfg.font));
        tf.textColor = defineTextColor(flag, damageType);
        tf._x = -(tf._width / 2.0);

        if (cfg.shadow)
        {
            var sh_color:Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color));
            var sh_alpha:Number = proxy.formatDynamicAlpha(cfg.shadow.alpha);
            tf.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
        }

        animation.insert(new TweenLite(tf, cfg.speed, { _y: -cfg.maxRange, ease: Linear.easeOut } ), 0);
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
    
    private function defineTextColor(flag:Number, damageType:Number):Number
    {
        return Config.s_config.dmgPalette[damageType][flag];
    }
    
    private function defineText(cfg:Object, newHealth:Number, delta:Number):String
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

    // Damage Visualization
    private function removeTextField(f: TextField)
    {
        f.removeTextField();
        delete f;
    }
}
