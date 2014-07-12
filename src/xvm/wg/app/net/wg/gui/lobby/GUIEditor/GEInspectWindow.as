package net.wg.gui.lobby.GUIEditor
{
    import net.wg.dev.base.meta.impl.GEInspectWindowMeta;
    import net.wg.infrastructure.base.meta.IGEInspectWindowMeta;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    import flash.display.InteractiveObject;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.GUIEditor.events.InspectorViewEvent;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.GUIEditor.data.ContextMenuGeneratorItems;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import flash.geom.Point;
    import net.wg.gui.events.ContextMenuEvent;
    
    public class GEInspectWindow extends GEInspectWindowMeta implements IGEInspectWindowMeta
    {
        
        public function GEInspectWindow() {
            super();
            showWindowBg = false;
            canClose = false;
        }
        
        public static var CONTENT_TABS:Array;
        
        private static var TABS_DATA:Array;
        
        private static function onComponentCreateHandler(param1:ComponentCreateEvent) : void {
            var _loc2_:Sprite = Sprite(param1.component);
            App.cursor.attachToCursor(_loc2_,0,0);
        }
        
        public var viewStack:ViewStack = null;
        
        public var tabs:ButtonBarEx = null;
        
        public var contentTabs:ButtonBarEx = null;
        
        public var componentsPanel:ComponentsPanel = null;
        
        public var fileBtn:SoundButtonEx = null;
        
        public var editBtn:SoundButtonEx = null;
        
        public var tfLocation:TextField = null;
        
        public var btnCopyLocation:SoundButtonEx = null;
        
        override public function updateStage(param1:Number, param2:Number) : void {
            super.updateStage(param1,param2);
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.tabs.dataProvider = new DataProvider(TABS_DATA);
            this.contentTabs.dataProvider = new DataProvider(CONTENT_TABS);
            this.addListeners();
            this.viewStack.show("InspectorViewUI");
            this.tfLocation.autoSize = TextFieldAutoSize.LEFT;
            this.btnCopyLocation.visible = false;
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            addEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
            window.getBackground().visible = false;
            InteractiveObject(window).mouseEnabled = false;
            window.title = "";
        }
        
        override protected function onDispose() : void {
            removeEventListener(ComponentCreateEvent.COMPONENT_CREATE,onComponentCreateHandler);
            this.removeListeners();
            this.viewStack.dispose();
            this.viewStack = null;
            this.tabs.dispose();
            this.tabs = null;
            this.contentTabs.dispose();
            this.contentTabs = null;
            this.componentsPanel.dispose();
            this.componentsPanel = null;
            this.fileBtn.dispose();
            this.fileBtn = null;
            this.editBtn.dispose();
            this.editBtn = null;
            this.tfLocation = null;
            this.btnCopyLocation = null;
            super.onDispose();
        }
        
        override protected function draw() : void {
            super.draw();
            window.x = -window.formBgPadding.left - 322;
            window.y = -window.formBgPadding.top - 102;
            invalidateSize();
        }
        
        private function addListeners() : void {
            this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.viewStack.addEventListener(InspectorViewEvent.ELEMENT_SELECTED,this.onElementSelected);
            this.fileBtn.addEventListener(MouseEvent.CLICK,this.showContextMenu);
            this.editBtn.addEventListener(MouseEvent.CLICK,this.showContextMenu);
            this.btnCopyLocation.addEventListener(MouseEvent.MOUSE_DOWN,this.copyLocation);
        }
        
        private function removeListeners() : void {
            this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.viewStack.removeEventListener(InspectorViewEvent.ELEMENT_SELECTED,this.onElementSelected);
            this.fileBtn.removeEventListener(MouseEvent.CLICK,this.showContextMenu);
            this.editBtn.removeEventListener(MouseEvent.CLICK,this.showContextMenu);
            this.btnCopyLocation.removeEventListener(MouseEvent.MOUSE_DOWN,this.copyLocation);
        }
        
        private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void {
        }
        
        private function onViewChangeHandler(param1:ViewStackEvent) : void {
        }
        
        private function showContextMenu(param1:MouseEvent) : void {
            var _loc8_:String = null;
            var _loc2_:DisplayObject = DisplayObject(param1.target);
            if(_loc2_ == this.fileBtn)
            {
                _loc8_ = ContextMenuGeneratorItems.FILE_TYPE;
            }
            if(_loc2_ == this.editBtn)
            {
                _loc8_ = ContextMenuGeneratorItems.EDIT_TYPE;
            }
            var _loc3_:ContextMenuGeneratorItems = new ContextMenuGeneratorItems();
            var _loc4_:IContextMenu = App.contextMenuMgr.show(_loc3_.generateItemsContextMenu(_loc8_),this,this.onContextMenuHandler);
            var _loc5_:DisplayObject = DisplayObject(_loc4_);
            var _loc6_:Point = localToGlobal(new Point(_loc2_.x,_loc2_.y));
            var _loc7_:Point = _loc5_.parent.globalToLocal(_loc6_);
            _loc5_.x = _loc7_.x;
            _loc5_.y = _loc7_.y + _loc2_.height;
        }
        
        private function onContextMenuHandler(param1:ContextMenuEvent) : void {
            switch(param1.id)
            {
                case DEVELOPMENT.EDITOR_CONTEXTMENU_NEW:
                    break;
                case DEVELOPMENT.EDITOR_CONTEXTMENU_OPEN:
                    break;
                case DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE:
                    break;
                case DEVELOPMENT.EDITOR_CONTEXTMENU_SAVE_AS:
                    break;
                case DEVELOPMENT.EDITOR_CONTEXTMENU_COPY:
                    break;
                case DEVELOPMENT.EDITOR_CONTEXTMENU_CLOSE_EDITOR:
                    onWindowCloseS();
                    break;
            }
            App.contextMenuMgr.hide();
        }
        
        private function onElementSelected(param1:InspectorViewEvent) : void {
            var _loc3_:* = 0;
            var _loc4_:DisplayObject = null;
            var _loc5_:* = 0;
            var _loc2_:DisplayObject = param1.selectedElement;
            if(_loc2_ != null)
            {
                _loc3_ = 50;
                this.tfLocation.text = GUIEditorHelper.getLocationForDO(_loc2_);
                this.btnCopyLocation.visible = true;
                _loc4_ = DisplayObject(App.instance);
                this.btnCopyLocation.x = _loc4_.x;
                _loc5_ = 10;
                this.tfLocation.y = this.btnCopyLocation.y = _loc4_.y + App.appHeight + _loc5_;
                this.tfLocation.x = this.btnCopyLocation.x + this.btnCopyLocation.width;
                this.tfLocation.width = App.appWidth - this.btnCopyLocation.width;
            }
            else
            {
                this.tfLocation.text = "";
                this.btnCopyLocation.visible = false;
            }
        }
        
        private function copyLocation(param1:MouseEvent) : void {
            copyToClipboardS(this.tfLocation.text);
        }
    }
}
