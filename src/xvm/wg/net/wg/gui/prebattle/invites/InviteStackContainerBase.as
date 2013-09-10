package net.wg.gui.prebattle.invites 
{
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class InviteStackContainerBase extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function InviteStackContainerBase()
        {
            this.dataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.rosterList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.rosterList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.rosterList_itemDoubleClickHandler);
            this.rosterList.disposeRenderers();
            this.rosterList = null;
            this.dataProvider.cleanUp();
            this.dataProvider = null;
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this.dataProvider = arg1 as net.wg.data.daapi.base.DAAPIDataProvider;
            this.rosterList.dataProvider = this.dataProvider;
            this.rosterList.validateNow();
            return;
        }

        protected override function configUI():void
        {
            focusable = true;
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement(this.rosterList.name, this.rosterList, scaleform.clik.utils.Constraints.ALL);
            this.rosterList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.rosterList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.rosterList_itemDoubleClickHandler);
            this.rosterList.useRightButton = true;
            this.rosterList.useRightButtonForSelect = true;
            this.rosterList.dataProvider = this.dataProvider as scaleform.clik.interfaces.IDataProvider;
            this.initDispatcher(net.wg.gui.prebattle.invites.SendInvitesEvent.INIT_COMPONENT, this);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (constraints && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                constraints.update(_width, _height);
            return;
        }

        internal function showContextMenu(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                this.initDispatcher(net.wg.gui.prebattle.invites.SendInvitesEvent.SHOW_CONTEXT_MENU, arg1.itemData);
            return;
        }

        protected function initDispatcher(arg1:String, arg2:Object):void
        {
            var loc1:*=new net.wg.gui.prebattle.invites.SendInvitesEvent(arg1, true);
            loc1.initItem = arg2;
            dispatchEvent(loc1);
            return;
        }

        internal function rosterList_itemDoubleClickHandler(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.LEFT_BUTTON) 
                if (arg1.itemData) 
                    this.initDispatcher(net.wg.gui.prebattle.invites.SendInvitesEvent.LIST_DOUBLE_CLICK, arg1.itemData);
            return;
        }

        public var rosterList:net.wg.gui.components.controls.ScrollingListEx;

        public var dataProvider:net.wg.data.daapi.base.DAAPIDataProvider;
    }
}
