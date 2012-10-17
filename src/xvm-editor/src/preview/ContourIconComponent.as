package preview
{

import mx.core.UIComponent;
import spark.components.Image;
import utils.*;
import preview.*;

public class ContourIconComponent
{
    private var proxy:ContourIconProxy;
    private var m_contourIconLoaded:Boolean;

    private var contourIcon:Image = new Image();
    private var contourIconHolder: UIComponent;

    public var onEnterFrame:Function;

    public function ContourIconComponent(proxy:ContourIconProxy)
    {
        this.proxy = proxy;

        contourIconHolder = new UIComponent();
        contourIconHolder.includeInLayout = false;
        proxy.addChild(contourIconHolder);

        contourIcon.includeInLayout = false;
        contourIcon.source = proxy.isDead ? new Resources.IMG_contour3()
            : proxy.team == "ally" ? new Resources.IMG_contour1() : new Resources.IMG_contour2();
        contourIcon.width = 80;
        contourIcon.height = 24;

        contourIconHolder.visible = false;
        contourIconHolder.addChild(contourIcon);

        //updateState(this.proxy.currentStateConfigRoot);
    }

    /**
     * Update contour icon state
     * @param	state_cfg Current state config section
     * @see	completeLoadContourIcon
     * @see	XVMUpdateStyle
     */
    function updateState(state_cfg:Object)
    {
        if (!m_contourIconLoaded)
            return;

        try
        {
            var cfg = state_cfg.contourIcon;

            if (cfg.amount >= 0)
            {
                // TODO: Check performance, not necessary to execute every marker update
                var tintColor: Number = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color));
                var tintAmount: Number = Math.min(100, Math.max(0, cfg.amount)) * 0.01;
                GraphicsUtil.setColor(contourIconHolder, tintColor, tintAmount);
            }

            var visible = cfg.visible;
            if (visible)
            {
                contourIconHolder.x = cfg.x - (contourIcon.width / 2.0);
                contourIconHolder.y = cfg.y - (contourIcon.height / 2.0);
                contourIconHolder.alpha = proxy.formatDynamicAlpha(cfg.alpha);
            }
            contourIconHolder.visible = visible;
        }
        catch (e)
        {
//            ErrorHandler.setText("ERROR: updateContourIcon():" + String(e));
        }
    }
}

}
