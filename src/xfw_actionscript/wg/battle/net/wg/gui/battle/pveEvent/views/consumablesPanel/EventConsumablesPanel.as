package net.wg.gui.battle.pveEvent.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
    import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventConsumablesPanel extends ConsumablesPanel
    {

        private static const DIVIDER_OFFSET:int = 10;

        private static const CAT_AMMO:int = 0;

        private static const CAT_CONSUMABLE:int = 1;

        private static const CAT_SKILL:int = 2;

        public function EventConsumablesPanel()
        {
            super();
        }

        override protected function createEquipmentButton() : IConsumablesButton
        {
            return App.utils.classFactory.getComponent(Linkages.EVENT_EQUIPMENT_BUTTON,EventBattleEquipmentButton);
        }

        override protected function createShellButton() : IBattleShellButton
        {
            return App.utils.classFactory.getComponent(Linkages.EVENT_SHELL_BUTTON_BATTLE,BattleShellButton);
        }

        override protected function drawLayout() : void
        {
            var _loc3_:IConsumablesButton = null;
            var _loc1_:int = slotIdxMap.length;
            var _loc2_:* = 0;
            var _loc4_:int = itemsPadding;
            var _loc5_:* = false;
            var _loc6_:int = Values.DEFAULT_INT;
            var _loc7_:int = Values.DEFAULT_INT;
            var _loc8_:uint = 0;
            while(_loc8_ < _loc1_)
            {
                if(slotIdxMap[_loc8_] >= 0)
                {
                    _loc3_ = getRendererBySlotIdx(_loc8_);
                    if(_loc3_)
                    {
                        _loc7_ = this.getSlotCat(_loc3_.consumablesVO.tag);
                        if(_loc3_.visible)
                        {
                            if(_loc6_ != _loc7_)
                            {
                                if(!_loc5_)
                                {
                                    _loc5_ = true;
                                }
                                else
                                {
                                    _loc2_ = _loc2_ + DIVIDER_OFFSET;
                                }
                            }
                            _loc3_.x = _loc2_;
                            _loc2_ = _loc2_ + _loc4_;
                        }
                        _loc6_ = _loc7_;
                    }
                }
                _loc8_++;
            }
            basePanelWidth = _loc2_;
        }

        private function getSlotCat(param1:String) : int
        {
            if(param1 == BATTLE_CONSUMABLES_PANEL_TAGS.TRIGGER || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ABILITY || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.REPAIR_AND_CREW_HEAL || param1 == BATTLE_CONSUMABLES_PANEL_TAGS.INSTANT_RELOAD)
            {
                return CAT_SKILL;
            }
            if(StringUtils.isEmpty(param1))
            {
                return CAT_AMMO;
            }
            return CAT_CONSUMABLE;
        }
    }
}
