package net.wg.gui.cyberSport.data
{
   import net.wg.data.VoDAAPIDataProvider;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;


   public class CandidatesDataProvider extends VoDAAPIDataProvider
   {
          
      public function CandidatesDataProvider() {
         super(UnitCandidateVO);
      }
   }

}