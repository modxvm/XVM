import com.greensock.TweenLite;
import com.greensock.easing.Cubic;
import wot.utils.GraphicsUtil;
import wot.VehicleMarkersManager.components.HealthBarProxy;

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

        healthBar = proxy.createHolder();
        border = healthBar.createEmptyMovieClip("border", 1);
        fill = healthBar.createEmptyMovieClip("fill", 2);
        damage = healthBar.createEmptyMovieClip("damage", 3);
    }

    public function showDamage(state_cfg:Object, curHealth:Number, maxHealth:Number, delta:Number)
    {
        var cfg = state_cfg.healthBar;
        //Flow bar animation
        TweenLite.killTweensOf(damage);
        damage._x = cfg.border.size + cfg.width * (curHealth / maxHealth) - 1;
        damage._xscale = damage._xscale + 100 * (delta / maxHealth);
        GraphicsUtil.setColor(damage, proxy.formatDynamicColor(cfg.damage.color));
        damage._alpha = proxy.formatDynamicAlpha(cfg.damage.alpha, curHealth);
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

        GraphicsUtil.fillRect(border, 0, 0, cfg.width + cfg.border.size * 2, cfg.height + cfg.border.size * 2);
        GraphicsUtil.fillRect(fill, cfg.border.size, cfg.border.size, cfg.width, cfg.height);
        GraphicsUtil.fillRect(damage, cfg.border.size, cfg.border.size, cfg.width, cfg.height);

        damage._xscale = 0;

        healthBar._x = cfg.x;
        healthBar._y = cfg.y;
        healthBar._alpha = proxy.formatDynamicAlpha(cfg.alpha);

        GraphicsUtil.setColor(border, proxy.formatDynamicColor(cfg.border.color));
        border._alpha = proxy.formatDynamicAlpha(cfg.border.alpha);

        var ct = proxy.formatStaticColorText(cfg.color);
        var lct = proxy.formatStaticColorText(cfg.lcolor);
        var fullColor: Number = proxy.formatDynamicColor(ct);
        var lowColor: Number = proxy.formatDynamicColor(lct || ct);
        var percent: Number = proxy.curHealth / proxy.maxHealth;
        var currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);

        GraphicsUtil.setColor(fill, currColor);
        fill._alpha = proxy.formatDynamicAlpha(cfg.fill.alpha);
        fill._xscale = Math.min(proxy.curHealth / proxy.maxHealth * 100.0, 100);

        GraphicsUtil.setColor(damage, proxy.formatDynamicColor(cfg.damage.color));
        damage._alpha = proxy.formatDynamicAlpha(cfg.damage.alpha);
    }
}
