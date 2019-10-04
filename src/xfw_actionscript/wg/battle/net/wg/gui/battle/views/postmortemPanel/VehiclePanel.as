package net.wg.gui.battle.views.postmortemPanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.DisplayObject;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import flash.text.TextFieldAutoSize;

    public class VehiclePanel extends Sprite implements IDisposable
    {

        private static const DELTA_X_LEVEL_ICON:int = -10;

        private static const DELTA_X_LEVEL_TYPE:Number = 20;

        private static const DELTA_X_LEVEL_NAME:Number = 75;

        public var bgMC:BattleAtlasSprite = null;

        public var bgMCLarge:BattleAtlasSprite = null;

        public var levelTF:TextField = null;

        public var nameTF:TextField = null;

        public var typeMC:UILoaderAlt = null;

        public var iconMC:UILoaderAlt = null;

        public function VehiclePanel()
        {
            super();
            this.bgMC.imageName = BATTLEATLAS.POSTMORTEM_PANEL_BG;
            this.bgMCLarge.imageName = BATTLEATLAS.POSTMORTEM_PANEL_BG_LARGE;
            this.nameTF.autoSize = TextFieldAutoSize.LEFT;
            this.levelTF.autoSize = TextFieldAutoSize.LEFT;
        }

        public final function dispose() : void
        {
            this.bgMC = null;
            this.bgMCLarge = null;
            this.levelTF = null;
            this.nameTF = null;
            this.typeMC.dispose();
            this.typeMC = null;
            this.iconMC.dispose();
            this.iconMC = null;
        }

        public function setVehicleData(param1:String, param2:String, param3:String, param4:String) : void
        {
            var _loc5_:* = 0;
            this.iconMC.source = param2;
            this.typeMC.source = param3;
            if(this.nameTF.text != param4)
            {
                this.nameTF.text = param4;
            }
            if(this.levelTF.text != param1)
            {
                this.levelTF.text = param1;
            }
            _loc5_ = this.levelTF.width + DELTA_X_LEVEL_NAME + this.nameTF.width;
            this.bgMC.visible = false;
            this.bgMCLarge.visible = false;
            var _loc6_:DisplayObject = this.bgMC;
            if(_loc5_ >= this.bgMC.width)
            {
                _loc6_ = this.bgMCLarge;
            }
            _loc6_.visible = true;
            this.levelTF.x = this.bgMC.width - _loc5_ >> 1;
            var _loc7_:* = this.levelTF.x + this.levelTF.width ^ 0;
            this.iconMC.x = _loc7_ + DELTA_X_LEVEL_ICON;
            this.typeMC.x = _loc7_ + DELTA_X_LEVEL_TYPE;
            this.nameTF.x = _loc7_ + DELTA_X_LEVEL_NAME;
        }
    }
}
