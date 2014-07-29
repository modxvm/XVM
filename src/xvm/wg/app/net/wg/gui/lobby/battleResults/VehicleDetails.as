package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.utils.IUtils;
    import net.wg.utils.ICommons;
    import net.wg.utils.IClassFactory;
    
    public class VehicleDetails extends UIComponent
    {
        
        public function VehicleDetails()
        {
            super();
        }
        
        public static var STATE_NORMAL:String = "normal";
        
        public static var STATE_TIME:String = "time";
        
        public static var STATE_WIDE:String = "wide";
        
        private static var STATS_LINE:String = "statsLine";
        
        private static var STATS_LINE_WIDE:String = "statsLineWide";
        
        public var statsLbl:TextField;
        
        public var statsValuesLbl:TextField;
        
        private var linesContainer:MovieClip;
        
        private var lineType:String = "statsLine";
        
        override protected function configUI() : void
        {
            super.configUI();
            this.clearLines();
            this.statsLbl.mouseWheelEnabled = false;
            this.statsValuesLbl.mouseWheelEnabled = false;
        }
        
        private var _data:Array;
        
        private var _dataDirty:Boolean = false;
        
        public function get data() : Array
        {
            return this._data;
        }
        
        public function set data(param1:Array) : void
        {
            this._data = param1;
            this._dataDirty = true;
            this.invalidateFast();
        }
        
        private var _state:String = "normal";
        
        private var _stateDirty:Boolean = false;
        
        public function get state() : String
        {
            return this._state;
        }
        
        public function set state(param1:String) : void
        {
            this._state = param1;
            this._stateDirty = true;
            invalidate();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(this._stateDirty)
            {
                if(this.state == STATE_WIDE)
                {
                    this.statsLbl.width = 280;
                    this.statsValuesLbl.x = 286;
                    this.statsValuesLbl.y = 0;
                    this.statsValuesLbl.width = 150;
                    this.lineType = STATS_LINE_WIDE;
                    width = 436;
                }
                else if(this.state == STATE_TIME)
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
                    this.statsValuesLbl.x = 282;
                    this.statsValuesLbl.y = 2;
                    this.statsValuesLbl.width = 80;
                    this.lineType = STATS_LINE;
                    width = 362;
                }
                
                initSize();
                this._stateDirty = false;
            }
            if(this._dataDirty)
            {
                this.populateStats(this.data);
                this._dataDirty = false;
            }
        }
        
        private function populateStats(param1:Array) : void
        {
            var _loc4_:Object = null;
            var _loc5_:MovieClip = null;
            this.statsLbl.htmlText = "";
            this.statsValuesLbl.htmlText = "";
            this.clearLines();
            var _loc2_:Number = 0;
            var _loc3_:Number = param1.length;
            var _loc6_:IUtils = App.utils;
            var _loc7_:ICommons = _loc6_.commons;
            var _loc8_:IClassFactory = _loc6_.classFactory;
            while(_loc2_ < _loc3_)
            {
                _loc4_ = param1[_loc2_];
                _loc7_.addBlankLines(_loc4_.label,this.statsLbl,Vector.<TextField>([this.statsValuesLbl]));
                this.statsLbl.htmlText = this.statsLbl.htmlText + _loc4_.label;
                this.statsValuesLbl.htmlText = this.statsValuesLbl.htmlText + _loc4_.value;
                if(Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + 3 < this.statsLbl.height)
                {
                    _loc5_ = _loc8_.getComponent(this.lineType,MovieClip,{"x":this.statsLbl.x + 3,
                    "y":Math.floor(this.statsLbl.y + this.statsLbl.textHeight) + 3
                });
                this.linesContainer.addChild(_loc5_);
            }
            _loc2_++;
        }
        height = Math.max(this.statsLbl.textHeight,this.statsValuesLbl.textHeight) + 6;
    }
    
    private function clearLines() : void
    {
        if(this.linesContainer)
        {
            removeChild(this.linesContainer);
        }
        this.linesContainer = new MovieClip();
        addChild(this.linesContainer);
    }
    
    private function invalidateFast() : void
    {
        if(initialized)
        {
            validateNow();
        }
        else
        {
            invalidate();
        }
    }
}
}
