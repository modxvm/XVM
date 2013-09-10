package net.wg.gui.lobby.techtree 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.data.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.sub.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class ResearchPage extends net.wg.infrastructure.base.meta.impl.ResearchMeta implements net.wg.gui.lobby.techtree.interfaces.IResearchPage
    {
        public function ResearchPage()
        {
            super();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            exitFromResearchS();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            setViewSize(arg1, arg2);
            return;
        }

        public function as_drawResearchItems(arg1:String, arg2:Number):void
        {
            var loc1:*=getResearchItemsDataS(arg2, false);
            if (this.researchItems != null) 
                this.researchItems.invalidateNodesData(arg1, loc1);
            return;
        }

        public function as_setNodesStates(arg1:Number, arg2:Array):void
        {
            if (this.researchItems != null) 
                this.researchItems.setNodesStates(arg1, arg2);
            return;
        }

        public function as_setNext2Unlock(arg1:Array):void
        {
            if (this.researchItems != null) 
                this.researchItems.setNodesStates(net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK, arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.UNLOCK_PROPS_FIELD);
            return;
        }

        public function as_setFreeXP(arg1:Number):void
        {
            if (this.researchItems != null) 
                this.researchItems.setFreeXP(arg1);
            return;
        }

        public function as_setVehicleTypeXP(arg1:Array):void
        {
            if (this.researchItems != null) 
                this.researchItems.setVehicleTypeXP(arg1);
            return;
        }

        public function as_setInventoryItems(arg1:Array):void
        {
            if (this.researchItems != null) 
                this.researchItems.setNodesStates(net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY, arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.NODE_DUMP_FIELD);
            return;
        }

        public function as_setInstalledItems(arg1:Array):void
        {
            if (this.researchItems != null) 
                this.researchItems.setNodesStates(net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED, arg1, net.wg.gui.lobby.techtree.data.vo.NodeData.NODE_DUMP_FIELD);
            return;
        }

        public function as_useXMLDumping():void
        {
            if (this.researchItems != null) 
                this.researchItems.dataProvider = new net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            if (!initialized) 
                validateNow();
            requestNationDataS();
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            super.onDispose();
            if (this.researchItems != null) 
                this.researchItems.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.researchItems != null) 
                this.researchItems.view = this;
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                this.updateLayouts();
            return;
        }

        protected function updateLayouts():void
        {
            if (this.background != null) 
            {
                this.background.width = _width;
                this.background.height = _height + net.wg.data.constants.LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
            }
            if (this.researchItems != null) 
            {
                this.researchItems.y = 0;
                this.researchItems.x = _width - net.wg.data.constants.LobbyMetrics.MIN_STAGE_WIDTH >> 1;
                this.researchItems.height = _height;
            }
            return;
        }

        public var researchItems:net.wg.gui.lobby.techtree.sub.ResearchItems;

        public var background:flash.display.Sprite;
    }
}
