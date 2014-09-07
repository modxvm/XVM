package net.wg.gui.interfaces
{
    public interface IRallyCandidateVO extends IExtendedUserVO
    {
        
        function get isCommander() : Boolean;
        
        function get userName() : String;
        
        function get clanAbbrev() : String;
        
        function set clanAbbrev(param1:String) : void;
        
        function get region() : String;
        
        function get igrType() : int;
        
        function get color() : Number;
        
        function get rating() : String;
        
        function get isOffline() : Boolean;
        
        function set isOffline(param1:Boolean) : void;
        
        function get isPlayerSpeaking() : Boolean;
        
        function set isPlayerSpeaking(param1:Boolean) : void;
    }
}
