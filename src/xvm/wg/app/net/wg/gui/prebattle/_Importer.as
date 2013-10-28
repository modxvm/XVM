package net.wg.gui.prebattle
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.prebattle.battleSession.BattleSessionList;
   import net.wg.gui.prebattle.battleSession.BattleSessionListRenderer;
   import net.wg.gui.prebattle.battleSession.BattleSessionWindow;
   import net.wg.gui.prebattle.battleSession.BSListRendererVO;
   import net.wg.gui.prebattle.battleSession.FlagsList;
   import net.wg.gui.prebattle.battleSession.RequirementInfo;
   import net.wg.gui.prebattle.battleSession.TopInfo;
   import net.wg.gui.prebattle.battleSession.TopStats;
   import net.wg.gui.prebattle.company.CompaniesListWindow;
   import net.wg.gui.prebattle.company.CompaniesScrollingList;
   import net.wg.gui.prebattle.company.CompanyDropItemRenderer;
   import net.wg.gui.prebattle.company.CompanyDropList;
   import net.wg.gui.prebattle.company.CompanyEvent;
   import net.wg.gui.prebattle.company.CompanyListItemRenderer;
   import net.wg.gui.prebattle.company.CompanyWindow;
   import net.wg.gui.prebattle.company.GroupPlayersDropDownMenu;
   import net.wg.gui.prebattle.constants.PrebattleStateFlags;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import net.wg.gui.prebattle.controls.TeamMemberRenderer;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.gui.prebattle.invites.InviteStackContainerBase;
   import net.wg.gui.prebattle.invites.NotificationInvitesWindow;
   import net.wg.gui.prebattle.invites.PrbInviteSearchUsersForm;
   import net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator;
   import net.wg.gui.prebattle.invites.PrbSendInvitesWindow;
   import net.wg.gui.prebattle.invites.ReceivedInviteWindow;
   import net.wg.gui.prebattle.invites.SendInvitesEvent;
   import net.wg.gui.prebattle.invites.UserRosterItemRenderer;
   import net.wg.gui.prebattle.invites.UserRosterView;
   import net.wg.gui.prebattle.pages.ChannelWindow;
   import net.wg.gui.prebattle.pages.LazyWindow;
   import net.wg.gui.prebattle.pages.MemberDataProvider;
   import net.wg.gui.prebattle.squad.MessengerUtils;
   import net.wg.gui.prebattle.squad.SquadItemRenderer;
   import net.wg.gui.prebattle.squad.SquadWindow;
   import net.wg.gui.prebattle.squad.SquadWindowCIGenerator;
   import net.wg.gui.prebattle.squad.UserDataFlags;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([BattleSessionList,BattleSessionListRenderer,BattleSessionWindow,BSListRendererVO,FlagsList,RequirementInfo,TopInfo,TopStats,CompaniesListWindow,CompaniesScrollingList,CompaniesListWindow,CompaniesScrollingList,CompanyDropItemRenderer,CompanyDropList,CompanyEvent,CompanyListItemRenderer,CompanyWindow,GroupPlayersDropDownMenu,PrebattleStateFlags,PrebattleStateString,TeamMemberRenderer,PlayerPrbInfoVO,InviteStackContainerBase,NotificationInvitesWindow,PrbInviteSearchUsersForm,PrbSendInviteCIGenerator,PrbSendInvitesWindow,ReceivedInviteWindow,SendInvitesEvent,UserRosterItemRenderer,UserRosterView,ChannelWindow,LazyWindow,MemberDataProvider,MessengerUtils,SquadItemRenderer,SquadWindow,SquadWindowCIGenerator,UserDataFlags]));
      }
   }

}