package net.wg.gui.lobby.techtree 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.helpers.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.sub.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class TechTreePage extends net.wg.infrastructure.base.meta.impl.TechTreeMeta implements net.wg.gui.lobby.techtree.interfaces.ITechTreePage
    {
        public function TechTreePage()
        {
            super();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onCloseTechTreeS();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            setViewSize(arg1, arg2);
            return;
        }

        public function as_setAvailableNations(arg1:Array):void
        {
            if (this.nationsBar != null) 
            {
                this.nationsBar.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            }
            return;
        }

        public function as_setSelectedNation(arg1:String):void
        {
            if (!this.nationsBar) 
            {
                return;
            }
            var loc1:*=this.nationsBar.dataProvider.indexOf(arg1);
            if (loc1 > -1) 
            {
                this.nationsBar.selectedIndex = loc1;
            }
            return;
        }

        public function as_refreshNationTreeData(arg1:String):void
        {
            var loc1:*=null;
            if (getNationTreeData != null) 
            {
                loc1 = getNationTreeDataS(arg1);
            }
            if (this.nationTree != null) 
            {
                this.nationTree.storeScrollPosition();
                this.nationTree.invalidateNodesData(arg1, loc1);
            }
            return;
        }

        public function as_setNodesStates(arg1:Number, arg2:Array):void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.setNodesStates(arg1, arg2);
            }
            return;
        }

        public function as_setNext2Unlock(arg1:Array):void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.setNodesStates(net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK, arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.UNLOCK_PROPS_FIELD);
            }
            return;
        }

        public function as_setVehicleTypeXP(arg1:Array):void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.setVehicleTypeXP(arg1);
            }
            return;
        }

        public function as_setInventoryItems(arg1:Array):void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.setNodesStates(net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY, arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.NODE_DUMP_FIELD);
            }
            return;
        }

        public function as_setUnlockProps(arg1:Array):void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.setItemsField(arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.UNLOCK_PROPS_FIELD);
            }
            return;
        }

        public function as_useXMLDumping():void
        {
            if (this.nationTree != null) 
            {
                this.nationTree.dataProvider = new net.wg.gui.lobby.techtree.data.NationXMLDataProvider();
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            if (!initialized) 
            {
                validateNow();
            }
            requestNationTreeDataS();
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            super.onDispose();
            if (this.titleAppearance != null) 
            {
                this.titleAppearance.clearUp();
                this.titleAppearance = null;
            }
            if (this.nationsBar != null) 
            {
                this.nationsBar.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.handleIndexChange);
                this.nationsBar.dispose();
            }
            if (this.nationTree != null) 
            {
                this.nationTree.dispose();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.titleAppearance = new net.wg.gui.lobby.techtree.helpers.TitleAppearance(this.titleField);
            if (this.titleField != null) 
            {
                this.titleField.mouseEnabled = false;
                scaleform.gfx.TextFieldEx.setVerticalAlign(this.titleField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
            }
            if (this.nationsBar != null) 
            {
                this.nationsBar.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.handleIndexChange, false, 0, true);
                this.nationsBar.focused = 1;
            }
            if (this.nationTree != null) 
            {
                this.nationTree.view = this;
            }
            if (this.treeRightBG != null) 
            {
                var loc1:*;
                this.treeRightBG.tabEnabled = loc1 = false;
                this.treeRightBG.mouseEnabled = loc1;
            }
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.updateLayouts();
            }
            return;
        }

        protected function updateLayouts():void
        {
            if (this.nationsBar != null) 
            {
                this.nationsBar.height = _height;
            }
            if (this.nationTree != null) 
            {
                this.nationTree.setSize(Math.round(_width - this.nationTree.x), Math.round(_height));
            }
            if (this.treeRightBG != null) 
            {
                this.treeRightBG.x = _width - this.treeRightBG.width;
                this.treeRightBG.height = _height;
            }
            this.titleAppearance.updateInTT(_width, App.appHeight);
            if (this.background != null) 
            {
                this.background.width = _width;
                this.background.height = _height + net.wg.data.constants.LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
            }
            return;
        }

        internal function handleIndexChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            var loc3:*=null;
            var loc1:*=this.nationsBar.itemToLabel(arg1.data);
            var loc2:*=null;
            if (getNationTreeData != null) 
            {
                loc2 = getNationTreeDataS(loc1);
            }
            if (this.titleField != null) 
            {
                if (loc3 = MENU.nation_tree_title(loc1)) 
                {
                    this.titleField.text = loc3;
                }
                else 
                {
                    this.titleField.text = "";
                }
            }
            if (this.nationTree != null) 
            {
                this.nationTree.storeScrollPosition();
                this.nationTree.invalidateNodesData(loc1, loc2);
            }
            return;
        }

        internal var titleAppearance:net.wg.gui.lobby.techtree.helpers.TitleAppearance=null;

        public var titleField:flash.text.TextField;

        public var nationTree:net.wg.gui.lobby.techtree.sub.NationTree;

        public var nationsBar:net.wg.gui.lobby.techtree.controls.NationsButtonBar;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;

        public var background:flash.display.Sprite;

        public var treeRightBG:flash.display.Sprite;
    }
}
