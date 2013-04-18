import wot.utils.Config;

class wot.battle.FragCorrelation
{
    public static function modify():Void
    {
        fixFragCorellationBarOffset();
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
    
    private static function hideFragCorellationBarTeamTextFields():Void
    {
        _root.fragCorrelationBar.m_enemyTeamTF._alpha = 0;
        _root.fragCorrelationBar.m_alliedTeamTF._alpha = 0;
    }
}