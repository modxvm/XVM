import wot.utils.Config;
import wot.utils.Utils;

class wot.battle.FragCorrelation
{
    public static function modify():Void
    {
        fixFragCorellationBarOffset();
        disableSelection();
        if (Config.s_config.fragCorrelation.hideTeamTextFields == true)
        {
            hideFragCorellationBarTeamTextFields();
        }
    }
    
    /**
     * Quick dirty partial fix of alive markers bad positioning at FragCorrelationBar.
     * Positioning is broken because of VehicleMarkersManager.xml.patch
     */
    private static function fixFragCorellationBarOffset():Void
    {
        _root.fragCorrelationBar.enemyMarkers.drawRenderers = 
        _root.fragCorrelationBar.alliedMarkers.drawRenderers = 
        function(resetPrevData)
        {
            /** Original WG code */
            for (var i = 0; i < this.__get__dataProvider().length; ++i)
            {
                this.createItemRenderer(this.__get__dataProvider()[i], resetPrevData);
            }
            
            /** Extra XVM code */
            for (var vid in this.vIdToRenderer)
            {
                var renderer = this.vIdToRenderer[vid];
                if (renderer._data.isAlive)
                {
                    renderer._y = 16;
                    //renderer._x += 6;
                }
            }
        }
    }
    
    /** Disable caret cursor change while mouse cursor is hovering over frag clips */
    /**
     * Does not work :(
     */
    private static function disableSelection():Void
    {
        var clipsToDisableSelect:Array = Utils.getChildrenOf(_root.fragCorrelationBar);
        clipsToDisableSelect.push(_root.fragCorrelationBar);
        for (var i in clipsToDisableSelect)
        {
            clipsToDisableSelect[i].selectable = false;
        }
    }
    
    private static function hideFragCorellationBarTeamTextFields():Void
    {
        /** Everything outside of this rectangular mask will be invisible */
        _root.fragCorrelationBar.scrollRect = new flash.geom.Rectangle
        (0, 0, _root.fragCorrelationBar._width, _root.fragCorrelationBar._height / 2);
    }
}
