/**
 * Base Widget View
 * @author Maxim Schedriviy <max(at)modxvm.com>
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
import com.xvm.Components.Widgets.WidgetsEventTypes;

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
        //Logger.addObject(settings);
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

        Mouse.addListener(this); // catch Mouse.RIGHT

        var bgAlpha = settings.bgAlpha != null ? settings.bgAlpha : defaults.bgAlpha != null ? defaults.bgAlpha : 60;
        _panel = Panel.Create(mc, "panel", 0, 0, settings.width || defaults.width || 0, settings.height || defaults.height || 0, {
            color: settings.bgColor != null ? settings.bgColor : defaults.bgColor != null ? defaults.bgColor : 0x000000,
            alpha: bgAlpha,
            borderSize: 1,
            borderColor: 0xCCCCCC,
            borderAlpha: bgAlpha
        });
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
        //Logger.add("onPress: " + com.xvm.JSONx.stringify(arguments));
        if (m_settings.pinned == true)
            return;
        mouseDown = true;
        mouseX = _root._xmouse;
        mouseY = _root._ymouse;
    }

    private function onRelease(mouseIndex, button)
    {
        //Logger.add("onRelease: " + com.xvm.JSONx.stringify(arguments));
        if (m_settings.pinned == true)
            return;
        mouseDown = false;
        m_settings.x = mc._x;
        m_settings.y = mc._y;
        GlobalEventDispatcher.dispatchEvent( { type: WidgetsEventTypes.SAVE_WIDGETS_SETTINGS } );
    }

    private function onMouseMove()
    {
        if (m_settings.pinned == true)
            return;
        if (!mouseDown)
            return;
        if (mouseX == _root._xmouse && mouseY == _root._ymouse)
            return;

        //Logger.add("onMouseMove: " + _root._xmouse + ", " + _root._ymouse + "   "  + mouseX + ", " + mouseY);
        mc._x += _root._xmouse - mouseX;
        mc._y += _root._ymouse - mouseY;
        mouseX = _root._xmouse;
        mouseY = _root._ymouse;
    }

    private function onMouseDown(button, target)
    {
        //Logger.add("onMouseDown: " + com.xvm.JSONx.stringify(arguments));
        
        if (!mc.hitTest(_root._xmouse, _root._ymouse, true))
            return;
        
        if (button == Mouse.RIGHT)
        {
            var menu = net.wargaming.managers.ContextMenuManager.instance.show([
                [{id: "pin", label: m_settings.pinned ?  Locale.get("Unpin") : Locale.get("Pin") }]//,
                //[net.wargaming.controls.ContextMenu.SEPARATE],
                ], false);
            menu.addEventListener("action", this, "onMenuSelect");
        }
    }

    private function onMenuSelect(event)
    {
        //Logger.addObject(event, "onMenuSelect");
        switch (event.id)
        {
            case "pin":
                m_settings.pinned = !m_settings.pinned;
                GlobalEventDispatcher.dispatchEvent( { type: WidgetsEventTypes.SAVE_WIDGETS_SETTINGS } );
                break;
        }
    }
}
