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
import net.wg.data.daapi.base.*; DAAPIDataClass;
import net.wg.gui.components.common.*; MainViewContainer;
import net.wg.gui.components.controls.ReadOnlyScrollingList; ReadOnlyScrollingList;
import net.wg.gui.intro.*; IntroPage;
import net.wg.gui.login.impl.*; LoginPage;
import net.wg.gui.lobby.*; LobbyPage;
import net.wg.gui.lobby.dialogs.*; SimpleDialog;
//TODO: 0.9.3 import net.wg.gui.lobby.header.*; TutorialControl;
import net.wg.gui.lobby.hangar.*; Hangar; TankParam;
import net.wg.gui.lobby.hangar.crew.*; Crew; RecruitRendererVO; CrewItemRenderer;
import net.wg.gui.lobby.battleloading.*; BattleLoading; PlayerItemRenderer;
import net.wg.gui.lobby.battleResults.*; BattleResults; CommonStats; ProgressElement;
import net.wg.gui.lobby.profile.*; Profile;
import net.wg.gui.lobby.profile.components.*; UserDateFooter; ProfileDashLineTextItem;
import net.wg.gui.lobby.profile.pages.awards.*; ProfileAwards;
import net.wg.gui.lobby.profile.pages.summary.*; ProfileSummaryPage; ProfileSummaryWindow;
import net.wg.gui.lobby.profile.pages.technique.*; ProfileTechniquePage; ProfileTechniqueWindow;
import net.wg.gui.lobby.techtree.*; TechTreePage; ResearchPage;
import net.wg.gui.lobby.window.*; ProfileWindow;
import net.wg.gui.messenger.controls.*; MemberItemRenderer;
import net.wg.gui.notification.*; NotificationListView;
import net.wg.gui.prebattle.company.*; CompaniesListWindow; CompanyWindow;
import net.wg.gui.prebattle.squad.*; SquadWindow; MessengerUtils;
import net.wg.infrastructure.base.*; BaseViewWrapper;
import net.wg.infrastructure.events.*; LoaderEvent; LifeCycleEvent;
import net.wg.infrastructure.managers.impl.*; ContainerManager;

/**
 * UIs
 */

// battleLoading.swf
LeftItemRendererUI;
RightItemRendererUI;

// battleResults.swf
BR_SubtaskComponent_UI;
ProgressElement_UI;
BattleResultsAwards_UI;

// companiesWindow.swf
CompanyListItemRendererUI;
CompanyDropItemRendererUI;

// controls.swf
//ButtonBlack; ButtonCaps; ButtonCapsRed; ButtonIcon; ButtonIconText; ButtonNormal; ButtonRed;
//CheckBox; CheckBoxFilter; CheckBoxTankers; IconText; LabelControl; NumericStepper;
//RadioButton; RedButton; Slider; TextFieldShort; TextInput; UILoaderAlt; UILoaderCut;
ListItemRedererImageText; DropDownImageText;

// nodesLib.swf
NationTreeNodeSkinned;
ResearchItemNode;

// prebattleComponents.swf
TeamMemberRendererUI;

// profileTechnique.swf
TechniqueRenderer_UI;
TechniqueStatisticTab_UI;

// serviceMessageComponents.swf
ServiceMessageIR_UI;
ServiceMessagePopUp_UI;

// squadWindow.swf
squadItemRendererUI;

// TankCarousel.swf
TankCarouselUI;
TankCarouselItemRendererUI;

}

}
