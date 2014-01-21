/**
 * XVM Config - "statisticForm" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CStatisticForm extends Object
    {
        public var showChances:Boolean;     // Show game round win chances percentage.
        public var showChancesLive:Boolean; // Show "chance to win" only for live tanks.
        public var removeSquadIcon:Boolean; // Hide squad icon.
        public var clanIcon:CClanIcon;      // Playes/clan icon parameters.
        // Dispay formats.
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
    }
}
