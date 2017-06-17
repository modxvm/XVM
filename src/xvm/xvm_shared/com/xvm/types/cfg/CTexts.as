/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTexts implements ICloneable
    {
        public var vtype:CTextsVType;
        public var marksOnGun:CTextsMarksOnGun;
        public var spotted:CTextsSpotted;
        public var xvmuser:CTextsXvmUser;
        public var battletype:CTextsBattleType;
        public var topclan:CTextsTopClan;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
