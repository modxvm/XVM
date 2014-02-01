package net.wg.gui.lobby.questsWindow.components
{
   import scaleform.clik.core.UIComponent;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IResizableContent;
   import net.wg.gui.events.ResizableBlockEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.DisplayObject;
   import flash.events.Event;


   public class ResizableContainer extends UIComponent
   {
          
      public function ResizableContainer() {
         this._data = [];
         super();
         this._blocks = new Vector.<IResizableContent>();
      }

      protected var _blocks:Vector.<IResizableContent> = null;

      protected var totalBlocks:int = 0;

      private var _data:Array;

      private var _isReadyForLayout:Boolean = false;

      private var _contentAlign:String = "left";

      private var _verticalPadding:int = 0;

      private var _availableWidth:Number = 375;

      private var _bottomPadding:int = 0;

      private var _isNumerated:Boolean = false;

      public function setData(param1:Array) : void {
         this._data = param1;
         invalidateData();
      }

      public function cleanContainer() : void {
         this.clearBlocks();
         this.layoutBlocks();
      }

      public function get isReadyForLayout() : Boolean {
         return this._isReadyForLayout;
      }

      public function set isReadyForLayout(param1:Boolean) : void {
         this._isReadyForLayout = param1;
      }

      public function get data() : Array {
         return this._data;
      }

      public function set data(param1:Array) : void {
         this._data = param1;
      }

      public function get verticalPadding() : int {
         return this._verticalPadding;
      }

      public function set verticalPadding(param1:int) : void {
         this._verticalPadding = param1;
      }

      public function get availableWidth() : Number {
         return this._availableWidth;
      }

      public function set availableWidth(param1:Number) : void {
         this._availableWidth = param1;
      }

      public function get bottomPadding() : int {
         return this._bottomPadding;
      }

      public function set bottomPadding(param1:int) : void {
         this._bottomPadding = param1;
      }

      public function get contentAlign() : String {
         return this._contentAlign;
      }

      public function set contentAlign(param1:String) : void {
         this._contentAlign = param1;
      }

      public function get isNumerated() : Boolean {
         return this._isNumerated;
      }

      public function set isNumerated(param1:Boolean) : void {
         this._isNumerated = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         addEventListener(ResizableBlockEvent.CONTETNT_WAS_CHANGED,this.componentsResizeHandler);
      }

      override protected function onDispose() : void {
         removeEventListener(ResizableBlockEvent.CONTETNT_WAS_CHANGED,this.componentsResizeHandler);
         if(this._blocks)
         {
            this.clearBlocks();
            this._blocks = null;
         }
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.createBlocks();
         }
      }

      protected function clearBlocks() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._blocks.length)
         {
            this._blocks[_loc1_].dispose();
            removeChild(DisplayObject(this._blocks[_loc1_]));
            _loc1_++;
         }
         this._blocks.splice(0,this._blocks.length);
      }

      protected function createBlocks() : void {
         var _loc1_:* = 0;
         var _loc2_:String = null;
         if((this._data) && (this._data.length))
         {
            this.totalBlocks = this._data.length;
            this.clearBlocks();
            _loc1_ = 0;
            while(_loc1_ < this.totalBlocks)
            {
               if(this._data[_loc1_].hasOwnProperty("linkage"))
               {
                  this.addBlock(this._data[_loc1_]);
               }
               else
               {
                  DebugUtils.LOG_ERROR("data must have linkage",this._data[_loc1_]);
                  for (_loc2_ in this._data[_loc1_])
                  {
                     DebugUtils.LOG_DEBUG(_loc2_,this._data[_loc1_][_loc2_]);
                  }
               }
               _loc1_++;
            }
            this.layoutBlocks();
         }
         else
         {
            this.cleanContainer();
         }
      }

      protected function addBlock(param1:Object) : void {
         var _loc2_:IResizableContent = App.utils.classFactory.getComponent(param1.linkage,IResizableContent);
         _loc2_.isReadyForLayout = false;
         _loc2_.availableWidth = this.availableWidth;
         _loc2_.contentAlign = this.contentAlign;
         _loc2_.isNumerated = this.isNumerated;
         _loc2_.setData(param1);
         _loc2_.validateNow();
         this._blocks.push(_loc2_);
         addChild(DisplayObject(_loc2_));
      }

      protected function layoutBlocks() : void {
         this.totalBlocks = this._blocks.length;
         var _loc1_:* = 0;
         while(_loc1_ < this.totalBlocks)
         {
            _loc1_++;
         }
         var _loc2_:Number = Math.round(this.totalBlocks > 0?this._blocks[this.totalBlocks-1].height + this._blocks[this.totalBlocks-1].y + this.bottomPadding:0);
         setSize(this.width,_loc2_);
         this.isReadyForLayout = true;
         dispatchEvent(new Event(Event.RESIZE));
      }

      protected function componentsResizeHandler(param1:ResizableBlockEvent) : void {
         if(this.isReadyForLayout)
         {
            this.layoutBlocks();
         }
      }
   }

}