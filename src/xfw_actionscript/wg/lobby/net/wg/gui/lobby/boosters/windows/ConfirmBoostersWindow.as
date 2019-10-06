package net.wg.gui.lobby.boosters.windows
{
    import net.wg.gui.lobby.window.ConfirmItemWindow;
    import net.wg.gui.lobby.window.ConfirmItemWindowVO;
    import net.wg.gui.lobby.boosters.data.ConfirmBoostersWindowVO;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.components.data.BoosterSlotVO;
    import net.wg.gui.lobby.components.BoosterSlot;

    public class ConfirmBoostersWindow extends ConfirmItemWindow
    {

        public function ConfirmBoostersWindow()
        {
            super();
        }

        override protected function getConfirmItemWindowVOForValue(param1:Object) : ConfirmItemWindowVO
        {
            return new ConfirmBoostersWindowVO(param1);
        }

        override protected function onDispose() : void
        {
            data = null;
            super.onDispose();
        }

        override protected function setData(param1:ConfirmItemWindowVO) : void
        {
            data = param1;
            invalidateData();
        }

        override protected function applyData() : void
        {
            var _loc1_:ConfirmBoostersWindowVO = ConfirmBoostersWindowVO(data);
            App.utils.asserter.assertNotNull(_loc1_.boosterData,"boosterData" + Errors.CANT_NULL);
            var _loc2_:BoosterSlotVO = _loc1_.boosterData;
            var _loc3_:BoosterSlot = App.utils.classFactory.getComponent(_loc1_.linkage,BoosterSlot);
            _loc3_.update(_loc2_);
            _loc3_.id = _loc2_.id;
            _loc3_.icon = _loc2_.icon;
            _loc3_.isInactive = _loc2_.isInactive;
            _loc3_.enabled = false;
            content.setIcon(_loc3_);
            super.applyData();
        }
    }
}
