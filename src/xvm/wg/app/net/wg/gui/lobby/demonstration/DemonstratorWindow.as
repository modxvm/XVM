package net.wg.gui.lobby.demonstration 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.demonstration.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class DemonstratorWindow extends net.wg.infrastructure.base.meta.impl.DemonstratorWindowMeta implements net.wg.infrastructure.base.meta.IDemonstratorWindowMeta
    {
        public function DemonstratorWindow()
        {
            super();
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this.model = new net.wg.gui.lobby.demonstration.data.DemonstratorVO(arg1);
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.scrollStandard.visible = false;
            this.scrollAssault.visible = false;
            this.scrollEncounter.visible = false;
            this.listStandard.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            this.listAssault.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            this.listEncounter.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            return;
        }

        internal function onStageClick(arg1:flash.events.MouseEvent):void
        {
            this.updateScrollBars();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.model) 
            {
                this.listStandard.dataProvider = this.model.standard;
                this.listAssault.dataProvider = this.model.assault;
                this.listEncounter.dataProvider = this.model.encounter;
                App.utils.scheduler.envokeInNextFrame(this.updateScrollBars);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = MENU.DEMONSTRATOR_WINDOW_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.model.dispose();
            this.model = null;
            this.listStandard.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            this.listAssault.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            this.listEncounter.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.onMapItemClick);
            this.listStandard.dataProvider.cleanUp();
            this.listStandard.dataProvider = null;
            this.listAssault.dataProvider.cleanUp();
            this.listAssault.dataProvider = null;
            this.listEncounter.dataProvider.cleanUp();
            this.listEncounter.dataProvider = null;
            return;
        }

        internal function onMapItemClick(arg1:scaleform.clik.events.ListEvent):void
        {
            onMapSelectedS(net.wg.gui.lobby.demonstration.data.MapItemVO(arg1.itemData).id);
            return;
        }

        internal function updateScrollBars():void
        {
            this.scrollStandard.visible = this.scrollStandard.thumb.visible;
            this.scrollAssault.visible = this.scrollAssault.thumb.visible;
            this.scrollEncounter.visible = this.scrollEncounter.thumb.visible;
            return;
        }

        public var listStandard:net.wg.gui.components.controls.TileList;

        public var listAssault:net.wg.gui.components.controls.TileList;

        public var listEncounter:net.wg.gui.components.controls.TileList;

        public var scrollStandard:net.wg.gui.components.controls.ScrollBar;

        public var scrollAssault:net.wg.gui.components.controls.ScrollBar;

        public var scrollEncounter:net.wg.gui.components.controls.ScrollBar;

        internal var model:net.wg.gui.lobby.demonstration.data.DemonstratorVO;
    }
}
