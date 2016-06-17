/**
 * XVM - battle
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class BattleXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BATTLE]";
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            //Logger.addObject(stage);
            //Logger.addObject(root);
        }
    }
}
