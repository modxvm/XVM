/**
 * XVM Config - "rating" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CRating extends Object
    {
        public var showPlayersStatistics:Boolean;    // Global switch. Handles whole statisctics module.
        public var loadEnemyStatsInFogOfWar:Boolean; // Load players data in "fog of war".
        public var enableStatisticsLog:Boolean;      // Enable saving statistics to "xvm-stat.log" file
        public var enableUserInfoStatistics:Boolean; // Enable statistics in the user info window
        public var enableCompanyStatistics:Boolean;  // Enable statistics in the company window
    }
}
