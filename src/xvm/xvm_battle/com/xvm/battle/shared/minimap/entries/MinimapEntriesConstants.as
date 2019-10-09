/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries
{
    public class MinimapEntriesConstants
    {
        public static const OFFMAP_COORDINATE:int = 500;

        // Moving state
        public static const MOVING_STATE_STOPPED:int = 0x01;
        public static const MOVING_STATE_MOVING:int  = 0x02;
        public static const MOVING_STATE_ALL:int     = MOVING_STATE_STOPPED | MOVING_STATE_MOVING;
    }
}
