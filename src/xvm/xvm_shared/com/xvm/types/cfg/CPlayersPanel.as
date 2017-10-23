/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanel implements ICloneable
    {
        public var enabled:*;
        public var alpha:*;
        public var iconAlpha:*;
        public var removeSelectedBackground:*;
        public var removePanelsModeSwitcher:*;
        public var startMode:String;
        public var altMode:String;
        public var clanIcon:CClanIcon;
        public var none:CPlayersPanelNoneMode;
        public var short:CPlayersPanelMode;
        public var medium:CPlayersPanelMode;
        public var medium2:CPlayersPanelMode;
        public var large:CPlayersPanelMode;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
