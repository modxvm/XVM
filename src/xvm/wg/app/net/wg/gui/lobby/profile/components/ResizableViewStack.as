package net.wg.gui.lobby.profile.components
{
   import net.wg.gui.components.advanced.ViewStack;
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import flash.display.MovieClip;


   public class ResizableViewStack extends ViewStack
   {
          
      public function ResizableViewStack() {
         super();
      }

      private static const OFFSET_INVALID:String = "layoutInv";

      private static const AVAILABLE_SIZE_INV:String = "availSizeInv";

      private static const DATA_INV:String = "dataForUpdInv";

      private var availableSize:Point;

      private var _centerOffset:int = 0;

      private var _dataForUpdate:Object;

      override protected function draw() : void {
         super.draw();
         if(isInvalid(AVAILABLE_SIZE_INV))
         {
            if((this.availableSize) && (currentView))
            {
               IResizableContent(currentView).setViewSize(this.availableSize.x,this.availableSize.y);
            }
         }
         if(isInvalid(AVAILABLE_SIZE_INV))
         {
            if(currentView)
            {
               IResizableContent(currentView).centerOffset = this._centerOffset;
            }
         }
         if((isInvalid(DATA_INV)) && (this._dataForUpdate))
         {
            this.applyData();
         }
      }

      protected function applyData() : void {
         var _loc1_:IUpdatable = null;
         for each (_loc1_ in cachedViews)
         {
            _loc1_.update(this._dataForUpdate);
         }
      }

      public function updateData(param1:Object) : void {
         this._dataForUpdate = param1;
         invalidate(DATA_INV);
      }

      override public function show(param1:String) : MovieClip {
         var _loc2_:IResizableContent = currentView as IResizableContent;
         var _loc3_:MovieClip = super.show(param1);
         if(_loc2_)
         {
            _loc2_.active = false;
         }
         _loc2_ = IResizableContent(_loc3_);
         _loc2_.active = true;
         if(this.availableSize)
         {
            _loc2_.setViewSize(this.availableSize.x,this.availableSize.y);
         }
         _loc2_.centerOffset = this._centerOffset;
         _loc2_.update(this._dataForUpdate);
         return _loc3_;
      }

      override protected function onDispose() : void {
         this._dataForUpdate = null;
         super.onDispose();
      }

      public function setAvailableSize(param1:Number, param2:Number) : void {
         if(!this.availableSize)
         {
            this.availableSize = new Point();
         }
         this.availableSize.x = param1;
         this.availableSize.y = param2;
         invalidate(AVAILABLE_SIZE_INV);
      }

      public function set centerOffset(param1:int) : void {
         this._centerOffset = param1;
         invalidate(OFFSET_INVALID);
      }
   }

}