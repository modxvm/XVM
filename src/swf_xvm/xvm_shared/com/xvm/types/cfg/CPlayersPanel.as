/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanel implements ICloneable
    {
        public var alpha:*;
        public var altMode:String;
        public var enabled:*;
        public var iconAlpha:*;
        public var large:CPlayersPanelMode;
        public var medium:CPlayersPanelMode;
        public var medium2:CPlayersPanelMode;
        public var none:CPlayersPanelNoneMode;
        public var removePanelsModeSwitcher:*;
        public var removeSelectedBackground:*;
        public var short:CPlayersPanelMode;
        public var startMode:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
