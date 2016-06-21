package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;

    public class BattleGlobalData
    {
        public static function get curentXtdb():Number
        {
            return instance.getCurentXtdb();
        }

        // instance
        private static var _instance:BattleGlobalData = null;
        public static function get instance():BattleGlobalData
        {
            if (_instance == null)
            {
                _instance = new BattleGlobalData();
            }
            return _instance;
        }

        private var _xtdb_data:Array;

        // .ctor should be private for Singleton
        function BattleGlobalData()
        {
            _xtdb_data = Xfw.cmd(XvmCommands.GET_XTDB_DATA);
        }

        private var _curent_xtdb:Number = 0;
        private function getCurentXtdb():Number
        {
                var xtdb_data_len:Number = _xtdb_data.length;
                while (_curent_xtdb < xtdb_data_len - 1)
                {
                    if (BattleState.playersDataVO.hitlogTotalDamage < _xtdb_data[_curent_xtdb])
                        break;
                    ++_curent_xtdb;
                }
                return _curent_xtdb;
        }
    }
}
