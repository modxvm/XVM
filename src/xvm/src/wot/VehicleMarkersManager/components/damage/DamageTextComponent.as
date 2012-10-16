import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.damage.DamageTextProxy;
import wot.VehicleMarkersManager.components.damage.DamageTextAnimation;

class wot.VehicleMarkersManager.components.damage.DamageTextComponent
{
    private var proxy:DamageTextProxy;
    private var cfg:Object;

    private var damage:MovieClip;

    public function DamageTextComponent(proxy:DamageTextProxy)
    {
        this.proxy = proxy;
        damage = proxy.createHolder();
    }

    /**
     * Show floating damage indicator
     * @param	cfg damageText config section for current state
     * @param	newHealth value of new health
     * @param	delta absolute damage
     * @param	flag  damage source: 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
     * @param	damageType damage kind: "attack", "fire", "ramming", "world_collision", "death_zone", "drowning", "explosion"
     */
    public function showDamage(cfg:Object, newHealth:Number, delta:Number, flag:Number, damageType:String)
    {
        this.cfg = cfg;// new DamageTextConfig(dmgReceiverCfg, dmgSourceCfg, flag, damageType);

        if (!cfg.visible)
            return;

        var text:String = defineText(newHealth, delta, damageType);

        var color:Number;
        if (cfg.color == null)
        {
            color = ColorsManager.getDamageSystemColor(flagToDamageSource(flag), proxy.damageDest,
                proxy.isDead, proxy.isBlowedUp, proxy.isColorBlindMode);
        }
        else
        {
            color = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color), damageType);
        }

        var shadowColor:Number;
        if (cfg.shadow.color == null)
        {
            shadowColor = ColorsManager.getDamageSystemColor(flagToDamageSource(flag), proxy.damageDest,
                proxy.isDead, proxy.isBlowedUp, proxy.isColorBlindMode);
        }
        else
        {
            shadowColor = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color), damageType);
        }

        // TODO: dynamic alpha?
        //var alpha = proxy.formatDynamicAlpha(cfg.alpha);
        //var shadowAlpha = proxy.formatDynamicAlpha(cfg.shadow.alpha);

        var tf:TextField = createTextField(color, shadowColor, cfg);

        tf.htmlText = "<textformat leading='-2'><p class='xvm_damageText'>" + text + "</p></textformat>";
        //wot.utils.Logger.add("dmg: " + flagToDamageSource(flag) + ", " + proxy.damageDest + " - color=" + color);
        //wot.utils.Logger.add(tf.htmlText);
        //wot.utils.Logger.add(XvmHelper.createCSS(cfg.font, color, "xvm_damageText"));

        var dummy = new DamageTextAnimation(cfg, tf); // defines and starts
    }

    public function updateState(state_cfg:Object)
    {
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

    private function createTextField(color:Number, shadowColor:Number, cfg):TextField
    {
        var n = damage.getNextHighestDepth();
        var tf: TextField = damage.createTextField("txt" + n, n, 0, 0, 200, 100);

        tf.antiAliasType = "advanced";
        tf.multiline = true;
        tf.wordWrap = false;

        tf.html = true;

        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(XvmHelper.createCSS(cfg.font, color, "xvm_damageText"));
        tf.styleSheet = style;

        tf.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance, cfg.shadow.angle, shadowColor,
            cfg.shadow.alpha, cfg.shadow.size, cfg.shadow.strength) ];

        tf._x = -(tf._width / 2.0);

/*        var b1:flash.display.BitmapData = new flash.display.BitmapData(16, 16);
        var matrix:flash.geom.Matrix = new flash.geom.Matrix()
        b1.draw(proxy.xvm.clanIconComponent.m_clanIcon, matrix);
        tf.setImageSubstitutions([ { subString:"[", image:b1 } ]);*/

        return tf;
    }

    private function defineText(newHealth:Number, delta:Number, damageType:String):String
    {
        var msg = (newHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
        var text = proxy.formatDynamicText(proxy.formatStaticText(msg), newHealth, delta, damageType);
        // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
        // so we're appending empty prefix and suffix to bypass this unexpected behavior
        return " " + text + " ";
    }

    //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
    private static function flagToDamageSource(flag:Number):String
    {
        switch (flag)
        {
            case Defines.FROM_ALLY:
                return "ally";
            case Defines.FROM_ENEMY:
                return "enemy";
            case Defines.FROM_PLAYER:
                return "player";
            case Defines.FROM_SQUAD:
                return "squadman";
            case Defines.FROM_UNKNOWN:
            default:
                return "unknown";
        }
    }
}
