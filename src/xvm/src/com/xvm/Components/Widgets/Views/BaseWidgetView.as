/**
 * Base Widget View
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Controls.Panel;
import com.xvm.Controls.Chart;
import com.xvm.Controls.Grid;
import com.xvm.Controls.Label;
import com.xvm.Controls.Progress;
import com.xvm.Components.Widgets.Views.IWidgetView;

class com.xvm.Components.Widgets.Views.BaseWidgetView implements IWidgetView
{
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private var mc:MovieClip;
    private var m_settings:Object;
    
    /////////////////////////////////////////////////////////////////
    // .ctor()

    public function BaseWidgetView(mc:MovieClip, settings:Object, defaults:Object)
    {
        this.m_settings = settings;

        var me = this;
        this.mc = mc;
        mc._x = settings.x != null ? settings.x : defaults.x != null ? defaults.x : 0;
        mc._y = settings.y != null ? settings.y : defaults.y != null ? defaults.y : 20;
        mc._alpha = settings.alpha != null ? settings.alpha : defaults.alpha != null ? defaults.alpha : 50;
        mc.onRollOver = function() {
            mc._alpha = settings.activeAlpha != null ? settings.activeAlpha : defaults.activeAlpha != null ? defaults.activeAlpha : 100;
        }
        mc.onRollOut = function() {
            mc._alpha = settings.alpha != null ? settings.alpha : defaults.alpha != null ? defaults.alpha : 100;
        }

        mc.onPress = function()          { me.onPress.apply(me, arguments); }
        mc.onRelease = function()        { me.onRelease.apply(me, arguments); }
        mc.onReleaseOutside = function() { me.onRelease.apply(me, arguments); }
        mc.onMouseMove = function()      { me.onMouseMove.apply(me, arguments); }

        var bgAlpha = settings.bgAlpha != null ? settings.bgAlpha : defaults.bgAlpha != null ? defaults.bgAlpha : 60;
        _panel = Panel.Create(mc, "panel", 0, 0,
            settings.width || defaults.width || 50,
            settings.height || defaults.height || 50,
            settings.bgColor != null ? settings.bgColor : defaults.bgColor != null ? defaults.bgColor : 0x000000, bgAlpha,
            1, 0xCCCCCC, bgAlpha);
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidgetView implementation

    private var _panel:Panel;
    public function get panel():Panel
    {
        return _panel;
    }
    
    // virtual abstract
    public function update(data:Object)
    {
        if (m_settings.bgAlpha != null && panel.alpha != m_settings.bgAlpha)
            panel.alpha = m_settings.bgAlpha;
        if (m_settings.bgColor != null && panel.color != m_settings.bgColor)
            panel.color = m_settings.bgColor;
    }

    // virtual abstract
    public function updateIdle(pos:Number)
    {
        throw new Error("ERROR: BaseWidgetView::updateIdle() is abstract method and must be overriden");
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private var mouseDown:Boolean = false;
    private var mouseX:Number;
    private var mouseY:Number;
    
    private function onPress(mouseIndex, button)
    {
        //Logger.addObject("onPress: " + com.xvm.JSONx.stringify(arguments));
        if (m_settings.pinned == true)
            return;
        mouseDown = true;
        mouseX = _root._xmouse;
        mouseY = _root._ymouse;
    }

    private function onRelease(mouseIndex, button)
    {
        //Logger.addObject("onRelease: " + com.xvm.JSONx.stringify(arguments));
        if (m_settings.pinned == true)
            return;
        mouseDown = false;
        m_settings.x = mc._x;
        m_settings.y = mc._y;
        GlobalEventDispatcher.dispatchEvent( { type: "save_widgets_settings" } );
    }

    private function onMouseMove()
    {
        if (m_settings.pinned == true)
            return;
        if (!mouseDown)
            return;
        if (mouseX == _root._xmouse && mouseY == _root._ymouse)
            return;

        //Logger.addObject("onMouseMove: " + _root._xmouse + ", " + _root._ymouse + "   "  + mouseX + ", " + mouseY);
        mc._x += _root._xmouse - mouseX;
        mc._y += _root._ymouse - mouseY;
        mouseX = _root._xmouse;
        mouseY = _root._ymouse;
    }
}
