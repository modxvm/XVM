/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xvm.vo.*;

    public class VOMarkerState extends VOBase
    {
        public var criticalHitLabelText:String = null;
        public var hitExplosionAnimationType:String = null;

        public function VOMarkerState(data:Object = null)
        {
            super(data);
        }
    }
}
