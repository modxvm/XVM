import com.xvm.Config;
import com.xvm.Utils;

class wot.battle.FragCorrelation
{
    public static function modify():Void
    {
        disableSelection();
        if (Config.s_config.fragCorrelation.hideTeamTextFields == true)
            hideFragCorellationBarTeamTextFields();
    }

    /** Disable caret cursor change while mouse cursor is hovering over frag clips */
    private static function disableSelection():Void
    {
        var clipsToDisableSelect:Array = [
            _root.fragCorrelationBar.indicator,
            _root.fragCorrelationBar.m_enemyTeamFragsTF,
            _root.fragCorrelationBar.m_alliedTeamFragsTF,
            _root.fragCorrelationBar.m_enemyTeamTF,
            _root.fragCorrelationBar.m_alliedTeamTF
        ];

        for (var i in clipsToDisableSelect)
            clipsToDisableSelect[i].selectable = false;
    }

    private static function hideFragCorellationBarTeamTextFields():Void
    {
        /** Everything outside of this rectangular mask will be invisible */
        _root.fragCorrelationBar.scrollRect =
            new flash.geom.Rectangle(0, 0, _root.fragCorrelationBar._width, _root.fragCorrelationBar._height / 2);
    }
}
