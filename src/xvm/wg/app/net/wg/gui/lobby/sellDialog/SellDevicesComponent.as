package net.wg.gui.lobby.sellDialog 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.data.VO.*;
    import scaleform.clik.core.*;
    
    public class SellDevicesComponent extends scaleform.clik.core.UIComponent
    {
        public function SellDevicesComponent()
        {
            this._sellData = [];
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.complexDevice.dispose();
            this.complexDevicesArr.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.complexDevice.scrollingRenderrBg.visible = false;
            return;
        }

        public function get removePrice():Number
        {
            return this._removePrice;
        }

        public function set removePrice(arg1:Number):void
        {
            this._removePrice = arg1;
            return;
        }

        public function get sellData():Array
        {
            return this._sellData;
        }

        public function setData(arg1:Object):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            this.complexDevicesArr = new net.wg.data.VO.SellDialogItem();
            var loc1:*=new net.wg.data.VO.SellDialogItem();
            var loc2:*=0;
            while (loc2 < arg1.optDevices.length) 
            {
                if (arg1.optDevices[loc2] != undefined) 
                {
                    (loc3 = new net.wg.data.VO.SellDialogElement()).id = arg1.optDevices[loc2].userName;
                    loc3.type = "optDevices";
                    loc3.data = arg1.optDevices[loc2];
                    loc3.moneyValue = arg1.optDevices[loc2].sellPrice[0];
                    if (arg1.optDevices[loc2].isRemovable) 
                    {
                        loc3.isRemovable = true;
                        loc3.inInventory = true;
                        loc1.elements.push(loc3);
                    }
                    else 
                    {
                        loc3.removePrice = this._removePrice;
                        loc3.isRemovable = false;
                        loc3.inInventory = true;
                        this.complexDevicesArr.elements.push(loc3);
                    }
                }
                ++loc2;
            }
            if (loc1.elements.length != 0) 
            {
                loc1.header = DIALOGS.VEHICLESELLDIALOG_OPTIONALDEVICE;
                this._sellData.push(loc1);
            }
            if (this.complexDevicesArr.elements.length == 0) 
            {
                this.complexDevice.visible = false;
                this.complDevBg.visible = false;
                visible = false;
            }
            else 
            {
                this.complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_COMPLEXOPTIONALDEVICE;
                this.complexDevice.setData(this.complexDevicesArr);
                this.complexDevice.visible = true;
                this.complDevBg.visible = true;
                this.complexDevice.validateNow();
                this.complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_COMPLEXOPTIONALDEVICE;
                loc4 = 14;
                this.devHeight = this.complexDevice.height + loc4;
                this.complexDevice.setSize(477, this.complexDevice.height);
            }
            return;
        }

        public function get deviceItemRenderer():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.ISaleItemBlockRenderer>
        {
            return this.complexDevice.getRenderers();
        }

        public function getNextPosition():int
        {
            return this.complexDevice.y + this.complexDevice.height + PADDING_FOR_NEXT_ELEMENT;
        }

        internal static const PADDING_FOR_NEXT_ELEMENT:uint=5;

        public var complexDevice:net.wg.gui.lobby.sellDialog.SellDialogListItemRenderer;

        public var complDevBg:flash.display.MovieClip;

        internal var devHeight:Number=0;

        internal var complexDevicesArr:net.wg.data.VO.SellDialogItem;

        internal var _removePrice:Number=0;

        internal var _sellData:Array;
    }
}
