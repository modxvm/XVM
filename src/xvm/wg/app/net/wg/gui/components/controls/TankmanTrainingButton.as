package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;


   public class TankmanTrainingButton extends SoundButton
   {
          
      public function TankmanTrainingButton() {
         this._priceColors =
            {
               "normal":16314069,
               "disabled":16711680
            }
         ;
         _stateMap =
            {
               "up":["up"],
               "over":["over"],
               "down":["down"],
               "release":["release","over"],
               "out":["out","up"],
               "disabled":["disabled"],
               "selecting":["selecting","out"],
               "kb_selecting":["kb_selecting","up"],
               "kb_release":["kb_release","out","up"],
               "kb_down":["kb_down","down"],
               "buy":["buy"]
            }
         ;
         soundType = SoundTypes.RNDR_NORMAL;
         super();
      }

      public static const TYPE_INVALID:String = "typeInvalid";

      public var bg:MovieClip;

      public var typeSwitcher:MovieClip;

      public var priceLabel:TextField;

      public var typeLabel:TextField;

      private var _buy:Boolean = false;

      private var _nation:Number;

      private var _type:String = "free";

      private var _priceColors:Object;

      public function get buy() : Boolean {
         return this._buy;
      }

      public function set buy(param1:Boolean) : void {
         if(this._buy == param1)
         {
            return;
         }
         this._buy = param1;
         this.priceLabel.visible = !this._buy && !(this._type == "free");
         clearRepeatInterval();
         setState(this._buy?"buy":"up");
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleMouseRollOver(param1);
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleMouseRollOut(param1);
      }

      override protected function handleMousePress(param1:MouseEvent) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleMousePress(param1);
      }

      override protected function handlePress(param1:uint=0) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handlePress(param1);
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleMouseRelease(param1);
      }

      override protected function handleRelease(param1:uint=0) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleRelease(param1);
      }

      override protected function handleReleaseOutside(param1:MouseEvent) : void {
         if(this._buy == true)
         {
            return;
         }
         super.handleReleaseOutside(param1);
      }

      override protected function configUI() : void {
         super.configUI();
      }

      public function get nation() : Number {
         return this._nation;
      }

      public function set nation(param1:Number) : void {
         this._nation = param1;
         invalidate("_nation");
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         if(this._type != param1)
         {
            this._type = param1;
            invalidate(TYPE_INVALID);
         }
      }

      public function get price() : String {
         return this.priceLabel.text;
      }

      public function set price(param1:String) : void {
         var _loc2_:String = !enabled?"disabled":"normal";
         this.priceLabel.textColor = this._priceColors[_loc2_];
         this.priceLabel.text = this._type == "academy"?App.utils.locale.gold(param1):App.utils.locale.integer(param1);
      }

      override public function toString() : String {
         return "[Wargaming TankmanTrainingButton " + name + "]";
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid("_nation"))
         {
            this.bg.gotoAndPlay(!isNaN(this._nation)?App.utils.nations.getNationName(this._nation):"empty");
         }
         if(isInvalid(TYPE_INVALID))
         {
            this.priceLabel.visible = !(this._type == "free");
            this.typeLabel.text = MENU.tankmantrainingwindow(this._type);
            this.typeSwitcher.gotoAndPlay(this._type);
         }
      }
   }

}