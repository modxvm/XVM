package net.wg.gui.lobby.GUIEditor
{
   import net.wg.dev.base.meta.impl.GEInspectWindowMeta;
   import net.wg.infrastructure.base.meta.IGEInspectWindowMeta;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.display.MovieClip;
   import net.wg.gui.events.ListEventEx;
   import flash.events.MouseEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.interfaces.IDataProvider;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;


   public class GEInspectWindow extends GEInspectWindowMeta implements IGEInspectWindowMeta
   {
          
      public function GEInspectWindow() {
         super();
         canClose = true;
      }

      private static function onComponentCreateHandler(param1:ComponentCreateEvent) : void {
         var _loc2_:Sprite = Sprite(param1.component);
         App.cursor.attachToCursor(_loc2_,0,0);
      }

      public var sceneList:ScrollingListEx = null;

      public var propsList:ScrollingListEx = null;

      public var componentsList:ScrollingListEx = null;

      public var componentsType:DropdownMenu = null;

      public var switcher:MovieClip = null;

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
         addEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
         this.propsList.addEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         this.propsList.mouseEnabled = false;
         this.switcher.addEventListener(MouseEvent.CLICK,this.onSwitcherClickHdlr);
         this.switcher.buttonMode = true;
         this.componentsType.dataProvider = new DataProvider([{"label":GUIEditorHelper.TYPE_ALL},{"label":GUIEditorHelper.TYPE_SIMPLE},{"label":GUIEditorHelper.TYPE_STANDART},{"label":GUIEditorHelper.TYPE_ADVANCED},{"label":GUIEditorHelper.TYPE_NON_SMART},{"label":GUIEditorHelper.TYPE_SMART}]);
         this.componentsType.selectedIndex = 0;
         this.componentsType.addEventListener(ListEvent.INDEX_CHANGE,this.onComponentsTypeIndexChangeHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
         this.updateDisplayList();
         this.updateComponentsList();
         this.switchMainPanels(true);
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
         this.sceneList.removeEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
         this.propsList.removeEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         this.componentsType.removeEventListener(ListEvent.INDEX_CHANGE,this.onComponentsTypeIndexChangeHandler);
         this.cleanUpInstancesInList();
         this.sceneList.dispose();
         this.sceneList = null;
         this.propsList.dispose();
         this.propsList = null;
         this.componentsList.dispose();
         this.componentsList = null;
         this.componentsType.dispose();
         this.componentsType = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         window.x = 0;
         window.y = 0;
         invalidateSize();
      }

      private function updateDisplayList() : void {
         this.cleanUpInstancesInList();
         var _loc1_:Array = GUIEditorHelper.instance.getDisplayList(DisplayObjectContainer(App.instance));
         this.sceneList.dataProvider = new DataProvider(_loc1_);
      }

      private function updateComponentsList() : void {
         var _loc1_:String = this.componentsType.dataProvider[this.componentsType.selectedIndex].label;
         var _loc2_:Array = GUIEditorHelper.instance.getComponentsList(_loc1_);
         this.componentsList.dataProvider = new DataProvider(_loc2_);
      }

      private function cleanUpInstancesInList() : void {
         var _loc2_:Object = null;
         var _loc1_:IDataProvider = this.sceneList.dataProvider;
         if(_loc1_ != null)
         {
            for each (_loc2_ in _loc1_)
            {
               _loc2_.instance = null;
            }
            _loc1_.cleanUp();
         }
      }

      private function updatePropertiesListForElement(param1:Number) : void {
         var _loc5_:String = null;
         var _loc2_:DisplayObject = this.sceneList.dataProvider[param1].instance;
         var _loc3_:Array = [];
         var _loc4_:Array = GUIEditorHelper.instance.getPropsList(_loc2_).sort();
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

      private function switchMainPanels(param1:Boolean) : void {
         this.propsList.visible = param1;
         this.sceneList.visible = param1;
         this.componentsType.visible = !param1;
         this.componentsList.visible = !param1;
         window.title = param1?"Property inspector":"components palette";
      }

      private function onComponentsTypeIndexChangeHandler(param1:ListEvent) : void {
         this.updateComponentsList();
      }

      private function onSwitcherClickHdlr(param1:MouseEvent) : void {
         this.switchMainPanels(false);
         showDesignerS();
      }

      private function onChangePropertyHandler(param1:ChangePropertyEvent) : void {
         var _loc2_:Object = this.sceneList.dataProvider[this.sceneList.selectedIndex];
         _loc2_.instance[param1.property] = param1.newValue;
      }

      private function onGlobalMouseDnHdlr(param1:MouseEvent) : void {
         var _loc3_:Object = null;
         var _loc4_:* = NaN;
         var _loc2_:DisplayObject = param1.target.parent;
         while(_loc2_ != null)
         {
            if(_loc2_ == this)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.updateDisplayList();
         for each (_loc3_ in this.sceneList.dataProvider)
         {
            if(param1.target == _loc3_.instance)
            {
               _loc4_ = this.sceneList.dataProvider.indexOf(_loc3_);
               this.sceneList.selectedIndex = _loc4_;
               this.updatePropertiesListForElement(_loc4_);
               App.utils.scheduler.scheduleTask(this.switchMainPanels,100,true);
               break;
            }
         }
      }

      private function onMouseRollOverHandler(param1:MouseEvent) : void {
         window.alpha = alpha = 1;
      }

      private function onMouseRollOutHandler(param1:MouseEvent) : void {
          
      }

      private function onSceneListClickHandler(param1:ListEventEx) : void {
         if(param1.index < this.sceneList.dataProvider.length)
         {
            this.updatePropertiesListForElement(param1.index);
         }
      }
   }

}