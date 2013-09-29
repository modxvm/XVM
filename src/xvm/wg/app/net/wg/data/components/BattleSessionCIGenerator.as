package net.wg.data.components
{
    import __AS3__.vec.*;
    import net.wg.data.daapi.*;
    import org.idmedia.as3commons.util.*;
    import net.wg.infrastructure.interfaces.IContextItem;

    public class BattleSessionCIGenerator extends net.wg.data.components.ContextItemGenerator
    {
        public function BattleSessionCIGenerator(arg1:Boolean, arg2:Boolean)
        {
            super();
            this._isOnline = arg1;
            this._canKickPlayer = arg2;
            return;
        }

        public override function generateData(arg1:net.wg.data.daapi.PlayerInfo, arg2:Number=NaN):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            var loc1:*=super.generateData(arg1);
            loc1.splice(1, 0, getDenunciationsSubmenu(arg2, arg1));
            return loc1;
        }

        protected override function createSimpleDataIDs(arg1:String, arg2:String, arg3:String, arg4:String):org.idmedia.as3commons.util.Map
        {
            return App.utils.commons.createMap(["userInfo", {}, arg1, {"enabled":this._isOnline}, arg2, {"enabled":this._isOnline}, arg3, {"enabled":this._isOnline}, "copyToClipBoard", {}, arg4, {"enabled":this._isOnline}, "kickPlayer", {"enabled":this._canKickPlayer}]);
        }

        internal var _isOnline:Boolean=false;

        internal var _canKickPlayer:Boolean=false;
    }
}
