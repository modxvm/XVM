package net.wg.gui.interfaces
{
   public interface IRallyCandidateVO extends IExtendedUserVO
   {
      
      function get isCommander() : Boolean;
      
      function get userName() : String;
      
      function get clanAbbrev() : String;
      
      function get region() : String;
      
      function get igrType() : int;
      
      function get color() : Number;
      
      function get isPlayerSpeaking() : Boolean;
      
      function get rating() : String;
   }
}
