import wot.TeamBasesPanel.CapConfig;
import wot.utils.Logger;

/**
 * Substitutes macroses like {{points}} with corresponding values
 */

class wot.TeamBasesPanel.Macro
{
    private static var WRONG_TAG_POSITIONING:String =
    "{{tanks}} and {{time}} can only be placed in ExtraFormat config field!";
    
    private var m_primaryTitleFormat:String;
    private var m_secondaryTitleFormat:String;
    private var m_captureDoneFormat:String;
    private var m_extra:String;
    
    // updated
    private var m_capTimeLeft:String;
    private var m_capturersNum:String
    private var m_isExtraDefined:Boolean;
    private var m_points:String;
    
    public function Macro(startingPoints:Number)
    {
        m_primaryTitleFormat = CapConfig.primaryTitleFormat;
        m_secondaryTitleFormat = CapConfig.secondaryTitleFormat;
        m_captureDoneFormat = CapConfig.captureDoneFormat;
        m_extra = CapConfig.extra;
        
       /**
        * Should be defined early because
        * TeamBasesPanel inits panel with "add" function
        * and only then calls "updatePoints".
        * We should be prepared.
        */
        this.m_isExtraDefined = false;
        this.m_points = startingPoints.toString();
    }
    
    public function update(isExtraDefined:Boolean, capTimeLeft:String, capturersNum:Number, points:Number):Void
    {
        this.m_isExtraDefined = isExtraDefined;
        this.m_capTimeLeft = capTimeLeft;
        this.m_capturersNum = capturersNum.toString();
        this.m_points = points.toString();
    }
    
    public function getPrimaryText():String
    {
        return format(m_primaryTitleFormat);
    }
    
    public function getSecondaryText():String
    {
        var s = format(m_secondaryTitleFormat);
        Logger.add("Macro: getSecondaryText = " + s);
        return s;
    }
    
    public function getCaptureDoneText():String
    {
        return format(m_captureDoneFormat);
    }
    
    // -- Private
    
    private function format(text:String):String
    {
        /**
         * {{tanks}} and {{time}} can only be placed in ExtraFormat.
         * Ignoring this causes extreme values being returned.
         * isExtraDefined var indicates normal values are being calculated.
         */
        if extraIntegrityBroken(text)
            return WRONG_TAG_POSITIONING;
        
        /**
         * Extra data is tanks capturing and time left
         * Extra can not be defined at every possible tick in time. 
         * Only stable capturing process defines extra.
         */
        if (m_isExtraDefined)
            text = stringReplace("{{extra}}", m_extra, text);
        else
            text = stringReplace("{{extra}}", "", text)
            
        text = stringReplace("{{tanks}}", m_capturersNum, text);
        text = stringReplace("{{time}}", m_capTimeLeft, text);
        text = stringReplace("{{points}}", m_points, text);
        
        return text;
    }
    
    private function extraIntegrityBroken(text:String):Boolean
    {
        if (text.indexOf("{{tanks}}") == -1 && text.indexOf("{{time}}") == -1 )
            return false;
        return true;
    }
    
    private function stringReplace(what:String, to:String, where:String):String
    {
        var formatArr:Array;
        formatArr = where.split(what); // what to search
            if (formatArr.length > 1)
        where = formatArr.join(to);
        
        return where;
    }
}
