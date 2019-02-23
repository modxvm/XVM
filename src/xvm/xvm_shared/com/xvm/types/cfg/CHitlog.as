/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHitlog implements ICloneable
    {
        public var blowupMarker:String;
        public var deadMarker:String;
        public var defaultHeader:String;
        public var formatHeader:String;
        public var formatHistory:String;
        public var groupHitsByPlayer:*;
        public var insertOrder:String;

        public function clone():*
        {
            var result:CHitlog = new CHitlog();
            result.blowupMarker = blowupMarker;
            result.deadMarker = deadMarker;
            result.defaultHeader = defaultHeader;
            result.formatHeader = formatHeader;
            result.formatHistory = formatHistory;
            result.groupHitsByPlayer = groupHitsByPlayer;
            result.insertOrder = insertOrder;
            return result;
        }
    }
}
