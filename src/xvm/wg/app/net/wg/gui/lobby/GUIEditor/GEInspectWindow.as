package net.wg.gui.lobby.GUIEditor
{
   import net.wg.infrastructure.base.meta.impl.GEInspectWindowMeta;
   import net.wg.infrastructure.base.meta.IGEInspectWindowMeta;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import flash.events.MouseEvent;
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.data.DataProvider;
   import flash.display.DisplayObject;
   import avmplus.getQualifiedClassName;
   import flash.text.TextField;
   import avmplus.getQualifiedSuperclassName;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.ScrollingList;


   public class GEInspectWindow extends GEInspectWindowMeta implements IGEInspectWindowMeta
   {
          
      public function GEInspectWindow() {
         super();
         canClose = true;
      }

      public var sceneList:ScrollingListEx = null;

      public var propsList:ScrollingListEx = null;

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         x = 0;
         y = 0;
         window.x = 0;
         window.y = 0;
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         this.sceneList.addEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.propsList.addEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
         this.updateDisplayList();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.cleanUpInstancesInList();
         this.propsList.removeEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         this.sceneList.dispose();
         this.sceneList = null;
         this.propsList.dispose();
         this.propsList = null;
      }

      override protected function draw() : void {
         super.draw();
         window.x = 0;
         window.y = 0;
         invalidateSize();
      }

      private function updateDisplayList() : void {
         this.cleanUpInstancesInList();
         var _loc1_:Array = this.getDisplayList(DisplayObjectContainer(App.instance));
         this.sceneList.dataProvider = new DataProvider(_loc1_);
      }

      private function cleanUpInstancesInList() : void {
         var _loc1_:Object = null;
         if(this.sceneList.dataProvider != null)
         {
            for each (_loc1_ in this.sceneList.dataProvider)
            {
               _loc1_.instance = null;
            }
         }
         this.sceneList.dataProvider.cleanUp();
      }

      private function getDisplayList(param1:DisplayObjectContainer, param2:String="") : Array {
         var _loc4_:* = NaN;
         var _loc5_:DisplayObject = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc3_:Array = [];
         if(param2.length <= 1000)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.numChildren)
            {
               _loc5_ = param1.getChildAt(_loc4_);
               _loc6_ = getQualifiedClassName(_loc5_);
               _loc7_ = _loc6_.lastIndexOf("::");
               if(_loc7_ != -1)
               {
                  _loc6_ = _loc6_.substr(_loc7_ + 2);
               }
               _loc8_ = "../maps/icons/tooltip/complex_equipment.png";
               _loc9_ = param2;
               switch(_loc6_)
               {
                  case "TextField":
                     _loc9_ = _loc9_ + TextField(_loc5_).text;
                     break;
                  default:
                     _loc9_ = _loc9_ + _loc5_.name + "(" + _loc6_ + ")";
               }
               _loc3_.push(
                  {
                     "label":_loc9_,
                     "icon":_loc8_,
                     "instance":_loc5_
                  }
               );
               if(_loc5_  is  DisplayObjectContainer)
               {
                  _loc3_ = _loc3_.concat(this.getDisplayList(DisplayObjectContainer(_loc5_),param2 + "    "));
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }

      private function updatePropertiesListForElement(param1:Number) : void {
         var _loc5_:String = null;
         var _loc2_:DisplayObject = this.sceneList.dataProvider[param1].instance;
         var _loc3_:Array = [];
         var _loc4_:Array = this.getPropsList(_loc2_);
         for each (_loc5_ in _loc4_)
         {
            _loc3_.push(
               {
                  "label":_loc5_,
                  "value":_loc2_[_loc5_]
               }
            );
         }
         _loc3_.push(
            {
               "label":"class",
               "value":getQualifiedClassName(_loc2_)
            }
         );
         _loc3_.push(
            {
               "label":"superclass",
               "value":getQualifiedSuperclassName(_loc2_)
            }
         );
         this.propsList.dataProvider = new DataProvider(_loc3_);
      }

      private function getPropsList(param1:Object) : Array {
         var _loc2_:Array = [];
         if(param1  is  InteractiveObject)
         {
            _loc2_ = _loc2_.concat(["tabEnabled","tabIndex","mouseEnabled","doubleClickEnabled"]);
         }
         if(param1  is  DisplayObject)
         {
            _loc2_ = _loc2_.concat(["x","y","width","height","alpha","name","rotation","scaleX","scaleY","visible"]);
         }
         if(param1  is  DisplayObjectContainer)
         {
            _loc2_ = _loc2_.concat(["numChildren","tabChildren","mouseChildren"]);
         }
         if(param1  is  Sprite)
         {
            _loc2_ = _loc2_.concat(["hitArea","buttonMode","useHandCursor","mouseChildren"]);
         }
         if(param1  is  MovieClip)
         {
            _loc2_ = _loc2_.concat(["currentFrame","framesLoaded","totalFrames","currentLabel","currentFrameLabel","currentLabels","enabled"]);
         }
         if(param1  is  TextField)
         {
            _loc2_ = _loc2_.concat(["antiAliasType","autoSize","background","backgroundColor","border","borderColor","bottomScrollV","condenseWhite","embedFonts","htmlText","length","textInteractionMode","maxChars","maxScrollH","maxScrollV","mouseWheelEnabled","multiline","numLines","restrict","scrollH","scrollV","selectable","selectedText","selectionBeginIndex","selectionEndIndex","text","textColor","textHeight","textWidth","type"]);
         }
         if(param1  is  UIComponent)
         {
            _loc2_ = _loc2_.concat(["componentInspectorSetting","hasFocus","focused","focusTarget","actualWidth","actualHeight","actualScaleX","actualScaleY"]);
         }
         if(param1  is  CoreList)
         {
            _loc2_ = _loc2_.concat(["itemRendererName","itemRenderer","labelField"]);
         }
         if(param1  is  ScrollingList)
         {
            _loc2_ = _loc2_.concat(["margin","scrollBar","scrollPosition","rowCount","rowHeight"]);
         }
         return _loc2_;
      }

      private function onChangePropertyHandler(param1:ChangePropertyEvent) : void {
         var _loc2_:Object = this.sceneList.dataProvider[this.sceneList.selectedIndex];
         _loc2_.instance[param1.property] = param1.newValue;
      }

      private function onGlobalMouseDnHdlr(param1:MouseEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:* = NaN;
         for each (_loc2_ in this.sceneList.dataProvider)
         {
            if(param1.target == _loc2_.instance)
            {
               _loc3_ = this.sceneList.dataProvider.indexOf(_loc2_);
               this.sceneList.selectedIndex = _loc3_;
               this.updatePropertiesListForElement(_loc3_);
               break;
            }
         }
      }

      private function onMouseRollOverHandler(param1:MouseEvent) : void {
         window.alpha = alpha = 1;
      }

      private function onMouseRollOutHandler(param1:MouseEvent) : void {
         window.alpha = alpha = 0.5;
      }

      private function onSceneListClickHandler(param1:ListEventEx) : void {
         if(param1.index < this.sceneList.dataProvider.length)
         {
            this.updatePropertiesListForElement(param1.index);
         }
      }
   }

}