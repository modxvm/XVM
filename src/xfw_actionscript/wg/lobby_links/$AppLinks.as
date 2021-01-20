package
{

internal class $AppLinks
{

/**
 *  @private
 *  This class is used to link additional classes into wg.swc
 *  beyond those that are found by dependecy analysis starting
 *  from the classes specified in manifest.xml.
 */

import net.wg.app.iml.base.AbstractApplication; AbstractApplication;
import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS; PROFILE_DROPDOWN_KEYS;
import net.wg.infrastructure.base.AbstractView; AbstractView;
import net.wg.infrastructure.events.LibraryLoaderEvent; LibraryLoaderEvent;
import net.wg.infrastructure.events.LoaderEvent; LoaderEvent;
import net.wg.infrastructure.managers.impl.ContainerManagerBase; ContainerManagerBase;
import net.wg.gui.components.containers.MainViewContainer; MainViewContainer;
import net.wg.gui.lobby.LobbyPage; LobbyPage;
import net.wg.gui.lobby.battleResults.BattleResults; BattleResults;
import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer; EfficiencyIconRenderer;
import net.wg.gui.lobby.hangar.Hangar; Hangar;
import net.wg.gui.lobby.hangar.crew.CrewItemRenderer; CrewItemRenderer;
import net.wg.gui.lobby.hangar.tcarousel.SmallTankIcon; SmallTankIcon;
import net.wg.gui.lobby.hangar.tcarousel.TankIcon; TankIcon;
import net.wg.gui.lobby.header.headerButtonBar.HBC_BattleSelector; HBC_BattleSelector;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Finance; HBC_Finance;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Squad; HBC_Squad;
import net.wg.gui.lobby.profile.Profile; Profile;
import net.wg.gui.lobby.techtree.ResearchPage; ResearchPage;
import net.wg.gui.lobby.techtree.TechTreePage; TechTreePage;
import net.wg.gui.lobby.window.ProfileWindow; ProfileWindow;
import net.wg.gui.login.impl.LoginPage; LoginPage;
import net.wg.gui.messenger.ContactsListPopover; ContactsListPopover;
// TODO: 1.11.1-CT
//import net.wg.gui.prebattle.squads.SquadWindow; SquadWindow;

/**
 * UIs
 */

// commonStats.swf
BattleResultsAwards_UI;
BR_SubtaskComponent_UI;
CommonStats;
ProgressElement_UI;

// contactsTreeComponents.swf
ContactsTreeItemRendererUI;

// contactsListPopover.swf
ContactNoteManageViewUI;

// crew.swf
CrewItemRendererUI;
CrewItemRendererSmallUI;

// guiControlsLobby.swf
CheckBoxTankers;
ProfileSortingButton_UI;
SmallSkillsListUI;
TextAreaSimple;

// guiControlsLobbyBattle.swf
LabelControl;

// messengerControls.swf
ContactItemUI;

// nodesLib.swf
NationTreeNodeSkinned;
ResearchItemNode;

// prebattleComponents.swf
TeamMemberRendererUI;

// profileTechnique.swf
ProfileTechniquePage_UI;
ProfileTechniqueWindow_UI;
//SortableButtonBar_UI;
TechniqueRenderer_UI;
TechniqueStatisticTab_UI;

// statisticsComponents.swf
StatisticsDashLineTextItemIRenderer_UI;

// TankCarousel.swf
MultiselectionSlotRendererUI;
MultiselectionSlotsUI;
SmallTankCarouselItemRendererUI;
TankCarouselItemRendererUI;
TankCarouselUI;

}

}
