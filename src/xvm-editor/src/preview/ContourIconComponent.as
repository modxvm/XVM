package preview
{

import utils.*;
import preview.*;

public class ContourIconComponent
{
    private var proxy:ContourIconProxy;
    private var m_contourIconLoaded:Boolean;
    private var m_iconset: IconLoader;

    public var onEnterFrame:Function;

    public function ContourIconComponent(proxy:ContourIconProxy)
    {
        this.proxy = proxy;

        /*
        contourIconHolder = new UIComponent();
        contourIconHolder.includeInLayout = false;
        addChild(contourIconHolder);

        contourIcon.includeInLayout = false;
        contourIcon.source = _vdead ? new Resources.IMG_contour3()
        : _vtype == "ally" ? new Resources.IMG_contour1() : new Resources.IMG_contour2();
        contourIcon.width = 80;
        contourIcon.height = 24;
        
        contourIconHolder.visible = false;
        contourIconHolder.addChild(contourIcon);
        */
        onEnterFrame = null;

        m_contourIconLoaded = false;

        if (proxy.initialized)
        {
            setupContourIconComponent();
        }
        else
        {
            // if loader is not initialized, wait one frame
            onEnterFrame = function()
            {
                delete this.onEnterFrame;

                if (!this.proxy.initialized)
                {
                    ErrorHandler.setText("INTERNAL ERROR: setupContourIconLoader(): proxy.iconLoader not initialized");
                    return;
                }

                this.setupContourIconComponent();
            }
        }
    }

    /**
     * @see .ctor
     */
    function setupContourIconComponent()
    {
        // Alternative icon set
        if (!m_iconset)
        {
            m_iconset = new IconLoader(this, completeLoadContourIcon);
            m_iconset.init(proxy.iconLoader,
                [ proxy.source.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.vehicleMarker), proxy.source ]);
        }

        proxy.iconLoader.source = m_iconset.currentIcon;
    }

    /**
     * Callback function called when contour icon is loaded
     */
    function completeLoadContourIcon()
    {
        proxy.iconLoader._visible = false;
        onEnterFrame = function()
        {
            delete this.onEnterFrame;
            this.m_contourIconLoaded = true;
            this.updateState(this.proxy.currentStateConfigRoot);
        }
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
                GraphicsUtil.setColor(proxy.iconLoader, tintColor, tintAmount);
            }

            var visible = cfg.visible;
            if (visible)
            {
                proxy.iconLoader._x = cfg.x - (proxy.iconLoader.contentHolder._width / 2.0);
                proxy.iconLoader._y = cfg.y - (proxy.iconLoader.contentHolder._height / 2.0);
                proxy.iconLoader._alpha = proxy.formatDynamicAlpha(cfg.alpha);
            }
            proxy.iconLoader._visible = visible;
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: updateContourIcon():" + String(e));
        }
    }
}

}
