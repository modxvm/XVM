package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
    import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
    import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;

    public class EventConsumablesPanel extends ConsumablesPanel
    {

        public function EventConsumablesPanel()
        {
            super();
        }

        private static function isAbility(param1:Array) : Boolean
        {
            var _loc4_:String = null;
            var _loc2_:String = BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM;
            var _loc3_:String = BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ALT_ITEM;
            if(param1)
            {
                for each(_loc4_ in param1)
                {
                    if(_loc4_ == _loc2_ || _loc4_ == _loc3_)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        override public function as_addShellSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:String, param7:String, param8:String) : void
        {
            super.as_addShellSlot(param1,param2,param3,param4,param5,param6,param7,param8);
            var _loc9_:BattleShellButton = getRendererBySlotIdx(param1) as BattleShellButton;
            if(_loc9_)
            {
                _loc9_.isQuantityFieldVisible = false;
                _loc9_.isTooltipSpecial = true;
            }
        }

        override protected function addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:String, param8:String, param9:int, param10:int, param11:Array) : void
        {
            super.addEquipmentSlot(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
            var _loc12_:EventBattleEquipmentButton = getRendererBySlotIdx(param1) as EventBattleEquipmentButton;
            if(_loc12_)
            {
                _loc12_.setIsAbility(isAbility(param11));
                _loc12_.setCoolDownTime(param5,param6,param6 - param5,param9);
            }
        }

        override protected function createEquipmentButton() : IConsumablesButton
        {
            return App.utils.classFactory.getComponent(Linkages.EVENT_EQUIPMENT_BUTTON,EventBattleEquipmentButton);
        }

        override protected function createShellButton() : IBattleShellButton
        {
            return App.utils.classFactory.getComponent(Linkages.EVENT_SHELL_BUTTON_BATTLE,EventBattleShellButton);
        }
    }
}
