package net.wg.gui.prebattle.data 
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.prebattle.constants.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class PlayerPrbInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function PlayerPrbInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get chatRoster():Number
        {
            return this._chatRoster;
        }

        public function set chatRoster(arg1:Number):void
        {
            this._chatRoster = arg1;
            return;
        }

        public function get isPlayerSpeaking():Boolean
        {
            return this._isPlayerSpeaking;
        }

        public function set isPlayerSpeaking(arg1:Boolean):void
        {
            this._isPlayerSpeaking = arg1;
            return;
        }

        public function get colors():Array
        {
            return this._colors;
        }

        public function set time(arg1:Number):void
        {
            this._time = arg1;
            return;
        }

        public function set colors(arg1:Array):void
        {
            this._colors = arg1;
            return;
        }

        public function get dummy():Boolean
        {
            return this._dummy;
        }

        public function set dummy(arg1:Boolean):void
        {
            this._dummy = arg1;
            return;
        }

        public function get vType():String
        {
            return this._vType;
        }

        public function set vType(arg1:String):void
        {
            this._vType = arg1;
            return;
        }

        public function set orderNumber(arg1:Number):void
        {
            this._orderNumber = arg1;
            return;
        }

        public function get isCreator():Boolean
        {
            return this._isCreator;
        }

        public function set isCreator(arg1:Boolean):void
        {
            this._isCreator = arg1;
            return;
        }

        public function isOffline():Boolean
        {
            return !((this._state & net.wg.gui.prebattle.constants.PrebattleStateFlags.OFFLINE) == 0);
        }

        public function getStateString():String
        {
            var loc1:*=net.wg.gui.prebattle.constants.PrebattleStateString.UNKNOWN;
            if (this._state && !(this._state == net.wg.gui.prebattle.constants.PrebattleStateFlags.UNKNOWN)) 
            {
                if (this.isOffline()) 
                {
                    loc1 = (this._state & net.wg.gui.prebattle.constants.PrebattleStateFlags.NOT_READY) == 0 ? net.wg.gui.prebattle.constants.PrebattleStateString.OFFLINE_READY : net.wg.gui.prebattle.constants.PrebattleStateString.OFFLINE;
                }
                else if (this._state != net.wg.gui.prebattle.constants.PrebattleStateFlags.NOT_READY) 
                {
                    if (this._state != net.wg.gui.prebattle.constants.PrebattleStateFlags.AFK) 
                    {
                        if (this._state != net.wg.gui.prebattle.constants.PrebattleStateFlags.READY) 
                        {
                            if (this._state == net.wg.gui.prebattle.constants.PrebattleStateFlags.IN_BATTLE) 
                            {
                                loc1 = net.wg.gui.prebattle.constants.PrebattleStateString.IN_BATTLE;
                            }
                        }
                        else 
                        {
                            loc1 = net.wg.gui.prebattle.constants.PrebattleStateString.READY;
                        }
                    }
                    else 
                    {
                        loc1 = net.wg.gui.prebattle.constants.PrebattleStateString.AFK;
                    }
                }
                else 
                {
                    loc1 = net.wg.gui.prebattle.constants.PrebattleStateString.NOT_READY;
                }
            }
            return loc1;
        }

        public function getCurrentColor():Number
        {
            var loc1:*=null;
            if (this.isCreator && !this.himself) 
            {
                loc1 = App.colorSchemeMgr.getScheme(net.wg.data.constants.ColorSchemeNames.TEAM_COMMANDER);
                return loc1.rgb;
            }
            return this._colors ? this._colors[this.isOffline() ? 1 : 0] : NaN;
        }

        public function get accID():Number
        {
            return this._accID;
        }

        public function set accID(arg1:Number):void
        {
            this._accID = arg1;
            return;
        }

        public function get uid():Number
        {
            return this._uid;
        }

        public function set uid(arg1:Number):void
        {
            this._uid = arg1;
            return;
        }

        public function get userName():String
        {
            return this._userName;
        }

        public function set userName(arg1:String):void
        {
            this._userName = arg1;
            return;
        }

        public function get fullName():String
        {
            return this._fullName;
        }

        public function set fullName(arg1:String):void
        {
            this._fullName = arg1;
            return;
        }

        public function get time():Number
        {
            return this._time;
        }

        public function get orderNumber():Number
        {
            return this._orderNumber;
        }

        public function get himself():Boolean
        {
            return this._himself;
        }

        public function set himself(arg1:Boolean):void
        {
            this._himself = arg1;
            return;
        }

        public function get state():Number
        {
            return this._state;
        }

        public function set state(arg1:Number):void
        {
            this._state = arg1;
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get vShortName():String
        {
            return this._vShortName;
        }

        public function set vShortName(arg1:String):void
        {
            this._vShortName = arg1;
            return;
        }

        public function get vLevel():String
        {
            return this._vLevel;
        }

        public function set vLevel(arg1:String):void
        {
            this._vLevel = arg1;
            return;
        }

        internal var _accID:Number;

        internal var _uid:Number;

        internal var _userName:String="";

        internal var _fullName:String="";

        internal var _time:Number;

        internal var _state:Number;

        internal var _icon:String="";

        internal var _vShortName:String="";

        internal var _vLevel:String="";

        internal var _chatRoster:Number;

        internal var _isPlayerSpeaking:Boolean=false;

        internal var _colors:Array;

        internal var _dummy:Boolean=false;

        internal var _vType:String="";

        internal var _orderNumber:Number;

        internal var _isCreator:Boolean;

        internal var _himself:Boolean;
    }
}
