package net.wg.gui.bootcamp.battleResult.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.battleResult.data.PlayerVehicleVO;

    public class TankLabel extends Sprite implements IDisposable
    {

        public var loader:UILoaderAlt = null;

        public var textField:TextField = null;

        public function TankLabel()
        {
            super();
        }

        public final function dispose() : void
        {
            this.textField = null;
            this.loader.dispose();
            this.loader = null;
        }

        public function setData(param1:PlayerVehicleVO) : void
        {
            this.loader.source = param1.typeIcon;
            this.textField.text = param1.name;
            App.utils.commons.updateTextFieldSize(this.textField);
        }
    }
}
