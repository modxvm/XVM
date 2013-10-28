package net.wg.gui.cyberSport.controls
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Cursors;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class CSRosterToggleButton extends ButtonIconLoader
   {
          
      public function CSRosterToggleButton() {
         super();
         this.rFlagsFrame.visible = false;
         this.vType.visible = false;
         _data = {};
         this.hightLight.visible = false;
      }

      public static const FLAGS_SOURCE:String = "../maps/icons/filters/nations/";

      public var rFlagsFrame:Sprite;

      public var vType:MovieClip;

      public var sizeArea:MovieClip;

      public var hightLight:MovieClip;

      public var toggleBg:MovieClip;

      private var _vehicleType:String = null;

      private var _nationFlag:String = null;

      private var _buttonCursor:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.sizeArea.visible = false;
         buttonMode = false;
         this._buttonCursor = false;
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseOverHandler);
         this.mouseOverHandler();
      }

      override public function dispose() : void {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseOverHandler);
         App.utils.scheduler.cancelTask(this.mouseOverHandler);
         super.dispose();
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.alpha = param1?1:0.5;
      }

      private function mouseOverHandler(param1:MouseEvent=null) : void {
         if(this.testPoint())
         {
            if(!this._buttonCursor)
            {
               App.cursor.setCursor(Cursors.BUTTON);
               this._buttonCursor = true;
            }
         }
         else
         {
            if(this._buttonCursor)
            {
               this._buttonCursor = false;
               App.cursor.setCursor(Cursors.ARROW);
            }
         }
      }

      private function testPoint() : Boolean {
         return Boolean((mouseX <= this.toggleBg.width) && (mouseY <= this.toggleBg.height) && (mouseX >= 0) && (mouseY >= 0));
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         if(this.testPoint())
         {
            super.handleMouseRelease(param1);
         }
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this._buttonCursor = false;
         App.cursor.setCursor(Cursors.ARROW);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.STATE)) && (this.hightLight))
         {
            this.hightLight.visible = selected;
         }
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         App.utils.scheduler.envokeInNextFrame(this.mouseOverHandler);
      }

      public function get vehicleType() : String {
         return this._vehicleType;
      }

      public function set vehicleType(param1:String) : void {
         if((param1) && !(param1 == "") && !(param1 == "none"))
         {
            this._vehicleType = param1;
            this.changeViewState(true);
         }
      }

      public function get nationFlag() : String {
         return this._nationFlag;
      }

      public function set nationFlag(param1:String) : void {
         if((param1) && !(param1 == "") && !(param1 == "none"))
         {
            this._nationFlag = param1;
            externalSource = true;
            _data = this._nationFlag;
            iconSource = FLAGS_SOURCE + this._nationFlag + ".png";
            this.rFlagsFrame.visible = true;
            this.changeViewState(false);
         }
         else
         {
            this.rFlagsFrame.visible = false;
         }
      }

      protected function changeViewState(param1:Boolean) : void {
         if(externalSource)
         {
            return;
         }
         this.vType.visible = param1;
         if(param1)
         {
            this.vType.gotoAndStop(this.vehicleType);
            _data = this.vehicleType;
         }
      }

      override protected function completeHandler(param1:Event) : void {
         if((loader) && (this.toggleBg.contains(loader)))
         {
            this.toggleBg.removeChild(loader);
         }
         loader.scaleX = 1 / this.toggleBg.scaleX;
         loader.scaleY = 1 / this.toggleBg.scaleY;
         loader.x = Math.floor((this.toggleBg.width / this.toggleBg.scaleX - loader.width) / 2);
         loader.y = Math.floor((this.toggleBg.height / this.toggleBg.scaleY - loader.height) / 2);
         this.toggleBg.addChild(loader);
      }
   }

}