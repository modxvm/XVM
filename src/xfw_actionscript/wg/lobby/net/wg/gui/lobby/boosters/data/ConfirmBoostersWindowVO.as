package net.wg.gui.lobby.boosters.data
{
    import net.wg.gui.lobby.window.ConfirmItemWindowVO;
    import net.wg.gui.lobby.components.data.BoosterSlotVO;

    public class ConfirmBoostersWindowVO extends ConfirmItemWindowVO
    {

        private static const BOOSTER_DATA:String = "boosterData";

        public var boosterData:BoosterSlotVO;

        public function ConfirmBoostersWindowVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == BOOSTER_DATA && param2 != null)
            {
                this.boosterData = new BoosterSlotVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.boosterData != null)
            {
                this.boosterData.dispose();
                this.boosterData = null;
            }
            super.onDispose();
        }
    }
}
