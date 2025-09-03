/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneMode implements ICloneable
    {
        public var enabled:*;
        public var expandAreaWidth:*;
        public var extraFields:CPlayersPanelNoneModeExtraFields;
        public var fixedPosition:*;
        public var inviteIndicatorAlpha:*;
        public var inviteIndicatorX:*;
        public var inviteIndicatorY:*;
        public var layout:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
