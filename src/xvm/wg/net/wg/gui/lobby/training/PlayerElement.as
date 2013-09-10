package net.wg.gui.lobby.training 
{
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class PlayerElement extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.entity.IUpdatable
    {
        public function PlayerElement()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.defColorTrans = this.iconLoader.transform.colorTransform;
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1) 
            {
                this.data = net.wg.data.VO.TrainingRoomRendererVO(arg1);
                invalidate(scaleform.clik.constants.InvalidationType.DATA);
            }
            return;
        }

        public override function dispose():void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.nameField.dispose();
            this.nameField = null;
            this.vehicleField = null;
            this.vehicleLevelField = null;
            this.stateField = null;
            this.data.dispose();
            this.data = null;
            this.defColorTrans = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (this.data) 
                {
                    this.nameField.label = this.data.fullName;
                    this.vehicleField.text = this.data.vShortName;
                    this.stateField.text = this.data.stateString;
                    this.vehicleLevelField.text = this.data.vLevel;
                    this.iconLoader.visible = true;
                    if (this.iconLoader.source != this.data.icon) 
                        this.iconLoader.source = this.data.icon;
                    enabled = true;
                    this.nameField.textColor = NAME_COLOR;
                    this.vehicleField.textColor = VEHICLE_COLOR;
                    loc1 = new flash.geom.ColorTransform();
                    if (enabled) 
                        if (this.data.himself) 
                        {
                            this.nameField.textColor = GOLD_COLOR;
                            this.vehicleField.textColor = GOLD_COLOR;
                            loc1.redOffset = 21;
                            loc1.greenOffset = 9;
                            loc1.blueMultiplier = 0.51;
                            loc1.greenMultiplier = 0.87;
                        }
                        else 
                            loc1 = this.defColorTrans;
                    else 
                    {
                        loc1.alphaMultiplier = 0.7;
                        loc1.redMultiplier = 0.1;
                        loc1.blueMultiplier = 0.1;
                        loc1.greenMultiplier = 0.1;
                    }
                    this.iconLoader.transform.colorTransform = loc1;
                }
                else 
                {
                    this.nameField.label = "";
                    this.vehicleField.text = "";
                    this.vehicleLevelField.text = "";
                    this.iconLoader.visible = false;
                    enabled = false;
                }
            return;
        }

        internal static const GOLD_COLOR:Number=16761699;

        internal static const NAME_COLOR:Number=13224374;

        internal static const VEHICLE_COLOR:Number=8092009;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var nameField:net.wg.gui.components.controls.TextFieldShort;

        public var vehicleField:flash.text.TextField;

        public var vehicleLevelField:flash.text.TextField;

        public var stateField:flash.text.TextField;

        internal var _himself:Boolean=false;

        internal var data:net.wg.data.VO.TrainingRoomRendererVO;

        internal var defColorTrans:flash.geom.ColorTransform;
    }
}
