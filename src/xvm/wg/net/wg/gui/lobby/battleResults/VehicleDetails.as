package net.wg.gui.lobby.battleResults 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class VehicleDetails extends scaleform.clik.core.UIComponent
    {
        public function VehicleDetails()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.clearLines();
            this.statsLbl.mouseWheelEnabled = false;
            this.statsValuesLbl.mouseWheelEnabled = false;
            return;
        }

        public function get data():Array
        {
            return this._data;
        }

        public function set data(arg1:Array):void
        {
            this._data = arg1;
            this._dataDirty = true;
            this.invalidateFast();
            return;
        }

        public function get state():String
        {
            return this._state;
        }

        public function set state(arg1:String):void
        {
            this._state = arg1;
            this._stateDirty = true;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this._stateDirty) 
            {
                if (this.state != STATE_WIDE) 
                    if (this.state != STATE_TIME) 
                    {
                        this.statsLbl.width = 280;
                        this.statsValuesLbl.x = 282;
                        this.statsValuesLbl.y = 2;
                        this.statsValuesLbl.width = 80;
                        this.lineType = STATS_LINE;
                        width = 362;
                    }
                    else 
                    {
                        this.statsLbl.width = 254;
                        this.statsValuesLbl.x = 262;
                        this.statsValuesLbl.y = 2;
                        this.statsValuesLbl.width = 100;
                        this.lineType = STATS_LINE;
                        width = 362;
                    }
                else 
                {
                    this.statsLbl.width = 280;
                    this.statsValuesLbl.x = 286;
                    this.statsValuesLbl.y = 0;
                    this.statsValuesLbl.width = 150;
                    this.lineType = STATS_LINE_WIDE;
                    width = 436;
                }
                initSize();
                this._stateDirty = false;
            }
            if (this._dataDirty) 
            {
                this.populateStats(this.data);
                this._dataDirty = false;
            }
            return;
        }

        internal function populateStats(arg1:Array):void
        {
            var loc3:*=null;
            var loc4:*=null;
            this.statsLbl.htmlText = "";
            this.statsValuesLbl.htmlText = "";
            this.clearLines();
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc5:*;
            var loc6:*=(loc5 = App.utils).commons;
            var loc7:*=loc5.classFactory;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                loc6.addBlankLines(loc3.label, this.statsLbl, Vector.<flash.text.TextField>([this.statsValuesLbl]));
                this.statsLbl.htmlText = this.statsLbl.htmlText + loc3.label;
                this.statsValuesLbl.htmlText = this.statsValuesLbl.htmlText + loc3.value;
                if (Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + 3 < this.statsLbl.height) 
                {
                    loc4 = loc7.getComponent(this.lineType, flash.display.MovieClip, {"x":this.statsLbl.x + 3, "y":Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + 3});
                    this.linesContainer.addChild(loc4);
                }
                ++loc1;
            }
            this.statsLbl.height = this.height + 15;
            this.statsValuesLbl.height = this.height + 15;
            return;
        }

        internal function clearLines():void
        {
            if (this.linesContainer) 
                removeChild(this.linesContainer);
            this.linesContainer = new flash.display.MovieClip();
            addChild(this.linesContainer);
            return;
        }

        internal function invalidateFast():void
        {
            if (initialized) 
                validateNow();
            else 
                invalidate();
            return;
        }

        public static const STATE_NORMAL:String="normal";

        public static const STATE_TIME:String="time";

        public static const STATE_WIDE:String="wide";

        internal static const STATS_LINE:String="statsLine";

        internal static const STATS_LINE_WIDE:String="statsLineWide";

        public var statsLbl:flash.text.TextField;

        public var statsValuesLbl:flash.text.TextField;

        internal var linesContainer:flash.display.MovieClip;

        internal var lineType:String="statsLine";

        internal var _data:Array;

        internal var _dataDirty:Boolean=false;

        internal var _state:String="normal";

        internal var _stateDirty:Boolean=false;
    }
}
