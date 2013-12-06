package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;


   public class CyberSportUnitsListMeta extends CyberSportBaseViewMeta
   {
          
      public function CyberSportUnitsListMeta() {
         super();
      }

      public var getTeamData:Function = null;

      public var refreshTeams:Function = null;

      public var filterVehicles:Function = null;

      public var loadPrevious:Function = null;

      public var loadNext:Function = null;

      public function getTeamDataS(param1:int) : Object {
         App.utils.asserter.assertNotNull(this.getTeamData,"getTeamData" + Errors.CANT_NULL);
         return this.getTeamData(param1);
      }

      public function refreshTeamsS() : void {
         App.utils.asserter.assertNotNull(this.refreshTeams,"refreshTeams" + Errors.CANT_NULL);
         this.refreshTeams();
      }

      public function filterVehiclesS() : void {
         App.utils.asserter.assertNotNull(this.filterVehicles,"filterVehicles" + Errors.CANT_NULL);
         this.filterVehicles();
      }

      public function loadPreviousS() : void {
         App.utils.asserter.assertNotNull(this.loadPrevious,"loadPrevious" + Errors.CANT_NULL);
         this.loadPrevious();
      }

      public function loadNextS() : void {
         App.utils.asserter.assertNotNull(this.loadNext,"loadNext" + Errors.CANT_NULL);
         this.loadNext();
      }
   }

}