package net.wg.gui.lobby.window 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class ExchangeXPFromVehicleIR extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function ExchangeXPFromVehicleIR()
        {
            super();
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            _toggle = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(focusIndicator.name, focusIndicator, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.background.name, this.background, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.xpLabel.name, this.xpLabel, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.mcGreyAssets.name, this.mcGreyAssets, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.checkboxVehicle.name, this.checkboxVehicle, scaleform.clik.utils.Constraints.CENTER_V);
            this.vehicleNation.addEventListener(net.wg.gui.events.UILoaderEvent.IOERROR, this.nationIconLoadingError, false, 0, true);
            setState("up");
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRelease(arg1);
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.buttonIdx : 0;
            if (loc2 == scaleform.gfx.MouseEventEx.LEFT_BUTTON) 
            {
                if (App.utils) 
                {
                    App.utils.asserter.assertNotNull("vehicleData in ExchangeXPFromVehicleIR" + net.wg.data.constants.Errors.CANT_NULL, this.toString());
                }
                this.toggleSelection();
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            var loc1:*=arg1.details;
            if (loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                if (loc1.code == flash.ui.Keyboard.ENTER || loc1.code == flash.ui.Keyboard.SPACE) 
                {
                    this.toggleSelection();
                }
                arg1.handled = true;
            }
            return;
        }

        internal function toggleSelection():void
        {
            this.vehicleData.isSelectCandidate = !this.vehicleData.isSelectCandidate;
            invalidate(this.SELECTION_INVALIDATE);
            dispatchEvent(new flash.events.Event(SELECTION_CHANGED, true));
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            this.vehicleData = net.wg.gui.lobby.window.ExchangeXPVehicleVO(arg1);
            invalidate(this.DATA_INVALIDATE);
            return;
        }

        public override function get data():Object
        {
            return this.vehicleData;
        }

        protected override function draw():void
        {
            if (isInvalid(this.DATA_INVALIDATE)) 
            {
                if (this.vehicleData) 
                {
                    this.xpLabel.text = App.utils ? App.utils.locale.integer(this.vehicleData.xp) : this.vehicleData.xp.toString();
                    this.xpLabel.visible = true;
                    this.checkboxVehicle.visible = true;
                    this.checkboxVehicle.tabEnabled = false;
                    this.vehicleName.visible = true;
                    this.vehicleName.text = this.vehicleData.vehicleName;
                    this.mcGreyAssets.visible = true;
                    this.vehicleIcon.visible = true;
                    this.vehicleIcon.source = this.vehicleData.vehicleIco;
                    buttonMode = true;
                    this.vehicleTypeIcon.source = this.vehicleData.vehicleType;
                    this.vehicleNation.source = this.vehicleData.nationIco;
                    invalidate(this.SELECTION_INVALIDATE);
                }
                else 
                {
                    buttonMode = false;
                    this.xpLabel.visible = false;
                    this.mcGreyAssets.visible = false;
                    this.checkboxVehicle.visible = false;
                    this.vehicleName.visible = false;
                    this.vehicleIcon.visible = false;
                    this.vehicleTypeIcon.source = null;
                    this.vehicleNation.source = null;
                }
            }
            if (isInvalid(this.SELECTION_INVALIDATE)) 
            {
                if (this.vehicleData) 
                {
                    this.checkboxVehicle.selected = this.vehicleData.isSelectCandidate;
                    setState(state);
                }
            }
            super.draw();
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            return this.vehicleData && this.vehicleData.isSelectCandidate ? MY_STATE_PREFIXES : statesDefault;
        }

        internal function nationIconLoadingError(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            var loc1:*="Flash :: Couldn\'t Load Nations Icon, " + avmplus.getQualifiedClassName(this) + ", Row Number = " + index;
            DebugUtils.LOG_ERROR(loc1);
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            constraints.updateElement(focusIndicator.name, focusIndicator);
            constraints.updateElement(this.background.name, this.background);
            constraints.updateElement(this.xpLabel.name, this.xpLabel);
            constraints.updateElement(this.mcGreyAssets.name, this.mcGreyAssets);
            constraints.updateElement(this.checkboxVehicle.name, this.checkboxVehicle);
            return;
        }

        public static const SELECTION_CHANGED:String="IrSelectionChanged";

        internal static const MY_STATE_PREFIXES:__AS3__.vec.Vector.<String>=Vector.<String>(["cbselection_", ""]);

        public var vehicleIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var vehicleTypeIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var checkboxVehicle:net.wg.gui.components.controls.CheckBox;

        public var xpLabel:net.wg.gui.components.controls.IconText;

        public var vehicleName:flash.text.TextField;

        public var vehicleNation:net.wg.gui.components.controls.UILoaderAlt;

        public var background:flash.display.MovieClip;

        public var clickArea:flash.display.MovieClip;

        public var mcGreyAssets:flash.display.MovieClip;

        internal var vehicleData:net.wg.gui.lobby.window.ExchangeXPVehicleVO;

        internal var SELECTION_INVALIDATE:String="selInv";

        internal var DATA_INVALIDATE:String="dataInv";
    }
}
