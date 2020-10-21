package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.utils.ICommons;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;

    public class TankStatusHeader extends Sprite implements IDisposable
    {

        private static const OFFSET:uint = 5;

        public var statusTF:TextField = null;

        public var nameTF:TextField = null;

        public var timeTF:TextField = null;

        private var _commons:ICommons;

        public function TankStatusHeader()
        {
            this._commons = App.utils.commons;
            super();
        }

        public function setData(param1:ResultDataVO) : void
        {
            this.statusTF.text = param1.deathReason == -1?EVENT.RESULTSCREEN_ALIVE:EVENT.RESULTSCREEN_DEAD;
            this.nameTF.text = param1.tankName;
            this.timeTF.text = param1.time;
            this._commons.updateTextFieldSize(this.statusTF,true,false);
            this._commons.updateTextFieldSize(this.nameTF,true,false);
            this.statusTF.x = -this.statusTF.width >> 0;
            this.nameTF.x = this.statusTF.x - this.nameTF.width - OFFSET >> 0;
        }

        public final function dispose() : void
        {
            this.statusTF = null;
            this.nameTF = null;
            this.timeTF = null;
            this._commons = null;
        }
    }
}
