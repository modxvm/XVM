/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xvm.vo.*;

    public class VODamageInfo extends VOBase
    {
        public var damageDelta : Number = NaN;
        public var damageType : String = null;
        public var damageFlag : Number = NaN;
        public var attackerID : Number = NaN;

        public function VODamageInfo(data:Object = null)
        {
            super(data);
        }
    }
}
