package net.wg.gui.lobby.GUIEditor.views
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.utils.Constraints;
   import flash.display.InteractiveObject;
   import net.wg.gui.events.ListEventEx;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.GUIEditor.ChangePropertyEvent;
   import flash.display.Sprite;
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.gui.lobby.GUIEditor.GUIEditorHelper;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.lobby.GUIEditor.data.ComponentPropertyVO;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.GUIEditor.data.ComponentProperties;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import flash.geom.Rectangle;


   public class InspectorView extends UIComponent implements IViewStackContent
   {
          
      public function InspectorView() {
         super();
      }

      public var sceneList:ScrollingListEx = null;

      public var propsList:ScrollingListEx = null;

      private var constraint:Constraints;

      public function update(param1:Object) : void {
          
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }

      override protected function configUI() : void {
         super.configUI();
         this.sceneList.addEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
         addEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         this.propsList.mouseEnabled = false;
         this.updateDisplayList();
      }

      override protected function onDispose() : void {
         this.cleanUpInstancesInList();
         this.disposeSelectRect();
         removeEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
         this.sceneList.removeEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
         this.sceneList.dispose();
         this.sceneList = null;
         this.propsList.dispose();
         this.propsList = null;
         super.onDispose();
      }

      private function disposeSelectRect() : void {
         var _loc1_:Sprite = null;
         var _loc2_:DisplayObjectContainer = null;
         if(this.constraint != null)
         {
            _loc1_ = Sprite(this.constraint.scope);
            while(_loc1_.numChildren)
            {
               _loc1_.removeChildAt(0);
            }
            _loc2_ = App.stage;
            _loc2_.removeChild(_loc1_);
            this.constraint.dispose();
         }
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

      private function updateDisplayList() : void {
         this.cleanUpInstancesInList();
         var _loc1_:Array = GUIEditorHelper.instance.getDisplayList(DisplayObjectContainer(App.instance));
         this.sceneList.dataProvider = new DataProvider(_loc1_);
      }

      private function updatePropertiesListForElement(param1:Number) : void {
         var _loc5_:ComponentPropertyVO = null;
         var _loc2_:DisplayObject = this.sceneList.dataProvider[param1].instance;
         this.changeSelectRect(_loc2_);
         var _loc3_:Array = [];
         var _loc4_:Array = GUIEditorHelper.instance.getPropsList(_loc2_).sort();
         for each (_loc5_ in _loc4_)
         {
            _loc3_.push(_loc5_.cloneAndSetValue(_loc2_[_loc5_.name]));
         }
         _loc3_.push(ComponentProperties.CLASS.cloneAndSetValue(getQualifiedClassName(_loc2_)));
         _loc3_.push(ComponentProperties.SUPER_CLASS.cloneAndSetValue(getQualifiedSuperclassName(_loc2_)));
         this.propsList.dataProvider = new DataProvider(_loc3_);
      }

      private function onSceneListClickHandler(param1:ListEventEx) : void {
         if(param1.index < this.sceneList.dataProvider.length)
         {
            this.updatePropertiesListForElement(param1.index);
         }
      }

      private function onChangePropertyHandler(param1:ChangePropertyEvent) : void {
         var _loc2_:Object = this.sceneList.dataProvider[this.sceneList.selectedIndex];
         _loc2_.instance[param1.property.name] = param1.newValue;
         var _loc3_:DisplayObject = this.sceneList.dataProvider[this.sceneList.selectedIndex].instance;
         this.changeSelectRect(_loc3_);
      }

      private function changeSelectRect(param1:DisplayObject) : void {
         var _loc4_:Sprite = null;
         if(this.constraint == null)
         {
            _loc4_ = this.createSelectRect();
         }
         else
         {
            _loc4_ = Sprite(this.constraint.scope);
         }
         var _loc2_:DisplayObjectContainer = App.stage;
         _loc2_.addChildAt(_loc4_,_loc2_.numChildren);
         var _loc3_:Rectangle = param1.getBounds(_loc2_);
         _loc4_.x = _loc3_.x;
         _loc4_.y = _loc3_.y;
         this.constraint.update(_loc3_.width,_loc3_.height);
         _loc4_.graphics.clear();
         _loc4_.graphics.lineStyle(1,4560867);
         _loc4_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
      }

      private function createSelectRect() : Sprite {
         var _loc4_:uint = 0;
         var _loc5_:DisplayObject = null;
         var _loc1_:Sprite = new Sprite();
         this.constraint = new Constraints(_loc1_);
         var _loc2_:Class = App.utils.classFactory.getClass("SquareForSelect");
         var _loc3_:Array = [Constraints.LEFT | Constraints.TOP,Constraints.RIGHT | Constraints.TOP,Constraints.LEFT | Constraints.BOTTOM,Constraints.RIGHT | Constraints.BOTTOM,Constraints.CENTER_H | Constraints.TOP,Constraints.LEFT | Constraints.CENTER_V,Constraints.CENTER_H | Constraints.BOTTOM,Constraints.RIGHT | Constraints.CENTER_V];
         if(_loc2_ != null)
         {
            _loc4_ = 8;
            while(_loc4_ > 0)
            {
               _loc5_ = new _loc2_();
               _loc1_.addChild(_loc5_);
               this.constraint.addElement("square" + _loc4_,_loc5_,_loc3_[_loc4_]);
               _loc4_--;
            }
         }
         return _loc1_;
      }

      private function onGlobalMouseDnHdlr(param1:MouseEvent) : void {
         var _loc3_:DisplayObject = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:* = NaN;
         var _loc2_:DisplayObject = DisplayObject(App.instance);
         if(App.stage.mouseX < App.appWidth && App.stage.mouseY < App.appHeight && App.stage.mouseX >= _loc2_.x && App.stage.mouseY >= _loc2_.y)
         {
            _loc3_ = param1.target.parent;
            this.changeSelectRect(DisplayObject(param1.target));
            while(_loc3_ != null)
            {
               if(_loc3_ == this)
               {
                  return;
               }
               _loc3_ = _loc3_.parent;
            }
            this.updateDisplayList();
            _loc4_ = param1.target;
            for each (_loc5_ in this.sceneList.dataProvider)
            {
               if(_loc4_ == _loc5_.instance)
               {
                  _loc6_ = this.sceneList.dataProvider.indexOf(_loc5_);
                  this.sceneList.selectedIndex = _loc6_;
                  this.updatePropertiesListForElement(_loc6_);
                  break;
               }
            }
         }
      }
   }

}