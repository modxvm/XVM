import wot.TeamBasesPanel.CapConfig;
import wot.utils.Locale;

/**
 * Class prepares html formatted text.
 * Substitutes {{}} macroses with corresponding values.
 */

class wot.TeamBasesPanel.Macro
{
    private var m_primaryTitleFormat:String;
    private var m_secondaryTitleFormat:String;
    private var m_captureDoneFormat:String;
    private var m_extra:String;
    
    // updated
    private var m_timeLeftSec:String;
    private var m_timeLeftMinSec:String;
    private var m_capturersNum:String
    private var m_isSituationNormal:Boolean;
    private var m_points:String;
    
    private var m_capColor:String;
    
    public function Macro(startingPoints:Number, capColor:String)
    {
        /**
        * Should be defined early because
        * TeamBasesPanel inits panel with "add" function
        * and only after some time passed calls "updatePoints".
        * We already should be prepared to return text.
        */
        m_isSituationNormal = false;
        m_points = startingPoints.toString();
        m_capColor = capColor;
        
        m_primaryTitleFormat = Locale.get(CapConfig.primaryTitleFormat(m_capColor));
        m_secondaryTitleFormat = Locale.get(CapConfig.secondaryTitleFormat(m_capColor));
        m_captureDoneFormat = Locale.get(CapConfig.captureDoneFormat(m_capColor));
        m_extra = Locale.get(CapConfig.extra(m_capColor));
    }
    
    public function update(isSituationNormal:Boolean, timeLeftSec:Number, timeLeftMinSec:String, capturersNum:Number, points:Number):Void
    {
        this.m_isSituationNormal = isSituationNormal;
        this.m_timeLeftSec = timeLeftSec.toString();
        this.m_timeLeftMinSec = timeLeftMinSec;
        this.m_capturersNum = capturersNum.toString();
        this.m_points = points.toString();
    }
    
    public function getPrimaryText():String
    {
        return format(m_primaryTitleFormat);
    }
    
    public function getSecondaryText():String
    {
        return format(m_secondaryTitleFormat);
    }
    
    public function getCaptureDoneText():String
    {
        return format(m_captureDoneFormat);
    }
    
    // -- Private
    
    private function format(text:String):String
    {
       /**
        * Extra data is tanks capturing and time left.
        * Extra can not be defined at every possible tick in time. 
        * And only stable capturing process defines presentable extra data.
        * CaptureBar.isSituationNormal indicates normal values are being calculated.
        */
        if (m_isSituationNormal)
            text = stringReplace("{{extra}}", m_extra, text);
        else
            text = stringReplace("{{extra}}", "", text)
            
        text = stringReplace("{{tanks}}", m_capturersNum, text);
        text = stringReplace("{{time}}", m_timeLeftMinSec, text);
        text = stringReplace("{{time-sec}}", m_timeLeftSec, text);
        text = stringReplace("{{points}}", m_points, text);
        
        return text;
    }
    
    private function stringReplace(what:String, to:String, where:String):String
    {
        // as2 string replace hack
        var formatArr:Array;
        formatArr = where.split(what);
            if (formatArr.length > 1)
        where = formatArr.join(to);
        
        return where;
    }
}
