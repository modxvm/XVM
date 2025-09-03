/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTexts implements ICloneable
    {
        public var battletype:CTextsBattleType;
        public var marksOnGun:CTextsMarksOnGun;
        public var spotted:CTextsSpotted;
        public var topclan:CTextsTopClan;
        public var vtype:CTextsVType;
        public var xvmuser:CTextsXvmUser;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
