package net.wg.gui.components.common.crosshair 
{
    import flash.display.*;
    
    public class CrosshairStrategic extends net.wg.gui.components.common.crosshair.CrosshairBase
    {
        public function CrosshairStrategic()
        {
            super();
            return;
        }

        protected override function initCallbacks():void
        {
            return;
        }

        protected override function onSetReloading(arg1:Number, arg2:Number, arg3:Boolean, arg4:Number=0):void
        {
            this.radiusNodesGotoAndStop(arg1 != 0 ? NODE_TYPE_RED : NODE_TYPE_GREEN);
            return;
        }

        protected override function onSetReloadingAsPercent(arg1:Number):void
        {
            this.radiusNodesGotoAndStop(arg1 < 100 ? NODE_TYPE_RED : NODE_TYPE_GREEN);
            return;
        }

        protected function onSetAsDebug():void
        {
            this.radiusNodesGotoAndStop(NODE_TYPE_DEBUG);
            return;
        }

        internal function radiusNodesGotoAndStop(arg1:String):void
        {
            var loc1:*=1;
            while (loc1 <= NODES_COUNT) 
            {
                (getChildByName(NODE_NAME_BASE + loc1) as flash.display.MovieClip).gotoAndStop(arg1);
                ++loc1;
            }
            return;
        }

        internal static const NODE_TYPE_RED:String="red";

        internal static const NODE_TYPE_GREEN:String="green";

        internal static const NODE_TYPE_DEBUG:String="debug";

        internal static const NODES_COUNT:uint=37;

        internal static const NODE_NAME_BASE:String="elem_";
    }
}
