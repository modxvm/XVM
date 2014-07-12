package net.wg.gui.components.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.utils.getDefinitionByName;
   
   public class BitmapFill extends UIComponentEx
   {
      
      public function BitmapFill() {
         super();
         if(!this.pos)
         {
            this.createPos();
            this.pos.x = 0;
            this.pos.y = 0;
            this.pos.width = this.tempBg.width * this.scaleX;
            this.pos.height = this.tempBg.height * this.scaleY;
         }
         if(this.tempBg)
         {
            this.tempBg.visible = false;
         }
      }
      
      public var tempBg:MovieClip;
      
      public var pos:Rectangle;
      
      public var repeat:String = "none";
      
      public var startPos:String = "TL";
      
      private var myBitmapData:BitmapData;
      
      private var _src:String = "";
      
      override public function setSize(param1:Number, param2:Number) : void {
         this.createPos();
         this.pos.width = param1;
         this.pos.height = param2;
         this.draw();
      }
      
      public function get source() : String {
         return this._src;
      }
      
      public function set source(param1:String) : void {
         var _loc2_:Class = null;
         this._src = param1;
         if(this._src != "")
         {
            _loc2_ = getDefinitionByName(this._src) as Class;
            this.myBitmapData = new _loc2_() as BitmapData;
            invalidate();
         }
      }
      
      public function get setBitmap() : BitmapData {
         return this.myBitmapData;
      }
      
      public function set setBitmap(param1:BitmapData) : void {
         this.myBitmapData = param1;
         invalidate();
      }
      
      public function get widthFill() : Number {
         return this.pos.width;
      }
      
      public function set widthFill(param1:Number) : void {
         this.setSize(param1,this.pos.height);
      }
      
      public function get heightFill() : Number {
         return this.pos.height;
      }
      
      public function set heightFill(param1:Number) : void {
         this.setSize(this.pos.width,param1);
      }
      
      override protected function onDispose() : void {
         this.tempBg = null;
         this.myBitmapData = null;
         this.pos = null;
         super.onDispose();
      }
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override protected function draw() : void {
         super.draw();
         this.graphics.clear();
         if(!this.myBitmapData)
         {
            return;
         }
         this.graphics.beginFill(13762560);
         this.graphics.beginBitmapFill(this.myBitmapData);
         var _loc1_:uint = this.pos.x;
         var _loc2_:uint = this.pos.y;
         var _loc3_:uint = this.pos.width;
         var _loc4_:uint = this.pos.height;
         switch(this.repeat)
         {
            case "none":
               _loc3_ = this.myBitmapData.width;
               _loc4_ = this.myBitmapData.height;
               break;
            case "horizontal":
               _loc3_ = this.pos.width;
               _loc4_ = this.myBitmapData.height;
               break;
            case "vertical":
               _loc3_ = this.myBitmapData.width;
               _loc4_ = this.pos.height;
               break;
            case "all":
               _loc3_ = this.pos.width;
               _loc4_ = this.pos.height;
               break;
         }
         switch(this.startPos)
         {
            case "TL":
               _loc1_ = 0;
               _loc2_ = 0;
               break;
            case "TR":
               _loc1_ = -_loc3_;
               _loc2_ = 0;
               break;
            case "TC":
               _loc1_ = -Math.round(_loc3_ / 2);
               _loc2_ = 0;
               break;
            case "BL":
               _loc1_ = 0;
               _loc2_ = -_loc4_;
               break;
            case "BR":
               _loc1_ = -_loc3_;
               _loc2_ = -_loc4_;
               break;
            case "BC":
               _loc1_ = -Math.round(_loc3_ / 2);
               _loc2_ = -_loc4_;
               break;
            case "CL":
               _loc1_ = 0;
               _loc2_ = -Math.round(_loc4_ / 2);
               break;
            case "CR":
               _loc1_ = -_loc3_;
               _loc2_ = -Math.round(_loc4_ / 2);
               break;
            case "CC":
               _loc1_ = -Math.round(_loc3_ / 2);
               _loc2_ = -Math.round(_loc4_ / 2);
               break;
         }
         this.graphics.lineTo(_loc1_,_loc2_);
         this.graphics.lineTo(_loc1_ + _loc3_,_loc2_);
         this.graphics.lineTo(_loc1_ + _loc3_,_loc2_ + _loc4_);
         this.graphics.lineTo(_loc1_,_loc2_ + _loc4_);
         this.graphics.lineTo(_loc1_,_loc2_);
         this.graphics.endFill();
      }
      
      private function createPos() : void {
         if(!this.pos)
         {
            this.pos = new Rectangle(0,0,0,0);
         }
      }
   }
}
