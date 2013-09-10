package net.wg.gui.components.icons 
{
    import scaleform.clik.core.*;
    
    public class PlayerActionMarker extends scaleform.clik.core.UIComponent
    {
        public function PlayerActionMarker()
        {
            super();
            return;
        }

        public function get action():Number
        {
            return this._actionBitMask;
        }

        public function set action(arg1:Number):void
        {
            if (this._actionBitMask == arg1) 
            {
                return;
            }
            this._actionBitMask = arg1;
            invalidate();
            return;
        }

        public function get team():String
        {
            return this._team;
        }

        public function set team(arg1:String):void
        {
            if (this._team == arg1) 
            {
                return;
            }
            this._team = arg1;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            var actions:Array;
            var allActions:Array;
            var elName:String;

            var loc1:*;
            allActions = null;
            elName = null;
            super.draw();
            actions = net.wg.gui.components.icons.PlayerActionMarkerController.instance.getActions(this._team, this._actionBitMask);
            if (actions.length) 
            {
                allActions = net.wg.gui.components.icons.PlayerActionMarkerController.instance.allActions;
                gotoAndStop("actions");
                var loc2:*=0;
                var loc3:*=allActions;
                for (elName in loc3) 
                {
                };
                loc2 = 0;
                loc3 = actions;
                for (elName in loc3) 
                {
                };
            }
            else 
            {
                gotoAndStop(1);
            }
            return;
        }

        internal var _actionBitMask:Number=0;

        internal var _team:String="common";
    }
}
