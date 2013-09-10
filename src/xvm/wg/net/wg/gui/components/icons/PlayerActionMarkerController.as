package net.wg.gui.components.icons
{
    public class PlayerActionMarkerController extends Object
    {
        public function PlayerActionMarkerController()
        {
            super();
            //if (__allowInstantiation) ;
            return;
        }

        public function init():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.__ACTIONS = new Object();
            this.__ACTIONS["common"] = new Object();
            this.__ACTIONS["myteam"] = new Object();
            this.__ACTIONS["enemy"] = new Object();
            this.__ACTIONS["enemy"]["hunting"] = 1;
            this.__allActions = new Array();
            var loc3:*=0;
            var loc4:*=this.__ACTIONS;
            for (loc1 in loc4)
            {
                var loc5:*=0;
                var loc6:*=this.__ACTIONS[loc1];
                for (loc2 in loc6)
                    this.__allActions.push(loc2);
            }
            return;
        }

        public function get allActions():Array
        {
            return this.__allActions;
        }

        public function getActions(arg1:String, arg2:Number):Array
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=new Array();
            var loc4:*=0;
            var loc5:*=this.__ACTIONS[arg1];
            for (loc2 in loc5)
            {
                if (!((loc3 = this.__ACTIONS[arg1][loc2]) & arg2))
                    continue;
                loc1.push(loc2);
            }
            return loc1;
        }

        public static function get instance():net.wg.gui.components.icons.PlayerActionMarkerController
        {
            if (!__instance)
            {
                __allowInstantiation = true;
                __instance = new PlayerActionMarkerController();
                __allowInstantiation = false;
                __instance.init();
            }
            return __instance;
        }


        {
            __allowInstantiation = false;
        }

        internal var __ACTIONS:Object;

        internal var __allActions:Array;

        internal static var __instance:net.wg.gui.components.icons.PlayerActionMarkerController;

        internal static var __allowInstantiation:Boolean=false;
    }
}
