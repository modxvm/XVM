/**
 * @author ilitvinov
 */

import wot.utils.Utils;

/**
 * Creates and manages capture bar mc library instances.
 * See CaptureBar class for implemented extra feature list.
 */

class wot.TeamBasesPanel.TeamBasesPanel extends net.wargaming.ingame.TeamBasesPanel
{
    var m_textFormat:TextFormat;
    var m_filters:Array;
    
    public function TeamBasesPanel() 
    {
        Utils.TraceXvmModule("TeamBasesPanel");
        super();
        defineStyle();
    }
    
    function add(id, sortWeight, colorFeature, title, points)
    {
        super.add(id, sortWeight, colorFeature, title, points);
        
        captureBars[indexByID[id]].init();
        captureBars[indexByID[id]].setStyle(m_textFormat, m_filters);
    }
    
   /**
    * Define capture bar style here.
    */
    private function defineStyle():Void
    {
        m_textFormat = _root.debugPanel.fgMC.fps.getNewTextFormat();
        m_textFormat.align = "center";
        m_textFormat.color = 0xF0F0F0;
        m_filters = [new flash.filters.DropShadowFilter(0, 0, 0x000000, 100, 2, 2, 1.5, 3)];
    }
}