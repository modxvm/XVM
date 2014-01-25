package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.infrastructure.interfaces.ISortable;
   import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import scaleform.clik.motion.Tween;
   import flash.events.Event;
   import net.wg.gui.events.ResizableBlockEvent;
   import fl.transitions.easing.Strong;
   import scaleform.clik.constants.InvalidationType;


   public class EventsResizableContent extends AbstractResizableContent implements ISortable
   {
          
      public function EventsResizableContent() {
         this.tweens = new Vector.<Tween>();
         this.fadeTweens = new Vector.<Tween>();
         super();
      }

      private static const ANIMATION_DURATION:int = 500;

      private static const HEADER_HEIGHT:int = 26;

      public var data:EventsResizableContentVO = null;

      public var header:ResizableContentHeader;

      public var contentMask:Sprite;

      public var resizableContainer:MovableBlocksContainer;

      private var tweens:Vector.<Tween>;

      private var fadeTweens:Vector.<Tween>;

      private var contentHeight:Number;

      private var _sortingFunction:Function = null;

      override protected function configUI() : void {
         super.configUI();
         this.resizableContainer.verticalPadding = 3;
         this.header.height = HEADER_HEIGHT;
         this.resizableContainer.sortingFunction = this._sortingFunction;
         this.header.slideCheckBox.addEventListener(Event.SELECT,this.startAnimation);
         this.resizableContainer.addEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
         this.resizableContainer.addEventListener(Event.RESIZE,this.resizableContainerResizeHandler);
      }

      override protected function onDispose() : void {
         var _loc1_:Tween = null;
         var _loc2_:Tween = null;
         this.resizableContainer.removeEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
         this.resizableContainer.removeEventListener(Event.RESIZE,this.resizableContainerResizeHandler);
         this.header.slideCheckBox.removeEventListener(Event.SELECT,this.startAnimation);
         this.contentMask = null;
         this.header.dispose();
         this.header = null;
         this.resizableContainer.dispose();
         this.resizableContainer = null;
         this._sortingFunction = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         for each (_loc1_ in this.tweens)
         {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_ = null;
         }
         this.tweens = null;
         for each (_loc2_ in this.fadeTweens)
         {
            _loc2_.onComplete = null;
            _loc2_.onChange = null;
            _loc2_.paused = true;
            _loc2_ = null;
         }
         this.fadeTweens = null;
         super.onDispose();
      }

      private function startAnimation(param1:Event) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         if(isReadyForLayout)
         {
            _loc2_ = this.header.slideCheckBox.selected?this.contentHeight + this.header.height:this.header.height;
            _loc3_ = _loc2_ - this.contentMask.height;
            dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.READY_FOR_ANIMATION,false,_loc3_));
            this.playResizeAnimation(_loc2_,ANIMATION_DURATION,this.onEndAnimation);
            _loc4_ = this.header.slideCheckBox.selected?1:0;
            this.playFadeAnimation(_loc4_,ANIMATION_DURATION);
         }
      }

      private function onEndAnimation() : void {
         this.layoutComponents();
         dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
      }

      private function playResizeAnimation(param1:Number, param2:Number, param3:Function=null) : void {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each (_loc4_ in this.tweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.tweens = Vector.<Tween>([new Tween(param2,this.contentMask,{"height":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":param3
            }
         )]);
         for each (_loc5_ in this.tweens)
         {
            _loc5_.fastTransform = false;
         }
      }

      private function playFadeAnimation(param1:Number, param2:Number, param3:Function=null) : void {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each (_loc4_ in this.fadeTweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.fadeTweens = Vector.<Tween>([new Tween(param2,this.resizableContainer,{"alpha":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":param3
            }
         )]);
         for each (_loc5_ in this.fadeTweens)
         {
            _loc5_.fastTransform = false;
         }
      }

      override public function setData(param1:Object) : void {
         this.data = new EventsResizableContentVO(param1);
         this.resizableContainer.isReadyForLayout = false;
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.header.slideCheckBox.selected = this.data.isOpened;
               this.header.label = this.data.headerTitle;
               this.header.htmlLabel = this.data.headerHtmlPart;
               this.header.slideCheckBox.enabled = this.data.isResizable;
               if(this.data.headerProgress)
               {
                  this.header.setProgress(this.data.headerProgress);
               }
            }
            if(this.data)
            {
               this.resizableContainer.setData(this.data.containerElements);
               this.resizableContainer.validateNow();
            }
            else
            {
               this.resizableContainer.cleanContainer();
            }
            this.layoutComponents();
         }
      }

      private function layoutComponents() : void {
         var _loc1_:Number = this.header.height;
         this.resizableContainer.y = Math.round(_loc1_);
         this.contentHeight = this.resizableContainer.height;
         this.contentMask.height = this.header.slideCheckBox.selected?this.contentHeight + _loc1_:_loc1_;
         var _loc2_:Number = _loc1_ + this.contentHeight;
         setSize(this.width,this.header.slideCheckBox.selected?_loc2_:_loc1_);
         isReadyForLayout = true;
      }

      private function resizableContainerResizeHandler(param1:Event) : void {
         this.checkInitedComponents();
      }

      private function checkInitedComponents() : void {
         var _loc1_:Boolean = this.resizableContainer.isReadyForLayout;
         if(_loc1_)
         {
            this.layoutComponents();
            dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
         }
      }

      private function containerAnimationHandler(param1:ResizableBlockEvent) : void {
         var _loc2_:Number = this.contentMask.height + param1.heightDiff;
         this.playResizeAnimation(_loc2_,ANIMATION_DURATION,this.onEndAnimation);
      }

      public function get sortingFunction() : Function {
         return this._sortingFunction;
      }

      public function set sortingFunction(param1:Function) : void {
         this._sortingFunction = param1;
      }
   }

}