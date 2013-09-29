package net.wg.gui.lobby.customization.data 
{
    import net.wg.data.daapi.base.*;
    
    public class RentalPackageDAAPIDataProvider extends net.wg.data.daapi.base.DAAPIDataProvider
    {
        public function RentalPackageDAAPIDataProvider()
        {
            super();
            return;
        }

        public var getSelectedPackageIndex:Function;

        public var setSelectedPackageIndex:Function;
    }
}
