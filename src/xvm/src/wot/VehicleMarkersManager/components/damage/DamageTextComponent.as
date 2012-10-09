import wot.utils.GraphicsUtil;
import wot.VehicleMarkersManager.components.damage.DamageTextConfig;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.damage.DamageTextProxy;
import wot.VehicleMarkersManager.components.damage.DamageTextAnimation;
class wot.VehicleMarkersManager.components.damage.DamageTextComponent
{
    private var proxy:DamageTextProxy;
    private var cfg:DamageTextConfig;

    private var damage:MovieClip;
    private var dmgReceiverCfg:Object;
    private var dmgSourceCfg:Object;

    public function DamageTextComponent(proxy:DamageTextProxy)
    {
        this.proxy = proxy;
        damage = proxy.createHolder();
    }

    /**
     * @param	dmgReceiverCfg
     * Damage indicator configuration from markers section.
     * Contains dmgText specs from enemy\alive\normal for example.
     *
     * @param	dmgIndicatorCfg
     * Damage indicator configuration from damageTextMajor first level section.
     */
    public function showDamage(dmgReceiverCfg:Object, dmgSourceCfg:Object, newHealth:Number, delta:Number, flag:Number, damageType:String)
    {
        this.cfg = new DamageTextConfig(dmgReceiverCfg, dmgSourceCfg, flag, damageType);

        if (!cfg.visible)
            return;

        var text:String = defineText(newHealth, delta);
        var tf:TextField = createTextField(text, cfg.textColor, cfg.shadowColor);
        var animation = new DamageTextAnimation(tf, cfg); // defines and starts
    }

    public function updateState(state_cfg:Object)
    {
        // TODO:
        // Not adapted to new damage model

        var cfg = state_cfg.damageText;
        var visible = cfg.visible;
        if (visible)
        {
            damage._x = cfg.x;
            damage._y = cfg.y;
        }
        damage._visible = visible;
    }

    // PRIVATE METHODS

    private function createTextField(text:String, textColor:Number, shadowColor:Number):TextField
    {
//TODO:getDamageSystemColor
//TODO:css
        var n = damage.getNextHighestDepth();
        var tf: TextField = damage.createTextField("txt" + n, n, 0, 0, 140, 20);

        tf.text = text;
        tf.antiAliasType = "advanced";
        tf.autoSize = "left";
        tf.border = false;
        tf.embedFonts = true;
        tf.setTextFormat(XvmHelper.createNewTextFormat(cfg.font));
        tf.textColor = textColor;
        tf._x = -(tf._width / 2.0);

        if (cfg.shadow)
        {
            //var sh_color:Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color));
            tf.filters = [ GraphicsUtil.createShadowFilter
            (
                cfg.shadow.distance,
                cfg.shadow.angle,
                shadowColor,
                cfg.shadow.aplha,
                cfg.shadow.size,
                cfg.shadow.strength
            ) ];
        }

        return tf;
    }

    private function defineText(newHealth:Number, delta:Number):String
    {
        var msg = (newHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
        var text = proxy.formatDynamicText(proxy.formatStaticText(msg), newHealth, delta);
        // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
        // so we're appending empty prefix and suffix to bypass this unexpected behavior
        return " " + text + " ";
    }
}
