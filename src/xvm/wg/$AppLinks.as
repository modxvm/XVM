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
import org.idmedia.as3commons.util.*; StringUtils;
import net.wg.infrastructure.events.*; LoaderEvent; LifeCycleEvent;
import net.wg.infrastructure.managers.impl.*; ContainerManager;
import net.wg.gui.components.common.*; MainViewContainer;
import net.wg.gui.components.controls.*; ReadOnlyScrollingList;
import net.wg.gui.login.impl.*; LoginPage;
import net.wg.gui.lobby.*; LobbyPage;
import net.wg.gui.lobby.header.*; TutorialControl;
import net.wg.gui.lobby.hangar.*; Hangar;
import net.wg.gui.lobby.hangar.crew.*; Crew; RecruitRendererVO; CrewItemRenderer;
import net.wg.gui.lobby.battleloading.*; BattleLoading; PlayerItemRenderer;
import net.wg.gui.messenger.controls.*; MemberItemRenderer;
import net.wg.gui.prebattle.company.*; CompaniesListWindow; CompanyWindow;
import net.wg.gui.prebattle.squad.*; SquadWindow;

// UIs

// battleLoading.swf
LeftItemRendererUI; RightItemRendererUI;

// companiesWindow.swf
CompanyListItemRendererUI;

// squadWindow.swf
squadItemRendererUI;

}

}
