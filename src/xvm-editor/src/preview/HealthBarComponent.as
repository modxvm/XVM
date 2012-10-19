package preview
{

import com.greensock.TweenLite;
import com.greensock.easing.Cubic;

import flash.display.MovieClip;

import mx.containers.Canvas;
import mx.core.ScrollPolicy;

import preview.*;

import utils.*;

public class HealthBarComponent
{
    private var proxy:HealthBarProxy;

    private var healthBar: Canvas;
    private var border: Canvas;
    private var fill: Canvas;
    private var damage: Canvas;

    public function HealthBarComponent(proxy:HealthBarProxy)
    {
        this.proxy = proxy;

        healthBar = new Canvas();
        healthBar.horizontalScrollPolicy = healthBar.verticalScrollPolicy = ScrollPolicy.OFF;
        border = new Canvas();
        healthBar.addChild(border);
        border.horizontalScrollPolicy = border.verticalScrollPolicy = ScrollPolicy.OFF;
        damage = new Canvas();
        healthBar.addChild(damage);
        damage.horizontalScrollPolicy = damage.verticalScrollPolicy = ScrollPolicy.OFF;
        fill = new Canvas();
        healthBar.addChild(fill);
        fill.horizontalScrollPolicy = fill.verticalScrollPolicy = ScrollPolicy.OFF;
        proxy.addChild(healthBar);
        healthBar.includeInLayout = false;
    }

    public function showDamage(state_cfg:Object, curHealth:Number, maxHealth:Number, delta:Number)
    {
        var cfg = state_cfg.healthBar;
		if (!cfg.visible)
			return;
        //Flow bar animation
        TweenLite.killTweensOf(damage);

		var o = { delta: delta };
		
		var onUpdate:Function = function()
		{
			damage.graphics.clear();
			damage.graphics.beginFill(proxy.formatDynamicColor(cfg.damage.color), proxy.formatDynamicAlpha(cfg.damage.alpha) / 100.0);
			damage.graphics.drawRect(cfg.border.size + cfg.width * (curHealth / maxHealth), cfg.border.size,
				cfg.width * o.delta / maxHealth, cfg.height);
			damage.graphics.endFill();
		}

		onUpdate();

        TweenLite.to(o, cfg.damage.fade, {onUpdate:onUpdate, delta: 0, ease: Cubic.easeIn });
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.healthBar;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        healthBar.visible = visible;
    }

    private function draw(cfg:Object)
    {
		TweenLite.killTweensOf(damage);
        healthBar.graphics.clear();
        border.graphics.clear();
        fill.graphics.clear();
        damage.graphics.clear();

		var ct = proxy.formatStaticColorText(cfg.color);
		var lct = proxy.formatStaticColorText(cfg.lcolor);
		var fullColor: Number = proxy.formatDynamicColor(ct);
		var lowColor: Number = proxy.formatDynamicColor(lct || ct);
		var percent: Number = proxy.curHealth / proxy.maxHealth;
		var currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);
				
        border.graphics.beginFill(proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.border.color)),
			proxy.formatDynamicAlpha(cfg.border.alpha) / 100.0);
        border.graphics.drawRect(0, 0, cfg.width + cfg.border.size * 2, cfg.height + cfg.border.size * 2);
        border.graphics.endFill();

        fill.graphics.beginFill(currColor, proxy.formatDynamicAlpha(cfg.fill.alpha) / 100.0);
        fill.graphics.drawRect(cfg.border.size, cfg.border.size,
			cfg.width * proxy.curHealth / proxy.maxHealth, cfg.height);
        fill.graphics.endFill();
		
        healthBar.x = cfg.x;
        healthBar.y = cfg.y;
        healthBar.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
    }
}

}
