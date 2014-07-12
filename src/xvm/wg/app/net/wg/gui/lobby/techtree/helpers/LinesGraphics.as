package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import flash.display.Graphics;
   import flash.geom.ColorTransform;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class LinesGraphics extends Sprite implements IDisposable
   {
      
      public function LinesGraphics() {
         super();
         scale9Grid = new Rectangle(0,0,1,1);
         this.getComponent = App.utils.classFactory.getComponent;
      }
      
      protected var colorIdxs:Array;
      
      protected var lineRatio:Number = 0.5;
      
      protected var _container:INodesContainer = null;
      
      protected var getComponent:Function = null;
      
      public var unlockedLineColor:Number;
      
      public var next2unlockLineColor:Number;
      
      public var lockedLineColor:Number;
      
      public var lineThickness:Number = 1;
      
      public var arrowRenderer:String = "Arrow";
      
      public function get container() : INodesContainer {
         return this._container;
      }
      
      public function set container(param1:INodesContainer) : void {
         this._container = param1;
      }
      
      public function getVectorAxeXAngle(param1:Point, param2:Point) : Number {
         var _loc3_:* = NaN;
         var _loc4_:Point = param2.subtract(param1);
         if(_loc4_.y == 0)
         {
            _loc3_ = 0;
         }
         else if(_loc4_.x == 0)
         {
            _loc3_ = param1.y > param2.y?-90:90;
         }
         else
         {
            _loc3_ = Math.round(180 * Math.atan(_loc4_.y / _loc4_.x) / Math.PI);
         }
         
         return _loc3_;
      }
      
      public function getArrowPosition(param1:Point, param2:Number) : Point {
         var _loc3_:Point = param1.clone();
         if(param2 == 0)
         {
            _loc3_.y = _loc3_.y + this.lineRatio;
         }
         else if(Math.abs(param2) == 90)
         {
            _loc3_.x = _loc3_.x + this.lineRatio;
         }
         
         return _loc3_;
      }
      
      public function drawLine(param1:IRenderer, param2:Number, param3:Point, param4:Point, param5:String = null) : void {
         var _loc6_:Graphics = this.getSubSprite(param1,param5,true).graphics;
         _loc6_.lineStyle(this.lineThickness,param2,1);
         _loc6_.moveTo(param3.x,param3.y);
         _loc6_.lineTo(param4.x,param4.y);
      }
      
      public function drawArrow(param1:IRenderer, param2:Number, param3:Point, param4:Number = 0, param5:String = null) : void {
         var _loc8_:ColorTransform = null;
         var _loc6_:Object = 
            {
               "x":param3.x,
               "y":param3.y,
               "rotation":param4
            };
         var _loc7_:Sprite = this.getComponent(this.arrowRenderer,Sprite,_loc6_);
         if(param2)
         {
            _loc8_ = new ColorTransform();
            _loc8_.color = param2;
            _loc7_.transform.colorTransform = _loc8_;
         }
         this.getSubSprite(param1,param5,true).addChild(_loc7_);
      }
      
      public function drawArrowEx(param1:IRenderer, param2:Number, param3:Point, param4:Point, param5:String = null) : void {
         var _loc6_:Number = this.getVectorAxeXAngle(param3,param4);
         var _loc7_:Point = this.getArrowPosition(param4,_loc6_);
         this.drawArrow(param1,param2,_loc7_,_loc6_,param5);
      }
      
      public function clearLinesAndArrows(param1:IRenderer, param2:String = null) : void {
         var _loc4_:Sprite = null;
         var _loc3_:Sprite = getChildByName(param1.getGraphicsName()) as Sprite;
         if(_loc3_ == null)
         {
            return;
         }
         if(!(param2 == null) && param2.length > 0)
         {
            _loc4_ = this.getSubSprite(param1,param2,false);
            if(_loc4_ != null)
            {
               _loc3_.removeChild(_loc4_);
            }
         }
         else
         {
            removeChild(_loc3_);
         }
      }
      
      public function setup() : void {
         this.colorIdxs = [this.unlockedLineColor,this.next2unlockLineColor,this.lockedLineColor];
         this.lineRatio = 0.5 * this.lineThickness;
      }
      
      public final function dispose() : void {
         this.onDispose();
      }
      
      protected function onDispose() : void {
         this._container = null;
         this.getComponent = null;
      }
      
      public function clearUp() : void {
      }
      
      public function clearUpRenderer(param1:IRenderer) : void {
      }
      
      public function removeRenderer(param1:IRenderer) : void {
         this.clearUpRenderer(param1);
         this.clearLinesAndArrows(param1);
         if(contains(DisplayObject(param1)))
         {
            removeChild(DisplayObject(param1));
         }
      }
      
      private function getSubSprite(param1:IRenderer, param2:String = null, param3:Boolean = true) : Sprite {
         var _loc7_:DisplayObject = null;
         var _loc4_:String = param1.getGraphicsName();
         var _loc5_:Sprite = getChildByName(_loc4_) as Sprite;
         if(_loc5_ == null && (param3))
         {
            _loc5_ = new Sprite();
            _loc5_.name = _loc4_;
            addChild(_loc5_);
            _loc7_ = DisplayObject(param1);
            if(getChildIndex(_loc5_) > getChildIndex(_loc7_))
            {
               swapChildren(_loc7_,_loc5_);
            }
         }
         var _loc6_:Sprite = _loc5_;
         if(!(param2 == null) && !(_loc5_ == null))
         {
            _loc6_ = _loc5_.getChildByName(param2) as Sprite;
            if(_loc6_ == null && (param3))
            {
               _loc6_ = new Sprite();
               _loc6_.name = param2;
               _loc5_.addChild(_loc6_);
            }
         }
         return _loc6_;
      }
   }
}
