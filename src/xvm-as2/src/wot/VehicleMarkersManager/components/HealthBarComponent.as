import com.xvm.*;
import com.greensock.*;
import com.greensock.easing.*;
import wot.VehicleMarkersManager.components.*;

class wot.VehicleMarkersManager.components.HealthBarComponent
{
    private var proxy:HealthBarProxy;

    private var healthBar: MovieClip;
    private var border: MovieClip;
    private var fill: MovieClip;
    private var damage: MovieClip;

    public function HealthBarComponent(proxy:HealthBarProxy)
    {
        this.proxy = proxy;
    }

    public function init()
    {
        healthBar = proxy.createHolder();
        border = healthBar.createEmptyMovieClip("border", 1);
        fill = healthBar.createEmptyMovieClip("fill", 2);
        damage = healthBar.createEmptyMovieClip("damage", 3);
    }

    /**
     * Show floating damage indicator
     * @param	delta absolute damage
     * @param	flag  damage source: 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
     * @param	damageType damage kind: "attack", "fire", "ramming", "world_collision", "death_zone", "drowning", "explosion"
     */
    public function showDamage(state_cfg:Object, curHealth:Number, maxHealth:Number, delta:Number, flag:Number, damageType:String)
    {
        var cfg = state_cfg.healthBar;
        //Flow bar animation
        TweenLite.killTweensOf(damage);
        damage._x = cfg.border.size + cfg.width * (curHealth / maxHealth) - 1;
        damage._xscale = damage._xscale + 100 * (delta / maxHealth);
        GraphicsUtil.setColor(damage, proxy.formatDynamicColor(cfg.damage.color, delta, flag, damageType));
        damage._alpha = proxy.formatDynamicAlpha(cfg.damage.alpha);
        TweenLite.to(damage, cfg.damage.fade, {_xscale: 0, ease: Cubic.easeIn });
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.healthBar;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        healthBar._visible = visible;
    }

    private function draw(cfg:Object)
    {
        healthBar.clear();
        border.clear();
        fill.clear();
        damage.clear();

        GraphicsUtil.fillRect(border, 0, 0, cfg.width + cfg.border.size * 2, cfg.height + cfg.border.size * 2,
            proxy.formatDynamicColor(cfg.border.color), proxy.formatDynamicAlpha(cfg.border.alpha));

        var ct = proxy.formatStaticColorText(cfg.color);
        var lct = proxy.formatStaticColorText(cfg.lcolor);
        var fullColor: Number = proxy.formatDynamicColor(ct);
        var lowColor: Number = proxy.formatDynamicColor(lct || ct);
        var percent: Number = proxy.curHealth / proxy.maxHealth;
        var currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);

        GraphicsUtil.fillRect(fill, cfg.border.size, cfg.border.size,
            cfg.width * Math.min(proxy.curHealth / proxy.maxHealth, 1.0), cfg.height,
            currColor, proxy.formatDynamicAlpha(cfg.fill.alpha));

        damage._xscale = 0;

        GraphicsUtil.fillRect(damage, cfg.border.size, cfg.border.size, cfg.width, cfg.height,
            proxy.formatDynamicColor(cfg.damage.color), proxy.formatDynamicAlpha(cfg.damage.alpha));

        healthBar._x = cfg.x;
        healthBar._y = cfg.y;
        healthBar._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}
