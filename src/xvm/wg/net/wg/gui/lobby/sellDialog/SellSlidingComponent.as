package net.wg.gui.lobby.sellDialog 
{
    import flash.display.*;
    import flash.geom.*;
    import net.wg.data.VO.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class SellSlidingComponent extends scaleform.clik.core.UIComponent
    {
        public function SellSlidingComponent()
        {
            this.sellData = [];
            super();
            scrollRect = new flash.geom.Rectangle(0, 0, 480, 270);
            return;
        }

        public function getNextPosition():int
        {
            return this.expandBg.y + this.expandBg.height + PADDING_FOR_NEXT_ELEMENT;
        }

        public function get isOpened():Boolean
        {
            return this._isOpened;
        }

        public function set isOpened(arg1:Boolean):void
        {
            this._isOpened = arg1;
            this.settingsBtn.setingsDropBtn.selected = this.isOpened;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.settingsBtn.visible = false;
            this.expandBg.visible = false;
            this.slidingScrList.addEventListener(net.wg.gui.events.VehicleSellDialogEvent.LIST_WAS_DRAWN, this.wasDrawnHandler, false, 5);
            return;
        }

        internal function wasDrawnHandler(arg1:net.wg.gui.events.VehicleSellDialogEvent):void
        {
            this.listHeight = arg1.listVisibleHight;
            this.updateElements();
            return;
        }

        public function setShells(arg1:Object):void
        {
            var loc4:*=null;
            var loc1:*=new net.wg.data.VO.SellDialogItem();
            var loc2:*=App.utils.locale;
            var loc3:*=0;
            while (loc3 < arg1.shells.length) 
            {
                if (arg1.shells[loc3] != undefined) 
                    if (arg1.shells[loc3].count != 0) 
                    {
                        (loc4 = new net.wg.data.VO.SellDialogElement()).id = arg1.shells[loc3].userName + " (" + arg1.shells[loc3].count + " " + loc2.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                        loc4.isRemovable = true;
                        loc4.type = "shells";
                        loc4.data = arg1.shells[loc3];
                        if (arg1.shells[loc3].buyPrice[1] > 0) 
                            loc4.inInventory = true;
                        else 
                            loc4.inInventory = false;
                        loc4.moneyValue = arg1.shells[loc3].sellPrice[0] * arg1.shells[loc3].count;
                        loc1.elements.push(loc4);
                    }
                ++loc3;
            }
            if (loc1.elements.length != 0) 
            {
                loc1.header = DIALOGS.VEHICLESELLDIALOG_AMMO_LABEL;
                this.sellData.push(loc1);
            }
            return;
        }

        public function setEquipment(arg1:Object):void
        {
            var loc3:*=null;
            var loc1:*=new net.wg.data.VO.SellDialogItem();
            var loc2:*=0;
            while (loc2 < arg1.eqs.length) 
            {
                if (arg1.eqs[loc2] != undefined) 
                {
                    (loc3 = new net.wg.data.VO.SellDialogElement()).id = arg1.eqs[loc2].userName;
                    loc3.type = "eqs";
                    loc3.moneyValue = arg1.eqs[loc2].sellPrice[0];
                    loc3.inInventory = true;
                    loc3.data = arg1.eqs[loc2];
                    loc3.isRemovable = true;
                    loc1.elements.push(loc3);
                }
                ++loc2;
            }
            if (loc1.elements.length != 0) 
            {
                loc1.header = DIALOGS.VEHICLESELLDIALOG_EQUIPMENT;
                this.sellData.push(loc1);
            }
            return;
        }

        public function calculateOpenedState():void
        {
            this.settingsBtn.y = 0;
            this.slidingScrList.y = this.settingsBtn.y + this.settingsBtn.height;
            this.slidingScrList.height = this.listHeight;
            this.expandBg.height = (this.slidingScrList.y + this.listHeight - 1);
            this.mask_mc.y = this.slidingScrList.y;
            this.mask_mc.height = this.listHeight;
            return;
        }

        public function calculateClosedState():void
        {
            this.settingsBtn.y = 0;
            this.slidingScrList.height = this.listHeight;
            this.slidingScrList.y = this.slidingScrList.height * -1 + this.settingsBtn.y + this.settingsBtn.height;
            this.mask_mc.y = this.settingsBtn.y + this.settingsBtn.height;
            this.mask_mc.height = 0;
            return;
        }

        public function setInventory(arg1:Object, arg2:Object):void
        {
            var loc8:*=null;
            var loc1:*=new net.wg.data.VO.SellDialogItem();
            var loc2:*=0;
            var loc3:*;
            (loc3 = new net.wg.data.VO.SellDialogElement()).inInventory = true;
            var loc4:*=0;
            var loc5:*=0;
            while (loc5 < arg1.length) 
            {
                loc2 = loc2 + arg1[loc5][0].sellPrice[0] * arg1[loc5][0].inventoryCount;
                loc4 = loc4 + arg1[loc5][0].inventoryCount;
                if (arg1[loc5][1]) 
                    loc3.inInventory = true;
                ++loc5;
            }
            var loc6:*=App.utils.locale;
            if (arg1.length > 0) 
            {
                loc3.moneyValue = loc2;
                loc3.id = loc6.makeString(DIALOGS.VEHICLESELLDIALOG_NOTINSTALLED_MODULES) + " (" + loc4 + " " + loc6.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                loc3.isRemovable = true;
                loc3.type = "modules";
                loc3.data = arg1;
                loc1.elements.push(loc3);
            }
            var loc7:*=0;
            while (loc7 < arg2.length) 
            {
                if (arg2[loc7][0] != undefined) 
                    if (arg2[loc7][0].inventoryCount != 0) 
                    {
                        (loc8 = new net.wg.data.VO.SellDialogElement()).id = arg2[loc7][0].userName + " (" + arg2[loc7][0].inventoryCount + " " + loc6.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                        loc8.isRemovable = true;
                        loc8.data = arg2[loc7][0];
                        loc8.type = "invShells";
                        if (arg2[loc7][0].buyPrice[1] > 0 || arg2[loc7][1]) 
                            loc8.inInventory = true;
                        else 
                            loc8.inInventory = false;
                        loc8.moneyValue = arg2[loc7][0].sellPrice[0] * arg2[loc7][0].inventoryCount;
                        loc1.elements.push(loc8);
                    }
                ++loc7;
            }
            if (loc1.elements.length != 0) 
            {
                loc1.header = DIALOGS.VEHICLESELLDIALOG_INVENTORY;
                this.sellData.push(loc1);
            }
            this.slidingScrList.dataProvider = new scaleform.clik.data.DataProvider(this.sellData);
            return;
        }

        internal function updateElements():void
        {
            this.preInitStates();
            if (this.isOpened) 
            {
                this.calculateOpenedState();
                this.mask_mc.visible = true;
                this.slidingScrList.visible = true;
                this.settingsBtn.creditsIT.alpha = 0;
                this.settingsBtn.ddLine.alpha = 1;
            }
            else 
            {
                this.calculateClosedState();
                this.mask_mc.visible = false;
                this.slidingScrList.visible = false;
                this.settingsBtn.creditsIT.alpha = 1;
                this.settingsBtn.ddLine.alpha = 0;
            }
            return;
        }

        public function preInitStates():void
        {
            this.resultExpand = (this.settingsBtn.height + this.listHeight - 1) - this.expandBg.height;
            return;
        }

        internal static const PADDING_FOR_NEXT_ELEMENT:uint=10;

        public var settingsBtn:net.wg.gui.lobby.sellDialog.SettingsButton;

        public var mask_mc:flash.display.MovieClip;

        public var slidingScrList:net.wg.gui.lobby.sellDialog.SlidingScrollingList;

        public var expandBg:flash.display.MovieClip;

        public var sellData:Array;

        public var resultExpand:int=0;

        internal var _isOpened:Boolean=false;

        internal var listHeight:int=0;
    }
}
