package net.wg.gui.lobby.customization.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;


   public class RentalPackageDAAPIDataProvider extends DAAPIDataProvider
   {
          
      public function RentalPackageDAAPIDataProvider() {
         super();
      }

      public var getSelectedPackageIndex:Function;

      public var setSelectedPackageIndex:Function;
   }

}