/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;

class wot.battle.Clock
{
    public function Clock()
    {
        var format:String = Config.config.battle.clockFormat;

        var debugPanel:MovieClip = _root.debugPanel;
        var lag:MovieClip = debugPanel.lag;
        var fps:MovieClip = debugPanel.fps;
        var clock: TextField = debugPanel.createTextField("clock", debugPanel.getNextHighestDepth(),
            lag._x + lag._width, fps._y, 300, fps._height);
        clock.selectable = false;
        clock.antiAliasType = "advanced";
        clock.html = true;
        var tf: TextFormat = fps.getNewTextFormat();
        clock.styleSheet = Utils.createStyleSheet(Utils.createCSS("xvm_clock",
            tf.color, tf.font, tf.size, "left", tf.bold, tf.italic));
        clock.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5)];

        _global.setInterval(function() {
            clock.htmlText = Utils.fixImgTag("<span class='xvm_clock'>" + Strings.FormatDate(format, new Date()) + "</span>");
        }, 1000);
    }
}
