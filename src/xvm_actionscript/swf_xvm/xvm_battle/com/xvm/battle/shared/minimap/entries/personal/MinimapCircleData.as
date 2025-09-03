package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xvm.types.cfg.*;
    import com.xvm.battle.shared.minimap.entries.*;
    import flash.display.*;

    internal class MinimapCircleData
    {
        public var cfg:CMinimapCircle;
        public var radius:Number;
        public var shape:Shape;
        public var state:int;

        public function MinimapCircleData(cfg:CMinimapCircle):void
        {
            this.cfg = cfg;
            this.state = MinimapEntriesConstants.MOVING_STATE_ALL;
        }
    }
}