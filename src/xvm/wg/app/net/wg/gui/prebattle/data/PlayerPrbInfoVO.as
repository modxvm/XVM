package net.wg.gui.prebattle.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.prebattle.constants.PrebattleStateFlags;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.data.constants.ColorSchemeNames;


   public class PlayerPrbInfoVO extends DAAPIDataClass
   {
          
      public function PlayerPrbInfoVO(param1:Object) {
         super(param1);
      }

      public var igrType:int = 0;

      public var clanAbbrev:String = "";

      public var region:String = "";

      private var _accID:Number;

      private var _uid:Number;

      private var _userName:String = "";

      private var _fullName:String = "";

      private var _time:Number;

      private var _himself:Boolean;

      private var _state:Number;

      private var _icon:String = "";

      private var _vShortName:String = "";

      private var _vLevel:String = "";

      private var _chatRoster:Number;

      private var _isPlayerSpeaking:Boolean = false;

      private var _colors:Array;

      private var _dummy:Boolean = false;

      private var _vType:String = "";

      private var _orderNumber:Number;

      private var _isCreator:Boolean;

      public function get accID() : Number {
         return this._accID;
      }

      public function set accID(param1:Number) : void {
         this._accID = param1;
      }

      public function get uid() : Number {
         return this._uid;
      }

      public function set uid(param1:Number) : void {
         this._uid = param1;
      }

      public function get userName() : String {
         return this._userName;
      }

      public function set userName(param1:String) : void {
         this._userName = param1;
      }

      public function get fullName() : String {
         return this._fullName;
      }

      public function set fullName(param1:String) : void {
         this._fullName = param1;
      }

      public function get time() : Number {
         return this._time;
      }

      public function set time(param1:Number) : void {
         this._time = param1;
      }

      public function get himself() : Boolean {
         return this._himself;
      }

      public function set himself(param1:Boolean) : void {
         this._himself = param1;
      }

      public function get state() : Number {
         return this._state;
      }

      public function set state(param1:Number) : void {
         this._state = param1;
      }

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
      }

      public function get vShortName() : String {
         return this._vShortName;
      }

      public function set vShortName(param1:String) : void {
         this._vShortName = param1;
      }

      public function get vLevel() : String {
         return this._vLevel;
      }

      public function set vLevel(param1:String) : void {
         this._vLevel = param1;
      }

      public function get chatRoster() : Number {
         return this._chatRoster;
      }

      public function set chatRoster(param1:Number) : void {
         this._chatRoster = param1;
      }

      public function get isPlayerSpeaking() : Boolean {
         return this._isPlayerSpeaking;
      }

      public function set isPlayerSpeaking(param1:Boolean) : void {
         this._isPlayerSpeaking = param1;
      }

      public function get colors() : Array {
         return this._colors;
      }

      public function set colors(param1:Array) : void {
         this._colors = param1;
      }

      public function get dummy() : Boolean {
         return this._dummy;
      }

      public function set dummy(param1:Boolean) : void {
         this._dummy = param1;
      }

      public function get vType() : String {
         return this._vType;
      }

      public function set vType(param1:String) : void {
         this._vType = param1;
      }

      public function get orderNumber() : Number {
         return this._orderNumber;
      }

      public function set orderNumber(param1:Number) : void {
         this._orderNumber = param1;
      }

      public function get isCreator() : Boolean {
         return this._isCreator;
      }

      public function set isCreator(param1:Boolean) : void {
         this._isCreator = param1;
      }

      public function isOffline() : Boolean {
         return !((this._state & PrebattleStateFlags.OFFLINE) == 0);
      }

      public function getStateString() : String {
         var _loc1_:String = PrebattleStateString.UNKNOWN;
         if((this._state) && !(this._state == PrebattleStateFlags.UNKNOWN))
         {
            if(this.isOffline())
            {
               _loc1_ = (this._state & PrebattleStateFlags.NOT_READY) != 0?PrebattleStateString.OFFLINE:PrebattleStateString.OFFLINE_READY;
            }
            else
            {
               if(this._state == PrebattleStateFlags.NOT_READY)
               {
                  _loc1_ = PrebattleStateString.NOT_READY;
               }
               else
               {
                  if(this._state == PrebattleStateFlags.AFK)
                  {
                     _loc1_ = PrebattleStateString.AFK;
                  }
                  else
                  {
                     if(this._state == PrebattleStateFlags.READY)
                     {
                        _loc1_ = PrebattleStateString.READY;
                     }
                     else
                     {
                        if(this._state == PrebattleStateFlags.IN_BATTLE)
                        {
                           _loc1_ = PrebattleStateString.IN_BATTLE;
                        }
                     }
                  }
               }
            }
         }
         return _loc1_;
      }

      public function getCurrentColor() : Number {
         var _loc1_:IColorScheme = null;
         if((this.isCreator) && !this.himself)
         {
            _loc1_ = App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAM_COMMANDER);
            return _loc1_.rgb;
         }
         return this._colors?this._colors[this.isOffline()?1:0]:NaN;
      }
   }

}