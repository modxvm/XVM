/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneMode implements ICloneable
    {
        public var enabled:*;
        public var expandAreaWidth:*;
        public var layout:String;
        public var fixedPosition:*;
        public var inviteIndicatorAlpha:*;
        public var inviteIndicatorX:*;
        public var inviteIndicatorY:*;
        public var extraFields:CPlayersPanelNoneModeExtraFields;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
