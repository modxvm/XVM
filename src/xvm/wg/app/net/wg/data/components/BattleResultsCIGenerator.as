package net.wg.data.components 
{
    import __AS3__.vec.*;
    import net.wg.data.daapi.*;
    
    public class BattleResultsCIGenerator extends net.wg.data.components.ContextItemGenerator
    {
        public function BattleResultsCIGenerator(arg1:Boolean)
        {
            super();
            this._isOwnSquad = arg1;
            return;
        }

        public function get isOwnSquad():Boolean
        {
            return this._isOwnSquad;
        }

        public function set isOwnSquad(arg1:Boolean):void
        {
            this._isOwnSquad = arg1;
            return;
        }

        public override function generateData(arg1:net.wg.data.daapi.PlayerInfo, arg2:Number=NaN):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            var loc1:*=super.generateData(arg1);
            loc1.splice(1, 0, getDenunciationsSubmenu(arg2, arg1, this.isOwnSquad));
            return loc1;
        }

        internal var _isOwnSquad:Boolean;
    }
}
