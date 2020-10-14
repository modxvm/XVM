package net.wg.gui.battle.views.postmortemPanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import flash.text.TextFieldAutoSize;

    public class VehiclePanel extends Sprite implements IDisposable
    {

        private static const HORIZONTAL_MARGIN:int = 12;

        private static const ELEMENTS_GAP:int = 7;

        public var bgMC:BattleAtlasSprite = null;

        public var levelTF:TextField = null;

        public var typeMC:UILoaderAlt = null;

        public var nameTF:TextField = null;

        public function VehiclePanel()
        {
            super();
            this.bgMC.imageName = BATTLEATLAS.POSTMORTEM_VEHICLE_PANEL_BG;
            this.levelTF.autoSize = TextFieldAutoSize.LEFT;
            this.nameTF.autoSize = TextFieldAutoSize.LEFT;
        }

        public final function dispose() : void
        {
            this.bgMC = null;
            this.levelTF = null;
            this.nameTF = null;
            this.typeMC.dispose();
            this.typeMC = null;
        }

        public function setVehicleData(param1:String, param2:String, param3:String) : void
        {
            this.typeMC.source = param2;
            this.nameTF.text = param3;
            this.levelTF.text = param1;
            this.adjustPositions();
        }

        private function adjustPositions() : void
        {
            this.levelTF.x = HORIZONTAL_MARGIN;
            this.typeMC.x = this.levelTF.x + this.levelTF.width + ELEMENTS_GAP;
            this.nameTF.x = this.typeMC.x + this.typeMC.originalWidth + ELEMENTS_GAP;
            this.bgMC.width = this.nameTF.x + this.nameTF.width + HORIZONTAL_MARGIN;
        }
    }
}
