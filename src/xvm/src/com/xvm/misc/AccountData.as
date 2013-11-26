/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import com.xvm.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public class AccountData
    {
        public static var dossier:AccountDossier = null;
        public static var vehicles:Object = null;

        public static function init():void
        {
            if (dossier != null)
                return;

            try
            {
                dossier = new AccountDossier(null);
                vehicles = {};
                for each (var data:TechniqueListVehicleVO in dossier.getAllVehiclesList())
                    vehicles[data.id] = data;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
