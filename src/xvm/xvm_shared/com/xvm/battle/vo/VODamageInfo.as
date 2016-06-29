/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.vo
{
    import com.xvm.vo.*;

    public class VODamageInfo extends VOBase
    {
        // XVM
        public var damageDelta : Number = NaN;
        public var damageType : String = null;
        public var damageFlag : Number = NaN;
        public var isTeamKiller : Boolean = false;
        public var entityName : String = null;
        public var isDead : Boolean = false;
        public var isBlown : Boolean = false;
    }
}
