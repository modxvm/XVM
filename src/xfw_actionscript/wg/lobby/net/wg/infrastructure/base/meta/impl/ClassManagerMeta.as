package net.wg.infrastructure.base.meta.impl
{
    import net.wg.data.ContainerConstants;
    import net.wg.data.InspectableDataProvider;
    import net.wg.data.SortableVoDAAPIDataProvider;
    import net.wg.data.VoDAAPIDataProvider;
    import net.wg.data.components.StoreMenuViewData;
    import net.wg.data.components.UserContextItem;
    import net.wg.data.components.VehicleContextMenuGenerator;
    import net.wg.data.constants.ArenaBonusTypes;
    import net.wg.data.constants.Dialogs;
    import net.wg.data.constants.Directions;
    import net.wg.data.constants.GunTypes;
    import net.wg.data.constants.ItemTypes;
    import net.wg.data.constants.LobbyShared;
    import net.wg.data.constants.Nations;
    import net.wg.data.constants.ProgressIndicatorStates;
    import net.wg.data.constants.QuestsStates;
    import net.wg.data.constants.RolesState;
    import net.wg.data.constants.UnitRole;
    import net.wg.data.constants.ValObject;
    import net.wg.data.constants.VehicleState;
    import net.wg.data.constants.VehicleTypes;
    import net.wg.data.constants.generated.ACHIEVEMENTS_ALIASES;
    import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
    import net.wg.data.constants.generated.AWARDWINDOW_CONSTANTS;
    import net.wg.data.constants.generated.BARRACKS_CONSTANTS;
    import net.wg.data.constants.generated.BATTLE_RESULTS_PREMIUM_STATES;
    import net.wg.data.constants.generated.BATTLE_RESULT_TYPES;
    import net.wg.data.constants.generated.BOOSTER_CONSTANTS;
    import net.wg.data.constants.generated.BOOTCAMP_BATTLE_RESULT_CONSTANTS;
    import net.wg.data.constants.generated.BOOTCAMP_HANGAR_ALIASES;
    import net.wg.data.constants.generated.BOOTCAMP_MESSAGE_ALIASES;
    import net.wg.data.constants.generated.BROWSER_CONSTANTS;
    import net.wg.data.constants.generated.CLANS_ALIASES;
    import net.wg.data.constants.generated.CONFIRM_DIALOG_ALIASES;
    import net.wg.data.constants.generated.CONFIRM_EXCHANGE_DIALOG_TYPES;
    import net.wg.data.constants.generated.CONTACTS_ALIASES;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    import net.wg.data.constants.generated.EPICBATTLES_ALIASES;
    import net.wg.data.constants.generated.EVENTBOARDS_ALIASES;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.data.constants.generated.GRAPHICS_OPTIMIZATION_ALIASES;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.data.constants.generated.HANGAR_HEADER_QUESTS;
    import net.wg.data.constants.generated.LINKEDSET_ALIASES;
    import net.wg.data.constants.generated.MANUAL_TEMPLATES;
    import net.wg.data.constants.generated.MENU_CONSTANTS;
    import net.wg.data.constants.generated.MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;
    import net.wg.data.constants.generated.MISSIONS_ALIASES;
    import net.wg.data.constants.generated.MISSIONS_CONSTANTS;
    import net.wg.data.constants.generated.NODE_STATE_FLAGS;
    import net.wg.data.constants.generated.NOTIFICATIONS_CONSTANTS;
    import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
    import net.wg.data.constants.generated.PERSONAL_MISSIONS_BUTTONS;
    import net.wg.data.constants.generated.PREBATTLE_ALIASES;
    import net.wg.data.constants.generated.PROFILE_CONSTANTS;
    import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
    import net.wg.data.constants.generated.PROGRESSIVEREWARD_CONSTANTS;
    import net.wg.data.constants.generated.QUESTS_ALIASES;
    import net.wg.data.constants.generated.QUEST_AWARD_BLOCK_ALIASES;
    import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
    import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
    import net.wg.data.constants.generated.SESSION_STATS_CONSTANTS;
    import net.wg.data.constants.generated.SHOP20_ALIASES;
    import net.wg.data.constants.generated.SKILLS_CONSTANTS;
    import net.wg.data.constants.generated.SLOT_HIGHLIGHT_TYPES;
    import net.wg.data.constants.generated.SQUADTYPES;
    import net.wg.data.constants.generated.STORAGE_CONSTANTS;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.data.constants.generated.STORE_TYPES;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.data.constants.generated.TWEEN_EFFECT_TYPES;
    import net.wg.data.constants.generated.VEHICLE_BUY_WINDOW_ALIASES;
    import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
    import net.wg.data.constants.generated.VEHICLE_SELECTOR_CONSTANTS;
    import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
    import net.wg.data.generated.models.DemoSubModel;
    import net.wg.data.generated.models.DemoViewModel;
    import net.wg.data.generated.models.TestViewModel;
    import net.wg.data.generated.models.TextViewModel;
    import net.wg.data.generated.views.DemoViewBase;
    import net.wg.data.generated.views.TestViewBase;
    import net.wg.data.managers.impl.DialogDispatcher;
    import net.wg.data.managers.impl.NotifyProperties;
    import net.wg.data.utilData.ItemPrice;
    import net.wg.data.utilData.TankmanRoleLevel;
    import net.wg.data.VO.AnimationObject;
    import net.wg.data.VO.AwardsItemVO;
    import net.wg.data.VO.BattleResultsQuestVO;
    import net.wg.data.VO.ButtonPropertiesVO;
    import net.wg.data.VO.ConfirmDialogVO;
    import net.wg.data.VO.ConfirmExchangeBlockVO;
    import net.wg.data.VO.ConfirmExchangeDialogVO;
    import net.wg.data.VO.DialogSettingsVO;
    import net.wg.data.VO.EpicBattleTrainingRoomTeamVO;
    import net.wg.data.VO.ExtendedUserVO;
    import net.wg.data.VO.ILditInfo;
    import net.wg.data.VO.PointVO;
    import net.wg.data.VO.ProgressElementVO;
    import net.wg.data.VO.SellDialogElement;
    import net.wg.data.VO.SellDialogItem;
    import net.wg.data.VO.ShopNationFilterDataVo;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.data.VO.ShopVehicleFilterElementData;
    import net.wg.data.VO.StoreTableData;
    import net.wg.data.VO.StoreTableVO;
    import net.wg.data.VO.TankmanAchievementVO;
    import net.wg.data.VO.TankmanCardVO;
    import net.wg.data.VO.TrainingFormInfoVO;
    import net.wg.data.VO.TrainingFormRendererVO;
    import net.wg.data.VO.TrainingFormVO;
    import net.wg.data.VO.TrainingRoomInfoVO;
    import net.wg.data.VO.TrainingRoomListVO;
    import net.wg.data.VO.TrainingRoomRendererVO;
    import net.wg.data.VO.TrainingRoomTeamBaseVO;
    import net.wg.data.VO.TrainingRoomTeamVO;
    import net.wg.data.VO.TrainingWindowVO;
    import net.wg.data.VO.WalletStatusVO;
    import net.wg.gui.bootcamp.BCHighlightsOverlay;
    import net.wg.gui.bootcamp.BCOutroVideoPage;
    import net.wg.gui.bootcamp.BCOutroVideoVO;
    import net.wg.gui.bootcamp.BCTooltipsWindow;
    import net.wg.gui.bootcamp.battleResult.BCBattleResult;
    import net.wg.gui.bootcamp.battleResult.containers.AnimationContainer;
    import net.wg.gui.bootcamp.battleResult.containers.BattleItemRendererBase;
    import net.wg.gui.bootcamp.battleResult.containers.BattleMedalRenderer;
    import net.wg.gui.bootcamp.battleResult.containers.BattleResultGroupLayout;
    import net.wg.gui.bootcamp.battleResult.containers.BattleResultsGroup;
    import net.wg.gui.bootcamp.battleResult.containers.BattleStatRenderer;
    import net.wg.gui.bootcamp.battleResult.containers.BottomContainer;
    import net.wg.gui.bootcamp.battleResult.containers.RewardStatContainer;
    import net.wg.gui.bootcamp.battleResult.containers.RewardStatsContainer;
    import net.wg.gui.bootcamp.battleResult.containers.StatRendererContent;
    import net.wg.gui.bootcamp.battleResult.containers.TankLabel;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;
    import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
    import net.wg.gui.bootcamp.battleResult.data.PlayerVehicleVO;
    import net.wg.gui.bootcamp.battleResult.data.RewardDataVO;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
    import net.wg.gui.bootcamp.battleResult.views.BattleStatsView;
    import net.wg.gui.bootcamp.constants.BOOTCAMP_DISPLAY;
    import net.wg.gui.bootcamp.controls.LoaderContainer;
    import net.wg.gui.bootcamp.lobby.BCVehicleBuyView;
    import net.wg.gui.bootcamp.messageWindow.BCMessageWindow;
    import net.wg.gui.bootcamp.messageWindow.containers.AnimatedShapeContainer;
    import net.wg.gui.bootcamp.messageWindow.controls.MessageItemRendererBase;
    import net.wg.gui.bootcamp.messageWindow.controls.MessageItemRendererReward;
    import net.wg.gui.bootcamp.messageWindow.data.MessageBottomItemVO;
    import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
    import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
    import net.wg.gui.bootcamp.messageWindow.interfaces.IBottomRenderer;
    import net.wg.gui.bootcamp.messageWindow.interfaces.IMessageView;
    import net.wg.gui.bootcamp.messageWindow.views.MessageViewBase;
    import net.wg.gui.bootcamp.messageWindow.views.MessageViewLines;
    import net.wg.gui.bootcamp.messageWindow.views.MessageViewLinesFinal;
    import net.wg.gui.bootcamp.messageWindow.views.bottom.BottomButtonsView;
    import net.wg.gui.bootcamp.messageWindow.views.bottom.BottomListViewBase;
    import net.wg.gui.bootcamp.nationsWindow.BCNationsWindow;
    import net.wg.gui.bootcamp.nationsWindow.containers.NationsContainer;
    import net.wg.gui.bootcamp.nationsWindow.containers.NationsSelectorContainer;
    import net.wg.gui.bootcamp.nationsWindow.containers.TankInfoContainer;
    import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
    import net.wg.gui.bootcamp.questsView.BCQuestsView;
    import net.wg.gui.bootcamp.questsView.containers.MissionContainer;
    import net.wg.gui.bootcamp.questsView.data.BCQuestsViewVO;
    import net.wg.gui.bootcamp.queueWindow.BCQueueWindow;
    import net.wg.gui.bootcamp.queueWindow.data.BCQueueVO;
    import net.wg.gui.components.advanced.Accordion;
    import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
    import net.wg.gui.components.advanced.AmmunitionButton;
    import net.wg.gui.components.advanced.AwardItem;
    import net.wg.gui.components.advanced.AwardItemEx;
    import net.wg.gui.components.advanced.BackButton;
    import net.wg.gui.components.advanced.BlinkingButton;
    import net.wg.gui.components.advanced.ButtonToggleIndicator;
    import net.wg.gui.components.advanced.Calendar;
    import net.wg.gui.components.advanced.ClanEmblem;
    import net.wg.gui.components.advanced.ComplexProgressIndicator;
    import net.wg.gui.components.advanced.CooldownAnimationController;
    import net.wg.gui.components.advanced.CooldownSlot;
    import net.wg.gui.components.advanced.CounterEx;
    import net.wg.gui.components.advanced.DashLineTextItem;
    import net.wg.gui.components.advanced.DoubleProgressBar;
    import net.wg.gui.components.advanced.Dummy;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import net.wg.gui.components.advanced.HelpLayoutControl;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.gui.components.advanced.InteractiveSortingButton;
    import net.wg.gui.components.advanced.InviteIndicator;
    import net.wg.gui.components.advanced.ItemBrowserTabMask;
    import net.wg.gui.components.advanced.LineDescrIconText;
    import net.wg.gui.components.advanced.LineIconText;
    import net.wg.gui.components.advanced.ModuleIcon;
    import net.wg.gui.components.advanced.NormalButtonToggleWG;
    import net.wg.gui.components.advanced.PortraitItemRenderer;
    import net.wg.gui.components.advanced.RecruitParametersComponent;
    import net.wg.gui.components.advanced.ScalableIconWrapper;
    import net.wg.gui.components.advanced.ShellButton;
    import net.wg.gui.components.advanced.ShellsSet;
    import net.wg.gui.components.advanced.SkillsItemRenderer;
    import net.wg.gui.components.advanced.SkillsLevelItemRenderer;
    import net.wg.gui.components.advanced.SortableHeaderButtonBar;
    import net.wg.gui.components.advanced.SortingButton;
    import net.wg.gui.components.advanced.StaticItemSlot;
    import net.wg.gui.components.advanced.StatisticItem;
    import net.wg.gui.components.advanced.StatusDeltaIndicatorAnim;
    import net.wg.gui.components.advanced.TankIcon;
    import net.wg.gui.components.advanced.TankmanCard;
    import net.wg.gui.components.advanced.TextArea;
    import net.wg.gui.components.advanced.TextAreaSimple;
    import net.wg.gui.components.advanced.ToggleButton;
    import net.wg.gui.components.advanced.UnderlinedText;
    import net.wg.gui.components.advanced.VideoButton;
    import net.wg.gui.components.advanced.ViewHeader;
    import net.wg.gui.components.advanced.backButton.BackButtonHelper;
    import net.wg.gui.components.advanced.backButton.BackButtonStates;
    import net.wg.gui.components.advanced.backButton.BackButtonText;
    import net.wg.gui.components.advanced.calendar.DayRenderer;
    import net.wg.gui.components.advanced.calendar.WeekDayRenderer;
    import net.wg.gui.components.advanced.collapsingBar.CollapsingBar;
    import net.wg.gui.components.advanced.collapsingBar.CollapsingGroup;
    import net.wg.gui.components.advanced.collapsingBar.ResizableButton;
    import net.wg.gui.components.advanced.collapsingBar.data.CollapsingBarButtonVO;
    import net.wg.gui.components.advanced.collapsingBar.interfaces.ICollapseChecker;
    import net.wg.gui.components.advanced.events.CalendarEvent;
    import net.wg.gui.components.advanced.events.DummyEvent;
    import net.wg.gui.components.advanced.events.RecruitParamsEvent;
    import net.wg.gui.components.advanced.events.TutorialHelpBtnEvent;
    import net.wg.gui.components.advanced.events.TutorialHintEvent;
    import net.wg.gui.components.advanced.events.ViewHeaderEvent;
    import net.wg.gui.components.advanced.interfaces.IBackButton;
    import net.wg.gui.components.advanced.interfaces.IComplexProgressStepRenderer;
    import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
    import net.wg.gui.components.advanced.interfaces.IDashLineTextItem;
    import net.wg.gui.components.advanced.interfaces.IDummy;
    import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
    import net.wg.gui.components.advanced.interfaces.ITutorialHintAnimation;
    import net.wg.gui.components.advanced.interfaces.ITutorialHintArrowAnimation;
    import net.wg.gui.components.advanced.interfaces.ITutorialHintTextAnimation;
    import net.wg.gui.components.advanced.screenTab.ScreenTabButton;
    import net.wg.gui.components.advanced.screenTab.ScreenTabButtonBar;
    import net.wg.gui.components.advanced.screenTab.ScreenTabButtonBg;
    import net.wg.gui.components.advanced.tutorial.TutorialContextHint;
    import net.wg.gui.components.advanced.tutorial.TutorialContextOverlay;
    import net.wg.gui.components.advanced.tutorial.TutorialHint;
    import net.wg.gui.components.advanced.tutorial.TutorialHintAnimation;
    import net.wg.gui.components.advanced.tutorial.TutorialHintArrowAnimation;
    import net.wg.gui.components.advanced.tutorial.TutorialHintText;
    import net.wg.gui.components.advanced.tutorial.TutorialHintTextAnimation;
    import net.wg.gui.components.advanced.tutorial.TutorialHintTextAnimationMc;
    import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
    import net.wg.gui.components.advanced.vo.DummyVO;
    import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
    import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
    import net.wg.gui.components.advanced.vo.RecruitParametersVO;
    import net.wg.gui.components.advanced.vo.StaticItemSlotVO;
    import net.wg.gui.components.advanced.vo.StatisticItemVo;
    import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
    import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
    import net.wg.gui.components.advanced.vo.TutorialBtnControllerVO;
    import net.wg.gui.components.advanced.vo.TutorialClipEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialContextHintVO;
    import net.wg.gui.components.advanced.vo.TutorialContextOverlayVO;
    import net.wg.gui.components.advanced.vo.TutorialContextVO;
    import net.wg.gui.components.advanced.vo.TutorialDisplayEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialEnabledEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialHighlightEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialHintVO;
    import net.wg.gui.components.advanced.vo.TutorialOverlayEffectVO;
    import net.wg.gui.components.advanced.vo.TutorialTweenEffectVO;
    import net.wg.gui.components.advanced.vo.ViewHeaderVO;
    import net.wg.gui.components.carousels.AchievementCarousel;
    import net.wg.gui.components.carousels.CarouselBase;
    import net.wg.gui.components.carousels.PortraitsCarousel;
    import net.wg.gui.components.carousels.SkillsCarousel;
    import net.wg.gui.components.carousels.VerticalScroller;
    import net.wg.gui.components.carousels.VerticalScrollerViewPort;
    import net.wg.gui.components.carousels.interfaces.ICarouselItemRenderer;
    import net.wg.gui.components.common.ArrowButtonIconContainer;
    import net.wg.gui.components.common.ArrowButtonNumber;
    import net.wg.gui.components.common.ArrowButtonWithNumber;
    import net.wg.gui.components.common.ConfirmComponent;
    import net.wg.gui.components.common.ConfirmItemComponent;
    import net.wg.gui.components.common.InputChecker;
    import net.wg.gui.components.common.containers.AutoResizableTiledLayout;
    import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
    import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
    import net.wg.gui.components.common.containers.EqualWidthHorizontalLayout;
    import net.wg.gui.components.common.containers.Group;
    import net.wg.gui.components.common.containers.GroupExAnimated;
    import net.wg.gui.components.common.containers.TiledLayout;
    import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
    import net.wg.gui.components.common.containers.VerticalGroupLayout;
    import net.wg.gui.components.controls.AccordionSoundRenderer;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.BaseDropList;
    import net.wg.gui.components.controls.ButtonIconLoader;
    import net.wg.gui.components.controls.DropDownListItemRendererPrice;
    import net.wg.gui.components.controls.DropdownMenuPrice;
    import net.wg.gui.components.controls.GlowArrowAsset;
    import net.wg.gui.components.controls.MainMenuButton;
    import net.wg.gui.components.controls.ProgressBar;
    import net.wg.gui.components.controls.ProgressBarAnim;
    import net.wg.gui.components.controls.ResizableTileList;
    import net.wg.gui.components.controls.RoundProgressBarAnim;
    import net.wg.gui.components.controls.SlotButtonBase;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.components.controls.SortableTableList;
    import net.wg.gui.components.controls.SortButton;
    import net.wg.gui.components.controls.TableRenderer;
    import net.wg.gui.components.controls.TankmanTrainigButtonVO;
    import net.wg.gui.components.controls.TankmanTrainingButton;
    import net.wg.gui.components.controls.TankmanTrainingSmallButton;
    import net.wg.gui.components.controls.TileList;
    import net.wg.gui.components.controls.TradeIco;
    import net.wg.gui.components.controls.UnitCommanderStats;
    import net.wg.gui.components.controls.VehicleSelectorBase;
    import net.wg.gui.components.controls.VerticalListViewPort;
    import net.wg.gui.components.controls.WgScrollingList;
    import net.wg.gui.components.controls.events.VerticalListViewportEvent;
    import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
    import net.wg.gui.components.controls.slotsPanel.impl.BaseSlotsPanel;
    import net.wg.gui.components.controls.tabs.OrangeTabButton;
    import net.wg.gui.components.controls.tabs.OrangeTabMenu;
    import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
    import net.wg.gui.components.interfaces.IAccordionItemRenderer;
    import net.wg.gui.components.interfaces.IListItemAnimatedRenderer;
    import net.wg.gui.components.interfaces.IReusableListItemRenderer;
    import net.wg.gui.components.interfaces.ITabButton;
    import net.wg.gui.components.interfaces.IVehicleSelector;
    import net.wg.gui.components.interfaces.IVehicleSelectorFilter;
    import net.wg.gui.components.miniclient.BattleTypeMiniClientComponent;
    import net.wg.gui.components.miniclient.HangarMiniClientComponent;
    import net.wg.gui.components.miniclient.LinkedMiniClientComponent;
    import net.wg.gui.components.miniclient.TechTreeMiniClientComponent;
    import net.wg.gui.components.popovers.VehicleSelectPopoverBase;
    import net.wg.gui.components.popovers.data.VehicleSelectPopoverVO;
    import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
    import net.wg.gui.components.popovers.interfaces.IVehicleSelectPopoverVO;
    import net.wg.gui.components.tooltips.AchievementsCustomBlockItem;
    import net.wg.gui.components.tooltips.ExtraModuleInfo;
    import net.wg.gui.components.tooltips.IgrPremVehQuestBlock;
    import net.wg.gui.components.tooltips.IgrQuestBlock;
    import net.wg.gui.components.tooltips.IgrQuestProgressBlock;
    import net.wg.gui.components.tooltips.ModuleItem;
    import net.wg.gui.components.tooltips.Status;
    import net.wg.gui.components.tooltips.SuitableVehicleBlockItem;
    import net.wg.gui.components.tooltips.ToolTipAchievement;
    import net.wg.gui.components.tooltips.ToolTipActionPrice;
    import net.wg.gui.components.tooltips.ToolTipBuySkill;
    import net.wg.gui.components.tooltips.ToolTipClanCommonInfo;
    import net.wg.gui.components.tooltips.ToolTipClanInfo;
    import net.wg.gui.components.tooltips.ToolTipColumnFields;
    import net.wg.gui.components.tooltips.TooltipContact;
    import net.wg.gui.components.tooltips.ToolTipCustomizationItem;
    import net.wg.gui.components.tooltips.TooltipEnvironment;
    import net.wg.gui.components.tooltips.ToolTipFortDivision;
    import net.wg.gui.components.tooltips.ToolTipFortSortie;
    import net.wg.gui.components.tooltips.ToolTipIGR;
    import net.wg.gui.components.tooltips.ToolTipLadder;
    import net.wg.gui.components.tooltips.ToolTipLadderRegulations;
    import net.wg.gui.components.tooltips.ToolTipMap;
    import net.wg.gui.components.tooltips.ToolTipMapSmall;
    import net.wg.gui.components.tooltips.ToolTipMarkOfMastery;
    import net.wg.gui.components.tooltips.ToolTipMarksOnGun;
    import net.wg.gui.components.tooltips.ToolTipPrivateQuests;
    import net.wg.gui.components.tooltips.ToolTipRefSysDirects;
    import net.wg.gui.components.tooltips.ToolTipRefSysReserves;
    import net.wg.gui.components.tooltips.ToolTipSeasons;
    import net.wg.gui.components.tooltips.ToolTipSelectedVehicle;
    import net.wg.gui.components.tooltips.ToolTipSkill;
    import net.wg.gui.components.tooltips.ToolTipSortieDivision;
    import net.wg.gui.components.tooltips.ToolTipSuitableVehicle;
    import net.wg.gui.components.tooltips.ToolTipTankmen;
    import net.wg.gui.components.tooltips.ToolTipTradeInPrice;
    import net.wg.gui.components.tooltips.TooltipUnitCommand;
    import net.wg.gui.components.tooltips.ToolTipUnitLevel;
    import net.wg.gui.components.tooltips.TooltipWrapper;
    import net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
    import net.wg.gui.components.tooltips.finstats.HeadBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.AbstractTextParameterBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.ActionTextParameterBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.AdvancedClipBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.AdvancedKeyBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.BadgeInfoBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.BlueprintBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.CompoundPriceBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.CrewSkillsBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.DashLineItemPriceBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.EpicMetaLevelProgressBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.GroupBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.ImageBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.RankBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.RendererTextBlockInBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.SaleTextParameterBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.SimpleTileListBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.StatusDeltaParameterBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.TextBetweenLineBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterWithIconBlock;
    import net.wg.gui.components.tooltips.inblocks.blocks.TitleDescParameterWithIconBlock;
    import net.wg.gui.components.tooltips.inblocks.components.ImageRenderer;
    import net.wg.gui.components.tooltips.inblocks.data.ActionTextParameterBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.BadgeInfoBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.BlueprintBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.CrewSkillsBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.DashLineItemPriceBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.GroupBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.RankBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.RendererDataVO;
    import net.wg.gui.components.tooltips.inblocks.data.RendererTextBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.SaleTextParameterVO;
    import net.wg.gui.components.tooltips.inblocks.data.SimpleTileListBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.StatusDeltaParameterBlockVO;
    import net.wg.gui.components.tooltips.inblocks.data.TextBetweenLineVO;
    import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
    import net.wg.gui.components.tooltips.inblocks.data.TextParameterWithIconVO;
    import net.wg.gui.components.tooltips.inblocks.data.TitleDescParameterWithIconVO;
    import net.wg.gui.components.tooltips.sortie.SortieDivisionBlock;
    import net.wg.gui.components.tooltips.VO.AchievementVO;
    import net.wg.gui.components.tooltips.VO.ColumnFieldsVo;
    import net.wg.gui.components.tooltips.VO.ContactTooltipVO;
    import net.wg.gui.components.tooltips.VO.CustomizationItemVO;
    import net.wg.gui.components.tooltips.VO.Dimension;
    import net.wg.gui.components.tooltips.VO.DivisionVO;
    import net.wg.gui.components.tooltips.VO.EquipmentParamVO;
    import net.wg.gui.components.tooltips.VO.ExtraModuleInfoVO;
    import net.wg.gui.components.tooltips.VO.FortClanCommonInfoVO;
    import net.wg.gui.components.tooltips.VO.FortClanInfoVO;
    import net.wg.gui.components.tooltips.VO.FortDivisionVO;
    import net.wg.gui.components.tooltips.VO.IgrVO;
    import net.wg.gui.components.tooltips.VO.LadderVO;
    import net.wg.gui.components.tooltips.VO.MapVO;
    import net.wg.gui.components.tooltips.VO.ModuleVO;
    import net.wg.gui.components.tooltips.VO.PersonalCaseBlockItemVO;
    import net.wg.gui.components.tooltips.VO.PremDaysVo;
    import net.wg.gui.components.tooltips.VO.PrivateQuestsVO;
    import net.wg.gui.components.tooltips.VO.SettingsControlVO;
    import net.wg.gui.components.tooltips.VO.SortieDivisionVO;
    import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
    import net.wg.gui.components.tooltips.VO.TankmenVO;
    import net.wg.gui.components.tooltips.VO.ToolTipActionPriceVO;
    import net.wg.gui.components.tooltips.VO.ToolTipBuySkillVO;
    import net.wg.gui.components.tooltips.VO.TooltipEnvironmentVO;
    import net.wg.gui.components.tooltips.VO.ToolTipFortSortieVO;
    import net.wg.gui.components.tooltips.VO.ToolTipLadderRegulationsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysDirectsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipRefSysReservesVO;
    import net.wg.gui.components.tooltips.VO.ToolTipSeasonsVO;
    import net.wg.gui.components.tooltips.VO.ToolTipSkillVO;
    import net.wg.gui.components.tooltips.VO.ToolTipTankClassVO;
    import net.wg.gui.components.tooltips.VO.ToolTipUnitLevelVO;
    import net.wg.gui.components.tooltips.VO.TradeInTooltipVo;
    import net.wg.gui.components.tooltips.VO.finalStats.HeadBlockData;
    import net.wg.gui.components.waitingQueue.WaitingQueueMessageHelper;
    import net.wg.gui.components.waitingQueue.WaitingQueueMessageUpdater;
    import net.wg.gui.components.windows.ScreenBg;
    import net.wg.gui.components.windows.SimpleWindow;
    import net.wg.gui.components.windows.vo.SimpleWindowBtnVo;
    import net.wg.gui.crewOperations.CrewOperationEvent;
    import net.wg.gui.crewOperations.CrewOperationInfoVO;
    import net.wg.gui.crewOperations.CrewOperationsInitVO;
    import net.wg.gui.crewOperations.CrewOperationsIRenderer;
    import net.wg.gui.crewOperations.CrewOperationsIRFooter;
    import net.wg.gui.crewOperations.CrewOperationsPopOver;
    import net.wg.gui.crewOperations.CrewOperationsScrollingList;
    import net.wg.gui.crewOperations.CrewOperationWarningVO;
    import net.wg.gui.cyberSport.CSConstants;
    import net.wg.gui.cyberSport.CSInvalidationType;
    import net.wg.gui.cyberSport.CyberSportMainWindow;
    import net.wg.gui.cyberSport.controls.CandidateHeaderItemRender;
    import net.wg.gui.cyberSport.controls.CandidateItemRenderer;
    import net.wg.gui.cyberSport.controls.CommandRenderer;
    import net.wg.gui.cyberSport.controls.CSCandidatesScrollingList;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.gui.cyberSport.controls.CSVehicleButtonLevels;
    import net.wg.gui.cyberSport.controls.DynamicRangeVehicles;
    import net.wg.gui.cyberSport.controls.ManualSearchRenderer;
    import net.wg.gui.cyberSport.controls.MedalVehicleVO;
    import net.wg.gui.cyberSport.controls.RangeViewComponent;
    import net.wg.gui.cyberSport.controls.RosterButtonGroup;
    import net.wg.gui.cyberSport.controls.RosterSettingsNumerationBlock;
    import net.wg.gui.cyberSport.controls.SelectedVehiclesMsg;
    import net.wg.gui.cyberSport.controls.SettingsIcons;
    import net.wg.gui.cyberSport.controls.VehicleSelector;
    import net.wg.gui.cyberSport.controls.VehicleSelectorItemRenderer;
    import net.wg.gui.cyberSport.controls.VehicleSelectorNavigator;
    import net.wg.gui.cyberSport.controls.WaitingAlert;
    import net.wg.gui.cyberSport.controls.data.CSVehicleButtonSelectionVO;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
    import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
    import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
    import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
    import net.wg.gui.cyberSport.data.CandidatesDataProvider;
    import net.wg.gui.cyberSport.data.RosterSlotSettingsWindowStaticVO;
    import net.wg.gui.cyberSport.interfaces.IAutoSearchFormView;
    import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
    import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
    import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
    import net.wg.gui.cyberSport.popups.VehicleSelectorPopup;
    import net.wg.gui.cyberSport.views.AnimatedRosterSettingsView;
    import net.wg.gui.cyberSport.views.IntroView;
    import net.wg.gui.cyberSport.views.RangeRosterSettingsView;
    import net.wg.gui.cyberSport.views.RosterSettingsView;
    import net.wg.gui.cyberSport.views.RosterSlotSettingsWindow;
    import net.wg.gui.cyberSport.views.UnitsListView;
    import net.wg.gui.cyberSport.views.UnitView;
    import net.wg.gui.cyberSport.views.autoSearch.ConfirmationReadinessStatus;
    import net.wg.gui.cyberSport.views.autoSearch.CSAutoSearchMainView;
    import net.wg.gui.cyberSport.views.autoSearch.ErrorState;
    import net.wg.gui.cyberSport.views.autoSearch.SearchCommands;
    import net.wg.gui.cyberSport.views.autoSearch.SearchEnemy;
    import net.wg.gui.cyberSport.views.autoSearch.SearchEnemyRespawn;
    import net.wg.gui.cyberSport.views.autoSearch.StateViewBase;
    import net.wg.gui.cyberSport.views.autoSearch.WaitingPlayers;
    import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
    import net.wg.gui.cyberSport.views.events.CyberSportEvent;
    import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
    import net.wg.gui.cyberSport.views.events.SCUpdateFocusEvent;
    import net.wg.gui.cyberSport.views.respawn.RespawnChatSection;
    import net.wg.gui.cyberSport.views.respawn.RespawnSlotHelper;
    import net.wg.gui.cyberSport.views.respawn.RespawnTeamSection;
    import net.wg.gui.cyberSport.views.respawn.RespawnTeamSlot;
    import net.wg.gui.cyberSport.views.respawn.UnitSlotButtonProperties;
    import net.wg.gui.cyberSport.views.unit.ChatSection;
    import net.wg.gui.cyberSport.views.unit.CyberSportTeamSectionBase;
    import net.wg.gui.cyberSport.views.unit.IStaticRallyDetailsSection;
    import net.wg.gui.cyberSport.views.unit.JoinUnitSection;
    import net.wg.gui.cyberSport.views.unit.SimpleSlotRenderer;
    import net.wg.gui.cyberSport.views.unit.SlotRenderer;
    import net.wg.gui.cyberSport.views.unit.TeamSection;
    import net.wg.gui.cyberSport.views.unit.UnitSlotHelper;
    import net.wg.gui.cyberSport.views.unit.WaitListSection;
    import net.wg.gui.cyberSport.vo.AutoSearchVO;
    import net.wg.gui.cyberSport.vo.CSCommadDetailsVO;
    import net.wg.gui.cyberSport.vo.CSCommandVO;
    import net.wg.gui.cyberSport.vo.CSIndicatorData;
    import net.wg.gui.cyberSport.vo.CSIntroViewStaticTeamVO;
    import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
    import net.wg.gui.cyberSport.vo.IUnit;
    import net.wg.gui.cyberSport.vo.IUnitSlot;
    import net.wg.gui.cyberSport.vo.NavigationBlockVO;
    import net.wg.gui.cyberSport.vo.RosterLimitsVO;
    import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
    import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
    import net.wg.gui.cyberSport.vo.WaitingPlayersVO;
    import net.wg.gui.data.AwardItemVO;
    import net.wg.gui.data.AwardWindowVO;
    import net.wg.gui.data.BaseAwardsBlockVO;
    import net.wg.gui.data.BoosterBuyWindowUpdateVO;
    import net.wg.gui.data.BoosterBuyWindowVO;
    import net.wg.gui.data.ButtonBarDataVO;
    import net.wg.gui.data.ButtonBarItemVO;
    import net.wg.gui.data.CrystalsPromoWindowVO;
    import net.wg.gui.data.DataClassItemVO;
    import net.wg.gui.data.MissionAwardWindowVO;
    import net.wg.gui.data.TabDataVO;
    import net.wg.gui.data.TabsVO;
    import net.wg.gui.data.TaskAwardsBlockVO;
    import net.wg.gui.data.VehCompareEntrypointVO;
    import net.wg.gui.demoPage.ButtonDemoRenderer;
    import net.wg.gui.demoPage.ButtonDemoVO;
    import net.wg.gui.demoPage.DemoPage;
    import net.wg.gui.events.AnimatedRendererEvent;
    import net.wg.gui.events.ArenaVoipSettingsEvent;
    import net.wg.gui.events.ConfirmExchangeBlockEvent;
    import net.wg.gui.events.CooldownEvent;
    import net.wg.gui.events.CrewEvent;
    import net.wg.gui.events.DeviceEvent;
    import net.wg.gui.events.FinalStatisticEvent;
    import net.wg.gui.events.HeaderButtonBarEvent;
    import net.wg.gui.events.HeaderEvent;
    import net.wg.gui.events.LobbyEvent;
    import net.wg.gui.events.LobbyTDispatcherEvent;
    import net.wg.gui.events.MessengerBarEvent;
    import net.wg.gui.events.PersonalCaseEvent;
    import net.wg.gui.events.QuestEvent;
    import net.wg.gui.events.ResizableBlockEvent;
    import net.wg.gui.events.ShowDialogEvent;
    import net.wg.gui.events.SortableTableListEvent;
    import net.wg.gui.events.TechniqueListComponentEvent;
    import net.wg.gui.events.TrainingEvent;
    import net.wg.gui.events.VehicleSellDialogEvent;
    import net.wg.gui.events.WaitingQueueMessageEvent;
    import net.wg.gui.fortBase.IBuildingBaseVO;
    import net.wg.gui.fortBase.IBuildingVO;
    import net.wg.gui.interfaces.ICalendarDayVO;
    import net.wg.gui.interfaces.IDate;
    import net.wg.gui.interfaces.IDropList;
    import net.wg.gui.interfaces.IExtendedUserVO;
    import net.wg.gui.interfaces.IHeaderButtonContentItem;
    import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
    import net.wg.gui.interfaces.IRallyCandidateVO;
    import net.wg.gui.interfaces.IResettable;
    import net.wg.gui.interfaces.ISaleItemBlockRenderer;
    import net.wg.gui.interfaces.IUpdatableComponent;
    import net.wg.gui.interfaces.IWaitingQueueMessageHelper;
    import net.wg.gui.interfaces.IWaitingQueueMessageUpdater;
    import net.wg.gui.intro.IntroInfoVO;
    import net.wg.gui.intro.IntroPage;
    import net.wg.gui.lobby.LobbyPage;
    import net.wg.gui.lobby.badges.BadgesContentContainer;
    import net.wg.gui.lobby.badges.BadgesHeader;
    import net.wg.gui.lobby.badges.BadgesPage;
    import net.wg.gui.lobby.badges.components.BadgeRenderer;
    import net.wg.gui.lobby.badges.data.BadgesGroupVO;
    import net.wg.gui.lobby.badges.data.BadgesHeaderVO;
    import net.wg.gui.lobby.badges.data.BadgesStaticDataVO;
    import net.wg.gui.lobby.badges.data.BadgeVO;
    import net.wg.gui.lobby.badges.events.BadgesEvent;
    import net.wg.gui.lobby.barracks.Barracks;
    import net.wg.gui.lobby.barracks.BarracksForm;
    import net.wg.gui.lobby.barracks.BarracksItemRenderer;
    import net.wg.gui.lobby.barracks.data.BarracksTankmanVO;
    import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
    import net.wg.gui.lobby.battlequeue.BattleQueue;
    import net.wg.gui.lobby.battlequeue.BattleQueueItemRenderer;
    import net.wg.gui.lobby.battlequeue.BattleQueueItemVO;
    import net.wg.gui.lobby.battlequeue.BattleQueueTypeInfoVO;
    import net.wg.gui.lobby.battlequeue.BattleStrongholdsLeagueRenderer;
    import net.wg.gui.lobby.battlequeue.BattleStrongholdsLeaguesLeaderVO;
    import net.wg.gui.lobby.battlequeue.BattleStrongholdsLeaguesVO;
    import net.wg.gui.lobby.battlequeue.BattleStrongholdsQueue;
    import net.wg.gui.lobby.battlequeue.BattleStrongholdsQueueTypeInfoVO;
    import net.wg.gui.lobby.battleResults.AwardExtractor;
    import net.wg.gui.lobby.battleResults.BattleResults;
    import net.wg.gui.lobby.battleResults.CommonStats;
    import net.wg.gui.lobby.battleResults.DetailsStatsView;
    import net.wg.gui.lobby.battleResults.EpicStats;
    import net.wg.gui.lobby.battleResults.GetPremiumPopover;
    import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
    import net.wg.gui.lobby.battleResults.TeamStats;
    import net.wg.gui.lobby.battleResults.components.AlertMessage;
    import net.wg.gui.lobby.battleResults.components.BattleResultImageSwitcherView;
    import net.wg.gui.lobby.battleResults.components.BattleResultsEventRenderer;
    import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
    import net.wg.gui.lobby.battleResults.components.BattleResultsPersonalQuest;
    import net.wg.gui.lobby.battleResults.components.DetailsBlock;
    import net.wg.gui.lobby.battleResults.components.DetailsStats;
    import net.wg.gui.lobby.battleResults.components.DetailsStatsScrollPane;
    import net.wg.gui.lobby.battleResults.components.EfficiencyHeader;
    import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer;
    import net.wg.gui.lobby.battleResults.components.EfficiencyRenderer;
    import net.wg.gui.lobby.battleResults.components.EpicTeamMemberStatsView;
    import net.wg.gui.lobby.battleResults.components.IncomeDetails;
    import net.wg.gui.lobby.battleResults.components.IncomeDetailsBase;
    import net.wg.gui.lobby.battleResults.components.IncomeDetailsShort;
    import net.wg.gui.lobby.battleResults.components.IncomeDetailsSmall;
    import net.wg.gui.lobby.battleResults.components.MedalsList;
    import net.wg.gui.lobby.battleResults.components.MultiColumnSubtasksList;
    import net.wg.gui.lobby.battleResults.components.MultipleTankList;
    import net.wg.gui.lobby.battleResults.components.PersonalQuestState;
    import net.wg.gui.lobby.battleResults.components.ProgressElement;
    import net.wg.gui.lobby.battleResults.components.RankedTeamMemberItemRenderer;
    import net.wg.gui.lobby.battleResults.components.ScrollbarTeamMemberItemRenderer;
    import net.wg.gui.lobby.battleResults.components.SortieTeamStatsController;
    import net.wg.gui.lobby.battleResults.components.SpecialAchievement;
    import net.wg.gui.lobby.battleResults.components.TankResultItemRenderer;
    import net.wg.gui.lobby.battleResults.components.TankStatsView;
    import net.wg.gui.lobby.battleResults.components.TeamMemberItemRenderer;
    import net.wg.gui.lobby.battleResults.components.TeamMemberRendererBase;
    import net.wg.gui.lobby.battleResults.components.TeamMemberStatsView;
    import net.wg.gui.lobby.battleResults.components.TeamMemberStatsViewBase;
    import net.wg.gui.lobby.battleResults.components.TeamStatsList;
    import net.wg.gui.lobby.battleResults.components.TotalIncomeDetails;
    import net.wg.gui.lobby.battleResults.components.VehicleDetails;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.AdvertisingState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.ComparePremiumState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.DetailsState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumBonusState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumInfoState;
    import net.wg.gui.lobby.battleResults.controller.ColumnConstants;
    import net.wg.gui.lobby.battleResults.controller.CybersportTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.DefaultTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.EpicTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.FortTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.RankedTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.RatedCybersportTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.ScrollBarTeamStatsController;
    import net.wg.gui.lobby.battleResults.controller.TeamStatsControllerAbstract;
    import net.wg.gui.lobby.battleResults.cs.CsTeamEmblemEvent;
    import net.wg.gui.lobby.battleResults.cs.CsTeamEvent;
    import net.wg.gui.lobby.battleResults.cs.CsTeamStats;
    import net.wg.gui.lobby.battleResults.cs.CsTeamStatsBg;
    import net.wg.gui.lobby.battleResults.cs.CsTeamStatsVo;
    import net.wg.gui.lobby.battleResults.data.AlertMessageVO;
    import net.wg.gui.lobby.battleResults.data.BattleResultsMedalsListVO;
    import net.wg.gui.lobby.battleResults.data.BattleResultsTextData;
    import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
    import net.wg.gui.lobby.battleResults.data.ColumnCollection;
    import net.wg.gui.lobby.battleResults.data.ColumnData;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
    import net.wg.gui.lobby.battleResults.data.EfficiencyHeaderVO;
    import net.wg.gui.lobby.battleResults.data.EfficiencyRendererVO;
    import net.wg.gui.lobby.battleResults.data.EpicEfficiencyData;
    import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
    import net.wg.gui.lobby.battleResults.data.OvertimeVO;
    import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
    import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
    import net.wg.gui.lobby.battleResults.data.PremiumEarningsVO;
    import net.wg.gui.lobby.battleResults.data.PremiumInfoVO;
    import net.wg.gui.lobby.battleResults.data.RankedBattleSubTaskVO;
    import net.wg.gui.lobby.battleResults.data.StatItemVO;
    import net.wg.gui.lobby.battleResults.data.TabInfoVO;
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
    import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
    import net.wg.gui.lobby.battleResults.data.VictoryPanelVO;
    import net.wg.gui.lobby.battleResults.epic.EpicDetailsVehicleSelection;
    import net.wg.gui.lobby.battleResults.epic.EpicEfficiencyItemRenderer;
    import net.wg.gui.lobby.battleResults.epic.EpicTeamMemberItemRenderer;
    import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
    import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
    import net.wg.gui.lobby.battleResults.event.TeamTableSortEvent;
    import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
    import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
    import net.wg.gui.lobby.battleResults.progressReport.BattleResultUnlockItem;
    import net.wg.gui.lobby.battleResults.progressReport.BattleResultUnlockItemVO;
    import net.wg.gui.lobby.battleResults.progressReport.ProgressReportLinkageSelector;
    import net.wg.gui.lobby.battleResults.progressReport.UnlockLinkEvent;
    import net.wg.gui.lobby.boosters.BoostersTableRenderer;
    import net.wg.gui.lobby.boosters.components.BoostersWindowFilters;
    import net.wg.gui.lobby.boosters.data.BoostersTableRendererVO;
    import net.wg.gui.lobby.boosters.data.BoostersWindowFiltersVO;
    import net.wg.gui.lobby.boosters.data.BoostersWindowStaticVO;
    import net.wg.gui.lobby.boosters.data.BoostersWindowVO;
    import net.wg.gui.lobby.boosters.data.ConfirmBoostersWindowVO;
    import net.wg.gui.lobby.boosters.events.BoostersWindowEvent;
    import net.wg.gui.lobby.boosters.windows.ConfirmBoostersWindow;
    import net.wg.gui.lobby.browser.Browser;
    import net.wg.gui.lobby.browser.BrowserActionBtn;
    import net.wg.gui.lobby.browser.ServiceView;
    import net.wg.gui.lobby.browser.events.BrowserActionBtnEvent;
    import net.wg.gui.lobby.browser.events.BrowserEvent;
    import net.wg.gui.lobby.browser.events.BrowserTitleEvent;
    import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
    import net.wg.gui.lobby.clans.common.ClanNameField;
    import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
    import net.wg.gui.lobby.clans.common.ClanViewWithVariableContent;
    import net.wg.gui.lobby.clans.common.ClanVO;
    import net.wg.gui.lobby.clans.common.IClanHeaderComponent;
    import net.wg.gui.lobby.clans.common.IClanNameField;
    import net.wg.gui.lobby.clans.invites.ClanInvitesWindow;
    import net.wg.gui.lobby.clans.invites.ClanPersonalInvitesWindow;
    import net.wg.gui.lobby.clans.invites.components.AcceptActions;
    import net.wg.gui.lobby.clans.invites.components.TextValueBlock;
    import net.wg.gui.lobby.clans.invites.renderers.ClanInviteItemRenderer;
    import net.wg.gui.lobby.clans.invites.renderers.ClanInvitesWindowAbstractTableItemRenderer;
    import net.wg.gui.lobby.clans.invites.renderers.ClanPersonalInvitesItemRenderer;
    import net.wg.gui.lobby.clans.invites.renderers.ClanRequestItemRenderer;
    import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
    import net.wg.gui.lobby.clans.invites.renderers.UserAbstractTableItemRenderer;
    import net.wg.gui.lobby.clans.invites.views.ClanInvitesView;
    import net.wg.gui.lobby.clans.invites.views.ClanInvitesViewWithTable;
    import net.wg.gui.lobby.clans.invites.views.ClanInvitesWindowAbstractTabView;
    import net.wg.gui.lobby.clans.invites.views.ClanPersonalInvitesView;
    import net.wg.gui.lobby.clans.invites.views.ClanRequestsView;
    import net.wg.gui.lobby.clans.invites.VOs.AcceptActionsVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowAbstractItemVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowHeaderStateVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTableFilterVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTabViewVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanInviteVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanRequestActionsVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanRequestStatusVO;
    import net.wg.gui.lobby.clans.invites.VOs.ClanRequestVO;
    import net.wg.gui.lobby.clans.invites.VOs.DummyTextVO;
    import net.wg.gui.lobby.clans.invites.VOs.PersonalInviteVO;
    import net.wg.gui.lobby.clans.invites.VOs.UserInvitesWindowItemVO;
    import net.wg.gui.lobby.clans.profile.ClanProfileEvent;
    import net.wg.gui.lobby.clans.profile.ClanProfileMainWindow;
    import net.wg.gui.lobby.clans.profile.ClanProfileMainWindowBaseHeader;
    import net.wg.gui.lobby.clans.profile.ClanProfileMainWindowHeader;
    import net.wg.gui.lobby.clans.profile.ClanProfileSummaryViewHeader;
    import net.wg.gui.lobby.clans.profile.cmp.ClanProfileSummaryBlock;
    import net.wg.gui.lobby.clans.profile.cmp.TextFieldFrame;
    import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileSummaryBlock;
    import net.wg.gui.lobby.clans.profile.interfaces.ITextFieldFrame;
    import net.wg.gui.lobby.clans.profile.renderers.ClanLeagueRenderer;
    import net.wg.gui.lobby.clans.profile.renderers.ClanProfileMemberItemRenderer;
    import net.wg.gui.lobby.clans.profile.renderers.ClanProfileProvinceItemRenderer;
    import net.wg.gui.lobby.clans.profile.renderers.ClanProfileSelfProvinceItemRenderer;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapInfoView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapPromoView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfilePersonnelView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileSummaryView;
    import net.wg.gui.lobby.clans.profile.views.ClanProfileTableStatisticsView;
    import net.wg.gui.lobby.clans.profile.VOs.ClanMemberVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapInfoVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapPromoVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapViewVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileMainWindowVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfilePersonnelViewVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileProvinceVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSelfProvinceVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileStatsLineVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryBlockVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryLeaguesVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewStatusVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewVO;
    import net.wg.gui.lobby.clans.profile.VOs.ClanProfileTableStatisticsDataVO;
    import net.wg.gui.lobby.clans.profile.VOs.GlobalMapStatisticsBodyVO;
    import net.wg.gui.lobby.clans.profile.VOs.LeagueItemRendererVO;
    import net.wg.gui.lobby.clans.search.ClanSearchInfo;
    import net.wg.gui.lobby.clans.search.ClanSearchItemRenderer;
    import net.wg.gui.lobby.clans.search.ClanSearchWindow;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoDataVO;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoInitDataVO;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoStateDataVO;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchItemVO;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowInitDataVO;
    import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowStateDataVO;
    import net.wg.gui.lobby.clans.utils.ClanHelper;
    import net.wg.gui.lobby.components.AbstractPopoverComponentPanel;
    import net.wg.gui.lobby.components.AbstractPopoverWithScrollableComponentPanel;
    import net.wg.gui.lobby.components.ArrowDown;
    import net.wg.gui.lobby.components.AwardItemRendererEx;
    import net.wg.gui.lobby.components.AwardWindowAnimationController;
    import net.wg.gui.lobby.components.BaseAwardsBlock;
    import net.wg.gui.lobby.components.BaseBoosterSlot;
    import net.wg.gui.lobby.components.BaseMissionDetailedView;
    import net.wg.gui.lobby.components.BaseMissionDetailsBg;
    import net.wg.gui.lobby.components.BaseMissionDetailsContainerView;
    import net.wg.gui.lobby.components.BoosterAddSlot;
    import net.wg.gui.lobby.components.BoosterSlot;
    import net.wg.gui.lobby.components.BoostersPanel;
    import net.wg.gui.lobby.components.BrowserScreen;
    import net.wg.gui.lobby.components.BrowserViewStackExPadding;
    import net.wg.gui.lobby.components.ButtonFilters;
    import net.wg.gui.lobby.components.ButtonFiltersGroup;
    import net.wg.gui.lobby.components.DataViewStack;
    import net.wg.gui.lobby.components.DetailedStatisticsGroupEx;
    import net.wg.gui.lobby.components.DetailedStatisticsRootUnit;
    import net.wg.gui.lobby.components.DetailedStatisticsUnit;
    import net.wg.gui.lobby.components.DetailedStatisticsView;
    import net.wg.gui.lobby.components.ExplosionAwardWindowAnimation;
    import net.wg.gui.lobby.components.ExplosionAwardWindowAnimationIcon;
    import net.wg.gui.lobby.components.IconTextWrapper;
    import net.wg.gui.lobby.components.ImageWrapper;
    import net.wg.gui.lobby.components.InfoMessageComponent;
    import net.wg.gui.lobby.components.IResizableContent;
    import net.wg.gui.lobby.components.IStatisticsBodyContainerData;
    import net.wg.gui.lobby.components.MissionDetailsBg;
    import net.wg.gui.lobby.components.MissionsVehicleSelector;
    import net.wg.gui.lobby.components.PerPixelTileList;
    import net.wg.gui.lobby.components.ProfileDashLineTextItem;
    import net.wg.gui.lobby.components.ProgressIndicator;
    import net.wg.gui.lobby.components.ResizableViewStack;
    import net.wg.gui.lobby.components.RibbonAwardAnim;
    import net.wg.gui.lobby.components.RibbonAwardItemRenderer;
    import net.wg.gui.lobby.components.RibbonAwards;
    import net.wg.gui.lobby.components.ServerSlotButton;
    import net.wg.gui.lobby.components.SideBar;
    import net.wg.gui.lobby.components.SideBarRenderer;
    import net.wg.gui.lobby.components.SmallSkillGroupIcons;
    import net.wg.gui.lobby.components.SmallSkillItemRenderer;
    import net.wg.gui.lobby.components.SmallSkillsList;
    import net.wg.gui.lobby.components.StatisticsBodyContainer;
    import net.wg.gui.lobby.components.StatisticsDashLineTextItemIRenderer;
    import net.wg.gui.lobby.components.StoppableAnimationLoader;
    import net.wg.gui.lobby.components.TextWrapper;
    import net.wg.gui.lobby.components.VehicleSelectorFilter;
    import net.wg.gui.lobby.components.VehicleSelectorMultiFilter;
    import net.wg.gui.lobby.components.base.ButtonFiltersBase;
    import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
    import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
    import net.wg.gui.lobby.components.data.BaseMissionDetailsContainerVO;
    import net.wg.gui.lobby.components.data.BaseTankmanVO;
    import net.wg.gui.lobby.components.data.BoosterSlotVO;
    import net.wg.gui.lobby.components.data.BrowserVO;
    import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
    import net.wg.gui.lobby.components.data.ButtonFiltersVO;
    import net.wg.gui.lobby.components.data.DetailedLabelDataVO;
    import net.wg.gui.lobby.components.data.DetailedStatisticsLabelDataVO;
    import net.wg.gui.lobby.components.data.DetailedStatisticsUnitVO;
    import net.wg.gui.lobby.components.data.DeviceSlotVO;
    import net.wg.gui.lobby.components.data.InfoMessageVO;
    import net.wg.gui.lobby.components.data.PrimeTimeServerVO;
    import net.wg.gui.lobby.components.data.PrimeTimeVO;
    import net.wg.gui.lobby.components.data.RibbonAwardsVO;
    import net.wg.gui.lobby.components.data.SkillsVO;
    import net.wg.gui.lobby.components.data.StatisticsBodyVO;
    import net.wg.gui.lobby.components.data.StatisticsLabelDataVO;
    import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
    import net.wg.gui.lobby.components.data.StatisticsTooltipDataVO;
    import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
    import net.wg.gui.lobby.components.data.TruncateDetailedStatisticsLabelDataVO;
    import net.wg.gui.lobby.components.data.VehicleSelectMultiFilterPopoverVO;
    import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
    import net.wg.gui.lobby.components.data.VehicleSelectorMultiFilterVO;
    import net.wg.gui.lobby.components.data.VehParamVO;
    import net.wg.gui.lobby.components.events.BoosterPanelEvent;
    import net.wg.gui.lobby.components.events.DashLineTextItemRendererEvent;
    import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;
    import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
    import net.wg.gui.lobby.components.interfaces.IAwardWindow;
    import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationController;
    import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationWrapper;
    import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
    import net.wg.gui.lobby.components.interfaces.IMissionDetailsPopUpPanel;
    import net.wg.gui.lobby.components.interfaces.IMissionsVehicleSelector;
    import net.wg.gui.lobby.components.interfaces.IRibbonAwardAnim;
    import net.wg.gui.lobby.components.interfaces.IStoppableAnimation;
    import net.wg.gui.lobby.components.interfaces.IStoppableAnimationItem;
    import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoader;
    import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
    import net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleWindow;
    import net.wg.gui.lobby.confirmModuleWindow.ModuleInfoVo;
    import net.wg.gui.lobby.demonstration.DemonstratorWindow;
    import net.wg.gui.lobby.demonstration.MapItemRenderer;
    import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
    import net.wg.gui.lobby.demonstration.data.MapItemVO;
    import net.wg.gui.lobby.demoView.DemoButton;
    import net.wg.gui.lobby.demoView.DemoSubView;
    import net.wg.gui.lobby.demoView.DemoView;
    import net.wg.gui.lobby.dialogs.CheckBoxDialog;
    import net.wg.gui.lobby.dialogs.ConfirmDialog;
    import net.wg.gui.lobby.dialogs.CrewSkinsCompensationDialog;
    import net.wg.gui.lobby.dialogs.DemountDeviceDialog;
    import net.wg.gui.lobby.dialogs.DestroyDeviceDialog;
    import net.wg.gui.lobby.dialogs.FreeXPInfoWindow;
    import net.wg.gui.lobby.dialogs.IconDialog;
    import net.wg.gui.lobby.dialogs.IconPriceDialog;
    import net.wg.gui.lobby.dialogs.PMConfirmationDialog;
    import net.wg.gui.lobby.dialogs.PriceMc;
    import net.wg.gui.lobby.dialogs.TankmanOperationDialog;
    import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
    import net.wg.gui.lobby.dialogs.data.TankmanOperationDialogVO;
    import net.wg.gui.lobby.eliteWindow.EliteWindow;
    import net.wg.gui.lobby.epicBattles.components.AnimatedRewardRibbon;
    import net.wg.gui.lobby.epicBattles.components.AnimatedRewardRibbonIconContainer;
    import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesLevelUpSkillButton;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesMetaLevel;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesPrestigeProgress;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesWidget;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesWidgetButton;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesAfterBattleFameProgressBar;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesAnimatedTitleTextfield;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesFamePointsCounter;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesMetaLevelProgressBar;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesPlayerRank;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicMetaLevelProgressBarIcons;
    import net.wg.gui.lobby.epicBattles.components.common.AlignedIconTextButton;
    import net.wg.gui.lobby.epicBattles.components.common.alignedIconTextButton.AlignedIconTextButtonMainStates;
    import net.wg.gui.lobby.epicBattles.components.infoView.AvailableSkillPointsElement;
    import net.wg.gui.lobby.epicBattles.components.infoView.CombatReservesElement;
    import net.wg.gui.lobby.epicBattles.components.infoView.EndGamePanel;
    import net.wg.gui.lobby.epicBattles.components.infoView.LeftInfoViewWing;
    import net.wg.gui.lobby.epicBattles.components.infoView.MetaProgressPanel;
    import net.wg.gui.lobby.epicBattles.components.infoView.PrestigeAllowedPanel;
    import net.wg.gui.lobby.epicBattles.components.infoView.RewardRibbonSubView;
    import net.wg.gui.lobby.epicBattles.components.infoView.RightInfoViewWing;
    import net.wg.gui.lobby.epicBattles.components.infoView.TitleElement;
    import net.wg.gui.lobby.epicBattles.components.infoView.TutorialLine;
    import net.wg.gui.lobby.epicBattles.components.offlineView.Calendar;
    import net.wg.gui.lobby.epicBattles.components.offlineView.CenterBlock;
    import net.wg.gui.lobby.epicBattles.components.prestigeProgress.PrestigeProgressBlock;
    import net.wg.gui.lobby.epicBattles.components.prestigeProgress.VehicleRewardProgressBlock;
    import net.wg.gui.lobby.epicBattles.components.prestigeView.ActionsButtonBar;
    import net.wg.gui.lobby.epicBattles.components.prestigeView.PrestigeOverlay;
    import net.wg.gui.lobby.epicBattles.components.prestigeView.RewardRibbon;
    import net.wg.gui.lobby.epicBattles.components.prestigeView.TextBlock;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillBarSection;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillImage;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillLevelBar;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillsGroup;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesSkillTile;
    import net.wg.gui.lobby.epicBattles.components.skillView.EpicBattlesUnspentPoints;
    import net.wg.gui.lobby.epicBattles.components.skillView.SkillInfoPane;
    import net.wg.gui.lobby.epicBattles.components.skillView.SkillInfoPaneContent;
    import net.wg.gui.lobby.epicBattles.components.skillView.SkillLevelUpAnimationContainer;
    import net.wg.gui.lobby.epicBattles.components.skillView.SkillStatsPanel;
    import net.wg.gui.lobby.epicBattles.components.skillView.StatusDeltaParameterBlock;
    import net.wg.gui.lobby.epicBattles.components.skillView.TextParameterBlock;
    import net.wg.gui.lobby.epicBattles.components.welcomeBackView.InfoItemRenderer;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesAfterBattleViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoCombatReservesVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoMetaProgressVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillInitVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesMetaLevelVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesOfflineViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeProgressBlockVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeProgressVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesRewardRibbonVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesSkillViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesWelcomeBackViewVO;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
    import net.wg.gui.lobby.epicBattles.data.EpicMetaLevelIconVO;
    import net.wg.gui.lobby.epicBattles.data.FrontlineBuyConfirmVO;
    import net.wg.gui.lobby.epicBattles.data.InfoItemRendererVO;
    import net.wg.gui.lobby.epicBattles.events.AfterBattleFameBarEvent;
    import net.wg.gui.lobby.epicBattles.events.EpicBattleInfoViewClickEvent;
    import net.wg.gui.lobby.epicBattles.events.EpicBattlePrestigeViewClickEvent;
    import net.wg.gui.lobby.epicBattles.events.EpicBattlesSkillViewClickEvent;
    import net.wg.gui.lobby.epicBattles.events.RewardRibbonSubViewEvent;
    import net.wg.gui.lobby.epicBattles.events.SkillLevelBarMouseEvent;
    import net.wg.gui.lobby.epicBattles.interfaces.skillView.ISkillParameterBlock;
    import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesAfterBattleView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesBrowserView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesInfoView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesOfflineView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesPrestigeView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesSkillView;
    import net.wg.gui.lobby.epicBattles.views.EpicBattlesWelcomeBackView;
    import net.wg.gui.lobby.epicBattles.views.FrontlineBuyConfirmView;
    import net.wg.gui.lobby.eventBoards.EventBoardsDetailsContainerView;
    import net.wg.gui.lobby.eventBoards.EventBoardsTableView;
    import net.wg.gui.lobby.eventBoards.MissionsEventBoardsView;
    import net.wg.gui.lobby.eventBoards.components.AwardGroups;
    import net.wg.gui.lobby.eventBoards.components.AwardsRibbonBg;
    import net.wg.gui.lobby.eventBoards.components.AwardsTableHeader;
    import net.wg.gui.lobby.eventBoards.components.AwardStripeRenderer;
    import net.wg.gui.lobby.eventBoards.components.BasePlayerAwardRenderer;
    import net.wg.gui.lobby.eventBoards.components.BasePlayerBattleRenderer;
    import net.wg.gui.lobby.eventBoards.components.BattleViewTableHeader;
    import net.wg.gui.lobby.eventBoards.components.EventBoardsVehicleSelector;
    import net.wg.gui.lobby.eventBoards.components.LevelTypeFlagRenderer;
    import net.wg.gui.lobby.eventBoards.components.LevelTypeFlagRendererText;
    import net.wg.gui.lobby.eventBoards.components.MaintenanceComponent;
    import net.wg.gui.lobby.eventBoards.components.MissionsEventBoardsBody;
    import net.wg.gui.lobby.eventBoards.components.MissionsEventBoardsCardRenderer;
    import net.wg.gui.lobby.eventBoards.components.MissionsEventBoardsHeader;
    import net.wg.gui.lobby.eventBoards.components.OverlayAwardsRenderer;
    import net.wg.gui.lobby.eventBoards.components.Pagination;
    import net.wg.gui.lobby.eventBoards.components.TableViewHeader;
    import net.wg.gui.lobby.eventBoards.components.TableViewStatus;
    import net.wg.gui.lobby.eventBoards.components.TableViewTableHeader;
    import net.wg.gui.lobby.eventBoards.components.TopPlayerAwardRenderer;
    import net.wg.gui.lobby.eventBoards.components.VehicleItemRenderer;
    import net.wg.gui.lobby.eventBoards.components.VehicleSelectorItemRenderer;
    import net.wg.gui.lobby.eventBoards.components.battleComponents.BattleExperienceBlock;
    import net.wg.gui.lobby.eventBoards.components.battleComponents.BattleStatisticsBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderAwardBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderConditionBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderDescBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderReloginBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderServerBlock;
    import net.wg.gui.lobby.eventBoards.components.headerComponents.TextFieldNoSound;
    import net.wg.gui.lobby.eventBoards.components.interfaces.IAwardGroups;
    import net.wg.gui.lobby.eventBoards.components.interfaces.IMaintenanceComponent;
    import net.wg.gui.lobby.eventBoards.components.interfaces.IPagination;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsDetailsAwardsTableContent;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsDetailsAwardsView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsDetailsBattleView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsDetailsBrowserView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsDetailsVehiclesView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsResultFilterPopoverView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardsResultFilterVehiclesPopoverView;
    import net.wg.gui.lobby.eventBoards.components.view.EventBoardTableContent;
    import net.wg.gui.lobby.eventBoards.data.AwardsListRendererVO;
    import net.wg.gui.lobby.eventBoards.data.AwardsTableVO;
    import net.wg.gui.lobby.eventBoards.data.AwardStripeRendererVO;
    import net.wg.gui.lobby.eventBoards.data.BaseEventBoardTableRendererVO;
    import net.wg.gui.lobby.eventBoards.data.BasePlayerAwardRendererVO;
    import net.wg.gui.lobby.eventBoards.data.BasePlayerBattleRendererVO;
    import net.wg.gui.lobby.eventBoards.data.BattleExperienceBlockVO;
    import net.wg.gui.lobby.eventBoards.data.BattleStatisticsBlockVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsAwardsOverlayVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsBattleOverlayVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsDetailsContainerVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewHeaderVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewStatusVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsVehiclesOverlayVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardsVehicleVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVehiclesVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderIconVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
    import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
    import net.wg.gui.lobby.eventBoards.data.HeaderAwardBlockVO;
    import net.wg.gui.lobby.eventBoards.data.HeaderConditionBlockVO;
    import net.wg.gui.lobby.eventBoards.data.HeaderDescBlockVO;
    import net.wg.gui.lobby.eventBoards.data.HeaderReloginBlockVO;
    import net.wg.gui.lobby.eventBoards.data.HeaderServerBlockVO;
    import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsBodyVO;
    import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsCardVO;
    import net.wg.gui.lobby.eventBoards.data.MissionEventBoardsHeaderVO;
    import net.wg.gui.lobby.eventBoards.data.MissionsEventBoardsPackVO;
    import net.wg.gui.lobby.eventBoards.data.TopPlayerAwardRendererVO;
    import net.wg.gui.lobby.eventBoards.data.VehicleRendererItemVO;
    import net.wg.gui.lobby.eventBoards.events.AwardsRendererEvent;
    import net.wg.gui.lobby.eventBoards.events.FilterRendererEvent;
    import net.wg.gui.lobby.eventBoards.events.MissionPremiumEvent;
    import net.wg.gui.lobby.eventBoards.events.PlayerRendererEvent;
    import net.wg.gui.lobby.eventBoards.events.ServerEvent;
    import net.wg.gui.lobby.eventBoards.events.TypeEvent;
    import net.wg.gui.lobby.eventInfoPanel.EventInfoPanel;
    import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelItemVO;
    import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
    import net.wg.gui.lobby.eventInfoPanel.interfaces.IEventInfoPanel;
    import net.wg.gui.lobby.fortifications.FortBattleRoomWindow;
    import net.wg.gui.lobby.fortifications.battleRoom.FortBattleRoomWaitListSection;
    import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieDetailsSection;
    import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieDetailsSectionAlertView;
    import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieSection;
    import net.wg.gui.lobby.fortifications.battleRoom.LegionariesCandidateItemRenderer;
    import net.wg.gui.lobby.fortifications.battleRoom.LegionariesDataProvider;
    import net.wg.gui.lobby.fortifications.battleRoom.SortieChatSection;
    import net.wg.gui.lobby.fortifications.battleRoom.SortieListRenderer;
    import net.wg.gui.lobby.fortifications.battleRoom.SortieSlotHelper;
    import net.wg.gui.lobby.fortifications.battleRoom.SortieTeamSection;
    import net.wg.gui.lobby.fortifications.battleRoom.SortieWaitListSection;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.AdvancedClanBattleTimer;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleCreatorView;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleTableRenderer;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleTimer;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleRoom;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleTeamSection;
    import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.JoinClanBattleSection;
    import net.wg.gui.lobby.fortifications.cmp.IFortDisconnectView;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SlotButtonFilters;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirects;
    import net.wg.gui.lobby.fortifications.cmp.impl.FortDisconnectView;
    import net.wg.gui.lobby.fortifications.cmp.selector.FortVehicleSelector;
    import net.wg.gui.lobby.fortifications.cmp.selector.FortVehicleSelectorFilter;
    import net.wg.gui.lobby.fortifications.cmp.selector.FortVehicleSelectorRenderer;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSlotsVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.SortieAlertViewVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.SortieSlotVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleRenderListVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
    import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectorFilterVO;
    import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectorItemVO;
    import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectPopoverData;
    import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectPopoverVO;
    import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
    import net.wg.gui.lobby.fortifications.events.ClanBattleSlotEvent;
    import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
    import net.wg.gui.lobby.fortifications.events.DirectionEvent;
    import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
    import net.wg.gui.lobby.fortifications.popovers.FortVehicleSelectPopover;
    import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
    import net.wg.gui.lobby.goldFishEvent.GoldFishWindow;
    import net.wg.gui.lobby.hangar.CrewDropDownEvent;
    import net.wg.gui.lobby.hangar.Hangar;
    import net.wg.gui.lobby.hangar.HangarHeader;
    import net.wg.gui.lobby.hangar.LootboxesEntrancePointWidget;
    import net.wg.gui.lobby.hangar.NYCreditBonus;
    import net.wg.gui.lobby.hangar.ResearchPanel;
    import net.wg.gui.lobby.hangar.SwitchModePanel;
    import net.wg.gui.lobby.hangar.TmenXpPanel;
    import net.wg.gui.lobby.hangar.VehicleParameters;
    import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
    import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
    import net.wg.gui.lobby.hangar.ammunitionPanel.BattleAbilitiesHighlighter;
    import net.wg.gui.lobby.hangar.ammunitionPanel.BattleAbilitySlot;
    import net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;
    import net.wg.gui.lobby.hangar.ammunitionPanel.IAmmunitionPanel;
    import net.wg.gui.lobby.hangar.ammunitionPanel.VehicleStateMsg;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.AmmunitionPanelVO;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
    import net.wg.gui.lobby.hangar.crew.Crew;
    import net.wg.gui.lobby.hangar.crew.CrewDogItem;
    import net.wg.gui.lobby.hangar.crew.CrewItemLabel;
    import net.wg.gui.lobby.hangar.crew.CrewItemRenderer;
    import net.wg.gui.lobby.hangar.crew.CrewScrollingList;
    import net.wg.gui.lobby.hangar.crew.IconsProps;
    import net.wg.gui.lobby.hangar.crew.ICrew;
    import net.wg.gui.lobby.hangar.crew.RecruitItemRenderer;
    import net.wg.gui.lobby.hangar.crew.TankmanRoleVO;
    import net.wg.gui.lobby.hangar.crew.TankmanTextCreator;
    import net.wg.gui.lobby.hangar.crew.TankmanVO;
    import net.wg.gui.lobby.hangar.crew.TankmenIcons;
    import net.wg.gui.lobby.hangar.crew.TankmenResponseVO;
    import net.wg.gui.lobby.hangar.crew.ev.CrewDogEvent;
    import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
    import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
    import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;
    import net.wg.gui.lobby.hangar.data.HeaderQuestsVO;
    import net.wg.gui.lobby.hangar.data.ModuleInfoActionVO;
    import net.wg.gui.lobby.hangar.data.ResearchPanelVO;
    import net.wg.gui.lobby.hangar.data.SwitchModePanelVO;
    import net.wg.gui.lobby.hangar.interfaces.IHangar;
    import net.wg.gui.lobby.hangar.interfaces.IHangarHeader;
    import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
    import net.wg.gui.lobby.hangar.interfaces.IQuestInformerButton;
    import net.wg.gui.lobby.hangar.interfaces.IQuestsButtonsContainer;
    import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
    import net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
    import net.wg.gui.lobby.hangar.maintenance.EquipmentListItemRenderer;
    import net.wg.gui.lobby.hangar.maintenance.FittingSelectDropDown;
    import net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;
    import net.wg.gui.lobby.hangar.maintenance.ShellItemRenderer;
    import net.wg.gui.lobby.hangar.maintenance.ShellListItemRenderer;
    import net.wg.gui.lobby.hangar.maintenance.TechnicalMaintenance;
    import net.wg.gui.lobby.hangar.maintenance.data.HistoricalAmmoVO;
    import net.wg.gui.lobby.hangar.quests.FlagContainer;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsContainer;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
    import net.wg.gui.lobby.hangar.quests.HEADER_QUESTS_CONSTANTS;
    import net.wg.gui.lobby.hangar.quests.QuestFlagIconContainer;
    import net.wg.gui.lobby.hangar.quests.QuestInformerButton;
    import net.wg.gui.lobby.hangar.quests.QuestInformerContent;
    import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPoint;
    import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPointHangar;
    import net.wg.gui.lobby.hangar.seniorityAwards.SeniorityAwardsEntryPointVO;
    import net.wg.gui.lobby.hangar.tcarousel.BaseTankIcon;
    import net.wg.gui.lobby.hangar.tcarousel.ClanLockUI;
    import net.wg.gui.lobby.hangar.tcarousel.ITankCarousel;
    import net.wg.gui.lobby.hangar.tcarousel.MultiselectionInfoBlock;
    import net.wg.gui.lobby.hangar.tcarousel.MultiselectionSlotRenderer;
    import net.wg.gui.lobby.hangar.tcarousel.MultiselectionSlots;
    import net.wg.gui.lobby.hangar.tcarousel.NYVehicleBonus;
    import net.wg.gui.lobby.hangar.tcarousel.SmallTankIcon;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
    import net.wg.gui.lobby.hangar.tcarousel.TankIcon;
    import net.wg.gui.lobby.hangar.tcarousel.VehicleSelectorCarousel;
    import net.wg.gui.lobby.hangar.tcarousel.data.FilterComponentViewVO;
    import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionInfoVO;
    import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionSlotVO;
    import net.wg.gui.lobby.hangar.tcarousel.event.SlotEvent;
    import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
    import net.wg.gui.lobby.hangar.tcarousel.helper.TankCarouselStatsFormatter;
    import net.wg.gui.lobby.hangar.vehicleParameters.components.VehParamRenderer;
    import net.wg.gui.lobby.header.AccountClanPopoverBlock;
    import net.wg.gui.lobby.header.AccountPopover;
    import net.wg.gui.lobby.header.AccountPopoverBlock;
    import net.wg.gui.lobby.header.AccountPopoverBlockBase;
    import net.wg.gui.lobby.header.AccountPopoverReferralBlock;
    import net.wg.gui.lobby.header.BadgeSlot;
    import net.wg.gui.lobby.header.IAccountClanPopOverBlock;
    import net.wg.gui.lobby.header.LobbyHeader;
    import net.wg.gui.lobby.header.NYWidgetUI;
    import net.wg.gui.lobby.header.OnlineCounter;
    import net.wg.gui.lobby.header.TankPanel;
    import net.wg.gui.lobby.header.events.AccountPopoverEvent;
    import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
    import net.wg.gui.lobby.header.events.HeaderEvents;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Account;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_AccountUpper;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_ActionItem;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_BattleSelector;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Finance;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Prem;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_PremShop;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Settings;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Squad;
    import net.wg.gui.lobby.header.headerButtonBar.HBC_Upper;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonActionContent;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonContentItem;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
    import net.wg.gui.lobby.header.interfaces.ILobbyHeader;
    import net.wg.gui.lobby.header.itemSelectorPopover.BattleTypeSelectPopoverDemonstrator;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorList;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorPopover;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRenderer;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRendererVO;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorTooltipDataVO;
    import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
    import net.wg.gui.lobby.header.rankedBattles.SparkAnim;
    import net.wg.gui.lobby.header.vo.AccountBoosterVO;
    import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
    import net.wg.gui.lobby.header.vo.AccountDataVo;
    import net.wg.gui.lobby.header.vo.AccountPopoverBlockVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
    import net.wg.gui.lobby.header.vo.HBC_AbstractVO;
    import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
    import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import net.wg.gui.lobby.header.vo.IHBC_VO;
    import net.wg.gui.lobby.imageView.ImageView;
    import net.wg.gui.lobby.interfaces.ILobbyPage;
    import net.wg.gui.lobby.interfaces.ISubtaskComponent;
    import net.wg.gui.lobby.invites.SendInvitesWindow;
    import net.wg.gui.lobby.invites.controls.CandidatesList;
    import net.wg.gui.lobby.invites.controls.CandidatesListItemRenderer;
    import net.wg.gui.lobby.invites.controls.SearchListDragController;
    import net.wg.gui.lobby.invites.controls.SearchListDropDelegate;
    import net.wg.gui.lobby.invites.controls.TreeDragController;
    import net.wg.gui.lobby.invites.controls.TreeDropDelegate;
    import net.wg.gui.lobby.linkedSet.LinkedSetDetailsContainerView;
    import net.wg.gui.lobby.linkedSet.LinkedSetHintsView;
    import net.wg.gui.lobby.linkedSet.components.AnimatedMovieClipContainer;
    import net.wg.gui.lobby.linkedSet.components.LinkedSetAward;
    import net.wg.gui.lobby.linkedSet.components.LinkedSetVideo;
    import net.wg.gui.lobby.linkedSet.components.MissionsLinkedSetBody;
    import net.wg.gui.lobby.linkedSet.components.MissionsLinkedSetCardRenderer;
    import net.wg.gui.lobby.linkedSet.components.MissionsLinkedSetHeader;
    import net.wg.gui.lobby.linkedSet.components.MissionsPaginator;
    import net.wg.gui.lobby.linkedSet.components.view.LinkedSetDetailsView;
    import net.wg.gui.lobby.linkedSet.data.LinkedSetAwardVO;
    import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsContainerVO;
    import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsOverlayVO;
    import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsVideoVO;
    import net.wg.gui.lobby.linkedSet.data.LinkedSetHintsVO;
    import net.wg.gui.lobby.linkedSet.data.MissionLinkedSetBodyVO;
    import net.wg.gui.lobby.linkedSet.data.MissionLinkedSetCardVO;
    import net.wg.gui.lobby.linkedSet.data.MissionLinkedSetHeaderVO;
    import net.wg.gui.lobby.linkedSet.popups.VehicleListPopup;
    import net.wg.gui.lobby.lobbyVehicleMarkerView.LobbyVehicleMarkerView;
    import net.wg.gui.lobby.manual.ManualMainView;
    import net.wg.gui.lobby.manual.controls.ChapterItemRenderer;
    import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;
    import net.wg.gui.lobby.manualChapter.ManualChapterView;
    import net.wg.gui.lobby.manualChapter.ManualPageView;
    import net.wg.gui.lobby.manualChapter.controls.BootcampContainer;
    import net.wg.gui.lobby.manualChapter.controls.DescriptionContainer;
    import net.wg.gui.lobby.manualChapter.controls.HintRenderer;
    import net.wg.gui.lobby.manualChapter.controls.HintsContainer;
    import net.wg.gui.lobby.manualChapter.controls.ManualBackgroundContainer;
    import net.wg.gui.lobby.manualChapter.controls.PageContentTemplate;
    import net.wg.gui.lobby.manualChapter.controls.TextContainer;
    import net.wg.gui.lobby.manualChapter.data.ManualChapterBootcampVO;
    import net.wg.gui.lobby.manualChapter.data.ManualChapterContainerVO;
    import net.wg.gui.lobby.manualChapter.data.ManualChapterHintsVO;
    import net.wg.gui.lobby.manualChapter.data.ManualChapterHintVO;
    import net.wg.gui.lobby.manualChapter.data.ManualPageDetailedViewVO;
    import net.wg.gui.lobby.manualChapter.events.ManualViewEvent;
    import net.wg.gui.lobby.menu.LobbyMenu;
    import net.wg.gui.lobby.messengerBar.ButtonWithCounter;
    import net.wg.gui.lobby.messengerBar.MessegerBarInitVO;
    import net.wg.gui.lobby.messengerBar.MessengerBar;
    import net.wg.gui.lobby.messengerBar.MessengerChannelCarouselItem;
    import net.wg.gui.lobby.messengerBar.MessengerIconButton;
    import net.wg.gui.lobby.messengerBar.NotificationListButton;
    import net.wg.gui.lobby.messengerBar.PrebattleChannelCarouselItem;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
    import net.wg.gui.lobby.messengerBar.carousel.BaseChannelCarouselItem;
    import net.wg.gui.lobby.messengerBar.carousel.BaseChannelRenderer;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelButton;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelCarouselScrollBar;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelList;
    import net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
    import net.wg.gui.lobby.messengerBar.carousel.FlexibleTileList;
    import net.wg.gui.lobby.messengerBar.carousel.PreBattleChannelRenderer;
    import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
    import net.wg.gui.lobby.messengerBar.carousel.data.IToolTipData;
    import net.wg.gui.lobby.messengerBar.carousel.data.MessengerBarConstants;
    import net.wg.gui.lobby.messengerBar.carousel.data.ReadyDataVO;
    import net.wg.gui.lobby.messengerBar.carousel.data.TooltipDataVO;
    import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
    import net.wg.gui.lobby.messengerBar.carousel.events.MessengerBarChannelCarouselEvent;
    import net.wg.gui.lobby.messengerBar.interfaces.IBaseChannelCarouselItem;
    import net.wg.gui.lobby.messengerBar.interfaces.INotificationListButton;
    import net.wg.gui.lobby.missions.CurrentVehicleMissionsView;
    import net.wg.gui.lobby.missions.MissionDetailedView;
    import net.wg.gui.lobby.missions.MissionDetailsContainerView;
    import net.wg.gui.lobby.missions.MissionsFilterPopoverView;
    import net.wg.gui.lobby.missions.MissionsGroupedView;
    import net.wg.gui.lobby.missions.MissionsMarathonView;
    import net.wg.gui.lobby.missions.MissionsPage;
    import net.wg.gui.lobby.missions.MissionsTokenPopover;
    import net.wg.gui.lobby.missions.MissionsViewBase;
    import net.wg.gui.lobby.missions.components.AwardGroup;
    import net.wg.gui.lobby.missions.components.MissionAltConditionsContainer;
    import net.wg.gui.lobby.missions.components.MissionCardAltConditionsContainer;
    import net.wg.gui.lobby.missions.components.MissionCardConditionRenderer;
    import net.wg.gui.lobby.missions.components.MissionCardRenderer;
    import net.wg.gui.lobby.missions.components.MissionConditionRenderer;
    import net.wg.gui.lobby.missions.components.MissionConditionsListContainer;
    import net.wg.gui.lobby.missions.components.MissionDetailsAltConditionsContainer;
    import net.wg.gui.lobby.missions.components.MissionPackCategoryHeader;
    import net.wg.gui.lobby.missions.components.MissionPackCurrentVehicleHeader;
    import net.wg.gui.lobby.missions.components.MissionPackHeaderBase;
    import net.wg.gui.lobby.missions.components.MissionPackMarathonBody;
    import net.wg.gui.lobby.missions.components.MissionPackMarathonHeader;
    import net.wg.gui.lobby.missions.components.MissionPackRenderer;
    import net.wg.gui.lobby.missions.components.MissionsCounterDelegate;
    import net.wg.gui.lobby.missions.components.MissionsFilter;
    import net.wg.gui.lobby.missions.components.MissionsList;
    import net.wg.gui.lobby.missions.components.MissionsTokenListRenderer;
    import net.wg.gui.lobby.missions.components.MissionVehicleItemRenderer;
    import net.wg.gui.lobby.missions.components.MissionVehicleParamRenderer;
    import net.wg.gui.lobby.missions.components.MissionVehicleTypeRenderer;
    import net.wg.gui.lobby.missions.components.detailedView.AbstractPopoverWithScrollableGroupPanel;
    import net.wg.gui.lobby.missions.components.detailedView.ConditionsComponentPanel;
    import net.wg.gui.lobby.missions.components.detailedView.MissionAccountRequirementRenderer;
    import net.wg.gui.lobby.missions.components.detailedView.MissionBattleRequirementRenderer;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailedConditionRenderer;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsAccountRequirementsPanel;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsAchievement;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsAwardsPanel;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsConditionRendererAbstract;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsConditionRendererSmall;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsConditionsListContainer;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsConditionsPanel;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsTokenRenderer;
    import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsTopPanel;
    import net.wg.gui.lobby.missions.components.detailedView.VerticalCenterAlignedLayout;
    import net.wg.gui.lobby.missions.components.headerComponents.AwardsTileList;
    import net.wg.gui.lobby.missions.components.headerComponents.CollapsedHeaderTitleBlock;
    import net.wg.gui.lobby.missions.components.headerComponents.CurrentVehicleHeaderTitleBlock;
    import net.wg.gui.lobby.missions.components.headerComponents.HeaderDescBlock;
    import net.wg.gui.lobby.missions.components.headerComponents.HeaderTitleBlockBase;
    import net.wg.gui.lobby.missions.components.headerComponents.MarathonHeaderAwardBlock;
    import net.wg.gui.lobby.missions.components.headerComponents.MarathonHeaderConditionBlock;
    import net.wg.gui.lobby.missions.components.headerComponents.MarathonHeaderConditionItemRenderer;
    import net.wg.gui.lobby.missions.components.headerComponents.MissionHeaderAction;
    import net.wg.gui.lobby.missions.components.headerComponents.MissionHeaderCalendar;
    import net.wg.gui.lobby.missions.data.CollapsedHeaderTitleBlockVO;
    import net.wg.gui.lobby.missions.data.ConditionRendererVO;
    import net.wg.gui.lobby.missions.data.CurrentVehicleHeaderTitleBlockVO;
    import net.wg.gui.lobby.missions.data.HeaderDescBlockVO;
    import net.wg.gui.lobby.missions.data.HeaderTitleBlockBaseVO;
    import net.wg.gui.lobby.missions.data.MarathonHeaderAwardBlockVO;
    import net.wg.gui.lobby.missions.data.MarathonHeaderConditionBlockVO;
    import net.wg.gui.lobby.missions.data.MissionAccountRequirementRendererVO;
    import net.wg.gui.lobby.missions.data.MissionAccountRequirementsVO;
    import net.wg.gui.lobby.missions.data.MissionAltConditionsContainerVO;
    import net.wg.gui.lobby.missions.data.MissionBattleRequirementRendererVO;
    import net.wg.gui.lobby.missions.data.MissionCardViewVO;
    import net.wg.gui.lobby.missions.data.MissionConditionDetailsVO;
    import net.wg.gui.lobby.missions.data.MissionConditionsContainerVO;
    import net.wg.gui.lobby.missions.data.MissionConditionVO;
    import net.wg.gui.lobby.missions.data.MissionDetailedViewVO;
    import net.wg.gui.lobby.missions.data.MissionDetailsAchievementRendererVO;
    import net.wg.gui.lobby.missions.data.MissionDetailsContainerVO;
    import net.wg.gui.lobby.missions.data.MissionDetailsPopUpPanelVO;
    import net.wg.gui.lobby.missions.data.MissionDetailsTokenRendererVO;
    import net.wg.gui.lobby.missions.data.MissionHeaderActionVO;
    import net.wg.gui.lobby.missions.data.MissionPackCategoryHeaderVO;
    import net.wg.gui.lobby.missions.data.MissionPackCurrentVehicleHeaderVO;
    import net.wg.gui.lobby.missions.data.MissionPackHeaderBaseVO;
    import net.wg.gui.lobby.missions.data.MissionPackMarathonBodyVO;
    import net.wg.gui.lobby.missions.data.MissionPackMarathonHeaderVO;
    import net.wg.gui.lobby.missions.data.MissionProgressVO;
    import net.wg.gui.lobby.missions.data.MissionsFilterPopoverInitVO;
    import net.wg.gui.lobby.missions.data.MissionsFilterPopoverStateVO;
    import net.wg.gui.lobby.missions.data.MissionsPackVO;
    import net.wg.gui.lobby.missions.data.MissionsTankVO;
    import net.wg.gui.lobby.missions.data.MissionsTokenPopoverVO;
    import net.wg.gui.lobby.missions.data.MissionTabCounterVO;
    import net.wg.gui.lobby.missions.data.MissionTabVO;
    import net.wg.gui.lobby.missions.data.MissionVehicleItemRendererVO;
    import net.wg.gui.lobby.missions.data.MissionVehicleParamRendererVO;
    import net.wg.gui.lobby.missions.data.MissionVehicleSelectorVO;
    import net.wg.gui.lobby.missions.data.MissionVehicleTypeRendererVO;
    import net.wg.gui.lobby.missions.data.TokenRendererVO;
    import net.wg.gui.lobby.missions.event.MissionConditionRendererEvent;
    import net.wg.gui.lobby.missions.event.MissionDetailedConditionRendererEvent;
    import net.wg.gui.lobby.missions.event.MissionDetailsTopPanelEvent;
    import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
    import net.wg.gui.lobby.missions.event.MissionsTokenListRendererEvent;
    import net.wg.gui.lobby.missions.event.MissionViewEvent;
    import net.wg.gui.lobby.missions.interfaces.IConditionVO;
    import net.wg.gui.lobby.missions.interfaces.IMarathonHeaderBlock;
    import net.wg.gui.lobby.missions.interfaces.IMissionPackBody;
    import net.wg.gui.lobby.missions.interfaces.IMissionPackHeader;
    import net.wg.gui.lobby.moduleInfo.ModuleEffects;
    import net.wg.gui.lobby.moduleInfo.ModuleParameters;
    import net.wg.gui.lobby.modulesPanel.DeviceIndexHelper;
    import net.wg.gui.lobby.modulesPanel.FittingSelectPopover;
    import net.wg.gui.lobby.modulesPanel.ModulesPanel;
    import net.wg.gui.lobby.modulesPanel.components.BattleAbilityItemRenderer;
    import net.wg.gui.lobby.modulesPanel.components.BoosterFittingItemRenderer;
    import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
    import net.wg.gui.lobby.modulesPanel.components.ExtraIcon;
    import net.wg.gui.lobby.modulesPanel.components.FittingListItemRenderer;
    import net.wg.gui.lobby.modulesPanel.components.FittingListSelectionNavigator;
    import net.wg.gui.lobby.modulesPanel.components.ListOverlay;
    import net.wg.gui.lobby.modulesPanel.components.ModuleFittingItemRenderer;
    import net.wg.gui.lobby.modulesPanel.components.ModuleSlot;
    import net.wg.gui.lobby.modulesPanel.components.OptDeviceFittingItemRenderer;
    import net.wg.gui.lobby.modulesPanel.data.BattleAbilityVO;
    import net.wg.gui.lobby.modulesPanel.data.BoosterFittingItemVO;
    import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
    import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
    import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
    import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
    import net.wg.gui.lobby.modulesPanel.data.ListOverlayVO;
    import net.wg.gui.lobby.modulesPanel.data.ModuleVO;
    import net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO;
    import net.wg.gui.lobby.modulesPanel.interfaces.IDeviceSlot;
    import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
    import net.wg.gui.lobby.ny2020.NYCustomizationSlot;
    import net.wg.gui.lobby.ny2020.NYSelectVehiclePopover;
    import net.wg.gui.lobby.ny2020.NYSelectVehicleRenderer;
    import net.wg.gui.lobby.ny2020.NYVehicleBonusPanel;
    import net.wg.gui.lobby.ny2020.NYVehicleSelectorFilter;
    import net.wg.gui.lobby.ny2020.vo.NYSelectVehiclePopoverVO;
    import net.wg.gui.lobby.personalMissions.CampaignOperationsContainer;
    import net.wg.gui.lobby.personalMissions.PersonalMissionsPage;
    import net.wg.gui.lobby.personalMissions.components.AllOperationsContent;
    import net.wg.gui.lobby.personalMissions.components.OperationButton;
    import net.wg.gui.lobby.personalMissions.components.OperationButtonPostponed;
    import net.wg.gui.lobby.personalMissions.components.OperationRenderer;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardBtnAnim;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardBtnReflect;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardRenderer;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardsContainer;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardsScreen;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardsScreenBgAnim;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardsScreenHeaderAnim;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionDetailedView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionDetailsContainerView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionExtraAwardAnim;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionExtraAwardDesc;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionFirstEntryAwardView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionFirstEntryView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionMapBgContainer;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionOperations;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionPlansLoaderMgr;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsAbstractInfoView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsAwardsView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsMapView;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsPlan;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsPlanRegion;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsPlanRegionCheck;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsPlanRegionDigit;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsQuestAwardScreen;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsRegionAwards;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionVehicleAward;
    import net.wg.gui.lobby.personalMissions.components.PMPaginatorArrowsController;
    import net.wg.gui.lobby.personalMissions.components.SmokeGenerator;
    import net.wg.gui.lobby.personalMissions.components.ToSeasonBtn;
    import net.wg.gui.lobby.personalMissions.components.UseAwardSheetWindow;
    import net.wg.gui.lobby.personalMissions.components.awardsView.AdditionalAwards;
    import net.wg.gui.lobby.personalMissions.components.awardsView.AwardHeader;
    import net.wg.gui.lobby.personalMissions.components.awardsView.PersonalMissionsItemSlot;
    import net.wg.gui.lobby.personalMissions.components.awardsView.PersonalMissionsVehicleSlot;
    import net.wg.gui.lobby.personalMissions.components.awardsView.VehicleAward;
    import net.wg.gui.lobby.personalMissions.components.chainsPanel.ChainButton;
    import net.wg.gui.lobby.personalMissions.components.chainsPanel.ChainButtonContent;
    import net.wg.gui.lobby.personalMissions.components.chainsPanel.ChainsPanel;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoAdditionalBlock;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoAdditionalContent;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoAdditionalContentPage;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoAdditionalNotification;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoContent;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoItemRenderer;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.InfoItemRendererBg;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.MoreTextAnim;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoAdditionalViewSettings;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoVewSettings;
    import net.wg.gui.lobby.personalMissions.components.firstEntry.PMInfoVewSettingsCore;
    import net.wg.gui.lobby.personalMissions.components.interfaces.IAwardSheetPopup;
    import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButton;
    import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButtonContent;
    import net.wg.gui.lobby.personalMissions.components.interfaces.IChainsPanel;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.FreeSheetsCounter;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.Operation;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationDescription;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationsContainer;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationsHeader;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationTitle;
    import net.wg.gui.lobby.personalMissions.components.operationsHeader.OperationTitleInfo;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.AbstractFreeSheetPopup;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.AwardSheetAcceptBtnCmp;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.AwardSheetAnimation;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.AwardSheetTextBlocks;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.BottomBlock;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.FourFreeSheetsObtainedPopup;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.FreeSheetObtainedPopup;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.FreeSheetTitle;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.HeaderBlock;
    import net.wg.gui.lobby.personalMissions.components.popupComponents.IconTextRenderer;
    import net.wg.gui.lobby.personalMissions.components.questAwardScreen.QuestConditions;
    import net.wg.gui.lobby.personalMissions.components.questAwardScreen.QuestStatus;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.BasicFooterBlock;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.FreeSheetPopover;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.PawnedSheetListRenderer;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.SheetsBlock;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.SheetsInfoBlock;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.StatusFooter;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.TankgirlsBlock;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.TankgirlsListRenderer;
    import net.wg.gui.lobby.personalMissions.components.statusFooter.TankgirlsPopover;
    import net.wg.gui.lobby.personalMissions.data.AdditionalAwardsVO;
    import net.wg.gui.lobby.personalMissions.data.BasicFooterBlockVO;
    import net.wg.gui.lobby.personalMissions.data.ChainButtonVO;
    import net.wg.gui.lobby.personalMissions.data.ChainsPanelVO;
    import net.wg.gui.lobby.personalMissions.data.FourFreeSheetsObtainedPopupVO;
    import net.wg.gui.lobby.personalMissions.data.FreeSheetObtainedPopupVO;
    import net.wg.gui.lobby.personalMissions.data.FreeSheetPopoverData;
    import net.wg.gui.lobby.personalMissions.data.FreeSheetPopoverVO;
    import net.wg.gui.lobby.personalMissions.data.IconTextRendererVO;
    import net.wg.gui.lobby.personalMissions.data.InfoAdditionalBlockDataVO;
    import net.wg.gui.lobby.personalMissions.data.InfoAdditionalDataVO;
    import net.wg.gui.lobby.personalMissions.data.InfoItemRendererVO;
    import net.wg.gui.lobby.personalMissions.data.MapSettingsData;
    import net.wg.gui.lobby.personalMissions.data.OperationAwardsVO;
    import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
    import net.wg.gui.lobby.personalMissions.data.OperationsHeaderVO;
    import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
    import net.wg.gui.lobby.personalMissions.data.OperationVO;
    import net.wg.gui.lobby.personalMissions.data.PawnedSheetVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardRendererVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardsScreenVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionDetailedViewVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionDetailsContainerVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionFirstEntryViewVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAbstractInfoViewVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAwardsViewVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsItemSlotVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsMapPlanVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsPlanRegionVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsQuestAwardScreenVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsRegionAwardsVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionsVehicleSlotVO;
    import net.wg.gui.lobby.personalMissions.data.PersonalMissionVehicleAwardVO;
    import net.wg.gui.lobby.personalMissions.data.PMAwardHeaderVO;
    import net.wg.gui.lobby.personalMissions.data.QuestRecruitWindowVO;
    import net.wg.gui.lobby.personalMissions.data.SheetsBlockVO;
    import net.wg.gui.lobby.personalMissions.data.SheetsInfoBlockVO;
    import net.wg.gui.lobby.personalMissions.data.StatusFooterVO;
    import net.wg.gui.lobby.personalMissions.data.TankgirlsBlockVO;
    import net.wg.gui.lobby.personalMissions.data.TankgirlVO;
    import net.wg.gui.lobby.personalMissions.data.UseAwardSheetWindowVO;
    import net.wg.gui.lobby.personalMissions.data.VehicleAwardVO;
    import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
    import net.wg.gui.lobby.personalMissions.events.AwardEvent;
    import net.wg.gui.lobby.personalMissions.events.ChainEvent;
    import net.wg.gui.lobby.personalMissions.events.FirstEntryCardEvent;
    import net.wg.gui.lobby.personalMissions.events.OperationEvent;
    import net.wg.gui.lobby.personalMissions.events.PawnedSheetRendererEvent;
    import net.wg.gui.lobby.personalMissions.events.PersonalMissionDetailedViewEvent;
    import net.wg.gui.lobby.personalMissions.events.PersonalMissionsItemSlotEvent;
    import net.wg.gui.lobby.personalMissions.events.PlanLoaderEvent;
    import net.wg.gui.lobby.personalMissions.events.PlanRegionEvent;
    import net.wg.gui.lobby.personalMissions.events.StatusFooterEvent;
    import net.wg.gui.lobby.personalMissions.events.TankgirlRendererEvent;
    import net.wg.gui.lobby.post.Teaser;
    import net.wg.gui.lobby.post.TeaserEvent;
    import net.wg.gui.lobby.post.data.TeaserVO;
    import net.wg.gui.lobby.premiumMissions.components.MissionsPremiumBody;
    import net.wg.gui.lobby.premiumMissions.data.MissionPremiumBodyVO;
    import net.wg.gui.lobby.premiumWindow.PremiumBody;
    import net.wg.gui.lobby.premiumWindow.PremiumItemRenderer;
    import net.wg.gui.lobby.premiumWindow.PremiumWindow;
    import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;
    import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
    import net.wg.gui.lobby.premiumWindow.events.PremiumWindowEvent;
    import net.wg.gui.lobby.profile.LinkageUtils;
    import net.wg.gui.lobby.profile.Profile;
    import net.wg.gui.lobby.profile.ProfileConstants;
    import net.wg.gui.lobby.profile.ProfileInvalidationTypes;
    import net.wg.gui.lobby.profile.ProfileMenuInfoVO;
    import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
    import net.wg.gui.lobby.profile.ProfileTabNavigator;
    import net.wg.gui.lobby.profile.SectionInfo;
    import net.wg.gui.lobby.profile.SectionViewInfo;
    import net.wg.gui.lobby.profile.UserInfoForm;
    import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
    import net.wg.gui.lobby.profile.components.BattlesTypeDropdown;
    import net.wg.gui.lobby.profile.components.CenteredLineIconText;
    import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
    import net.wg.gui.lobby.profile.components.GradientLineButtonBar;
    import net.wg.gui.lobby.profile.components.ICounter;
    import net.wg.gui.lobby.profile.components.LditBattles;
    import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
    import net.wg.gui.lobby.profile.components.LditValued;
    import net.wg.gui.lobby.profile.components.LineButtonBar;
    import net.wg.gui.lobby.profile.components.LineTextComponent;
    import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
    import net.wg.gui.lobby.profile.components.ProfileFooter;
    import net.wg.gui.lobby.profile.components.ProfileGroupBlock;
    import net.wg.gui.lobby.profile.components.ProfileHofCenterGroup;
    import net.wg.gui.lobby.profile.components.ProfileHofFooter;
    import net.wg.gui.lobby.profile.components.ProfileHofStatusWaiting;
    import net.wg.gui.lobby.profile.components.ProfileMedalsList;
    import net.wg.gui.lobby.profile.components.ProfilePageFooter;
    import net.wg.gui.lobby.profile.components.ProfileWindowFooter;
    import net.wg.gui.lobby.profile.components.ResizableContent;
    import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    import net.wg.gui.lobby.profile.components.TechMasteryIcon;
    import net.wg.gui.lobby.profile.components.TestTrack;
    import net.wg.gui.lobby.profile.components.chart.AxisChart;
    import net.wg.gui.lobby.profile.components.chart.BarItem;
    import net.wg.gui.lobby.profile.components.chart.ChartBase;
    import net.wg.gui.lobby.profile.components.chart.ChartItem;
    import net.wg.gui.lobby.profile.components.chart.ChartItemBase;
    import net.wg.gui.lobby.profile.components.chart.FrameChartItem;
    import net.wg.gui.lobby.profile.components.chart.IChartItem;
    import net.wg.gui.lobby.profile.components.chart.axis.AxisBase;
    import net.wg.gui.lobby.profile.components.chart.axis.IChartAxis;
    import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
    import net.wg.gui.lobby.profile.components.chart.layout.LayoutBase;
    import net.wg.gui.lobby.profile.data.LayoutItemInfo;
    import net.wg.gui.lobby.profile.data.ProfileBaseInfoVO;
    import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
    import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
    import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
    import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
    import net.wg.gui.lobby.profile.data.ProfileUserVO;
    import net.wg.gui.lobby.profile.data.SectionLayoutManager;
    import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
    import net.wg.gui.lobby.profile.pages.ProfileSection;
    import net.wg.gui.lobby.profile.pages.ProfiletabInfo;
    import net.wg.gui.lobby.profile.pages.SectionsShowAnimationManager;
    import net.wg.gui.lobby.profile.pages.awards.AwardsBlock;
    import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;
    import net.wg.gui.lobby.profile.pages.awards.ProfileAwards;
    import net.wg.gui.lobby.profile.pages.awards.StageAwardsBlock;
    import net.wg.gui.lobby.profile.pages.awards.data.AchievementFilterVO;
    import net.wg.gui.lobby.profile.pages.awards.data.AwardsBlockDataVO;
    import net.wg.gui.lobby.profile.pages.awards.data.ProfileAwardsInitVO;
    import net.wg.gui.lobby.profile.pages.awards.data.ReceivedRareVO;
    import net.wg.gui.lobby.profile.pages.formations.ClanInfo;
    import net.wg.gui.lobby.profile.pages.formations.ErrorInfo;
    import net.wg.gui.lobby.profile.pages.formations.FormationHeader;
    import net.wg.gui.lobby.profile.pages.formations.FormationInfoAbstract;
    import net.wg.gui.lobby.profile.pages.formations.FortInfo;
    import net.wg.gui.lobby.profile.pages.formations.LinkNavigationEvent;
    import net.wg.gui.lobby.profile.pages.formations.NoClan;
    import net.wg.gui.lobby.profile.pages.formations.PreviousTeamRenderer;
    import net.wg.gui.lobby.profile.pages.formations.ProfileFormationsPage;
    import net.wg.gui.lobby.profile.pages.formations.ShowTeamEvent;
    import net.wg.gui.lobby.profile.pages.formations.TeamInfo;
    import net.wg.gui.lobby.profile.pages.formations.data.FormationHeaderVO;
    import net.wg.gui.lobby.profile.pages.formations.data.FormationStatVO;
    import net.wg.gui.lobby.profile.pages.formations.data.PreviousTeamsItemVO;
    import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
    import net.wg.gui.lobby.profile.pages.hof.ProfileHof;
    import net.wg.gui.lobby.profile.pages.statistics.LevelBarChartItem;
    import net.wg.gui.lobby.profile.pages.statistics.NationBarChartItem;
    import net.wg.gui.lobby.profile.pages.statistics.ProfileStatistics;
    import net.wg.gui.lobby.profile.pages.statistics.ProfileStatisticsBodyVO;
    import net.wg.gui.lobby.profile.pages.statistics.ProfileStatisticsVO;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartInitializer;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartLayout;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChartAxis;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsChartItemAnimClient;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsLayoutManager;
    import net.wg.gui.lobby.profile.pages.statistics.TypeBarChartItem;
    import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsGroup;
    import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsView;
    import net.wg.gui.lobby.profile.pages.statistics.body.ProfileStatisticsDetailedVO;
    import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsChartsTabDataVO;
    import net.wg.gui.lobby.profile.pages.statistics.header.HeaderBGImage;
    import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
    import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
    import net.wg.gui.lobby.profile.pages.summary.AwardsListComponent;
    import net.wg.gui.lobby.profile.pages.summary.LineTextFieldsLayout;
    import net.wg.gui.lobby.profile.pages.summary.ProfileSummary;
    import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryPage;
    import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryVO;
    import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryWindow;
    import net.wg.gui.lobby.profile.pages.summary.SummaryCommonScoresVO;
    import net.wg.gui.lobby.profile.pages.summary.SummaryInitVO;
    import net.wg.gui.lobby.profile.pages.summary.SummaryPageInitVO;
    import net.wg.gui.lobby.profile.pages.summary.SummaryViewVO;
    import net.wg.gui.lobby.profile.pages.technique.AchievementSmall;
    import net.wg.gui.lobby.profile.pages.technique.ProfileSortingButton;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueEmptyScreen;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueEvent;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechniquePage;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueWindow;
    import net.wg.gui.lobby.profile.pages.technique.TechAwardsMainContainer;
    import net.wg.gui.lobby.profile.pages.technique.TechDetailedUnitGroup;
    import net.wg.gui.lobby.profile.pages.technique.TechnicsDashLineTextItemIRenderer;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementsBlock;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementTab;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueList;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueRenderer;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueStackComponent;
    import net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;
    import net.wg.gui.lobby.profile.pages.technique.TechStatisticsInitVO;
    import net.wg.gui.lobby.profile.pages.technique.TechStatisticsPageInitVO;
    import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
    import net.wg.gui.lobby.profile.pages.technique.data.RatingButtonVO;
    import net.wg.gui.lobby.profile.pages.technique.data.SortingSettingVO;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueStatisticVO;
    import net.wg.gui.lobby.progressiveReward.ProgressiveReward;
    import net.wg.gui.lobby.progressiveReward.ProgressiveRewardProgress;
    import net.wg.gui.lobby.progressiveReward.ProgressiveRewardWidget;
    import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardStepVO;
    import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
    import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
    import net.wg.gui.lobby.quests.components.AwardCarousel;
    import net.wg.gui.lobby.quests.components.BaseQuestsProgress;
    import net.wg.gui.lobby.quests.components.QuestsProgress;
    import net.wg.gui.lobby.quests.components.RadioButtonScrollBar;
    import net.wg.gui.lobby.quests.components.SlotsGroup;
    import net.wg.gui.lobby.quests.components.SlotsLayout;
    import net.wg.gui.lobby.quests.components.SlotsPanel;
    import net.wg.gui.lobby.quests.components.TaskAwardsBlock;
    import net.wg.gui.lobby.quests.components.TextBlockWelcomeView;
    import net.wg.gui.lobby.quests.components.interfaces.IQuestSlotRenderer;
    import net.wg.gui.lobby.quests.components.interfaces.ITaskAwardItemRenderer;
    import net.wg.gui.lobby.quests.components.interfaces.ITasksProgressComponent;
    import net.wg.gui.lobby.quests.components.interfaces.ITextBlockWelcomeView;
    import net.wg.gui.lobby.quests.components.renderers.TaskAwardItemRenderer;
    import net.wg.gui.lobby.quests.data.ChainProgressItemVO;
    import net.wg.gui.lobby.quests.data.ChainProgressVO;
    import net.wg.gui.lobby.quests.data.QuestSlotsDataVO;
    import net.wg.gui.lobby.quests.data.QuestSlotVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.IconTitleDescSeasonAwardVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardListRendererVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.TextBlockWelcomeViewVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.VehicleSeasonAwardVO;
    import net.wg.gui.lobby.quests.events.AwardWindowEvent;
    import net.wg.gui.lobby.questsWindow.ConditionBlock;
    import net.wg.gui.lobby.questsWindow.ConditionElement;
    import net.wg.gui.lobby.questsWindow.DescriptionBlock;
    import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
    import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
    import net.wg.gui.lobby.questsWindow.QuestListSelectionNavigator;
    import net.wg.gui.lobby.questsWindow.QuestsList;
    import net.wg.gui.lobby.questsWindow.QuestsTasksNavigator;
    import net.wg.gui.lobby.questsWindow.QuestWindowUtils;
    import net.wg.gui.lobby.questsWindow.RequirementBlock;
    import net.wg.gui.lobby.questsWindow.SubtaskComponent;
    import net.wg.gui.lobby.questsWindow.SubtasksList;
    import net.wg.gui.lobby.questsWindow.VehicleBlock;
    import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
    import net.wg.gui.lobby.questsWindow.components.AlertMessage;
    import net.wg.gui.lobby.questsWindow.components.AnimResizableContent;
    import net.wg.gui.lobby.questsWindow.components.BaseResizableContentHeader;
    import net.wg.gui.lobby.questsWindow.components.CommonConditionsBlock;
    import net.wg.gui.lobby.questsWindow.components.ConditionSeparator;
    import net.wg.gui.lobby.questsWindow.components.CounterTextElement;
    import net.wg.gui.lobby.questsWindow.components.CustomizationItemRenderer;
    import net.wg.gui.lobby.questsWindow.components.CustomizationsBlock;
    import net.wg.gui.lobby.questsWindow.components.EventsResizableContent;
    import net.wg.gui.lobby.questsWindow.components.InnerResizableContent;
    import net.wg.gui.lobby.questsWindow.components.InscriptionItemRenderer;
    import net.wg.gui.lobby.questsWindow.components.MovableBlocksContainer;
    import net.wg.gui.lobby.questsWindow.components.ProgressBlock;
    import net.wg.gui.lobby.questsWindow.components.QuestBigIconAwardBlock;
    import net.wg.gui.lobby.questsWindow.components.QuestBigIconAwardItem;
    import net.wg.gui.lobby.questsWindow.components.QuestIconAwardsBlock;
    import net.wg.gui.lobby.questsWindow.components.QuestIconElement;
    import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
    import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
    import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
    import net.wg.gui.lobby.questsWindow.components.QuestTextAwardBlock;
    import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
    import net.wg.gui.lobby.questsWindow.components.ResizableContentHeader;
    import net.wg.gui.lobby.questsWindow.components.TextProgressElement;
    import net.wg.gui.lobby.questsWindow.components.TreeHeader;
    import net.wg.gui.lobby.questsWindow.components.TutorialMotiveQuestDescriptionContainer;
    import net.wg.gui.lobby.questsWindow.components.VehicleBonusTextElement;
    import net.wg.gui.lobby.questsWindow.components.VehicleItemRenderer;
    import net.wg.gui.lobby.questsWindow.components.VehiclesSortingBlock;
    import net.wg.gui.lobby.questsWindow.components.interfaces.IComplexViewStackItem;
    import net.wg.gui.lobby.questsWindow.components.interfaces.IConditionRenderer;
    import net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;
    import net.wg.gui.lobby.questsWindow.data.BaseResizableContentVO;
    import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
    import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
    import net.wg.gui.lobby.questsWindow.data.ConditionSeparatorVO;
    import net.wg.gui.lobby.questsWindow.data.CounterTextElementVO;
    import net.wg.gui.lobby.questsWindow.data.CustomizationQuestBonusVO;
    import net.wg.gui.lobby.questsWindow.data.DescriptionVO;
    import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
    import net.wg.gui.lobby.questsWindow.data.InfoDataVO;
    import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
    import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
    import net.wg.gui.lobby.questsWindow.data.ProgressBlockVO;
    import net.wg.gui.lobby.questsWindow.data.QuestDashlineItemVO;
    import net.wg.gui.lobby.questsWindow.data.QuestDetailsVO;
    import net.wg.gui.lobby.questsWindow.data.QuestIconAwardsBlockVO;
    import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
    import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
    import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
    import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
    import net.wg.gui.lobby.questsWindow.data.SortedBtnVO;
    import net.wg.gui.lobby.questsWindow.data.StateVO;
    import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
    import net.wg.gui.lobby.questsWindow.data.TextBlockVO;
    import net.wg.gui.lobby.questsWindow.data.TreeContentVO;
    import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;
    import net.wg.gui.lobby.questsWindow.data.TutorialQuestConditionRendererVO;
    import net.wg.gui.lobby.questsWindow.data.TutorialQuestDescVO;
    import net.wg.gui.lobby.questsWindow.data.VehicleBlockVO;
    import net.wg.gui.lobby.questsWindow.data.VehicleBonusTextElementVO;
    import net.wg.gui.lobby.questsWindow.data.VehiclesSortingBlockVO;
    import net.wg.gui.lobby.questsWindow.events.IQuestRenderer;
    import net.wg.gui.lobby.questsWindow.events.TutorialQuestConditionEvent;
    import net.wg.gui.lobby.rankedBattles19.RankedBattlesPage;
    import net.wg.gui.lobby.rankedBattles19.battleResults.components.RankedBattleSubTask;
    import net.wg.gui.lobby.rankedBattles19.components.BonusBattles;
    import net.wg.gui.lobby.rankedBattles19.components.DivisionIcon;
    import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
    import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
    import net.wg.gui.lobby.rankedBattles19.components.StepArrow;
    import net.wg.gui.lobby.rankedBattles19.components.StepsContainer;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressRankRenderer;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionRankShield;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.AbstractDivisionState;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.ActiveDivisionState;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.BlockSizeParams;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.BlockViewParams;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.FirstEnterDivisionState;
    import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers.InactiveDivisionState;
    import net.wg.gui.lobby.rankedBattles19.components.divisionsContainer.Division;
    import net.wg.gui.lobby.rankedBattles19.components.divisionsContainer.DivisionsContainer;
    import net.wg.gui.lobby.rankedBattles19.components.divisionSelector.DivisionSelector;
    import net.wg.gui.lobby.rankedBattles19.components.divisionSelector.DivisionSelectorName;
    import net.wg.gui.lobby.rankedBattles19.components.divisionStatus.DivisionStatus;
    import net.wg.gui.lobby.rankedBattles19.components.interfaces.IRankIcon;
    import net.wg.gui.lobby.rankedBattles19.components.interfaces.IResizableRankedComponent;
    import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepArrow;
    import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepsContainer;
    import net.wg.gui.lobby.rankedBattles19.components.league.LeagueIcon;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardDivision;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardDivisionBase;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardLeague;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.AwardTitle;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.GlowRankAnimation;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.RankAwardAnimation;
    import net.wg.gui.lobby.rankedBattles19.components.rankAward.RankContainer;
    import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
    import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStatsDelta;
    import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStatsInfo;
    import net.wg.gui.lobby.rankedBattles19.components.widget.LeagueImageContainer;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankedBattlesHangarWidget;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankIcon;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankShield;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankShieldContainer;
    import net.wg.gui.lobby.rankedBattles19.components.widget.RankWidgetAnimator;
    import net.wg.gui.lobby.rankedBattles19.components.widget.StatsDelta;
    import net.wg.gui.lobby.rankedBattles19.components.widget.WidgetBonusBattles;
    import net.wg.gui.lobby.rankedBattles19.components.widget.WidgetDivision;
    import net.wg.gui.lobby.rankedBattles19.components.widget.WidgetLeague;
    import net.wg.gui.lobby.rankedBattles19.components.widget.WidgetStepsContainer;
    import net.wg.gui.lobby.rankedBattles19.constants.LeagueIconConsts;
    import net.wg.gui.lobby.rankedBattles19.constants.RankedHelper;
    import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
    import net.wg.gui.lobby.rankedBattles19.data.AwardDivisionBaseVO;
    import net.wg.gui.lobby.rankedBattles19.data.AwardDivisionVO;
    import net.wg.gui.lobby.rankedBattles19.data.DivisionProgressBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.DivisionShieldVO;
    import net.wg.gui.lobby.rankedBattles19.data.DivisionsViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
    import net.wg.gui.lobby.rankedBattles19.data.LeaguesStatsBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.LeaguesViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.PlayerRankRendererVO;
    import net.wg.gui.lobby.rankedBattles19.data.ProgressInfoBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattleAwardViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattleResultsVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesCurrentAwardVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesDivisionProgressVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesHangarWidgetVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesSeasonCompleteViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsDeltaVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsInfoVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesUnreachableViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedListsVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedListVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedRewardsYearVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedRewardYearItemVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankIconVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankScoreVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankShieldAnimHelperVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankShieldVO;
    import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueRendererVO;
    import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueVO;
    import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
    import net.wg.gui.lobby.rankedBattles19.data.RuleVO;
    import net.wg.gui.lobby.rankedBattles19.data.SeasonGapViewVO;
    import net.wg.gui.lobby.rankedBattles19.data.StepsContainerVO;
    import net.wg.gui.lobby.rankedBattles19.data.WidgetDivisionVO;
    import net.wg.gui.lobby.rankedBattles19.data.WidgetLeagueVO;
    import net.wg.gui.lobby.rankedBattles19.events.DivisionsEvent;
    import net.wg.gui.lobby.rankedBattles19.events.RankWidgetEvent;
    import net.wg.gui.lobby.rankedBattles19.events.RewardsEvent;
    import net.wg.gui.lobby.rankedBattles19.events.RewardYearEvent;
    import net.wg.gui.lobby.rankedBattles19.events.SeasonCompleteEvent;
    import net.wg.gui.lobby.rankedBattles19.events.ServerSlotButtonEvent;
    import net.wg.gui.lobby.rankedBattles19.events.SoundEvent;
    import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.PlayerRankedRenderer;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.RankedBattlesBattleResults;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.RankedListsContainer;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.RankedListWithBackground;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.RankedSimpleTileList;
    import net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults.ResultsContainer;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesAwardView;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesDivisionsView;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesLeaguesView;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesSeasonGapView;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesUnreachableView;
    import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
    import net.wg.gui.lobby.rankedBattles19.view.base.HangarRankedScreen;
    import net.wg.gui.lobby.rankedBattles19.view.base.RankedScreen;
    import net.wg.gui.lobby.rankedBattles19.view.divisions.RankedBattlesDivisionProgress;
    import net.wg.gui.lobby.rankedBattles19.view.divisions.RankedBattlesDivisionQualification;
    import net.wg.gui.lobby.rankedBattles19.view.intro.RankedBattlesIntro;
    import net.wg.gui.lobby.rankedBattles19.view.intro.RankedIntroBlock;
    import net.wg.gui.lobby.rankedBattles19.view.intro.RankedIntroBlocks;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.RankedBattlesRewards;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.RankedBattlesRewardsLeaguesView;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.RankedBattlesRewardsRanksView;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.RankedBattlesRewardsYearView;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.league.RewardsLeagueContainer;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.league.RewardsLeagueRenderer;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.league.RewardsLeagueStyleReward;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.DivisionRewardsView;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.QualificationRewardsView;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.RankShieldLevel;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.RewardsRankRenderer;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.ranks.RewardsRanksContainer;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.year.RankedBattlesRewardsYearBg;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.year.RankedBattlesYearRewardBtn;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.year.RankedBattlesYearRewardCircle;
    import net.wg.gui.lobby.rankedBattles19.view.rewards.year.RankedBattlesYearRewardContainer;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.RankedBattlesSeasonCompleteView;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.RankedBattlesSeasonContainer;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.RankedBattlesSeasonType;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonBaseResultBlock;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonDivisionResultBlock;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonLeagueResultBlock;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonMainImage;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonResultRenderer;
    import net.wg.gui.lobby.rankedBattles19.view.seasonComplete.SeasonTextWrapper;
    import net.wg.gui.lobby.rankedBattles19.view.stats.DivisionsStatsBlock;
    import net.wg.gui.lobby.rankedBattles19.view.stats.LeaguesStatsBlock;
    import net.wg.gui.lobby.rankedBattles19.view.stats.StatsBlock;
    import net.wg.gui.lobby.rankedBattles19.view.unreachableView.RankedUnreachableBottomBlock;
    import net.wg.gui.lobby.rankedBattles19.view.unreachableView.RuleRenderer;
    import net.wg.gui.lobby.recruitWindow.QuestRecruitWindow;
    import net.wg.gui.lobby.recruitWindow.RecruitWindow;
    import net.wg.gui.lobby.referralSystem.AwardReceivedBlock;
    import net.wg.gui.lobby.referralSystem.ProgressStepRenderer;
    import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
    import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
    import net.wg.gui.lobby.reservesPanel.components.ReserveFittingItemRenderer;
    import net.wg.gui.lobby.reservesPanel.components.ReserveSlot;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVO;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVOBase;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewMainButtons;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewOperationVO;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewRoleIR;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewWindow;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainTankmanVO;
    import net.wg.gui.lobby.retrainCrewWindow.RetrainVehicleBlockVO;
    import net.wg.gui.lobby.sessionStats.SessionBattleStatsView;
    import net.wg.gui.lobby.sessionStats.SessionStatsBattleEfficiencyBlock;
    import net.wg.gui.lobby.sessionStats.SessionStatsBattleResultBlock;
    import net.wg.gui.lobby.sessionStats.SessionStatsEfficiencyParamBlock;
    import net.wg.gui.lobby.sessionStats.SessionStatsParamsListBlock;
    import net.wg.gui.lobby.sessionStats.SessionStatsPopover;
    import net.wg.gui.lobby.sessionStats.SessionStatsStatusBlock;
    import net.wg.gui.lobby.sessionStats.SessionStatsTankInfoHeaderBlock;
    import net.wg.gui.lobby.sessionStats.SessionVehicleStatsView;
    import net.wg.gui.lobby.sessionStats.components.SessionBattleEfficiencyStatsRenderer;
    import net.wg.gui.lobby.sessionStats.components.SessionBattleStatsRenderer;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsAnimatedCounter;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsAnimatedNumber;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsAnimatedNumberCounter;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsInfoParamsRenderer;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsRateComponent;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsTankInfoBackground;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsTankInfoMainMark;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsTankInfoRenderer;
    import net.wg.gui.lobby.sessionStats.components.SessionStatsTankSmallName;
    import net.wg.gui.lobby.sessionStats.components.SessionTotalStatsRenderer;
    import net.wg.gui.lobby.sessionStats.components.SessionVehicleStatsRenderer;
    import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsRendererVO;
    import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsEfficiencyParamVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsPopoverVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsRateVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsTabVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsTankInfoHeaderVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsTankInfoParamVO;
    import net.wg.gui.lobby.sessionStats.data.SessionStatsTankStatusVO;
    import net.wg.gui.lobby.sessionStats.data.SessionVehicleStatsRendererVO;
    import net.wg.gui.lobby.sessionStats.data.SessionVehicleStatsViewVO;
    import net.wg.gui.lobby.sessionStats.events.SessionStatsPopoverResizedEvent;
    import net.wg.gui.lobby.shop20.controls.RentalTermSlotButton;
    import net.wg.gui.lobby.shop20.data.RentalTermSelectionPopoverVO;
    import net.wg.gui.lobby.shop20.data.RentalTermSlotButtonVO;
    import net.wg.gui.lobby.shop20.data.VehicleSellConfirmationPopoverVO;
    import net.wg.gui.lobby.shop20.popovers.RentalTermSelectionPopover;
    import net.wg.gui.lobby.shop20.popovers.VehicleSellConfirmationPopover;
    import net.wg.gui.lobby.storage.StorageView;
    import net.wg.gui.lobby.storage.categories.BaseCategoryView;
    import net.wg.gui.lobby.storage.categories.BaseFilterBlock;
    import net.wg.gui.lobby.storage.categories.ICategory;
    import net.wg.gui.lobby.storage.categories.NoItemsView;
    import net.wg.gui.lobby.storage.categories.StorageCarousel;
    import net.wg.gui.lobby.storage.categories.StorageVehicleFilterBlock;
    import net.wg.gui.lobby.storage.categories.blueprints.BlueprintFragmentRenderer;
    import net.wg.gui.lobby.storage.categories.blueprints.BlueprintFragmentsBar;
    import net.wg.gui.lobby.storage.categories.blueprints.BlueprintsFilterBlock;
    import net.wg.gui.lobby.storage.categories.blueprints.BlueprintsNoItemsView;
    import net.wg.gui.lobby.storage.categories.blueprints.StorageCategoryBlueprintsView;
    import net.wg.gui.lobby.storage.categories.cards.BaseCard;
    import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
    import net.wg.gui.lobby.storage.categories.cards.BlueprintCardVO;
    import net.wg.gui.lobby.storage.categories.cards.BlueprintsCard;
    import net.wg.gui.lobby.storage.categories.cards.CardEvent;
    import net.wg.gui.lobby.storage.categories.cards.CardSizeConfig;
    import net.wg.gui.lobby.storage.categories.cards.CardSizeVO;
    import net.wg.gui.lobby.storage.categories.cards.CustomizationCard;
    import net.wg.gui.lobby.storage.categories.cards.PersonalReservesCard;
    import net.wg.gui.lobby.storage.categories.cards.RentVehicleCard;
    import net.wg.gui.lobby.storage.categories.cards.RestoreVehicleCard;
    import net.wg.gui.lobby.storage.categories.cards.SelectableCard;
    import net.wg.gui.lobby.storage.categories.cards.VehicleCard;
    import net.wg.gui.lobby.storage.categories.cards.VehicleCardVO;
    import net.wg.gui.lobby.storage.categories.customization.StorageCategoryCustomizationView;
    import net.wg.gui.lobby.storage.categories.forsell.BuyBlock;
    import net.wg.gui.lobby.storage.categories.forsell.BuyBlockEvent;
    import net.wg.gui.lobby.storage.categories.forsell.StorageCategoryForSellView;
    import net.wg.gui.lobby.storage.categories.forsell.StorageCategoryForSellVO;
    import net.wg.gui.lobby.storage.categories.inhangar.AllVehiclesTabView;
    import net.wg.gui.lobby.storage.categories.inhangar.InHangarFilterBlock;
    import net.wg.gui.lobby.storage.categories.inhangar.RentVehiclesTabView;
    import net.wg.gui.lobby.storage.categories.inhangar.RestoreVehiclesTabView;
    import net.wg.gui.lobby.storage.categories.inhangar.StorageCategoryInHangarView;
    import net.wg.gui.lobby.storage.categories.personalreserves.ActiveReservesBlock;
    import net.wg.gui.lobby.storage.categories.personalreserves.PersonalReserveFilterBlock;
    import net.wg.gui.lobby.storage.categories.personalreserves.StorageCategoryPersonalReservesView;
    import net.wg.gui.lobby.storage.categories.personalreserves.StorageCategoryPersonalReservesVO;
    import net.wg.gui.lobby.storage.categories.storage.ItemsWithTypeAndNationFilterTabView;
    import net.wg.gui.lobby.storage.categories.storage.ItemsWithTypeFilterTabView;
    import net.wg.gui.lobby.storage.categories.storage.ItemsWithVehicleFilterTabView;
    import net.wg.gui.lobby.storage.categories.storage.RegularItemsTabView;
    import net.wg.gui.lobby.storage.categories.storage.StorageCategoryStorageView;
    import net.wg.gui.lobby.storage.categories.storage.StorageTypeAndNationFilterBlock;
    import net.wg.gui.lobby.storage.categories.storage.StorageTypeAndVehicleFilterBlock;
    import net.wg.gui.lobby.storage.categories.storage.StorageTypeFilterBlock;
    import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.StorageVehicleSelectPopoverVO;
    import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.VehicleSelectorFilter;
    import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.VehicleSelectPopover;
    import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.VehicleSelectPopoverItemVO;
    import net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.VehicleSelectRenderer;
    import net.wg.gui.lobby.storage.data.BlueprintsFragmentVO;
    import net.wg.gui.lobby.storage.data.StorageNationFilterVO;
    import net.wg.gui.lobby.storage.data.StorageVO;
    import net.wg.gui.lobby.store.ComplexListItemRenderer;
    import net.wg.gui.lobby.store.StoreComponent;
    import net.wg.gui.lobby.store.StoreComponentViewBase;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.gui.lobby.store.StoreForm;
    import net.wg.gui.lobby.store.StoreHelper;
    import net.wg.gui.lobby.store.StoreList;
    import net.wg.gui.lobby.store.StoreListItemRenderer;
    import net.wg.gui.lobby.store.StoreTable;
    import net.wg.gui.lobby.store.StoreTableDataProvider;
    import net.wg.gui.lobby.store.StoreView;
    import net.wg.gui.lobby.store.StoreViewsEvent;
    import net.wg.gui.lobby.store.TableHeader;
    import net.wg.gui.lobby.store.TableHeaderInfo;
    import net.wg.gui.lobby.store.actions.StoreActionsContainer;
    import net.wg.gui.lobby.store.actions.StoreActionsEmpty;
    import net.wg.gui.lobby.store.actions.StoreActionsView;
    import net.wg.gui.lobby.store.actions.cards.ActionCardSelectFrame;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardAbstract;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardBase;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardDescrTableOfferItem;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardHeader;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardHero;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardNormal;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardSmall;
    import net.wg.gui.lobby.store.actions.cards.StoreActionCardTitle;
    import net.wg.gui.lobby.store.actions.cards.StoreActionComingSoon;
    import net.wg.gui.lobby.store.actions.cards.StoreActionDescr;
    import net.wg.gui.lobby.store.actions.cards.StoreActionDescrTTC;
    import net.wg.gui.lobby.store.actions.cards.StoreActionDiscount;
    import net.wg.gui.lobby.store.actions.data.CardSettings;
    import net.wg.gui.lobby.store.actions.data.CardsSettings;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardDescrVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardOffersItemVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionPictureVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionsCardsVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionsEmptyVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionsViewVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.gui.lobby.store.actions.interfaces.IStoreActionCard;
    import net.wg.gui.lobby.store.data.ButtonBarVO;
    import net.wg.gui.lobby.store.data.FiltersDataVO;
    import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
    import net.wg.gui.lobby.store.data.StoreViewInitVO;
    import net.wg.gui.lobby.store.evnts.StoreViewStackEvent;
    import net.wg.gui.lobby.store.interfaces.IStoreTable;
    import net.wg.gui.lobby.store.inventory.Inventory;
    import net.wg.gui.lobby.store.inventory.InventoryModuleListItemRenderer;
    import net.wg.gui.lobby.store.inventory.InventoryVehicleListItemRdr;
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.lobby.store.shop.Shop;
    import net.wg.gui.lobby.store.shop.ShopIconText;
    import net.wg.gui.lobby.store.shop.ShopModuleListItemRenderer;
    import net.wg.gui.lobby.store.shop.ShopVehicleListItemRenderer;
    import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
    import net.wg.gui.lobby.store.views.ActionsFilterView;
    import net.wg.gui.lobby.store.views.BattleBoosterView;
    import net.wg.gui.lobby.store.views.EquipmentView;
    import net.wg.gui.lobby.store.views.InventoryVehicleView;
    import net.wg.gui.lobby.store.views.ModuleView;
    import net.wg.gui.lobby.store.views.OptionalDeviceView;
    import net.wg.gui.lobby.store.views.ShellView;
    import net.wg.gui.lobby.store.views.ShopVehicleView;
    import net.wg.gui.lobby.store.views.VehicleView;
    import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
    import net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView;
    import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.gui.lobby.store.views.base.interfaces.IStoreMenuView;
    import net.wg.gui.lobby.store.views.data.ExtFitItemsFiltersVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.FitItemsFiltersVO;
    import net.wg.gui.lobby.store.views.data.ShopVehiclesFiltersVO;
    import net.wg.gui.lobby.store.views.data.TargetTypeFiltersVO;
    import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;
    import net.wg.gui.lobby.stronghold.StrongholdClanProfileView;
    import net.wg.gui.lobby.stronghold.StrongholdListView;
    import net.wg.gui.lobby.stronghold.StrongholdView;
    import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
    import net.wg.gui.lobby.tankman.CrewTankmanRetraining;
    import net.wg.gui.lobby.tankman.DropSkillsCost;
    import net.wg.gui.lobby.tankman.PersonalCase;
    import net.wg.gui.lobby.tankman.PersonalCaseBase;
    import net.wg.gui.lobby.tankman.PersonalCaseBlockItem;
    import net.wg.gui.lobby.tankman.PersonalCaseBlocksArea;
    import net.wg.gui.lobby.tankman.PersonalCaseBlockTitle;
    import net.wg.gui.lobby.tankman.PersonalCaseCrewSkins;
    import net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle;
    import net.wg.gui.lobby.tankman.PersonalCaseDocs;
    import net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
    import net.wg.gui.lobby.tankman.PersonalCaseInputList;
    import net.wg.gui.lobby.tankman.PersonalCaseModel;
    import net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
    import net.wg.gui.lobby.tankman.PersonalCaseSkillModel;
    import net.wg.gui.lobby.tankman.PersonalCaseSkills;
    import net.wg.gui.lobby.tankman.PersonalCaseSkillsItemRenderer;
    import net.wg.gui.lobby.tankman.PersonalCaseSkillsModel;
    import net.wg.gui.lobby.tankman.PersonalCaseSpecialization;
    import net.wg.gui.lobby.tankman.PersonalCaseStats;
    import net.wg.gui.lobby.tankman.RankElement;
    import net.wg.gui.lobby.tankman.RoleChangeItem;
    import net.wg.gui.lobby.tankman.RoleChangeItems;
    import net.wg.gui.lobby.tankman.RoleChangeVehicleSelection;
    import net.wg.gui.lobby.tankman.RoleChangeWindow;
    import net.wg.gui.lobby.tankman.SkillDropModel;
    import net.wg.gui.lobby.tankman.SkillDropWindow;
    import net.wg.gui.lobby.tankman.SkillItemViewMini;
    import net.wg.gui.lobby.tankman.SkillsItemsRendererRankIcon;
    import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
    import net.wg.gui.lobby.tankman.VehicleTypeButton;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinNoItemsInfo;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsBlock;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsItemRenderer;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsMainContainer;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinSoundInfo;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinStorageInfo;
    import net.wg.gui.lobby.tankman.crewSkins.CrewSkinsWarning;
    import net.wg.gui.lobby.tankman.crewSkins.PersonalCaseCrewSkinsItemRenderer;
    import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
    import net.wg.gui.lobby.tankman.crewSkins.model.PersonalCaseCrewSkinsVO;
    import net.wg.gui.lobby.tankman.vo.PersonalCaseTabNameVO;
    import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
    import net.wg.gui.lobby.tankman.vo.RoleChangeItemVO;
    import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
    import net.wg.gui.lobby.tankman.vo.TankmanSkillsInfoBlockVO;
    import net.wg.gui.lobby.tankman.vo.VehicleSelectionItemVO;
    import net.wg.gui.lobby.tankman.vo.VehicleSelectionVO;
    import net.wg.gui.lobby.techtree.ResearchPage;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.TechTreePage;
    import net.wg.gui.lobby.techtree.constants.ActionName;
    import net.wg.gui.lobby.techtree.constants.ColorIndex;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import net.wg.gui.lobby.techtree.constants.NodeRendererState;
    import net.wg.gui.lobby.techtree.constants.OutLiteral;
    import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
    import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
    import net.wg.gui.lobby.techtree.controls.ActionButton;
    import net.wg.gui.lobby.techtree.controls.AnimatedTextButton;
    import net.wg.gui.lobby.techtree.controls.AnimatedTextLabel;
    import net.wg.gui.lobby.techtree.controls.BalanceContainer;
    import net.wg.gui.lobby.techtree.controls.BenefitRenderer;
    import net.wg.gui.lobby.techtree.controls.BlueprintBackground;
    import net.wg.gui.lobby.techtree.controls.BlueprintBalance;
    import net.wg.gui.lobby.techtree.controls.BlueprintBalanceItem;
    import net.wg.gui.lobby.techtree.controls.BlueprintBar;
    import net.wg.gui.lobby.techtree.controls.BlueprintProgressBar;
    import net.wg.gui.lobby.techtree.controls.BlueprintsModeSwitchButton;
    import net.wg.gui.lobby.techtree.controls.DiscountBanner;
    import net.wg.gui.lobby.techtree.controls.ExperienceBlock;
    import net.wg.gui.lobby.techtree.controls.FadeComponent;
    import net.wg.gui.lobby.techtree.controls.LevelDelimiter;
    import net.wg.gui.lobby.techtree.controls.LevelsContainer;
    import net.wg.gui.lobby.techtree.controls.NationButton;
    import net.wg.gui.lobby.techtree.controls.NationButtonStates;
    import net.wg.gui.lobby.techtree.controls.NationFlagContainer;
    import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
    import net.wg.gui.lobby.techtree.controls.NodeComponent;
    import net.wg.gui.lobby.techtree.controls.PremiumLayout;
    import net.wg.gui.lobby.techtree.controls.ResearchRootExperience;
    import net.wg.gui.lobby.techtree.controls.ResearchRootTitle;
    import net.wg.gui.lobby.techtree.controls.TechTreeTitle;
    import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
    import net.wg.gui.lobby.techtree.controls.VehicleButton;
    import net.wg.gui.lobby.techtree.controls.XPField;
    import net.wg.gui.lobby.techtree.controls.XPIcon;
    import net.wg.gui.lobby.techtree.data.AbstractDataProvider;
    import net.wg.gui.lobby.techtree.data.BlueprintBalanceItemVO;
    import net.wg.gui.lobby.techtree.data.BlueprintBalanceVO;
    import net.wg.gui.lobby.techtree.data.NationVODataProvider;
    import net.wg.gui.lobby.techtree.data.ResearchPageVO;
    import net.wg.gui.lobby.techtree.data.ResearchRootVO;
    import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
    import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
    import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
    import net.wg.gui.lobby.techtree.data.state.NodeStateItem;
    import net.wg.gui.lobby.techtree.data.state.StateProperties;
    import net.wg.gui.lobby.techtree.data.state.UnlockedStateItem;
    import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
    import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
    import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
    import net.wg.gui.lobby.techtree.data.vo.VehCompareEntrypointTreeNodeVO;
    import net.wg.gui.lobby.techtree.helpers.Distance;
    import net.wg.gui.lobby.techtree.helpers.LinesGraphics;
    import net.wg.gui.lobby.techtree.helpers.ModulesGraphics;
    import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
    import net.wg.gui.lobby.techtree.helpers.NTGraphics;
    import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
    import net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner;
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
    import net.wg.gui.lobby.techtree.interfaces.INodesDataProvider;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
    import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
    import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
    import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
    import net.wg.gui.lobby.techtree.interfaces.IValueObject;
    import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
    import net.wg.gui.lobby.techtree.math.HungarianAlgorithm;
    import net.wg.gui.lobby.techtree.math.MatrixPosition;
    import net.wg.gui.lobby.techtree.math.MatrixUtils;
    import net.wg.gui.lobby.techtree.nodes.FakeNode;
    import net.wg.gui.lobby.techtree.nodes.NationTreeNode;
    import net.wg.gui.lobby.techtree.nodes.Renderer;
    import net.wg.gui.lobby.techtree.nodes.ResearchItem;
    import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
    import net.wg.gui.lobby.techtree.sub.ModulesTree;
    import net.wg.gui.lobby.techtree.sub.NationTree;
    import net.wg.gui.lobby.techtree.sub.ResearchItems;
    import net.wg.gui.lobby.testView.TestView;
    import net.wg.gui.lobby.testView.generated.models.TestViewModel;
    import net.wg.gui.lobby.testView.generated.models.TextViewModel;
    import net.wg.gui.lobby.testView.generated.views.TestViewBase;
    import net.wg.gui.lobby.tradeIn.TradeOffWidget;
    import net.wg.gui.lobby.tradeIn.vo.TradeOffWidgetVO;
    import net.wg.gui.lobby.training.ArenaVoipSettings;
    import net.wg.gui.lobby.training.DragPlayerElement;
    import net.wg.gui.lobby.training.DragPlayerElementBase;
    import net.wg.gui.lobby.training.DragPlayerElementEpic;
    import net.wg.gui.lobby.training.DropList;
    import net.wg.gui.lobby.training.DropTileList;
    import net.wg.gui.lobby.training.EpicBattleTrainingRoom;
    import net.wg.gui.lobby.training.ObserverButtonComponent;
    import net.wg.gui.lobby.training.TooltipViewer;
    import net.wg.gui.lobby.training.TrainingConstants;
    import net.wg.gui.lobby.training.TrainingDragController;
    import net.wg.gui.lobby.training.TrainingDragDelegate;
    import net.wg.gui.lobby.training.TrainingForm;
    import net.wg.gui.lobby.training.TrainingListItemRenderer;
    import net.wg.gui.lobby.training.TrainingPlayerItemRenderer;
    import net.wg.gui.lobby.training.TrainingPlayerItemRendererBase;
    import net.wg.gui.lobby.training.TrainingPlayerItemRendererEpic;
    import net.wg.gui.lobby.training.TrainingRoom;
    import net.wg.gui.lobby.training.TrainingRoomBase;
    import net.wg.gui.lobby.training.TrainingWindow;
    import net.wg.gui.lobby.unboundInjectWindow.GamefaceTestComponent;
    import net.wg.gui.lobby.unboundInjectWindow.UnboundInjectWindow;
    import net.wg.gui.lobby.unboundInjectWindow.UnboundTestComponent;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareCartItemRenderer;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareCartPopover;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareCommonView;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareConfiguratorBaseView;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareConfiguratorMain;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareConfiguratorView;
    import net.wg.gui.lobby.vehicleCompare.VehicleCompareView;
    import net.wg.gui.lobby.vehicleCompare.VehicleModulesTree;
    import net.wg.gui.lobby.vehicleCompare.VehicleModulesView;
    import net.wg.gui.lobby.vehicleCompare.configurator.CamouflageCheckBoxButton;
    import net.wg.gui.lobby.vehicleCompare.configurator.ClosableEquipmentSlot;
    import net.wg.gui.lobby.vehicleCompare.configurator.SkillsFade;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfBottomPanel;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfCrew;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfCrewSkillSlot;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfEquipment;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModules;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModulesButton;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfModuleSlot;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfParameters;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfParamRenderer;
    import net.wg.gui.lobby.vehicleCompare.configurator.VehConfShellButton;
    import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAddVehiclePopover;
    import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAddVehicleRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnim;
    import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnimRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareVehicleSelector;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareBubble;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareCrewDropDownItemRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareGridLine;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareHeader;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareHeaderBackground;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareMainPanel;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamsDelta;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamsViewPort;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTableContent;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTableGrid;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTankCarousel;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTopPanel;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareVehicleRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareVehParamRenderer;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehParamsListDataProvider;
    import net.wg.gui.lobby.vehicleCompare.controls.view.VehParamsScroller;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareDataProvider;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareHeaderVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareStaticDataVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehConfSkillVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAddVehiclePopoverVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartItemVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartPopoverInitDataVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareVehicleSelectorItemVO;
    import net.wg.gui.lobby.vehicleCompare.data.VehParamsDataVO;
    import net.wg.gui.lobby.vehicleCompare.events.ClosableEquipmentSlotEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareParamsListEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareScrollEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfShellSlotEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillDropDownEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehConfSkillEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareCartEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehicleModuleItemEvent;
    import net.wg.gui.lobby.vehicleCompare.interfaces.IMainPanel;
    import net.wg.gui.lobby.vehicleCompare.interfaces.ITableGridLine;
    import net.wg.gui.lobby.vehicleCompare.interfaces.ITopPanel;
    import net.wg.gui.lobby.vehicleCompare.interfaces.IVehCompareViewHeader;
    import net.wg.gui.lobby.vehicleCompare.interfaces.IVehParamRenderer;
    import net.wg.gui.lobby.vehicleCompare.nodes.ModuleItemNode;
    import net.wg.gui.lobby.vehicleCompare.nodes.ModuleRenderer;
    import net.wg.gui.lobby.vehicleCompare.nodes.ModulesRootNode;
    import net.wg.gui.lobby.vehicleCompare.nodes.ModulesTreeDataProvider;
    import net.wg.gui.lobby.vehicleCongratulation.VehicleCongratulationAnimation;
    import net.wg.gui.lobby.vehicleCustomization.BottomPanel;
    import net.wg.gui.lobby.vehicleCustomization.ConfirmCustomizationItemDialog;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationAnchorRenderer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationAnchorsSet;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationAnchorSwitchers;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationBill;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationBuyContainer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationBuyRenderer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationBuyWindow;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationCarousel;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationCarouselBookmark;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationCarouselLayoutController;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationDecalAnchorRenderer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationEndPointIcon;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationFiltersPopover;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationHeader;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationHelper;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationItemsPopover;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationKitPopover;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationKitPopoverContent;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationKitTable;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationMainView;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationNonHistoricIcon;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationNotification;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationPurchasesListItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationSaleRibbon;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationSeasonBuyRenderer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationShared;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationSimpleAnchor;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationStyleInfo;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationStyleInfoBlock;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationStyleScrollContainer;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationTabNavigator;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationTrigger;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationTriggerBgDisable;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationVehicleView;
    import net.wg.gui.lobby.vehicleCustomization.ICustomizationEndPointIcon;
    import net.wg.gui.lobby.vehicleCustomization.ISlotsPanelRenderer;
    import net.wg.gui.lobby.vehicleCustomization.ItemBrowserDisableOverlay;
    import net.wg.gui.lobby.vehicleCustomization.PropertySheetSeasonItemPopover;
    import net.wg.gui.lobby.vehicleCustomization.StyleInfoRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.CarouselItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttached;
    import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttachedBase;
    import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttachedDecal;
    import net.wg.gui.lobby.vehicleCustomization.controls.CheckBoxIcon;
    import net.wg.gui.lobby.vehicleCustomization.controls.CheckboxWithLabel;
    import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationBonusDelta;
    import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationItemIconRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationPopoverItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationPopoverKitRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationRadialButton;
    import net.wg.gui.lobby.vehicleCustomization.controls.FilterCounterTFContainer;
    import net.wg.gui.lobby.vehicleCustomization.controls.HistoricIndicator;
    import net.wg.gui.lobby.vehicleCustomization.controls.ItemSlot;
    import net.wg.gui.lobby.vehicleCustomization.controls.PriceItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.PurchaseTableRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.RadioButtonListSelectionNavigator;
    import net.wg.gui.lobby.vehicleCustomization.controls.RadioRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationBottomPanelTabBar;
    import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationBottomPanelTabButton;
    import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationCarouselOverlay;
    import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.IMagneticClickHandler;
    import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.MagneticToolController;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationPropertiesSheet;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetBaseBtnRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetBtnRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetContentRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetElementControls;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetIconAnimated;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetProjectionBtn;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetProjectionControls;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetRendererBase;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetScaleColorsRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetStyleItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationSheetSwitchRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.TextFieldAnimated;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController.CustomizationHintImageWrapper;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController.CustomizationInscriptionController;
    import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController.CustomizationInscriptionHint;
    import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizaionSeasonsBar;
    import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizationSeasonBGAnimation;
    import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizationSeasonRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizationSeasonRendererAnimation;
    import net.wg.gui.lobby.vehicleCustomization.controls.slot.CustomizationSlotBase;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.CustomizationSlotsLayout;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.ICustomizationSlot;
    import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelBillVO;
    import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
    import net.wg.gui.lobby.vehicleCustomization.data.ConfirmCustomizationItemDialogVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorIdVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorInitVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorPositionVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsSetVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsStateVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelNotificationVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemIconRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemPopoverHeaderVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverItemRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverKitRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPurchasesPopoverInitVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPurchasesPopoverVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationRadioRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSwitcherVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabButtonVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabNavigatorVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomziationAnchorStateVO;
    import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
    import net.wg.gui.lobby.vehicleCustomization.data.FiltersStateVO;
    import net.wg.gui.lobby.vehicleCustomization.data.HistoricIndicatorVO;
    import net.wg.gui.lobby.vehicleCustomization.data.ItemBrowserTabStateVO;
    import net.wg.gui.lobby.vehicleCustomization.data.PriceRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.SmallSlotVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationBonusDeltaVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselBookmarkVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselDataVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationItemVO;
    import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationImageVO;
    import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationInscriptionHintVO;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetButtonsBlockVO;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetButtonsRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetStyleRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.BuyWindowTittlesVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.CustomizationBuyWindowDataVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesPopoverRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchaseVO;
    import net.wg.gui.lobby.vehicleCustomization.data.seasonBar.CustomizationSeasonBarRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.BuyBtnVO;
    import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.ParamRevdererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.StyleInfoVO;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorSetEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationCarouselScrollEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationIndicatorEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemSwitchEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationStyleInfoEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationTabEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.CustomizationSheetRendererEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.ProjectionControlsEvent;
    import net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks.ImageBlockNonHistorical;
    import net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.data.CustomizationImageBlockVO;
    import net.wg.gui.lobby.vehicleHitArea.LobbyVehicleHitArea;
    import net.wg.gui.lobby.vehicleHitArea.VehicleHitArea;
    import net.wg.gui.lobby.vehicleInfo.BaseBlock;
    import net.wg.gui.lobby.vehicleInfo.CrewBlock;
    import net.wg.gui.lobby.vehicleInfo.IVehicleInfoBlock;
    import net.wg.gui.lobby.vehicleInfo.PropBlock;
    import net.wg.gui.lobby.vehicleInfo.VehicleInfo;
    import net.wg.gui.lobby.vehicleInfo.VehicleInfoBase;
    import net.wg.gui.lobby.vehicleInfo.VehicleInfoCrew;
    import net.wg.gui.lobby.vehicleInfo.VehicleInfoProps;
    import net.wg.gui.lobby.vehicleInfo.VehicleInfoViewContent;
    import net.wg.gui.lobby.vehicleInfo.data.VehCompareButtonDataVO;
    import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoButtonDataVO;
    import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoCrewBlockVO;
    import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
    import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoPropBlockVO;
    import net.wg.gui.lobby.vehiclePreview.VehiclePreview;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewBottomPanel;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewCrewInfo;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewCrewListRenderer;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewEliteFactSheet;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewFactSheet;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewHeader;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoPanel;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoPanelTab;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoTabButton;
    import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoViewStack;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBottomPanelVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewInfoVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewListRendererVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewEliteFactSheetVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewFactSheetVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewHeaderVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanelTab;
    import net.wg.gui.lobby.vehiclePreview20.CompareBlock;
    import net.wg.gui.lobby.vehiclePreview20.VehicleBasePreviewPage;
    import net.wg.gui.lobby.vehiclePreview20.VehiclePreview20Event;
    import net.wg.gui.lobby.vehiclePreview20.VehiclePreview20Page;
    import net.wg.gui.lobby.vehiclePreview20.additionalInfo.VPAdditionalInfoPanel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.CompensationPanel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.CouponRenderer;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.CouponView;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.IVPBottomPanel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.OfferRenderer;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.OffersView;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.SetItemRenderer;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.SetItemsBlock;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.SetItemsView;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.SetVehiclesRenderer;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.SetVehiclesView;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.VPBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.VPFrontlineBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.VPScrollCarousel;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.VPTradeInBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview20.data.VPAdditionalInfoVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPBuyingPanelVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPCompensationVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPCouponVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPCustomOfferVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPFrontlineBuyingPanelVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPOfferVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPPackItemVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPPageBaseVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPPageVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemsBlockVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemsVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetVehiclesVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPStyleBtnVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPTradeInBuyingPanelVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPVehicleCarouselVO;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.VPInfoPanel;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.browse.VPBrowseTab;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.browse.VPKPIItemRenderer;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.crew.CommonSkillRenderer;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.crew.VPCrewRenderer;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.crew.VPCrewRendererVO;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.crew.VPCrewTab;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.crew.VPCrewTabVO;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.modules.VPModulesPanel;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.modules.VPModulesTab;
    import net.wg.gui.lobby.vehiclePreview20.packItemsPopover.PackItemRenderer;
    import net.wg.gui.lobby.vehiclePreview20.packItemsPopover.PackItemsPopover;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.VehicleBuyWindow;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.interfaces.IVehicleBuyView;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.popover.TradeInItemRenderer;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.popover.TradeInPopover;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.popover.TradeInRendererVO;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.popover.TradeInVO;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.views.ContentBuyTradeInContainer;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.views.ContentBuyTradInView;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.views.ContentBuyView;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.views.ContentBuyViewBase;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.TradeOffVehicleVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyHeaderVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyRentItemVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyStudyVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
    import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyVo;
    import net.wg.gui.lobby.vehicleTradeWnds.cpmts.ConfirmationInput;
    import net.wg.gui.lobby.vehicleTradeWnds.cpmts.VehicleTradeHeader;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.ControlQuestionComponent;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.MovingResult;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SaleItemBlockRenderer;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SellDevicesComponent;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SellDevicesContentContainer;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SellDialogListItemRenderer;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SellHeaderComponent;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SellSlidingComponent;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SettingsButton;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.SlidingScrollingList;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.TotalResult;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.UserInputControl;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.VehicleSellDialog;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellDialogVO;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellInInventoryModuleVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellInInventoryShellVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleEquipmentVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleOptionalDeviceVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellOnVehicleShellVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellVehicleItemBaseVo;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellVehicleVo;
    import net.wg.gui.lobby.wgnc.WGNCDialog;
    import net.wg.gui.lobby.wgnc.WGNCPollWindow;
    import net.wg.gui.lobby.window.AwardWindow;
    import net.wg.gui.lobby.window.BaseExchangeWindow;
    import net.wg.gui.lobby.window.BaseExchangeWindowRateVO;
    import net.wg.gui.lobby.window.BoosterBuyContent;
    import net.wg.gui.lobby.window.BoosterBuyWindow;
    import net.wg.gui.lobby.window.BoosterInfo;
    import net.wg.gui.lobby.window.BoostersWindow;
    import net.wg.gui.lobby.window.BrowserWindow;
    import net.wg.gui.lobby.window.ConfirmExchangeBlock;
    import net.wg.gui.lobby.window.ConfirmExchangeDialog;
    import net.wg.gui.lobby.window.ConfirmItemWindow;
    import net.wg.gui.lobby.window.ConfirmItemWindowBaseVO;
    import net.wg.gui.lobby.window.ConfirmItemWindowVO;
    import net.wg.gui.lobby.window.CrystalsPromoWindow;
    import net.wg.gui.lobby.window.EpicPrimeTime;
    import net.wg.gui.lobby.window.ExchangeCurrencyWindow;
    import net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO;
    import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWarning;
    import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWindow;
    import net.wg.gui.lobby.window.ExchangeHeader;
    import net.wg.gui.lobby.window.ExchangeHeaderVO;
    import net.wg.gui.lobby.window.ExchangeUtils;
    import net.wg.gui.lobby.window.ExchangeWindow;
    import net.wg.gui.lobby.window.ExchangeXPFromVehicleIR;
    import net.wg.gui.lobby.window.ExchangeXPList;
    import net.wg.gui.lobby.window.ExchangeXPTankmanSkillsModel;
    import net.wg.gui.lobby.window.ExchangeXPVehicleVO;
    import net.wg.gui.lobby.window.ExchangeXPWarningScreen;
    import net.wg.gui.lobby.window.ExchangeXPWindow;
    import net.wg.gui.lobby.window.ExchangeXPWindowVO;
    import net.wg.gui.lobby.window.IExchangeHeader;
    import net.wg.gui.lobby.window.MissionAwardWindow;
    import net.wg.gui.lobby.window.ModuleInfo;
    import net.wg.gui.lobby.window.PrimeTime;
    import net.wg.gui.lobby.window.ProfileWindow;
    import net.wg.gui.lobby.window.ProfileWindowInitVO;
    import net.wg.gui.lobby.window.PromoPremiumIgrWindow;
    import net.wg.gui.lobby.window.PunishmentDialog;
    import net.wg.gui.lobby.window.PvESandboxQueueWindow;
    import net.wg.gui.lobby.window.RankedPrimeTime;
    import net.wg.gui.lobby.window.SwitchPeripheryWindow;
    import net.wg.gui.lobby.window.VcoinExchangeDataVO;
    import net.wg.gui.login.IFormBaseVo;
    import net.wg.gui.login.ILoginForm;
    import net.wg.gui.login.ILoginFormView;
    import net.wg.gui.login.IRssNewsFeedRenderer;
    import net.wg.gui.login.ISparksManager;
    import net.wg.gui.login.EULA.EULADlg;
    import net.wg.gui.login.EULA.EULAFullDlg;
    import net.wg.gui.login.impl.ErrorStates;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.gui.login.impl.LoginQueueWindow;
    import net.wg.gui.login.impl.LoginViewStack;
    import net.wg.gui.login.impl.RudimentarySwfOnLoginCheckingHelper;
    import net.wg.gui.login.impl.Spark;
    import net.wg.gui.login.impl.SparksManager;
    import net.wg.gui.login.impl.components.CapsLockIndicator;
    import net.wg.gui.login.impl.components.Copyright;
    import net.wg.gui.login.impl.components.CopyrightEvent;
    import net.wg.gui.login.impl.components.LoginIgrWarning;
    import net.wg.gui.login.impl.components.RssItemEvent;
    import net.wg.gui.login.impl.components.RssNewsFeed;
    import net.wg.gui.login.impl.components.RssNewsFeedRenderer;
    import net.wg.gui.login.impl.components.SocialGroup;
    import net.wg.gui.login.impl.components.SocialIconsList;
    import net.wg.gui.login.impl.components.SocialItemRenderer;
    import net.wg.gui.login.impl.ev.LoginEvent;
    import net.wg.gui.login.impl.ev.LoginEventTextLink;
    import net.wg.gui.login.impl.ev.LoginServerDDEvent;
    import net.wg.gui.login.impl.ev.LoginViewStackEvent;
    import net.wg.gui.login.impl.views.FilledLoginForm;
    import net.wg.gui.login.impl.views.LoginFormView;
    import net.wg.gui.login.impl.views.SimpleForm;
    import net.wg.gui.login.impl.vo.FilledLoginFormVo;
    import net.wg.gui.login.impl.vo.FormBaseVo;
    import net.wg.gui.login.impl.vo.RssItemVo;
    import net.wg.gui.login.impl.vo.SimpleFormVo;
    import net.wg.gui.login.impl.vo.SocialIconVo;
    import net.wg.gui.login.impl.vo.SubmitDataVo;
    import net.wg.gui.login.legal.LegalContent;
    import net.wg.gui.login.legal.LegalInfoWindow;
    import net.wg.gui.messenger.ChannelComponent;
    import net.wg.gui.messenger.ContactsListPopover;
    import net.wg.gui.messenger.IChannelComponent;
    import net.wg.gui.messenger.SmileyMap;
    import net.wg.gui.messenger.controls.BaseContactsScrollingList;
    import net.wg.gui.messenger.controls.ChannelItemRenderer;
    import net.wg.gui.messenger.controls.ContactAttributesGroup;
    import net.wg.gui.messenger.controls.ContactGroupItem;
    import net.wg.gui.messenger.controls.ContactItem;
    import net.wg.gui.messenger.controls.ContactItemRenderer;
    import net.wg.gui.messenger.controls.ContactListHeaderCheckBox;
    import net.wg.gui.messenger.controls.ContactsBaseDropListDelegate;
    import net.wg.gui.messenger.controls.ContactsBtnBar;
    import net.wg.gui.messenger.controls.ContactScrollingList;
    import net.wg.gui.messenger.controls.ContactsDropListDelegate;
    import net.wg.gui.messenger.controls.ContactsListBaseController;
    import net.wg.gui.messenger.controls.ContactsListDragDropDelegate;
    import net.wg.gui.messenger.controls.ContactsListDtagController;
    import net.wg.gui.messenger.controls.ContactsListHighlightArea;
    import net.wg.gui.messenger.controls.ContactsListItemRenderer;
    import net.wg.gui.messenger.controls.ContactsListSelectionNavigator;
    import net.wg.gui.messenger.controls.ContactsTreeComponent;
    import net.wg.gui.messenger.controls.ContactsTreeItemRenderer;
    import net.wg.gui.messenger.controls.ContactsWindowViewBG;
    import net.wg.gui.messenger.controls.DashedHighlightArea;
    import net.wg.gui.messenger.controls.EmptyHighlightArea;
    import net.wg.gui.messenger.controls.ImgDropListDelegate;
    import net.wg.gui.messenger.controls.InfoMessageView;
    import net.wg.gui.messenger.controls.MainGroupItem;
    import net.wg.gui.messenger.controls.MemberItemRenderer;
    import net.wg.gui.messenger.data.ChannelMemberVO;
    import net.wg.gui.messenger.data.ContactEvent;
    import net.wg.gui.messenger.data.ContactItemVO;
    import net.wg.gui.messenger.data.ContactListMainInfo;
    import net.wg.gui.messenger.data.ContactsConstants;
    import net.wg.gui.messenger.data.ContactsGroupEvent;
    import net.wg.gui.messenger.data.ContactsListGroupVO;
    import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
    import net.wg.gui.messenger.data.ContactsSettingsDataVO;
    import net.wg.gui.messenger.data.ContactsSettingsViewInitDataVO;
    import net.wg.gui.messenger.data.ContactsShared;
    import net.wg.gui.messenger.data.ContactsTreeDataProvider;
    import net.wg.gui.messenger.data.ContactsViewInitDataVO;
    import net.wg.gui.messenger.data.ContactsWindowInitVO;
    import net.wg.gui.messenger.data.ContactUserPropVO;
    import net.wg.gui.messenger.data.ContactVO;
    import net.wg.gui.messenger.data.ExtContactsViewInitVO;
    import net.wg.gui.messenger.data.GroupRulesVO;
    import net.wg.gui.messenger.data.IContactItemRenderer;
    import net.wg.gui.messenger.data.ITreeItemInfo;
    import net.wg.gui.messenger.data.TreeDAAPIDataProvider;
    import net.wg.gui.messenger.data.TreeItemInfo;
    import net.wg.gui.messenger.evnts.ChannelsFormEvent;
    import net.wg.gui.messenger.evnts.ContactsFormEvent;
    import net.wg.gui.messenger.evnts.ContactsScrollingListEvent;
    import net.wg.gui.messenger.evnts.ContactsTreeEvent;
    import net.wg.gui.messenger.forms.ChannelsCreateForm;
    import net.wg.gui.messenger.forms.ChannelsSearchForm;
    import net.wg.gui.messenger.forms.ContactsSearchForm;
    import net.wg.gui.messenger.meta.IBaseContactViewMeta;
    import net.wg.gui.messenger.meta.IBaseManageContactViewMeta;
    import net.wg.gui.messenger.meta.IChannelComponentMeta;
    import net.wg.gui.messenger.meta.IChannelsManagementWindowMeta;
    import net.wg.gui.messenger.meta.IChannelWindowMeta;
    import net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta;
    import net.wg.gui.messenger.meta.IContactNoteManageViewMeta;
    import net.wg.gui.messenger.meta.IContactsListPopoverMeta;
    import net.wg.gui.messenger.meta.IContactsSettingsViewMeta;
    import net.wg.gui.messenger.meta.IFAQWindowMeta;
    import net.wg.gui.messenger.meta.IGroupDeleteViewMeta;
    import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
    import net.wg.gui.messenger.meta.ISearchContactViewMeta;
    import net.wg.gui.messenger.meta.impl.BaseContactViewMeta;
    import net.wg.gui.messenger.meta.impl.BaseManageContactViewMeta;
    import net.wg.gui.messenger.meta.impl.ChannelComponentMeta;
    import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
    import net.wg.gui.messenger.meta.impl.ChannelWindowMeta;
    import net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta;
    import net.wg.gui.messenger.meta.impl.ContactNoteManageViewMeta;
    import net.wg.gui.messenger.meta.impl.ContactsListPopoverMeta;
    import net.wg.gui.messenger.meta.impl.ContactsSettingsViewMeta;
    import net.wg.gui.messenger.meta.impl.FAQWindowMeta;
    import net.wg.gui.messenger.meta.impl.GroupDeleteViewMeta;
    import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;
    import net.wg.gui.messenger.meta.impl.SearchContactViewMeta;
    import net.wg.gui.messenger.views.BaseContactView;
    import net.wg.gui.messenger.views.BaseManageContactView;
    import net.wg.gui.messenger.views.ContactNoteManageView;
    import net.wg.gui.messenger.views.ContactsSettingsView;
    import net.wg.gui.messenger.views.GroupDeleteView;
    import net.wg.gui.messenger.views.SearchContactView;
    import net.wg.gui.messenger.windows.ChannelsManagementWindow;
    import net.wg.gui.messenger.windows.ChannelWindow;
    import net.wg.gui.messenger.windows.ConnectToSecureChannelWindow;
    import net.wg.gui.messenger.windows.FAQWindow;
    import net.wg.gui.messenger.windows.LazyChannelWindow;
    import net.wg.gui.messenger.windows.LobbyChannelWindow;
    import net.wg.gui.messenger.windows.PMWarningPanel;
    import net.wg.gui.notification.NotificationListView;
    import net.wg.gui.notification.NotificationPopUpViewer;
    import net.wg.gui.notification.NotificationsList;
    import net.wg.gui.notification.NotificationTimeComponent;
    import net.wg.gui.notification.ServiceMessage;
    import net.wg.gui.notification.ServiceMessageItemRenderer;
    import net.wg.gui.notification.ServiceMessagePopUp;
    import net.wg.gui.notification.SystemMessageDialog;
    import net.wg.gui.notification.constants.ButtonState;
    import net.wg.gui.notification.constants.ButtonType;
    import net.wg.gui.notification.constants.MessageMetrics;
    import net.wg.gui.notification.events.NotificationLayoutEvent;
    import net.wg.gui.notification.events.NotificationListEvent;
    import net.wg.gui.notification.events.ServiceMessageEvent;
    import net.wg.gui.notification.vo.ButtonVO;
    import net.wg.gui.notification.vo.MessageInfoVO;
    import net.wg.gui.notification.vo.NotificationDialogInitInfoVO;
    import net.wg.gui.notification.vo.NotificationInfoVO;
    import net.wg.gui.notification.vo.NotificationMessagesListVO;
    import net.wg.gui.notification.vo.NotificationSettingsVO;
    import net.wg.gui.notification.vo.NotificationViewInitVO;
    import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
    import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;
    import net.wg.gui.prebattle.abstract.PrequeueWindow;
    import net.wg.gui.prebattle.base.BasePrebattleListView;
    import net.wg.gui.prebattle.base.BasePrebattleRoomView;
    import net.wg.gui.prebattle.battleSession.BattleSessionList;
    import net.wg.gui.prebattle.battleSession.BattleSessionListRenderer;
    import net.wg.gui.prebattle.battleSession.BattleSessionWindow;
    import net.wg.gui.prebattle.battleSession.BSFlagRenderer;
    import net.wg.gui.prebattle.battleSession.BSFlagRendererVO;
    import net.wg.gui.prebattle.battleSession.BSListRendererVO;
    import net.wg.gui.prebattle.battleSession.FlagsList;
    import net.wg.gui.prebattle.battleSession.RequirementInfo;
    import net.wg.gui.prebattle.battleSession.TopInfo;
    import net.wg.gui.prebattle.battleSession.TopStats;
    import net.wg.gui.prebattle.constants.PrebattleStateFlags;
    import net.wg.gui.prebattle.constants.PrebattleStateString;
    import net.wg.gui.prebattle.controls.TeamMemberRenderer;
    import net.wg.gui.prebattle.controls.TeamMemberRendererBase;
    import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
    import net.wg.gui.prebattle.data.ReceivedInviteVO;
    import net.wg.gui.prebattle.invites.InviteStackContainerBase;
    import net.wg.gui.prebattle.invites.PrbInviteSearchUsersForm;
    import net.wg.gui.prebattle.invites.ReceivedInviteWindow;
    import net.wg.gui.prebattle.invites.SendInvitesEvent;
    import net.wg.gui.prebattle.invites.UserRosterItemRenderer;
    import net.wg.gui.prebattle.invites.UserRosterView;
    import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
    import net.wg.gui.prebattle.meta.IBattleSessionWindowMeta;
    import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
    import net.wg.gui.prebattle.meta.IPrequeueWindowMeta;
    import net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta;
    import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
    import net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta;
    import net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta;
    import net.wg.gui.prebattle.meta.impl.PrequeueWindowMeta;
    import net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta;
    import net.wg.gui.prebattle.squads.SquadAbstractFactory;
    import net.wg.gui.prebattle.squads.SquadChatSectionBase;
    import net.wg.gui.prebattle.squads.SquadPromoWindow;
    import net.wg.gui.prebattle.squads.SquadTeamSectionBase;
    import net.wg.gui.prebattle.squads.SquadView;
    import net.wg.gui.prebattle.squads.SquadWindow;
    import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
    import net.wg.gui.prebattle.squads.interfaces.ISquadAbstractFactory;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadBonusRenderer;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadChatSection;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotHelper;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotRenderer;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
    import net.wg.gui.prebattle.squads.simple.SquadViewHeaderVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadBonusVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallyVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
    import net.wg.gui.rally.AbstractRallyView;
    import net.wg.gui.rally.AbstractRallyWindow;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import net.wg.gui.rally.BaseRallyView;
    import net.wg.gui.rally.RallyMainWindowWithSearch;
    import net.wg.gui.rally.constants.PlayerStatus;
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.CandidatesScrollingList;
    import net.wg.gui.rally.controls.ManualSearchScrollingList;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.RallySlotRenderer;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    import net.wg.gui.rally.controls.SlotRendererHelper;
    import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.interfaces.IRallySlotWithRating;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.rally.data.TooltipDataVO;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.gui.rally.helpers.RallyDragDropDelegate;
    import net.wg.gui.rally.helpers.RallyDragDropListDelegateController;
    import net.wg.gui.rally.interfaces.IBaseChatSection;
    import net.wg.gui.rally.interfaces.IBaseTeamSection;
    import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
    import net.wg.gui.rally.interfaces.IManualSearchRenderer;
    import net.wg.gui.rally.interfaces.IManualSearchScrollingList;
    import net.wg.gui.rally.interfaces.IRallyListItemVO;
    import net.wg.gui.rally.interfaces.IRallyNoSortieScreen;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.interfaces.ITeamSectionWithDropIndicators;
    import net.wg.gui.rally.views.intro.BaseRallyIntroView;
    import net.wg.gui.rally.views.list.AbtractRallyDetailsSection;
    import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
    import net.wg.gui.rally.views.list.BaseRallyListView;
    import net.wg.gui.rally.views.list.RallyNoSortieScreen;
    import net.wg.gui.rally.views.list.SimpleRallyDetailsSection;
    import net.wg.gui.rally.views.room.BaseChatSection;
    import net.wg.gui.rally.views.room.BaseRallyRoomView;
    import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
    import net.wg.gui.rally.views.room.BaseTeamSection;
    import net.wg.gui.rally.views.room.BaseWaitListSection;
    import net.wg.gui.rally.views.room.ChatSectionWithDescription;
    import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
    import net.wg.gui.rally.vo.ActionButtonVO;
    import net.wg.gui.rally.vo.IntroVehicleVO;
    import net.wg.gui.rally.vo.RallyCandidateVO;
    import net.wg.gui.rally.vo.RallyShortVO;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.gui.rally.vo.SettingRosterVO;
    import net.wg.gui.rally.vo.VehicleAlertVO;
    import net.wg.gui.tutorial.constants.HintItemType;
    import net.wg.gui.tutorial.constants.PlayerXPLevel;
    import net.wg.gui.tutorial.controls.BattleBonusItem;
    import net.wg.gui.tutorial.controls.BattleProgress;
    import net.wg.gui.tutorial.controls.ChapterProgressItemRenderer;
    import net.wg.gui.tutorial.controls.FinalStatisticProgress;
    import net.wg.gui.tutorial.controls.HintBaseItemRenderer;
    import net.wg.gui.tutorial.controls.HintList;
    import net.wg.gui.tutorial.controls.HintTextItemRenderer;
    import net.wg.gui.tutorial.controls.HintVideoItemRenderer;
    import net.wg.gui.tutorial.controls.ProgressItem;
    import net.wg.gui.tutorial.controls.ProgressSeparator;
    import net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta;
    import net.wg.gui.tutorial.meta.ITutorialBattleStatisticMeta;
    import net.wg.gui.tutorial.meta.ITutorialConfirmRefuseDialogMeta;
    import net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta;
    import net.wg.gui.tutorial.meta.impl.TutorialBattleStatisticMeta;
    import net.wg.gui.tutorial.meta.impl.TutorialConfirmRefuseDialogMeta;
    import net.wg.gui.tutorial.windows.TutorialBattleNoResultsWindow;
    import net.wg.gui.tutorial.windows.TutorialBattleStatisticWindow;
    import net.wg.gui.tutorial.windows.TutorialConfirmRefuseDialog;
    import net.wg.gui.tutorial.windows.TutorialGreetingDialog;
    import net.wg.gui.tutorial.windows.TutorialQueueDialog;
    import net.wg.gui.utils.ImageSubstitution;
    import net.wg.gui.utils.VO.PriceVO;
    import net.wg.gui.utils.VO.UnitSlotProperties;
    import net.wg.infrastructure.base.AbstractConfirmItemDialog;
    import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
    import net.wg.infrastructure.base.meta.IAbstractRallyWindowMeta;
    import net.wg.infrastructure.base.meta.IAccountPopoverMeta;
    import net.wg.infrastructure.base.meta.IAlertMessageBlockMeta;
    import net.wg.infrastructure.base.meta.IAllVehiclesTabViewMeta;
    import net.wg.infrastructure.base.meta.IAmmunitionPanelMeta;
    import net.wg.infrastructure.base.meta.IAwardGroupsMeta;
    import net.wg.infrastructure.base.meta.IAwardWindowMeta;
    import net.wg.infrastructure.base.meta.IAwardWindowsBaseMeta;
    import net.wg.infrastructure.base.meta.IBadgesPageMeta;
    import net.wg.infrastructure.base.meta.IBarracksMeta;
    import net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta;
    import net.wg.infrastructure.base.meta.IBaseMissionDetailsContainerViewMeta;
    import net.wg.infrastructure.base.meta.IBasePrebattleListViewMeta;
    import net.wg.infrastructure.base.meta.IBasePrebattleRoomViewMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyIntroViewMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyListViewMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyMainWindowMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyRoomViewMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
    import net.wg.infrastructure.base.meta.IBaseStorageCategoryViewMeta;
    import net.wg.infrastructure.base.meta.IBattleQueueMeta;
    import net.wg.infrastructure.base.meta.IBattleResultsMeta;
    import net.wg.infrastructure.base.meta.IBattleStrongholdsQueueMeta;
    import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IBCBattleResultMeta;
    import net.wg.infrastructure.base.meta.IBCMessageWindowMeta;
    import net.wg.infrastructure.base.meta.IBCNationsWindowMeta;
    import net.wg.infrastructure.base.meta.IBCOutroVideoPageMeta;
    import net.wg.infrastructure.base.meta.IBCQuestsViewMeta;
    import net.wg.infrastructure.base.meta.IBCQueueWindowMeta;
    import net.wg.infrastructure.base.meta.IBCTooltipsWindowMeta;
    import net.wg.infrastructure.base.meta.IBoosterBuyWindowMeta;
    import net.wg.infrastructure.base.meta.IBoosterInfoMeta;
    import net.wg.infrastructure.base.meta.IBoostersWindowMeta;
    import net.wg.infrastructure.base.meta.IBrowserInViewComponentMeta;
    import net.wg.infrastructure.base.meta.IBrowserMeta;
    import net.wg.infrastructure.base.meta.IBrowserScreenMeta;
    import net.wg.infrastructure.base.meta.IBrowserViewStackExPaddingMeta;
    import net.wg.infrastructure.base.meta.IBrowserWindowMeta;
    import net.wg.infrastructure.base.meta.IButtonWithCounterMeta;
    import net.wg.infrastructure.base.meta.ICalendarMeta;
    import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
    import net.wg.infrastructure.base.meta.ICheckBoxDialogMeta;
    import net.wg.infrastructure.base.meta.IClanInvitesViewMeta;
    import net.wg.infrastructure.base.meta.IClanInvitesViewWithTableMeta;
    import net.wg.infrastructure.base.meta.IClanInvitesWindowAbstractTabViewMeta;
    import net.wg.infrastructure.base.meta.IClanInvitesWindowMeta;
    import net.wg.infrastructure.base.meta.IClanPersonalInvitesViewMeta;
    import net.wg.infrastructure.base.meta.IClanPersonalInvitesWindowMeta;
    import net.wg.infrastructure.base.meta.IClanProfileBaseViewMeta;
    import net.wg.infrastructure.base.meta.IClanProfileGlobalMapInfoViewMeta;
    import net.wg.infrastructure.base.meta.IClanProfileGlobalMapPromoViewMeta;
    import net.wg.infrastructure.base.meta.IClanProfileMainWindowMeta;
    import net.wg.infrastructure.base.meta.IClanProfilePersonnelViewMeta;
    import net.wg.infrastructure.base.meta.IClanProfileSummaryViewMeta;
    import net.wg.infrastructure.base.meta.IClanProfileTableStatisticsViewMeta;
    import net.wg.infrastructure.base.meta.IClanRequestsViewMeta;
    import net.wg.infrastructure.base.meta.IClanSearchInfoMeta;
    import net.wg.infrastructure.base.meta.IClanSearchWindowMeta;
    import net.wg.infrastructure.base.meta.IConfirmDialogMeta;
    import net.wg.infrastructure.base.meta.IConfirmExchangeDialogMeta;
    import net.wg.infrastructure.base.meta.IConfirmItemWindowMeta;
    import net.wg.infrastructure.base.meta.IContactsTreeComponentMeta;
    import net.wg.infrastructure.base.meta.ICrewMeta;
    import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
    import net.wg.infrastructure.base.meta.ICrewSkinsCompensationDialogMeta;
    import net.wg.infrastructure.base.meta.ICrystalsPromoWindowMeta;
    import net.wg.infrastructure.base.meta.ICurrentVehicleMissionsViewMeta;
    import net.wg.infrastructure.base.meta.ICustomizationBottomPanelMeta;
    import net.wg.infrastructure.base.meta.ICustomizationBuyWindowMeta;
    import net.wg.infrastructure.base.meta.ICustomizationConfigurationWindowMeta;
    import net.wg.infrastructure.base.meta.ICustomizationFiltersPopoverMeta;
    import net.wg.infrastructure.base.meta.ICustomizationInscriptionControllerMeta;
    import net.wg.infrastructure.base.meta.ICustomizationItemsPopoverMeta;
    import net.wg.infrastructure.base.meta.ICustomizationKitPopoverMeta;
    import net.wg.infrastructure.base.meta.ICustomizationMainViewMeta;
    import net.wg.infrastructure.base.meta.ICustomizationNonHistoricPopoverMeta;
    import net.wg.infrastructure.base.meta.ICustomizationPropertiesSheetMeta;
    import net.wg.infrastructure.base.meta.ICustomizationStyleInfoMeta;
    import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
    import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
    import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
    import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
    import net.wg.infrastructure.base.meta.IDemonstratorWindowMeta;
    import net.wg.infrastructure.base.meta.IDemoPageMeta;
    import net.wg.infrastructure.base.meta.IEliteWindowMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesAfterBattleViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesBrowserViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesInfoViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesOfflineViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesPrestigeViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesSkillViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesWelcomeBackViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesWidgetMeta;
    import net.wg.infrastructure.base.meta.IEpicBattleTrainingRoomMeta;
    import net.wg.infrastructure.base.meta.IEULAMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsAwardsOverlayMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsBattleOverlayMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsDetailsContainerViewMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsResultFilterPopoverViewMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsResultFilterVehiclesPopoverViewMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsTableViewMeta;
    import net.wg.infrastructure.base.meta.IEventBoardsVehiclesOverlayMeta;
    import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
    import net.wg.infrastructure.base.meta.IExchangeWindowMeta;
    import net.wg.infrastructure.base.meta.IExchangeXpWindowMeta;
    import net.wg.infrastructure.base.meta.IFittingSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortBattleRoomWindowMeta;
    import net.wg.infrastructure.base.meta.IFortClanBattleRoomMeta;
    import net.wg.infrastructure.base.meta.IFortDisconnectViewMeta;
    import net.wg.infrastructure.base.meta.IFortVehicleSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IFreeSheetPopoverMeta;
    import net.wg.infrastructure.base.meta.IFreeXPInfoWindowMeta;
    import net.wg.infrastructure.base.meta.IFrontlineBuyConfirmViewMeta;
    import net.wg.infrastructure.base.meta.IGetPremiumPopoverMeta;
    import net.wg.infrastructure.base.meta.IGoldFishWindowMeta;
    import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
    import net.wg.infrastructure.base.meta.IHangarMeta;
    import net.wg.infrastructure.base.meta.IIconDialogMeta;
    import net.wg.infrastructure.base.meta.IIconPriceDialogMeta;
    import net.wg.infrastructure.base.meta.IImageViewMeta;
    import net.wg.infrastructure.base.meta.IInputCheckerMeta;
    import net.wg.infrastructure.base.meta.IIntroPageMeta;
    import net.wg.infrastructure.base.meta.IInventoryMeta;
    import net.wg.infrastructure.base.meta.IItemsWithTypeAndNationFilterTabViewMeta;
    import net.wg.infrastructure.base.meta.IItemsWithTypeFilterTabViewMeta;
    import net.wg.infrastructure.base.meta.IItemsWithVehicleFilterTabViewMeta;
    import net.wg.infrastructure.base.meta.ILegalInfoWindowMeta;
    import net.wg.infrastructure.base.meta.ILinkedSetDetailsContainerViewMeta;
    import net.wg.infrastructure.base.meta.ILinkedSetDetailsOverlayMeta;
    import net.wg.infrastructure.base.meta.ILinkedSetHintsViewMeta;
    import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
    import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
    import net.wg.infrastructure.base.meta.ILobbyPageMeta;
    import net.wg.infrastructure.base.meta.ILobbyVehicleMarkerViewMeta;
    import net.wg.infrastructure.base.meta.ILoginPageMeta;
    import net.wg.infrastructure.base.meta.ILoginQueueWindowMeta;
    import net.wg.infrastructure.base.meta.IMaintenanceComponentMeta;
    import net.wg.infrastructure.base.meta.IManualChapterViewMeta;
    import net.wg.infrastructure.base.meta.IManualMainViewMeta;
    import net.wg.infrastructure.base.meta.IMessengerBarMeta;
    import net.wg.infrastructure.base.meta.IMiniClientComponentMeta;
    import net.wg.infrastructure.base.meta.IMissionAwardWindowMeta;
    import net.wg.infrastructure.base.meta.IMissionDetailsContainerViewMeta;
    import net.wg.infrastructure.base.meta.IMissionsEventBoardsViewMeta;
    import net.wg.infrastructure.base.meta.IMissionsFilterPopoverViewMeta;
    import net.wg.infrastructure.base.meta.IMissionsGroupedViewMeta;
    import net.wg.infrastructure.base.meta.IMissionsMarathonViewMeta;
    import net.wg.infrastructure.base.meta.IMissionsPageMeta;
    import net.wg.infrastructure.base.meta.IMissionsTokenPopoverMeta;
    import net.wg.infrastructure.base.meta.IMissionsVehicleSelectorMeta;
    import net.wg.infrastructure.base.meta.IMissionsViewBaseMeta;
    import net.wg.infrastructure.base.meta.IModuleInfoMeta;
    import net.wg.infrastructure.base.meta.IModulesPanelMeta;
    import net.wg.infrastructure.base.meta.INotificationListButtonMeta;
    import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
    import net.wg.infrastructure.base.meta.INotificationsListMeta;
    import net.wg.infrastructure.base.meta.INYSelectVehiclePopoverMeta;
    import net.wg.infrastructure.base.meta.IPackItemsPopoverMeta;
    import net.wg.infrastructure.base.meta.IPaginationMeta;
    import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionDetailsContainerViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionFirstEntryAwardViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionFirstEntryViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionOperationsMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsAbstractInfoViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsAwardsViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsMapViewMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsOperationAwardsScreenMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsPageMeta;
    import net.wg.infrastructure.base.meta.IPersonalMissionsQuestAwardScreenMeta;
    import net.wg.infrastructure.base.meta.IPremiumWindowMeta;
    import net.wg.infrastructure.base.meta.IPrimeTimeMeta;
    import net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta;
    import net.wg.infrastructure.base.meta.IProfileAwardsMeta;
    import net.wg.infrastructure.base.meta.IProfileFormationsPageMeta;
    import net.wg.infrastructure.base.meta.IProfileHofMeta;
    import net.wg.infrastructure.base.meta.IProfileMeta;
    import net.wg.infrastructure.base.meta.IProfileSectionMeta;
    import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
    import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
    import net.wg.infrastructure.base.meta.IProfileSummaryWindowMeta;
    import net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta;
    import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
    import net.wg.infrastructure.base.meta.IProfileTechniquePageMeta;
    import net.wg.infrastructure.base.meta.IProfileWindowMeta;
    import net.wg.infrastructure.base.meta.IProgressiveRewardWidgetMeta;
    import net.wg.infrastructure.base.meta.IPromoPremiumIgrWindowMeta;
    import net.wg.infrastructure.base.meta.IPunishmentDialogMeta;
    import net.wg.infrastructure.base.meta.IPvESandboxQueueWindowMeta;
    import net.wg.infrastructure.base.meta.IQuestRecruitWindowMeta;
    import net.wg.infrastructure.base.meta.IQuestsContentTabsMeta;
    import net.wg.infrastructure.base.meta.IRallyMainWindowWithSearchMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesAwardsViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesBattleResultsMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesDivisionProgressMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesDivisionQualificationMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesDivisionsViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesHangarWidgetMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesIntroMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesLeaguesViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesPageMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesRewardsLeaguesMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesRewardsMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesRewardsRanksMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesRewardsYearMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesSeasonCompleteViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesSeasonGapViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesUnreachableViewMeta;
    import net.wg.infrastructure.base.meta.IRankedPrimeTimeMeta;
    import net.wg.infrastructure.base.meta.IRecruitParametersMeta;
    import net.wg.infrastructure.base.meta.IRecruitWindowMeta;
    import net.wg.infrastructure.base.meta.IRegularItemsTabViewMeta;
    import net.wg.infrastructure.base.meta.IRentalTermSelectionPopoverMeta;
    import net.wg.infrastructure.base.meta.IRentVehiclesTabViewMeta;
    import net.wg.infrastructure.base.meta.IResearchMeta;
    import net.wg.infrastructure.base.meta.IResearchPanelMeta;
    import net.wg.infrastructure.base.meta.IResearchViewMeta;
    import net.wg.infrastructure.base.meta.IRestoreVehiclesTabViewMeta;
    import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
    import net.wg.infrastructure.base.meta.IRoleChangeMeta;
    import net.wg.infrastructure.base.meta.IRosterSlotSettingsWindowMeta;
    import net.wg.infrastructure.base.meta.IRssNewsFeedMeta;
    import net.wg.infrastructure.base.meta.ISendInvitesWindowMeta;
    import net.wg.infrastructure.base.meta.ISeniorityAwardsEntryPointMeta;
    import net.wg.infrastructure.base.meta.ISessionBattleStatsViewMeta;
    import net.wg.infrastructure.base.meta.ISessionStatsPopoverMeta;
    import net.wg.infrastructure.base.meta.ISessionVehicleStatsViewMeta;
    import net.wg.infrastructure.base.meta.IShopMeta;
    import net.wg.infrastructure.base.meta.ISimpleWindowMeta;
    import net.wg.infrastructure.base.meta.ISkillDropMeta;
    import net.wg.infrastructure.base.meta.ISlotsPanelMeta;
    import net.wg.infrastructure.base.meta.ISquadPromoWindowMeta;
    import net.wg.infrastructure.base.meta.ISquadViewMeta;
    import net.wg.infrastructure.base.meta.ISquadWindowMeta;
    import net.wg.infrastructure.base.meta.IStorageCarouselEnvironmentMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryBlueprintsViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryCustomizationViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryForSellViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryInHangarViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryPersonalReservesViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryStorageViewMeta;
    import net.wg.infrastructure.base.meta.IStorageVehicleSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IStorageViewMeta;
    import net.wg.infrastructure.base.meta.IStoreActionsViewMeta;
    import net.wg.infrastructure.base.meta.IStoreComponentMeta;
    import net.wg.infrastructure.base.meta.IStoreTableMeta;
    import net.wg.infrastructure.base.meta.IStoreViewMeta;
    import net.wg.infrastructure.base.meta.IStrongholdBattlesListViewMeta;
    import net.wg.infrastructure.base.meta.IStrongholdViewMeta;
    import net.wg.infrastructure.base.meta.ISwitchModePanelMeta;
    import net.wg.infrastructure.base.meta.ISwitchPeripheryWindowMeta;
    import net.wg.infrastructure.base.meta.ISystemMessageDialogMeta;
    import net.wg.infrastructure.base.meta.ITankCarouselMeta;
    import net.wg.infrastructure.base.meta.ITankgirlsPopoverMeta;
    import net.wg.infrastructure.base.meta.ITankmanOperationDialogMeta;
    import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
    import net.wg.infrastructure.base.meta.ITechTreeMeta;
    import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
    import net.wg.infrastructure.base.meta.ITradeInPopupMeta;
    import net.wg.infrastructure.base.meta.ITradeOffWidgetMeta;
    import net.wg.infrastructure.base.meta.ITrainingFormMeta;
    import net.wg.infrastructure.base.meta.ITrainingRoomBaseMeta;
    import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
    import net.wg.infrastructure.base.meta.IUnboundInjectWindowMeta;
    import net.wg.infrastructure.base.meta.IUseAwardSheetWindowMeta;
    import net.wg.infrastructure.base.meta.IVehicleBasePreviewMeta;
    import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareCartPopoverMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareCommonViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorBaseViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorMainMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
    import net.wg.infrastructure.base.meta.IVehicleListPopupMeta;
    import net.wg.infrastructure.base.meta.IVehicleModulesViewMeta;
    import net.wg.infrastructure.base.meta.IVehicleParametersMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreview20Meta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewBrowseTabMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewBuyingPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewCrewTabMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewFrontlineBuyingPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewModulesTabMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewTradeInBuyingPanelMeta;
    import net.wg.infrastructure.base.meta.IVehicleSelectorCarouselMeta;
    import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
    import net.wg.infrastructure.base.meta.IVehicleSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IVehicleSellConfirmationPopoverMeta;
    import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
    import net.wg.infrastructure.base.meta.IWGNCDialogMeta;
    import net.wg.infrastructure.base.meta.IWGNCPollWindowMeta;
    import net.wg.infrastructure.events.DragEvent;
    import net.wg.infrastructure.events.DropEvent;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import net.wg.infrastructure.events.FocusedViewEvent;
    import net.wg.infrastructure.events.GameEvent;
    import net.wg.infrastructure.helpers.DragDelegate;
    import net.wg.infrastructure.helpers.DragDelegateController;
    import net.wg.infrastructure.helpers.DropListDelegate;
    import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
    import net.wg.infrastructure.helpers.LoaderEx;
    import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
    import net.wg.infrastructure.interfaces.ISortable;
    import net.wg.infrastructure.tutorial.builders.TutorialBuilder;
    import net.wg.infrastructure.tutorial.builders.TutorialCustomHintBuilder;
    import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.TutorialHintBuilder;
    import net.wg.infrastructure.tutorial.builders.TutorialOverlayBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialAmmunitionEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialClipEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialEnabledEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialHangarTweenEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialHangarVisibilityEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialHighlightEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialLobbyEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialOverlayEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialQuestVisibilityEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialTweenEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TutorialVisibilityEffectBuilder;
    import net.wg.infrastructure.tutorial.builders.bootcamp.TweenFactory;
    import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialHelpBtnController;
    import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialViewHelpBtnCtrllr;
    import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialWindowHelpBtnCtrllr;
    import net.wg.infrastructure.tutorial.helpBtnControllers.interfaces.ITutorialHelpBtnController;

    public class ClassManagerMeta extends Object
    {

        public static const NET_WG_DATA_CONTAINERCONSTANTS:Class = ContainerConstants;

        public static const NET_WG_DATA_INSPECTABLEDATAPROVIDER:Class = InspectableDataProvider;

        public static const NET_WG_DATA_SORTABLEVODAAPIDATAPROVIDER:Class = SortableVoDAAPIDataProvider;

        public static const NET_WG_DATA_VODAAPIDATAPROVIDER:Class = VoDAAPIDataProvider;

        public static const NET_WG_DATA_COMPONENTS_STOREMENUVIEWDATA:Class = StoreMenuViewData;

        public static const NET_WG_DATA_COMPONENTS_USERCONTEXTITEM:Class = UserContextItem;

        public static const NET_WG_DATA_COMPONENTS_VEHICLECONTEXTMENUGENERATOR:Class = VehicleContextMenuGenerator;

        public static const NET_WG_DATA_CONSTANTS_ARENABONUSTYPES:Class = ArenaBonusTypes;

        public static const NET_WG_DATA_CONSTANTS_DIALOGS:Class = Dialogs;

        public static const NET_WG_DATA_CONSTANTS_DIRECTIONS:Class = Directions;

        public static const NET_WG_DATA_CONSTANTS_GUNTYPES:Class = GunTypes;

        public static const NET_WG_DATA_CONSTANTS_ITEMTYPES:Class = ItemTypes;

        public static const NET_WG_DATA_CONSTANTS_LOBBYSHARED:Class = LobbyShared;

        public static const NET_WG_DATA_CONSTANTS_NATIONS:Class = Nations;

        public static const NET_WG_DATA_CONSTANTS_PROGRESSINDICATORSTATES:Class = ProgressIndicatorStates;

        public static const NET_WG_DATA_CONSTANTS_QUESTSSTATES:Class = QuestsStates;

        public static const NET_WG_DATA_CONSTANTS_ROLESSTATE:Class = RolesState;

        public static const NET_WG_DATA_CONSTANTS_UNITROLE:Class = UnitRole;

        public static const NET_WG_DATA_CONSTANTS_VALOBJECT:Class = ValObject;

        public static const NET_WG_DATA_CONSTANTS_VEHICLESTATE:Class = VehicleState;

        public static const NET_WG_DATA_CONSTANTS_VEHICLETYPES:Class = VehicleTypes;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_ACHIEVEMENTS_ALIASES:Class = ACHIEVEMENTS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_ACTION_PRICE_CONSTANTS:Class = ACTION_PRICE_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_AWARDWINDOW_CONSTANTS:Class = AWARDWINDOW_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BARRACKS_CONSTANTS:Class = BARRACKS_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_RESULTS_PREMIUM_STATES:Class = BATTLE_RESULTS_PREMIUM_STATES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_RESULT_TYPES:Class = BATTLE_RESULT_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BOOSTER_CONSTANTS:Class = BOOSTER_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BOOTCAMP_BATTLE_RESULT_CONSTANTS:Class = BOOTCAMP_BATTLE_RESULT_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BOOTCAMP_HANGAR_ALIASES:Class = BOOTCAMP_HANGAR_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BOOTCAMP_MESSAGE_ALIASES:Class = BOOTCAMP_MESSAGE_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_BROWSER_CONSTANTS:Class = BROWSER_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CLANS_ALIASES:Class = CLANS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CONFIRM_DIALOG_ALIASES:Class = CONFIRM_DIALOG_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CONFIRM_EXCHANGE_DIALOG_TYPES:Class = CONFIRM_EXCHANGE_DIALOG_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CONTACTS_ALIASES:Class = CONTACTS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CONTEXT_MENU_HANDLER_TYPE:Class = CONTEXT_MENU_HANDLER_TYPE;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CUSTOMIZATION_ALIASES:Class = CUSTOMIZATION_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_CYBER_SPORT_ALIASES:Class = CYBER_SPORT_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_EPICBATTLES_ALIASES:Class = EPICBATTLES_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_EVENTBOARDS_ALIASES:Class = EVENTBOARDS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_FITTING_TYPES:Class = FITTING_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_FORTIFICATION_ALIASES:Class = FORTIFICATION_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_GRAPHICS_OPTIMIZATION_ALIASES:Class = GRAPHICS_OPTIMIZATION_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_HANGAR_ALIASES:Class = HANGAR_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_HANGAR_HEADER_QUESTS:Class = HANGAR_HEADER_QUESTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_LINKEDSET_ALIASES:Class = LINKEDSET_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_MANUAL_TEMPLATES:Class = MANUAL_TEMPLATES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_MENU_CONSTANTS:Class = MENU_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES:Class = MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_MISSIONS_ALIASES:Class = MISSIONS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_MISSIONS_CONSTANTS:Class = MISSIONS_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_NODE_STATE_FLAGS:Class = NODE_STATE_FLAGS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_NOTIFICATIONS_CONSTANTS:Class = NOTIFICATIONS_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PERSONAL_MISSIONS_ALIASES:Class = PERSONAL_MISSIONS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PERSONAL_MISSIONS_BUTTONS:Class = PERSONAL_MISSIONS_BUTTONS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PREBATTLE_ALIASES:Class = PREBATTLE_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PROFILE_CONSTANTS:Class = PROFILE_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PROFILE_DROPDOWN_KEYS:Class = PROFILE_DROPDOWN_KEYS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_PROGRESSIVEREWARD_CONSTANTS:Class = PROGRESSIVEREWARD_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_QUESTS_ALIASES:Class = QUESTS_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_QUEST_AWARD_BLOCK_ALIASES:Class = QUEST_AWARD_BLOCK_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_RANKEDBATTLES_ALIASES:Class = RANKEDBATTLES_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_RANKEDBATTLES_CONSTS:Class = RANKEDBATTLES_CONSTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_SESSION_STATS_CONSTANTS:Class = SESSION_STATS_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_SHOP20_ALIASES:Class = SHOP20_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_SKILLS_CONSTANTS:Class = SKILLS_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_SLOT_HIGHLIGHT_TYPES:Class = SLOT_HIGHLIGHT_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_SQUADTYPES:Class = SQUADTYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_STORAGE_CONSTANTS:Class = STORAGE_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_STORE_CONSTANTS:Class = STORE_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_STORE_TYPES:Class = STORE_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_TEXT_ALIGN:Class = TEXT_ALIGN;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_TWEEN_EFFECT_TYPES:Class = TWEEN_EFFECT_TYPES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHICLE_BUY_WINDOW_ALIASES:Class = VEHICLE_BUY_WINDOW_ALIASES;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHICLE_COMPARE_CONSTANTS:Class = VEHICLE_COMPARE_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHICLE_SELECTOR_CONSTANTS:Class = VEHICLE_SELECTOR_CONSTANTS;

        public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHPREVIEW_CONSTANTS:Class = VEHPREVIEW_CONSTANTS;

        public static const NET_WG_DATA_GENERATED_MODELS_DEMOSUBMODEL:Class = DemoSubModel;

        public static const NET_WG_DATA_GENERATED_MODELS_DEMOVIEWMODEL:Class = DemoViewModel;

        public static const NET_WG_DATA_GENERATED_MODELS_TESTVIEWMODEL:Class = net.wg.data.generated.models.TestViewModel;

        public static const NET_WG_DATA_GENERATED_MODELS_TEXTVIEWMODEL:Class = net.wg.data.generated.models.TextViewModel;

        public static const NET_WG_DATA_GENERATED_VIEWS_DEMOVIEWBASE:Class = DemoViewBase;

        public static const NET_WG_DATA_GENERATED_VIEWS_TESTVIEWBASE:Class = net.wg.data.generated.views.TestViewBase;

        public static const NET_WG_DATA_MANAGERS_IMPL_DIALOGDISPATCHER:Class = DialogDispatcher;

        public static const NET_WG_DATA_MANAGERS_IMPL_NOTIFYPROPERTIES:Class = NotifyProperties;

        public static const NET_WG_DATA_UTILDATA_ITEMPRICE:Class = ItemPrice;

        public static const NET_WG_DATA_UTILDATA_TANKMANROLELEVEL:Class = TankmanRoleLevel;

        public static const NET_WG_DATA_VO_ANIMATIONOBJECT:Class = AnimationObject;

        public static const NET_WG_DATA_VO_AWARDSITEMVO:Class = AwardsItemVO;

        public static const NET_WG_DATA_VO_BATTLERESULTSQUESTVO:Class = BattleResultsQuestVO;

        public static const NET_WG_DATA_VO_BUTTONPROPERTIESVO:Class = ButtonPropertiesVO;

        public static const NET_WG_DATA_VO_CONFIRMDIALOGVO:Class = ConfirmDialogVO;

        public static const NET_WG_DATA_VO_CONFIRMEXCHANGEBLOCKVO:Class = ConfirmExchangeBlockVO;

        public static const NET_WG_DATA_VO_CONFIRMEXCHANGEDIALOGVO:Class = ConfirmExchangeDialogVO;

        public static const NET_WG_DATA_VO_DIALOGSETTINGSVO:Class = DialogSettingsVO;

        public static const NET_WG_DATA_VO_EPICBATTLETRAININGROOMTEAMVO:Class = EpicBattleTrainingRoomTeamVO;

        public static const NET_WG_DATA_VO_EXTENDEDUSERVO:Class = ExtendedUserVO;

        public static const NET_WG_DATA_VO_ILDITINFO:Class = ILditInfo;

        public static const NET_WG_DATA_VO_POINTVO:Class = PointVO;

        public static const NET_WG_DATA_VO_PROGRESSELEMENTVO:Class = ProgressElementVO;

        public static const NET_WG_DATA_VO_SELLDIALOGELEMENT:Class = SellDialogElement;

        public static const NET_WG_DATA_VO_SELLDIALOGITEM:Class = SellDialogItem;

        public static const NET_WG_DATA_VO_SHOPNATIONFILTERDATAVO:Class = ShopNationFilterDataVo;

        public static const NET_WG_DATA_VO_SHOPSUBFILTERDATA:Class = ShopSubFilterData;

        public static const NET_WG_DATA_VO_SHOPVEHICLEFILTERELEMENTDATA:Class = ShopVehicleFilterElementData;

        public static const NET_WG_DATA_VO_STORETABLEDATA:Class = StoreTableData;

        public static const NET_WG_DATA_VO_STORETABLEVO:Class = StoreTableVO;

        public static const NET_WG_DATA_VO_TANKMANACHIEVEMENTVO:Class = TankmanAchievementVO;

        public static const NET_WG_DATA_VO_TANKMANCARDVO:Class = TankmanCardVO;

        public static const NET_WG_DATA_VO_TRAININGFORMINFOVO:Class = TrainingFormInfoVO;

        public static const NET_WG_DATA_VO_TRAININGFORMRENDERERVO:Class = TrainingFormRendererVO;

        public static const NET_WG_DATA_VO_TRAININGFORMVO:Class = TrainingFormVO;

        public static const NET_WG_DATA_VO_TRAININGROOMINFOVO:Class = TrainingRoomInfoVO;

        public static const NET_WG_DATA_VO_TRAININGROOMLISTVO:Class = TrainingRoomListVO;

        public static const NET_WG_DATA_VO_TRAININGROOMRENDERERVO:Class = TrainingRoomRendererVO;

        public static const NET_WG_DATA_VO_TRAININGROOMTEAMBASEVO:Class = TrainingRoomTeamBaseVO;

        public static const NET_WG_DATA_VO_TRAININGROOMTEAMVO:Class = TrainingRoomTeamVO;

        public static const NET_WG_DATA_VO_TRAININGWINDOWVO:Class = TrainingWindowVO;

        public static const NET_WG_DATA_VO_WALLETSTATUSVO:Class = WalletStatusVO;

        public static const NET_WG_GUI_BOOTCAMP_BCHIGHLIGHTSOVERLAY:Class = BCHighlightsOverlay;

        public static const NET_WG_GUI_BOOTCAMP_BCOUTROVIDEOPAGE:Class = BCOutroVideoPage;

        public static const NET_WG_GUI_BOOTCAMP_BCOUTROVIDEOVO:Class = BCOutroVideoVO;

        public static const NET_WG_GUI_BOOTCAMP_BCTOOLTIPSWINDOW:Class = BCTooltipsWindow;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_BCBATTLERESULT:Class = BCBattleResult;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_ANIMATIONCONTAINER:Class = AnimationContainer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BATTLEITEMRENDERERBASE:Class = BattleItemRendererBase;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BATTLEMEDALRENDERER:Class = BattleMedalRenderer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BATTLERESULTGROUPLAYOUT:Class = BattleResultGroupLayout;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BATTLERESULTSGROUP:Class = BattleResultsGroup;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BATTLESTATRENDERER:Class = BattleStatRenderer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_BOTTOMCONTAINER:Class = BottomContainer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_REWARDSTATCONTAINER:Class = RewardStatContainer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_REWARDSTATSCONTAINER:Class = RewardStatsContainer;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_STATRENDERERCONTENT:Class = StatRendererContent;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_CONTAINERS_TANKLABEL:Class = TankLabel;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_DATA_BATTLEITEMRENDRERVO:Class = BattleItemRendrerVO;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_DATA_BCBATTLEVIEWVO:Class = BCBattleViewVO;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_DATA_PLAYERVEHICLEVO:Class = PlayerVehicleVO;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_DATA_REWARDDATAVO:Class = RewardDataVO;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_EVENTS_BATTLEVIEWEVENT:Class = BattleViewEvent;

        public static const NET_WG_GUI_BOOTCAMP_BATTLERESULT_VIEWS_BATTLESTATSVIEW:Class = BattleStatsView;

        public static const NET_WG_GUI_BOOTCAMP_CONSTANTS_BOOTCAMP_DISPLAY:Class = BOOTCAMP_DISPLAY;

        public static const NET_WG_GUI_BOOTCAMP_CONTROLS_LOADERCONTAINER:Class = LoaderContainer;

        public static const NET_WG_GUI_BOOTCAMP_LOBBY_BCVEHICLEBUYVIEW:Class = BCVehicleBuyView;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_BCMESSAGEWINDOW:Class = BCMessageWindow;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_CONTAINERS_ANIMATEDSHAPECONTAINER:Class = AnimatedShapeContainer;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_CONTROLS_MESSAGEITEMRENDERERBASE:Class = MessageItemRendererBase;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_CONTROLS_MESSAGEITEMRENDERERREWARD:Class = MessageItemRendererReward;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_DATA_MESSAGEBOTTOMITEMVO:Class = MessageBottomItemVO;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_DATA_MESSAGECONTENTVO:Class = MessageContentVO;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_EVENTS_MESSAGEVIEWEVENT:Class = MessageViewEvent;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_INTERFACES_IBOTTOMRENDERER:Class = IBottomRenderer;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_INTERFACES_IMESSAGEVIEW:Class = IMessageView;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_VIEWS_MESSAGEVIEWBASE:Class = MessageViewBase;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_VIEWS_MESSAGEVIEWLINES:Class = MessageViewLines;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_VIEWS_MESSAGEVIEWLINESFINAL:Class = MessageViewLinesFinal;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_VIEWS_BOTTOM_BOTTOMBUTTONSVIEW:Class = BottomButtonsView;

        public static const NET_WG_GUI_BOOTCAMP_MESSAGEWINDOW_VIEWS_BOTTOM_BOTTOMLISTVIEWBASE:Class = BottomListViewBase;

        public static const NET_WG_GUI_BOOTCAMP_NATIONSWINDOW_BCNATIONSWINDOW:Class = BCNationsWindow;

        public static const NET_WG_GUI_BOOTCAMP_NATIONSWINDOW_CONTAINERS_NATIONSCONTAINER:Class = NationsContainer;

        public static const NET_WG_GUI_BOOTCAMP_NATIONSWINDOW_CONTAINERS_NATIONSSELECTORCONTAINER:Class = NationsSelectorContainer;

        public static const NET_WG_GUI_BOOTCAMP_NATIONSWINDOW_CONTAINERS_TANKINFOCONTAINER:Class = TankInfoContainer;

        public static const NET_WG_GUI_BOOTCAMP_NATIONSWINDOW_EVENTS_NATIONSELECTEVENT:Class = NationSelectEvent;

        public static const NET_WG_GUI_BOOTCAMP_QUESTSVIEW_BCQUESTSVIEW:Class = BCQuestsView;

        public static const NET_WG_GUI_BOOTCAMP_QUESTSVIEW_CONTAINERS_MISSIONCONTAINER:Class = MissionContainer;

        public static const NET_WG_GUI_BOOTCAMP_QUESTSVIEW_DATA_BCQUESTSVIEWVO:Class = BCQuestsViewVO;

        public static const NET_WG_GUI_BOOTCAMP_QUEUEWINDOW_BCQUEUEWINDOW:Class = BCQueueWindow;

        public static const NET_WG_GUI_BOOTCAMP_QUEUEWINDOW_DATA_BCQUEUEVO:Class = BCQueueVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_ACCORDION:Class = Accordion;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_ADVANCEDLINEDESCRICONTEXT:Class = AdvancedLineDescrIconText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_AMMUNITIONBUTTON:Class = AmmunitionButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_AWARDITEM:Class = AwardItem;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_AWARDITEMEX:Class = AwardItemEx;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON:Class = BackButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BLINKINGBUTTON:Class = BlinkingButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BUTTONTOGGLEINDICATOR:Class = ButtonToggleIndicator;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR:Class = net.wg.gui.components.advanced.Calendar;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_CLANEMBLEM:Class = ClanEmblem;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COMPLEXPROGRESSINDICATOR:Class = ComplexProgressIndicator;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COOLDOWNANIMATIONCONTROLLER:Class = CooldownAnimationController;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COOLDOWNSLOT:Class = CooldownSlot;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COUNTEREX:Class = CounterEx;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_DASHLINETEXTITEM:Class = DashLineTextItem;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_DOUBLEPROGRESSBAR:Class = DoubleProgressBar;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_DUMMY:Class = Dummy;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EXTRAMODULEICON:Class = ExtraModuleIcon;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_HELPLAYOUTCONTROL:Class = HelpLayoutControl;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INDICATIONOFSTATUS:Class = IndicationOfStatus;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERACTIVESORTINGBUTTON:Class = InteractiveSortingButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INVITEINDICATOR:Class = InviteIndicator;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_ITEMBROWSERTABMASK:Class = ItemBrowserTabMask;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_LINEDESCRICONTEXT:Class = LineDescrIconText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_LINEICONTEXT:Class = LineIconText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_MODULEICON:Class = ModuleIcon;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_NORMALBUTTONTOGGLEWG:Class = NormalButtonToggleWG;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_PORTRAITITEMRENDERER:Class = PortraitItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_RECRUITPARAMETERSCOMPONENT:Class = RecruitParametersComponent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONWRAPPER:Class = ScalableIconWrapper;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLBUTTON:Class = ShellButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLSSET:Class = ShellsSet;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SKILLSITEMRENDERER:Class = SkillsItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SKILLSLEVELITEMRENDERER:Class = SkillsLevelItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTABLEHEADERBUTTONBAR:Class = SortableHeaderButtonBar;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTINGBUTTON:Class = SortingButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_STATICITEMSLOT:Class = StaticItemSlot;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_STATISTICITEM:Class = StatisticItem;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_STATUSDELTAINDICATORANIM:Class = StatusDeltaIndicatorAnim;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TANKICON:Class = net.wg.gui.components.advanced.TankIcon;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TANKMANCARD:Class = TankmanCard;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREA:Class = TextArea;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREASIMPLE:Class = TextAreaSimple;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TOGGLEBUTTON:Class = ToggleButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_UNDERLINEDTEXT:Class = UnderlinedText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VIDEOBUTTON:Class = VideoButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VIEWHEADER:Class = ViewHeader;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONHELPER:Class = BackButtonHelper;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONSTATES:Class = BackButtonStates;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONTEXT:Class = BackButtonText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR_DAYRENDERER:Class = DayRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR_WEEKDAYRENDERER:Class = WeekDayRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COLLAPSINGBAR_COLLAPSINGBAR:Class = CollapsingBar;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COLLAPSINGBAR_COLLAPSINGGROUP:Class = CollapsingGroup;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COLLAPSINGBAR_RESIZABLEBUTTON:Class = ResizableButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COLLAPSINGBAR_DATA_COLLAPSINGBARBUTTONVO:Class = CollapsingBarButtonVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_COLLAPSINGBAR_INTERFACES_ICOLLAPSECHECKER:Class = ICollapseChecker;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_CALENDAREVENT:Class = CalendarEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_DUMMYEVENT:Class = DummyEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_RECRUITPARAMSEVENT:Class = RecruitParamsEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_TUTORIALHELPBTNEVENT:Class = TutorialHelpBtnEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_TUTORIALHINTEVENT:Class = TutorialHintEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_VIEWHEADEREVENT:Class = ViewHeaderEvent;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IBACKBUTTON:Class = IBackButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ICOMPLEXPROGRESSSTEPRENDERER:Class = IComplexProgressStepRenderer;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ICOOLDOWNSLOT:Class = ICooldownSlot;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IDASHLINETEXTITEM:Class = IDashLineTextItem;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IDUMMY:Class = IDummy;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IPROGRESSBARANIM:Class = IProgressBarAnim;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTANIMATION:Class = ITutorialHintAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTARROWANIMATION:Class = ITutorialHintArrowAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTTEXTANIMATION:Class = ITutorialHintTextAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTON:Class = ScreenTabButton;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTONBAR:Class = ScreenTabButtonBar;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTONBG:Class = ScreenTabButtonBg;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALCONTEXTHINT:Class = TutorialContextHint;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALCONTEXTOVERLAY:Class = TutorialContextOverlay;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINT:Class = TutorialHint;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTANIMATION:Class = TutorialHintAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTARROWANIMATION:Class = TutorialHintArrowAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXT:Class = TutorialHintText;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXTANIMATION:Class = TutorialHintTextAnimation;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXTANIMATIONMC:Class = TutorialHintTextAnimationMc;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_COMPLEXPROGRESSINDICATORVO:Class = ComplexProgressIndicatorVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_DUMMYVO:Class = DummyVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_NORMALSORTINGTABLEHEADERVO:Class = NormalSortingTableHeaderVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_PROGRESSBARANIMVO:Class = ProgressBarAnimVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_RECRUITPARAMETERSVO:Class = RecruitParametersVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_STATICITEMSLOTVO:Class = StaticItemSlotVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_STATISTICITEMVO:Class = StatisticItemVo;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_STATUSDELTAINDICATORVO:Class = StatusDeltaIndicatorVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TRUNCATEHTMLTEXTVO:Class = TruncateHtmlTextVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALBTNCONTROLLERVO:Class = TutorialBtnControllerVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCLIPEFFECTVO:Class = TutorialClipEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTHINTVO:Class = TutorialContextHintVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTOVERLAYVO:Class = TutorialContextOverlayVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTVO:Class = TutorialContextVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALDISPLAYEFFECTVO:Class = TutorialDisplayEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALENABLEDEFFECTVO:Class = TutorialEnabledEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALHIGHLIGHTEFFECTVO:Class = TutorialHighlightEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALHINTVO:Class = TutorialHintVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALOVERLAYEFFECTVO:Class = TutorialOverlayEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALTWEENEFFECTVO:Class = TutorialTweenEffectVO;

        public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_VIEWHEADERVO:Class = ViewHeaderVO;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_ACHIEVEMENTCAROUSEL:Class = AchievementCarousel;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_CAROUSELBASE:Class = CarouselBase;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_PORTRAITSCAROUSEL:Class = PortraitsCarousel;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_SKILLSCAROUSEL:Class = SkillsCarousel;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_VERTICALSCROLLER:Class = VerticalScroller;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_VERTICALSCROLLERVIEWPORT:Class = VerticalScrollerViewPort;

        public static const NET_WG_GUI_COMPONENTS_CAROUSELS_INTERFACES_ICAROUSELITEMRENDERER:Class = ICarouselItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_COMMON_ARROWBUTTONICONCONTAINER:Class = ArrowButtonIconContainer;

        public static const NET_WG_GUI_COMPONENTS_COMMON_ARROWBUTTONNUMBER:Class = ArrowButtonNumber;

        public static const NET_WG_GUI_COMPONENTS_COMMON_ARROWBUTTONWITHNUMBER:Class = ArrowButtonWithNumber;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONFIRMCOMPONENT:Class = ConfirmComponent;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONFIRMITEMCOMPONENT:Class = ConfirmItemComponent;

        public static const NET_WG_GUI_COMPONENTS_COMMON_INPUTCHECKER:Class = InputChecker;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_AUTORESIZABLETILEDLAYOUT:Class = AutoResizableTiledLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_CENTERALIGNEDGROUPLAYOUT:Class = CenterAlignedGroupLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_EQUALGAPSHORIZONTALLAYOUT:Class = EqualGapsHorizontalLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_EQUALWIDTHHORIZONTALLAYOUT:Class = EqualWidthHorizontalLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUP:Class = Group;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUPEXANIMATED:Class = GroupExAnimated;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_TILEDLAYOUT:Class = TiledLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_VERTICAL100PERCWIDTHLAYOUT:Class = Vertical100PercWidthLayout;

        public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_VERTICALGROUPLAYOUT:Class = VerticalGroupLayout;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACCORDIONSOUNDRENDERER:Class = AccordionSoundRenderer;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACTIONPRICE:Class = ActionPrice;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_BASEDROPLIST:Class = BaseDropList;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONLOADER:Class = ButtonIconLoader;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNLISTITEMRENDERERPRICE:Class = DropDownListItemRendererPrice;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNMENUPRICE:Class = DropdownMenuPrice;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_GLOWARROWASSET:Class = GlowArrowAsset;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_MAINMENUBUTTON:Class = MainMenuButton;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_PROGRESSBAR:Class = ProgressBar;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_PROGRESSBARANIM:Class = ProgressBarAnim;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_RESIZABLETILELIST:Class = ResizableTileList;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_ROUNDPROGRESSBARANIM:Class = RoundProgressBarAnim;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLOTBUTTONBASE:Class = SlotButtonBase;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLETABLE:Class = SortableTable;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLETABLELIST:Class = SortableTableList;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTBUTTON:Class = SortButton;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABLERENDERER:Class = TableRenderer;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAINIGBUTTONVO:Class = TankmanTrainigButtonVO;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGBUTTON:Class = TankmanTrainingButton;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGSMALLBUTTON:Class = TankmanTrainingSmallButton;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TILELIST:Class = TileList;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TRADEICO:Class = TradeIco;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_UNITCOMMANDERSTATS:Class = UnitCommanderStats;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_VEHICLESELECTORBASE:Class = VehicleSelectorBase;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_VERTICALLISTVIEWPORT:Class = VerticalListViewPort;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_WGSCROLLINGLIST:Class = WgScrollingList;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_VERTICALLISTVIEWPORTEVENT:Class = VerticalListViewportEvent;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLOTSPANEL_ISLOTSPANEL:Class = ISlotsPanel;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLOTSPANEL_IMPL_BASESLOTSPANEL:Class = BaseSlotsPanel;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABS_ORANGETABBUTTON:Class = OrangeTabButton;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABS_ORANGETABMENU:Class = OrangeTabMenu;

        public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABS_ORANGETABSMENUVO:Class = OrangeTabsMenuVO;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_IACCORDIONITEMRENDERER:Class = IAccordionItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_ILISTITEMANIMATEDRENDERER:Class = IListItemAnimatedRenderer;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_IREUSABLELISTITEMRENDERER:Class = IReusableListItemRenderer;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_ITABBUTTON:Class = ITabButton;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_IVEHICLESELECTOR:Class = IVehicleSelector;

        public static const NET_WG_GUI_COMPONENTS_INTERFACES_IVEHICLESELECTORFILTER:Class = IVehicleSelectorFilter;

        public static const NET_WG_GUI_COMPONENTS_MINICLIENT_BATTLETYPEMINICLIENTCOMPONENT:Class = BattleTypeMiniClientComponent;

        public static const NET_WG_GUI_COMPONENTS_MINICLIENT_HANGARMINICLIENTCOMPONENT:Class = HangarMiniClientComponent;

        public static const NET_WG_GUI_COMPONENTS_MINICLIENT_LINKEDMINICLIENTCOMPONENT:Class = LinkedMiniClientComponent;

        public static const NET_WG_GUI_COMPONENTS_MINICLIENT_TECHTREEMINICLIENTCOMPONENT:Class = TechTreeMiniClientComponent;

        public static const NET_WG_GUI_COMPONENTS_POPOVERS_VEHICLESELECTPOPOVERBASE:Class = VehicleSelectPopoverBase;

        public static const NET_WG_GUI_COMPONENTS_POPOVERS_DATA_VEHICLESELECTPOPOVERVO:Class = VehicleSelectPopoverVO;

        public static const NET_WG_GUI_COMPONENTS_POPOVERS_EVENTS_VEHICLESELECTRENDEREREVENT:Class = VehicleSelectRendererEvent;

        public static const NET_WG_GUI_COMPONENTS_POPOVERS_INTERFACES_IVEHICLESELECTPOPOVERVO:Class = IVehicleSelectPopoverVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_ACHIEVEMENTSCUSTOMBLOCKITEM:Class = AchievementsCustomBlockItem;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_EXTRAMODULEINFO:Class = ExtraModuleInfo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRPREMVEHQUESTBLOCK:Class = IgrPremVehQuestBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTBLOCK:Class = IgrQuestBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTPROGRESSBLOCK:Class = IgrQuestProgressBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_MODULEITEM:Class = ModuleItem;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_STATUS:Class = Status;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SUITABLEVEHICLEBLOCKITEM:Class = SuitableVehicleBlockItem;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPACHIEVEMENT:Class = ToolTipAchievement;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPACTIONPRICE:Class = ToolTipActionPrice;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPBUYSKILL:Class = ToolTipBuySkill;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCLANCOMMONINFO:Class = ToolTipClanCommonInfo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCLANINFO:Class = ToolTipClanInfo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCOLUMNFIELDS:Class = ToolTipColumnFields;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCONTACT:Class = TooltipContact;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCUSTOMIZATIONITEM:Class = ToolTipCustomizationItem;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPENVIRONMENT:Class = TooltipEnvironment;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPFORTDIVISION:Class = ToolTipFortDivision;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPFORTSORTIE:Class = ToolTipFortSortie;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPIGR:Class = ToolTipIGR;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPLADDER:Class = ToolTipLadder;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPLADDERREGULATIONS:Class = ToolTipLadderRegulations;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMAP:Class = ToolTipMap;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMAPSMALL:Class = ToolTipMapSmall;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMARKOFMASTERY:Class = ToolTipMarkOfMastery;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMARKSONGUN:Class = ToolTipMarksOnGun;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPPRIVATEQUESTS:Class = ToolTipPrivateQuests;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSDIRECTS:Class = ToolTipRefSysDirects;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSRESERVES:Class = ToolTipRefSysReserves;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSEASONS:Class = ToolTipSeasons;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSELECTEDVEHICLE:Class = ToolTipSelectedVehicle;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSKILL:Class = ToolTipSkill;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSORTIEDIVISION:Class = ToolTipSortieDivision;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSUITABLEVEHICLE:Class = ToolTipSuitableVehicle;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPTANKMEN:Class = ToolTipTankmen;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPTRADEINPRICE:Class = ToolTipTradeInPrice;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPUNITCOMMAND:Class = TooltipUnitCommand;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPUNITLEVEL:Class = ToolTipUnitLevel;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPWRAPPER:Class = TooltipWrapper;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_EFFICIENCYBLOCK:Class = EfficiencyBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_HEADBLOCK:Class = HeadBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_ABSTRACTTEXTPARAMETERBLOCK:Class = AbstractTextParameterBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_ACTIONTEXTPARAMETERBLOCK:Class = ActionTextParameterBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_ADVANCEDCLIPBLOCK:Class = AdvancedClipBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_ADVANCEDKEYBLOCK:Class = AdvancedKeyBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_BADGEINFOBLOCK:Class = BadgeInfoBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_BLUEPRINTBLOCK:Class = BlueprintBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_COMPOUNDPRICEBLOCK:Class = CompoundPriceBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_CREWSKILLSBLOCK:Class = CrewSkillsBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_DASHLINEITEMPRICEBLOCK:Class = DashLineItemPriceBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_EPICMETALEVELPROGRESSBLOCK:Class = EpicMetaLevelProgressBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_GROUPBLOCK:Class = GroupBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_IMAGEBLOCK:Class = ImageBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_RANKBLOCK:Class = RankBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_RENDERERTEXTBLOCKINBLOCK:Class = RendererTextBlockInBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_SALETEXTPARAMETERBLOCK:Class = SaleTextParameterBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_SIMPLETILELISTBLOCK:Class = SimpleTileListBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_STATUSDELTAPARAMETERBLOCK:Class = net.wg.gui.components.tooltips.inblocks.blocks.StatusDeltaParameterBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTBETWEENLINEBLOCK:Class = TextBetweenLineBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTPARAMETERBLOCK:Class = net.wg.gui.components.tooltips.inblocks.blocks.TextParameterBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTPARAMETERWITHICONBLOCK:Class = TextParameterWithIconBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TITLEDESCPARAMETERWITHICONBLOCK:Class = TitleDescParameterWithIconBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_COMPONENTS_IMAGERENDERER:Class = ImageRenderer;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_ACTIONTEXTPARAMETERBLOCKVO:Class = ActionTextParameterBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_BADGEINFOBLOCKVO:Class = BadgeInfoBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_BLUEPRINTBLOCKVO:Class = BlueprintBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_CREWSKILLSBLOCKVO:Class = CrewSkillsBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_DASHLINEITEMPRICEBLOCKVO:Class = DashLineItemPriceBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_GROUPBLOCKVO:Class = GroupBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_RANKBLOCKVO:Class = RankBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_RENDERERDATAVO:Class = RendererDataVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_RENDERERTEXTBLOCKVO:Class = RendererTextBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_SALETEXTPARAMETERVO:Class = SaleTextParameterVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_SIMPLETILELISTBLOCKVO:Class = SimpleTileListBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_STATUSDELTAPARAMETERBLOCKVO:Class = StatusDeltaParameterBlockVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTBETWEENLINEVO:Class = TextBetweenLineVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTPARAMETERVO:Class = TextParameterVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTPARAMETERWITHICONVO:Class = TextParameterWithIconVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TITLEDESCPARAMETERWITHICONVO:Class = TitleDescParameterWithIconVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SORTIE_SORTIEDIVISIONBLOCK:Class = SortieDivisionBlock;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_ACHIEVEMENTVO:Class = AchievementVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_COLUMNFIELDSVO:Class = ColumnFieldsVo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_CONTACTTOOLTIPVO:Class = ContactTooltipVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_CUSTOMIZATIONITEMVO:Class = net.wg.gui.components.tooltips.VO.CustomizationItemVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_DIMENSION:Class = Dimension;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_DIVISIONVO:Class = net.wg.gui.components.tooltips.VO.DivisionVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EQUIPMENTPARAMVO:Class = EquipmentParamVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EXTRAMODULEINFOVO:Class = ExtraModuleInfoVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTCLANCOMMONINFOVO:Class = FortClanCommonInfoVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTCLANINFOVO:Class = FortClanInfoVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTDIVISIONVO:Class = FortDivisionVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_IGRVO:Class = IgrVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_LADDERVO:Class = LadderVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MAPVO:Class = MapVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MODULEVO:Class = net.wg.gui.components.tooltips.VO.ModuleVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PERSONALCASEBLOCKITEMVO:Class = PersonalCaseBlockItemVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PREMDAYSVO:Class = PremDaysVo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PRIVATEQUESTSVO:Class = PrivateQuestsVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SETTINGSCONTROLVO:Class = SettingsControlVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SORTIEDIVISIONVO:Class = SortieDivisionVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SUITABLEVEHICLEVO:Class = SuitableVehicleVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TANKMENVO:Class = TankmenVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPACTIONPRICEVO:Class = ToolTipActionPriceVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBUYSKILLVO:Class = ToolTipBuySkillVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPENVIRONMENTVO:Class = TooltipEnvironmentVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPFORTSORTIEVO:Class = ToolTipFortSortieVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPLADDERREGULATIONSVO:Class = ToolTipLadderRegulationsVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSDIRECTSVO:Class = ToolTipRefSysDirectsVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSRESERVESVO:Class = ToolTipRefSysReservesVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSEASONSVO:Class = ToolTipSeasonsVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSKILLVO:Class = ToolTipSkillVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPTANKCLASSVO:Class = ToolTipTankClassVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPUNITLEVELVO:Class = ToolTipUnitLevelVO;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TRADEINTOOLTIPVO:Class = TradeInTooltipVo;

        public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FINALSTATS_HEADBLOCKDATA:Class = HeadBlockData;

        public static const NET_WG_GUI_COMPONENTS_WAITINGQUEUE_WAITINGQUEUEMESSAGEHELPER:Class = WaitingQueueMessageHelper;

        public static const NET_WG_GUI_COMPONENTS_WAITINGQUEUE_WAITINGQUEUEMESSAGEUPDATER:Class = WaitingQueueMessageUpdater;

        public static const NET_WG_GUI_COMPONENTS_WINDOWS_SCREENBG:Class = ScreenBg;

        public static const NET_WG_GUI_COMPONENTS_WINDOWS_SIMPLEWINDOW:Class = SimpleWindow;

        public static const NET_WG_GUI_COMPONENTS_WINDOWS_VO_SIMPLEWINDOWBTNVO:Class = SimpleWindowBtnVo;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONEVENT:Class = CrewOperationEvent;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONINFOVO:Class = CrewOperationInfoVO;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSINITVO:Class = CrewOperationsInitVO;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRENDERER:Class = CrewOperationsIRenderer;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRFOOTER:Class = CrewOperationsIRFooter;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSPOPOVER:Class = CrewOperationsPopOver;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSSCROLLINGLIST:Class = CrewOperationsScrollingList;

        public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONWARNINGVO:Class = CrewOperationWarningVO;

        public static const NET_WG_GUI_CYBERSPORT_CSCONSTANTS:Class = CSConstants;

        public static const NET_WG_GUI_CYBERSPORT_CSINVALIDATIONTYPE:Class = CSInvalidationType;

        public static const NET_WG_GUI_CYBERSPORT_CYBERSPORTMAINWINDOW:Class = CyberSportMainWindow;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CANDIDATEHEADERITEMRENDER:Class = CandidateHeaderItemRender;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CANDIDATEITEMRENDERER:Class = CandidateItemRenderer;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_COMMANDRENDERER:Class = CommandRenderer;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSCANDIDATESSCROLLINGLIST:Class = CSCandidatesScrollingList;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTON:Class = CSVehicleButton;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTONLEVELS:Class = CSVehicleButtonLevels;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DYNAMICRANGEVEHICLES:Class = DynamicRangeVehicles;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MANUALSEARCHRENDERER:Class = ManualSearchRenderer;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MEDALVEHICLEVO:Class = MedalVehicleVO;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_RANGEVIEWCOMPONENT:Class = RangeViewComponent;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERBUTTONGROUP:Class = RosterButtonGroup;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERSETTINGSNUMERATIONBLOCK:Class = RosterSettingsNumerationBlock;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SELECTEDVEHICLESMSG:Class = SelectedVehiclesMsg;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SETTINGSICONS:Class = SettingsIcons;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTOR:Class = VehicleSelector;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORITEMRENDERER:Class = net.wg.gui.cyberSport.controls.VehicleSelectorItemRenderer;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORNAVIGATOR:Class = VehicleSelectorNavigator;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_WAITINGALERT:Class = WaitingAlert;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DATA_CSVEHICLEBUTTONSELECTIONVO:Class = CSVehicleButtonSelectionVO;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_CSCOMPONENTEVENT:Class = CSComponentEvent;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_MANUALSEARCHEVENT:Class = ManualSearchEvent;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTOREVENT:Class = VehicleSelectorEvent;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTORITEMEVENT:Class = VehicleSelectorItemEvent;

        public static const NET_WG_GUI_CYBERSPORT_CONTROLS_INTERFACES_IVEHICLEBUTTON:Class = IVehicleButton;

        public static const NET_WG_GUI_CYBERSPORT_DATA_CANDIDATESDATAPROVIDER:Class = CandidatesDataProvider;

        public static const NET_WG_GUI_CYBERSPORT_DATA_ROSTERSLOTSETTINGSWINDOWSTATICVO:Class = RosterSlotSettingsWindowStaticVO;

        public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IAUTOSEARCHFORMVIEW:Class = IAutoSearchFormView;

        public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICHANNELCOMPONENTHOLDER:Class = IChannelComponentHolder;

        public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICSAUTOSEARCHMAINVIEW:Class = ICSAutoSearchMainView;

        public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IMANUALSEARCHDATAPROVIDER:Class = IManualSearchDataProvider;

        public static const NET_WG_GUI_CYBERSPORT_POPUPS_VEHICLESELECTORPOPUP:Class = VehicleSelectorPopup;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_ANIMATEDROSTERSETTINGSVIEW:Class = AnimatedRosterSettingsView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_INTROVIEW:Class = IntroView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RANGEROSTERSETTINGSVIEW:Class = RangeRosterSettingsView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSETTINGSVIEW:Class = RosterSettingsView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSLOTSETTINGSWINDOW:Class = RosterSlotSettingsWindow;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITSLISTVIEW:Class = UnitsListView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITVIEW:Class = UnitView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CONFIRMATIONREADINESSSTATUS:Class = ConfirmationReadinessStatus;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CSAUTOSEARCHMAINVIEW:Class = CSAutoSearchMainView;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_ERRORSTATE:Class = ErrorState;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHCOMMANDS:Class = SearchCommands;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHENEMY:Class = SearchEnemy;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHENEMYRESPAWN:Class = SearchEnemyRespawn;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_STATEVIEWBASE:Class = StateViewBase;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_WAITINGPLAYERS:Class = WaitingPlayers;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_CSSHOWHELPEVENT:Class = CSShowHelpEvent;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_CYBERSPORTEVENT:Class = CyberSportEvent;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_ROSTERSETTINGSEVENT:Class = RosterSettingsEvent;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_SCUPDATEFOCUSEVENT:Class = SCUpdateFocusEvent;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNCHATSECTION:Class = RespawnChatSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNSLOTHELPER:Class = RespawnSlotHelper;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNTEAMSECTION:Class = RespawnTeamSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNTEAMSLOT:Class = RespawnTeamSlot;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_UNITSLOTBUTTONPROPERTIES:Class = UnitSlotButtonProperties;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_CHATSECTION:Class = ChatSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_CYBERSPORTTEAMSECTIONBASE:Class = CyberSportTeamSectionBase;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_ISTATICRALLYDETAILSSECTION:Class = IStaticRallyDetailsSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_JOINUNITSECTION:Class = JoinUnitSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SIMPLESLOTRENDERER:Class = SimpleSlotRenderer;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SLOTRENDERER:Class = SlotRenderer;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_TEAMSECTION:Class = TeamSection;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_UNITSLOTHELPER:Class = UnitSlotHelper;

        public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_WAITLISTSECTION:Class = WaitListSection;

        public static const NET_WG_GUI_CYBERSPORT_VO_AUTOSEARCHVO:Class = AutoSearchVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_CSCOMMADDETAILSVO:Class = CSCommadDetailsVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_CSCOMMANDVO:Class = CSCommandVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_CSINDICATORDATA:Class = CSIndicatorData;

        public static const NET_WG_GUI_CYBERSPORT_VO_CSINTROVIEWSTATICTEAMVO:Class = CSIntroViewStaticTeamVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_CSINTROVIEWTEXTSVO:Class = CSIntroViewTextsVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_IUNIT:Class = IUnit;

        public static const NET_WG_GUI_CYBERSPORT_VO_IUNITSLOT:Class = IUnitSlot;

        public static const NET_WG_GUI_CYBERSPORT_VO_NAVIGATIONBLOCKVO:Class = NavigationBlockVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_ROSTERLIMITSVO:Class = RosterLimitsVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_UNITLISTVIEWHEADERVO:Class = UnitListViewHeaderVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_VEHICLESELECTORITEMVO:Class = VehicleSelectorItemVO;

        public static const NET_WG_GUI_CYBERSPORT_VO_WAITINGPLAYERSVO:Class = WaitingPlayersVO;

        public static const NET_WG_GUI_DATA_AWARDITEMVO:Class = AwardItemVO;

        public static const NET_WG_GUI_DATA_AWARDWINDOWVO:Class = AwardWindowVO;

        public static const NET_WG_GUI_DATA_BASEAWARDSBLOCKVO:Class = BaseAwardsBlockVO;

        public static const NET_WG_GUI_DATA_BOOSTERBUYWINDOWUPDATEVO:Class = BoosterBuyWindowUpdateVO;

        public static const NET_WG_GUI_DATA_BOOSTERBUYWINDOWVO:Class = BoosterBuyWindowVO;

        public static const NET_WG_GUI_DATA_BUTTONBARDATAVO:Class = ButtonBarDataVO;

        public static const NET_WG_GUI_DATA_BUTTONBARITEMVO:Class = ButtonBarItemVO;

        public static const NET_WG_GUI_DATA_CRYSTALSPROMOWINDOWVO:Class = CrystalsPromoWindowVO;

        public static const NET_WG_GUI_DATA_DATACLASSITEMVO:Class = DataClassItemVO;

        public static const NET_WG_GUI_DATA_MISSIONAWARDWINDOWVO:Class = MissionAwardWindowVO;

        public static const NET_WG_GUI_DATA_TABDATAVO:Class = TabDataVO;

        public static const NET_WG_GUI_DATA_TABSVO:Class = TabsVO;

        public static const NET_WG_GUI_DATA_TASKAWARDSBLOCKVO:Class = TaskAwardsBlockVO;

        public static const NET_WG_GUI_DATA_VEHCOMPAREENTRYPOINTVO:Class = VehCompareEntrypointVO;

        public static const NET_WG_GUI_DEMOPAGE_BUTTONDEMORENDERER:Class = ButtonDemoRenderer;

        public static const NET_WG_GUI_DEMOPAGE_BUTTONDEMOVO:Class = ButtonDemoVO;

        public static const NET_WG_GUI_DEMOPAGE_DEMOPAGE:Class = DemoPage;

        public static const NET_WG_GUI_EVENTS_ANIMATEDRENDEREREVENT:Class = AnimatedRendererEvent;

        public static const NET_WG_GUI_EVENTS_ARENAVOIPSETTINGSEVENT:Class = ArenaVoipSettingsEvent;

        public static const NET_WG_GUI_EVENTS_CONFIRMEXCHANGEBLOCKEVENT:Class = ConfirmExchangeBlockEvent;

        public static const NET_WG_GUI_EVENTS_COOLDOWNEVENT:Class = CooldownEvent;

        public static const NET_WG_GUI_EVENTS_CREWEVENT:Class = CrewEvent;

        public static const NET_WG_GUI_EVENTS_DEVICEEVENT:Class = DeviceEvent;

        public static const NET_WG_GUI_EVENTS_FINALSTATISTICEVENT:Class = FinalStatisticEvent;

        public static const NET_WG_GUI_EVENTS_HEADERBUTTONBAREVENT:Class = HeaderButtonBarEvent;

        public static const NET_WG_GUI_EVENTS_HEADEREVENT:Class = HeaderEvent;

        public static const NET_WG_GUI_EVENTS_LOBBYEVENT:Class = LobbyEvent;

        public static const NET_WG_GUI_EVENTS_LOBBYTDISPATCHEREVENT:Class = LobbyTDispatcherEvent;

        public static const NET_WG_GUI_EVENTS_MESSENGERBAREVENT:Class = MessengerBarEvent;

        public static const NET_WG_GUI_EVENTS_PERSONALCASEEVENT:Class = PersonalCaseEvent;

        public static const NET_WG_GUI_EVENTS_QUESTEVENT:Class = QuestEvent;

        public static const NET_WG_GUI_EVENTS_RESIZABLEBLOCKEVENT:Class = ResizableBlockEvent;

        public static const NET_WG_GUI_EVENTS_SHOWDIALOGEVENT:Class = ShowDialogEvent;

        public static const NET_WG_GUI_EVENTS_SORTABLETABLELISTEVENT:Class = SortableTableListEvent;

        public static const NET_WG_GUI_EVENTS_TECHNIQUELISTCOMPONENTEVENT:Class = TechniqueListComponentEvent;

        public static const NET_WG_GUI_EVENTS_TRAININGEVENT:Class = TrainingEvent;

        public static const NET_WG_GUI_EVENTS_VEHICLESELLDIALOGEVENT:Class = VehicleSellDialogEvent;

        public static const NET_WG_GUI_EVENTS_WAITINGQUEUEMESSAGEEVENT:Class = WaitingQueueMessageEvent;

        public static const NET_WG_GUI_FORTBASE_IBUILDINGBASEVO:Class = IBuildingBaseVO;

        public static const NET_WG_GUI_FORTBASE_IBUILDINGVO:Class = IBuildingVO;

        public static const NET_WG_GUI_INTERFACES_ICALENDARDAYVO:Class = ICalendarDayVO;

        public static const NET_WG_GUI_INTERFACES_IDATE:Class = IDate;

        public static const NET_WG_GUI_INTERFACES_IDROPLIST:Class = IDropList;

        public static const NET_WG_GUI_INTERFACES_IEXTENDEDUSERVO:Class = IExtendedUserVO;

        public static const NET_WG_GUI_INTERFACES_IHEADERBUTTONCONTENTITEM:Class = IHeaderButtonContentItem;

        public static const NET_WG_GUI_INTERFACES_IPERSONALCASEBLOCKTITLE:Class = IPersonalCaseBlockTitle;

        public static const NET_WG_GUI_INTERFACES_IRALLYCANDIDATEVO:Class = IRallyCandidateVO;

        public static const NET_WG_GUI_INTERFACES_IRESETTABLE:Class = IResettable;

        public static const NET_WG_GUI_INTERFACES_ISALEITEMBLOCKRENDERER:Class = ISaleItemBlockRenderer;

        public static const NET_WG_GUI_INTERFACES_IUPDATABLECOMPONENT:Class = IUpdatableComponent;

        public static const NET_WG_GUI_INTERFACES_IWAITINGQUEUEMESSAGEHELPER:Class = IWaitingQueueMessageHelper;

        public static const NET_WG_GUI_INTERFACES_IWAITINGQUEUEMESSAGEUPDATER:Class = IWaitingQueueMessageUpdater;

        public static const NET_WG_GUI_INTRO_INTROINFOVO:Class = IntroInfoVO;

        public static const NET_WG_GUI_INTRO_INTROPAGE:Class = IntroPage;

        public static const NET_WG_GUI_LOBBY_LOBBYPAGE:Class = LobbyPage;

        public static const NET_WG_GUI_LOBBY_BADGES_BADGESCONTENTCONTAINER:Class = BadgesContentContainer;

        public static const NET_WG_GUI_LOBBY_BADGES_BADGESHEADER:Class = BadgesHeader;

        public static const NET_WG_GUI_LOBBY_BADGES_BADGESPAGE:Class = BadgesPage;

        public static const NET_WG_GUI_LOBBY_BADGES_COMPONENTS_BADGERENDERER:Class = BadgeRenderer;

        public static const NET_WG_GUI_LOBBY_BADGES_DATA_BADGESGROUPVO:Class = BadgesGroupVO;

        public static const NET_WG_GUI_LOBBY_BADGES_DATA_BADGESHEADERVO:Class = BadgesHeaderVO;

        public static const NET_WG_GUI_LOBBY_BADGES_DATA_BADGESSTATICDATAVO:Class = BadgesStaticDataVO;

        public static const NET_WG_GUI_LOBBY_BADGES_DATA_BADGEVO:Class = BadgeVO;

        public static const NET_WG_GUI_LOBBY_BADGES_EVENTS_BADGESEVENT:Class = BadgesEvent;

        public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKS:Class = Barracks;

        public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSFORM:Class = BarracksForm;

        public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSITEMRENDERER:Class = BarracksItemRenderer;

        public static const NET_WG_GUI_LOBBY_BARRACKS_DATA_BARRACKSTANKMANVO:Class = BarracksTankmanVO;

        public static const NET_WG_GUI_LOBBY_BARRACKS_DATA_BARRACKSTANKMENVO:Class = BarracksTankmenVO;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUE:Class = BattleQueue;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUEITEMRENDERER:Class = BattleQueueItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUEITEMVO:Class = BattleQueueItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUETYPEINFOVO:Class = BattleQueueTypeInfoVO;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLESTRONGHOLDSLEAGUERENDERER:Class = BattleStrongholdsLeagueRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLESTRONGHOLDSLEAGUESLEADERVO:Class = BattleStrongholdsLeaguesLeaderVO;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLESTRONGHOLDSLEAGUESVO:Class = BattleStrongholdsLeaguesVO;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLESTRONGHOLDSQUEUE:Class = BattleStrongholdsQueue;

        public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLESTRONGHOLDSQUEUETYPEINFOVO:Class = BattleStrongholdsQueueTypeInfoVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_AWARDEXTRACTOR:Class = AwardExtractor;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_BATTLERESULTS:Class = BattleResults;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMMONSTATS:Class = CommonStats;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DETAILSSTATSVIEW:Class = DetailsStatsView;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EPICSTATS:Class = EpicStats;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_GETPREMIUMPOPOVER:Class = GetPremiumPopover;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_IEMBLEMLOADEDDELEGATE:Class = IEmblemLoadedDelegate;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMSTATS:Class = TeamStats;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_ALERTMESSAGE:Class = net.wg.gui.lobby.battleResults.components.AlertMessage;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTIMAGESWITCHERVIEW:Class = BattleResultImageSwitcherView;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSEVENTRENDERER:Class = BattleResultsEventRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSMEDALSLIST:Class = BattleResultsMedalsList;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSPERSONALQUEST:Class = BattleResultsPersonalQuest;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCK:Class = DetailsBlock;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSSTATS:Class = DetailsStats;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSSTATSSCROLLPANE:Class = DetailsStatsScrollPane;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYHEADER:Class = EfficiencyHeader;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYICONRENDERER:Class = EfficiencyIconRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYRENDERER:Class = EfficiencyRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EPICTEAMMEMBERSTATSVIEW:Class = EpicTeamMemberStatsView;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILS:Class = IncomeDetails;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILSBASE:Class = IncomeDetailsBase;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILSSHORT:Class = IncomeDetailsShort;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILSSMALL:Class = IncomeDetailsSmall;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_MEDALSLIST:Class = MedalsList;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_MULTICOLUMNSUBTASKSLIST:Class = MultiColumnSubtasksList;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_MULTIPLETANKLIST:Class = MultipleTankList;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_PERSONALQUESTSTATE:Class = PersonalQuestState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_PROGRESSELEMENT:Class = ProgressElement;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_RANKEDTEAMMEMBERITEMRENDERER:Class = RankedTeamMemberItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_SCROLLBARTEAMMEMBERITEMRENDERER:Class = ScrollbarTeamMemberItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_SORTIETEAMSTATSCONTROLLER:Class = SortieTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_SPECIALACHIEVEMENT:Class = SpecialAchievement;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TANKRESULTITEMRENDERER:Class = TankResultItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TANKSTATSVIEW:Class = TankStatsView;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERITEMRENDERER:Class = TeamMemberItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERRENDERERBASE:Class = net.wg.gui.lobby.battleResults.components.TeamMemberRendererBase;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERSTATSVIEW:Class = TeamMemberStatsView;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERSTATSVIEWBASE:Class = TeamMemberStatsViewBase;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMSTATSLIST:Class = TeamStatsList;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TOTALINCOMEDETAILS:Class = TotalIncomeDetails;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_VEHICLEDETAILS:Class = VehicleDetails;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCKSTATES_ADVERTISINGSTATE:Class = AdvertisingState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCKSTATES_COMPAREPREMIUMSTATE:Class = ComparePremiumState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCKSTATES_DETAILSSTATE:Class = DetailsState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCKSTATES_PREMIUMBONUSSTATE:Class = PremiumBonusState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCKSTATES_PREMIUMINFOSTATE:Class = PremiumInfoState;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_COLUMNCONSTANTS:Class = ColumnConstants;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_CYBERSPORTTEAMSTATSCONTROLLER:Class = CybersportTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_DEFAULTTEAMSTATSCONTROLLER:Class = DefaultTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_EPICTEAMSTATSCONTROLLER:Class = EpicTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_FORTTEAMSTATSCONTROLLER:Class = FortTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_RANKEDTEAMSTATSCONTROLLER:Class = RankedTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_RATEDCYBERSPORTTEAMSTATSCONTROLLER:Class = RatedCybersportTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_SCROLLBARTEAMSTATSCONTROLLER:Class = ScrollBarTeamStatsController;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_TEAMSTATSCONTROLLERABSTRACT:Class = TeamStatsControllerAbstract;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMEMBLEMEVENT:Class = CsTeamEmblemEvent;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMEVENT:Class = CsTeamEvent;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATS:Class = CsTeamStats;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATSBG:Class = CsTeamStatsBg;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATSVO:Class = CsTeamStatsVo;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_ALERTMESSAGEVO:Class = AlertMessageVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSMEDALSLISTVO:Class = BattleResultsMedalsListVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSTEXTDATA:Class = BattleResultsTextData;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSVO:Class = BattleResultsVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COLUMNCOLLECTION:Class = ColumnCollection;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COLUMNDATA:Class = ColumnData;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COMMONSTATSVO:Class = CommonStatsVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_DETAILEDSTATSITEMVO:Class = DetailedStatsItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_EFFICIENCYHEADERVO:Class = EfficiencyHeaderVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_EFFICIENCYRENDERERVO:Class = EfficiencyRendererVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_EPICEFFICIENCYDATA:Class = EpicEfficiencyData;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_ICONEFFICIENCYTOOLTIPDATA:Class = IconEfficiencyTooltipData;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_OVERTIMEVO:Class = OvertimeVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_PERSONALDATAVO:Class = PersonalDataVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_PREMIUMBONUSVO:Class = PremiumBonusVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_PREMIUMEARNINGSVO:Class = PremiumEarningsVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_PREMIUMINFOVO:Class = PremiumInfoVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_RANKEDBATTLESUBTASKVO:Class = RankedBattleSubTaskVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_STATITEMVO:Class = StatItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_TABINFOVO:Class = TabInfoVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_TEAMMEMBERITEMVO:Class = TeamMemberItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VEHICLEITEMVO:Class = VehicleItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VEHICLESTATSVO:Class = VehicleStatsVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VICTORYPANELVO:Class = VictoryPanelVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EPIC_EPICDETAILSVEHICLESELECTION:Class = EpicDetailsVehicleSelection;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EPIC_EPICEFFICIENCYITEMRENDERER:Class = EpicEfficiencyItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EPIC_EPICTEAMMEMBERITEMRENDERER:Class = EpicTeamMemberItemRenderer;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_BATTLERESULTSVIEWEVENT:Class = BattleResultsViewEvent;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_CLANEMBLEMREQUESTEVENT:Class = ClanEmblemRequestEvent;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_TEAMTABLESORTEVENT:Class = TeamTableSortEvent;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MANAGERS_ISTATSUTILSMANAGER:Class = IStatsUtilsManager;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MANAGERS_IMPL_STATSUTILSMANAGER:Class = StatsUtilsManager;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_BATTLERESULTUNLOCKITEM:Class = BattleResultUnlockItem;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_BATTLERESULTUNLOCKITEMVO:Class = BattleResultUnlockItemVO;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_PROGRESSREPORTLINKAGESELECTOR:Class = ProgressReportLinkageSelector;

        public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_UNLOCKLINKEVENT:Class = UnlockLinkEvent;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_BOOSTERSTABLERENDERER:Class = BoostersTableRenderer;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_COMPONENTS_BOOSTERSWINDOWFILTERS:Class = BoostersWindowFilters;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSTABLERENDERERVO:Class = BoostersTableRendererVO;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWFILTERSVO:Class = BoostersWindowFiltersVO;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWSTATICVO:Class = BoostersWindowStaticVO;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWVO:Class = BoostersWindowVO;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_CONFIRMBOOSTERSWINDOWVO:Class = ConfirmBoostersWindowVO;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_EVENTS_BOOSTERSWINDOWEVENT:Class = BoostersWindowEvent;

        public static const NET_WG_GUI_LOBBY_BOOSTERS_WINDOWS_CONFIRMBOOSTERSWINDOW:Class = ConfirmBoostersWindow;

        public static const NET_WG_GUI_LOBBY_BROWSER_BROWSER:Class = Browser;

        public static const NET_WG_GUI_LOBBY_BROWSER_BROWSERACTIONBTN:Class = BrowserActionBtn;

        public static const NET_WG_GUI_LOBBY_BROWSER_SERVICEVIEW:Class = ServiceView;

        public static const NET_WG_GUI_LOBBY_BROWSER_EVENTS_BROWSERACTIONBTNEVENT:Class = BrowserActionBtnEvent;

        public static const NET_WG_GUI_LOBBY_BROWSER_EVENTS_BROWSEREVENT:Class = BrowserEvent;

        public static const NET_WG_GUI_LOBBY_BROWSER_EVENTS_BROWSERTITLEEVENT:Class = BrowserTitleEvent;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANBASEINFOVO:Class = ClanBaseInfoVO;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANNAMEFIELD:Class = ClanNameField;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANTABDATAPROVIDERVO:Class = ClanTabDataProviderVO;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANVIEWWITHVARIABLECONTENT:Class = ClanViewWithVariableContent;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANVO:Class = ClanVO;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_ICLANHEADERCOMPONENT:Class = IClanHeaderComponent;

        public static const NET_WG_GUI_LOBBY_CLANS_COMMON_ICLANNAMEFIELD:Class = IClanNameField;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_CLANINVITESWINDOW:Class = ClanInvitesWindow;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_CLANPERSONALINVITESWINDOW:Class = ClanPersonalInvitesWindow;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_COMPONENTS_ACCEPTACTIONS:Class = AcceptActions;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_COMPONENTS_TEXTVALUEBLOCK:Class = TextValueBlock;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANINVITEITEMRENDERER:Class = ClanInviteItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANINVITESWINDOWABSTRACTTABLEITEMRENDERER:Class = ClanInvitesWindowAbstractTableItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANPERSONALINVITESITEMRENDERER:Class = ClanPersonalInvitesItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANREQUESTITEMRENDERER:Class = ClanRequestItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANTABLERENDERERITEMEVENT:Class = ClanTableRendererItemEvent;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_USERABSTRACTTABLEITEMRENDERER:Class = UserAbstractTableItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESVIEW:Class = ClanInvitesView;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESVIEWWITHTABLE:Class = ClanInvitesViewWithTable;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESWINDOWABSTRACTTABVIEW:Class = ClanInvitesWindowAbstractTabView;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANPERSONALINVITESVIEW:Class = ClanPersonalInvitesView;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANREQUESTSVIEW:Class = ClanRequestsView;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_ACCEPTACTIONSVO:Class = AcceptActionsVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESVIEWVO:Class = ClanInvitesViewVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWABSTRACTITEMVO:Class = ClanInvitesWindowAbstractItemVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWHEADERSTATEVO:Class = ClanInvitesWindowHeaderStateVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWTABLEFILTERVO:Class = ClanInvitesWindowTableFilterVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWTABVIEWVO:Class = ClanInvitesWindowTabViewVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWVO:Class = ClanInvitesWindowVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITEVO:Class = ClanInviteVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTACTIONSVO:Class = ClanRequestActionsVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTSTATUSVO:Class = ClanRequestStatusVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTVO:Class = ClanRequestVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_DUMMYTEXTVO:Class = DummyTextVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_PERSONALINVITEVO:Class = PersonalInviteVO;

        public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_USERINVITESWINDOWITEMVO:Class = UserInvitesWindowItemVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEEVENT:Class = ClanProfileEvent;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOW:Class = ClanProfileMainWindow;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOWBASEHEADER:Class = ClanProfileMainWindowBaseHeader;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOWHEADER:Class = ClanProfileMainWindowHeader;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILESUMMARYVIEWHEADER:Class = ClanProfileSummaryViewHeader;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_CLANPROFILESUMMARYBLOCK:Class = ClanProfileSummaryBlock;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_TEXTFIELDFRAME:Class = TextFieldFrame;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ICLANPROFILESUMMARYBLOCK:Class = IClanProfileSummaryBlock;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ITEXTFIELDFRAME:Class = ITextFieldFrame;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANLEAGUERENDERER:Class = ClanLeagueRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILEMEMBERITEMRENDERER:Class = ClanProfileMemberItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILEPROVINCEITEMRENDERER:Class = ClanProfileProvinceItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILESELFPROVINCEITEMRENDERER:Class = ClanProfileSelfProvinceItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEBASEVIEW:Class = ClanProfileBaseView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPINFOVIEW:Class = ClanProfileGlobalMapInfoView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPPROMOVIEW:Class = ClanProfileGlobalMapPromoView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPVIEW:Class = ClanProfileGlobalMapView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEPERSONNELVIEW:Class = ClanProfilePersonnelView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILESUMMARYVIEW:Class = ClanProfileSummaryView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILETABLESTATISTICSVIEW:Class = ClanProfileTableStatisticsView;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANMEMBERVO:Class = ClanMemberVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPINFOVO:Class = ClanProfileGlobalMapInfoVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPPROMOVO:Class = ClanProfileGlobalMapPromoVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPVIEWVO:Class = ClanProfileGlobalMapViewVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEHEADERSTATEVO:Class = ClanProfileHeaderStateVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEMAINWINDOWVO:Class = ClanProfileMainWindowVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEPERSONNELVIEWVO:Class = ClanProfilePersonnelViewVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEPROVINCEVO:Class = ClanProfileProvinceVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESELFPROVINCEVO:Class = ClanProfileSelfProvinceVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESTATSLINEVO:Class = ClanProfileStatsLineVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYBLOCKVO:Class = ClanProfileSummaryBlockVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYLEAGUESVO:Class = ClanProfileSummaryLeaguesVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYVIEWSTATUSVO:Class = ClanProfileSummaryViewStatusVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYVIEWVO:Class = ClanProfileSummaryViewVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILETABLESTATISTICSDATAVO:Class = ClanProfileTableStatisticsDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_GLOBALMAPSTATISTICSBODYVO:Class = GlobalMapStatisticsBodyVO;

        public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_LEAGUEITEMRENDERERVO:Class = LeagueItemRendererVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHINFO:Class = ClanSearchInfo;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHITEMRENDERER:Class = ClanSearchItemRenderer;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHWINDOW:Class = ClanSearchWindow;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFODATAVO:Class = ClanSearchInfoDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFOINITDATAVO:Class = ClanSearchInfoInitDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFOSTATEDATAVO:Class = ClanSearchInfoStateDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHITEMVO:Class = ClanSearchItemVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHWINDOWINITDATAVO:Class = ClanSearchWindowInitDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHWINDOWSTATEDATAVO:Class = ClanSearchWindowStateDataVO;

        public static const NET_WG_GUI_LOBBY_CLANS_UTILS_CLANHELPER:Class = ClanHelper;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_ABSTRACTPOPOVERCOMPONENTPANEL:Class = AbstractPopoverComponentPanel;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_ABSTRACTPOPOVERWITHSCROLLABLECOMPONENTPANEL:Class = AbstractPopoverWithScrollableComponentPanel;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_ARROWDOWN:Class = ArrowDown;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_AWARDITEMRENDEREREX:Class = AwardItemRendererEx;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_AWARDWINDOWANIMATIONCONTROLLER:Class = AwardWindowAnimationController;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEAWARDSBLOCK:Class = BaseAwardsBlock;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEBOOSTERSLOT:Class = BaseBoosterSlot;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEMISSIONDETAILEDVIEW:Class = BaseMissionDetailedView;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEMISSIONDETAILSBG:Class = BaseMissionDetailsBg;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEMISSIONDETAILSCONTAINERVIEW:Class = BaseMissionDetailsContainerView;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERADDSLOT:Class = BoosterAddSlot;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERSLOT:Class = BoosterSlot;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERSPANEL:Class = BoostersPanel;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BROWSERSCREEN:Class = BrowserScreen;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BROWSERVIEWSTACKEXPADDING:Class = BrowserViewStackExPadding;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BUTTONFILTERS:Class = ButtonFilters;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BUTTONFILTERSGROUP:Class = ButtonFiltersGroup;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATAVIEWSTACK:Class = DataViewStack;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSGROUPEX:Class = DetailedStatisticsGroupEx;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSROOTUNIT:Class = DetailedStatisticsRootUnit;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSUNIT:Class = DetailedStatisticsUnit;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSVIEW:Class = DetailedStatisticsView;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EXPLOSIONAWARDWINDOWANIMATION:Class = ExplosionAwardWindowAnimation;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EXPLOSIONAWARDWINDOWANIMATIONICON:Class = ExplosionAwardWindowAnimationIcon;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_ICONTEXTWRAPPER:Class = IconTextWrapper;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_IMAGEWRAPPER:Class = ImageWrapper;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INFOMESSAGECOMPONENT:Class = InfoMessageComponent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_IRESIZABLECONTENT:Class = net.wg.gui.lobby.components.IResizableContent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_ISTATISTICSBODYCONTAINERDATA:Class = IStatisticsBodyContainerData;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_MISSIONDETAILSBG:Class = MissionDetailsBg;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_MISSIONSVEHICLESELECTOR:Class = MissionsVehicleSelector;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_PERPIXELTILELIST:Class = PerPixelTileList;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_PROFILEDASHLINETEXTITEM:Class = ProfileDashLineTextItem;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_PROGRESSINDICATOR:Class = ProgressIndicator;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_RESIZABLEVIEWSTACK:Class = ResizableViewStack;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_RIBBONAWARDANIM:Class = RibbonAwardAnim;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_RIBBONAWARDITEMRENDERER:Class = RibbonAwardItemRenderer;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_RIBBONAWARDS:Class = RibbonAwards;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SERVERSLOTBUTTON:Class = ServerSlotButton;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SIDEBAR:Class = SideBar;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SIDEBARRENDERER:Class = SideBarRenderer;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLGROUPICONS:Class = SmallSkillGroupIcons;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLITEMRENDERER:Class = SmallSkillItemRenderer;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLSLIST:Class = SmallSkillsList;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_STATISTICSBODYCONTAINER:Class = StatisticsBodyContainer;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_STATISTICSDASHLINETEXTITEMIRENDERER:Class = StatisticsDashLineTextItemIRenderer;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_STOPPABLEANIMATIONLOADER:Class = StoppableAnimationLoader;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_TEXTWRAPPER:Class = TextWrapper;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_VEHICLESELECTORFILTER:Class = net.wg.gui.lobby.components.VehicleSelectorFilter;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_VEHICLESELECTORMULTIFILTER:Class = VehicleSelectorMultiFilter;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_BASE_BUTTONFILTERSBASE:Class = ButtonFiltersBase;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_AWARDITEMRENDEREREXVO:Class = AwardItemRendererExVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BASEMISSIONDETAILEDVIEWVO:Class = BaseMissionDetailedViewVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BASEMISSIONDETAILSCONTAINERVO:Class = BaseMissionDetailsContainerVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BASETANKMANVO:Class = BaseTankmanVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BOOSTERSLOTVO:Class = BoosterSlotVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BROWSERVO:Class = BrowserVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BUTTONFILTERSITEMVO:Class = ButtonFiltersItemVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BUTTONFILTERSVO:Class = ButtonFiltersVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDLABELDATAVO:Class = DetailedLabelDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDSTATISTICSLABELDATAVO:Class = DetailedStatisticsLabelDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDSTATISTICSUNITVO:Class = DetailedStatisticsUnitVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DEVICESLOTVO:Class = DeviceSlotVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_INFOMESSAGEVO:Class = InfoMessageVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_PRIMETIMESERVERVO:Class = PrimeTimeServerVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_PRIMETIMEVO:Class = PrimeTimeVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_RIBBONAWARDSVO:Class = RibbonAwardsVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_SKILLSVO:Class = SkillsVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSBODYVO:Class = StatisticsBodyVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSLABELDATAVO:Class = StatisticsLabelDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSLABELLINKAGEDATAVO:Class = StatisticsLabelLinkageDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSTOOLTIPDATAVO:Class = StatisticsTooltipDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STOPPABLEANIMATIONLOADERVO:Class = StoppableAnimationLoaderVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_TRUNCATEDETAILEDSTATISTICSLABELDATAVO:Class = TruncateDetailedStatisticsLabelDataVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHICLESELECTMULTIFILTERPOPOVERVO:Class = VehicleSelectMultiFilterPopoverVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHICLESELECTORFILTERVO:Class = VehicleSelectorFilterVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHICLESELECTORMULTIFILTERVO:Class = VehicleSelectorMultiFilterVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHPARAMVO:Class = VehParamVO;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_BOOSTERPANELEVENT:Class = BoosterPanelEvent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_DASHLINETEXTITEMRENDEREREVENT:Class = DashLineTextItemRendererEvent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_RIBBONAWARDANIMEVENT:Class = RibbonAwardAnimEvent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_VEHICLESELECTORFILTEREVENT:Class = VehicleSelectorFilterEvent;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOW:Class = IAwardWindow;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOWANIMATIONCONTROLLER:Class = IAwardWindowAnimationController;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOWANIMATIONWRAPPER:Class = IAwardWindowAnimationWrapper;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IBOOSTERSLOT:Class = IBoosterSlot;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IMISSIONDETAILSPOPUPPANEL:Class = IMissionDetailsPopUpPanel;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IMISSIONSVEHICLESELECTOR:Class = IMissionsVehicleSelector;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IRIBBONAWARDANIM:Class = IRibbonAwardAnim;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATION:Class = IStoppableAnimation;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONITEM:Class = IStoppableAnimationItem;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONLOADER:Class = IStoppableAnimationLoader;

        public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IVEHICLESELECTORFILTERVO:Class = IVehicleSelectorFilterVO;

        public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_CONFIRMMODULEWINDOW:Class = ConfirmModuleWindow;

        public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_MODULEINFOVO:Class = ModuleInfoVo;

        public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DEMONSTRATORWINDOW:Class = DemonstratorWindow;

        public static const NET_WG_GUI_LOBBY_DEMONSTRATION_MAPITEMRENDERER:Class = MapItemRenderer;

        public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_DEMONSTRATORVO:Class = DemonstratorVO;

        public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_MAPITEMVO:Class = MapItemVO;

        public static const NET_WG_GUI_LOBBY_DEMOVIEW_DEMOBUTTON:Class = DemoButton;

        public static const NET_WG_GUI_LOBBY_DEMOVIEW_DEMOSUBVIEW:Class = DemoSubView;

        public static const NET_WG_GUI_LOBBY_DEMOVIEW_DEMOVIEW:Class = DemoView;

        public static const NET_WG_GUI_LOBBY_DIALOGS_CHECKBOXDIALOG:Class = CheckBoxDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_CONFIRMDIALOG:Class = ConfirmDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_CREWSKINSCOMPENSATIONDIALOG:Class = CrewSkinsCompensationDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_DEMOUNTDEVICEDIALOG:Class = DemountDeviceDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_DESTROYDEVICEDIALOG:Class = DestroyDeviceDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_FREEXPINFOWINDOW:Class = FreeXPInfoWindow;

        public static const NET_WG_GUI_LOBBY_DIALOGS_ICONDIALOG:Class = IconDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_ICONPRICEDIALOG:Class = IconPriceDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_PMCONFIRMATIONDIALOG:Class = PMConfirmationDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_PRICEMC:Class = PriceMc;

        public static const NET_WG_GUI_LOBBY_DIALOGS_TANKMANOPERATIONDIALOG:Class = TankmanOperationDialog;

        public static const NET_WG_GUI_LOBBY_DIALOGS_DATA_ICONPRICEDIALOGVO:Class = IconPriceDialogVO;

        public static const NET_WG_GUI_LOBBY_DIALOGS_DATA_TANKMANOPERATIONDIALOGVO:Class = TankmanOperationDialogVO;

        public static const NET_WG_GUI_LOBBY_ELITEWINDOW_ELITEWINDOW:Class = EliteWindow;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_ANIMATEDREWARDRIBBON:Class = AnimatedRewardRibbon;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_ANIMATEDREWARDRIBBONICONCONTAINER:Class = AnimatedRewardRibbonIconContainer;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_BACKGROUNDCOMPONENT:Class = BackgroundComponent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_EPICBATTLESLEVELUPSKILLBUTTON:Class = EpicBattlesLevelUpSkillButton;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_EPICBATTLESMETALEVEL:Class = EpicBattlesMetaLevel;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_EPICBATTLESPRESTIGEPROGRESS:Class = EpicBattlesPrestigeProgress;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_EPICBATTLESWIDGET:Class = EpicBattlesWidget;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_EPICBATTLESWIDGETBUTTON:Class = EpicBattlesWidgetButton;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICBATTLESAFTERBATTLEFAMEPROGRESSBAR:Class = EpicBattlesAfterBattleFameProgressBar;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICBATTLESANIMATEDTITLETEXTFIELD:Class = EpicBattlesAnimatedTitleTextfield;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICBATTLESFAMEPOINTSCOUNTER:Class = EpicBattlesFamePointsCounter;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICBATTLESMETALEVELPROGRESSBAR:Class = EpicBattlesMetaLevelProgressBar;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICBATTLESPLAYERRANK:Class = EpicBattlesPlayerRank;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_AFTERBATTLE_EPICMETALEVELPROGRESSBARICONS:Class = EpicMetaLevelProgressBarIcons;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_COMMON_ALIGNEDICONTEXTBUTTON:Class = AlignedIconTextButton;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_COMMON_ALIGNEDICONTEXTBUTTON_ALIGNEDICONTEXTBUTTONMAINSTATES:Class = AlignedIconTextButtonMainStates;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_AVAILABLESKILLPOINTSELEMENT:Class = AvailableSkillPointsElement;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_COMBATRESERVESELEMENT:Class = CombatReservesElement;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_ENDGAMEPANEL:Class = EndGamePanel;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_LEFTINFOVIEWWING:Class = LeftInfoViewWing;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_METAPROGRESSPANEL:Class = MetaProgressPanel;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_PRESTIGEALLOWEDPANEL:Class = PrestigeAllowedPanel;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_REWARDRIBBONSUBVIEW:Class = RewardRibbonSubView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_RIGHTINFOVIEWWING:Class = RightInfoViewWing;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_TITLEELEMENT:Class = TitleElement;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_INFOVIEW_TUTORIALLINE:Class = TutorialLine;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_OFFLINEVIEW_CALENDAR:Class = net.wg.gui.lobby.epicBattles.components.offlineView.Calendar;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_OFFLINEVIEW_CENTERBLOCK:Class = CenterBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEPROGRESS_PRESTIGEPROGRESSBLOCK:Class = PrestigeProgressBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEPROGRESS_VEHICLEREWARDPROGRESSBLOCK:Class = VehicleRewardProgressBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEVIEW_ACTIONSBUTTONBAR:Class = ActionsButtonBar;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEVIEW_PRESTIGEOVERLAY:Class = PrestigeOverlay;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEVIEW_REWARDRIBBON:Class = RewardRibbon;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_PRESTIGEVIEW_TEXTBLOCK:Class = TextBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESSKILLBARSECTION:Class = EpicBattlesSkillBarSection;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESSKILLIMAGE:Class = EpicBattlesSkillImage;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESSKILLLEVELBAR:Class = EpicBattlesSkillLevelBar;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESSKILLSGROUP:Class = EpicBattlesSkillsGroup;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESSKILLTILE:Class = EpicBattlesSkillTile;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_EPICBATTLESUNSPENTPOINTS:Class = EpicBattlesUnspentPoints;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_SKILLINFOPANE:Class = SkillInfoPane;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_SKILLINFOPANECONTENT:Class = SkillInfoPaneContent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_SKILLLEVELUPANIMATIONCONTAINER:Class = SkillLevelUpAnimationContainer;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_SKILLSTATSPANEL:Class = SkillStatsPanel;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_STATUSDELTAPARAMETERBLOCK:Class = net.wg.gui.lobby.epicBattles.components.skillView.StatusDeltaParameterBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_SKILLVIEW_TEXTPARAMETERBLOCK:Class = net.wg.gui.lobby.epicBattles.components.skillView.TextParameterBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_COMPONENTS_WELCOMEBACKVIEW_INFOITEMRENDERER:Class = net.wg.gui.lobby.epicBattles.components.welcomeBackView.InfoItemRenderer;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESAFTERBATTLEVIEWVO:Class = EpicBattlesAfterBattleViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESINFOCOMBATRESERVESVO:Class = EpicBattlesInfoCombatReservesVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESINFOMETAPROGRESSVO:Class = EpicBattlesInfoMetaProgressVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESINFOVIEWVO:Class = EpicBattlesInfoViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESKILLINITVO:Class = EpicBattleSkillInitVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESKILLVO:Class = EpicBattleSkillVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESMETALEVELVO:Class = EpicBattlesMetaLevelVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESOFFLINEVIEWVO:Class = EpicBattlesOfflineViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESPRESTIGEPROGRESSBLOCKVO:Class = EpicBattlesPrestigeProgressBlockVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESPRESTIGEPROGRESSVO:Class = EpicBattlesPrestigeProgressVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESPRESTIGEVIEWVO:Class = EpicBattlesPrestigeViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESREWARDRIBBONVO:Class = EpicBattlesRewardRibbonVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESSKILLVIEWVO:Class = EpicBattlesSkillViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESWELCOMEBACKVIEWVO:Class = EpicBattlesWelcomeBackViewVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICBATTLESWIDGETVO:Class = EpicBattlesWidgetVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_EPICMETALEVELICONVO:Class = EpicMetaLevelIconVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_FRONTLINEBUYCONFIRMVO:Class = FrontlineBuyConfirmVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_DATA_INFOITEMRENDERERVO:Class = net.wg.gui.lobby.epicBattles.data.InfoItemRendererVO;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_AFTERBATTLEFAMEBAREVENT:Class = AfterBattleFameBarEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_EPICBATTLEINFOVIEWCLICKEVENT:Class = EpicBattleInfoViewClickEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_EPICBATTLEPRESTIGEVIEWCLICKEVENT:Class = EpicBattlePrestigeViewClickEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_EPICBATTLESSKILLVIEWCLICKEVENT:Class = EpicBattlesSkillViewClickEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_REWARDRIBBONSUBVIEWEVENT:Class = RewardRibbonSubViewEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_EVENTS_SKILLLEVELBARMOUSEEVENT:Class = SkillLevelBarMouseEvent;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_INTERFACES_SKILLVIEW_ISKILLPARAMETERBLOCK:Class = ISkillParameterBlock;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_UTILS_EPICHELPER:Class = EpicHelper;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESAFTERBATTLEVIEW:Class = EpicBattlesAfterBattleView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESBROWSERVIEW:Class = EpicBattlesBrowserView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESINFOVIEW:Class = EpicBattlesInfoView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESOFFLINEVIEW:Class = EpicBattlesOfflineView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESPRESTIGEVIEW:Class = EpicBattlesPrestigeView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESSKILLVIEW:Class = EpicBattlesSkillView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_EPICBATTLESWELCOMEBACKVIEW:Class = EpicBattlesWelcomeBackView;

        public static const NET_WG_GUI_LOBBY_EPICBATTLES_VIEWS_FRONTLINEBUYCONFIRMVIEW:Class = FrontlineBuyConfirmView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTBOARDSDETAILSCONTAINERVIEW:Class = EventBoardsDetailsContainerView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTBOARDSTABLEVIEW:Class = EventBoardsTableView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_MISSIONSEVENTBOARDSVIEW:Class = MissionsEventBoardsView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_AWARDGROUPS:Class = AwardGroups;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_AWARDSRIBBONBG:Class = AwardsRibbonBg;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_AWARDSTABLEHEADER:Class = AwardsTableHeader;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_AWARDSTRIPERENDERER:Class = AwardStripeRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_BASEPLAYERAWARDRENDERER:Class = BasePlayerAwardRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_BASEPLAYERBATTLERENDERER:Class = BasePlayerBattleRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_BATTLEVIEWTABLEHEADER:Class = BattleViewTableHeader;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_EVENTBOARDSVEHICLESELECTOR:Class = EventBoardsVehicleSelector;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_LEVELTYPEFLAGRENDERER:Class = LevelTypeFlagRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_LEVELTYPEFLAGRENDERERTEXT:Class = LevelTypeFlagRendererText;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_MAINTENANCECOMPONENT:Class = MaintenanceComponent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_MISSIONSEVENTBOARDSBODY:Class = MissionsEventBoardsBody;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_MISSIONSEVENTBOARDSCARDRENDERER:Class = MissionsEventBoardsCardRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_MISSIONSEVENTBOARDSHEADER:Class = MissionsEventBoardsHeader;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_OVERLAYAWARDSRENDERER:Class = OverlayAwardsRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_PAGINATION:Class = Pagination;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_TABLEVIEWHEADER:Class = TableViewHeader;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_TABLEVIEWSTATUS:Class = TableViewStatus;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_TABLEVIEWTABLEHEADER:Class = TableViewTableHeader;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_TOPPLAYERAWARDRENDERER:Class = TopPlayerAwardRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VEHICLEITEMRENDERER:Class = net.wg.gui.lobby.eventBoards.components.VehicleItemRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VEHICLESELECTORITEMRENDERER:Class = net.wg.gui.lobby.eventBoards.components.VehicleSelectorItemRenderer;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_BATTLECOMPONENTS_BATTLEEXPERIENCEBLOCK:Class = BattleExperienceBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_BATTLECOMPONENTS_BATTLESTATISTICSBLOCK:Class = BattleStatisticsBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_HEADERAWARDBLOCK:Class = HeaderAwardBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_HEADERCONDITIONBLOCK:Class = HeaderConditionBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_HEADERDESCBLOCK:Class = net.wg.gui.lobby.eventBoards.components.headerComponents.HeaderDescBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_HEADERRELOGINBLOCK:Class = HeaderReloginBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_HEADERSERVERBLOCK:Class = HeaderServerBlock;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_HEADERCOMPONENTS_TEXTFIELDNOSOUND:Class = TextFieldNoSound;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_INTERFACES_IAWARDGROUPS:Class = IAwardGroups;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_INTERFACES_IMAINTENANCECOMPONENT:Class = IMaintenanceComponent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_INTERFACES_IPAGINATION:Class = IPagination;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSDETAILSAWARDSTABLECONTENT:Class = EventBoardsDetailsAwardsTableContent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSDETAILSAWARDSVIEW:Class = EventBoardsDetailsAwardsView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSDETAILSBATTLEVIEW:Class = EventBoardsDetailsBattleView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSDETAILSBROWSERVIEW:Class = EventBoardsDetailsBrowserView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSDETAILSVEHICLESVIEW:Class = EventBoardsDetailsVehiclesView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSRESULTFILTERPOPOVERVIEW:Class = EventBoardsResultFilterPopoverView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDSRESULTFILTERVEHICLESPOPOVERVIEW:Class = EventBoardsResultFilterVehiclesPopoverView;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_COMPONENTS_VIEW_EVENTBOARDTABLECONTENT:Class = EventBoardTableContent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_AWARDSLISTRENDERERVO:Class = AwardsListRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_AWARDSTABLEVO:Class = AwardsTableVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_AWARDSTRIPERENDERERVO:Class = AwardStripeRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_BASEEVENTBOARDTABLERENDERERVO:Class = BaseEventBoardTableRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_BASEPLAYERAWARDRENDERERVO:Class = BasePlayerAwardRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_BASEPLAYERBATTLERENDERERVO:Class = BasePlayerBattleRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_BATTLEEXPERIENCEBLOCKVO:Class = BattleExperienceBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_BATTLESTATISTICSBLOCKVO:Class = BattleStatisticsBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSAWARDSOVERLAYVO:Class = EventBoardsAwardsOverlayVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSBATTLEOVERLAYVO:Class = EventBoardsBattleOverlayVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSDETAILSCONTAINERVO:Class = EventBoardsDetailsContainerVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSTABLEVIEWHEADERVO:Class = EventBoardsTableViewHeaderVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSTABLEVIEWSTATUSVO:Class = EventBoardsTableViewStatusVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSVEHICLESOVERLAYVO:Class = EventBoardsVehiclesOverlayVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDSVEHICLEVO:Class = EventBoardsVehicleVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDTABLEFILTERVEHICLESVO:Class = EventBoardTableFilterVehiclesVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDTABLEFILTERVO:Class = EventBoardTableFilterVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDTABLEHEADERICONVO:Class = EventBoardTableHeaderIconVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDTABLEHEADERVO:Class = EventBoardTableHeaderVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_EVENTBOARDTABLERENDERERCONTAINERVO:Class = EventBoardTableRendererContainerVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_HEADERAWARDBLOCKVO:Class = HeaderAwardBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_HEADERCONDITIONBLOCKVO:Class = HeaderConditionBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_HEADERDESCBLOCKVO:Class = net.wg.gui.lobby.eventBoards.data.HeaderDescBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_HEADERRELOGINBLOCKVO:Class = HeaderReloginBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_HEADERSERVERBLOCKVO:Class = HeaderServerBlockVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_MISSIONEVENTBOARDSBODYVO:Class = MissionEventBoardsBodyVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_MISSIONEVENTBOARDSCARDVO:Class = MissionEventBoardsCardVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_MISSIONEVENTBOARDSHEADERVO:Class = MissionEventBoardsHeaderVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_MISSIONSEVENTBOARDSPACKVO:Class = MissionsEventBoardsPackVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_TOPPLAYERAWARDRENDERERVO:Class = TopPlayerAwardRendererVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_DATA_VEHICLERENDERERITEMVO:Class = VehicleRendererItemVO;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_AWARDSRENDEREREVENT:Class = AwardsRendererEvent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_FILTERRENDEREREVENT:Class = FilterRendererEvent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_MISSIONPREMIUMEVENT:Class = MissionPremiumEvent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_PLAYERRENDEREREVENT:Class = PlayerRendererEvent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_SERVEREVENT:Class = ServerEvent;

        public static const NET_WG_GUI_LOBBY_EVENTBOARDS_EVENTS_TYPEEVENT:Class = TypeEvent;

        public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_EVENTINFOPANEL:Class = EventInfoPanel;

        public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_DATA_EVENTINFOPANELITEMVO:Class = EventInfoPanelItemVO;

        public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_DATA_EVENTINFOPANELVO:Class = EventInfoPanelVO;

        public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_INTERFACES_IEVENTINFOPANEL:Class = IEventInfoPanel;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_FORTBATTLEROOMWINDOW:Class = FortBattleRoomWindow;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTBATTLEROOMWAITLISTSECTION:Class = FortBattleRoomWaitListSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIEDETAILSSECTION:Class = JoinSortieDetailsSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIEDETAILSSECTIONALERTVIEW:Class = JoinSortieDetailsSectionAlertView;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIESECTION:Class = JoinSortieSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_LEGIONARIESCANDIDATEITEMRENDERER:Class = LegionariesCandidateItemRenderer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_LEGIONARIESDATAPROVIDER:Class = LegionariesDataProvider;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIECHATSECTION:Class = SortieChatSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIELISTRENDERER:Class = SortieListRenderer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIESLOTHELPER:Class = SortieSlotHelper;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIETEAMSECTION:Class = SortieTeamSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIEWAITLISTSECTION:Class = SortieWaitListSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_ADVANCEDCLANBATTLETIMER:Class = AdvancedClanBattleTimer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLECREATORVIEW:Class = ClanBattleCreatorView;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLETABLERENDERER:Class = ClanBattleTableRenderer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLETIMER:Class = ClanBattleTimer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTCLANBATTLEROOM:Class = FortClanBattleRoom;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTCLANBATTLETEAMSECTION:Class = FortClanBattleTeamSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_JOINCLANBATTLESECTION:Class = JoinClanBattleSection;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IFORTDISCONNECTVIEW:Class = IFortDisconnectView;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLEROOM_SLOTBUTTONFILTERS:Class = SlotButtonFilters;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLEROOM_SORTIESIMPLESLOT:Class = SortieSimpleSlot;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLEROOM_SORTIESLOT:Class = SortieSlot;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_CONNECTEDDIRECTS:Class = ConnectedDirects;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTDISCONNECTVIEW:Class = FortDisconnectView;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_SELECTOR_FORTVEHICLESELECTOR:Class = FortVehicleSelector;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_SELECTOR_FORTVEHICLESELECTORFILTER:Class = FortVehicleSelectorFilter;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_SELECTOR_FORTVEHICLESELECTORRENDERER:Class = FortVehicleSelectorRenderer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGVO:Class = BuildingVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BASE_BUILDINGBASEVO:Class = BuildingBaseVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESCANDIDATEVO:Class = LegionariesCandidateVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESSLOTSVO:Class = LegionariesSlotsVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESSORTIEVO:Class = LegionariesSortieVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_SORTIEALERTVIEWVO:Class = SortieAlertViewVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_SORTIESLOTVO:Class = SortieSlotVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_SORTIEVO:Class = SortieVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLEDETAILSVO:Class = ClanBattleDetailsVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLERENDERLISTVO:Class = ClanBattleRenderListVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLETIMERVO:Class = ClanBattleTimerVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_FORTCLANBATTLEROOMVO:Class = FortClanBattleRoomVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_POPOVER_FORTVEHICLESELECTORFILTERVO:Class = FortVehicleSelectorFilterVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_POPOVER_FORTVEHICLESELECTORITEMVO:Class = FortVehicleSelectorItemVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_POPOVER_FORTVEHICLESELECTPOPOVERDATA:Class = FortVehicleSelectPopoverData;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_POPOVER_FORTVEHICLESELECTPOPOVERVO:Class = FortVehicleSelectPopoverVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SORTIE_SORTIERENDERVO:Class = SortieRenderVO;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_CLANBATTLESLOTEVENT:Class = ClanBattleSlotEvent;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_CLANBATTLETIMEREVENT:Class = ClanBattleTimerEvent;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_DIRECTIONEVENT:Class = DirectionEvent;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTERFACES_ICLANBATTLETIMER:Class = IClanBattleTimer;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_FORTVEHICLESELECTPOPOVER:Class = FortVehicleSelectPopover;

        public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_POPOVERWITHDROPDOWN:Class = PopoverWithDropdown;

        public static const NET_WG_GUI_LOBBY_GOLDFISHEVENT_GOLDFISHWINDOW:Class = GoldFishWindow;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREWDROPDOWNEVENT:Class = CrewDropDownEvent;

        public static const NET_WG_GUI_LOBBY_HANGAR_HANGAR:Class = Hangar;

        public static const NET_WG_GUI_LOBBY_HANGAR_HANGARHEADER:Class = HangarHeader;

        public static const NET_WG_GUI_LOBBY_HANGAR_LOOTBOXESENTRANCEPOINTWIDGET:Class = LootboxesEntrancePointWidget;

        public static const NET_WG_GUI_LOBBY_HANGAR_NYCREDITBONUS:Class = NYCreditBonus;

        public static const NET_WG_GUI_LOBBY_HANGAR_RESEARCHPANEL:Class = ResearchPanel;

        public static const NET_WG_GUI_LOBBY_HANGAR_SWITCHMODEPANEL:Class = SwitchModePanel;

        public static const NET_WG_GUI_LOBBY_HANGAR_TMENXPPANEL:Class = TmenXpPanel;

        public static const NET_WG_GUI_LOBBY_HANGAR_VEHICLEPARAMETERS:Class = VehicleParameters;

        public static const NET_WG_GUI_LOBBY_HANGAR_ALERTMESSAGE_ALERTMESSAGEBLOCK:Class = AlertMessageBlock;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_AMMUNITIONPANEL:Class = AmmunitionPanel;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_BATTLEABILITIESHIGHLIGHTER:Class = BattleAbilitiesHighlighter;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_BATTLEABILITYSLOT:Class = BattleAbilitySlot;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EQUIPMENTSLOT:Class = EquipmentSlot;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_IAMMUNITIONPANEL:Class = IAmmunitionPanel;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_VEHICLESTATEMSG:Class = VehicleStateMsg;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_DATA_AMMUNITIONPANELVO:Class = AmmunitionPanelVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_DATA_VEHICLEMESSAGEVO:Class = VehicleMessageVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EVENTS_AMMUNITIONPANELEVENTS:Class = AmmunitionPanelEvents;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREW:Class = Crew;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWDOGITEM:Class = CrewDogItem;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWITEMLABEL:Class = CrewItemLabel;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWITEMRENDERER:Class = CrewItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWSCROLLINGLIST:Class = CrewScrollingList;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_ICONSPROPS:Class = IconsProps;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_ICREW:Class = ICrew;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_RECRUITITEMRENDERER:Class = RecruitItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANROLEVO:Class = TankmanRoleVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANTEXTCREATOR:Class = TankmanTextCreator;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANVO:Class = TankmanVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMENICONS:Class = TankmenIcons;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMENRESPONSEVO:Class = TankmenResponseVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_CREW_EV_CREWDOGEVENT:Class = CrewDogEvent;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_ALERTMESSAGEBLOCKVO:Class = AlertMessageBlockVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_HANGARHEADERVO:Class = HangarHeaderVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_HEADERQUESTGROUPVO:Class = HeaderQuestGroupVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_HEADERQUESTSVO:Class = HeaderQuestsVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_MODULEINFOACTIONVO:Class = ModuleInfoActionVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_RESEARCHPANELVO:Class = ResearchPanelVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_DATA_SWITCHMODEPANELVO:Class = SwitchModePanelVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IHANGAR:Class = IHangar;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IHANGARHEADER:Class = IHangarHeader;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IHEADERQUESTSCONTAINER:Class = IHeaderQuestsContainer;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IQUESTINFORMERBUTTON:Class = IQuestInformerButton;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IQUESTSBUTTONSCONTAINER:Class = IQuestsButtonsContainer;

        public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IVEHICLEPARAMETERS:Class = IVehicleParameters;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTITEM:Class = EquipmentItem;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTLISTITEMRENDERER:Class = EquipmentListItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_FITTINGSELECTDROPDOWN:Class = FittingSelectDropDown;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_MAINTENANCESTATUSINDICATOR:Class = MaintenanceStatusIndicator;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLITEMRENDERER:Class = ShellItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLLISTITEMRENDERER:Class = ShellListItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_TECHNICALMAINTENANCE:Class = TechnicalMaintenance;

        public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_HISTORICALAMMOVO:Class = HistoricalAmmoVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_FLAGCONTAINER:Class = FlagContainer;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_HEADERQUESTSCONTAINER:Class = HeaderQuestsContainer;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_HEADERQUESTSEVENT:Class = HeaderQuestsEvent;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_HEADERQUESTSFLAGS:Class = HeaderQuestsFlags;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_HEADER_QUESTS_CONSTANTS:Class = HEADER_QUESTS_CONSTANTS;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_QUESTFLAGICONCONTAINER:Class = QuestFlagIconContainer;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_QUESTINFORMERBUTTON:Class = QuestInformerButton;

        public static const NET_WG_GUI_LOBBY_HANGAR_QUESTS_QUESTINFORMERCONTENT:Class = QuestInformerContent;

        public static const NET_WG_GUI_LOBBY_HANGAR_SENIORITYAWARDS_SENIORITYAWARDSENTRYPOINT:Class = SeniorityAwardsEntryPoint;

        public static const NET_WG_GUI_LOBBY_HANGAR_SENIORITYAWARDS_SENIORITYAWARDSENTRYPOINTHANGAR:Class = SeniorityAwardsEntryPointHangar;

        public static const NET_WG_GUI_LOBBY_HANGAR_SENIORITYAWARDS_SENIORITYAWARDSENTRYPOINTVO:Class = SeniorityAwardsEntryPointVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_BASETANKICON:Class = BaseTankIcon;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CLANLOCKUI:Class = ClanLockUI;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_ITANKCAROUSEL:Class = ITankCarousel;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONINFOBLOCK:Class = MultiselectionInfoBlock;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONSLOTRENDERER:Class = MultiselectionSlotRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONSLOTS:Class = MultiselectionSlots;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_NYVEHICLEBONUS:Class = NYVehicleBonus;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_SMALLTANKICON:Class = SmallTankIcon;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSEL:Class = TankCarousel;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSELITEMRENDERER:Class = TankCarouselItemRenderer;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKICON:Class = net.wg.gui.lobby.hangar.tcarousel.TankIcon;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_VEHICLESELECTORCAROUSEL:Class = VehicleSelectorCarousel;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_FILTERCOMPONENTVIEWVO:Class = FilterComponentViewVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_MULTISELECTIONINFOVO:Class = MultiselectionInfoVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_MULTISELECTIONSLOTVO:Class = MultiselectionSlotVO;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_EVENT_SLOTEVENT:Class = SlotEvent;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_ITANKCAROUSELHELPER:Class = ITankCarouselHelper;

        public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_TANKCAROUSELSTATSFORMATTER:Class = TankCarouselStatsFormatter;

        public static const NET_WG_GUI_LOBBY_HANGAR_VEHICLEPARAMETERS_COMPONENTS_VEHPARAMRENDERER:Class = VehParamRenderer;

        public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTCLANPOPOVERBLOCK:Class = AccountClanPopoverBlock;

        public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVER:Class = AccountPopover;

        public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERBLOCK:Class = AccountPopoverBlock;

        public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERBLOCKBASE:Class = AccountPopoverBlockBase;

        public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERREFERRALBLOCK:Class = AccountPopoverReferralBlock;

        public static const NET_WG_GUI_LOBBY_HEADER_BADGESLOT:Class = BadgeSlot;

        public static const NET_WG_GUI_LOBBY_HEADER_IACCOUNTCLANPOPOVERBLOCK:Class = IAccountClanPopOverBlock;

        public static const NET_WG_GUI_LOBBY_HEADER_LOBBYHEADER:Class = LobbyHeader;

        public static const NET_WG_GUI_LOBBY_HEADER_NYWIDGETUI:Class = NYWidgetUI;

        public static const NET_WG_GUI_LOBBY_HEADER_ONLINECOUNTER:Class = OnlineCounter;

        public static const NET_WG_GUI_LOBBY_HEADER_TANKPANEL:Class = TankPanel;

        public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_ACCOUNTPOPOVEREVENT:Class = AccountPopoverEvent;

        public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_BATTLETYPESELECTOREVENT:Class = BattleTypeSelectorEvent;

        public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_HEADEREVENTS:Class = HeaderEvents;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACCOUNT:Class = HBC_Account;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACCOUNTUPPER:Class = HBC_AccountUpper;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACTIONITEM:Class = HBC_ActionItem;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_BATTLESELECTOR:Class = HBC_BattleSelector;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_FINANCE:Class = HBC_Finance;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_PREM:Class = HBC_Prem;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_PREMSHOP:Class = HBC_PremShop;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_SETTINGS:Class = HBC_Settings;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_SQUAD:Class = HBC_Squad;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_UPPER:Class = HBC_Upper;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTON:Class = HeaderButton;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONACTIONCONTENT:Class = HeaderButtonActionContent;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONBAR:Class = HeaderButtonBar;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONCONTENTITEM:Class = HeaderButtonContentItem;

        public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONSHELPER:Class = HeaderButtonsHelper;

        public static const NET_WG_GUI_LOBBY_HEADER_INTERFACES_ILOBBYHEADER:Class = ILobbyHeader;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_BATTLETYPESELECTPOPOVERDEMONSTRATOR:Class = BattleTypeSelectPopoverDemonstrator;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORLIST:Class = ItemSelectorList;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORPOPOVER:Class = ItemSelectorPopover;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORRENDERER:Class = ItemSelectorRenderer;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORRENDERERVO:Class = ItemSelectorRendererVO;

        public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORTOOLTIPDATAVO:Class = ItemSelectorTooltipDataVO;

        public static const NET_WG_GUI_LOBBY_HEADER_MAINMENUBUTTONBAR_MAINMENUBUTTONBAR:Class = MainMenuButtonBar;

        public static const NET_WG_GUI_LOBBY_HEADER_RANKEDBATTLES_SPARKANIM:Class = SparkAnim;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTBOOSTERVO:Class = AccountBoosterVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTCLANPOPOVERBLOCKVO:Class = AccountClanPopoverBlockVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTDATAVO:Class = AccountDataVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERBLOCKVO:Class = AccountPopoverBlockVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERMAINVO:Class = AccountPopoverMainVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERREFERRALBLOCKVO:Class = AccountPopoverReferralBlockVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HANGARMENUTABITEMVO:Class = HangarMenuTabItemVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_ABSTRACTVO:Class = HBC_AbstractVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_ACCOUNTDATAVO:Class = HBC_AccountDataVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_BATTLETYPEVO:Class = HBC_BattleTypeVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_FINANCEVO:Class = HBC_FinanceVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_PREMDATAVO:Class = HBC_PremDataVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_PREMSHOPVO:Class = HBC_PremShopVO;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_SETTINGSVO:Class = HBC_SettingsVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_SQUADDATAVO:Class = HBC_SquadDataVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_HEADERBUTTONVO:Class = HeaderButtonVo;

        public static const NET_WG_GUI_LOBBY_HEADER_VO_IHBC_VO:Class = IHBC_VO;

        public static const NET_WG_GUI_LOBBY_IMAGEVIEW_IMAGEVIEW:Class = ImageView;

        public static const NET_WG_GUI_LOBBY_INTERFACES_ILOBBYPAGE:Class = ILobbyPage;

        public static const NET_WG_GUI_LOBBY_INTERFACES_ISUBTASKCOMPONENT:Class = ISubtaskComponent;

        public static const NET_WG_GUI_LOBBY_INVITES_SENDINVITESWINDOW:Class = SendInvitesWindow;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_CANDIDATESLIST:Class = CandidatesList;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_CANDIDATESLISTITEMRENDERER:Class = CandidatesListItemRenderer;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_SEARCHLISTDRAGCONTROLLER:Class = SearchListDragController;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_SEARCHLISTDROPDELEGATE:Class = SearchListDropDelegate;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_TREEDRAGCONTROLLER:Class = TreeDragController;

        public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_TREEDROPDELEGATE:Class = TreeDropDelegate;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_LINKEDSETDETAILSCONTAINERVIEW:Class = LinkedSetDetailsContainerView;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_LINKEDSETHINTSVIEW:Class = LinkedSetHintsView;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_ANIMATEDMOVIECLIPCONTAINER:Class = AnimatedMovieClipContainer;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_LINKEDSETAWARD:Class = LinkedSetAward;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_LINKEDSETVIDEO:Class = LinkedSetVideo;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_MISSIONSLINKEDSETBODY:Class = MissionsLinkedSetBody;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_MISSIONSLINKEDSETCARDRENDERER:Class = MissionsLinkedSetCardRenderer;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_MISSIONSLINKEDSETHEADER:Class = MissionsLinkedSetHeader;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_MISSIONSPAGINATOR:Class = MissionsPaginator;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_COMPONENTS_VIEW_LINKEDSETDETAILSVIEW:Class = LinkedSetDetailsView;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_LINKEDSETAWARDVO:Class = LinkedSetAwardVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_LINKEDSETDETAILSCONTAINERVO:Class = LinkedSetDetailsContainerVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_LINKEDSETDETAILSOVERLAYVO:Class = LinkedSetDetailsOverlayVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_LINKEDSETDETAILSVIDEOVO:Class = LinkedSetDetailsVideoVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_LINKEDSETHINTSVO:Class = LinkedSetHintsVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_MISSIONLINKEDSETBODYVO:Class = MissionLinkedSetBodyVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_MISSIONLINKEDSETCARDVO:Class = MissionLinkedSetCardVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_DATA_MISSIONLINKEDSETHEADERVO:Class = MissionLinkedSetHeaderVO;

        public static const NET_WG_GUI_LOBBY_LINKEDSET_POPUPS_VEHICLELISTPOPUP:Class = VehicleListPopup;

        public static const NET_WG_GUI_LOBBY_LOBBYVEHICLEMARKERVIEW_LOBBYVEHICLEMARKERVIEW:Class = LobbyVehicleMarkerView;

        public static const NET_WG_GUI_LOBBY_MANUAL_MANUALMAINVIEW:Class = ManualMainView;

        public static const NET_WG_GUI_LOBBY_MANUAL_CONTROLS_CHAPTERITEMRENDERER:Class = ChapterItemRenderer;

        public static const NET_WG_GUI_LOBBY_MANUAL_DATA_CHAPTERITEMRENDERERVO:Class = ChapterItemRendererVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_MANUALCHAPTERVIEW:Class = ManualChapterView;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_MANUALPAGEVIEW:Class = ManualPageView;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_BOOTCAMPCONTAINER:Class = BootcampContainer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_DESCRIPTIONCONTAINER:Class = DescriptionContainer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_HINTRENDERER:Class = HintRenderer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_HINTSCONTAINER:Class = HintsContainer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_MANUALBACKGROUNDCONTAINER:Class = ManualBackgroundContainer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_PAGECONTENTTEMPLATE:Class = PageContentTemplate;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_CONTROLS_TEXTCONTAINER:Class = TextContainer;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_DATA_MANUALCHAPTERBOOTCAMPVO:Class = ManualChapterBootcampVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_DATA_MANUALCHAPTERCONTAINERVO:Class = ManualChapterContainerVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_DATA_MANUALCHAPTERHINTSVO:Class = ManualChapterHintsVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_DATA_MANUALCHAPTERHINTVO:Class = ManualChapterHintVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_DATA_MANUALPAGEDETAILEDVIEWVO:Class = ManualPageDetailedViewVO;

        public static const NET_WG_GUI_LOBBY_MANUALCHAPTER_EVENTS_MANUALVIEWEVENT:Class = ManualViewEvent;

        public static const NET_WG_GUI_LOBBY_MENU_LOBBYMENU:Class = LobbyMenu;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_BUTTONWITHCOUNTER:Class = ButtonWithCounter;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSEGERBARINITVO:Class = MessegerBarInitVO;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERBAR:Class = MessengerBar;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERCHANNELCAROUSELITEM:Class = MessengerChannelCarouselItem;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERICONBUTTON:Class = MessengerIconButton;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_NOTIFICATIONLISTBUTTON:Class = NotificationListButton;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_PREBATTLECHANNELCAROUSELITEM:Class = PrebattleChannelCarouselItem;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWGEOMETRYINBAR:Class = WindowGeometryInBar;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWOFFSETSINBAR:Class = WindowOffsetsInBar;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_BASECHANNELCAROUSELITEM:Class = BaseChannelCarouselItem;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_BASECHANNELRENDERER:Class = BaseChannelRenderer;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELBUTTON:Class = ChannelButton;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSEL:Class = ChannelCarousel;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSELSCROLLBAR:Class = ChannelCarouselScrollBar;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELLIST:Class = ChannelList;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELRENDERER:Class = ChannelRenderer;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_FLEXIBLETILELIST:Class = FlexibleTileList;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_PREBATTLECHANNELRENDERER:Class = PreBattleChannelRenderer;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_CHANNELLISTITEMVO:Class = ChannelListItemVO;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_ITOOLTIPDATA:Class = IToolTipData;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_MESSENGERBARCONSTANTS:Class = MessengerBarConstants;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_READYDATAVO:Class = ReadyDataVO;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_TOOLTIPDATAVO:Class = net.wg.gui.lobby.messengerBar.carousel.data.TooltipDataVO;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_EVENTS_CHANNELLISTEVENT:Class = ChannelListEvent;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_EVENTS_MESSENGERBARCHANNELCAROUSELEVENT:Class = MessengerBarChannelCarouselEvent;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_INTERFACES_IBASECHANNELCAROUSELITEM:Class = IBaseChannelCarouselItem;

        public static const NET_WG_GUI_LOBBY_MESSENGERBAR_INTERFACES_INOTIFICATIONLISTBUTTON:Class = INotificationListButton;

        public static const NET_WG_GUI_LOBBY_MISSIONS_CURRENTVEHICLEMISSIONSVIEW:Class = CurrentVehicleMissionsView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONDETAILEDVIEW:Class = MissionDetailedView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONDETAILSCONTAINERVIEW:Class = MissionDetailsContainerView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSFILTERPOPOVERVIEW:Class = MissionsFilterPopoverView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSGROUPEDVIEW:Class = MissionsGroupedView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSMARATHONVIEW:Class = MissionsMarathonView;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSPAGE:Class = MissionsPage;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSTOKENPOPOVER:Class = MissionsTokenPopover;

        public static const NET_WG_GUI_LOBBY_MISSIONS_MISSIONSVIEWBASE:Class = MissionsViewBase;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_AWARDGROUP:Class = AwardGroup;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONALTCONDITIONSCONTAINER:Class = MissionAltConditionsContainer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONCARDALTCONDITIONSCONTAINER:Class = MissionCardAltConditionsContainer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONCARDCONDITIONRENDERER:Class = MissionCardConditionRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONCARDRENDERER:Class = MissionCardRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONCONDITIONRENDERER:Class = MissionConditionRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONCONDITIONSLISTCONTAINER:Class = MissionConditionsListContainer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONDETAILSALTCONDITIONSCONTAINER:Class = MissionDetailsAltConditionsContainer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKCATEGORYHEADER:Class = MissionPackCategoryHeader;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKCURRENTVEHICLEHEADER:Class = MissionPackCurrentVehicleHeader;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKHEADERBASE:Class = MissionPackHeaderBase;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKMARATHONBODY:Class = MissionPackMarathonBody;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKMARATHONHEADER:Class = MissionPackMarathonHeader;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONPACKRENDERER:Class = MissionPackRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONSCOUNTERDELEGATE:Class = MissionsCounterDelegate;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONSFILTER:Class = MissionsFilter;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONSLIST:Class = MissionsList;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONSTOKENLISTRENDERER:Class = MissionsTokenListRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONVEHICLEITEMRENDERER:Class = MissionVehicleItemRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONVEHICLEPARAMRENDERER:Class = MissionVehicleParamRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_MISSIONVEHICLETYPERENDERER:Class = MissionVehicleTypeRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_ABSTRACTPOPOVERWITHSCROLLABLEGROUPPANEL:Class = AbstractPopoverWithScrollableGroupPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_CONDITIONSCOMPONENTPANEL:Class = ConditionsComponentPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONACCOUNTREQUIREMENTRENDERER:Class = MissionAccountRequirementRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONBATTLEREQUIREMENTRENDERER:Class = MissionBattleRequirementRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILEDCONDITIONRENDERER:Class = MissionDetailedConditionRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSACCOUNTREQUIREMENTSPANEL:Class = MissionDetailsAccountRequirementsPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSACHIEVEMENT:Class = MissionDetailsAchievement;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSAWARDSPANEL:Class = MissionDetailsAwardsPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSCONDITIONRENDERERABSTRACT:Class = MissionDetailsConditionRendererAbstract;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSCONDITIONRENDERERSMALL:Class = MissionDetailsConditionRendererSmall;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSCONDITIONSLISTCONTAINER:Class = MissionDetailsConditionsListContainer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSCONDITIONSPANEL:Class = MissionDetailsConditionsPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSTOKENRENDERER:Class = MissionDetailsTokenRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_MISSIONDETAILSTOPPANEL:Class = MissionDetailsTopPanel;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_DETAILEDVIEW_VERTICALCENTERALIGNEDLAYOUT:Class = VerticalCenterAlignedLayout;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_AWARDSTILELIST:Class = AwardsTileList;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_COLLAPSEDHEADERTITLEBLOCK:Class = CollapsedHeaderTitleBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_CURRENTVEHICLEHEADERTITLEBLOCK:Class = CurrentVehicleHeaderTitleBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_HEADERDESCBLOCK:Class = net.wg.gui.lobby.missions.components.headerComponents.HeaderDescBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_HEADERTITLEBLOCKBASE:Class = HeaderTitleBlockBase;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_MARATHONHEADERAWARDBLOCK:Class = MarathonHeaderAwardBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_MARATHONHEADERCONDITIONBLOCK:Class = MarathonHeaderConditionBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_MARATHONHEADERCONDITIONITEMRENDERER:Class = MarathonHeaderConditionItemRenderer;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_MISSIONHEADERACTION:Class = MissionHeaderAction;

        public static const NET_WG_GUI_LOBBY_MISSIONS_COMPONENTS_HEADERCOMPONENTS_MISSIONHEADERCALENDAR:Class = MissionHeaderCalendar;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_COLLAPSEDHEADERTITLEBLOCKVO:Class = CollapsedHeaderTitleBlockVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_CONDITIONRENDERERVO:Class = ConditionRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_CURRENTVEHICLEHEADERTITLEBLOCKVO:Class = CurrentVehicleHeaderTitleBlockVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_HEADERDESCBLOCKVO:Class = net.wg.gui.lobby.missions.data.HeaderDescBlockVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_HEADERTITLEBLOCKBASEVO:Class = HeaderTitleBlockBaseVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MARATHONHEADERAWARDBLOCKVO:Class = MarathonHeaderAwardBlockVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MARATHONHEADERCONDITIONBLOCKVO:Class = MarathonHeaderConditionBlockVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONACCOUNTREQUIREMENTRENDERERVO:Class = MissionAccountRequirementRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONACCOUNTREQUIREMENTSVO:Class = MissionAccountRequirementsVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONALTCONDITIONSCONTAINERVO:Class = MissionAltConditionsContainerVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONBATTLEREQUIREMENTRENDERERVO:Class = MissionBattleRequirementRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONCARDVIEWVO:Class = MissionCardViewVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONCONDITIONDETAILSVO:Class = MissionConditionDetailsVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONCONDITIONSCONTAINERVO:Class = MissionConditionsContainerVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONCONDITIONVO:Class = MissionConditionVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONDETAILEDVIEWVO:Class = MissionDetailedViewVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONDETAILSACHIEVEMENTRENDERERVO:Class = MissionDetailsAchievementRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONDETAILSCONTAINERVO:Class = MissionDetailsContainerVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONDETAILSPOPUPPANELVO:Class = MissionDetailsPopUpPanelVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONDETAILSTOKENRENDERERVO:Class = MissionDetailsTokenRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONHEADERACTIONVO:Class = MissionHeaderActionVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPACKCATEGORYHEADERVO:Class = MissionPackCategoryHeaderVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPACKCURRENTVEHICLEHEADERVO:Class = MissionPackCurrentVehicleHeaderVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPACKHEADERBASEVO:Class = MissionPackHeaderBaseVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPACKMARATHONBODYVO:Class = MissionPackMarathonBodyVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPACKMARATHONHEADERVO:Class = MissionPackMarathonHeaderVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONPROGRESSVO:Class = MissionProgressVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONSFILTERPOPOVERINITVO:Class = MissionsFilterPopoverInitVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONSFILTERPOPOVERSTATEVO:Class = MissionsFilterPopoverStateVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONSPACKVO:Class = MissionsPackVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONSTANKVO:Class = MissionsTankVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONSTOKENPOPOVERVO:Class = MissionsTokenPopoverVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONTABCOUNTERVO:Class = MissionTabCounterVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONTABVO:Class = MissionTabVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONVEHICLEITEMRENDERERVO:Class = MissionVehicleItemRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONVEHICLEPARAMRENDERERVO:Class = MissionVehicleParamRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONVEHICLESELECTORVO:Class = MissionVehicleSelectorVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_MISSIONVEHICLETYPERENDERERVO:Class = MissionVehicleTypeRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_DATA_TOKENRENDERERVO:Class = TokenRendererVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONCONDITIONRENDEREREVENT:Class = MissionConditionRendererEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONDETAILEDCONDITIONRENDEREREVENT:Class = MissionDetailedConditionRendererEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONDETAILSTOPPANELEVENT:Class = MissionDetailsTopPanelEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONHEADEREVENT:Class = MissionHeaderEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONSTOKENLISTRENDEREREVENT:Class = MissionsTokenListRendererEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_EVENT_MISSIONVIEWEVENT:Class = MissionViewEvent;

        public static const NET_WG_GUI_LOBBY_MISSIONS_INTERFACES_ICONDITIONVO:Class = IConditionVO;

        public static const NET_WG_GUI_LOBBY_MISSIONS_INTERFACES_IMARATHONHEADERBLOCK:Class = IMarathonHeaderBlock;

        public static const NET_WG_GUI_LOBBY_MISSIONS_INTERFACES_IMISSIONPACKBODY:Class = IMissionPackBody;

        public static const NET_WG_GUI_LOBBY_MISSIONS_INTERFACES_IMISSIONPACKHEADER:Class = IMissionPackHeader;

        public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEEFFECTS:Class = ModuleEffects;

        public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEPARAMETERS:Class = ModuleParameters;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DEVICEINDEXHELPER:Class = DeviceIndexHelper;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_FITTINGSELECTPOPOVER:Class = FittingSelectPopover;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_MODULESPANEL:Class = ModulesPanel;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_BATTLEABILITYITEMRENDERER:Class = BattleAbilityItemRenderer;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_BOOSTERFITTINGITEMRENDERER:Class = BoosterFittingItemRenderer;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_DEVICESLOT:Class = DeviceSlot;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_EXTRAICON:Class = ExtraIcon;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_FITTINGLISTITEMRENDERER:Class = FittingListItemRenderer;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_FITTINGLISTSELECTIONNAVIGATOR:Class = FittingListSelectionNavigator;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_LISTOVERLAY:Class = ListOverlay;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_MODULEFITTINGITEMRENDERER:Class = ModuleFittingItemRenderer;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_MODULESLOT:Class = ModuleSlot;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_OPTDEVICEFITTINGITEMRENDERER:Class = OptDeviceFittingItemRenderer;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_BATTLEABILITYVO:Class = BattleAbilityVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_BOOSTERFITTINGITEMVO:Class = BoosterFittingItemVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_DEVICESDATAVO:Class = DevicesDataVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_DEVICEVO:Class = DeviceVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_FITTINGSELECTPOPOVERPARAMS:Class = FittingSelectPopoverParams;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_FITTINGSELECTPOPOVERVO:Class = FittingSelectPopoverVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_LISTOVERLAYVO:Class = ListOverlayVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_MODULEVO:Class = net.wg.gui.lobby.modulesPanel.data.ModuleVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_OPTIONALDEVICEVO:Class = OptionalDeviceVO;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_INTERFACES_IDEVICESLOT:Class = IDeviceSlot;

        public static const NET_WG_GUI_LOBBY_MODULESPANEL_INTERFACES_IMODULESPANEL:Class = IModulesPanel;

        public static const NET_WG_GUI_LOBBY_NY2020_NYCUSTOMIZATIONSLOT:Class = NYCustomizationSlot;

        public static const NET_WG_GUI_LOBBY_NY2020_NYSELECTVEHICLEPOPOVER:Class = NYSelectVehiclePopover;

        public static const NET_WG_GUI_LOBBY_NY2020_NYSELECTVEHICLERENDERER:Class = NYSelectVehicleRenderer;

        public static const NET_WG_GUI_LOBBY_NY2020_NYVEHICLEBONUSPANEL:Class = NYVehicleBonusPanel;

        public static const NET_WG_GUI_LOBBY_NY2020_NYVEHICLESELECTORFILTER:Class = NYVehicleSelectorFilter;

        public static const NET_WG_GUI_LOBBY_NY2020_VO_NYSELECTVEHICLEPOPOVERVO:Class = NYSelectVehiclePopoverVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_CAMPAIGNOPERATIONSCONTAINER:Class = CampaignOperationsContainer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_PERSONALMISSIONSPAGE:Class = PersonalMissionsPage;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_ALLOPERATIONSCONTENT:Class = AllOperationsContent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONBUTTON:Class = OperationButton;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONBUTTONPOSTPONED:Class = OperationButtonPostponed;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONRENDERER:Class = OperationRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDBTNANIM:Class = PersonalMissionAwardBtnAnim;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDBTNREFLECT:Class = PersonalMissionAwardBtnReflect;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDRENDERER:Class = PersonalMissionAwardRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDSCONTAINER:Class = PersonalMissionAwardsContainer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDSSCREEN:Class = PersonalMissionAwardsScreen;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDSSCREENBGANIM:Class = PersonalMissionAwardsScreenBgAnim;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONAWARDSSCREENHEADERANIM:Class = PersonalMissionAwardsScreenHeaderAnim;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONDETAILEDVIEW:Class = PersonalMissionDetailedView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONDETAILSCONTAINERVIEW:Class = PersonalMissionDetailsContainerView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONEXTRAAWARDANIM:Class = PersonalMissionExtraAwardAnim;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONEXTRAAWARDDESC:Class = PersonalMissionExtraAwardDesc;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONFIRSTENTRYAWARDVIEW:Class = PersonalMissionFirstEntryAwardView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONFIRSTENTRYVIEW:Class = PersonalMissionFirstEntryView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONMAPBGCONTAINER:Class = PersonalMissionMapBgContainer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONOPERATIONS:Class = PersonalMissionOperations;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONPLANSLOADERMGR:Class = PersonalMissionPlansLoaderMgr;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSABSTRACTINFOVIEW:Class = PersonalMissionsAbstractInfoView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSAWARDSVIEW:Class = PersonalMissionsAwardsView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSMAPVIEW:Class = PersonalMissionsMapView;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSPLAN:Class = PersonalMissionsPlan;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSPLANREGION:Class = PersonalMissionsPlanRegion;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSPLANREGIONCHECK:Class = PersonalMissionsPlanRegionCheck;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSPLANREGIONDIGIT:Class = PersonalMissionsPlanRegionDigit;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSQUESTAWARDSCREEN:Class = PersonalMissionsQuestAwardScreen;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONSREGIONAWARDS:Class = PersonalMissionsRegionAwards;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PERSONALMISSIONVEHICLEAWARD:Class = PersonalMissionVehicleAward;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_PMPAGINATORARROWSCONTROLLER:Class = PMPaginatorArrowsController;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_SMOKEGENERATOR:Class = SmokeGenerator;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_TOSEASONBTN:Class = ToSeasonBtn;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_USEAWARDSHEETWINDOW:Class = UseAwardSheetWindow;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_AWARDSVIEW_ADDITIONALAWARDS:Class = AdditionalAwards;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_AWARDSVIEW_AWARDHEADER:Class = AwardHeader;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_AWARDSVIEW_PERSONALMISSIONSITEMSLOT:Class = PersonalMissionsItemSlot;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_AWARDSVIEW_PERSONALMISSIONSVEHICLESLOT:Class = PersonalMissionsVehicleSlot;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_AWARDSVIEW_VEHICLEAWARD:Class = VehicleAward;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_CHAINSPANEL_CHAINBUTTON:Class = ChainButton;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_CHAINSPANEL_CHAINBUTTONCONTENT:Class = ChainButtonContent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_CHAINSPANEL_CHAINSPANEL:Class = ChainsPanel;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOADDITIONALBLOCK:Class = InfoAdditionalBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOADDITIONALCONTENT:Class = InfoAdditionalContent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOADDITIONALCONTENTPAGE:Class = InfoAdditionalContentPage;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOADDITIONALNOTIFICATION:Class = InfoAdditionalNotification;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOCONTENT:Class = InfoContent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOITEMRENDERER:Class = net.wg.gui.lobby.personalMissions.components.firstEntry.InfoItemRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_INFOITEMRENDERERBG:Class = InfoItemRendererBg;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_MORETEXTANIM:Class = MoreTextAnim;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_PMINFOADDITIONALVIEWSETTINGS:Class = PMInfoAdditionalViewSettings;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_PMINFOVEWSETTINGS:Class = PMInfoVewSettings;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_FIRSTENTRY_PMINFOVEWSETTINGSCORE:Class = PMInfoVewSettingsCore;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_INTERFACES_IAWARDSHEETPOPUP:Class = IAwardSheetPopup;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_INTERFACES_ICHAINBUTTON:Class = IChainButton;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_INTERFACES_ICHAINBUTTONCONTENT:Class = IChainButtonContent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_INTERFACES_ICHAINSPANEL:Class = IChainsPanel;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_FREESHEETSCOUNTER:Class = FreeSheetsCounter;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATION:Class = Operation;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATIONDESCRIPTION:Class = OperationDescription;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATIONSCONTAINER:Class = OperationsContainer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATIONSHEADER:Class = OperationsHeader;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATIONTITLE:Class = OperationTitle;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_OPERATIONSHEADER_OPERATIONTITLEINFO:Class = OperationTitleInfo;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_ABSTRACTFREESHEETPOPUP:Class = AbstractFreeSheetPopup;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_AWARDSHEETACCEPTBTNCMP:Class = AwardSheetAcceptBtnCmp;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_AWARDSHEETANIMATION:Class = AwardSheetAnimation;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_AWARDSHEETTEXTBLOCKS:Class = AwardSheetTextBlocks;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_BOTTOMBLOCK:Class = BottomBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_FOURFREESHEETSOBTAINEDPOPUP:Class = FourFreeSheetsObtainedPopup;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_FREESHEETOBTAINEDPOPUP:Class = FreeSheetObtainedPopup;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_FREESHEETTITLE:Class = FreeSheetTitle;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_HEADERBLOCK:Class = HeaderBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_POPUPCOMPONENTS_ICONTEXTRENDERER:Class = IconTextRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_QUESTAWARDSCREEN_QUESTCONDITIONS:Class = QuestConditions;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_QUESTAWARDSCREEN_QUESTSTATUS:Class = QuestStatus;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_BASICFOOTERBLOCK:Class = BasicFooterBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_FREESHEETPOPOVER:Class = FreeSheetPopover;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_PAWNEDSHEETLISTRENDERER:Class = PawnedSheetListRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_SHEETSBLOCK:Class = SheetsBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_SHEETSINFOBLOCK:Class = SheetsInfoBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_STATUSFOOTER:Class = StatusFooter;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_TANKGIRLSBLOCK:Class = TankgirlsBlock;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_TANKGIRLSLISTRENDERER:Class = TankgirlsListRenderer;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_COMPONENTS_STATUSFOOTER_TANKGIRLSPOPOVER:Class = TankgirlsPopover;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_ADDITIONALAWARDSVO:Class = AdditionalAwardsVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_BASICFOOTERBLOCKVO:Class = BasicFooterBlockVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_CHAINBUTTONVO:Class = ChainButtonVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_CHAINSPANELVO:Class = ChainsPanelVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_FOURFREESHEETSOBTAINEDPOPUPVO:Class = FourFreeSheetsObtainedPopupVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_FREESHEETOBTAINEDPOPUPVO:Class = FreeSheetObtainedPopupVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_FREESHEETPOPOVERDATA:Class = FreeSheetPopoverData;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_FREESHEETPOPOVERVO:Class = FreeSheetPopoverVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_ICONTEXTRENDERERVO:Class = IconTextRendererVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_INFOADDITIONALBLOCKDATAVO:Class = InfoAdditionalBlockDataVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_INFOADDITIONALDATAVO:Class = InfoAdditionalDataVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_INFOITEMRENDERERVO:Class = net.wg.gui.lobby.personalMissions.data.InfoItemRendererVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_MAPSETTINGSDATA:Class = MapSettingsData;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_OPERATIONAWARDSVO:Class = OperationAwardsVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_OPERATIONDATAVO:Class = OperationDataVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_OPERATIONSHEADERVO:Class = OperationsHeaderVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_OPERATIONTITLEVO:Class = OperationTitleVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_OPERATIONVO:Class = OperationVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PAWNEDSHEETVO:Class = PawnedSheetVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONAWARDRENDERERVO:Class = PersonalMissionAwardRendererVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONAWARDSSCREENVO:Class = PersonalMissionAwardsScreenVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONDETAILEDVIEWVO:Class = PersonalMissionDetailedViewVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONDETAILSCONTAINERVO:Class = PersonalMissionDetailsContainerVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONFIRSTENTRYVIEWVO:Class = PersonalMissionFirstEntryViewVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSABSTRACTINFOVIEWVO:Class = PersonalMissionsAbstractInfoViewVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSAWARDSVIEWVO:Class = PersonalMissionsAwardsViewVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSITEMSLOTVO:Class = PersonalMissionsItemSlotVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSMAPPLANVO:Class = PersonalMissionsMapPlanVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSPLANREGIONVO:Class = PersonalMissionsPlanRegionVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSQUESTAWARDSCREENVO:Class = PersonalMissionsQuestAwardScreenVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSREGIONAWARDSVO:Class = PersonalMissionsRegionAwardsVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONSVEHICLESLOTVO:Class = PersonalMissionsVehicleSlotVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PERSONALMISSIONVEHICLEAWARDVO:Class = PersonalMissionVehicleAwardVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_PMAWARDHEADERVO:Class = PMAwardHeaderVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_QUESTRECRUITWINDOWVO:Class = QuestRecruitWindowVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_SHEETSBLOCKVO:Class = SheetsBlockVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_SHEETSINFOBLOCKVO:Class = SheetsInfoBlockVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_STATUSFOOTERVO:Class = StatusFooterVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_TANKGIRLSBLOCKVO:Class = TankgirlsBlockVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_TANKGIRLVO:Class = TankgirlVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_USEAWARDSHEETWINDOWVO:Class = UseAwardSheetWindowVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_DATA_VEHICLEAWARDVO:Class = VehicleAwardVO;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_ANIMATIONSTATEEVENT:Class = AnimationStateEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_AWARDEVENT:Class = AwardEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_CHAINEVENT:Class = ChainEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_FIRSTENTRYCARDEVENT:Class = FirstEntryCardEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_OPERATIONEVENT:Class = OperationEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_PAWNEDSHEETRENDEREREVENT:Class = PawnedSheetRendererEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_PERSONALMISSIONDETAILEDVIEWEVENT:Class = PersonalMissionDetailedViewEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_PERSONALMISSIONSITEMSLOTEVENT:Class = PersonalMissionsItemSlotEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_PLANLOADEREVENT:Class = PlanLoaderEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_PLANREGIONEVENT:Class = PlanRegionEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_STATUSFOOTEREVENT:Class = StatusFooterEvent;

        public static const NET_WG_GUI_LOBBY_PERSONALMISSIONS_EVENTS_TANKGIRLRENDEREREVENT:Class = TankgirlRendererEvent;

        public static const NET_WG_GUI_LOBBY_POST_TEASER:Class = Teaser;

        public static const NET_WG_GUI_LOBBY_POST_TEASEREVENT:Class = TeaserEvent;

        public static const NET_WG_GUI_LOBBY_POST_DATA_TEASERVO:Class = TeaserVO;

        public static const NET_WG_GUI_LOBBY_PREMIUMMISSIONS_COMPONENTS_MISSIONSPREMIUMBODY:Class = MissionsPremiumBody;

        public static const NET_WG_GUI_LOBBY_PREMIUMMISSIONS_DATA_MISSIONPREMIUMBODYVO:Class = MissionPremiumBodyVO;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMBODY:Class = PremiumBody;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMITEMRENDERER:Class = PremiumItemRenderer;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMWINDOW:Class = PremiumWindow;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_DATA_PREMIUMITEMRENDERERVO:Class = PremiumItemRendererVo;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_DATA_PREMIUMWINDOWRATESVO:Class = PremiumWindowRatesVO;

        public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_EVENTS_PREMIUMWINDOWEVENT:Class = PremiumWindowEvent;

        public static const NET_WG_GUI_LOBBY_PROFILE_LINKAGEUTILS:Class = LinkageUtils;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILE:Class = Profile;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILECONSTANTS:Class = ProfileConstants;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEINVALIDATIONTYPES:Class = ProfileInvalidationTypes;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEMENUINFOVO:Class = ProfileMenuInfoVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEOPENINFOEVENT:Class = ProfileOpenInfoEvent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PROFILETABNAVIGATOR:Class = ProfileTabNavigator;

        public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONINFO:Class = SectionInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONVIEWINFO:Class = SectionViewInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_USERINFOFORM:Class = UserInfoForm;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_AWARDSTILELISTBLOCK:Class = AwardsTileListBlock;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_BATTLESTYPEDROPDOWN:Class = BattlesTypeDropdown;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CENTEREDLINEICONTEXT:Class = CenteredLineIconText;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_COLOREDDESHLINETEXTITEM:Class = ColoredDeshLineTextItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_GRADIENTLINEBUTTONBAR:Class = GradientLineButtonBar;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_ICOUNTER:Class = ICounter;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITBATTLES:Class = LditBattles;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITMARKSOFMASTERY:Class = LditMarksOfMastery;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITVALUED:Class = LditValued;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINEBUTTONBAR:Class = LineButtonBar;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINETEXTCOMPONENT:Class = LineTextComponent;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PERSONALSCORECOMPONENT:Class = PersonalScoreComponent;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEFOOTER:Class = ProfileFooter;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEGROUPBLOCK:Class = ProfileGroupBlock;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEHOFCENTERGROUP:Class = ProfileHofCenterGroup;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEHOFFOOTER:Class = ProfileHofFooter;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEHOFSTATUSWAITING:Class = ProfileHofStatusWaiting;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEMEDALSLIST:Class = ProfileMedalsList;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEPAGEFOOTER:Class = ProfilePageFooter;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEWINDOWFOOTER:Class = ProfileWindowFooter;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLECONTENT:Class = ResizableContent;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLEINVALIDATIONTYPES:Class = ResizableInvalidationTypes;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_SIMPLELOADER:Class = SimpleLoader;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TECHMASTERYICON:Class = TechMasteryIcon;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TESTTRACK:Class = TestTrack;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXISCHART:Class = AxisChart;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_BARITEM:Class = BarItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTBASE:Class = ChartBase;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTITEM:Class = ChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTITEMBASE:Class = ChartItemBase;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_FRAMECHARTITEM:Class = FrameChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_ICHARTITEM:Class = IChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXIS_AXISBASE:Class = AxisBase;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXIS_ICHARTAXIS:Class = IChartAxis;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_LAYOUT_ICHARTLAYOUT:Class = IChartLayout;

        public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_LAYOUT_LAYOUTBASE:Class = LayoutBase;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_LAYOUTITEMINFO:Class = LayoutItemInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEBASEINFOVO:Class = ProfileBaseInfoVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEBATTLETYPEINITVO:Class = ProfileBattleTypeInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILECOMMONINFOVO:Class = ProfileCommonInfoVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEDOSSIERINFOVO:Class = ProfileDossierInfoVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEGROUPBLOCKVO:Class = ProfileGroupBlockVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEUSERVO:Class = ProfileUserVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_DATA_SECTIONLAYOUTMANAGER:Class = SectionLayoutManager;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILEACHIEVEMENTSSECTION:Class = ProfileAchievementsSection;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILESECTION:Class = ProfileSection;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILETABINFO:Class = ProfiletabInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SECTIONSSHOWANIMATIONMANAGER:Class = SectionsShowAnimationManager;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_AWARDSBLOCK:Class = AwardsBlock;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_AWARDSMAINCONTAINER:Class = AwardsMainContainer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_PROFILEAWARDS:Class = ProfileAwards;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_STAGEAWARDSBLOCK:Class = StageAwardsBlock;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_ACHIEVEMENTFILTERVO:Class = AchievementFilterVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_AWARDSBLOCKDATAVO:Class = AwardsBlockDataVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_PROFILEAWARDSINITVO:Class = ProfileAwardsInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_RECEIVEDRAREVO:Class = ReceivedRareVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_CLANINFO:Class = ClanInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_ERRORINFO:Class = ErrorInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORMATIONHEADER:Class = FormationHeader;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORMATIONINFOABSTRACT:Class = FormationInfoAbstract;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORTINFO:Class = FortInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_LINKNAVIGATIONEVENT:Class = LinkNavigationEvent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_NOCLAN:Class = NoClan;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_PREVIOUSTEAMRENDERER:Class = PreviousTeamRenderer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_PROFILEFORMATIONSPAGE:Class = ProfileFormationsPage;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_SHOWTEAMEVENT:Class = ShowTeamEvent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_TEAMINFO:Class = TeamInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_FORMATIONHEADERVO:Class = FormationHeaderVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_FORMATIONSTATVO:Class = FormationStatVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_PREVIOUSTEAMSITEMVO:Class = PreviousTeamsItemVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_PROFILEFORMATIONSVO:Class = ProfileFormationsVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_HOF_PROFILEHOF:Class = ProfileHof;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_LEVELBARCHARTITEM:Class = LevelBarChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_NATIONBARCHARTITEM:Class = NationBarChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICS:Class = ProfileStatistics;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICSBODYVO:Class = ProfileStatisticsBodyVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICSVO:Class = ProfileStatisticsVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTAXISPOINT:Class = StatisticBarChartAxisPoint;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTINITIALIZER:Class = StatisticBarChartInitializer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTITEM:Class = StatisticBarChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTLAYOUT:Class = StatisticBarChartLayout;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICCHARTINFO:Class = StatisticChartInfo;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHART:Class = StatisticsBarChart;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHARTAXIS:Class = StatisticsBarChartAxis;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSCHARTITEMANIMCLIENT:Class = StatisticsChartItemAnimClient;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSLAYOUTMANAGER:Class = StatisticsLayoutManager;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TYPEBARCHARTITEM:Class = TypeBarChartItem;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSGROUP:Class = ChartsStatisticsGroup;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSVIEW:Class = ChartsStatisticsView;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_PROFILESTATISTICSDETAILEDVO:Class = ProfileStatisticsDetailedVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSCHARTSTABDATAVO:Class = StatisticsChartsTabDataVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERBGIMAGE:Class = HeaderBGImage;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERCONTAINER:Class = HeaderContainer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_STATISTICSHEADERVO:Class = StatisticsHeaderVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_AWARDSLISTCOMPONENT:Class = AwardsListComponent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_LINETEXTFIELDSLAYOUT:Class = LineTextFieldsLayout;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARY:Class = ProfileSummary;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYPAGE:Class = ProfileSummaryPage;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYVO:Class = ProfileSummaryVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYWINDOW:Class = ProfileSummaryWindow;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYCOMMONSCORESVO:Class = SummaryCommonScoresVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYINITVO:Class = SummaryInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYPAGEINITVO:Class = SummaryPageInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYVIEWVO:Class = SummaryViewVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_ACHIEVEMENTSMALL:Class = AchievementSmall;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILESORTINGBUTTON:Class = ProfileSortingButton;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUE:Class = ProfileTechnique;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEEMPTYSCREEN:Class = ProfileTechniqueEmptyScreen;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEEVENT:Class = ProfileTechniqueEvent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEPAGE:Class = ProfileTechniquePage;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEWINDOW:Class = ProfileTechniqueWindow;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHAWARDSMAINCONTAINER:Class = TechAwardsMainContainer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHDETAILEDUNITGROUP:Class = TechDetailedUnitGroup;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNICSDASHLINETEXTITEMIRENDERER:Class = TechnicsDashLineTextItemIRenderer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTSBLOCK:Class = TechniqueAchievementsBlock;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTTAB:Class = TechniqueAchievementTab;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELIST:Class = TechniqueList;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELISTCOMPONENT:Class = TechniqueListComponent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUERENDERER:Class = TechniqueRenderer;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTACKCOMPONENT:Class = TechniqueStackComponent;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTATISTICTAB:Class = TechniqueStatisticTab;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHSTATISTICSINITVO:Class = TechStatisticsInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHSTATISTICSPAGEINITVO:Class = TechStatisticsPageInitVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_PROFILEVEHICLEDOSSIERVO:Class = ProfileVehicleDossierVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_RATINGBUTTONVO:Class = RatingButtonVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_SORTINGSETTINGVO:Class = SortingSettingVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUELISTVEHICLEVO:Class = TechniqueListVehicleVO;

        public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUESTATISTICVO:Class = TechniqueStatisticVO;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_PROGRESSIVEREWARD:Class = ProgressiveReward;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_PROGRESSIVEREWARDPROGRESS:Class = ProgressiveRewardProgress;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_PROGRESSIVEREWARDWIDGET:Class = ProgressiveRewardWidget;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_DATA_PROGRESSIVEREWARDSTEPVO:Class = ProgressiveRewardStepVO;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_DATA_PROGRESSIVEREWARDVO:Class = ProgressiveRewardVO;

        public static const NET_WG_GUI_LOBBY_PROGRESSIVEREWARD_EVENTS_PROGRESSIVEREWARDEVENT:Class = ProgressiveRewardEvent;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_AWARDCAROUSEL:Class = AwardCarousel;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_BASEQUESTSPROGRESS:Class = BaseQuestsProgress;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSPROGRESS:Class = QuestsProgress;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RADIOBUTTONSCROLLBAR:Class = RadioButtonScrollBar;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSGROUP:Class = SlotsGroup;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSLAYOUT:Class = SlotsLayout;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSPANEL:Class = SlotsPanel;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_TASKAWARDSBLOCK:Class = TaskAwardsBlock;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_TEXTBLOCKWELCOMEVIEW:Class = TextBlockWelcomeView;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_IQUESTSLOTRENDERER:Class = IQuestSlotRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITASKAWARDITEMRENDERER:Class = ITaskAwardItemRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITASKSPROGRESSCOMPONENT:Class = ITasksProgressComponent;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITEXTBLOCKWELCOMEVIEW:Class = ITextBlockWelcomeView;

        public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_TASKAWARDITEMRENDERER:Class = TaskAwardItemRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_CHAINPROGRESSITEMVO:Class = ChainProgressItemVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_CHAINPROGRESSVO:Class = ChainProgressVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSLOTSDATAVO:Class = QuestSlotsDataVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSLOTVO:Class = QuestSlotVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_ICONTITLEDESCSEASONAWARDVO:Class = IconTitleDescSeasonAwardVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_SEASONAWARDLISTRENDERERVO:Class = SeasonAwardListRendererVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_SEASONAWARDSVO:Class = SeasonAwardsVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_TEXTBLOCKWELCOMEVIEWVO:Class = TextBlockWelcomeViewVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_VEHICLESEASONAWARDVO:Class = VehicleSeasonAwardVO;

        public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_AWARDWINDOWEVENT:Class = AwardWindowEvent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONBLOCK:Class = ConditionBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONELEMENT:Class = ConditionElement;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DESCRIPTIONBLOCK:Class = DescriptionBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_ISUBTASKLISTLINKAGESELECTOR:Class = ISubtaskListLinkageSelector;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTAWARDSBLOCK:Class = QuestAwardsBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTLISTSELECTIONNAVIGATOR:Class = QuestListSelectionNavigator;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSLIST:Class = QuestsList;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSTASKSNAVIGATOR:Class = QuestsTasksNavigator;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTWINDOWUTILS:Class = QuestWindowUtils;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_REQUIREMENTBLOCK:Class = RequirementBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKCOMPONENT:Class = SubtaskComponent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKSLIST:Class = SubtasksList;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_VEHICLEBLOCK:Class = VehicleBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ABSTRACTRESIZABLECONTENT:Class = AbstractResizableContent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ALERTMESSAGE:Class = net.wg.gui.lobby.questsWindow.components.AlertMessage;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ANIMRESIZABLECONTENT:Class = AnimResizableContent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_BASERESIZABLECONTENTHEADER:Class = BaseResizableContentHeader;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_COMMONCONDITIONSBLOCK:Class = CommonConditionsBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CONDITIONSEPARATOR:Class = ConditionSeparator;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_COUNTERTEXTELEMENT:Class = CounterTextElement;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CUSTOMIZATIONITEMRENDERER:Class = CustomizationItemRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CUSTOMIZATIONSBLOCK:Class = CustomizationsBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_EVENTSRESIZABLECONTENT:Class = EventsResizableContent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INNERRESIZABLECONTENT:Class = InnerResizableContent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INSCRIPTIONITEMRENDERER:Class = InscriptionItemRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_MOVABLEBLOCKSCONTAINER:Class = MovableBlocksContainer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_PROGRESSBLOCK:Class = ProgressBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTBIGICONAWARDBLOCK:Class = QuestBigIconAwardBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTBIGICONAWARDITEM:Class = QuestBigIconAwardItem;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTICONAWARDSBLOCK:Class = QuestIconAwardsBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTICONELEMENT:Class = QuestIconElement;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSCOUNTER:Class = QuestsCounter;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSDASHLINEITEM:Class = QuestsDashlineItem;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSTATUSCOMPONENT:Class = QuestStatusComponent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTTEXTAWARDBLOCK:Class = QuestTextAwardBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTAINER:Class = ResizableContainer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTENTHEADER:Class = ResizableContentHeader;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TEXTPROGRESSELEMENT:Class = TextProgressElement;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TREEHEADER:Class = TreeHeader;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALMOTIVEQUESTDESCRIPTIONCONTAINER:Class = TutorialMotiveQuestDescriptionContainer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLEBONUSTEXTELEMENT:Class = VehicleBonusTextElement;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLEITEMRENDERER:Class = net.wg.gui.lobby.questsWindow.components.VehicleItemRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLESSORTINGBLOCK:Class = VehiclesSortingBlock;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_ICOMPLEXVIEWSTACKITEM:Class = IComplexViewStackItem;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_ICONDITIONRENDERER:Class = IConditionRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_IRESIZABLECONTENT:Class = net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_BASERESIZABLECONTENTVO:Class = BaseResizableContentVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_COMPLEXTOOLTIPVO:Class = ComplexTooltipVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONELEMENTVO:Class = ConditionElementVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONSEPARATORVO:Class = ConditionSeparatorVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_COUNTERTEXTELEMENTVO:Class = CounterTextElementVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CUSTOMIZATIONQUESTBONUSVO:Class = CustomizationQuestBonusVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_DESCRIPTIONVO:Class = DescriptionVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_EVENTSRESIZABLECONTENTVO:Class = EventsResizableContentVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_INFODATAVO:Class = InfoDataVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PADDINGSVO:Class = PaddingsVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PERSONALINFOVO:Class = PersonalInfoVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PROGRESSBLOCKVO:Class = ProgressBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDASHLINEITEMVO:Class = QuestDashlineItemVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDETAILSVO:Class = QuestDetailsVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTICONAWARDSBLOCKVO:Class = QuestIconAwardsBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTICONELEMENTVO:Class = QuestIconElementVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTRENDERERVO:Class = QuestRendererVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTVEHICLERENDERERVO:Class = QuestVehicleRendererVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_REQUIREMENTBLOCKVO:Class = RequirementBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SORTEDBTNVO:Class = SortedBtnVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_STATEVO:Class = StateVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SUBTASKVO:Class = SubtaskVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TEXTBLOCKVO:Class = TextBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TREECONTENTVO:Class = TreeContentVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALHANGARQUESTDETAILSVO:Class = TutorialHangarQuestDetailsVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALQUESTCONDITIONRENDERERVO:Class = TutorialQuestConditionRendererVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALQUESTDESCVO:Class = TutorialQuestDescVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLEBLOCKVO:Class = VehicleBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLEBONUSTEXTELEMENTVO:Class = VehicleBonusTextElementVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLESSORTINGBLOCKVO:Class = VehiclesSortingBlockVO;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_EVENTS_IQUESTRENDERER:Class = IQuestRenderer;

        public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_EVENTS_TUTORIALQUESTCONDITIONEVENT:Class = TutorialQuestConditionEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESPAGE:Class = RankedBattlesPage;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_BATTLERESULTS_COMPONENTS_RANKEDBATTLESUBTASK:Class = RankedBattleSubTask;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_BONUSBATTLES:Class = BonusBattles;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONICON:Class = DivisionIcon;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_IMAGECONTAINER:Class = ImageContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKEDBATTLESPAGEHEADER:Class = RankedBattlesPageHeader;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_STEPARROW:Class = StepArrow;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_STEPSCONTAINER:Class = StepsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_DIVISIONPROGRESSBLOCK:Class = DivisionProgressBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_DIVISIONPROGRESSRANKRENDERER:Class = DivisionProgressRankRenderer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_DIVISIONRANKSHIELD:Class = DivisionRankShield;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_ABSTRACTDIVISIONSTATE:Class = AbstractDivisionState;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_ACTIVEDIVISIONSTATE:Class = ActiveDivisionState;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_BLOCKSIZEPARAMS:Class = BlockSizeParams;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_BLOCKVIEWPARAMS:Class = BlockViewParams;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_FIRSTENTERDIVISIONSTATE:Class = FirstEnterDivisionState;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONPROGRESS_HELPERS_INACTIVEDIVISIONSTATE:Class = InactiveDivisionState;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONSCONTAINER_DIVISION:Class = Division;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONSCONTAINER_DIVISIONSCONTAINER:Class = DivisionsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONSELECTOR_DIVISIONSELECTOR:Class = DivisionSelector;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONSELECTOR_DIVISIONSELECTORNAME:Class = DivisionSelectorName;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_DIVISIONSTATUS_DIVISIONSTATUS:Class = DivisionStatus;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_INTERFACES_IRANKICON:Class = IRankIcon;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_INTERFACES_IRESIZABLERANKEDCOMPONENT:Class = IResizableRankedComponent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_INTERFACES_ISTEPARROW:Class = IStepArrow;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_INTERFACES_ISTEPSCONTAINER:Class = IStepsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_LEAGUE_LEAGUEICON:Class = LeagueIcon;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_AWARDDIVISION:Class = AwardDivision;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_AWARDDIVISIONBASE:Class = AwardDivisionBase;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_AWARDLEAGUE:Class = AwardLeague;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_AWARDTITLE:Class = AwardTitle;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_GLOWRANKANIMATION:Class = GlowRankAnimation;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_RANKAWARDANIMATION:Class = RankAwardAnimation;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_RANKAWARD_RANKCONTAINER:Class = RankContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_STATS_RANKEDBATTLESTATS:Class = RankedBattleStats;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_STATS_RANKEDBATTLESTATSDELTA:Class = RankedBattleStatsDelta;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_STATS_RANKEDBATTLESTATSINFO:Class = RankedBattleStatsInfo;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_LEAGUEIMAGECONTAINER:Class = LeagueImageContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_RANKEDBATTLESHANGARWIDGET:Class = RankedBattlesHangarWidget;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_RANKICON:Class = RankIcon;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_RANKSHIELD:Class = RankShield;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_RANKSHIELDCONTAINER:Class = RankShieldContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_RANKWIDGETANIMATOR:Class = RankWidgetAnimator;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_STATSDELTA:Class = StatsDelta;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_WIDGETBONUSBATTLES:Class = WidgetBonusBattles;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_WIDGETDIVISION:Class = WidgetDivision;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_WIDGETLEAGUE:Class = WidgetLeague;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_COMPONENTS_WIDGET_WIDGETSTEPSCONTAINER:Class = WidgetStepsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_CONSTANTS_LEAGUEICONCONSTS:Class = LeagueIconConsts;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_CONSTANTS_RANKEDHELPER:Class = RankedHelper;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_CONSTANTS_STATSCONSTS:Class = StatsConsts;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_AWARDDIVISIONBASEVO:Class = AwardDivisionBaseVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_AWARDDIVISIONVO:Class = AwardDivisionVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_DIVISIONPROGRESSBLOCKVO:Class = DivisionProgressBlockVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_DIVISIONSHIELDVO:Class = DivisionShieldVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_DIVISIONSVIEWVO:Class = DivisionsViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_DIVISIONVO:Class = net.wg.gui.lobby.rankedBattles19.data.DivisionVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_LEAGUESSTATSBLOCKVO:Class = LeaguesStatsBlockVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_LEAGUESVIEWVO:Class = LeaguesViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_PLAYERRANKRENDERERVO:Class = PlayerRankRendererVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_PROGRESSINFOBLOCKVO:Class = ProgressInfoBlockVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLEAWARDVIEWVO:Class = RankedBattleAwardViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLERESULTSVO:Class = RankedBattleResultsVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESCURRENTAWARDVO:Class = RankedBattlesCurrentAwardVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESDIVISIONPROGRESSVO:Class = RankedBattlesDivisionProgressVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESHANGARWIDGETVO:Class = RankedBattlesHangarWidgetVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESINTROBLOCKVO:Class = RankedBattlesIntroBlockVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESPAGEHEADERVO:Class = RankedBattlesPageHeaderVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESPAGEVO:Class = RankedBattlesPageVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESSEASONCOMPLETEVIEWVO:Class = RankedBattlesSeasonCompleteViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESSTATSBLOCKVO:Class = RankedBattlesStatsBlockVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESSTATSDELTAVO:Class = RankedBattlesStatsDeltaVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESSTATSINFOVO:Class = RankedBattlesStatsInfoVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESSTATSVO:Class = RankedBattlesStatsVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDBATTLESUNREACHABLEVIEWVO:Class = RankedBattlesUnreachableViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDLISTSVO:Class = RankedListsVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDLISTVO:Class = RankedListVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDREWARDSYEARVO:Class = RankedRewardsYearVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKEDREWARDYEARITEMVO:Class = RankedRewardYearItemVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKICONVO:Class = RankIconVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKSCOREVO:Class = RankScoreVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKSHIELDANIMHELPERVO:Class = RankShieldAnimHelperVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RANKSHIELDVO:Class = RankShieldVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_REWARDSLEAGUERENDERERVO:Class = RewardsLeagueRendererVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_REWARDSLEAGUEVO:Class = RewardsLeagueVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_REWARDSRANKRENDERERVO:Class = RewardsRankRendererVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_RULEVO:Class = RuleVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_SEASONGAPVIEWVO:Class = SeasonGapViewVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_STEPSCONTAINERVO:Class = StepsContainerVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_WIDGETDIVISIONVO:Class = WidgetDivisionVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_DATA_WIDGETLEAGUEVO:Class = WidgetLeagueVO;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_DIVISIONSEVENT:Class = DivisionsEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_RANKWIDGETEVENT:Class = RankWidgetEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_REWARDSEVENT:Class = RewardsEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_REWARDYEAREVENT:Class = RewardYearEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_SEASONCOMPLETEEVENT:Class = SeasonCompleteEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_SERVERSLOTBUTTONEVENT:Class = ServerSlotButtonEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_SOUNDEVENT:Class = SoundEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_EVENTS_STEPEVENT:Class = StepEvent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_PLAYERRANKEDRENDERER:Class = PlayerRankedRenderer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_RANKEDBATTLESBATTLERESULTS:Class = RankedBattlesBattleResults;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_RANKEDLISTSCONTAINER:Class = RankedListsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_RANKEDLISTWITHBACKGROUND:Class = RankedListWithBackground;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_RANKEDSIMPLETILELIST:Class = RankedSimpleTileList;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_RANKEDBATTLESBATTLERESULTS_RESULTSCONTAINER:Class = ResultsContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESAWARDVIEW:Class = RankedBattlesAwardView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESDIVISIONSVIEW:Class = RankedBattlesDivisionsView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESLEAGUESVIEW:Class = RankedBattlesLeaguesView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESSEASONGAPVIEW:Class = RankedBattlesSeasonGapView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESUNREACHABLEVIEW:Class = RankedBattlesUnreachableView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_RANKEDBATTLESVIEWSTACKCOMPONENT:Class = RankedBattlesViewStackComponent;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_BASE_HANGARRANKEDSCREEN:Class = HangarRankedScreen;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_BASE_RANKEDSCREEN:Class = RankedScreen;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_DIVISIONS_RANKEDBATTLESDIVISIONPROGRESS:Class = RankedBattlesDivisionProgress;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_DIVISIONS_RANKEDBATTLESDIVISIONQUALIFICATION:Class = RankedBattlesDivisionQualification;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_INTRO_RANKEDBATTLESINTRO:Class = RankedBattlesIntro;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_INTRO_RANKEDINTROBLOCK:Class = RankedIntroBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_INTRO_RANKEDINTROBLOCKS:Class = RankedIntroBlocks;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKEDBATTLESREWARDS:Class = RankedBattlesRewards;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKEDBATTLESREWARDSLEAGUESVIEW:Class = RankedBattlesRewardsLeaguesView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKEDBATTLESREWARDSRANKSVIEW:Class = RankedBattlesRewardsRanksView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKEDBATTLESREWARDSYEARVIEW:Class = RankedBattlesRewardsYearView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_LEAGUE_REWARDSLEAGUECONTAINER:Class = RewardsLeagueContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_LEAGUE_REWARDSLEAGUERENDERER:Class = RewardsLeagueRenderer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_LEAGUE_REWARDSLEAGUESTYLEREWARD:Class = RewardsLeagueStyleReward;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKS_DIVISIONREWARDSVIEW:Class = DivisionRewardsView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKS_QUALIFICATIONREWARDSVIEW:Class = QualificationRewardsView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKS_RANKSHIELDLEVEL:Class = RankShieldLevel;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKS_REWARDSRANKRENDERER:Class = RewardsRankRenderer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_RANKS_REWARDSRANKSCONTAINER:Class = RewardsRanksContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_YEAR_RANKEDBATTLESREWARDSYEARBG:Class = RankedBattlesRewardsYearBg;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_YEAR_RANKEDBATTLESYEARREWARDBTN:Class = RankedBattlesYearRewardBtn;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_YEAR_RANKEDBATTLESYEARREWARDCIRCLE:Class = RankedBattlesYearRewardCircle;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_REWARDS_YEAR_RANKEDBATTLESYEARREWARDCONTAINER:Class = RankedBattlesYearRewardContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_RANKEDBATTLESSEASONCOMPLETEVIEW:Class = RankedBattlesSeasonCompleteView;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_RANKEDBATTLESSEASONCONTAINER:Class = RankedBattlesSeasonContainer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_RANKEDBATTLESSEASONTYPE:Class = RankedBattlesSeasonType;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONBASERESULTBLOCK:Class = SeasonBaseResultBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONDIVISIONRESULTBLOCK:Class = SeasonDivisionResultBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONLEAGUERESULTBLOCK:Class = SeasonLeagueResultBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONMAINIMAGE:Class = SeasonMainImage;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONRESULTRENDERER:Class = SeasonResultRenderer;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_SEASONCOMPLETE_SEASONTEXTWRAPPER:Class = SeasonTextWrapper;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_STATS_DIVISIONSSTATSBLOCK:Class = DivisionsStatsBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_STATS_LEAGUESSTATSBLOCK:Class = LeaguesStatsBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_STATS_STATSBLOCK:Class = StatsBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_UNREACHABLEVIEW_RANKEDUNREACHABLEBOTTOMBLOCK:Class = RankedUnreachableBottomBlock;

        public static const NET_WG_GUI_LOBBY_RANKEDBATTLES19_VIEW_UNREACHABLEVIEW_RULERENDERER:Class = RuleRenderer;

        public static const NET_WG_GUI_LOBBY_RECRUITWINDOW_QUESTRECRUITWINDOW:Class = QuestRecruitWindow;

        public static const NET_WG_GUI_LOBBY_RECRUITWINDOW_RECRUITWINDOW:Class = RecruitWindow;

        public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_AWARDRECEIVEDBLOCK:Class = AwardReceivedBlock;

        public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_PROGRESSSTEPRENDERER:Class = ProgressStepRenderer;

        public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_DATA_AWARDDATADATAVO:Class = AwardDataDataVO;

        public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_DATA_PROGRESSSTEPVO:Class = ProgressStepVO;

        public static const NET_WG_GUI_LOBBY_RESERVESPANEL_COMPONENTS_RESERVEFITTINGITEMRENDERER:Class = ReserveFittingItemRenderer;

        public static const NET_WG_GUI_LOBBY_RESERVESPANEL_COMPONENTS_RESERVESLOT:Class = ReserveSlot;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWBLOCKVO:Class = RetrainCrewBlockVO;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWBLOCKVOBASE:Class = RetrainCrewBlockVOBase;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWMAINBUTTONS:Class = RetrainCrewMainButtons;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWOPERATIONVO:Class = RetrainCrewOperationVO;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWROLEIR:Class = RetrainCrewRoleIR;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWWINDOW:Class = RetrainCrewWindow;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINTANKMANVO:Class = RetrainTankmanVO;

        public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINVEHICLEBLOCKVO:Class = RetrainVehicleBlockVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONBATTLESTATSVIEW:Class = SessionBattleStatsView;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSBATTLEEFFICIENCYBLOCK:Class = SessionStatsBattleEfficiencyBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSBATTLERESULTBLOCK:Class = SessionStatsBattleResultBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSEFFICIENCYPARAMBLOCK:Class = SessionStatsEfficiencyParamBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSPARAMSLISTBLOCK:Class = SessionStatsParamsListBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSPOPOVER:Class = SessionStatsPopover;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSSTATUSBLOCK:Class = SessionStatsStatusBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONSTATSTANKINFOHEADERBLOCK:Class = SessionStatsTankInfoHeaderBlock;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_SESSIONVEHICLESTATSVIEW:Class = SessionVehicleStatsView;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONBATTLEEFFICIENCYSTATSRENDERER:Class = SessionBattleEfficiencyStatsRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONBATTLESTATSRENDERER:Class = SessionBattleStatsRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSANIMATEDCOUNTER:Class = SessionStatsAnimatedCounter;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSANIMATEDNUMBER:Class = SessionStatsAnimatedNumber;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSANIMATEDNUMBERCOUNTER:Class = SessionStatsAnimatedNumberCounter;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSINFOPARAMSRENDERER:Class = SessionStatsInfoParamsRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSRATECOMPONENT:Class = SessionStatsRateComponent;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSTANKINFOBACKGROUND:Class = SessionStatsTankInfoBackground;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSTANKINFOMAINMARK:Class = SessionStatsTankInfoMainMark;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSTANKINFORENDERER:Class = SessionStatsTankInfoRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONSTATSTANKSMALLNAME:Class = SessionStatsTankSmallName;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONTOTALSTATSRENDERER:Class = SessionTotalStatsRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_COMPONENTS_SESSIONVEHICLESTATSRENDERER:Class = SessionVehicleStatsRenderer;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONBATTLESTATSRENDERERVO:Class = SessionBattleStatsRendererVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONBATTLESTATSVIEWVO:Class = SessionBattleStatsViewVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSEFFICIENCYPARAMVO:Class = SessionStatsEfficiencyParamVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSPOPOVERVO:Class = SessionStatsPopoverVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSRATEVO:Class = SessionStatsRateVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSTABVO:Class = SessionStatsTabVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSTANKINFOHEADERVO:Class = SessionStatsTankInfoHeaderVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSTANKINFOPARAMVO:Class = SessionStatsTankInfoParamVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONSTATSTANKSTATUSVO:Class = SessionStatsTankStatusVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONVEHICLESTATSRENDERERVO:Class = SessionVehicleStatsRendererVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_DATA_SESSIONVEHICLESTATSVIEWVO:Class = SessionVehicleStatsViewVO;

        public static const NET_WG_GUI_LOBBY_SESSIONSTATS_EVENTS_SESSIONSTATSPOPOVERRESIZEDEVENT:Class = SessionStatsPopoverResizedEvent;

        public static const NET_WG_GUI_LOBBY_SHOP20_CONTROLS_RENTALTERMSLOTBUTTON:Class = RentalTermSlotButton;

        public static const NET_WG_GUI_LOBBY_SHOP20_DATA_RENTALTERMSELECTIONPOPOVERVO:Class = RentalTermSelectionPopoverVO;

        public static const NET_WG_GUI_LOBBY_SHOP20_DATA_RENTALTERMSLOTBUTTONVO:Class = RentalTermSlotButtonVO;

        public static const NET_WG_GUI_LOBBY_SHOP20_DATA_VEHICLESELLCONFIRMATIONPOPOVERVO:Class = VehicleSellConfirmationPopoverVO;

        public static const NET_WG_GUI_LOBBY_SHOP20_POPOVERS_RENTALTERMSELECTIONPOPOVER:Class = RentalTermSelectionPopover;

        public static const NET_WG_GUI_LOBBY_SHOP20_POPOVERS_VEHICLESELLCONFIRMATIONPOPOVER:Class = VehicleSellConfirmationPopover;

        public static const NET_WG_GUI_LOBBY_STORAGE_STORAGEVIEW:Class = StorageView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BASECATEGORYVIEW:Class = BaseCategoryView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BASEFILTERBLOCK:Class = BaseFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_ICATEGORY:Class = ICategory;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_NOITEMSVIEW:Class = NoItemsView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGECAROUSEL:Class = StorageCarousel;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGEVEHICLEFILTERBLOCK:Class = StorageVehicleFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BLUEPRINTS_BLUEPRINTFRAGMENTRENDERER:Class = BlueprintFragmentRenderer;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BLUEPRINTS_BLUEPRINTFRAGMENTSBAR:Class = BlueprintFragmentsBar;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BLUEPRINTS_BLUEPRINTSFILTERBLOCK:Class = BlueprintsFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BLUEPRINTS_BLUEPRINTSNOITEMSVIEW:Class = BlueprintsNoItemsView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_BLUEPRINTS_STORAGECATEGORYBLUEPRINTSVIEW:Class = StorageCategoryBlueprintsView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_BASECARD:Class = BaseCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_BASECARDVO:Class = BaseCardVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_BLUEPRINTCARDVO:Class = BlueprintCardVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_BLUEPRINTSCARD:Class = BlueprintsCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_CARDEVENT:Class = CardEvent;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_CARDSIZECONFIG:Class = CardSizeConfig;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_CARDSIZEVO:Class = CardSizeVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_CUSTOMIZATIONCARD:Class = CustomizationCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_PERSONALRESERVESCARD:Class = PersonalReservesCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_RENTVEHICLECARD:Class = RentVehicleCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_RESTOREVEHICLECARD:Class = RestoreVehicleCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_SELECTABLECARD:Class = SelectableCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_VEHICLECARD:Class = VehicleCard;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CARDS_VEHICLECARDVO:Class = VehicleCardVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_CUSTOMIZATION_STORAGECATEGORYCUSTOMIZATIONVIEW:Class = StorageCategoryCustomizationView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_FORSELL_BUYBLOCK:Class = BuyBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_FORSELL_BUYBLOCKEVENT:Class = BuyBlockEvent;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_FORSELL_STORAGECATEGORYFORSELLVIEW:Class = StorageCategoryForSellView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_FORSELL_STORAGECATEGORYFORSELLVO:Class = StorageCategoryForSellVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_INHANGAR_ALLVEHICLESTABVIEW:Class = AllVehiclesTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_INHANGAR_INHANGARFILTERBLOCK:Class = InHangarFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_INHANGAR_RENTVEHICLESTABVIEW:Class = RentVehiclesTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_INHANGAR_RESTOREVEHICLESTABVIEW:Class = RestoreVehiclesTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_INHANGAR_STORAGECATEGORYINHANGARVIEW:Class = StorageCategoryInHangarView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_PERSONALRESERVES_ACTIVERESERVESBLOCK:Class = ActiveReservesBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_PERSONALRESERVES_PERSONALRESERVEFILTERBLOCK:Class = PersonalReserveFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_PERSONALRESERVES_STORAGECATEGORYPERSONALRESERVESVIEW:Class = StorageCategoryPersonalReservesView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_PERSONALRESERVES_STORAGECATEGORYPERSONALRESERVESVO:Class = StorageCategoryPersonalReservesVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_ITEMSWITHTYPEANDNATIONFILTERTABVIEW:Class = ItemsWithTypeAndNationFilterTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_ITEMSWITHTYPEFILTERTABVIEW:Class = ItemsWithTypeFilterTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_ITEMSWITHVEHICLEFILTERTABVIEW:Class = ItemsWithVehicleFilterTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_REGULARITEMSTABVIEW:Class = RegularItemsTabView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_STORAGECATEGORYSTORAGEVIEW:Class = StorageCategoryStorageView;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_STORAGETYPEANDNATIONFILTERBLOCK:Class = StorageTypeAndNationFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_STORAGETYPEANDVEHICLEFILTERBLOCK:Class = StorageTypeAndVehicleFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_STORAGETYPEFILTERBLOCK:Class = StorageTypeFilterBlock;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_VEHICLESELECTPOPOVER_STORAGEVEHICLESELECTPOPOVERVO:Class = StorageVehicleSelectPopoverVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_VEHICLESELECTPOPOVER_VEHICLESELECTORFILTER:Class = net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover.VehicleSelectorFilter;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_VEHICLESELECTPOPOVER_VEHICLESELECTPOPOVER:Class = VehicleSelectPopover;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_VEHICLESELECTPOPOVER_VEHICLESELECTPOPOVERITEMVO:Class = VehicleSelectPopoverItemVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_CATEGORIES_STORAGE_VEHICLESELECTPOPOVER_VEHICLESELECTRENDERER:Class = VehicleSelectRenderer;

        public static const NET_WG_GUI_LOBBY_STORAGE_DATA_BLUEPRINTSFRAGMENTVO:Class = BlueprintsFragmentVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_DATA_STORAGENATIONFILTERVO:Class = StorageNationFilterVO;

        public static const NET_WG_GUI_LOBBY_STORAGE_DATA_STORAGEVO:Class = StorageVO;

        public static const NET_WG_GUI_LOBBY_STORE_COMPLEXLISTITEMRENDERER:Class = ComplexListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_STORECOMPONENT:Class = StoreComponent;

        public static const NET_WG_GUI_LOBBY_STORE_STORECOMPONENTVIEWBASE:Class = StoreComponentViewBase;

        public static const NET_WG_GUI_LOBBY_STORE_STOREEVENT:Class = StoreEvent;

        public static const NET_WG_GUI_LOBBY_STORE_STOREFORM:Class = StoreForm;

        public static const NET_WG_GUI_LOBBY_STORE_STOREHELPER:Class = StoreHelper;

        public static const NET_WG_GUI_LOBBY_STORE_STORELIST:Class = StoreList;

        public static const NET_WG_GUI_LOBBY_STORE_STORELISTITEMRENDERER:Class = StoreListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_STORETABLE:Class = StoreTable;

        public static const NET_WG_GUI_LOBBY_STORE_STORETABLEDATAPROVIDER:Class = StoreTableDataProvider;

        public static const NET_WG_GUI_LOBBY_STORE_STOREVIEW:Class = StoreView;

        public static const NET_WG_GUI_LOBBY_STORE_STOREVIEWSEVENT:Class = StoreViewsEvent;

        public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADER:Class = TableHeader;

        public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADERINFO:Class = TableHeaderInfo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_STOREACTIONSCONTAINER:Class = StoreActionsContainer;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_STOREACTIONSEMPTY:Class = StoreActionsEmpty;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_STOREACTIONSVIEW:Class = StoreActionsView;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_ACTIONCARDSELECTFRAME:Class = ActionCardSelectFrame;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDABSTRACT:Class = StoreActionCardAbstract;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDBASE:Class = StoreActionCardBase;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDDESCRTABLEOFFERITEM:Class = StoreActionCardDescrTableOfferItem;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDHEADER:Class = StoreActionCardHeader;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDHERO:Class = StoreActionCardHero;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDNORMAL:Class = StoreActionCardNormal;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDSMALL:Class = StoreActionCardSmall;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCARDTITLE:Class = StoreActionCardTitle;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONCOMINGSOON:Class = StoreActionComingSoon;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONDESCR:Class = StoreActionDescr;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONDESCRTTC:Class = StoreActionDescrTTC;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_CARDS_STOREACTIONDISCOUNT:Class = StoreActionDiscount;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_CARDSETTINGS:Class = CardSettings;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_CARDSSETTINGS:Class = CardsSettings;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONCARDDESCRVO:Class = StoreActionCardDescrVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONCARDOFFERSITEMVO:Class = StoreActionCardOffersItemVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONCARDVO:Class = StoreActionCardVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONPICTUREVO:Class = StoreActionPictureVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONSCARDSVO:Class = StoreActionsCardsVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONSEMPTYVO:Class = StoreActionsEmptyVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONSVIEWVO:Class = StoreActionsViewVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_DATA_STOREACTIONTIMEVO:Class = StoreActionTimeVo;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_EVNTS_STOREACTIONSEVENT:Class = StoreActionsEvent;

        public static const NET_WG_GUI_LOBBY_STORE_ACTIONS_INTERFACES_ISTOREACTIONCARD:Class = IStoreActionCard;

        public static const NET_WG_GUI_LOBBY_STORE_DATA_BUTTONBARVO:Class = ButtonBarVO;

        public static const NET_WG_GUI_LOBBY_STORE_DATA_FILTERSDATAVO:Class = FiltersDataVO;

        public static const NET_WG_GUI_LOBBY_STORE_DATA_STORETOOLTIPMAPVO:Class = StoreTooltipMapVO;

        public static const NET_WG_GUI_LOBBY_STORE_DATA_STOREVIEWINITVO:Class = StoreViewInitVO;

        public static const NET_WG_GUI_LOBBY_STORE_EVNTS_STOREVIEWSTACKEVENT:Class = StoreViewStackEvent;

        public static const NET_WG_GUI_LOBBY_STORE_INTERFACES_ISTORETABLE:Class = IStoreTable;

        public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORY:Class = Inventory;

        public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYMODULELISTITEMRENDERER:Class = InventoryModuleListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYVEHICLELISTITEMRDR:Class = InventoryVehicleListItemRdr;

        public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_BASE_INVENTORYLISTITEMRENDERER:Class = InventoryListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOP:Class = Shop;

        public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPICONTEXT:Class = ShopIconText;

        public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPMODULELISTITEMRENDERER:Class = ShopModuleListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPVEHICLELISTITEMRENDERER:Class = ShopVehicleListItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_SHOP_BASE_SHOPTABLEITEMRENDERER:Class = ShopTableItemRenderer;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_ACTIONSFILTERVIEW:Class = ActionsFilterView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BATTLEBOOSTERVIEW:Class = BattleBoosterView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_EQUIPMENTVIEW:Class = EquipmentView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_INVENTORYVEHICLEVIEW:Class = InventoryVehicleView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_MODULEVIEW:Class = ModuleView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_OPTIONALDEVICEVIEW:Class = OptionalDeviceView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_SHELLVIEW:Class = ShellView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_SHOPVEHICLEVIEW:Class = ShopVehicleView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_VEHICLEVIEW:Class = VehicleView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_BASESTOREMENUVIEW:Class = BaseStoreMenuView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_FITSSELECTABLESTOREMENUVIEW:Class = FitsSelectableStoreMenuView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_SIMPLESTOREMENUVIEW:Class = SimpleStoreMenuView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_VIEWUIELEMENTVO:Class = ViewUIElementVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_INTERFACES_ISTOREMENUVIEW:Class = IStoreMenuView;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_EXTFITITEMSFILTERSVO:Class = ExtFitItemsFiltersVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_FILTERSVO:Class = FiltersVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_FITITEMSFILTERSVO:Class = FitItemsFiltersVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_SHOPVEHICLESFILTERSVO:Class = ShopVehiclesFiltersVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_TARGETTYPEFILTERSVO:Class = TargetTypeFiltersVO;

        public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_VEHICLESFILTERSVO:Class = VehiclesFiltersVO;

        public static const NET_WG_GUI_LOBBY_STRONGHOLD_STRONGHOLDCLANPROFILEVIEW:Class = StrongholdClanProfileView;

        public static const NET_WG_GUI_LOBBY_STRONGHOLD_STRONGHOLDLISTVIEW:Class = StrongholdListView;

        public static const NET_WG_GUI_LOBBY_STRONGHOLD_STRONGHOLDVIEW:Class = StrongholdView;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CAROUSELTANKMANSKILLSMODEL:Class = CarouselTankmanSkillsModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWTANKMANRETRAINING:Class = CrewTankmanRetraining;

        public static const NET_WG_GUI_LOBBY_TANKMAN_DROPSKILLSCOST:Class = DropSkillsCost;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASE:Class = PersonalCase;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBASE:Class = PersonalCaseBase;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKITEM:Class = PersonalCaseBlockItem;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKSAREA:Class = PersonalCaseBlocksArea;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKTITLE:Class = PersonalCaseBlockTitle;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASECREWSKINS:Class = PersonalCaseCrewSkins;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASECURRENTVEHICLE:Class = PersonalCaseCurrentVehicle;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCS:Class = PersonalCaseDocs;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCSMODEL:Class = PersonalCaseDocsModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEINPUTLIST:Class = PersonalCaseInputList;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEMODEL:Class = PersonalCaseModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASERETRAININGMODEL:Class = PersonalCaseRetrainingModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLMODEL:Class = PersonalCaseSkillModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLS:Class = PersonalCaseSkills;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSITEMRENDERER:Class = PersonalCaseSkillsItemRenderer;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSMODEL:Class = PersonalCaseSkillsModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESPECIALIZATION:Class = PersonalCaseSpecialization;

        public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESTATS:Class = PersonalCaseStats;

        public static const NET_WG_GUI_LOBBY_TANKMAN_RANKELEMENT:Class = RankElement;

        public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEITEM:Class = RoleChangeItem;

        public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEITEMS:Class = RoleChangeItems;

        public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEVEHICLESELECTION:Class = RoleChangeVehicleSelection;

        public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEWINDOW:Class = RoleChangeWindow;

        public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPMODEL:Class = SkillDropModel;

        public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPWINDOW:Class = SkillDropWindow;

        public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLITEMVIEWMINI:Class = SkillItemViewMini;

        public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLSITEMSRENDERERRANKICON:Class = SkillsItemsRendererRankIcon;

        public static const NET_WG_GUI_LOBBY_TANKMAN_TANKMANSKILLSINFOBLOCK:Class = TankmanSkillsInfoBlock;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VEHICLETYPEBUTTON:Class = VehicleTypeButton;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINNOITEMSINFO:Class = CrewSkinNoItemsInfo;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSBLOCK:Class = CrewSkinsBlock;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSITEMRENDERER:Class = CrewSkinsItemRenderer;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSMAINCONTAINER:Class = CrewSkinsMainContainer;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSOUNDINFO:Class = CrewSkinSoundInfo;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSTORAGEINFO:Class = CrewSkinStorageInfo;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_CREWSKINSWARNING:Class = CrewSkinsWarning;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_PERSONALCASECREWSKINSITEMRENDERER:Class = PersonalCaseCrewSkinsItemRenderer;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_MODEL_CREWSKINVO:Class = CrewSkinVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_CREWSKINS_MODEL_PERSONALCASECREWSKINSVO:Class = PersonalCaseCrewSkinsVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_PERSONALCASETABNAMEVO:Class = PersonalCaseTabNameVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_RETRAINBUTTONVO:Class = RetrainButtonVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_ROLECHANGEITEMVO:Class = RoleChangeItemVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_ROLECHANGEVO:Class = RoleChangeVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_TANKMANSKILLSINFOBLOCKVO:Class = TankmanSkillsInfoBlockVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_VEHICLESELECTIONITEMVO:Class = VehicleSelectionItemVO;

        public static const NET_WG_GUI_LOBBY_TANKMAN_VO_VEHICLESELECTIONVO:Class = VehicleSelectionVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_RESEARCHPAGE:Class = ResearchPage;

        public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEEVENT:Class = TechTreeEvent;

        public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEPAGE:Class = TechTreePage;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_ACTIONNAME:Class = ActionName;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_COLORINDEX:Class = ColorIndex;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODEENTITYTYPE:Class = NodeEntityType;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODERENDERERSTATE:Class = NodeRendererState;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_OUTLITERAL:Class = OutLiteral;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_TTINVALIDATIONTYPE:Class = TTInvalidationType;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_XPTYPESTRINGS:Class = XpTypeStrings;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_ACTIONBUTTON:Class = ActionButton;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_ANIMATEDTEXTBUTTON:Class = AnimatedTextButton;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_ANIMATEDTEXTLABEL:Class = AnimatedTextLabel;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BALANCECONTAINER:Class = BalanceContainer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BENEFITRENDERER:Class = BenefitRenderer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTBACKGROUND:Class = BlueprintBackground;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTBALANCE:Class = BlueprintBalance;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTBALANCEITEM:Class = BlueprintBalanceItem;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTBAR:Class = BlueprintBar;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTPROGRESSBAR:Class = BlueprintProgressBar;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_BLUEPRINTSMODESWITCHBUTTON:Class = BlueprintsModeSwitchButton;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_DISCOUNTBANNER:Class = DiscountBanner;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_EXPERIENCEBLOCK:Class = ExperienceBlock;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_FADECOMPONENT:Class = FadeComponent;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELDELIMITER:Class = LevelDelimiter;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELSCONTAINER:Class = LevelsContainer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONBUTTON:Class = NationButton;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONBUTTONSTATES:Class = NationButtonStates;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONFLAGCONTAINER:Class = NationFlagContainer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONSBUTTONBAR:Class = NationsButtonBar;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NODECOMPONENT:Class = NodeComponent;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_PREMIUMLAYOUT:Class = PremiumLayout;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RESEARCHROOTEXPERIENCE:Class = ResearchRootExperience;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RESEARCHROOTTITLE:Class = ResearchRootTitle;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_TECHTREETITLE:Class = TechTreeTitle;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_TYPEANDLEVELFIELD:Class = TypeAndLevelField;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_VEHICLEBUTTON:Class = VehicleButton;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_XPFIELD:Class = XPField;

        public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_XPICON:Class = XPIcon;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_ABSTRACTDATAPROVIDER:Class = AbstractDataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_BLUEPRINTBALANCEITEMVO:Class = BlueprintBalanceItemVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_BLUEPRINTBALANCEVO:Class = BlueprintBalanceVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_NATIONVODATAPROVIDER:Class = NationVODataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHPAGEVO:Class = ResearchPageVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHROOTVO:Class = ResearchRootVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHVODATAPROVIDER:Class = ResearchVODataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_ANIMATIONPROPERTIES:Class = AnimationProperties;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATECOLLECTION:Class = NodeStateCollection;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATEITEM:Class = NodeStateItem;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_STATEPROPERTIES:Class = StateProperties;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_UNLOCKEDSTATEITEM:Class = UnlockedStateItem;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_EXTRAINFORMATION:Class = ExtraInformation;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NATIONDISPLAYSETTINGS:Class = NationDisplaySettings;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NODEDATA:Class = NodeData;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NTDISPLAYINFO:Class = NTDisplayInfo;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_RESEARCHDISPLAYINFO:Class = ResearchDisplayInfo;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_UNLOCKPROPS:Class = UnlockProps;

        public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_VEHCOMPAREENTRYPOINTTREENODEVO:Class = VehCompareEntrypointTreeNodeVO;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_DISTANCE:Class = Distance;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_LINESGRAPHICS:Class = LinesGraphics;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_MODULESGRAPHICS:Class = ModulesGraphics;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NODEINDEXFILTER:Class = NodeIndexFilter;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NTGRAPHICS:Class = NTGraphics;

        public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_RESEARCHGRAPHICS:Class = ResearchGraphics;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IHASRENDERERASOWNER:Class = IHasRendererAsOwner;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INATIONTREEDATAPROVIDER:Class = INationTreeDataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INODESCONTAINER:Class = INodesContainer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INODESDATAPROVIDER:Class = INodesDataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRENDERER:Class = IRenderer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHCONTAINER:Class = IResearchContainer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHDATAPROVIDER:Class = IResearchDataProvider;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHPAGE:Class = IResearchPage;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_ITECHTREEPAGE:Class = ITechTreePage;

        public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IVALUEOBJECT:Class = IValueObject;

        public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_ADG_ITEMLEVELSBUILDER:Class = ADG_ItemLevelsBuilder;

        public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_HUNGARIANALGORITHM:Class = HungarianAlgorithm;

        public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_MATRIXPOSITION:Class = MatrixPosition;

        public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_MATRIXUTILS:Class = MatrixUtils;

        public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_FAKENODE:Class = FakeNode;

        public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_NATIONTREENODE:Class = NationTreeNode;

        public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RENDERER:Class = Renderer;

        public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RESEARCHITEM:Class = ResearchItem;

        public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RESEARCHROOT:Class = ResearchRoot;

        public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_MODULESTREE:Class = ModulesTree;

        public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_NATIONTREE:Class = NationTree;

        public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_RESEARCHITEMS:Class = ResearchItems;

        public static const NET_WG_GUI_LOBBY_TESTVIEW_TESTVIEW:Class = TestView;

        public static const NET_WG_GUI_LOBBY_TESTVIEW_GENERATED_MODELS_TESTVIEWMODEL:Class = net.wg.gui.lobby.testView.generated.models.TestViewModel;

        public static const NET_WG_GUI_LOBBY_TESTVIEW_GENERATED_MODELS_TEXTVIEWMODEL:Class = net.wg.gui.lobby.testView.generated.models.TextViewModel;

        public static const NET_WG_GUI_LOBBY_TESTVIEW_GENERATED_VIEWS_TESTVIEWBASE:Class = net.wg.gui.lobby.testView.generated.views.TestViewBase;

        public static const NET_WG_GUI_LOBBY_TRADEIN_TRADEOFFWIDGET:Class = TradeOffWidget;

        public static const NET_WG_GUI_LOBBY_TRADEIN_VO_TRADEOFFWIDGETVO:Class = TradeOffWidgetVO;

        public static const NET_WG_GUI_LOBBY_TRAINING_ARENAVOIPSETTINGS:Class = ArenaVoipSettings;

        public static const NET_WG_GUI_LOBBY_TRAINING_DRAGPLAYERELEMENT:Class = DragPlayerElement;

        public static const NET_WG_GUI_LOBBY_TRAINING_DRAGPLAYERELEMENTBASE:Class = DragPlayerElementBase;

        public static const NET_WG_GUI_LOBBY_TRAINING_DRAGPLAYERELEMENTEPIC:Class = DragPlayerElementEpic;

        public static const NET_WG_GUI_LOBBY_TRAINING_DROPLIST:Class = DropList;

        public static const NET_WG_GUI_LOBBY_TRAINING_DROPTILELIST:Class = DropTileList;

        public static const NET_WG_GUI_LOBBY_TRAINING_EPICBATTLETRAININGROOM:Class = EpicBattleTrainingRoom;

        public static const NET_WG_GUI_LOBBY_TRAINING_OBSERVERBUTTONCOMPONENT:Class = ObserverButtonComponent;

        public static const NET_WG_GUI_LOBBY_TRAINING_TOOLTIPVIEWER:Class = TooltipViewer;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGCONSTANTS:Class = TrainingConstants;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGCONTROLLER:Class = TrainingDragController;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGDELEGATE:Class = TrainingDragDelegate;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGFORM:Class = TrainingForm;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGLISTITEMRENDERER:Class = TrainingListItemRenderer;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGPLAYERITEMRENDERER:Class = TrainingPlayerItemRenderer;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGPLAYERITEMRENDERERBASE:Class = TrainingPlayerItemRendererBase;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGPLAYERITEMRENDEREREPIC:Class = TrainingPlayerItemRendererEpic;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGROOM:Class = TrainingRoom;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGROOMBASE:Class = TrainingRoomBase;

        public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGWINDOW:Class = TrainingWindow;

        public static const NET_WG_GUI_LOBBY_UNBOUNDINJECTWINDOW_GAMEFACETESTCOMPONENT:Class = GamefaceTestComponent;

        public static const NET_WG_GUI_LOBBY_UNBOUNDINJECTWINDOW_UNBOUNDINJECTWINDOW:Class = UnboundInjectWindow;

        public static const NET_WG_GUI_LOBBY_UNBOUNDINJECTWINDOW_UNBOUNDTESTCOMPONENT:Class = UnboundTestComponent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECARTITEMRENDERER:Class = VehicleCompareCartItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECARTPOPOVER:Class = VehicleCompareCartPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECOMMONVIEW:Class = VehicleCompareCommonView;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECONFIGURATORBASEVIEW:Class = VehicleCompareConfiguratorBaseView;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECONFIGURATORMAIN:Class = VehicleCompareConfiguratorMain;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECONFIGURATORVIEW:Class = VehicleCompareConfiguratorView;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPAREVIEW:Class = VehicleCompareView;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLEMODULESTREE:Class = VehicleModulesTree;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLEMODULESVIEW:Class = VehicleModulesView;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_CAMOUFLAGECHECKBOXBUTTON:Class = CamouflageCheckBoxButton;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_CLOSABLEEQUIPMENTSLOT:Class = ClosableEquipmentSlot;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_SKILLSFADE:Class = SkillsFade;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFBOTTOMPANEL:Class = VehConfBottomPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFCREW:Class = VehConfCrew;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFCREWSKILLSLOT:Class = VehConfCrewSkillSlot;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFEQUIPMENT:Class = VehConfEquipment;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFMODULES:Class = VehConfModules;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFMODULESBUTTON:Class = VehConfModulesButton;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFMODULESLOT:Class = VehConfModuleSlot;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFPARAMETERS:Class = VehConfParameters;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFPARAMRENDERER:Class = VehConfParamRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONFIGURATOR_VEHCONFSHELLBUTTON:Class = VehConfShellButton;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREADDVEHICLEPOPOVER:Class = VehicleCompareAddVehiclePopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREADDVEHICLERENDERER:Class = VehicleCompareAddVehicleRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREANIM:Class = VehicleCompareAnim;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREANIMRENDERER:Class = VehicleCompareAnimRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREVEHICLESELECTOR:Class = VehicleCompareVehicleSelector;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREBUBBLE:Class = VehCompareBubble;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARECREWDROPDOWNITEMRENDERER:Class = VehCompareCrewDropDownItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREGRIDLINE:Class = VehCompareGridLine;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREHEADER:Class = VehCompareHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREHEADERBACKGROUND:Class = VehCompareHeaderBackground;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREMAINPANEL:Class = VehCompareMainPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMRENDERER:Class = VehCompareParamRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMSDELTA:Class = VehCompareParamsDelta;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMSVIEWPORT:Class = VehCompareParamsViewPort;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETABLECONTENT:Class = VehCompareTableContent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETABLEGRID:Class = VehCompareTableGrid;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETANKCAROUSEL:Class = VehCompareTankCarousel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETOPPANEL:Class = VehCompareTopPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREVEHICLERENDERER:Class = VehCompareVehicleRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREVEHPARAMRENDERER:Class = VehCompareVehParamRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHPARAMSLISTDATAPROVIDER:Class = VehParamsListDataProvider;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHPARAMSSCROLLER:Class = VehParamsScroller;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPARECREWLEVELVO:Class = VehCompareCrewLevelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREDATAPROVIDER:Class = VehCompareDataProvider;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREHEADERVO:Class = VehCompareHeaderVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREPARAMSDELTAVO:Class = VehCompareParamsDeltaVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPARESTATICDATAVO:Class = VehCompareStaticDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREVEHICLEVO:Class = VehCompareVehicleVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCONFSKILLVO:Class = VehConfSkillVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREADDVEHICLEPOPOVERVO:Class = VehicleCompareAddVehiclePopoverVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREANIMVO:Class = VehicleCompareAnimVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECARTITEMVO:Class = VehicleCompareCartItemVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECARTPOPOVERINITDATAVO:Class = VehicleCompareCartPopoverInitDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECONFIGURATORINITDATAVO:Class = VehicleCompareConfiguratorInitDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECONFIGURATORVO:Class = VehicleCompareConfiguratorVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREVEHICLESELECTORITEMVO:Class = VehicleCompareVehicleSelectorItemVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHPARAMSDATAVO:Class = VehParamsDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_CLOSABLEEQUIPMENTSLOTEVENT:Class = ClosableEquipmentSlotEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREEVENT:Class = VehCompareEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREPARAMSLISTEVENT:Class = VehCompareParamsListEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPARESCROLLEVENT:Class = VehCompareScrollEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREVEHICLERENDEREREVENT:Class = VehCompareVehicleRendererEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREVEHPARAMRENDEREREVENT:Class = VehCompareVehParamRendererEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCONFEVENT:Class = VehConfEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCONFSHELLSLOTEVENT:Class = VehConfShellSlotEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCONFSKILLDROPDOWNEVENT:Class = VehConfSkillDropDownEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCONFSKILLEVENT:Class = VehConfSkillEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHICLECOMPARECARTEVENT:Class = VehicleCompareCartEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHICLEMODULEITEMEVENT:Class = VehicleModuleItemEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IMAINPANEL:Class = IMainPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_ITABLEGRIDLINE:Class = ITableGridLine;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_ITOPPANEL:Class = ITopPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IVEHCOMPAREVIEWHEADER:Class = IVehCompareViewHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IVEHPARAMRENDERER:Class = IVehParamRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULEITEMNODE:Class = ModuleItemNode;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULERENDERER:Class = ModuleRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULESROOTNODE:Class = ModulesRootNode;

        public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULESTREEDATAPROVIDER:Class = ModulesTreeDataProvider;

        public static const NET_WG_GUI_LOBBY_VEHICLECONGRATULATION_VEHICLECONGRATULATIONANIMATION:Class = VehicleCongratulationAnimation;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_BOTTOMPANEL:Class = BottomPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONFIRMCUSTOMIZATIONITEMDIALOG:Class = ConfirmCustomizationItemDialog;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONANCHORRENDERER:Class = CustomizationAnchorRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONANCHORSSET:Class = CustomizationAnchorsSet;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONANCHORSWITCHERS:Class = CustomizationAnchorSwitchers;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBILL:Class = CustomizationBill;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBUYCONTAINER:Class = CustomizationBuyContainer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBUYRENDERER:Class = CustomizationBuyRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBUYWINDOW:Class = CustomizationBuyWindow;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONCAROUSEL:Class = CustomizationCarousel;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONCAROUSELBOOKMARK:Class = CustomizationCarouselBookmark;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONCAROUSELLAYOUTCONTROLLER:Class = CustomizationCarouselLayoutController;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONDECALANCHORRENDERER:Class = CustomizationDecalAnchorRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONENDPOINTICON:Class = CustomizationEndPointIcon;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONFILTERSPOPOVER:Class = CustomizationFiltersPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONHEADER:Class = CustomizationHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONHELPER:Class = CustomizationHelper;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONITEMSPOPOVER:Class = CustomizationItemsPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONKITPOPOVER:Class = CustomizationKitPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONKITPOPOVERCONTENT:Class = CustomizationKitPopoverContent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONKITTABLE:Class = CustomizationKitTable;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONMAINVIEW:Class = CustomizationMainView;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONNONHISTORICICON:Class = CustomizationNonHistoricIcon;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONNOTIFICATION:Class = CustomizationNotification;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONPURCHASESLISTITEMRENDERER:Class = CustomizationPurchasesListItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSALERIBBON:Class = CustomizationSaleRibbon;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSEASONBUYRENDERER:Class = CustomizationSeasonBuyRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSHARED:Class = CustomizationShared;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSIMPLEANCHOR:Class = CustomizationSimpleAnchor;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSTYLEINFO:Class = CustomizationStyleInfo;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSTYLEINFOBLOCK:Class = CustomizationStyleInfoBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSTYLESCROLLCONTAINER:Class = CustomizationStyleScrollContainer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONTABNAVIGATOR:Class = CustomizationTabNavigator;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONTRIGGER:Class = CustomizationTrigger;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONTRIGGERBGDISABLE:Class = CustomizationTriggerBgDisable;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONVEHICLEVIEW:Class = CustomizationVehicleView;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_ICUSTOMIZATIONENDPOINTICON:Class = ICustomizationEndPointIcon;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_ISLOTSPANELRENDERER:Class = ISlotsPanelRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_ITEMBROWSERDISABLEOVERLAY:Class = ItemBrowserDisableOverlay;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_PROPERTYSHEETSEASONITEMPOPOVER:Class = PropertySheetSeasonItemPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_STYLEINFORENDERER:Class = StyleInfoRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELITEMRENDERER:Class = CarouselItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELRENDERERATTACHED:Class = CarouselRendererAttached;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELRENDERERATTACHEDBASE:Class = CarouselRendererAttachedBase;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELRENDERERATTACHEDDECAL:Class = CarouselRendererAttachedDecal;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CHECKBOXICON:Class = CheckBoxIcon;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CHECKBOXWITHLABEL:Class = CheckboxWithLabel;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CUSTOMIZATIONBONUSDELTA:Class = CustomizationBonusDelta;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CUSTOMIZATIONITEMICONRENDERER:Class = CustomizationItemIconRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CUSTOMIZATIONPOPOVERITEMRENDERER:Class = CustomizationPopoverItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CUSTOMIZATIONPOPOVERKITRENDERER:Class = CustomizationPopoverKitRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CUSTOMIZATIONRADIALBUTTON:Class = CustomizationRadialButton;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_FILTERCOUNTERTFCONTAINER:Class = FilterCounterTFContainer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_HISTORICINDICATOR:Class = HistoricIndicator;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_ITEMSLOT:Class = ItemSlot;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PRICEITEMRENDERER:Class = PriceItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PURCHASETABLERENDERER:Class = PurchaseTableRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_RADIOBUTTONLISTSELECTIONNAVIGATOR:Class = RadioButtonListSelectionNavigator;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_RADIORENDERER:Class = RadioRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_BOTTOMPANEL_CUSTOMIZATIONBOTTOMPANELTABBAR:Class = CustomizationBottomPanelTabBar;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_BOTTOMPANEL_CUSTOMIZATIONBOTTOMPANELTABBUTTON:Class = CustomizationBottomPanelTabButton;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_BOTTOMPANEL_CUSTOMIZATIONCAROUSELOVERLAY:Class = CustomizationCarouselOverlay;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_MAGNETICTOOL_IMAGNETICCLICKHANDLER:Class = IMagneticClickHandler;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_MAGNETICTOOL_MAGNETICTOOLCONTROLLER:Class = MagneticToolController;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEET:Class = CustomizationPropertiesSheet;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETBASEBTNRENDERER:Class = CustomizationSheetBaseBtnRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETBTNRENDERER:Class = CustomizationSheetBtnRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETCONTENTRENDERER:Class = CustomizationSheetContentRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETELEMENTCONTROLS:Class = CustomizationSheetElementControls;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETICONANIMATED:Class = CustomizationSheetIconAnimated;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETPROJECTIONBTN:Class = CustomizationSheetProjectionBtn;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETPROJECTIONCONTROLS:Class = CustomizationSheetProjectionControls;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETRENDERERBASE:Class = CustomizationSheetRendererBase;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETSCALECOLORSRENDERER:Class = CustomizationSheetScaleColorsRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETSTYLEITEMRENDERER:Class = CustomizationSheetStyleItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_CUSTOMIZATIONSHEETSWITCHRENDERER:Class = CustomizationSheetSwitchRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_TEXTFIELDANIMATED:Class = TextFieldAnimated;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_INSCRIPTIONCONTROLLER_CUSTOMIZATIONHINTIMAGEWRAPPER:Class = CustomizationHintImageWrapper;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_INSCRIPTIONCONTROLLER_CUSTOMIZATIONINSCRIPTIONCONTROLLER:Class = CustomizationInscriptionController;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PROPERTIESSHEET_INSCRIPTIONCONTROLLER_CUSTOMIZATIONINSCRIPTIONHINT:Class = CustomizationInscriptionHint;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SEASONBAR_CUSTOMIZAIONSEASONSBAR:Class = CustomizaionSeasonsBar;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SEASONBAR_CUSTOMIZATIONSEASONBGANIMATION:Class = CustomizationSeasonBGAnimation;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SEASONBAR_CUSTOMIZATIONSEASONRENDERER:Class = CustomizationSeasonRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SEASONBAR_CUSTOMIZATIONSEASONRENDERERANIMATION:Class = CustomizationSeasonRendererAnimation;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SLOT_CUSTOMIZATIONSLOTBASE:Class = CustomizationSlotBase;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SLOTSGROUP_CUSTOMIZATIONSLOTSLAYOUT:Class = CustomizationSlotsLayout;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_SLOTSGROUP_ICUSTOMIZATIONSLOT:Class = ICustomizationSlot;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_BOTTOMPANELBILLVO:Class = BottomPanelBillVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_BOTTOMPANELVO:Class = BottomPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CONFIRMCUSTOMIZATIONITEMDIALOGVO:Class = ConfirmCustomizationItemDialogVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONANCHORIDVO:Class = CustomizationAnchorIdVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONANCHORINITVO:Class = CustomizationAnchorInitVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONANCHORPOSITIONVO:Class = CustomizationAnchorPositionVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONANCHORSSETVO:Class = CustomizationAnchorsSetVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONANCHORSSTATEVO:Class = CustomizationAnchorsStateVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONBOTTOMPANELINITVO:Class = CustomizationBottomPanelInitVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONBOTTOMPANELNOTIFICATIONVO:Class = CustomizationBottomPanelNotificationVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONHEADERVO:Class = CustomizationHeaderVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONITEMICONRENDERERVO:Class = CustomizationItemIconRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONITEMPOPOVERHEADERVO:Class = CustomizationItemPopoverHeaderVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPOPOVERITEMRENDERERVO:Class = CustomizationPopoverItemRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPOPOVERKITRENDERERVO:Class = CustomizationPopoverKitRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPURCHASESPOPOVERINITVO:Class = CustomizationPurchasesPopoverInitVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPURCHASESPOPOVERVO:Class = CustomizationPurchasesPopoverVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONRADIORENDERERVO:Class = CustomizationRadioRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONSLOTIDVO:Class = CustomizationSlotIdVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONSLOTUPDATEVO:Class = CustomizationSlotUpdateVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONSWITCHERVO:Class = CustomizationSwitcherVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONTABBUTTONVO:Class = CustomizationTabButtonVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONTABNAVIGATORVO:Class = CustomizationTabNavigatorVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMZIATIONANCHORSTATEVO:Class = CustomziationAnchorStateVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_FILTERSPOPOVERVO:Class = FiltersPopoverVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_FILTERSSTATEVO:Class = FiltersStateVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_HISTORICINDICATORVO:Class = HistoricIndicatorVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_ITEMBROWSERTABSTATEVO:Class = ItemBrowserTabStateVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PRICERENDERERVO:Class = PriceRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_SMALLSLOTVO:Class = SmallSlotVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONBONUSDELTAVO:Class = CustomizationBonusDeltaVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELBOOKMARKVO:Class = CustomizationCarouselBookmarkVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELDATAVO:Class = CustomizationCarouselDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELFILTERVO:Class = CustomizationCarouselFilterVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELRENDERERVO:Class = CustomizationCarouselRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONITEMVO:Class = net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationItemVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_INSCRIPTIONCONTROLLER_CUSTOMIZATIONIMAGEVO:Class = CustomizationImageVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_INSCRIPTIONCONTROLLER_CUSTOMIZATIONINSCRIPTIONHINTVO:Class = CustomizationInscriptionHintVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEETBUTTONSBLOCKVO:Class = CustomizationPropertiesSheetButtonsBlockVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEETBUTTONSRENDERERVO:Class = CustomizationPropertiesSheetButtonsRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEETRENDERERVO:Class = CustomizationPropertiesSheetRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEETSTYLERENDERERVO:Class = CustomizationPropertiesSheetStyleRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PROPERTIESSHEET_CUSTOMIZATIONPROPERTIESSHEETVO:Class = CustomizationPropertiesSheetVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_BUYWINDOWTITTLESVO:Class = BuyWindowTittlesVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_CUSTOMIZATIONBUYWINDOWDATAVO:Class = CustomizationBuyWindowDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_INITBUYWINDOWVO:Class = InitBuyWindowVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASESPOPOVERRENDERERVO:Class = PurchasesPopoverRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASESTOTALVO:Class = PurchasesTotalVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASEVO:Class = PurchaseVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_SEASONBAR_CUSTOMIZATIONSEASONBARRENDERERVO:Class = CustomizationSeasonBarRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_STYLEINFO_BUYBTNVO:Class = BuyBtnVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_STYLEINFO_PARAMREVDERERVO:Class = ParamRevdererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_STYLEINFO_STYLEINFOVO:Class = StyleInfoVO;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONANCHOREVENT:Class = CustomizationAnchorEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONANCHORSETEVENT:Class = CustomizationAnchorSetEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONCAROUSELSCROLLEVENT:Class = CustomizationCarouselScrollEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONEVENT:Class = CustomizationEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONINDICATOREVENT:Class = CustomizationIndicatorEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONITEMEVENT:Class = CustomizationItemEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONITEMSWITCHEVENT:Class = CustomizationItemSwitchEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONSOUNDEVENT:Class = CustomizationSoundEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONSTYLEINFOEVENT:Class = CustomizationStyleInfoEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONTABEVENT:Class = CustomizationTabEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_PROPERTIESSHEET_CUSTOMIZATIONSHEETRENDEREREVENT:Class = CustomizationSheetRendererEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_PROPERTIESSHEET_PROJECTIONCONTROLSEVENT:Class = ProjectionControlsEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_TOOLTIPS_INBLOCKS_BLOCKS_IMAGEBLOCKNONHISTORICAL:Class = ImageBlockNonHistorical;

        public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_TOOLTIPS_INBLOCKS_DATA_CUSTOMIZATIONIMAGEBLOCKVO:Class = CustomizationImageBlockVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEHITAREA_LOBBYVEHICLEHITAREA:Class = LobbyVehicleHitArea;

        public static const NET_WG_GUI_LOBBY_VEHICLEHITAREA_VEHICLEHITAREA:Class = VehicleHitArea;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_BASEBLOCK:Class = BaseBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_CREWBLOCK:Class = CrewBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_IVEHICLEINFOBLOCK:Class = IVehicleInfoBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_PROPBLOCK:Class = PropBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFO:Class = VehicleInfo;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOBASE:Class = VehicleInfoBase;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOCREW:Class = VehicleInfoCrew;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOPROPS:Class = VehicleInfoProps;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOVIEWCONTENT:Class = VehicleInfoViewContent;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHCOMPAREBUTTONDATAVO:Class = VehCompareButtonDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFOBUTTONDATAVO:Class = VehicleInfoButtonDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFOCREWBLOCKVO:Class = VehicleInfoCrewBlockVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFODATAVO:Class = VehicleInfoDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFOPROPBLOCKVO:Class = VehicleInfoPropBlockVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_VEHICLEPREVIEW:Class = VehiclePreview;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWBOTTOMPANEL:Class = VehPreviewBottomPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWBUYINGPANEL:Class = VehPreviewBuyingPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWCREWINFO:Class = VehPreviewCrewInfo;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWCREWLISTRENDERER:Class = VehPreviewCrewListRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWELITEFACTSHEET:Class = VehPreviewEliteFactSheet;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWFACTSHEET:Class = VehPreviewFactSheet;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWHEADER:Class = VehPreviewHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOPANEL:Class = VehPreviewInfoPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOPANELTAB:Class = VehPreviewInfoPanelTab;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOTABBUTTON:Class = VehPreviewInfoTabButton;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOVIEWSTACK:Class = VehPreviewInfoViewStack;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWBOTTOMPANELVO:Class = VehPreviewBottomPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWBUYINGPANELDATAVO:Class = VehPreviewBuyingPanelDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWCREWINFOVO:Class = VehPreviewCrewInfoVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWCREWLISTRENDERERVO:Class = VehPreviewCrewListRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWELITEFACTSHEETVO:Class = VehPreviewEliteFactSheetVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWFACTSHEETVO:Class = VehPreviewFactSheetVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWHEADERVO:Class = VehPreviewHeaderVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWINFOPANELVO:Class = VehPreviewInfoPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWSTATICDATAVO:Class = VehPreviewStaticDataVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_EVENTS_VEHPREVIEWEVENT:Class = VehPreviewEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_EVENTS_VEHPREVIEWINFOPANELEVENT:Class = VehPreviewInfoPanelEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWBOTTOMPANEL:Class = IVehPreviewBottomPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWBUYINGPANEL:Class = IVehPreviewBuyingPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWHEADER:Class = IVehPreviewHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWINFOPANEL:Class = IVehPreviewInfoPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWINFOPANELTAB:Class = IVehPreviewInfoPanelTab;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_COMPAREBLOCK:Class = CompareBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_VEHICLEBASEPREVIEWPAGE:Class = VehicleBasePreviewPage;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_VEHICLEPREVIEW20EVENT:Class = VehiclePreview20Event;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_VEHICLEPREVIEW20PAGE:Class = VehiclePreview20Page;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_ADDITIONALINFO_VPADDITIONALINFOPANEL:Class = VPAdditionalInfoPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_COMPENSATIONPANEL:Class = CompensationPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_COUPONRENDERER:Class = CouponRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_COUPONVIEW:Class = CouponView;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_IVPBOTTOMPANEL:Class = IVPBottomPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_OFFERRENDERER:Class = OfferRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_OFFERSVIEW:Class = OffersView;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_SETITEMRENDERER:Class = SetItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_SETITEMSBLOCK:Class = SetItemsBlock;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_SETITEMSVIEW:Class = SetItemsView;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_SETVEHICLESRENDERER:Class = SetVehiclesRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_SETVEHICLESVIEW:Class = SetVehiclesView;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_VPBUYINGPANEL:Class = VPBuyingPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_VPFRONTLINEBUYINGPANEL:Class = VPFrontlineBuyingPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_VPSCROLLCAROUSEL:Class = VPScrollCarousel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_BUYINGPANEL_VPTRADEINBUYINGPANEL:Class = VPTradeInBuyingPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPADDITIONALINFOVO:Class = VPAdditionalInfoVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPBUYINGPANELVO:Class = VPBuyingPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPCOMPENSATIONVO:Class = VPCompensationVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPCOUPONVO:Class = VPCouponVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPCUSTOMOFFERVO:Class = VPCustomOfferVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPFRONTLINEBUYINGPANELVO:Class = VPFrontlineBuyingPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPOFFERVO:Class = VPOfferVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPPACKITEMVO:Class = VPPackItemVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPPAGEBASEVO:Class = VPPageBaseVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPPAGEVO:Class = VPPageVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPSETITEMSBLOCKVO:Class = VPSetItemsBlockVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPSETITEMSVO:Class = VPSetItemsVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPSETITEMVO:Class = VPSetItemVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPSETVEHICLESVO:Class = VPSetVehiclesVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPSTYLEBTNVO:Class = VPStyleBtnVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPTRADEINBUYINGPANELVO:Class = VPTradeInBuyingPanelVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_DATA_VPVEHICLECAROUSELVO:Class = VPVehicleCarouselVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_VPINFOPANEL:Class = VPInfoPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_BROWSE_VPBROWSETAB:Class = VPBrowseTab;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_BROWSE_VPKPIITEMRENDERER:Class = VPKPIItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_CREW_COMMONSKILLRENDERER:Class = CommonSkillRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_CREW_VPCREWRENDERER:Class = VPCrewRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_CREW_VPCREWRENDERERVO:Class = VPCrewRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_CREW_VPCREWTAB:Class = VPCrewTab;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_CREW_VPCREWTABVO:Class = VPCrewTabVO;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_MODULES_VPMODULESPANEL:Class = VPModulesPanel;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_INFOPANEL_MODULES_VPMODULESTAB:Class = VPModulesTab;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_PACKITEMSPOPOVER_PACKITEMRENDERER:Class = PackItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW20_PACKITEMSPOPOVER_PACKITEMSPOPOVER:Class = PackItemsPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VEHICLEBUYWINDOW:Class = VehicleBuyWindow;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_EV_VEHICLEBUYEVENT:Class = VehicleBuyEvent;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_INTERFACES_IVEHICLEBUYVIEW:Class = IVehicleBuyView;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_POPOVER_TRADEINITEMRENDERER:Class = TradeInItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_POPOVER_TRADEINPOPOVER:Class = TradeInPopover;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_POPOVER_TRADEINRENDERERVO:Class = TradeInRendererVO;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_POPOVER_TRADEINVO:Class = TradeInVO;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VIEWS_CONTENTBUYTRADEINCONTAINER:Class = ContentBuyTradeInContainer;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VIEWS_CONTENTBUYTRADINVIEW:Class = ContentBuyTradInView;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VIEWS_CONTENTBUYVIEW:Class = ContentBuyView;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VIEWS_CONTENTBUYVIEWBASE:Class = ContentBuyViewBase;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_TRADEOFFVEHICLEVO:Class = TradeOffVehicleVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYCONTENTVO:Class = VehicleBuyContentVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYHEADERVO:Class = VehicleBuyHeaderVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYRENTITEMVO:Class = VehicleBuyRentItemVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYSTUDYVO:Class = VehicleBuyStudyVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYSUBMITVO:Class = VehicleBuySubmitVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYTRADEOFFVO:Class = VehicleBuyTradeOffVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_BUY_VO_VEHICLEBUYVO:Class = VehicleBuyVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_CPMTS_CONFIRMATIONINPUT:Class = ConfirmationInput;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_CPMTS_VEHICLETRADEHEADER:Class = VehicleTradeHeader;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_CONTROLQUESTIONCOMPONENT:Class = ControlQuestionComponent;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_MOVINGRESULT:Class = MovingResult;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SALEITEMBLOCKRENDERER:Class = SaleItemBlockRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SELLDEVICESCOMPONENT:Class = SellDevicesComponent;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SELLDEVICESCONTENTCONTAINER:Class = SellDevicesContentContainer;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SELLDIALOGLISTITEMRENDERER:Class = SellDialogListItemRenderer;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SELLHEADERCOMPONENT:Class = SellHeaderComponent;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SELLSLIDINGCOMPONENT:Class = SellSlidingComponent;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SETTINGSBUTTON:Class = SettingsButton;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_SLIDINGSCROLLINGLIST:Class = SlidingScrollingList;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_TOTALRESULT:Class = TotalResult;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_USERINPUTCONTROL:Class = UserInputControl;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VEHICLESELLDIALOG:Class = VehicleSellDialog;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLDIALOGVO:Class = SellDialogVO;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLININVENTORYMODULEVO:Class = SellInInventoryModuleVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLININVENTORYSHELLVO:Class = SellInInventoryShellVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLONVEHICLEEQUIPMENTVO:Class = SellOnVehicleEquipmentVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLONVEHICLEOPTIONALDEVICEVO:Class = SellOnVehicleOptionalDeviceVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLONVEHICLESHELLVO:Class = SellOnVehicleShellVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLVEHICLEITEMBASEVO:Class = SellVehicleItemBaseVo;

        public static const NET_WG_GUI_LOBBY_VEHICLETRADEWNDS_SELL_VO_SELLVEHICLEVO:Class = SellVehicleVo;

        public static const NET_WG_GUI_LOBBY_WGNC_WGNCDIALOG:Class = WGNCDialog;

        public static const NET_WG_GUI_LOBBY_WGNC_WGNCPOLLWINDOW:Class = WGNCPollWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_AWARDWINDOW:Class = AwardWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_BASEEXCHANGEWINDOW:Class = BaseExchangeWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_BASEEXCHANGEWINDOWRATEVO:Class = BaseExchangeWindowRateVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_BOOSTERBUYCONTENT:Class = BoosterBuyContent;

        public static const NET_WG_GUI_LOBBY_WINDOW_BOOSTERBUYWINDOW:Class = BoosterBuyWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_BOOSTERINFO:Class = BoosterInfo;

        public static const NET_WG_GUI_LOBBY_WINDOW_BOOSTERSWINDOW:Class = BoostersWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_BROWSERWINDOW:Class = BrowserWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMEXCHANGEBLOCK:Class = ConfirmExchangeBlock;

        public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMEXCHANGEDIALOG:Class = ConfirmExchangeDialog;

        public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOW:Class = ConfirmItemWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOWBASEVO:Class = ConfirmItemWindowBaseVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOWVO:Class = ConfirmItemWindowVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_CRYSTALSPROMOWINDOW:Class = CrystalsPromoWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_EPICPRIMETIME:Class = EpicPrimeTime;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGECURRENCYWINDOW:Class = ExchangeCurrencyWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANINITVO:Class = ExchangeFreeToTankmanInitVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWARNING:Class = ExchangeFreeToTankmanXpWarning;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWINDOW:Class = ExchangeFreeToTankmanXpWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEHEADER:Class = ExchangeHeader;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEHEADERVO:Class = ExchangeHeaderVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEUTILS:Class = ExchangeUtils;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEWINDOW:Class = ExchangeWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPFROMVEHICLEIR:Class = ExchangeXPFromVehicleIR;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPLIST:Class = ExchangeXPList;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPTANKMANSKILLSMODEL:Class = ExchangeXPTankmanSkillsModel;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPVEHICLEVO:Class = ExchangeXPVehicleVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWARNINGSCREEN:Class = ExchangeXPWarningScreen;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWINDOW:Class = ExchangeXPWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWINDOWVO:Class = ExchangeXPWindowVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_IEXCHANGEHEADER:Class = IExchangeHeader;

        public static const NET_WG_GUI_LOBBY_WINDOW_MISSIONAWARDWINDOW:Class = MissionAwardWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_MODULEINFO:Class = ModuleInfo;

        public static const NET_WG_GUI_LOBBY_WINDOW_PRIMETIME:Class = PrimeTime;

        public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOW:Class = ProfileWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOWINITVO:Class = ProfileWindowInitVO;

        public static const NET_WG_GUI_LOBBY_WINDOW_PROMOPREMIUMIGRWINDOW:Class = PromoPremiumIgrWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_PUNISHMENTDIALOG:Class = PunishmentDialog;

        public static const NET_WG_GUI_LOBBY_WINDOW_PVESANDBOXQUEUEWINDOW:Class = PvESandboxQueueWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_RANKEDPRIMETIME:Class = RankedPrimeTime;

        public static const NET_WG_GUI_LOBBY_WINDOW_SWITCHPERIPHERYWINDOW:Class = SwitchPeripheryWindow;

        public static const NET_WG_GUI_LOBBY_WINDOW_VCOINEXCHANGEDATAVO:Class = VcoinExchangeDataVO;

        public static const NET_WG_GUI_LOGIN_IFORMBASEVO:Class = IFormBaseVo;

        public static const NET_WG_GUI_LOGIN_ILOGINFORM:Class = ILoginForm;

        public static const NET_WG_GUI_LOGIN_ILOGINFORMVIEW:Class = ILoginFormView;

        public static const NET_WG_GUI_LOGIN_IRSSNEWSFEEDRENDERER:Class = IRssNewsFeedRenderer;

        public static const NET_WG_GUI_LOGIN_ISPARKSMANAGER:Class = ISparksManager;

        public static const NET_WG_GUI_LOGIN_EULA_EULADLG:Class = EULADlg;

        public static const NET_WG_GUI_LOGIN_EULA_EULAFULLDLG:Class = EULAFullDlg;

        public static const NET_WG_GUI_LOGIN_IMPL_ERRORSTATES:Class = ErrorStates;

        public static const NET_WG_GUI_LOGIN_IMPL_LOGINPAGE:Class = LoginPage;

        public static const NET_WG_GUI_LOGIN_IMPL_LOGINQUEUEWINDOW:Class = LoginQueueWindow;

        public static const NET_WG_GUI_LOGIN_IMPL_LOGINVIEWSTACK:Class = LoginViewStack;

        public static const NET_WG_GUI_LOGIN_IMPL_RUDIMENTARYSWFONLOGINCHECKINGHELPER:Class = RudimentarySwfOnLoginCheckingHelper;

        public static const NET_WG_GUI_LOGIN_IMPL_SPARK:Class = Spark;

        public static const NET_WG_GUI_LOGIN_IMPL_SPARKSMANAGER:Class = SparksManager;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_CAPSLOCKINDICATOR:Class = CapsLockIndicator;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_COPYRIGHT:Class = Copyright;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_COPYRIGHTEVENT:Class = CopyrightEvent;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_LOGINIGRWARNING:Class = LoginIgrWarning;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSITEMEVENT:Class = RssItemEvent;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSNEWSFEED:Class = RssNewsFeed;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSNEWSFEEDRENDERER:Class = RssNewsFeedRenderer;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALGROUP:Class = SocialGroup;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALICONSLIST:Class = SocialIconsList;

        public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALITEMRENDERER:Class = SocialItemRenderer;

        public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINEVENT:Class = LoginEvent;

        public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINEVENTTEXTLINK:Class = LoginEventTextLink;

        public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINSERVERDDEVENT:Class = LoginServerDDEvent;

        public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINVIEWSTACKEVENT:Class = LoginViewStackEvent;

        public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_FILLEDLOGINFORM:Class = FilledLoginForm;

        public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_LOGINFORMVIEW:Class = LoginFormView;

        public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_SIMPLEFORM:Class = SimpleForm;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_FILLEDLOGINFORMVO:Class = FilledLoginFormVo;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_FORMBASEVO:Class = FormBaseVo;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_RSSITEMVO:Class = RssItemVo;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_SIMPLEFORMVO:Class = SimpleFormVo;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_SOCIALICONVO:Class = SocialIconVo;

        public static const NET_WG_GUI_LOGIN_IMPL_VO_SUBMITDATAVO:Class = SubmitDataVo;

        public static const NET_WG_GUI_LOGIN_LEGAL_LEGALCONTENT:Class = LegalContent;

        public static const NET_WG_GUI_LOGIN_LEGAL_LEGALINFOWINDOW:Class = LegalInfoWindow;

        public static const NET_WG_GUI_MESSENGER_CHANNELCOMPONENT:Class = ChannelComponent;

        public static const NET_WG_GUI_MESSENGER_CONTACTSLISTPOPOVER:Class = ContactsListPopover;

        public static const NET_WG_GUI_MESSENGER_ICHANNELCOMPONENT:Class = IChannelComponent;

        public static const NET_WG_GUI_MESSENGER_SMILEYMAP:Class = SmileyMap;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_BASECONTACTSSCROLLINGLIST:Class = BaseContactsScrollingList;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CHANNELITEMRENDERER:Class = ChannelItemRenderer;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTATTRIBUTESGROUP:Class = ContactAttributesGroup;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTGROUPITEM:Class = ContactGroupItem;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTITEM:Class = ContactItem;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTITEMRENDERER:Class = ContactItemRenderer;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTLISTHEADERCHECKBOX:Class = ContactListHeaderCheckBox;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSBASEDROPLISTDELEGATE:Class = ContactsBaseDropListDelegate;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSBTNBAR:Class = ContactsBtnBar;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSCROLLINGLIST:Class = ContactScrollingList;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSDROPLISTDELEGATE:Class = ContactsDropListDelegate;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTBASECONTROLLER:Class = ContactsListBaseController;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTDRAGDROPDELEGATE:Class = ContactsListDragDropDelegate;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTDTAGCONTROLLER:Class = ContactsListDtagController;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTHIGHLIGHTAREA:Class = ContactsListHighlightArea;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTITEMRENDERER:Class = ContactsListItemRenderer;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTSELECTIONNAVIGATOR:Class = ContactsListSelectionNavigator;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSTREECOMPONENT:Class = ContactsTreeComponent;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSTREEITEMRENDERER:Class = ContactsTreeItemRenderer;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSWINDOWVIEWBG:Class = ContactsWindowViewBG;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_DASHEDHIGHLIGHTAREA:Class = DashedHighlightArea;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_EMPTYHIGHLIGHTAREA:Class = EmptyHighlightArea;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_IMGDROPLISTDELEGATE:Class = ImgDropListDelegate;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_INFOMESSAGEVIEW:Class = InfoMessageView;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_MAINGROUPITEM:Class = MainGroupItem;

        public static const NET_WG_GUI_MESSENGER_CONTROLS_MEMBERITEMRENDERER:Class = MemberItemRenderer;

        public static const NET_WG_GUI_MESSENGER_DATA_CHANNELMEMBERVO:Class = ChannelMemberVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTEVENT:Class = ContactEvent;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTITEMVO:Class = ContactItemVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTLISTMAININFO:Class = ContactListMainInfo;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSCONSTANTS:Class = ContactsConstants;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSGROUPEVENT:Class = ContactsGroupEvent;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSLISTGROUPVO:Class = ContactsListGroupVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSLISTTREEITEMINFO:Class = ContactsListTreeItemInfo;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSETTINGSDATAVO:Class = ContactsSettingsDataVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSETTINGSVIEWINITDATAVO:Class = ContactsSettingsViewInitDataVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSHARED:Class = ContactsShared;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSTREEDATAPROVIDER:Class = ContactsTreeDataProvider;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSVIEWINITDATAVO:Class = ContactsViewInitDataVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSWINDOWINITVO:Class = ContactsWindowInitVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTUSERPROPVO:Class = ContactUserPropVO;

        public static const NET_WG_GUI_MESSENGER_DATA_CONTACTVO:Class = ContactVO;

        public static const NET_WG_GUI_MESSENGER_DATA_EXTCONTACTSVIEWINITVO:Class = ExtContactsViewInitVO;

        public static const NET_WG_GUI_MESSENGER_DATA_GROUPRULESVO:Class = GroupRulesVO;

        public static const NET_WG_GUI_MESSENGER_DATA_ICONTACTITEMRENDERER:Class = IContactItemRenderer;

        public static const NET_WG_GUI_MESSENGER_DATA_ITREEITEMINFO:Class = ITreeItemInfo;

        public static const NET_WG_GUI_MESSENGER_DATA_TREEDAAPIDATAPROVIDER:Class = TreeDAAPIDataProvider;

        public static const NET_WG_GUI_MESSENGER_DATA_TREEITEMINFO:Class = TreeItemInfo;

        public static const NET_WG_GUI_MESSENGER_EVNTS_CHANNELSFORMEVENT:Class = ChannelsFormEvent;

        public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSFORMEVENT:Class = ContactsFormEvent;

        public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSSCROLLINGLISTEVENT:Class = ContactsScrollingListEvent;

        public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSTREEEVENT:Class = ContactsTreeEvent;

        public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSCREATEFORM:Class = ChannelsCreateForm;

        public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSSEARCHFORM:Class = ChannelsSearchForm;

        public static const NET_WG_GUI_MESSENGER_FORMS_CONTACTSSEARCHFORM:Class = ContactsSearchForm;

        public static const NET_WG_GUI_MESSENGER_META_IBASECONTACTVIEWMETA:Class = IBaseContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IBASEMANAGECONTACTVIEWMETA:Class = IBaseManageContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICHANNELCOMPONENTMETA:Class = IChannelComponentMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICHANNELSMANAGEMENTWINDOWMETA:Class = IChannelsManagementWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICHANNELWINDOWMETA:Class = IChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICONNECTTOSECURECHANNELWINDOWMETA:Class = IConnectToSecureChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICONTACTNOTEMANAGEVIEWMETA:Class = IContactNoteManageViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICONTACTSLISTPOPOVERMETA:Class = IContactsListPopoverMeta;

        public static const NET_WG_GUI_MESSENGER_META_ICONTACTSSETTINGSVIEWMETA:Class = IContactsSettingsViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IFAQWINDOWMETA:Class = IFAQWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IGROUPDELETEVIEWMETA:Class = IGroupDeleteViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_ILOBBYCHANNELWINDOWMETA:Class = ILobbyChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_ISEARCHCONTACTVIEWMETA:Class = ISearchContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_BASECONTACTVIEWMETA:Class = BaseContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_BASEMANAGECONTACTVIEWMETA:Class = BaseManageContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELCOMPONENTMETA:Class = ChannelComponentMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELSMANAGEMENTWINDOWMETA:Class = ChannelsManagementWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELWINDOWMETA:Class = ChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CONNECTTOSECURECHANNELWINDOWMETA:Class = ConnectToSecureChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTNOTEMANAGEVIEWMETA:Class = ContactNoteManageViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSLISTPOPOVERMETA:Class = ContactsListPopoverMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSSETTINGSVIEWMETA:Class = ContactsSettingsViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_FAQWINDOWMETA:Class = FAQWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_GROUPDELETEVIEWMETA:Class = GroupDeleteViewMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_LOBBYCHANNELWINDOWMETA:Class = LobbyChannelWindowMeta;

        public static const NET_WG_GUI_MESSENGER_META_IMPL_SEARCHCONTACTVIEWMETA:Class = SearchContactViewMeta;

        public static const NET_WG_GUI_MESSENGER_VIEWS_BASECONTACTVIEW:Class = BaseContactView;

        public static const NET_WG_GUI_MESSENGER_VIEWS_BASEMANAGECONTACTVIEW:Class = BaseManageContactView;

        public static const NET_WG_GUI_MESSENGER_VIEWS_CONTACTNOTEMANAGEVIEW:Class = ContactNoteManageView;

        public static const NET_WG_GUI_MESSENGER_VIEWS_CONTACTSSETTINGSVIEW:Class = ContactsSettingsView;

        public static const NET_WG_GUI_MESSENGER_VIEWS_GROUPDELETEVIEW:Class = GroupDeleteView;

        public static const NET_WG_GUI_MESSENGER_VIEWS_SEARCHCONTACTVIEW:Class = SearchContactView;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_CHANNELSMANAGEMENTWINDOW:Class = ChannelsManagementWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_CHANNELWINDOW:Class = ChannelWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_CONNECTTOSECURECHANNELWINDOW:Class = ConnectToSecureChannelWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_FAQWINDOW:Class = FAQWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_LAZYCHANNELWINDOW:Class = LazyChannelWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_LOBBYCHANNELWINDOW:Class = LobbyChannelWindow;

        public static const NET_WG_GUI_MESSENGER_WINDOWS_PMWARNINGPANEL:Class = PMWarningPanel;

        public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONLISTVIEW:Class = NotificationListView;

        public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONPOPUPVIEWER:Class = NotificationPopUpViewer;

        public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONSLIST:Class = NotificationsList;

        public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONTIMECOMPONENT:Class = NotificationTimeComponent;

        public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGE:Class = ServiceMessage;

        public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEITEMRENDERER:Class = ServiceMessageItemRenderer;

        public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEPOPUP:Class = ServiceMessagePopUp;

        public static const NET_WG_GUI_NOTIFICATION_SYSTEMMESSAGEDIALOG:Class = SystemMessageDialog;

        public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONSTATE:Class = ButtonState;

        public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONTYPE:Class = ButtonType;

        public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_MESSAGEMETRICS:Class = MessageMetrics;

        public static const NET_WG_GUI_NOTIFICATION_EVENTS_NOTIFICATIONLAYOUTEVENT:Class = NotificationLayoutEvent;

        public static const NET_WG_GUI_NOTIFICATION_EVENTS_NOTIFICATIONLISTEVENT:Class = NotificationListEvent;

        public static const NET_WG_GUI_NOTIFICATION_EVENTS_SERVICEMESSAGEEVENT:Class = ServiceMessageEvent;

        public static const NET_WG_GUI_NOTIFICATION_VO_BUTTONVO:Class = ButtonVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_MESSAGEINFOVO:Class = MessageInfoVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONDIALOGINITINFOVO:Class = NotificationDialogInitInfoVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONINFOVO:Class = NotificationInfoVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONMESSAGESLISTVO:Class = NotificationMessagesListVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONSETTINGSVO:Class = NotificationSettingsVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONVIEWINITVO:Class = NotificationViewInitVO;

        public static const NET_WG_GUI_NOTIFICATION_VO_POPUPNOTIFICATIONINFOVO:Class = PopUpNotificationInfoVO;

        public static const NET_WG_GUI_PREBATTLE_ABSTRACT_PREBATTLEWINDOWABSTRACT:Class = PrebattleWindowAbstract;

        public static const NET_WG_GUI_PREBATTLE_ABSTRACT_PREQUEUEWINDOW:Class = PrequeueWindow;

        public static const NET_WG_GUI_PREBATTLE_BASE_BASEPREBATTLELISTVIEW:Class = BasePrebattleListView;

        public static const NET_WG_GUI_PREBATTLE_BASE_BASEPREBATTLEROOMVIEW:Class = BasePrebattleRoomView;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLIST:Class = BattleSessionList;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLISTRENDERER:Class = BattleSessionListRenderer;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONWINDOW:Class = BattleSessionWindow;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSFLAGRENDERER:Class = BSFlagRenderer;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSFLAGRENDERERVO:Class = BSFlagRendererVO;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSLISTRENDERERVO:Class = BSListRendererVO;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_FLAGSLIST:Class = FlagsList;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_REQUIREMENTINFO:Class = RequirementInfo;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPINFO:Class = TopInfo;

        public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPSTATS:Class = TopStats;

        public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATEFLAGS:Class = PrebattleStateFlags;

        public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATESTRING:Class = PrebattleStateString;

        public static const NET_WG_GUI_PREBATTLE_CONTROLS_TEAMMEMBERRENDERER:Class = TeamMemberRenderer;

        public static const NET_WG_GUI_PREBATTLE_CONTROLS_TEAMMEMBERRENDERERBASE:Class = net.wg.gui.prebattle.controls.TeamMemberRendererBase;

        public static const NET_WG_GUI_PREBATTLE_DATA_PLAYERPRBINFOVO:Class = PlayerPrbInfoVO;

        public static const NET_WG_GUI_PREBATTLE_DATA_RECEIVEDINVITEVO:Class = ReceivedInviteVO;

        public static const NET_WG_GUI_PREBATTLE_INVITES_INVITESTACKCONTAINERBASE:Class = InviteStackContainerBase;

        public static const NET_WG_GUI_PREBATTLE_INVITES_PRBINVITESEARCHUSERSFORM:Class = PrbInviteSearchUsersForm;

        public static const NET_WG_GUI_PREBATTLE_INVITES_RECEIVEDINVITEWINDOW:Class = ReceivedInviteWindow;

        public static const NET_WG_GUI_PREBATTLE_INVITES_SENDINVITESEVENT:Class = SendInvitesEvent;

        public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERITEMRENDERER:Class = UserRosterItemRenderer;

        public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERVIEW:Class = UserRosterView;

        public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONLISTMETA:Class = IBattleSessionListMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONWINDOWMETA:Class = IBattleSessionWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IPREBATTLEWINDOWMETA:Class = IPrebattleWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IPREQUEUEWINDOWMETA:Class = IPrequeueWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IRECEIVEDINVITEWINDOWMETA:Class = IReceivedInviteWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONLISTMETA:Class = BattleSessionListMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONWINDOWMETA:Class = BattleSessionWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREBATTLEWINDOWMETA:Class = PrebattleWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREQUEUEWINDOWMETA:Class = PrequeueWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_META_IMPL_RECEIVEDINVITEWINDOWMETA:Class = ReceivedInviteWindowMeta;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADABSTRACTFACTORY:Class = SquadAbstractFactory;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADCHATSECTIONBASE:Class = SquadChatSectionBase;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADPROMOWINDOW:Class = SquadPromoWindow;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADTEAMSECTIONBASE:Class = SquadTeamSectionBase;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADVIEW:Class = SquadView;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADWINDOW:Class = SquadWindow;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_EV_SQUADVIEWEVENT:Class = SquadViewEvent;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_INTERFACES_ISQUADABSTRACTFACTORY:Class = ISquadAbstractFactory;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADBONUSRENDERER:Class = SimpleSquadBonusRenderer;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADCHATSECTION:Class = SimpleSquadChatSection;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADSLOTHELPER:Class = SimpleSquadSlotHelper;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADSLOTRENDERER:Class = SimpleSquadSlotRenderer;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADTEAMSECTION:Class = SimpleSquadTeamSection;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SQUADVIEWHEADERVO:Class = SquadViewHeaderVO;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADBONUSVO:Class = SimpleSquadBonusVO;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADRALLYSLOTVO:Class = SimpleSquadRallySlotVO;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADRALLYVO:Class = SimpleSquadRallyVO;

        public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADTEAMSECTIONVO:Class = SimpleSquadTeamSectionVO;

        public static const NET_WG_GUI_RALLY_ABSTRACTRALLYVIEW:Class = AbstractRallyView;

        public static const NET_WG_GUI_RALLY_ABSTRACTRALLYWINDOW:Class = AbstractRallyWindow;

        public static const NET_WG_GUI_RALLY_BASERALLYMAINWINDOW:Class = BaseRallyMainWindow;

        public static const NET_WG_GUI_RALLY_BASERALLYVIEW:Class = BaseRallyView;

        public static const NET_WG_GUI_RALLY_RALLYMAINWINDOWWITHSEARCH:Class = RallyMainWindowWithSearch;

        public static const NET_WG_GUI_RALLY_CONSTANTS_PLAYERSTATUS:Class = PlayerStatus;

        public static const NET_WG_GUI_RALLY_CONTROLS_BASERALLYSLOTHELPER:Class = BaseRallySlotHelper;

        public static const NET_WG_GUI_RALLY_CONTROLS_CANDIDATESSCROLLINGLIST:Class = CandidatesScrollingList;

        public static const NET_WG_GUI_RALLY_CONTROLS_MANUALSEARCHSCROLLINGLIST:Class = ManualSearchScrollingList;

        public static const NET_WG_GUI_RALLY_CONTROLS_RALLYINVALIDATIONTYPE:Class = RallyInvalidationType;

        public static const NET_WG_GUI_RALLY_CONTROLS_RALLYLOCKABLESLOTRENDERER:Class = RallyLockableSlotRenderer;

        public static const NET_WG_GUI_RALLY_CONTROLS_RALLYSIMPLESLOTRENDERER:Class = RallySimpleSlotRenderer;

        public static const NET_WG_GUI_RALLY_CONTROLS_RALLYSLOTRENDERER:Class = RallySlotRenderer;

        public static const NET_WG_GUI_RALLY_CONTROLS_SLOTDROPINDICATOR:Class = SlotDropIndicator;

        public static const NET_WG_GUI_RALLY_CONTROLS_SLOTRENDERERHELPER:Class = SlotRendererHelper;

        public static const NET_WG_GUI_RALLY_CONTROLS_VOICERALLYSLOTRENDERER:Class = VoiceRallySlotRenderer;

        public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_IRALLYSIMPLESLOTRENDERER:Class = IRallySimpleSlotRenderer;

        public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_IRALLYSLOTWITHRATING:Class = IRallySlotWithRating;

        public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_ISLOTDROPINDICATOR:Class = ISlotDropIndicator;

        public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_ISLOTRENDERERHELPER:Class = ISlotRendererHelper;

        public static const NET_WG_GUI_RALLY_DATA_MANUALSEARCHDATAPROVIDER:Class = ManualSearchDataProvider;

        public static const NET_WG_GUI_RALLY_DATA_TOOLTIPDATAVO:Class = net.wg.gui.rally.data.TooltipDataVO;

        public static const NET_WG_GUI_RALLY_EVENTS_RALLYVIEWSEVENT:Class = RallyViewsEvent;

        public static const NET_WG_GUI_RALLY_HELPERS_RALLYDRAGDROPDELEGATE:Class = RallyDragDropDelegate;

        public static const NET_WG_GUI_RALLY_HELPERS_RALLYDRAGDROPLISTDELEGATECONTROLLER:Class = RallyDragDropListDelegateController;

        public static const NET_WG_GUI_RALLY_INTERFACES_IBASECHATSECTION:Class = IBaseChatSection;

        public static const NET_WG_GUI_RALLY_INTERFACES_IBASETEAMSECTION:Class = IBaseTeamSection;

        public static const NET_WG_GUI_RALLY_INTERFACES_ICHATSECTIONWITHDESCRIPTION:Class = IChatSectionWithDescription;

        public static const NET_WG_GUI_RALLY_INTERFACES_IMANUALSEARCHRENDERER:Class = IManualSearchRenderer;

        public static const NET_WG_GUI_RALLY_INTERFACES_IMANUALSEARCHSCROLLINGLIST:Class = IManualSearchScrollingList;

        public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYLISTITEMVO:Class = IRallyListItemVO;

        public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYNOSORTIESCREEN:Class = IRallyNoSortieScreen;

        public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYSLOTVO:Class = IRallySlotVO;

        public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYVO:Class = IRallyVO;

        public static const NET_WG_GUI_RALLY_INTERFACES_ITEAMSECTIONWITHDROPINDICATORS:Class = ITeamSectionWithDropIndicators;

        public static const NET_WG_GUI_RALLY_VIEWS_INTRO_BASERALLYINTROVIEW:Class = BaseRallyIntroView;

        public static const NET_WG_GUI_RALLY_VIEWS_LIST_ABTRACTRALLYDETAILSSECTION:Class = AbtractRallyDetailsSection;

        public static const NET_WG_GUI_RALLY_VIEWS_LIST_BASERALLYDETAILSSECTION:Class = BaseRallyDetailsSection;

        public static const NET_WG_GUI_RALLY_VIEWS_LIST_BASERALLYLISTVIEW:Class = BaseRallyListView;

        public static const NET_WG_GUI_RALLY_VIEWS_LIST_RALLYNOSORTIESCREEN:Class = RallyNoSortieScreen;

        public static const NET_WG_GUI_RALLY_VIEWS_LIST_SIMPLERALLYDETAILSSECTION:Class = SimpleRallyDetailsSection;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASECHATSECTION:Class = BaseChatSection;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASERALLYROOMVIEW:Class = BaseRallyRoomView;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASERALLYROOMVIEWWITHWAITING:Class = BaseRallyRoomViewWithWaiting;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASETEAMSECTION:Class = BaseTeamSection;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASEWAITLISTSECTION:Class = BaseWaitListSection;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_CHATSECTIONWITHDESCRIPTION:Class = ChatSectionWithDescription;

        public static const NET_WG_GUI_RALLY_VIEWS_ROOM_TEAMSECTIONWITHDROPINDICATORS:Class = TeamSectionWithDropIndicators;

        public static const NET_WG_GUI_RALLY_VO_ACTIONBUTTONVO:Class = ActionButtonVO;

        public static const NET_WG_GUI_RALLY_VO_INTROVEHICLEVO:Class = IntroVehicleVO;

        public static const NET_WG_GUI_RALLY_VO_RALLYCANDIDATEVO:Class = RallyCandidateVO;

        public static const NET_WG_GUI_RALLY_VO_RALLYSHORTVO:Class = RallyShortVO;

        public static const NET_WG_GUI_RALLY_VO_RALLYSLOTVO:Class = RallySlotVO;

        public static const NET_WG_GUI_RALLY_VO_RALLYVO:Class = RallyVO;

        public static const NET_WG_GUI_RALLY_VO_SETTINGROSTERVO:Class = SettingRosterVO;

        public static const NET_WG_GUI_RALLY_VO_VEHICLEALERTVO:Class = VehicleAlertVO;

        public static const NET_WG_GUI_TUTORIAL_CONSTANTS_HINTITEMTYPE:Class = HintItemType;

        public static const NET_WG_GUI_TUTORIAL_CONSTANTS_PLAYERXPLEVEL:Class = PlayerXPLevel;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_BATTLEBONUSITEM:Class = BattleBonusItem;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_BATTLEPROGRESS:Class = BattleProgress;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_CHAPTERPROGRESSITEMRENDERER:Class = ChapterProgressItemRenderer;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_FINALSTATISTICPROGRESS:Class = FinalStatisticProgress;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTBASEITEMRENDERER:Class = HintBaseItemRenderer;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTLIST:Class = HintList;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTTEXTITEMRENDERER:Class = HintTextItemRenderer;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTVIDEOITEMRENDERER:Class = HintVideoItemRenderer;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_PROGRESSITEM:Class = ProgressItem;

        public static const NET_WG_GUI_TUTORIAL_CONTROLS_PROGRESSSEPARATOR:Class = ProgressSeparator;

        public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLENORESULTSMETA:Class = ITutorialBattleNoResultsMeta;

        public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLESTATISTICMETA:Class = ITutorialBattleStatisticMeta;

        public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALCONFIRMREFUSEDIALOGMETA:Class = ITutorialConfirmRefuseDialogMeta;

        public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLENORESULTSMETA:Class = TutorialBattleNoResultsMeta;

        public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLESTATISTICMETA:Class = TutorialBattleStatisticMeta;

        public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALCONFIRMREFUSEDIALOGMETA:Class = TutorialConfirmRefuseDialogMeta;

        public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLENORESULTSWINDOW:Class = TutorialBattleNoResultsWindow;

        public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLESTATISTICWINDOW:Class = TutorialBattleStatisticWindow;

        public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALCONFIRMREFUSEDIALOG:Class = TutorialConfirmRefuseDialog;

        public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALGREETINGDIALOG:Class = TutorialGreetingDialog;

        public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALQUEUEDIALOG:Class = TutorialQueueDialog;

        public static const NET_WG_GUI_UTILS_IMAGESUBSTITUTION:Class = ImageSubstitution;

        public static const NET_WG_GUI_UTILS_VO_PRICEVO:Class = PriceVO;

        public static const NET_WG_GUI_UTILS_VO_UNITSLOTPROPERTIES:Class = UnitSlotProperties;

        public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTCONFIRMITEMDIALOG:Class = AbstractConfirmItemDialog;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IABSTRACTRALLYVIEWMETA:Class = IAbstractRallyViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IABSTRACTRALLYWINDOWMETA:Class = IAbstractRallyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IACCOUNTPOPOVERMETA:Class = IAccountPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IALERTMESSAGEBLOCKMETA:Class = IAlertMessageBlockMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IALLVEHICLESTABVIEWMETA:Class = IAllVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IAMMUNITIONPANELMETA:Class = IAmmunitionPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IAWARDGROUPSMETA:Class = IAwardGroupsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IAWARDWINDOWMETA:Class = IAwardWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IAWARDWINDOWSBASEMETA:Class = IAwardWindowsBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBADGESPAGEMETA:Class = IBadgesPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBARRACKSMETA:Class = IBarracksMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEEXCHANGEWINDOWMETA:Class = IBaseExchangeWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEMISSIONDETAILSCONTAINERVIEWMETA:Class = IBaseMissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEPREBATTLELISTVIEWMETA:Class = IBasePrebattleListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEPREBATTLEROOMVIEWMETA:Class = IBasePrebattleRoomViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYINTROVIEWMETA:Class = IBaseRallyIntroViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYLISTVIEWMETA:Class = IBaseRallyListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYMAINWINDOWMETA:Class = IBaseRallyMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYROOMVIEWMETA:Class = IBaseRallyRoomViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYVIEWMETA:Class = IBaseRallyViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASESTORAGECATEGORYVIEWMETA:Class = IBaseStorageCategoryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEQUEUEMETA:Class = IBattleQueueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLERESULTSMETA:Class = IBattleResultsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLESTRONGHOLDSQUEUEMETA:Class = IBattleStrongholdsQueueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLETYPESELECTPOPOVERMETA:Class = IBattleTypeSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCBATTLERESULTMETA:Class = IBCBattleResultMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCMESSAGEWINDOWMETA:Class = IBCMessageWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCNATIONSWINDOWMETA:Class = IBCNationsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCOUTROVIDEOPAGEMETA:Class = IBCOutroVideoPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCQUESTSVIEWMETA:Class = IBCQuestsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCQUEUEWINDOWMETA:Class = IBCQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBCTOOLTIPSWINDOWMETA:Class = IBCTooltipsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBOOSTERBUYWINDOWMETA:Class = IBoosterBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBOOSTERINFOMETA:Class = IBoosterInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBOOSTERSWINDOWMETA:Class = IBoostersWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERINVIEWCOMPONENTMETA:Class = IBrowserInViewComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERMETA:Class = IBrowserMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERSCREENMETA:Class = IBrowserScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERVIEWSTACKEXPADDINGMETA:Class = IBrowserViewStackExPaddingMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERWINDOWMETA:Class = IBrowserWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IBUTTONWITHCOUNTERMETA:Class = IButtonWithCounterMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICALENDARMETA:Class = ICalendarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHANNELCAROUSELMETA:Class = IChannelCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHECKBOXDIALOGMETA:Class = ICheckBoxDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESVIEWMETA:Class = IClanInvitesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESVIEWWITHTABLEMETA:Class = IClanInvitesViewWithTableMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESWINDOWABSTRACTTABVIEWMETA:Class = IClanInvitesWindowAbstractTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESWINDOWMETA:Class = IClanInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPERSONALINVITESVIEWMETA:Class = IClanPersonalInvitesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPERSONALINVITESWINDOWMETA:Class = IClanPersonalInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEBASEVIEWMETA:Class = IClanProfileBaseViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEGLOBALMAPINFOVIEWMETA:Class = IClanProfileGlobalMapInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEGLOBALMAPPROMOVIEWMETA:Class = IClanProfileGlobalMapPromoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEMAINWINDOWMETA:Class = IClanProfileMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEPERSONNELVIEWMETA:Class = IClanProfilePersonnelViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILESUMMARYVIEWMETA:Class = IClanProfileSummaryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILETABLESTATISTICSVIEWMETA:Class = IClanProfileTableStatisticsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANREQUESTSVIEWMETA:Class = IClanRequestsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANSEARCHINFOMETA:Class = IClanSearchInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANSEARCHWINDOWMETA:Class = IClanSearchWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMDIALOGMETA:Class = IConfirmDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMEXCHANGEDIALOGMETA:Class = IConfirmExchangeDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMITEMWINDOWMETA:Class = IConfirmItemWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONTACTSTREECOMPONENTMETA:Class = IContactsTreeComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWMETA:Class = ICrewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWOPERATIONSPOPOVERMETA:Class = ICrewOperationsPopOverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWSKINSCOMPENSATIONDIALOGMETA:Class = ICrewSkinsCompensationDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICRYSTALSPROMOWINDOWMETA:Class = ICrystalsPromoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICURRENTVEHICLEMISSIONSVIEWMETA:Class = ICurrentVehicleMissionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONBOTTOMPANELMETA:Class = ICustomizationBottomPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONBUYWINDOWMETA:Class = ICustomizationBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONCONFIGURATIONWINDOWMETA:Class = ICustomizationConfigurationWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONFILTERSPOPOVERMETA:Class = ICustomizationFiltersPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONINSCRIPTIONCONTROLLERMETA:Class = ICustomizationInscriptionControllerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONITEMSPOPOVERMETA:Class = ICustomizationItemsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONKITPOPOVERMETA:Class = ICustomizationKitPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONMAINVIEWMETA:Class = ICustomizationMainViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONNONHISTORICPOPOVERMETA:Class = ICustomizationNonHistoricPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONPROPERTIESSHEETMETA:Class = ICustomizationPropertiesSheetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONSTYLEINFOMETA:Class = ICustomizationStyleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTINTROMETA:Class = ICyberSportIntroMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTMAINWINDOWMETA:Class = ICyberSportMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITMETA:Class = ICyberSportUnitMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITSLISTMETA:Class = ICyberSportUnitsListMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IDEMONSTRATORWINDOWMETA:Class = IDemonstratorWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IDEMOPAGEMETA:Class = IDemoPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IELITEWINDOWMETA:Class = IEliteWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESAFTERBATTLEVIEWMETA:Class = IEpicBattlesAfterBattleViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESBROWSERVIEWMETA:Class = IEpicBattlesBrowserViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESINFOVIEWMETA:Class = IEpicBattlesInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESOFFLINEVIEWMETA:Class = IEpicBattlesOfflineViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESPRESTIGEVIEWMETA:Class = IEpicBattlesPrestigeViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESSKILLVIEWMETA:Class = IEpicBattlesSkillViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESWELCOMEBACKVIEWMETA:Class = IEpicBattlesWelcomeBackViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLESWIDGETMETA:Class = IEpicBattlesWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEPICBATTLETRAININGROOMMETA:Class = IEpicBattleTrainingRoomMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEULAMETA:Class = IEULAMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSAWARDSOVERLAYMETA:Class = IEventBoardsAwardsOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSBATTLEOVERLAYMETA:Class = IEventBoardsBattleOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSDETAILSCONTAINERVIEWMETA:Class = IEventBoardsDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSRESULTFILTERPOPOVERVIEWMETA:Class = IEventBoardsResultFilterPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSRESULTFILTERVEHICLESPOPOVERVIEWMETA:Class = IEventBoardsResultFilterVehiclesPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSTABLEVIEWMETA:Class = IEventBoardsTableViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEVENTBOARDSVEHICLESOVERLAYMETA:Class = IEventBoardsVehiclesOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEFREETOTANKMANXPWINDOWMETA:Class = IExchangeFreeToTankmanXpWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEWINDOWMETA:Class = IExchangeWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEXPWINDOWMETA:Class = IExchangeXpWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFITTINGSELECTPOPOVERMETA:Class = IFittingSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBATTLEROOMWINDOWMETA:Class = IFortBattleRoomWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCLANBATTLEROOMMETA:Class = IFortClanBattleRoomMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDISCONNECTVIEWMETA:Class = IFortDisconnectViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTVEHICLESELECTPOPOVERMETA:Class = IFortVehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFREESHEETPOPOVERMETA:Class = IFreeSheetPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFREEXPINFOWINDOWMETA:Class = IFreeXPInfoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IFRONTLINEBUYCONFIRMVIEWMETA:Class = IFrontlineBuyConfirmViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IGETPREMIUMPOPOVERMETA:Class = IGetPremiumPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IGOLDFISHWINDOWMETA:Class = IGoldFishWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IHANGARHEADERMETA:Class = IHangarHeaderMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IHANGARMETA:Class = IHangarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONDIALOGMETA:Class = IIconDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONPRICEDIALOGMETA:Class = IIconPriceDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IIMAGEVIEWMETA:Class = IImageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IINPUTCHECKERMETA:Class = IInputCheckerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IINTROPAGEMETA:Class = IIntroPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IINVENTORYMETA:Class = IInventoryMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IITEMSWITHTYPEANDNATIONFILTERTABVIEWMETA:Class = IItemsWithTypeAndNationFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IITEMSWITHTYPEFILTERTABVIEWMETA:Class = IItemsWithTypeFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IITEMSWITHVEHICLEFILTERTABVIEWMETA:Class = IItemsWithVehicleFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILEGALINFOWINDOWMETA:Class = ILegalInfoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILINKEDSETDETAILSCONTAINERVIEWMETA:Class = ILinkedSetDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILINKEDSETDETAILSOVERLAYMETA:Class = ILinkedSetDetailsOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILINKEDSETHINTSVIEWMETA:Class = ILinkedSetHintsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYHEADERMETA:Class = ILobbyHeaderMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYMENUMETA:Class = ILobbyMenuMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYPAGEMETA:Class = ILobbyPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYVEHICLEMARKERVIEWMETA:Class = ILobbyVehicleMarkerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINPAGEMETA:Class = ILoginPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINQUEUEWINDOWMETA:Class = ILoginQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMAINTENANCECOMPONENTMETA:Class = IMaintenanceComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMANUALCHAPTERVIEWMETA:Class = IManualChapterViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMANUALMAINVIEWMETA:Class = IManualMainViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMESSENGERBARMETA:Class = IMessengerBarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMINICLIENTCOMPONENTMETA:Class = IMiniClientComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONAWARDWINDOWMETA:Class = IMissionAwardWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONDETAILSCONTAINERVIEWMETA:Class = IMissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSEVENTBOARDSVIEWMETA:Class = IMissionsEventBoardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSFILTERPOPOVERVIEWMETA:Class = IMissionsFilterPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSGROUPEDVIEWMETA:Class = IMissionsGroupedViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSMARATHONVIEWMETA:Class = IMissionsMarathonViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSPAGEMETA:Class = IMissionsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSTOKENPOPOVERMETA:Class = IMissionsTokenPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSVEHICLESELECTORMETA:Class = IMissionsVehicleSelectorMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONSVIEWBASEMETA:Class = IMissionsViewBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMODULEINFOMETA:Class = IModuleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMODULESPANELMETA:Class = IModulesPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONLISTBUTTONMETA:Class = INotificationListButtonMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONPOPUPVIEWERMETA:Class = INotificationPopUpViewerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONSLISTMETA:Class = INotificationsListMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_INYSELECTVEHICLEPOPOVERMETA:Class = INYSelectVehiclePopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPACKITEMSPOPOVERMETA:Class = IPackItemsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPAGINATIONMETA:Class = IPaginationMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALCASEMETA:Class = IPersonalCaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONDETAILSCONTAINERVIEWMETA:Class = IPersonalMissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONFIRSTENTRYAWARDVIEWMETA:Class = IPersonalMissionFirstEntryAwardViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONFIRSTENTRYVIEWMETA:Class = IPersonalMissionFirstEntryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONOPERATIONSMETA:Class = IPersonalMissionOperationsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSABSTRACTINFOVIEWMETA:Class = IPersonalMissionsAbstractInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSAWARDSVIEWMETA:Class = IPersonalMissionsAwardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSMAPVIEWMETA:Class = IPersonalMissionsMapViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSOPERATIONAWARDSSCREENMETA:Class = IPersonalMissionsOperationAwardsScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSPAGEMETA:Class = IPersonalMissionsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALMISSIONSQUESTAWARDSCREENMETA:Class = IPersonalMissionsQuestAwardScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPREMIUMWINDOWMETA:Class = IPremiumWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPRIMETIMEMETA:Class = IPrimeTimeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEACHIEVEMENTSECTIONMETA:Class = IProfileAchievementSectionMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEAWARDSMETA:Class = IProfileAwardsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEFORMATIONSPAGEMETA:Class = IProfileFormationsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEHOFMETA:Class = IProfileHofMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEMETA:Class = IProfileMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESECTIONMETA:Class = IProfileSectionMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESTATISTICSMETA:Class = IProfileStatisticsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESUMMARYMETA:Class = IProfileSummaryMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESUMMARYWINDOWMETA:Class = IProfileSummaryWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETABNAVIGATORMETA:Class = IProfileTabNavigatorMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEMETA:Class = IProfileTechniqueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEPAGEMETA:Class = IProfileTechniquePageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEWINDOWMETA:Class = IProfileWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROGRESSIVEREWARDWIDGETMETA:Class = IProgressiveRewardWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROMOPREMIUMIGRWINDOWMETA:Class = IPromoPremiumIgrWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPUNISHMENTDIALOGMETA:Class = IPunishmentDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IPVESANDBOXQUEUEWINDOWMETA:Class = IPvESandboxQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTRECRUITWINDOWMETA:Class = IQuestRecruitWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCONTENTTABSMETA:Class = IQuestsContentTabsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRALLYMAINWINDOWWITHSEARCHMETA:Class = IRallyMainWindowWithSearchMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESAWARDSVIEWMETA:Class = IRankedBattlesAwardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESBATTLERESULTSMETA:Class = IRankedBattlesBattleResultsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESDIVISIONPROGRESSMETA:Class = IRankedBattlesDivisionProgressMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESDIVISIONQUALIFICATIONMETA:Class = IRankedBattlesDivisionQualificationMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESDIVISIONSVIEWMETA:Class = IRankedBattlesDivisionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESHANGARWIDGETMETA:Class = IRankedBattlesHangarWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESINTROMETA:Class = IRankedBattlesIntroMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESLEAGUESVIEWMETA:Class = IRankedBattlesLeaguesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESPAGEMETA:Class = IRankedBattlesPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESREWARDSLEAGUESMETA:Class = IRankedBattlesRewardsLeaguesMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESREWARDSMETA:Class = IRankedBattlesRewardsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESREWARDSRANKSMETA:Class = IRankedBattlesRewardsRanksMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESREWARDSYEARMETA:Class = IRankedBattlesRewardsYearMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESSEASONCOMPLETEVIEWMETA:Class = IRankedBattlesSeasonCompleteViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESSEASONGAPVIEWMETA:Class = IRankedBattlesSeasonGapViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDBATTLESUNREACHABLEVIEWMETA:Class = IRankedBattlesUnreachableViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRANKEDPRIMETIMEMETA:Class = IRankedPrimeTimeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRECRUITPARAMETERSMETA:Class = IRecruitParametersMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRECRUITWINDOWMETA:Class = IRecruitWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IREGULARITEMSTABVIEWMETA:Class = IRegularItemsTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRENTALTERMSELECTIONPOPOVERMETA:Class = IRentalTermSelectionPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRENTVEHICLESTABVIEWMETA:Class = IRentVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHMETA:Class = IResearchMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHPANELMETA:Class = IResearchPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHVIEWMETA:Class = IResearchViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESTOREVEHICLESTABVIEWMETA:Class = IRestoreVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRETRAINCREWWINDOWMETA:Class = IRetrainCrewWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IROLECHANGEMETA:Class = IRoleChangeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IROSTERSLOTSETTINGSWINDOWMETA:Class = IRosterSlotSettingsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IRSSNEWSFEEDMETA:Class = IRssNewsFeedMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISENDINVITESWINDOWMETA:Class = ISendInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISENIORITYAWARDSENTRYPOINTMETA:Class = ISeniorityAwardsEntryPointMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISESSIONBATTLESTATSVIEWMETA:Class = ISessionBattleStatsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISESSIONSTATSPOPOVERMETA:Class = ISessionStatsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISESSIONVEHICLESTATSVIEWMETA:Class = ISessionVehicleStatsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISHOPMETA:Class = IShopMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISIMPLEWINDOWMETA:Class = ISimpleWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISKILLDROPMETA:Class = ISkillDropMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISLOTSPANELMETA:Class = ISlotsPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADPROMOWINDOWMETA:Class = ISquadPromoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADVIEWMETA:Class = ISquadViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADWINDOWMETA:Class = ISquadWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECAROUSELENVIRONMENTMETA:Class = IStorageCarouselEnvironmentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYBLUEPRINTSVIEWMETA:Class = IStorageCategoryBlueprintsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYCUSTOMIZATIONVIEWMETA:Class = IStorageCategoryCustomizationViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYFORSELLVIEWMETA:Class = IStorageCategoryForSellViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYINHANGARVIEWMETA:Class = IStorageCategoryInHangarViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYPERSONALRESERVESVIEWMETA:Class = IStorageCategoryPersonalReservesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGECATEGORYSTORAGEVIEWMETA:Class = IStorageCategoryStorageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGEVEHICLESELECTPOPOVERMETA:Class = IStorageVehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORAGEVIEWMETA:Class = IStorageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTOREACTIONSVIEWMETA:Class = IStoreActionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORECOMPONENTMETA:Class = IStoreComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORETABLEMETA:Class = IStoreTableMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTOREVIEWMETA:Class = IStoreViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTRONGHOLDBATTLESLISTVIEWMETA:Class = IStrongholdBattlesListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTRONGHOLDVIEWMETA:Class = IStrongholdViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISWITCHMODEPANELMETA:Class = ISwitchModePanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISWITCHPERIPHERYWINDOWMETA:Class = ISwitchPeripheryWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ISYSTEMMESSAGEDIALOGMETA:Class = ISystemMessageDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKCAROUSELMETA:Class = ITankCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKGIRLSPOPOVERMETA:Class = ITankgirlsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKMANOPERATIONDIALOGMETA:Class = ITankmanOperationDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHNICALMAINTENANCEMETA:Class = ITechnicalMaintenanceMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHTREEMETA:Class = ITechTreeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITMENXPPANELMETA:Class = ITmenXpPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRADEINPOPUPMETA:Class = ITradeInPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRADEOFFWIDGETMETA:Class = ITradeOffWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGFORMMETA:Class = ITrainingFormMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGROOMBASEMETA:Class = ITrainingRoomBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGWINDOWMETA:Class = ITrainingWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IUNBOUNDINJECTWINDOWMETA:Class = IUnboundInjectWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IUSEAWARDSHEETWINDOWMETA:Class = IUseAwardSheetWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEBASEPREVIEWMETA:Class = IVehicleBasePreviewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEBUYWINDOWMETA:Class = IVehicleBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECARTPOPOVERMETA:Class = IVehicleCompareCartPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECOMMONVIEWMETA:Class = IVehicleCompareCommonViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECONFIGURATORBASEVIEWMETA:Class = IVehicleCompareConfiguratorBaseViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECONFIGURATORMAINMETA:Class = IVehicleCompareConfiguratorMainMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECONFIGURATORVIEWMETA:Class = IVehicleCompareConfiguratorViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPAREVIEWMETA:Class = IVehicleCompareViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEINFOMETA:Class = IVehicleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLELISTPOPUPMETA:Class = IVehicleListPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEMODULESVIEWMETA:Class = IVehicleModulesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPARAMETERSMETA:Class = IVehicleParametersMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEW20META:Class = IVehiclePreview20Meta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWBROWSETABMETA:Class = IVehiclePreviewBrowseTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWBUYINGPANELMETA:Class = IVehiclePreviewBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWCREWTABMETA:Class = IVehiclePreviewCrewTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWFRONTLINEBUYINGPANELMETA:Class = IVehiclePreviewFrontlineBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWMETA:Class = IVehiclePreviewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWMODULESTABMETA:Class = IVehiclePreviewModulesTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWTRADEINBUYINGPANELMETA:Class = IVehiclePreviewTradeInBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELECTORCAROUSELMETA:Class = IVehicleSelectorCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELECTORPOPUPMETA:Class = IVehicleSelectorPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELECTPOPOVERMETA:Class = IVehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELLCONFIRMATIONPOPOVERMETA:Class = IVehicleSellConfirmationPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELLDIALOGMETA:Class = IVehicleSellDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IWGNCDIALOGMETA:Class = IWGNCDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IWGNCPOLLWINDOWMETA:Class = IWGNCPollWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ABSTRACTRALLYVIEWMETA:Class = AbstractRallyViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ABSTRACTRALLYWINDOWMETA:Class = AbstractRallyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ACCOUNTPOPOVERMETA:Class = AccountPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ALERTMESSAGEBLOCKMETA:Class = AlertMessageBlockMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ALLVEHICLESTABVIEWMETA:Class = AllVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AMMUNITIONPANELMETA:Class = AmmunitionPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AWARDGROUPSMETA:Class = AwardGroupsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AWARDWINDOWMETA:Class = AwardWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AWARDWINDOWSBASEMETA:Class = AwardWindowsBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BADGESPAGEMETA:Class = BadgesPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BARRACKSMETA:Class = BarracksMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEEXCHANGEWINDOWMETA:Class = BaseExchangeWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEMISSIONDETAILSCONTAINERVIEWMETA:Class = BaseMissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEPREBATTLELISTVIEWMETA:Class = BasePrebattleListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEPREBATTLEROOMVIEWMETA:Class = BasePrebattleRoomViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYINTROVIEWMETA:Class = BaseRallyIntroViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYLISTVIEWMETA:Class = BaseRallyListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYMAINWINDOWMETA:Class = BaseRallyMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYROOMVIEWMETA:Class = BaseRallyRoomViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYVIEWMETA:Class = BaseRallyViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASESTORAGECATEGORYVIEWMETA:Class = BaseStorageCategoryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEQUEUEMETA:Class = BattleQueueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLERESULTSMETA:Class = BattleResultsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLESTRONGHOLDSQUEUEMETA:Class = BattleStrongholdsQueueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLETYPESELECTPOPOVERMETA:Class = BattleTypeSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCBATTLERESULTMETA:Class = BCBattleResultMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCMESSAGEWINDOWMETA:Class = BCMessageWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCNATIONSWINDOWMETA:Class = BCNationsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCOUTROVIDEOPAGEMETA:Class = BCOutroVideoPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCQUESTSVIEWMETA:Class = BCQuestsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCQUEUEWINDOWMETA:Class = BCQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BCTOOLTIPSWINDOWMETA:Class = BCTooltipsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BOOSTERBUYWINDOWMETA:Class = BoosterBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BOOSTERINFOMETA:Class = BoosterInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BOOSTERSWINDOWMETA:Class = BoostersWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERINVIEWCOMPONENTMETA:Class = BrowserInViewComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERMETA:Class = BrowserMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERSCREENMETA:Class = BrowserScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERVIEWSTACKEXPADDINGMETA:Class = BrowserViewStackExPaddingMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERWINDOWMETA:Class = BrowserWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BUTTONWITHCOUNTERMETA:Class = ButtonWithCounterMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CALENDARMETA:Class = CalendarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHANNELCAROUSELMETA:Class = ChannelCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHECKBOXDIALOGMETA:Class = CheckBoxDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESVIEWMETA:Class = ClanInvitesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESVIEWWITHTABLEMETA:Class = ClanInvitesViewWithTableMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESWINDOWABSTRACTTABVIEWMETA:Class = ClanInvitesWindowAbstractTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESWINDOWMETA:Class = ClanInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPERSONALINVITESVIEWMETA:Class = ClanPersonalInvitesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPERSONALINVITESWINDOWMETA:Class = ClanPersonalInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEBASEVIEWMETA:Class = ClanProfileBaseViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEGLOBALMAPINFOVIEWMETA:Class = ClanProfileGlobalMapInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEGLOBALMAPPROMOVIEWMETA:Class = ClanProfileGlobalMapPromoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEMAINWINDOWMETA:Class = ClanProfileMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEPERSONNELVIEWMETA:Class = ClanProfilePersonnelViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILESUMMARYVIEWMETA:Class = ClanProfileSummaryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILETABLESTATISTICSVIEWMETA:Class = ClanProfileTableStatisticsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANREQUESTSVIEWMETA:Class = ClanRequestsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANSEARCHINFOMETA:Class = ClanSearchInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANSEARCHWINDOWMETA:Class = ClanSearchWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMDIALOGMETA:Class = ConfirmDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMEXCHANGEDIALOGMETA:Class = ConfirmExchangeDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMITEMWINDOWMETA:Class = ConfirmItemWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONTACTSTREECOMPONENTMETA:Class = ContactsTreeComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWMETA:Class = CrewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWOPERATIONSPOPOVERMETA:Class = CrewOperationsPopOverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWSKINSCOMPENSATIONDIALOGMETA:Class = CrewSkinsCompensationDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CRYSTALSPROMOWINDOWMETA:Class = CrystalsPromoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CURRENTVEHICLEMISSIONSVIEWMETA:Class = CurrentVehicleMissionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONBOTTOMPANELMETA:Class = CustomizationBottomPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONBUYWINDOWMETA:Class = CustomizationBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONCONFIGURATIONWINDOWMETA:Class = CustomizationConfigurationWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONFILTERSPOPOVERMETA:Class = CustomizationFiltersPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONINSCRIPTIONCONTROLLERMETA:Class = CustomizationInscriptionControllerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONITEMSPOPOVERMETA:Class = CustomizationItemsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONKITPOPOVERMETA:Class = CustomizationKitPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONMAINVIEWMETA:Class = CustomizationMainViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONNONHISTORICPOPOVERMETA:Class = CustomizationNonHistoricPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONPROPERTIESSHEETMETA:Class = CustomizationPropertiesSheetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONSTYLEINFOMETA:Class = CustomizationStyleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTINTROMETA:Class = CyberSportIntroMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTMAINWINDOWMETA:Class = CyberSportMainWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITMETA:Class = CyberSportUnitMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITSLISTMETA:Class = CyberSportUnitsListMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DEMONSTRATORWINDOWMETA:Class = DemonstratorWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DEMOPAGEMETA:Class = DemoPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ELITEWINDOWMETA:Class = EliteWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESAFTERBATTLEVIEWMETA:Class = EpicBattlesAfterBattleViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESBROWSERVIEWMETA:Class = EpicBattlesBrowserViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESINFOVIEWMETA:Class = EpicBattlesInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESOFFLINEVIEWMETA:Class = EpicBattlesOfflineViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESPRESTIGEVIEWMETA:Class = EpicBattlesPrestigeViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESSKILLVIEWMETA:Class = EpicBattlesSkillViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESWELCOMEBACKVIEWMETA:Class = EpicBattlesWelcomeBackViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLESWIDGETMETA:Class = EpicBattlesWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EPICBATTLETRAININGROOMMETA:Class = EpicBattleTrainingRoomMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EULAMETA:Class = EULAMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSAWARDSOVERLAYMETA:Class = EventBoardsAwardsOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSBATTLEOVERLAYMETA:Class = EventBoardsBattleOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSDETAILSCONTAINERVIEWMETA:Class = EventBoardsDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSRESULTFILTERPOPOVERVIEWMETA:Class = EventBoardsResultFilterPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSRESULTFILTERVEHICLESPOPOVERVIEWMETA:Class = EventBoardsResultFilterVehiclesPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSTABLEVIEWMETA:Class = EventBoardsTableViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EVENTBOARDSVEHICLESOVERLAYMETA:Class = EventBoardsVehiclesOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEFREETOTANKMANXPWINDOWMETA:Class = ExchangeFreeToTankmanXpWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEWINDOWMETA:Class = ExchangeWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEXPWINDOWMETA:Class = ExchangeXpWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FITTINGSELECTPOPOVERMETA:Class = FittingSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBATTLEROOMWINDOWMETA:Class = FortBattleRoomWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCLANBATTLEROOMMETA:Class = FortClanBattleRoomMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDISCONNECTVIEWMETA:Class = FortDisconnectViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTVEHICLESELECTPOPOVERMETA:Class = FortVehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FREESHEETPOPOVERMETA:Class = FreeSheetPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FREEXPINFOWINDOWMETA:Class = FreeXPInfoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FRONTLINEBUYCONFIRMVIEWMETA:Class = FrontlineBuyConfirmViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_GETPREMIUMPOPOVERMETA:Class = GetPremiumPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_GOLDFISHWINDOWMETA:Class = GoldFishWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HANGARHEADERMETA:Class = HangarHeaderMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HANGARMETA:Class = HangarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONDIALOGMETA:Class = IconDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONPRICEDIALOGMETA:Class = IconPriceDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_IMAGEVIEWMETA:Class = ImageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INPUTCHECKERMETA:Class = InputCheckerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INTROPAGEMETA:Class = IntroPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INVENTORYMETA:Class = InventoryMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ITEMSWITHTYPEANDNATIONFILTERTABVIEWMETA:Class = ItemsWithTypeAndNationFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ITEMSWITHTYPEFILTERTABVIEWMETA:Class = ItemsWithTypeFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ITEMSWITHVEHICLEFILTERTABVIEWMETA:Class = ItemsWithVehicleFilterTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LEGALINFOWINDOWMETA:Class = LegalInfoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LINKEDSETDETAILSCONTAINERVIEWMETA:Class = LinkedSetDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LINKEDSETDETAILSOVERLAYMETA:Class = LinkedSetDetailsOverlayMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LINKEDSETHINTSVIEWMETA:Class = LinkedSetHintsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYHEADERMETA:Class = LobbyHeaderMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYMENUMETA:Class = LobbyMenuMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYPAGEMETA:Class = LobbyPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYVEHICLEMARKERVIEWMETA:Class = LobbyVehicleMarkerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINPAGEMETA:Class = LoginPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINQUEUEWINDOWMETA:Class = LoginQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MAINTENANCECOMPONENTMETA:Class = MaintenanceComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MANUALCHAPTERVIEWMETA:Class = ManualChapterViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MANUALMAINVIEWMETA:Class = ManualMainViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MESSENGERBARMETA:Class = MessengerBarMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MINICLIENTCOMPONENTMETA:Class = MiniClientComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONAWARDWINDOWMETA:Class = MissionAwardWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONDETAILSCONTAINERVIEWMETA:Class = MissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSEVENTBOARDSVIEWMETA:Class = MissionsEventBoardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSFILTERPOPOVERVIEWMETA:Class = MissionsFilterPopoverViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSGROUPEDVIEWMETA:Class = MissionsGroupedViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSMARATHONVIEWMETA:Class = MissionsMarathonViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSPAGEMETA:Class = MissionsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSTOKENPOPOVERMETA:Class = MissionsTokenPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSVEHICLESELECTORMETA:Class = MissionsVehicleSelectorMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONSVIEWBASEMETA:Class = MissionsViewBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MODULEINFOMETA:Class = ModuleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MODULESPANELMETA:Class = ModulesPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONLISTBUTTONMETA:Class = NotificationListButtonMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONPOPUPVIEWERMETA:Class = NotificationPopUpViewerMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONSLISTMETA:Class = NotificationsListMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NYSELECTVEHICLEPOPOVERMETA:Class = NYSelectVehiclePopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PACKITEMSPOPOVERMETA:Class = PackItemsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PAGINATIONMETA:Class = PaginationMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALCASEMETA:Class = PersonalCaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONDETAILSCONTAINERVIEWMETA:Class = PersonalMissionDetailsContainerViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONFIRSTENTRYAWARDVIEWMETA:Class = PersonalMissionFirstEntryAwardViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONFIRSTENTRYVIEWMETA:Class = PersonalMissionFirstEntryViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONOPERATIONSMETA:Class = PersonalMissionOperationsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSABSTRACTINFOVIEWMETA:Class = PersonalMissionsAbstractInfoViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSAWARDSVIEWMETA:Class = PersonalMissionsAwardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSMAPVIEWMETA:Class = PersonalMissionsMapViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSOPERATIONAWARDSSCREENMETA:Class = PersonalMissionsOperationAwardsScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSPAGEMETA:Class = PersonalMissionsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALMISSIONSQUESTAWARDSCREENMETA:Class = PersonalMissionsQuestAwardScreenMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PREMIUMWINDOWMETA:Class = PremiumWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PRIMETIMEMETA:Class = PrimeTimeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEACHIEVEMENTSECTIONMETA:Class = ProfileAchievementSectionMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEAWARDSMETA:Class = ProfileAwardsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEFORMATIONSPAGEMETA:Class = ProfileFormationsPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEHOFMETA:Class = ProfileHofMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEMETA:Class = ProfileMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESECTIONMETA:Class = ProfileSectionMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESTATISTICSMETA:Class = ProfileStatisticsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESUMMARYMETA:Class = ProfileSummaryMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESUMMARYWINDOWMETA:Class = ProfileSummaryWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETABNAVIGATORMETA:Class = ProfileTabNavigatorMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEMETA:Class = ProfileTechniqueMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEPAGEMETA:Class = ProfileTechniquePageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEWINDOWMETA:Class = ProfileWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROGRESSIVEREWARDWIDGETMETA:Class = ProgressiveRewardWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROMOPREMIUMIGRWINDOWMETA:Class = PromoPremiumIgrWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PUNISHMENTDIALOGMETA:Class = PunishmentDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PVESANDBOXQUEUEWINDOWMETA:Class = PvESandboxQueueWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTRECRUITWINDOWMETA:Class = QuestRecruitWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCONTENTTABSMETA:Class = QuestsContentTabsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RALLYMAINWINDOWWITHSEARCHMETA:Class = RallyMainWindowWithSearchMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESAWARDSVIEWMETA:Class = RankedBattlesAwardsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESBATTLERESULTSMETA:Class = RankedBattlesBattleResultsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESDIVISIONPROGRESSMETA:Class = RankedBattlesDivisionProgressMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESDIVISIONQUALIFICATIONMETA:Class = RankedBattlesDivisionQualificationMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESDIVISIONSVIEWMETA:Class = RankedBattlesDivisionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESHANGARWIDGETMETA:Class = RankedBattlesHangarWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESINTROMETA:Class = RankedBattlesIntroMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESLEAGUESVIEWMETA:Class = RankedBattlesLeaguesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESPAGEMETA:Class = RankedBattlesPageMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESREWARDSLEAGUESMETA:Class = RankedBattlesRewardsLeaguesMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESREWARDSMETA:Class = RankedBattlesRewardsMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESREWARDSRANKSMETA:Class = RankedBattlesRewardsRanksMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESREWARDSYEARMETA:Class = RankedBattlesRewardsYearMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESSEASONCOMPLETEVIEWMETA:Class = RankedBattlesSeasonCompleteViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESSEASONGAPVIEWMETA:Class = RankedBattlesSeasonGapViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDBATTLESUNREACHABLEVIEWMETA:Class = RankedBattlesUnreachableViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RANKEDPRIMETIMEMETA:Class = RankedPrimeTimeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RECRUITPARAMETERSMETA:Class = RecruitParametersMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RECRUITWINDOWMETA:Class = RecruitWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REGULARITEMSTABVIEWMETA:Class = RegularItemsTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RENTALTERMSELECTIONPOPOVERMETA:Class = RentalTermSelectionPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RENTVEHICLESTABVIEWMETA:Class = RentVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHMETA:Class = ResearchMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHPANELMETA:Class = ResearchPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHVIEWMETA:Class = ResearchViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESTOREVEHICLESTABVIEWMETA:Class = RestoreVehiclesTabViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RETRAINCREWWINDOWMETA:Class = RetrainCrewWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ROLECHANGEMETA:Class = RoleChangeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ROSTERSLOTSETTINGSWINDOWMETA:Class = RosterSlotSettingsWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RSSNEWSFEEDMETA:Class = RssNewsFeedMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SENDINVITESWINDOWMETA:Class = SendInvitesWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SENIORITYAWARDSENTRYPOINTMETA:Class = SeniorityAwardsEntryPointMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SESSIONBATTLESTATSVIEWMETA:Class = SessionBattleStatsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SESSIONSTATSPOPOVERMETA:Class = SessionStatsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SESSIONVEHICLESTATSVIEWMETA:Class = SessionVehicleStatsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SHOPMETA:Class = ShopMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SIMPLEWINDOWMETA:Class = SimpleWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SKILLDROPMETA:Class = SkillDropMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SLOTSPANELMETA:Class = SlotsPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADPROMOWINDOWMETA:Class = SquadPromoWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADVIEWMETA:Class = SquadViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADWINDOWMETA:Class = SquadWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECAROUSELENVIRONMENTMETA:Class = StorageCarouselEnvironmentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYBLUEPRINTSVIEWMETA:Class = StorageCategoryBlueprintsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYCUSTOMIZATIONVIEWMETA:Class = StorageCategoryCustomizationViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYFORSELLVIEWMETA:Class = StorageCategoryForSellViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYINHANGARVIEWMETA:Class = StorageCategoryInHangarViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYPERSONALRESERVESVIEWMETA:Class = StorageCategoryPersonalReservesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGECATEGORYSTORAGEVIEWMETA:Class = StorageCategoryStorageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGEVEHICLESELECTPOPOVERMETA:Class = StorageVehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORAGEVIEWMETA:Class = StorageViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STOREACTIONSVIEWMETA:Class = StoreActionsViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORECOMPONENTMETA:Class = StoreComponentMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORETABLEMETA:Class = StoreTableMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STOREVIEWMETA:Class = StoreViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STRONGHOLDBATTLESLISTVIEWMETA:Class = StrongholdBattlesListViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STRONGHOLDVIEWMETA:Class = StrongholdViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SWITCHMODEPANELMETA:Class = SwitchModePanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SWITCHPERIPHERYWINDOWMETA:Class = SwitchPeripheryWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SYSTEMMESSAGEDIALOGMETA:Class = SystemMessageDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKCAROUSELMETA:Class = TankCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKGIRLSPOPOVERMETA:Class = TankgirlsPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKMANOPERATIONDIALOGMETA:Class = TankmanOperationDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHNICALMAINTENANCEMETA:Class = TechnicalMaintenanceMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHTREEMETA:Class = TechTreeMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TMENXPPANELMETA:Class = TmenXpPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRADEINPOPUPMETA:Class = TradeInPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRADEOFFWIDGETMETA:Class = TradeOffWidgetMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGFORMMETA:Class = TrainingFormMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGROOMBASEMETA:Class = TrainingRoomBaseMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGWINDOWMETA:Class = TrainingWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_UNBOUNDINJECTWINDOWMETA:Class = UnboundInjectWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_USEAWARDSHEETWINDOWMETA:Class = UseAwardSheetWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEBASEPREVIEWMETA:Class = VehicleBasePreviewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEBUYWINDOWMETA:Class = VehicleBuyWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECARTPOPOVERMETA:Class = VehicleCompareCartPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECOMMONVIEWMETA:Class = VehicleCompareCommonViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECONFIGURATORBASEVIEWMETA:Class = VehicleCompareConfiguratorBaseViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECONFIGURATORMAINMETA:Class = VehicleCompareConfiguratorMainMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECONFIGURATORVIEWMETA:Class = VehicleCompareConfiguratorViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPAREVIEWMETA:Class = VehicleCompareViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEINFOMETA:Class = VehicleInfoMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLELISTPOPUPMETA:Class = VehicleListPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEMODULESVIEWMETA:Class = VehicleModulesViewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPARAMETERSMETA:Class = VehicleParametersMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEW20META:Class = VehiclePreview20Meta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWBROWSETABMETA:Class = VehiclePreviewBrowseTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWBUYINGPANELMETA:Class = VehiclePreviewBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWCREWTABMETA:Class = VehiclePreviewCrewTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWFRONTLINEBUYINGPANELMETA:Class = VehiclePreviewFrontlineBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWMETA:Class = VehiclePreviewMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWMODULESTABMETA:Class = VehiclePreviewModulesTabMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWTRADEINBUYINGPANELMETA:Class = VehiclePreviewTradeInBuyingPanelMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELECTORCAROUSELMETA:Class = VehicleSelectorCarouselMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELECTORPOPUPMETA:Class = VehicleSelectorPopupMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELECTPOPOVERMETA:Class = VehicleSelectPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELLCONFIRMATIONPOPOVERMETA:Class = VehicleSellConfirmationPopoverMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELLDIALOGMETA:Class = VehicleSellDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WGNCDIALOGMETA:Class = WGNCDialogMeta;

        public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WGNCPOLLWINDOWMETA:Class = WGNCPollWindowMeta;

        public static const NET_WG_INFRASTRUCTURE_EVENTS_DRAGEVENT:Class = DragEvent;

        public static const NET_WG_INFRASTRUCTURE_EVENTS_DROPEVENT:Class = DropEvent;

        public static const NET_WG_INFRASTRUCTURE_EVENTS_FOCUSCHAINCHANGEEVENT:Class = FocusChainChangeEvent;

        public static const NET_WG_INFRASTRUCTURE_EVENTS_FOCUSEDVIEWEVENT:Class = FocusedViewEvent;

        public static const NET_WG_INFRASTRUCTURE_EVENTS_GAMEEVENT:Class = GameEvent;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATE:Class = DragDelegate;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATECONTROLLER:Class = DragDelegateController;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATE:Class = DropListDelegate;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATECTRLR:Class = DropListDelegateCtrlr;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_LOADEREX:Class = LoaderEx;

        public static const NET_WG_INFRASTRUCTURE_HELPERS_INTERFACES_IDROPLISTDELEGATE:Class = IDropListDelegate;

        public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISORTABLE:Class = ISortable;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALBUILDER:Class = TutorialBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALCUSTOMHINTBUILDER:Class = TutorialCustomHintBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALEFFECTBUILDER:Class = TutorialEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALHINTBUILDER:Class = TutorialHintBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALOVERLAYBUILDER:Class = TutorialOverlayBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALAMMUNITIONEFFECTBUILDER:Class = TutorialAmmunitionEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALCLIPEFFECTBUILDER:Class = TutorialClipEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALENABLEDEFFECTBUILDER:Class = TutorialEnabledEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALHANGARTWEENEFFECTBUILDER:Class = TutorialHangarTweenEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALHANGARVISIBILITYEFFECTBUILDER:Class = TutorialHangarVisibilityEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALHIGHLIGHTEFFECTBUILDER:Class = TutorialHighlightEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALLOBBYEFFECTBUILDER:Class = TutorialLobbyEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALOVERLAYEFFECTBUILDER:Class = TutorialOverlayEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALQUESTVISIBILITYEFFECTBUILDER:Class = TutorialQuestVisibilityEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALTWEENEFFECTBUILDER:Class = TutorialTweenEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TUTORIALVISIBILITYEFFECTBUILDER:Class = TutorialVisibilityEffectBuilder;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_BOOTCAMP_TWEENFACTORY:Class = TweenFactory;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALHELPBTNCONTROLLER:Class = TutorialHelpBtnController;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALVIEWHELPBTNCTRLLR:Class = TutorialViewHelpBtnCtrllr;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALWINDOWHELPBTNCTRLLR:Class = TutorialWindowHelpBtnCtrllr;

        public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_INTERFACES_ITUTORIALHELPBTNCONTROLLER:Class = ITutorialHelpBtnController;

        public function ClassManagerMeta()
        {
            super();
        }
    }
}
