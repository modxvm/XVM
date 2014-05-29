package scaleform.clik.managers
{
   import flash.display.Stage;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import net.wg.utils.IEventCollector;
   import flash.geom.Point;
   import scaleform.gfx.FocusManager;


   public class PopUpManager extends Object
   {
          
      public function PopUpManager() {
         super();
      }

      protected static var initialized:Boolean = false;

      public static function init(param1:Stage) : void {
         if(initialized)
         {
            return;
         }
         PopUpManager._stage = param1;
         _defaultPopupCanvas = new MovieClip();
         _defaultPopupCanvas.addEventListener(Event.REMOVED,handleRemovePopup,false,0,true);
         _stage.addChild(_defaultPopupCanvas);
         initialized = true;
      }

      protected static var _stage:Stage;

      protected static var _defaultPopupCanvas:MovieClip;

      public static function get popupCanvas() : MovieClip {
         return _defaultPopupCanvas;
      }

      protected static var _modalMc:Sprite;

      protected static var _modalBg:Sprite;

      public static function show(param1:DisplayObject, param2:Number=0, param3:Number=0, param4:DisplayObjectContainer=null) : void {
         if(!_stage)
         {
            return;
         }
         var _loc5_:IEventCollector = App.utils.events;
         _loc5_.disableDisposingForObj(param1);
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         handleStageAddedEvent(null);
         _defaultPopupCanvas.addChild(param1);
         _loc5_.enableDisposingForObj(param1);
         if(!param4)
         {
            param4 = _stage;
         }
         var _loc6_:Point = new Point(param2,param3);
         _loc6_ = param4.localToGlobal(_loc6_);
         param1.x = _loc6_.x;
         param1.y = _loc6_.y;
         _stage.setChildIndex(_defaultPopupCanvas,_stage.numChildren-1);
         _stage.addEventListener(Event.ADDED,PopUpManager.handleStageAddedEvent,false,0,true);
      }

      public static function showModal(param1:Sprite, param2:Number=0, param3:Number=0, param4:Sprite=null, param5:uint=0, param6:Sprite=null) : void {
         if(!_stage)
         {
            return;
         }
         if(_modalMc)
         {
            _defaultPopupCanvas.removeChild(_modalMc);
         }
         if(param1 == null)
         {
            return;
         }
         if(param4 == null)
         {
            param4 = new Sprite();
            param4.graphics.lineStyle(0,16777215,0);
            param4.graphics.beginFill(16777215,0);
            param4.graphics.drawRect(0,0,_stage.stageWidth,_stage.stageHeight);
            param4.graphics.endFill();
         }
         _modalMc = param1;
         _modalBg = param4;
         _modalMc.x = param2;
         _modalMc.y = param3;
         _defaultPopupCanvas.addChild(_modalBg);
         _defaultPopupCanvas.addChild(_modalMc);
         FocusHandler.getInstance().setFocus(param6,param5,false);
         FocusManager.setModalClip(_modalMc,param5);
         _modalMc.addEventListener(Event.REMOVED_FROM_STAGE,handleRemoveModalMc,false,0,true);
         _stage.addEventListener(Event.ADDED,PopUpManager.handleStageAddedEvent,false,0,true);
      }

      protected static function handleStageAddedEvent(param1:Event) : void {
         _stage.setChildIndex(_defaultPopupCanvas,_stage.numChildren-1);
      }

      protected static function handleRemovePopup(param1:Event) : void {
         removeAddedToStageListener();
      }

      protected static function handleRemoveModalMc(param1:Event) : void {
         _modalBg.removeEventListener(Event.REMOVED_FROM_STAGE,handleRemoveModalMc,false);
         if(_modalBg)
         {
            _defaultPopupCanvas.removeChild(_modalBg);
         }
         _modalMc = null;
         _modalBg = null;
         FocusManager.setModalClip(null);
         removeAddedToStageListener();
      }

      protected static function removeAddedToStageListener() : void {
         if(_defaultPopupCanvas.numChildren == 0 && _modalMc == null)
         {
            _stage.removeEventListener(Event.ADDED,PopUpManager.handleStageAddedEvent,false);
         }
      }
   }

}