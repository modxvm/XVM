package net.wg.gui.lobby.GUIEditor.views
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.lobby.GUIEditor.SelectRectangle;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import net.wg.gui.events.ListEventEx;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.GUIEditor.ChangePropertyEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.GUIEditor.GUIEditorHelper;
    import flash.display.DisplayObjectContainer;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.GUIEditor.data.ComponentPropertyVO;
    import net.wg.gui.lobby.GUIEditor.data.ComponentProperties;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getQualifiedSuperclassName;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.GUIEditor.events.InspectorViewEvent;
    import flash.geom.Point;
    import net.wg.gui.lobby.GUIEditor.GEInspectWindow;
    
    public class InspectorView extends UIComponent implements IViewStackContent
    {
        
        public function InspectorView()
        {
            super();
        }
        
        public var sceneList:ScrollingListEx = null;
        
        public var propsList:ScrollingListEx = null;
        
        private var selectRect:SelectRectangle = null;
        
        private var btnGetParent:SoundButtonEx = null;
        
        private var selectedElement:DisplayObject = null;
        
        public function update(param1:Object) : void
        {
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.sceneList.addEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
            addEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
            this.propsList.mouseEnabled = false;
            this.updateDisplayList();
            this.createBtnGetParent();
            this.selectRect = new SelectRectangle();
        }
        
        override protected function onDispose() : void
        {
            this.cleanUpInstancesInList();
            removeEventListener(ChangePropertyEvent.CHANGE_PROPERTY,this.onChangePropertyHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onGlobalMouseDnHdlr);
            this.sceneList.removeEventListener(ListEventEx.ITEM_CLICK,this.onSceneListClickHandler);
            App.stage.removeChild(this.selectRect);
            this.selectRect.dispose();
            this.selectRect = null;
            this.sceneList.dispose();
            this.sceneList = null;
            this.propsList.dispose();
            this.propsList = null;
            this.btnGetParent = null;
            this.selectedElement = null;
            super.onDispose();
        }
        
        private function createBtnGetParent() : void
        {
            if(this.btnGetParent == null)
            {
                this.btnGetParent = App.utils.classFactory.getComponent("ButtonNormal",SoundButtonEx);
                addChild(this.btnGetParent);
                this.btnGetParent.label = "Parent";
                this.btnGetParent.autoSize = TextFieldAutoSize.CENTER;
                this.btnGetParent.enabled = false;
                this.btnGetParent.width = 60;
                this.btnGetParent.addEventListener(MouseEvent.CLICK,this.getParent);
                this.btnGetParent.x = this.sceneList.width - this.btnGetParent.width;
                this.btnGetParent.y = this.sceneList.height;
            }
        }
        
        private function cleanUpInstancesInList() : void
        {
            var _loc2_:Object = null;
            var _loc1_:IDataProvider = this.sceneList.dataProvider;
            if(_loc1_ != null)
            {
                for each(_loc2_ in _loc1_)
                {
                    _loc2_.instance = null;
                }
                _loc1_.cleanUp();
            }
        }
        
        private function updateDisplayList() : void
        {
            this.cleanUpInstancesInList();
            var _loc1_:Array = GUIEditorHelper.instance.getDisplayList(DisplayObjectContainer(App.instance));
            this.sceneList.dataProvider = new DataProvider(_loc1_);
        }
        
        private function updatePropertiesListForElement(param1:Number) : void
        {
            var _loc5_:ComponentPropertyVO = null;
            var _loc2_:DisplayObject = this.sceneList.dataProvider[param1].instance;
            var _loc3_:Array = [];
            var _loc4_:Array = GUIEditorHelper.instance.getPropsList(_loc2_).sort();
            for each(_loc5_ in _loc4_)
            {
                _loc3_.push(_loc5_.cloneAndSetValue(_loc2_[_loc5_.name]));
            }
            _loc3_.push(ComponentProperties.CLASS.cloneAndSetValue(getQualifiedClassName(_loc2_)));
            _loc3_.push(ComponentProperties.SUPER_CLASS.cloneAndSetValue(getQualifiedSuperclassName(_loc2_)));
            this.propsList.dataProvider = new DataProvider(_loc3_);
        }
        
        private function changeSelectRect(param1:DisplayObject) : void
        {
            var _loc2_:DisplayObjectContainer = null;
            var _loc3_:Rectangle = null;
            if(param1 != null)
            {
                this.selectRect.visible = true;
                _loc2_ = App.stage;
                _loc3_ = param1.getBounds(_loc2_);
                _loc2_.addChildAt(this.selectRect,_loc2_.numChildren);
                this.selectRect.x = _loc3_.x;
                this.selectRect.y = _loc3_.y;
                this.selectRect.update(param1);
            }
            else
            {
                this.selectRect.visible = false;
            }
        }
        
        private function selectElementById(param1:int) : void
        {
            var _loc2_:DisplayObject = this.sceneList.dataProvider[param1].instance;
            this.selectElement(_loc2_);
        }
        
        private function selectElement(param1:DisplayObject) : void
        {
            var _loc2_:Object = null;
            var _loc3_:* = NaN;
            this.updateDisplayList();
            if(param1 != null)
            {
                this.btnGetParent.enabled = true;
                this.selectedElement = param1;
            }
            else
            {
                this.btnGetParent.enabled = false;
            }
            dispatchEvent(new InspectorViewEvent(InspectorViewEvent.ELEMENT_SELECTED,param1));
            this.changeSelectRect(param1);
            for each(_loc2_ in this.sceneList.dataProvider)
            {
                if(param1 == _loc2_.instance)
                {
                    _loc3_ = this.sceneList.dataProvider.indexOf(_loc2_);
                    this.sceneList.selectedIndex = _loc3_;
                    this.updatePropertiesListForElement(_loc3_);
                    break;
                }
            }
        }
        
        private function checkElementUnderCursor(param1:DisplayObject) : DisplayObject
        {
            var _loc2_:Point = null;
            var _loc3_:Array = null;
            if(param1 as DisplayObjectContainer != null)
            {
                _loc2_ = new Point(App.stage.mouseX,App.stage.mouseY);
                _loc3_ = DisplayObjectContainer(param1).getObjectsUnderPoint(_loc2_);
                param1 = _loc3_[_loc3_.length - 1];
            }
            return param1;
        }
        
        private function isMouseCoordinatesInAppWindow() : Boolean
        {
            var _loc1_:DisplayObject = DisplayObject(App.instance);
            return App.stage.mouseX < App.appWidth + _loc1_.x && App.stage.mouseY < App.appHeight + _loc1_.y && App.stage.mouseX >= _loc1_.x && App.stage.mouseY >= _loc1_.y;
        }
        
        private function onChangePropertyHandler(param1:ChangePropertyEvent) : void
        {
            var _loc2_:DisplayObject = this.sceneList.dataProvider[this.sceneList.selectedIndex].instance;
            _loc2_[param1.property.name] = param1.newValue;
            this.changeSelectRect(_loc2_);
        }
        
        private function onGlobalMouseDnHdlr(param1:MouseEvent) : void
        {
            var _loc2_:DisplayObject = DisplayObject(App.instance);
            var _loc3_:DisplayObject = DisplayObject(param1.target);
            if((this.isMouseCoordinatesInAppWindow()) && !(_loc3_ == App.stage))
            {
                this.selectElement(this.checkElementUnderCursor(_loc3_));
            }
            else if(_loc3_ is GEInspectWindow || _loc3_ == App.stage)
            {
                this.selectElement(null);
            }
            
        }
        
        private function onSceneListClickHandler(param1:ListEventEx) : void
        {
            if(param1.index < this.sceneList.dataProvider.length)
            {
                this.selectElementById(param1.index);
            }
        }
        
        private function getParent(param1:MouseEvent) : void
        {
            if(this.selectedElement.parent != null)
            {
                this.selectElement(this.selectedElement.parent);
            }
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
