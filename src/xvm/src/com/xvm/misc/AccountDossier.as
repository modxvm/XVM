/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.external.*;
    import flash.net.Responder;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public class AccountDossier
    {
        //public static var dossier:Dossier = null;
        //public static var vehicles:Object = null;

        private static var _initialized:Boolean = false;

        public static function init():void
        {
            if (_initialized)
                return;

            _initialized = true;

            ExternalInterface.addCallback(Cmd.RESPOND_DOSSIER, dataLoaded);

            //if (dossier != null)
                //return;
//
            //try
            //{
                //dossier = new Dossier();
                //vehicles = {};
                //for each (var data:TechniqueListVehicleVO in dossier.getAllVehiclesList())
                //    vehicles[data.id] = data;
            //}
            //catch (ex:Error)
            //{
                //Logger.add(ex.getStackTrace());
            //}
        }

        public static function getDossier(target:Object, callback:Function, playerId:* = null):void
        {
            init();
            Cmd.getDossier(playerId);
        }

        private static function dataLoaded(str:String):void
        {
            Logger.add("dataLoaded: " + str);
        }
    }
}

class Dossier
{

}

