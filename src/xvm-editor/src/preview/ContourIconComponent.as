package preview
{

import mx.core.UIComponent;

import preview.*;

import spark.components.Image;

import utils.*;

public class ContourIconComponent
{
    private var proxy:ContourIconProxy;

    private var contourIcon:Image = new Image();

    public var onEnterFrame:Function;

    public function ContourIconComponent(proxy:ContourIconProxy)
    {
        this.proxy = proxy;

		contourIcon.includeInLayout = false;
		contourIcon.visible = false;
        proxy.addChild(contourIcon);

        contourIcon.source = proxy.isDead ? new Resources.IMG_contour3()
            : proxy.team == "ally" ? new Resources.IMG_contour1() : new Resources.IMG_contour2();
        contourIcon.width = 80;
        contourIcon.height = 24;

        //updateState(this.proxy.currentStateConfigRoot);
    }

    /**
     * Update contour icon state
     * @param	state_cfg Current state config section
     * @see	completeLoadContourIcon
     * @see	XVMUpdateStyle
     */
    public function updateState(state_cfg:Object):void
    {
        var cfg:Object = state_cfg.contourIcon;

		contourIcon.visible = cfg.visible;
		if (cfg.visible)
		{
			contourIcon.x = cfg.x - contourIcon.width / 2.0;
			contourIcon.y = cfg.y - contourIcon.height / 2.0;
			var tintColor: Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color));
			var tintAmount: Number = Math.min(100, Math.max(0, cfg.amount)) * 0.01;
			GraphicsUtil.setColor(contourIcon, tintColor, tintAmount);
			contourIcon.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
		}
    }
}

}
