/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui
{
    import flash.display.*;

    import com.xvm.lobby.ui.battleresults.*;
    UI_BattleResultsAwards;
    UI_BR_SubtaskComponent;
    UI_CommonStats;
    UI_ProgressElement;

    // temporarily disable limits functionality for WG
    CLIENT::LESTA {
        import com.xvm.lobby.ui.limits.*;
        LimitsUIImpl;
    }

    // TODO
    //import com.xvm.lobby.ui.squad.*;
    //UI_SquadItemRenderer;

    CLIENT::LESTA {
        import com.xvm.lobby.ui.tankcarousel.*;
        UI_MultiselectionSlotRenderer;
        UI_MultiselectionSlots;
        UI_SmallTankCarouselItemRenderer;
        UI_TankCarousel;
        UI_TankCarouselItemRenderer;
    }

    import com.xvm.lobby.ui.techtree.*;
    UI_NationTreeNodeSkinned;

    public class LobbyUIMod extends Sprite
    {
    }
}
