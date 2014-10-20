/**
 * XVM Config - "battleLoading" section
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public dynamic class CBattleLoading extends Object
    {
        // Show clock at Battle Loading Screen.
        // ### Is there a clock:on\off switch variable supposed to be? ###
        // A: No, it is possible to set clockFormat: "" to disable clock.

        public var clockFormat:String;      // Format: http://php.net/date

        public var showBattleTier:Boolean;  // Show battle tier.
        public var removeSquadIcon:Boolean; // Hide squad icon.
        public var clanIcon:CClanIcon;      // Playes/clan icon parameters.
        // Dispay formats.
        public var darkenNotReadyIcon:Boolean;      // False - disable highlight of icons during battle start depends on ready state.
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
    }
}
