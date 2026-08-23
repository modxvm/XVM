/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleXvmMod;
    import com.xvm.battle.BattleXvmView;
    import com.xvm.battle.shared.playersPanel.PlayersPanelListItemProxyBase;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    CLIENT::WG {
        import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListItem;
    }
    CLIENT::LESTA {
        import net.wg.gui.battle.ranked.stats.components.playersPanel.list.RankedPlayersPanelListItem;
    }

    public class RankedPlayersPanelListItemProxy extends PlayersPanelListItemProxyBase
    {
        private static const RANK_ICON_AREA_WIDTH:int = 24;
        private static const SQUAD_ICON_AREA_WIDTH:int = 22;

        CLIENT::WG {
            private var ui:PlayersPanelListItem;
        }
        CLIENT::LESTA {
            private var ui:RankedPlayersPanelListItem;
        }

        private var mopt_removeRankIcon:Boolean;
        private var mopt_removeSquadIcon:Boolean;

        public function RankedPlayersPanelListItemProxy(ui:*, isLeftPanel:Boolean)
        {
            super(ui, isLeftPanel);
            this.ui = ui;
        }

        override protected function fix_state(state:int):int
        {
            return UI_RankedPlayersPanel.fix_state(state);
        }

        override protected function setup():void
        {
            if (isXVMEnabled)
            {
                mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                mopt_removeRankIcon = Macros.FormatBooleanGlobal(mcfg.removeRankIcon);
            }
            else
            {
                ui.rankIcon.alpha = 1;
                CLIENT::LESTA {
                    ui.squadIcon.alpha = 1;
                }
            }
        }

        override protected function applyState():void
        {
            switch (state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    mopt_removeRankIcon = Macros.FormatBooleanGlobal(mcfg.removeRankIcon);
                    mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                    break;
                default:
                    break;
            }
        }

        override protected function updateStandardFields():void
        {
            if (mopt_removeRankIcon)
            {
                ui.rankIcon.alpha = 0;
            }
            else
            {
                ui.rankIcon.alpha = Macros.FormatNumber(mcfg.rankIconAlpha, currentPlayerState, 100) / 100.0;
            }

            CLIENT::LESTA {
                if (mopt_removeSquadIcon)
                {
                    ui.squadIcon.alpha = 0;
                }
                else
                {
                    ui.squadIcon.alpha = Macros.FormatNumber(mcfg.squadIconAlpha, currentPlayerState, 100) / 100.0;
                }
            }
        }

        override protected function updatePositionsLeft(lastX:int):void
        {
            var rankIconWidth:int = mopt_removeRankIcon ? 0 : RANK_ICON_AREA_WIDTH;
            var squadIconWidth:int = 0;
            CLIENT::LESTA {
                squadIconWidth = mopt_removeSquadIcon ? 0 : SQUAD_ICON_AREA_WIDTH;
            }

            ui.x = -(lastX - rankIconWidth - squadIconWidth);
            ui.rankIcon.x = -ui.x + squadIconWidth;
            CLIENT::LESTA {
                ui.squadIcon.x = ui.noSoundIcon.x = -ui.x;
            }
        }

        override protected function updatePositionsRight(lastX:int):void
        {
            var rankIconWidth:int = mopt_removeRankIcon ? 0 : RANK_ICON_AREA_WIDTH;
            var squadIconWidth:int = 0;
            CLIENT::LESTA {
                squadIconWidth = mopt_removeSquadIcon ? 0 : SQUAD_ICON_AREA_WIDTH;
            }

            ui.x = -(lastX + rankIconWidth + squadIconWidth);
            ui.rankIcon.x = -ui.x - rankIconWidth - squadIconWidth;
            CLIENT::LESTA {
                ui.squadIcon.x = ui.noSoundIcon.x = -ui.x + rankIconWidth;
            }
        }

        override protected function createExtraFields():void
        {
            extraFieldsHidden.addEventListener(MouseEvent.MOUSE_MOVE, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseMoveHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OVER, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseRollOverHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OUT, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseRollOutHandler);
            BattleXvmView.battlePage.addChildAt(extraFieldsHidden, BattleXvmMod.battlePageRanked.getChildIndex(BattleXvmMod.battlePageRanked.playersPanel));
        }
    }
}
