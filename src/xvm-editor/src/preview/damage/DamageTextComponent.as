package preview.damage
{

import flash.display.MovieClip;
import flash.text.StyleSheet;
import flash.text.TextField;

import mx.core.UIComponent;

import preview.*;

import utils.*;

public class DamageTextComponent
{
    private var proxy:DamageTextProxy;
    private var cfg:Object;

    private var damage:UIComponent;

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
    public function showDamage(cfg:Object, newHealth:Number, delta:Number, flag:Number, damageType:String):void
    {
        this.cfg = cfg;// new DamageTextConfig(dmgReceiverCfg, dmgSourceCfg, flag, damageType);

        if (!cfg.visible)
            return;

        var text:String = defineText(newHealth, delta, damageType);

        var color:Number;
        if (cfg.color == null)
        {
            color = ColorsManager.getDamageSystemColor(flagToDamageSource(flag), proxy.damageDest, damageType,
                proxy.isDead, proxy.isBlowedUp);
        }
        else
        {
            color = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color), damageType);
        }

        var shadowColor:Number;
        if (cfg.shadow.color == null)
        {
            shadowColor = ColorsManager.getDamageSystemColor(flagToDamageSource(flag), proxy.damageDest, damageType,
                proxy.isDead, proxy.isBlowedUp);
        }
        else
        {
            shadowColor = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color), damageType);
        }

        var tf:TextField = createTextField(color, shadowColor, cfg);
		tf.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
		damage.addChild(tf);

        tf.htmlText = "<p class='xvm_damageText'>" + text.replace("$TextFont", "Tahoma") + "</p>";
        //wot.utils.Logger.add("dmg: " + flagToDamageSource(flag) + ", " + proxy.damageDest + " - color=" + color);
        //wot.utils.Logger.add(tf.htmlText);
        //wot.utils.Logger.add(XvmHelper.createCSS(cfg.font, color, "xvm_damageText"));

        new DamageTextAnimation(cfg, tf); // defines and starts
    }

    public function updateState(state_cfg:Object):void
    {
		var cfg:Object = state_cfg.damageText;
		damage.visible = cfg.visible;
		damage.x = cfg.x;
		damage.y = cfg.y;
    }

    // PRIVATE METHODS

    private function createTextField(color:Number, shadowColor:Number, cfg:Object):TextField
    {
        var tf: TextField = new TextField();
        tf.width = 200;
        tf.height = 100;

        tf.antiAliasType = "advanced";
        tf.multiline = true;
        tf.wordWrap = false;

		tf.embedFonts = cfg.font.name == "$FieldFont";
        //tf.html = true;

        var style:StyleSheet = new StyleSheet();
        style.parseCSS(XvmHelper.createCSS(cfg.font, color, "xvm_damageText"));
        tf.styleSheet = style;

        tf.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance, cfg.shadow.angle, shadowColor,
            cfg.shadow.alpha, cfg.shadow.size, cfg.shadow.strength) ];

        tf.x = -(tf.width / 2.0);

        return tf;
    }

    private function defineText(newHealth:Number, delta:Number, damageType:String):String
    {
        var msg:String = (newHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
        var text:String = proxy.formatDynamicText(proxy.formatStaticText(msg), newHealth, delta, damageType);
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

}
