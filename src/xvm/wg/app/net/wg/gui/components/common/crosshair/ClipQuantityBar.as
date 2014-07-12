package net.wg.gui.components.common.crosshair
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   
   public class ClipQuantityBar extends UIComponent
   {
      
      public function ClipQuantityBar() {
         super();
      }
      
      public static const TYPE_LIGHT:String = "LightClipQuantityBar";
      
      public static const TYPE_MEDIUM:String = "MediumClipQuantityBar";
      
      public static const TYPE_HEAVY:String = "HeavyClipQuantityBar";
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_WARNING:String = "warning";
      
      public static const STATE_CRITICAL:String = "critical";
      
      public static const STATE_RELOADED:String = "reloaded";
      
      public static const MODE_FRAME:String = "frame";
      
      public static const MODE_PERCENT:String = "percent";
      
      public static const MODE_QUEUE:String = "queue";
      
      public static const MODE_AMMO:String = "ammo";
      
      public static const MODE_BURST:String = "burst";
      
      public static const MODE_CRITICAL:String = "critical";
      
      private static const HEAVY_LIMIT:int = 13;
      
      private static const MEDIUM_LIMIT:int = 31;
      
      public static function create(param1:Number, param2:Number) : ClipQuantityBar {
         var _loc6_:ClipQuantityBar = null;
         var _loc3_:String = TYPE_LIGHT;
         var _loc4_:String = MODE_PERCENT;
         var _loc5_:Number = param1;
         if(param2 > 1)
         {
            _loc5_ = Math.ceil(_loc5_ / param2);
         }
         if(_loc5_ < HEAVY_LIMIT)
         {
            _loc3_ = TYPE_HEAVY;
            _loc4_ = param2 > 1?MODE_QUEUE:MODE_AMMO;
         }
         else if(_loc5_ < MEDIUM_LIMIT)
         {
            _loc3_ = TYPE_MEDIUM;
            _loc4_ = param2 > 1?MODE_QUEUE:MODE_AMMO;
         }
         
         storedProps.clipCapacity = param1;
         storedProps.mode = _loc4_;
         storedProps.burst = param2;
         storedPropsChanged = false;
         _loc6_ = App.utils.classFactory.getComponent(_loc3_,ClipQuantityBar,storedProps);
         return _loc6_;
      }
      
      private static var storedPropsChanged:Boolean = false;
      
      private static var storedProps:Object;
      
      public static function store(param1:Number, param2:Number, param3:String) : void {
         storedProps.quantity = param1;
         storedProps.quantityInClip = param2;
         storedProps.clipState = param3;
         storedPropsChanged = true;
      }
      
      public var capacityBar:MovieClip;
      
      public var quantityInClipBar:MovieClip;
      
      private var _clipCapacity:Number = 1;
      
      private var _burst:Number = 1;
      
      private var _quantityInClip:Number = 0;
      
      private var _quantity:Number = 0;
      
      private var quantityBarCurrentFrame:Number = 0;
      
      private var quantityBarTotalFrames:Number = 0;
      
      private var _clipState:String = "normal";
      
      private var _mode:String = "frame";
      
      override protected function configUI() : void {
         super.configUI();
         if(storedPropsChanged)
         {
            this._quantity = storedProps.quantity;
            this._quantityInClip = storedProps.quantityInClip;
            this._clipState = storedProps.clipState;
            storedPropsChanged = false;
         }
         gotoAndStop(this._clipState);
         this.quantityBarTotalFrames = this.calcTotalFrames();
         this.quantityBarCurrentFrame = this.calcCurrentFrame();
      }
      
      override protected function draw() : void {
         super.draw();
         this.capacityBar.gotoAndStop(this.quantityBarTotalFrames);
         this.quantityInClipBar.gotoAndStop(this.quantityBarCurrentFrame);
      }
      
      public function get clipCapacity() : Number {
         return this._clipCapacity;
      }
      
      public function set clipCapacity(param1:Number) : void {
         if(param1 == this._clipCapacity || param1 < 0)
         {
            return;
         }
         this._clipCapacity = param1;
         if((initialized) || true)
         {
            this.quantityBarTotalFrames = this.calcTotalFrames();
            this.capacityBar.gotoAndStop(this.quantityBarTotalFrames);
         }
      }
      
      public function get quantityInClip() : Number {
         return this._quantityInClip;
      }
      
      public function set quantityInClip(param1:Number) : void {
         if(param1 == this._quantityInClip || param1 < 0)
         {
            return;
         }
         this._quantityInClip = param1;
         var _loc2_:Number = this.calcCurrentFrame();
         if(_loc2_ != this.quantityBarCurrentFrame)
         {
            this.quantityBarCurrentFrame = _loc2_;
            this.quantityInClipBar.gotoAndStop(this.quantityBarCurrentFrame);
         }
      }
      
      public function get quantity() : Number {
         return this._quantity;
      }
      
      public function set quantity(param1:Number) : void {
         if(param1 == this._quantity || param1 < -1)
         {
            return;
         }
         this._quantity = param1;
      }
      
      public function get clipState() : String {
         return this._clipState;
      }
      
      public function set clipState(param1:String) : void {
         if(param1 == this._clipState)
         {
            return;
         }
         this._clipState = param1;
         gotoAndStop(this._clipState);
      }
      
      public function get mode() : String {
         return this._mode;
      }
      
      public function set mode(param1:String) : void {
         if(param1 == this._mode || !(param1 == MODE_AMMO) && !(param1 == MODE_PERCENT) && !(param1 == MODE_BURST))
         {
            return;
         }
         this._mode = param1;
         this.quantityBarTotalFrames = this.calcTotalFrames();
         this.quantityBarCurrentFrame = this.calcCurrentFrame();
         invalidate();
      }
      
      public function get burst() : Number {
         return this._burst;
      }
      
      public function set burst(param1:Number) : void {
         this._burst = param1;
      }
      
      public function change(param1:Number, param2:Number, param3:String, param4:Boolean) : void {
         this._quantity = param1;
         this._quantityInClip = param2;
         this.quantityBarCurrentFrame = this.calcCurrentFrame();
         if(initialized)
         {
            if((param4) && this._quantityInClip == this._clipCapacity)
            {
               gotoAndPlay(STATE_RELOADED);
            }
            else if(this._clipState != param3)
            {
               gotoAndStop(param3);
            }
            
            this._clipState = param3;
            invalidate();
         }
      }
      
      private function calcTotalFrames() : Number {
         var _loc1_:Number = this.capacityBar.totalFrames;
         if(this._mode == MODE_AMMO)
         {
            _loc1_ = Math.min(this._clipCapacity + 1,_loc1_);
         }
         else if(this._mode == MODE_QUEUE)
         {
            _loc1_ = Math.min(Math.ceil(this._clipCapacity / this._burst) + 1,_loc1_);
         }
         
         return _loc1_;
      }
      
      private function calcCurrentFrame() : Number {
         var _loc1_:Number = this.quantityBarCurrentFrame;
         var _loc2_:* = this.quantityBarTotalFrames > this._clipCapacity / Math.max(this._burst,1);
         if(this._mode == MODE_AMMO && (_loc2_))
         {
            _loc1_ = this._quantityInClip > 0?this._quantityInClip + 1:0;
         }
         else if(this._mode == MODE_QUEUE && (_loc2_))
         {
            _loc1_ = Math.ceil(this._quantityInClip / this._burst) + 1;
         }
         else if(this._clipCapacity > 0)
         {
            _loc1_ = Math.ceil(this.quantityBarTotalFrames * this._quantityInClip / this._clipCapacity);
         }
         
         
         return Math.min(_loc1_,this.quantityBarTotalFrames);
      }
   }
}
