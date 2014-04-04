package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.Aliases;
   import net.wg.data.ContainerConstants;
   import net.wg.data.InspectableDataProvider;
   import net.wg.data.VO.AchievementItemVO;
   import net.wg.data.VO.AnimationObject;
   import net.wg.data.VO.BattleResultsQuestVO;
   import net.wg.data.VO.ColorScheme;
   import net.wg.data.VO.ExtendedUserVO;
   import net.wg.data.VO.IconVO;
   import net.wg.data.VO.PointVO;
   import net.wg.data.VO.PremiumFormModel;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.data.VO.SellDialogElement;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.data.VO.SeparateItem;
   import net.wg.data.VO.ShopSubFilterData;
   import net.wg.data.VO.ShopVehicleFilterElementData;
   import net.wg.data.VO.StoreTableData;
   import net.wg.data.VO.StoreTableVO;
   import net.wg.data.VO.TrainingFormRendererVO;
   import net.wg.data.VO.TrainingRoomInfoVO;
   import net.wg.data.VO.TrainingRoomListVO;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.VO.TrainingWindowVO;
   import net.wg.data.VO.TweenPropertiesVO;
   import net.wg.data.VO.UserVO;
   import net.wg.data.VO.WalletStatusVO;
   import net.wg.data.VO.generated.ShopNationFilterData;
   import net.wg.data.VoDAAPIDataProvider;
   import net.wg.data.components.AbstractContextItemGenerator;
   import net.wg.data.components.AccordionRendererData;
   import net.wg.data.components.BattleResultsCIGenerator;
   import net.wg.data.components.BattleSessionCIGenerator;
   import net.wg.data.components.ContextItem;
   import net.wg.data.components.ContextItemGenerator;
   import net.wg.data.components.StoreMenuViewData;
   import net.wg.data.components.UserContextItem;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.ContainerTypes;
   import net.wg.data.constants.ContextMenuConstants;
   import net.wg.data.constants.Currencies;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.Dialogs;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.EngineMethods;
   import net.wg.data.constants.FittingTypes;
   import net.wg.data.constants.GunTypes;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.ItemTypes;
   import net.wg.data.constants.KeysMap;
   import net.wg.data.constants.Locales;
   import net.wg.data.constants.QuestsStates;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.TooltipTags;
   import net.wg.data.constants.Tooltips;
   import net.wg.data.constants.ValObject;
   import net.wg.data.constants.VehicleState;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ITEM_TYPE;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.data.constants.generated.STORE_TYPES;
   import net.wg.data.gui_items.FittingItem;
   import net.wg.data.gui_items.GUIItem;
   import net.wg.data.gui_items.ItemsUtils;
   import net.wg.data.gui_items.Tankman;
   import net.wg.data.gui_items.TankmanSkill;
   import net.wg.data.gui_items.Vehicle;
   import net.wg.data.gui_items.VehicleProfile;
   import net.wg.data.gui_items.dossier.AccountDossier;
   import net.wg.data.gui_items.dossier.Achievement;
   import net.wg.data.gui_items.dossier.Dossier;
   import net.wg.data.gui_items.dossier.TankmanDossier;
   import net.wg.data.gui_items.dossier.VehicleDossier;
   import net.wg.data.managers.impl.DialogDispatcher;
   import net.wg.data.managers.impl.NotifyProperties;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.managers.impl.Tween;
   import net.wg.data.utilData.FormattedInteger;
   import net.wg.data.utilData.ItemPrice;
   import net.wg.data.utilData.TankmanRoleLevel;
   import net.wg.data.utilData.TankmanSlot;
   import net.wg.gui.components.advanced.Accordion;
   import net.wg.gui.components.advanced.AmmunitionButton;
   import net.wg.gui.components.advanced.BlinkingButton;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ButtonIconLoader;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.advanced.ContentTabRenderer;
   import net.wg.gui.components.advanced.CooldownAnimationController;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.gui.components.advanced.DoubleProgressBar;
   import net.wg.gui.components.advanced.ExtraModuleIcon;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.advanced.HelpLayoutControl;
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import net.wg.gui.components.advanced.ModuleIcon;
   import net.wg.gui.components.advanced.PortraitItemRenderer;
   import net.wg.gui.components.advanced.ScalableIconButton;
   import net.wg.gui.components.advanced.ScalableIconWrapper;
   import net.wg.gui.components.advanced.ShellButton;
   import net.wg.gui.components.advanced.ShellsSet;
   import net.wg.gui.components.advanced.SkillsItemRenderer;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.advanced.SortingButton;
   import net.wg.gui.components.advanced.SortingButtonInfo;
   import net.wg.gui.components.advanced.TabButton;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.advanced.TextArea;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.advanced.ToggleButton;
   import net.wg.gui.components.advanced.UnClickableShadowBG;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.carousels.AchievementCarousel;
   import net.wg.gui.components.carousels.CarouselBase;
   import net.wg.gui.components.carousels.ICarouselItemRenderer;
   import net.wg.gui.components.carousels.PortraitsCarousel;
   import net.wg.gui.components.carousels.SkillsCarousel;
   import net.wg.gui.components.common.BaseLogoView;
   import net.wg.gui.components.common.CursorManagedContainer;
   import net.wg.gui.components.common.MainViewContainer;
   import net.wg.gui.components.common.ManagedContainer;
   import net.wg.gui.components.common.VehicleMarkerAlly;
   import net.wg.gui.components.common.VehicleMarkerEnemy;
   import net.wg.gui.components.common.WaitingManagedContainer;
   import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
   import net.wg.gui.components.common.containers.Group;
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.gui.components.common.containers.GroupLayout;
   import net.wg.gui.components.common.containers.HorizontalGroupLayout;
   import net.wg.gui.components.common.containers.VerticalGroupLayout;
   import net.wg.gui.components.common.crosshair.ClipQuantityBar;
   import net.wg.gui.components.common.crosshair.CrosshairBase;
   import net.wg.gui.components.common.crosshair.CrosshairPanelArcade;
   import net.wg.gui.components.common.crosshair.CrosshairPanelBase;
   import net.wg.gui.components.common.crosshair.CrosshairPanelPostmortem;
   import net.wg.gui.components.common.crosshair.CrosshairPanelSniper;
   import net.wg.gui.components.common.crosshair.CrosshairPanelStrategic;
   import net.wg.gui.components.common.crosshair.CrosshairSniper;
   import net.wg.gui.components.common.crosshair.CrosshairStrategic;
   import net.wg.gui.components.common.crosshair.ReloadingTimer;
   import net.wg.gui.components.common.cursor.Cursor;
   import net.wg.gui.components.common.cursor.base.BaseInfo;
   import net.wg.gui.components.common.cursor.base.DroppingCursor;
   import net.wg.gui.components.common.markers.AnimateExplosion;
   import net.wg.gui.components.common.markers.DamageLabel;
   import net.wg.gui.components.common.markers.HealthBar;
   import net.wg.gui.components.common.markers.HealthBarAnimatedLabel;
   import net.wg.gui.components.common.markers.HealthBarAnimatedPart;
   import net.wg.gui.components.common.markers.VehicleActionMarker;
   import net.wg.gui.components.common.markers.VehicleMarker;
   import net.wg.gui.components.common.markers.data.HPDisplayMode;
   import net.wg.gui.components.common.markers.data.VehicleMarkerFlags;
   import net.wg.gui.components.common.markers.data.VehicleMarkerSettings;
   import net.wg.gui.components.common.markers.data.VehicleMarkerVO;
   import net.wg.gui.components.common.ticker.RSSEntryVO;
   import net.wg.gui.components.common.ticker.Ticker;
   import net.wg.gui.components.common.ticker.TickerItem;
   import net.wg.gui.components.common.video.NetStreamStatusCode;
   import net.wg.gui.components.common.video.NetStreamStatusLevel;
   import net.wg.gui.components.common.video.PlayerStatus;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import net.wg.gui.components.common.video.advanced.AbstractPlayerController;
   import net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar;
   import net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer;
   import net.wg.gui.components.common.video.advanced.ControlBarController;
   import net.wg.gui.components.common.video.advanced.KeyboardController;
   import net.wg.gui.components.common.video.advanced.ProgressBarController;
   import net.wg.gui.components.common.video.advanced.ProgressBarEvent;
   import net.wg.gui.components.common.video.advanced.ProgressBarSlider;
   import net.wg.gui.components.common.video.advanced.SliderPlayerProgressBar;
   import net.wg.gui.components.common.video.advanced.VideoPlayerAnimationManager;
   import net.wg.gui.components.common.video.advanced.VideoPlayerControlBar;
   import net.wg.gui.components.common.video.advanced.VideoPlayerTitleBar;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.common.waiting.WaitingMc;
   import net.wg.gui.components.common.waiting.WaitingView;
   import net.wg.gui.components.common.waiting.events.WaitingChangeVisibilityEvent;
   import net.wg.gui.components.controls.AccordionSoundRenderer;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Carousel;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.ContextMenu;
   import net.wg.gui.components.controls.ContextMenuItem;
   import net.wg.gui.components.controls.ContextMenuItemSeparate;
   import net.wg.gui.components.controls.CoreListEx;
   import net.wg.gui.components.controls.DragableListItemRenderer;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.DropDownListItemRendererSound;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.DynamicScrollingListEx;
   import net.wg.gui.components.controls.FightButtonSelect;
   import net.wg.gui.components.controls.FightListItemRenderer;
   import net.wg.gui.components.controls.GlowArrowAsset;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.IProgressBar;
   import net.wg.gui.components.controls.IconButton;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.ListItemRedererImageText;
   import net.wg.gui.components.controls.ListItemRendererWithFocusOnDis;
   import net.wg.gui.components.controls.MainMenuButton;
   import net.wg.gui.components.controls.NationDropDownMenu;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.ProgressBar;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.components.controls.ReadOnlyScrollingList;
   import net.wg.gui.components.controls.RegionDropdownMenu;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListAutoScroll;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.ScrollingListPx;
   import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SliderBg;
   import net.wg.gui.components.controls.SliderKeyPoint;
   import net.wg.gui.components.controls.SortButton;
   import net.wg.gui.components.controls.SortableScrollingList;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.StepSlider;
   import net.wg.gui.components.controls.TankmanTrainingButton;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UILoaderCut;
   import net.wg.gui.components.controls.UnitCommanderStats;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.Voice;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.gui.components.controls.WgScrollingList;
   import net.wg.gui.components.controls.achievements.AchievementCommon;
   import net.wg.gui.components.controls.achievements.AchievementCommonVehicle;
   import net.wg.gui.components.controls.achievements.AchievementCounter;
   import net.wg.gui.components.controls.achievements.AchievementCounterSmall;
   import net.wg.gui.components.controls.achievements.AchievementDivision;
   import net.wg.gui.components.controls.achievements.AchievementEvent;
   import net.wg.gui.components.controls.achievements.AchievementProgress;
   import net.wg.gui.components.controls.achievements.AchievementProgressBar;
   import net.wg.gui.components.controls.achievements.AchievementProgressComponent;
   import net.wg.gui.components.controls.achievements.BeigeCounter;
   import net.wg.gui.components.controls.achievements.CounterComponent;
   import net.wg.gui.components.controls.achievements.GreyRibbonCounter;
   import net.wg.gui.components.controls.achievements.RedCounter;
   import net.wg.gui.components.controls.achievements.SmallCounter;
   import net.wg.gui.components.controls.achievements.YellowRibbonCounter;
   import net.wg.gui.components.controls.events.ScrollBarEvent;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.components.icons.PlayerActionMarker;
   import net.wg.gui.components.icons.PlayerActionMarkerController;
   import net.wg.gui.components.icons.SquadIcon;
   import net.wg.gui.components.popOvers.PopOver;
   import net.wg.gui.components.popOvers.PopOverConst;
   import net.wg.gui.components.popOvers.PopoverContentPadding;
   import net.wg.gui.components.popOvers.PopoverInternalLayout;
   import net.wg.gui.components.popOvers.SmartPopOver;
   import net.wg.gui.components.popOvers.SmartPopOverExternalLayout;
   import net.wg.gui.components.popOvers.SmartPopOverLayoutInfo;
   import net.wg.gui.components.tooltips.AchievementsCustomBlockItem;
   import net.wg.gui.components.tooltips.ExtraModuleInfo;
   import net.wg.gui.components.tooltips.IgrQuestBlock;
   import net.wg.gui.components.tooltips.IgrQuestProgressBlock;
   import net.wg.gui.components.tooltips.ModuleItem;
   import net.wg.gui.components.tooltips.Separator;
   import net.wg.gui.components.tooltips.Status;
   import net.wg.gui.components.tooltips.SuitableVehicleBlockItem;
   import net.wg.gui.components.tooltips.ToolTipAchievement;
   import net.wg.gui.components.tooltips.ToolTipBase;
   import net.wg.gui.components.tooltips.ToolTipBuySkill;
   import net.wg.gui.components.tooltips.ToolTipComplex;
   import net.wg.gui.components.tooltips.ToolTipEquipment;
   import net.wg.gui.components.tooltips.ToolTipFinalStats;
   import net.wg.gui.components.tooltips.ToolTipHistoricalAmmo;
   import net.wg.gui.components.tooltips.ToolTipHistoricalModules;
   import net.wg.gui.components.tooltips.ToolTipIGR;
   import net.wg.gui.components.tooltips.ToolTipMap;
   import net.wg.gui.components.tooltips.ToolTipRSSNews;
   import net.wg.gui.components.tooltips.ToolTipSelectedVehicle;
   import net.wg.gui.components.tooltips.ToolTipSettingsControl;
   import net.wg.gui.components.tooltips.ToolTipSkill;
   import net.wg.gui.components.tooltips.ToolTipSpecial;
   import net.wg.gui.components.tooltips.ToolTipSuitableVehicle;
   import net.wg.gui.components.tooltips.ToolTipTankClass;
   import net.wg.gui.components.tooltips.ToolTipTankmen;
   import net.wg.gui.components.tooltips.ToolTipVehicle;
   import net.wg.gui.components.tooltips.TooltipUnitCommand;
   import net.wg.gui.components.tooltips.VO.AchievementVO;
   import net.wg.gui.components.tooltips.VO.Dimension;
   import net.wg.gui.components.tooltips.VO.EquipmentParamVO;
   import net.wg.gui.components.tooltips.VO.EquipmentVO;
   import net.wg.gui.components.tooltips.VO.ExtraModuleInfoVO;
   import net.wg.gui.components.tooltips.VO.HistoricalModulesVO;
   import net.wg.gui.components.tooltips.VO.IgrVO;
   import net.wg.gui.components.tooltips.VO.MapVO;
   import net.wg.gui.components.tooltips.VO.ModuleVO;
   import net.wg.gui.components.tooltips.VO.SettingsControlVO;
   import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
   import net.wg.gui.components.tooltips.VO.TankmenVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipSkillVO;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipVehicleSelectedVO;
   import net.wg.gui.components.tooltips.VO.UnitCommandVO;
   import net.wg.gui.components.tooltips.VO.VehicleBaseVO;
   import net.wg.gui.components.tooltips.VO.VehicleVO;
   import net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
   import net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.windows.ModuleInfo;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.gui.crewOperations.CrewOperationEvent;
   import net.wg.gui.crewOperations.CrewOperationInfoVO;
   import net.wg.gui.crewOperations.CrewOperationWarningVO;
   import net.wg.gui.crewOperations.CrewOperationsIRFooter;
   import net.wg.gui.crewOperations.CrewOperationsIRenderer;
   import net.wg.gui.crewOperations.CrewOperationsInitVO;
   import net.wg.gui.crewOperations.CrewOperationsPopOver;
   import net.wg.gui.cyberSport.CSConstants;
   import net.wg.gui.cyberSport.CSInvalidationType;
   import net.wg.gui.cyberSport.CyberSportMainWindow;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import net.wg.gui.cyberSport.controls.ButtonDnmIconSlim;
   import net.wg.gui.cyberSport.controls.CSCandidatesScrollingList;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.cyberSport.controls.CSVehicleButtonLevels;
   import net.wg.gui.cyberSport.controls.CandidateItemRenderer;
   import net.wg.gui.cyberSport.controls.CommandRenderer;
   import net.wg.gui.cyberSport.controls.DoubleSlider;
   import net.wg.gui.cyberSport.controls.DynamicRangeVehicles;
   import net.wg.gui.cyberSport.controls.GrayButtonText;
   import net.wg.gui.cyberSport.controls.GrayTransparentButton;
   import net.wg.gui.cyberSport.controls.ManualSearchRenderer;
   import net.wg.gui.cyberSport.controls.ManualSearchScrollingList;
   import net.wg.gui.cyberSport.controls.MedalVehicleVO;
   import net.wg.gui.cyberSport.controls.NavigationBlock;
   import net.wg.gui.cyberSport.controls.RangeViewComponent;
   import net.wg.gui.cyberSport.controls.ReadyMsg;
   import net.wg.gui.cyberSport.controls.RosterButtonGroup;
   import net.wg.gui.cyberSport.controls.RosterSettingsNumerationBlock;
   import net.wg.gui.cyberSport.controls.SelectedVehiclesMsg;
   import net.wg.gui.cyberSport.controls.SettingRosterVO;
   import net.wg.gui.cyberSport.controls.SettingsIcons;
   import net.wg.gui.cyberSport.controls.SlotDropIndicator;
   import net.wg.gui.cyberSport.controls.VehicleSelector;
   import net.wg.gui.cyberSport.controls.VehicleSelectorFilter;
   import net.wg.gui.cyberSport.controls.VehicleSelectorItemRenderer;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;
   import net.wg.gui.cyberSport.data.ManualSearchDataProvider;
   import net.wg.gui.cyberSport.helpers.CSDragDropDelegate;
   import net.wg.gui.cyberSport.helpers.CSDragDropListDelegateController;
   import net.wg.gui.cyberSport.helpers.CSPlayerCIGenerator;
   import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
   import net.wg.gui.cyberSport.interfaces.IManualSearchRenderer;
   import net.wg.gui.cyberSport.interfaces.IManualSearchScrollingList;
   import net.wg.gui.cyberSport.popups.VehicleSelectorPopup;
   import net.wg.gui.cyberSport.views.AnimatedRosterSettingsView;
   import net.wg.gui.cyberSport.views.IntroView;
   import net.wg.gui.cyberSport.views.RangeRosterSettingsView;
   import net.wg.gui.cyberSport.views.RosterSettingsView;
   import net.wg.gui.cyberSport.views.RosterSlotSettingsWindow;
   import net.wg.gui.cyberSport.views.UnitView;
   import net.wg.gui.cyberSport.views.UnitsListView;
   import net.wg.gui.cyberSport.views.autoSearch.CSAutoSearchMainView;
   import net.wg.gui.cyberSport.views.autoSearch.ConfirmationReadinessStatus;
   import net.wg.gui.cyberSport.views.autoSearch.ErrorState;
   import net.wg.gui.cyberSport.views.autoSearch.SearchCommands;
   import net.wg.gui.cyberSport.views.autoSearch.SearchEnemy;
   import net.wg.gui.cyberSport.views.autoSearch.StateViewBase;
   import net.wg.gui.cyberSport.views.autoSearch.WaitingPlayers;
   import net.wg.gui.cyberSport.views.events.CyberSportEvent;
   import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
   import net.wg.gui.cyberSport.views.unit.ChatSection;
   import net.wg.gui.cyberSport.views.unit.JoinUnitSection;
   import net.wg.gui.cyberSport.views.unit.SimpleSlotRenderer;
   import net.wg.gui.cyberSport.views.unit.SlotRenderer;
   import net.wg.gui.cyberSport.views.unit.TeamSection;
   import net.wg.gui.cyberSport.views.unit.WaitListSection;
   import net.wg.gui.cyberSport.vo.ActionButtonVO;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.gui.cyberSport.vo.CSCommandVO;
   import net.wg.gui.cyberSport.vo.NavigationBlockVO;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;
   import net.wg.gui.cyberSport.vo.UnitShortVO;
   import net.wg.gui.cyberSport.vo.UnitSlotVO;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.cyberSport.vo.VehicleVO;
   import net.wg.gui.events.AccordionRendererEvent;
   import net.wg.gui.events.ArenaVoipSettingsEvent;
   import net.wg.gui.events.ContextMenuEvent;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.events.DeviceEvent;
   import net.wg.gui.events.EquipmentEvent;
   import net.wg.gui.events.FightButtonEvent;
   import net.wg.gui.events.FinalStatisticEvent;
   import net.wg.gui.events.HeaderButtonBarEvent;
   import net.wg.gui.events.HeaderEvent;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.events.LobbyTDispatcherEvent;
   import net.wg.gui.events.ManagedContainerEvent;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.events.ModuleInfoEvent;
   import net.wg.gui.events.NumericStepperEvent;
   import net.wg.gui.events.ParamsEvent;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.events.QuestEvent;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.events.ShellRendererEvent;
   import net.wg.gui.events.ShowDialogEvent;
   import net.wg.gui.events.StateManagerEvent;
   import net.wg.gui.events.TimelineEvent;
   import net.wg.gui.events.TrainingEvent;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.gameloading.GameLoading;
   import net.wg.gui.historicalBattles.HistoricalBattlesListWindow;
   import net.wg.gui.historicalBattles.controls.BattleCarouselItemRenderer;
   import net.wg.gui.historicalBattles.controls.BattlesCarousel;
   import net.wg.gui.historicalBattles.controls.SimpleVehicleList;
   import net.wg.gui.historicalBattles.controls.TeamsVehicleList;
   import net.wg.gui.historicalBattles.controls.VehicleListItemRenderer;
   import net.wg.gui.historicalBattles.data.BattleListItemVO;
   import net.wg.gui.historicalBattles.data.HistoricalBattleVO;
   import net.wg.gui.historicalBattles.data.VehicleListItemVO;
   import net.wg.gui.historicalBattles.events.TeamsVehicleListEvent;
   import net.wg.gui.intro.IntroInfoVO;
   import net.wg.gui.intro.IntroPage;
   import net.wg.gui.lobby.GUIEditor.ChangePropertyEvent;
   import net.wg.gui.lobby.GUIEditor.ComponentCreateEvent;
   import net.wg.gui.lobby.GUIEditor.ComponentInfoVo;
   import net.wg.gui.lobby.GUIEditor.ComponentListItemRenderer;
   import net.wg.gui.lobby.GUIEditor.ComponentsPanel;
   import net.wg.gui.lobby.GUIEditor.EditablePropertyListItemRenderer;
   import net.wg.gui.lobby.GUIEditor.GEComponentVO;
   import net.wg.gui.lobby.GUIEditor.GEDesignerWindow;
   import net.wg.gui.lobby.GUIEditor.GEInspectWindow;
   import net.wg.gui.lobby.GUIEditor.GUIEditorHelper;
   import net.wg.gui.lobby.GUIEditor.data.ComponentProperties;
   import net.wg.gui.lobby.GUIEditor.data.ComponentPropertyVO;
   import net.wg.gui.lobby.GUIEditor.data.PropTypes;
   import net.wg.gui.lobby.GUIEditor.views.EventsView;
   import net.wg.gui.lobby.GUIEditor.views.InspectorView;
   import net.wg.gui.lobby.LobbyPage;
   import net.wg.gui.lobby.barracks.Barracks;
   import net.wg.gui.lobby.barracks.BarracksForm;
   import net.wg.gui.lobby.barracks.BarracksItemRenderer;
   import net.wg.gui.lobby.battleResults.BattleResults;
   import net.wg.gui.lobby.battleResults.BattleResultsEventRenderer;
   import net.wg.gui.lobby.battleResults.CommonStats;
   import net.wg.gui.lobby.battleResults.CustomAchievement;
   import net.wg.gui.lobby.battleResults.DetailsBlock;
   import net.wg.gui.lobby.battleResults.DetailsStats;
   import net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;
   import net.wg.gui.lobby.battleResults.EfficiencyRenderer;
   import net.wg.gui.lobby.battleResults.MedalsList;
   import net.wg.gui.lobby.battleResults.ProgressElement;
   import net.wg.gui.lobby.battleResults.TankStatsView;
   import net.wg.gui.lobby.battleResults.TeamMemberItemRenderer;
   import net.wg.gui.lobby.battleResults.TeamMemberStatsView;
   import net.wg.gui.lobby.battleResults.TeamStats;
   import net.wg.gui.lobby.battleResults.TeamStatsList;
   import net.wg.gui.lobby.battleResults.VehicleDetails;
   import net.wg.gui.lobby.battleloading.BattleLoading;
   import net.wg.gui.lobby.battleloading.BattleLoadingForm;
   import net.wg.gui.lobby.battleloading.PlayerItemRenderer;
   import net.wg.gui.lobby.battleloading.constants.PlayerStatus;
   import net.wg.gui.lobby.battleloading.constants.VehicleStatus;
   import net.wg.gui.lobby.battleloading.data.EnemyVehiclesDataProvider;
   import net.wg.gui.lobby.battleloading.data.TeamVehiclesDataProvider;
   import net.wg.gui.lobby.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
   import net.wg.gui.lobby.battlequeue.BattleQueue;
   import net.wg.gui.lobby.battlequeue.BattleQueueItemRenderer;
   import net.wg.gui.lobby.browser.BrowserActionBtn;
   import net.wg.gui.lobby.browser.BrowserEvent;
   import net.wg.gui.lobby.browser.BrowserHitArea;
   import net.wg.gui.lobby.browser.BrowserWindow;
   import net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleSettingsVO;
   import net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleWindow;
   import net.wg.gui.lobby.confirmModuleWindow.ModuleInfoVo;
   import net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView;
   import net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView;
   import net.wg.gui.lobby.customization.CamoDropButton;
   import net.wg.gui.lobby.customization.CamouflageGroupView;
   import net.wg.gui.lobby.customization.CamouflageSectionView;
   import net.wg.gui.lobby.customization.CustomizationEvent;
   import net.wg.gui.lobby.customization.EmblemLeftSectionView;
   import net.wg.gui.lobby.customization.EmblemRightSectionView;
   import net.wg.gui.lobby.customization.InscriptionLeftSectionView;
   import net.wg.gui.lobby.customization.InscriptionRightSectionView;
   import net.wg.gui.lobby.customization.VehicleCustomization;
   import net.wg.gui.lobby.customization.data.CamouflagesDataProvider;
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
   import net.wg.gui.lobby.customization.renderers.CamoDemoRenderer;
   import net.wg.gui.lobby.customization.renderers.CamouflageItemRenderer;
   import net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer;
   import net.wg.gui.lobby.customization.renderers.InscriptionItemRenderer;
   import net.wg.gui.lobby.customization.renderers.PriceItemRenderer;
   import net.wg.gui.lobby.customization.renderers.RendererBorder;
   import net.wg.gui.lobby.customization.renderers.RentalPackageItemRenderer;
   import net.wg.gui.lobby.customization.renderers.SectionItemRenderer;
   import net.wg.gui.lobby.customization.renderers.TextureItemRenderer;
   import net.wg.gui.lobby.demonstration.DemonstratorWindow;
   import net.wg.gui.lobby.demonstration.MapItemRenderer;
   import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;
   import net.wg.gui.lobby.dialogs.DemountDeviceDialog;
   import net.wg.gui.lobby.dialogs.DestroyDeviceDialog;
   import net.wg.gui.lobby.dialogs.DismissTankmanDialog;
   import net.wg.gui.lobby.dialogs.FreeXPInfoWindow;
   import net.wg.gui.lobby.dialogs.IconDialog;
   import net.wg.gui.lobby.dialogs.IconPriceDialog;
   import net.wg.gui.lobby.dialogs.ItemStatusData;
   import net.wg.gui.lobby.dialogs.PriceMc;
   import net.wg.gui.lobby.dialogs.SimpleDialog;
   import net.wg.gui.lobby.eliteWindow.EliteWindow;
   import net.wg.gui.lobby.hangar.CrewDropDownEvent;
   import net.wg.gui.lobby.hangar.Hangar;
   import net.wg.gui.lobby.hangar.IgrLabel;
   import net.wg.gui.lobby.hangar.Params;
   import net.wg.gui.lobby.hangar.ParamsListener;
   import net.wg.gui.lobby.hangar.ParamsVO;
   import net.wg.gui.lobby.hangar.ResearchPanel;
   import net.wg.gui.lobby.hangar.TankParam;
   import net.wg.gui.lobby.hangar.TmenXpPanel;
   import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
   import net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot;
   import net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;
   import net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;
   import net.wg.gui.lobby.hangar.ammunitionPanel.FittingListItemRenderer;
   import net.wg.gui.lobby.hangar.ammunitionPanel.FittingSelect;
   import net.wg.gui.lobby.hangar.ammunitionPanel.HistoricalModulesOverlay;
   import net.wg.gui.lobby.hangar.ammunitionPanel.ModuleSlot;
   import net.wg.gui.lobby.hangar.crew.Crew;
   import net.wg.gui.lobby.hangar.crew.CrewItemRenderer;
   import net.wg.gui.lobby.hangar.crew.CrewScrollingList;
   import net.wg.gui.lobby.hangar.crew.IconsProps;
   import net.wg.gui.lobby.hangar.crew.RecruitItemRenderer;
   import net.wg.gui.lobby.hangar.crew.RecruitRendererVO;
   import net.wg.gui.lobby.hangar.crew.SkillsVO;
   import net.wg.gui.lobby.hangar.crew.SmallSkillItemRenderer;
   import net.wg.gui.lobby.hangar.crew.TankmenIcons;
   import net.wg.gui.lobby.hangar.crew.TextObject;
   import net.wg.gui.lobby.hangar.maintenance.AmmoBlockOverlay;
   import net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
   import net.wg.gui.lobby.hangar.maintenance.EquipmentListItemRenderer;
   import net.wg.gui.lobby.hangar.maintenance.MaintenanceDropDown;
   import net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;
   import net.wg.gui.lobby.hangar.maintenance.ShellItemRenderer;
   import net.wg.gui.lobby.hangar.maintenance.ShellListItemRenderer;
   import net.wg.gui.lobby.hangar.maintenance.TechnicalMaintenance;
   import net.wg.gui.lobby.hangar.maintenance.data.HistoricalAmmoVO;
   import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO;
   import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
   import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
   import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
   import net.wg.gui.lobby.hangar.tcarousel.ClanLockUI;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
   import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
   import net.wg.gui.lobby.hangar.tcarousel.helper.VehicleCarouselVOBuilder;
   import net.wg.gui.lobby.hangar.tcarousel.helper.VehicleCarouselVOManager;
   import net.wg.gui.lobby.header.AccountInfo;
   import net.wg.gui.lobby.header.FightButton;
   import net.wg.gui.lobby.header.FightButtonFancyRenderer;
   import net.wg.gui.lobby.header.FightButtonFancySelect;
   import net.wg.gui.lobby.header.HeaderButtonBar;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.MainMenu;
   import net.wg.gui.lobby.header.QuestsControl;
   import net.wg.gui.lobby.header.ServerStats;
   import net.wg.gui.lobby.header.ServerVO;
   import net.wg.gui.lobby.header.TankPanel;
   import net.wg.gui.lobby.header.TutorialControl;
   import net.wg.gui.lobby.menu.LobbyMenu;
   import net.wg.gui.lobby.menu.LobbyMenuForm;
   import net.wg.gui.lobby.messengerBar.MessengerBar;
   import net.wg.gui.lobby.messengerBar.NotificationListButton;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelButton;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelCarouselScrollBar;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelList;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
   import net.wg.gui.lobby.moduleInfo.ModuleEffects;
   import net.wg.gui.lobby.moduleInfo.ModuleParameters;
   import net.wg.gui.lobby.premiumForm.DiscountPrice;
   import net.wg.gui.lobby.premiumForm.PremiumForm;
   import net.wg.gui.lobby.premiumForm.PremiumFormItemRenderer;
   import net.wg.gui.lobby.profile.Profile;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.ProfileInvalidationTypes;
   import net.wg.gui.lobby.profile.ProfileMenuInfoVO;
   import net.wg.gui.lobby.profile.ProfileSectionsImporter;
   import net.wg.gui.lobby.profile.ProfileTabNavigator;
   import net.wg.gui.lobby.profile.SectionInfo;
   import net.wg.gui.lobby.profile.SectionViewInfo;
   import net.wg.gui.lobby.profile.SectionsDataUtil;
   import net.wg.gui.lobby.profile.UserInfoForm;
   import net.wg.gui.lobby.profile.components.AdvancedLineDescrIconText;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import net.wg.gui.lobby.profile.components.BattlesTypeDropdown;
   import net.wg.gui.lobby.profile.components.CenteredLineIconText;
   import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
   import net.wg.gui.lobby.profile.components.DashLine;
   import net.wg.gui.lobby.profile.components.DashLineTextItem;
   import net.wg.gui.lobby.profile.components.DataViewStack;
   import net.wg.gui.lobby.profile.components.GradientLineButtonBar;
   import net.wg.gui.lobby.profile.components.HidableScrollBar;
   import net.wg.gui.lobby.profile.components.ICounter;
   import net.wg.gui.lobby.profile.components.ILditInfo;
   import net.wg.gui.lobby.profile.components.IResizableContent;
   import net.wg.gui.lobby.profile.components.LditBattles;
   import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
   import net.wg.gui.lobby.profile.components.LditValued;
   import net.wg.gui.lobby.profile.components.LineButtonBar;
   import net.wg.gui.lobby.profile.components.LineDescrIconText;
   import net.wg.gui.lobby.profile.components.LineIconText;
   import net.wg.gui.lobby.profile.components.LineTextComponent;
   import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
   import net.wg.gui.lobby.profile.components.ProfileDashLineTextItem;
   import net.wg.gui.lobby.profile.components.ProfileFooter;
   import net.wg.gui.lobby.profile.components.ProfileMedalsList;
   import net.wg.gui.lobby.profile.components.ProfilePageFooter;
   import net.wg.gui.lobby.profile.components.ProfileWindowFooter;
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
   import net.wg.gui.lobby.profile.components.ResizableScrollPane;
   import net.wg.gui.lobby.profile.components.ResizableTileList;
   import net.wg.gui.lobby.profile.components.ResizableViewStack;
   import net.wg.gui.lobby.profile.components.ScrollPane;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import net.wg.gui.lobby.profile.components.TechMasteryIcon;
   import net.wg.gui.lobby.profile.components.TestTrack;
   import net.wg.gui.lobby.profile.components.UnderlinedText;
   import net.wg.gui.lobby.profile.components.UserDateFooter;
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
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   import net.wg.gui.lobby.profile.data.ProfileBaseInfoVO;
   import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
   import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.headerBar.ProfileHeaderButtonBar;
   import net.wg.gui.lobby.profile.headerBar.ProfileTabButton;
   import net.wg.gui.lobby.profile.headerBar.ProfileTabButtonBg;
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
   import net.wg.gui.lobby.profile.pages.statistics.AxisPointLevels;
   import net.wg.gui.lobby.profile.pages.statistics.AxisPointNations;
   import net.wg.gui.lobby.profile.pages.statistics.AxisPointTypes;
   import net.wg.gui.lobby.profile.pages.statistics.CommonStatistics;
   import net.wg.gui.lobby.profile.pages.statistics.LevelBarChartItem;
   import net.wg.gui.lobby.profile.pages.statistics.LevelsStatisticChart;
   import net.wg.gui.lobby.profile.pages.statistics.NationBarChartItem;
   import net.wg.gui.lobby.profile.pages.statistics.NationsStatisticsChart;
   import net.wg.gui.lobby.profile.pages.statistics.ProfileStatistics;
   import net.wg.gui.lobby.profile.pages.statistics.ProfileStatisticsVO;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartInitializer;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartLayout;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChartAxis;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsChartItemAnimClient;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsLayoutManager;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsTooltipDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.TfContainer;
   import net.wg.gui.lobby.profile.pages.statistics.TypeBarChartItem;
   import net.wg.gui.lobby.profile.pages.statistics.TypesStatisticsChart;
   import net.wg.gui.lobby.profile.pages.statistics.body.BodyContainer;
   import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsGroup;
   import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsView;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedLabelDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsLabelDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsUnit;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsUnitVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsView;
   import net.wg.gui.lobby.profile.pages.statistics.body.ProfileStatisticsDetailedVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticChartsInitDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsBodyVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsChartsTabDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsDashLineTextItemIRenderer;
   import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsLabelDataVO;
   import net.wg.gui.lobby.profile.pages.statistics.detailedStatistics.DetailedStatisticsGroupEx;
   import net.wg.gui.lobby.profile.pages.statistics.header.HeaderBGImage;
   import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
   import net.wg.gui.lobby.profile.pages.statistics.header.HeaderItemsTypes;
   import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
   import net.wg.gui.lobby.profile.pages.summary.AwardsListComponent;
   import net.wg.gui.lobby.profile.pages.summary.LineTextFieldsLayout;
   import net.wg.gui.lobby.profile.pages.summary.ProfileSummary;
   import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryPage;
   import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryVO;
   import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryWindow;
   import net.wg.gui.lobby.profile.pages.summary.SummaryInitVO;
   import net.wg.gui.lobby.profile.pages.summary.SummaryPageInitVO;
   import net.wg.gui.lobby.profile.pages.summary.SummaryVO;
   import net.wg.gui.lobby.profile.pages.technique.AchievementSmall;
   import net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo;
   import net.wg.gui.lobby.profile.pages.technique.ProfileSortingButton;
   import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
   import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueEmptyScreen;
   import net.wg.gui.lobby.profile.pages.technique.ProfileTechniquePage;
   import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueWindow;
   import net.wg.gui.lobby.profile.pages.technique.TechStatisticsInitVO;
   import net.wg.gui.lobby.profile.pages.technique.TechnicsDashLineTextItemIRenderer;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementTab;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementsBlock;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueList;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueRenderer;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueStackComponent;
   import net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.lobby.profile.pages.technique.data.SortingSettingVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueStatisticVO;
   import net.wg.gui.lobby.questsWindow.ConditionBlock;
   import net.wg.gui.lobby.questsWindow.ConditionElement;
   import net.wg.gui.lobby.questsWindow.DescriptionBlock;
   import net.wg.gui.lobby.questsWindow.HeaderBlock;
   import net.wg.gui.lobby.questsWindow.IQuestsTab;
   import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
   import net.wg.gui.lobby.questsWindow.QuestBlock;
   import net.wg.gui.lobby.questsWindow.QuestContent;
   import net.wg.gui.lobby.questsWindow.QuestRenderer;
   import net.wg.gui.lobby.questsWindow.QuestScrollPane;
   import net.wg.gui.lobby.questsWindow.QuestsCurrentTab;
   import net.wg.gui.lobby.questsWindow.QuestsFutureTab;
   import net.wg.gui.lobby.questsWindow.QuestsList;
   import net.wg.gui.lobby.questsWindow.QuestsWindow;
   import net.wg.gui.lobby.questsWindow.RequirementBlock;
   import net.wg.gui.lobby.questsWindow.SubtaskComponent;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import net.wg.gui.lobby.questsWindow.VehicleBlock;
   import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
   import net.wg.gui.lobby.questsWindow.components.AlertMessage;
   import net.wg.gui.lobby.questsWindow.components.CommonConditionsBlock;
   import net.wg.gui.lobby.questsWindow.components.ConditionSeparator;
   import net.wg.gui.lobby.questsWindow.components.EventsResizableContent;
   import net.wg.gui.lobby.questsWindow.components.InnerResizableContent;
   import net.wg.gui.lobby.questsWindow.components.MovableBlocksContainer;
   import net.wg.gui.lobby.questsWindow.components.ProgressBlock;
   import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
   import net.wg.gui.lobby.questsWindow.components.QuestIconElement;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import net.wg.gui.lobby.questsWindow.components.ResizableContentHeader;
   import net.wg.gui.lobby.questsWindow.components.SortingPanel;
   import net.wg.gui.lobby.questsWindow.components.TextProgressElement;
   import net.wg.gui.lobby.questsWindow.components.VehicleItemRenderer;
   import net.wg.gui.lobby.questsWindow.components.VehiclesSortingBlock;
   import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
   import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
   import net.wg.gui.lobby.questsWindow.data.ConditionSeparatorVO;
   import net.wg.gui.lobby.questsWindow.data.DescriptionVO;
   import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
   import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;
   import net.wg.gui.lobby.questsWindow.data.InfoDataVO;
   import net.wg.gui.lobby.questsWindow.data.ProgressBlockVO;
   import net.wg.gui.lobby.questsWindow.data.QuestDashlineItemVO;
   import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
   import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
   import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
   import net.wg.gui.lobby.questsWindow.data.SortedBtnVO;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import net.wg.gui.lobby.questsWindow.data.VehicleBlockVO;
   import net.wg.gui.lobby.questsWindow.data.VehiclesSortingBlockVO;
   import net.wg.gui.lobby.recruitWindow.RecruitWindow;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewMainButtons;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewOperationVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewRoleIR;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewVehicleVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewWindow;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainTankmanVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainVehicleBlockVO;
   import net.wg.gui.lobby.retrainCrewWindow.SelPriceInfo;
   import net.wg.gui.lobby.retrainCrewWindow.TankmanCrewRetrainingSmallButton;
   import net.wg.gui.lobby.sellDialog.ControlQuestionComponent;
   import net.wg.gui.lobby.sellDialog.MovingResult;
   import net.wg.gui.lobby.sellDialog.SaleItemBlockRenderer;
   import net.wg.gui.lobby.sellDialog.SellDevicesComponent;
   import net.wg.gui.lobby.sellDialog.SellDialogListItemRenderer;
   import net.wg.gui.lobby.sellDialog.SellHeaderComponent;
   import net.wg.gui.lobby.sellDialog.SellSlidingComponent;
   import net.wg.gui.lobby.sellDialog.SettingsButton;
   import net.wg.gui.lobby.sellDialog.SlidingScrollingList;
   import net.wg.gui.lobby.sellDialog.TotalResult;
   import net.wg.gui.lobby.sellDialog.UserInputControl;
   import net.wg.gui.lobby.sellDialog.VehicleSellDialog;
   import net.wg.gui.lobby.settings.AdvancedGraphicContentForm;
   import net.wg.gui.lobby.settings.AdvancedGraphicSettingsForm;
   import net.wg.gui.lobby.settings.AimSettings;
   import net.wg.gui.lobby.settings.ControlsSettings;
   import net.wg.gui.lobby.settings.GameSettings;
   import net.wg.gui.lobby.settings.GameSettingsBase;
   import net.wg.gui.lobby.settings.GraphicSettings;
   import net.wg.gui.lobby.settings.GraphicSettingsBase;
   import net.wg.gui.lobby.settings.MarkerSettings;
   import net.wg.gui.lobby.settings.ScreenSettingsForm;
   import net.wg.gui.lobby.settings.SettingsAimForm;
   import net.wg.gui.lobby.settings.SettingsBaseView;
   import net.wg.gui.lobby.settings.SettingsChangesMap;
   import net.wg.gui.lobby.settings.SettingsConfig;
   import net.wg.gui.lobby.settings.SettingsMarkersForm;
   import net.wg.gui.lobby.settings.SettingsWindow;
   import net.wg.gui.lobby.settings.SoundSettings;
   import net.wg.gui.lobby.settings.SoundSettingsBase;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.lobby.settings.components.KeysItemRenderer;
   import net.wg.gui.lobby.settings.components.KeysScrollingList;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.components.SettingsScrollPane;
   import net.wg.gui.lobby.settings.components.SettingsStepSlider;
   import net.wg.gui.lobby.settings.components.SoundVoiceWaves;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.store.ComplexListItemRenderer;
   import net.wg.gui.lobby.store.ModuleRendererCredits;
   import net.wg.gui.lobby.store.NationFilter;
   import net.wg.gui.lobby.store.STORE_STATUS_COLOR;
   import net.wg.gui.lobby.store.Store;
   import net.wg.gui.lobby.store.StoreEvent;
   import net.wg.gui.lobby.store.StoreForm;
   import net.wg.gui.lobby.store.StoreHelper;
   import net.wg.gui.lobby.store.StoreListItemRenderer;
   import net.wg.gui.lobby.store.StoreTable;
   import net.wg.gui.lobby.store.StoreTableDataProvider;
   import net.wg.gui.lobby.store.StoreTooltipMapVO;
   import net.wg.gui.lobby.store.StoreViewsEvent;
   import net.wg.gui.lobby.store.TableHeader;
   import net.wg.gui.lobby.store.TableHeaderInfo;
   import net.wg.gui.lobby.store.inventory.Inventory;
   import net.wg.gui.lobby.store.inventory.InventoryModuleListItemRenderer;
   import net.wg.gui.lobby.store.inventory.InventoryVehicleListItemRdr;
   import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
   import net.wg.gui.lobby.store.shop.Shop;
   import net.wg.gui.lobby.store.shop.ShopModuleListItemRenderer;
   import net.wg.gui.lobby.store.shop.ShopVehicleListItemRenderer;
   import net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES;
   import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
   import net.wg.gui.lobby.store.views.EquipmentView;
   import net.wg.gui.lobby.store.views.ModuleView;
   import net.wg.gui.lobby.store.views.OptionalDeviceView;
   import net.wg.gui.lobby.store.views.ShellView;
   import net.wg.gui.lobby.store.views.VehicleView;
   import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
   import net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView;
   import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
   import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
   import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
   import net.wg.gui.lobby.tankman.CrewTankmanRetraining;
   import net.wg.gui.lobby.tankman.PersonalCase;
   import net.wg.gui.lobby.tankman.PersonalCaseBase;
   import net.wg.gui.lobby.tankman.PersonalCaseBlockItem;
   import net.wg.gui.lobby.tankman.PersonalCaseBlocksArea;
   import net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle;
   import net.wg.gui.lobby.tankman.PersonalCaseDocs;
   import net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
   import net.wg.gui.lobby.tankman.PersonalCaseInputList;
   import net.wg.gui.lobby.tankman.PersonalCaseModel;
   import net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
   import net.wg.gui.lobby.tankman.PersonalCaseSkills;
   import net.wg.gui.lobby.tankman.PersonalCaseSkillsItemRenderer;
   import net.wg.gui.lobby.tankman.PersonalCaseSkillsModel;
   import net.wg.gui.lobby.tankman.PersonalCaseSpecialization;
   import net.wg.gui.lobby.tankman.PersonalCaseStats;
   import net.wg.gui.lobby.tankman.RankElement;
   import net.wg.gui.lobby.tankman.SkillDropModel;
   import net.wg.gui.lobby.tankman.SkillDropWindow;
   import net.wg.gui.lobby.tankman.SkillItemViewMini;
   import net.wg.gui.lobby.tankman.SkillsItemsRendererRankIcon;
   import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
   import net.wg.gui.lobby.tankman.VehicleTypeButton;
   import net.wg.gui.lobby.techtree.MenuHandler;
   import net.wg.gui.lobby.techtree.ResearchPage;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.TechTreePage;
   import net.wg.gui.lobby.techtree.constants.ActionName;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.IconTextResolver;
   import net.wg.gui.lobby.techtree.constants.NamedLabels;
   import net.wg.gui.lobby.techtree.constants.NavIndicator;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.constants.OutLiteral;
   import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
   import net.wg.gui.lobby.techtree.constants.TTSoundID;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
   import net.wg.gui.lobby.techtree.controls.ActionButton;
   import net.wg.gui.lobby.techtree.controls.ExperienceInformation;
   import net.wg.gui.lobby.techtree.controls.ExperienceLabel;
   import net.wg.gui.lobby.techtree.controls.LevelDelimiter;
   import net.wg.gui.lobby.techtree.controls.LevelsContainer;
   import net.wg.gui.lobby.techtree.controls.NameAndXpField;
   import net.wg.gui.lobby.techtree.controls.NationButton;
   import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
   import net.wg.gui.lobby.techtree.controls.NodeComponent;
   import net.wg.gui.lobby.techtree.controls.PremiumDescription;
   import net.wg.gui.lobby.techtree.controls.PremiumLayout;
   import net.wg.gui.lobby.techtree.controls.ResearchTitleBar;
   import net.wg.gui.lobby.techtree.controls.ReturnToTTButton;
   import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
   import net.wg.gui.lobby.techtree.controls.XPIcon;
   import net.wg.gui.lobby.techtree.data.AbstractDataProvider;
   import net.wg.gui.lobby.techtree.data.NationVODataProvider;
   import net.wg.gui.lobby.techtree.data.NationXMLDataProvider;
   import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
   import net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider;
   import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
   import net.wg.gui.lobby.techtree.data.state.InventoryStateItem;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.state.NodeStateItem;
   import net.wg.gui.lobby.techtree.data.state.ResearchStateItem;
   import net.wg.gui.lobby.techtree.data.state.StateProperties;
   import net.wg.gui.lobby.techtree.data.state.UnlockedStateItem;
   import net.wg.gui.lobby.techtree.data.vo.ActionData;
   import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.PrimaryClass;
   import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.ShopPrice;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
   import net.wg.gui.lobby.techtree.helpers.Distance;
   import net.wg.gui.lobby.techtree.helpers.LinesGraphics;
   import net.wg.gui.lobby.techtree.helpers.NTGraphics;
   import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
   import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
   import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
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
   import net.wg.gui.lobby.techtree.sub.NationTree;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import net.wg.gui.lobby.training.ArenaVoipSettings;
   import net.wg.gui.lobby.training.DropList;
   import net.wg.gui.lobby.training.DropTileList;
   import net.wg.gui.lobby.training.MinimapEntity;
   import net.wg.gui.lobby.training.MinimapEntry;
   import net.wg.gui.lobby.training.MinimapLobby;
   import net.wg.gui.lobby.training.PlayerElement;
   import net.wg.gui.lobby.training.TrainingDragController;
   import net.wg.gui.lobby.training.TrainingDragDelegate;
   import net.wg.gui.lobby.training.TrainingForm;
   import net.wg.gui.lobby.training.TrainingListItemRenderer;
   import net.wg.gui.lobby.training.TrainingPlayerItemRenderer;
   import net.wg.gui.lobby.training.TrainingRoom;
   import net.wg.gui.lobby.training.TrainingWindow;
   import net.wg.gui.lobby.vehicleBuyWindow.BodyMc;
   import net.wg.gui.lobby.vehicleBuyWindow.BuyingVehicleVO;
   import net.wg.gui.lobby.vehicleBuyWindow.ExpandButton;
   import net.wg.gui.lobby.vehicleBuyWindow.FooterMc;
   import net.wg.gui.lobby.vehicleBuyWindow.HeaderMc;
   import net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindow;
   import net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindowAnimManager;
   import net.wg.gui.lobby.vehicleInfo.BaseBlock;
   import net.wg.gui.lobby.vehicleInfo.CrewBlock;
   import net.wg.gui.lobby.vehicleInfo.PropBlock;
   import net.wg.gui.lobby.vehicleInfo.VehicleInfo;
   import net.wg.gui.lobby.vehicleInfo.VehicleInfoBase;
   import net.wg.gui.lobby.vehicleInfo.VehicleInfoCrew;
   import net.wg.gui.lobby.vehicleInfo.VehicleInfoProps;
   import net.wg.gui.lobby.window.BaseExchangeWindow;
   import net.wg.gui.lobby.window.ExchangeCurrencyWindow;
   import net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO;
   import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWarning;
   import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWindow;
   import net.wg.gui.lobby.window.ExchangeHeader;
   import net.wg.gui.lobby.window.ExchangeUtils;
   import net.wg.gui.lobby.window.ExchangeVcoinWarningMC;
   import net.wg.gui.lobby.window.ExchangeVcoinWindow;
   import net.wg.gui.lobby.window.ExchangeWindow;
   import net.wg.gui.lobby.window.ExchangeXPFromVehicleIR;
   import net.wg.gui.lobby.window.ExchangeXPList;
   import net.wg.gui.lobby.window.ExchangeXPTankmanSkillsModel;
   import net.wg.gui.lobby.window.ExchangeXPVehicleVO;
   import net.wg.gui.lobby.window.ExchangeXPWarningScreen;
   import net.wg.gui.lobby.window.ExchangeXPWindow;
   import net.wg.gui.lobby.window.ExtendedIconText;
   import net.wg.gui.lobby.window.ProfileWindow;
   import net.wg.gui.lobby.window.ProfileWindowInitVO;
   import net.wg.gui.lobby.window.VcoinExchangeDataVO;
   import net.wg.gui.login.EULA.EULADlg;
   import net.wg.gui.login.EULA.EULAFullDlg;
   import net.wg.gui.login.ILoginForm;
   import net.wg.gui.login.ISparksManager;
   import net.wg.gui.login.impl.LoginCreateAnAccountWindow;
   import net.wg.gui.login.impl.LoginEvent;
   import net.wg.gui.login.impl.LoginForm;
   import net.wg.gui.login.impl.LoginPage;
   import net.wg.gui.login.impl.LoginQueueWindow;
   import net.wg.gui.login.impl.Spark;
   import net.wg.gui.login.impl.SparksManager;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.messenger.IChannelComponent;
   import net.wg.gui.messenger.SmileyMap;
   import net.wg.gui.messenger.controls.ChannelItemRenderer;
   import net.wg.gui.messenger.controls.MemberItemRenderer;
   import net.wg.gui.messenger.data.ChannelMemberVO;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import net.wg.gui.messenger.forms.ChannelsCreateForm;
   import net.wg.gui.messenger.forms.ChannelsSearchForm;
   import net.wg.gui.messenger.forms.ContactsListForm;
   import net.wg.gui.messenger.forms.ContactsSearchForm;
   import net.wg.gui.messenger.meta.IBaseChannelWindowMeta;
   import net.wg.gui.messenger.meta.IChannelComponentMeta;
   import net.wg.gui.messenger.meta.IChannelsManagementWindowMeta;
   import net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta;
   import net.wg.gui.messenger.meta.IContactsWindowMeta;
   import net.wg.gui.messenger.meta.IFAQWindowMeta;
   import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.BaseChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.ChannelComponentMeta;
   import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
   import net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.ContactsWindowMeta;
   import net.wg.gui.messenger.meta.impl.FAQWindowMeta;
   import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;
   import net.wg.gui.messenger.windows.BaseChannelWindow;
   import net.wg.gui.messenger.windows.ChannelsManagementWindow;
   import net.wg.gui.messenger.windows.ConnectToSecureChannelWindow;
   import net.wg.gui.messenger.windows.ContactsWindow;
   import net.wg.gui.messenger.windows.FAQWindow;
   import net.wg.gui.messenger.windows.LazyChannelWindow;
   import net.wg.gui.messenger.windows.LobbyChannelWindow;
   import net.wg.gui.notification.CAPTCHA;
   import net.wg.gui.notification.NotificationListView;
   import net.wg.gui.notification.NotificationPopUpViewer;
   import net.wg.gui.notification.NotificationTimeComponent;
   import net.wg.gui.notification.NotificationsList;
   import net.wg.gui.notification.ServiceMessage;
   import net.wg.gui.notification.ServiceMessageItemRenderer;
   import net.wg.gui.notification.ServiceMessagePopUp;
   import net.wg.gui.notification.SystemMessageDialog;
   import net.wg.gui.notification.constants.ButtonState;
   import net.wg.gui.notification.constants.ButtonType;
   import net.wg.gui.notification.constants.MessageMetrics;
   import net.wg.gui.notification.events.NotificationListEvent;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.ButtonVO;
   import net.wg.gui.notification.vo.LayoutInfoVO;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.gui.notification.vo.NotificationDialogInitInfoVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.notification.vo.NotificationSettingsVO;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import net.wg.gui.prebattle.battleSession.BSListRendererVO;
   import net.wg.gui.prebattle.battleSession.BattleSessionList;
   import net.wg.gui.prebattle.battleSession.BattleSessionListRenderer;
   import net.wg.gui.prebattle.battleSession.BattleSessionWindow;
   import net.wg.gui.prebattle.battleSession.FlagsList;
   import net.wg.gui.prebattle.battleSession.RequirementInfo;
   import net.wg.gui.prebattle.battleSession.TopInfo;
   import net.wg.gui.prebattle.battleSession.TopStats;
   import net.wg.gui.prebattle.company.CompaniesListWindow;
   import net.wg.gui.prebattle.company.CompaniesScrollingList;
   import net.wg.gui.prebattle.company.CompanyDropDownEvent;
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
   import net.wg.gui.prebattle.data.ReceivedInviteVO;
   import net.wg.gui.prebattle.invites.InviteStackContainerBase;
   import net.wg.gui.prebattle.invites.PrbInviteSearchUsersForm;
   import net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator;
   import net.wg.gui.prebattle.invites.PrbSendInvitesWindow;
   import net.wg.gui.prebattle.invites.ReceivedInviteWindow;
   import net.wg.gui.prebattle.invites.SendInvitesEvent;
   import net.wg.gui.prebattle.invites.UserRosterItemRenderer;
   import net.wg.gui.prebattle.invites.UserRosterView;
   import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
   import net.wg.gui.prebattle.meta.IBattleSessionWindowMeta;
   import net.wg.gui.prebattle.meta.IChannelWindowMeta;
   import net.wg.gui.prebattle.meta.ICompaniesWindowMeta;
   import net.wg.gui.prebattle.meta.ICompanyWindowMeta;
   import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
   import net.wg.gui.prebattle.meta.IPrequeueWindowMeta;
   import net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta;
   import net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract;
   import net.wg.gui.prebattle.meta.abstract.PrequeueWindow;
   import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
   import net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta;
   import net.wg.gui.prebattle.meta.impl.ChannelWindowMeta;
   import net.wg.gui.prebattle.meta.impl.CompaniesWindowMeta;
   import net.wg.gui.prebattle.meta.impl.CompanyWindowMeta;
   import net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta;
   import net.wg.gui.prebattle.meta.impl.PrequeueWindowMeta;
   import net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta;
   import net.wg.gui.prebattle.pages.ChannelWindow;
   import net.wg.gui.prebattle.pages.LazyWindow;
   import net.wg.gui.prebattle.pages.MemberDataProvider;
   import net.wg.gui.prebattle.squad.MessengerUtils;
   import net.wg.gui.prebattle.squad.SquadItemRenderer;
   import net.wg.gui.prebattle.squad.SquadWindow;
   import net.wg.gui.prebattle.squad.SquadWindowCIGenerator;
   import net.wg.gui.prebattle.squad.UserDataFlags;
   import net.wg.gui.tutorial.TutorialBattleLoading;
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
   import net.wg.gui.tutorial.controls.TutorialBattleLoadingForm;
   import net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta;
   import net.wg.gui.tutorial.meta.ITutorialBattleStatisticMeta;
   import net.wg.gui.tutorial.meta.ITutorialDialogMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialBattleStatisticMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialDialogMeta;
   import net.wg.gui.tutorial.windows.TutorialBattleNoResultsWindow;
   import net.wg.gui.tutorial.windows.TutorialBattleStatisticWindow;
   import net.wg.gui.tutorial.windows.TutorialDialog;
   import net.wg.gui.tutorial.windows.TutorialGreetingDialog;
   import net.wg.gui.tutorial.windows.TutorialQueueDialog;
   import net.wg.gui.tutorial.windows.TutorialVideoDialog;
   import net.wg.gui.utils.ComplexTooltipHelper;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.gui.utils.FrameWalker;
   import net.wg.gui.utils.ImageSubstitution;
   import net.wg.gui.utils.VehicleStateString;
   import net.wg.infrastructure.base.AbstractPopOverView;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.base.AbstractWrapperView;
   import net.wg.infrastructure.base.BaseLayout;
   import net.wg.infrastructure.base.BaseViewWrapper;
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.base.StoredWindowGeometry;
   import net.wg.infrastructure.base.meta.IAmmunitionPanelMeta;
   import net.wg.infrastructure.base.meta.IBarracksMeta;
   import net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta;
   import net.wg.infrastructure.base.meta.IBattleLoadingMeta;
   import net.wg.infrastructure.base.meta.IBattleQueueMeta;
   import net.wg.infrastructure.base.meta.IBattleResultsMeta;
   import net.wg.infrastructure.base.meta.IBrowserMeta;
   import net.wg.infrastructure.base.meta.ICAPTCHAMeta;
   import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
   import net.wg.infrastructure.base.meta.IChannelComponentMeta;
   import net.wg.infrastructure.base.meta.IConfirmModuleWindowMeta;
   import net.wg.infrastructure.base.meta.ICrewMeta;
   import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
   import net.wg.infrastructure.base.meta.ICursorMeta;
   import net.wg.infrastructure.base.meta.ICyberSportBaseViewMeta;
   import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
   import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
   import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
   import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
   import net.wg.infrastructure.base.meta.IDemonstratorWindowMeta;
   import net.wg.infrastructure.base.meta.IDismissTankmanDialogMeta;
   import net.wg.infrastructure.base.meta.IEULAMeta;
   import net.wg.infrastructure.base.meta.IEliteWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeVcoinWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeXpWindowMeta;
   import net.wg.infrastructure.base.meta.IFightButtonMeta;
   import net.wg.infrastructure.base.meta.IFreeXPInfoWindowMeta;
   import net.wg.infrastructure.base.meta.IGEDesignerWindowMeta;
   import net.wg.infrastructure.base.meta.IGEInspectWindowMeta;
   import net.wg.infrastructure.base.meta.IHangarMeta;
   import net.wg.infrastructure.base.meta.IHistoricalBattlesListWindowMeta;
   import net.wg.infrastructure.base.meta.IIconDialogMeta;
   import net.wg.infrastructure.base.meta.IIconPriceDialogMeta;
   import net.wg.infrastructure.base.meta.IIntroPageMeta;
   import net.wg.infrastructure.base.meta.IInventoryMeta;
   import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
   import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
   import net.wg.infrastructure.base.meta.ILobbyMessengerMeta;
   import net.wg.infrastructure.base.meta.ILobbyMinimapMeta;
   import net.wg.infrastructure.base.meta.ILobbyPageMeta;
   import net.wg.infrastructure.base.meta.ILoginCreateAnAccountWindowMeta;
   import net.wg.infrastructure.base.meta.ILoginPageMeta;
   import net.wg.infrastructure.base.meta.ILoginQueueWindowMeta;
   import net.wg.infrastructure.base.meta.IMessengerBarMeta;
   import net.wg.infrastructure.base.meta.IMinimapEntityMeta;
   import net.wg.infrastructure.base.meta.IMinimapLobbyMeta;
   import net.wg.infrastructure.base.meta.IModuleInfoMeta;
   import net.wg.infrastructure.base.meta.INotificationListButtonMeta;
   import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
   import net.wg.infrastructure.base.meta.INotificationsListMeta;
   import net.wg.infrastructure.base.meta.IOrdersPanelMeta;
   import net.wg.infrastructure.base.meta.IParamsMeta;
   import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
   import net.wg.infrastructure.base.meta.IPopOverViewMeta;
   import net.wg.infrastructure.base.meta.IPrbSendInvitesWindowMeta;
   import net.wg.infrastructure.base.meta.IPremiumFormMeta;
   import net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta;
   import net.wg.infrastructure.base.meta.IProfileAwardsMeta;
   import net.wg.infrastructure.base.meta.IProfileMeta;
   import net.wg.infrastructure.base.meta.IProfileSectionMeta;
   import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
   import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
   import net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta;
   import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
   import net.wg.infrastructure.base.meta.IProfileTechniquePageMeta;
   import net.wg.infrastructure.base.meta.IProfileWindowMeta;
   import net.wg.infrastructure.base.meta.IQuestsControlMeta;
   import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;
   import net.wg.infrastructure.base.meta.IQuestsFutureTabMeta;
   import net.wg.infrastructure.base.meta.IQuestsWindowMeta;
   import net.wg.infrastructure.base.meta.IRecruitWindowMeta;
   import net.wg.infrastructure.base.meta.IResearchMeta;
   import net.wg.infrastructure.base.meta.IResearchPanelMeta;
   import net.wg.infrastructure.base.meta.IResearchViewMeta;
   import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
   import net.wg.infrastructure.base.meta.IRosterSlotSettingsWindowMeta;
   import net.wg.infrastructure.base.meta.ISettingsWindowMeta;
   import net.wg.infrastructure.base.meta.IShopMeta;
   import net.wg.infrastructure.base.meta.ISimpleDialogMeta;
   import net.wg.infrastructure.base.meta.ISkillDropMeta;
   import net.wg.infrastructure.base.meta.ISmartPopOverViewMeta;
   import net.wg.infrastructure.base.meta.IStoreMeta;
   import net.wg.infrastructure.base.meta.IStoreTableMeta;
   import net.wg.infrastructure.base.meta.ISystemMessageDialogMeta;
   import net.wg.infrastructure.base.meta.ITankCarouselMeta;
   import net.wg.infrastructure.base.meta.ITechTreeMeta;
   import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
   import net.wg.infrastructure.base.meta.ITickerMeta;
   import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
   import net.wg.infrastructure.base.meta.ITrainingFormMeta;
   import net.wg.infrastructure.base.meta.ITrainingRoomMeta;
   import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
   import net.wg.infrastructure.base.meta.ITutorialControlMeta;
   import net.wg.infrastructure.base.meta.ITutorialLayoutMeta;
   import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
   import net.wg.infrastructure.base.meta.IVehicleCustomizationMeta;
   import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
   import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
   import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
   import net.wg.infrastructure.base.meta.IWaitingViewMeta;
   import net.wg.infrastructure.base.meta.IWindowViewMeta;
   import net.wg.infrastructure.base.meta.IWrapperViewMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.events.DragEvent;
   import net.wg.infrastructure.events.DropEvent;
   import net.wg.infrastructure.events.EnvironmentEvent;
   import net.wg.infrastructure.events.FocusedViewEvent;
   import net.wg.infrastructure.events.GameEvent;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import net.wg.infrastructure.events.LoaderEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.helpers.DragDelegate;
   import net.wg.infrastructure.helpers.DragDelegateController;
   import net.wg.infrastructure.helpers.DropListDelegate;
   import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
   import net.wg.infrastructure.helpers.LibraryLoader;
   import net.wg.infrastructure.helpers.LoaderEx;
   import net.wg.infrastructure.interfaces.IAbstractPopOverView;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IBaseLayout;
   import net.wg.infrastructure.interfaces.ICounterComponent;
   import net.wg.infrastructure.interfaces.IDragDelegate;
   import net.wg.infrastructure.interfaces.IDraggableList;
   import net.wg.infrastructure.interfaces.IDropListDelegate;
   import net.wg.infrastructure.interfaces.IResizableContent;
   import net.wg.infrastructure.interfaces.ISortable;
   import net.wg.infrastructure.interfaces.IStoreMenuView;
   import net.wg.infrastructure.interfaces.IStoreTable;
   import net.wg.infrastructure.interfaces.ISubtaskComponent;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IWindowGeometry;


   public class ClassManagerMeta extends Object
   {
          
      public function ClassManagerMeta() {
         super();
      }

      public static const NET_WG_DATA_ALIASES:Class = Aliases;

      public static const NET_WG_DATA_CONTAINERCONSTANTS:Class = ContainerConstants;

      public static const NET_WG_DATA_INSPECTABLEDATAPROVIDER:Class = InspectableDataProvider;

      public static const NET_WG_DATA_VO_ACHIEVEMENTITEMVO:Class = AchievementItemVO;

      public static const NET_WG_DATA_VO_ANIMATIONOBJECT:Class = AnimationObject;

      public static const NET_WG_DATA_VO_BATTLERESULTSQUESTVO:Class = BattleResultsQuestVO;

      public static const NET_WG_DATA_VO_COLORSCHEME:Class = ColorScheme;

      public static const NET_WG_DATA_VO_EXTENDEDUSERVO:Class = ExtendedUserVO;

      public static const NET_WG_DATA_VO_ICONVO:Class = IconVO;

      public static const NET_WG_DATA_VO_POINTVO:Class = PointVO;

      public static const NET_WG_DATA_VO_PREMIUMFORMMODEL:Class = PremiumFormModel;

      public static const NET_WG_DATA_VO_PROGRESSELEMENTVO:Class = ProgressElementVO;

      public static const NET_WG_DATA_VO_SELLDIALOGELEMENT:Class = SellDialogElement;

      public static const NET_WG_DATA_VO_SELLDIALOGITEM:Class = SellDialogItem;

      public static const NET_WG_DATA_VO_SEPARATEITEM:Class = SeparateItem;

      public static const NET_WG_DATA_VO_SHOPSUBFILTERDATA:Class = ShopSubFilterData;

      public static const NET_WG_DATA_VO_SHOPVEHICLEFILTERELEMENTDATA:Class = ShopVehicleFilterElementData;

      public static const NET_WG_DATA_VO_STORETABLEDATA:Class = StoreTableData;

      public static const NET_WG_DATA_VO_STORETABLEVO:Class = StoreTableVO;

      public static const NET_WG_DATA_VO_TRAININGFORMRENDERERVO:Class = TrainingFormRendererVO;

      public static const NET_WG_DATA_VO_TRAININGROOMINFOVO:Class = TrainingRoomInfoVO;

      public static const NET_WG_DATA_VO_TRAININGROOMLISTVO:Class = TrainingRoomListVO;

      public static const NET_WG_DATA_VO_TRAININGROOMRENDERERVO:Class = TrainingRoomRendererVO;

      public static const NET_WG_DATA_VO_TRAININGWINDOWVO:Class = TrainingWindowVO;

      public static const NET_WG_DATA_VO_TWEENPROPERTIESVO:Class = TweenPropertiesVO;

      public static const NET_WG_DATA_VO_USERVO:Class = UserVO;

      public static const NET_WG_DATA_VO_WALLETSTATUSVO:Class = WalletStatusVO;

      public static const NET_WG_DATA_VO_GENERATED_SHOPNATIONFILTERDATA:Class = ShopNationFilterData;

      public static const NET_WG_DATA_VODAAPIDATAPROVIDER:Class = VoDAAPIDataProvider;

      public static const NET_WG_DATA_COMPONENTS_ABSTRACTCONTEXTITEMGENERATOR:Class = AbstractContextItemGenerator;

      public static const NET_WG_DATA_COMPONENTS_ACCORDIONRENDERERDATA:Class = AccordionRendererData;

      public static const NET_WG_DATA_COMPONENTS_BATTLERESULTSCIGENERATOR:Class = BattleResultsCIGenerator;

      public static const NET_WG_DATA_COMPONENTS_BATTLESESSIONCIGENERATOR:Class = BattleSessionCIGenerator;

      public static const NET_WG_DATA_COMPONENTS_CONTEXTITEM:Class = ContextItem;

      public static const NET_WG_DATA_COMPONENTS_CONTEXTITEMGENERATOR:Class = ContextItemGenerator;

      public static const NET_WG_DATA_COMPONENTS_STOREMENUVIEWDATA:Class = StoreMenuViewData;

      public static const NET_WG_DATA_COMPONENTS_USERCONTEXTITEM:Class = UserContextItem;

      public static const NET_WG_DATA_CONSTANTS_COLORSCHEMENAMES:Class = ColorSchemeNames;

      public static const NET_WG_DATA_CONSTANTS_CONTAINERTYPES:Class = ContainerTypes;

      public static const NET_WG_DATA_CONSTANTS_CONTEXTMENUCONSTANTS:Class = ContextMenuConstants;

      public static const NET_WG_DATA_CONSTANTS_CURRENCIES:Class = Currencies;

      public static const NET_WG_DATA_CONSTANTS_CURSORS:Class = Cursors;

      public static const NET_WG_DATA_CONSTANTS_DIALOGS:Class = Dialogs;

      public static const NET_WG_DATA_CONSTANTS_DIRECTIONS:Class = Directions;

      public static const NET_WG_DATA_CONSTANTS_DRAGTYPE:Class = DragType;

      public static const NET_WG_DATA_CONSTANTS_ENGINEMETHODS:Class = EngineMethods;

      public static const NET_WG_DATA_CONSTANTS_FITTINGTYPES:Class = FittingTypes;

      public static const NET_WG_DATA_CONSTANTS_GUNTYPES:Class = GunTypes;

      public static const NET_WG_DATA_CONSTANTS_ICONTEXTPOSITION:Class = IconTextPosition;

      public static const NET_WG_DATA_CONSTANTS_ITEMTYPES:Class = ItemTypes;

      public static const NET_WG_DATA_CONSTANTS_KEYSMAP:Class = KeysMap;

      public static const NET_WG_DATA_CONSTANTS_LOCALES:Class = Locales;

      public static const NET_WG_DATA_CONSTANTS_QUESTSSTATES:Class = QuestsStates;

      public static const NET_WG_DATA_CONSTANTS_ROLESSTATE:Class = RolesState;

      public static const NET_WG_DATA_CONSTANTS_SOUNDMANAGERSTATES:Class = SoundManagerStates;

      public static const NET_WG_DATA_CONSTANTS_SOUNDTYPES:Class = SoundTypes;

      public static const NET_WG_DATA_CONSTANTS_TOOLTIPTAGS:Class = TooltipTags;

      public static const NET_WG_DATA_CONSTANTS_TOOLTIPS:Class = Tooltips;

      public static const NET_WG_DATA_CONSTANTS_VALOBJECT:Class = ValObject;

      public static const NET_WG_DATA_CONSTANTS_VEHICLESTATE:Class = VehicleState;

      public static const NET_WG_DATA_CONSTANTS_VEHICLETYPES:Class = VehicleTypes;

      public static const NET_WG_DATA_CONSTANTS_GENERATED_CUSTOMIZATION_ITEM_TYPE:Class = CUSTOMIZATION_ITEM_TYPE;

      public static const NET_WG_DATA_CONSTANTS_GENERATED_CYBER_SPORT_ALIASES:Class = CYBER_SPORT_ALIASES;

      public static const NET_WG_DATA_CONSTANTS_GENERATED_FITTING_TYPES:Class = FITTING_TYPES;

      public static const NET_WG_DATA_CONSTANTS_GENERATED_STORE_TYPES:Class = STORE_TYPES;

      public static const NET_WG_DATA_GUI_ITEMS_FITTINGITEM:Class = FittingItem;

      public static const NET_WG_DATA_GUI_ITEMS_GUIITEM:Class = GUIItem;

      public static const NET_WG_DATA_GUI_ITEMS_ITEMSUTILS:Class = ItemsUtils;

      public static const NET_WG_DATA_GUI_ITEMS_TANKMAN:Class = Tankman;

      public static const NET_WG_DATA_GUI_ITEMS_TANKMANSKILL:Class = TankmanSkill;

      public static const NET_WG_DATA_GUI_ITEMS_VEHICLE:Class = Vehicle;

      public static const NET_WG_DATA_GUI_ITEMS_VEHICLEPROFILE:Class = VehicleProfile;

      public static const NET_WG_DATA_GUI_ITEMS_DOSSIER_ACCOUNTDOSSIER:Class = AccountDossier;

      public static const NET_WG_DATA_GUI_ITEMS_DOSSIER_ACHIEVEMENT:Class = Achievement;

      public static const NET_WG_DATA_GUI_ITEMS_DOSSIER_DOSSIER:Class = Dossier;

      public static const NET_WG_DATA_GUI_ITEMS_DOSSIER_TANKMANDOSSIER:Class = TankmanDossier;

      public static const NET_WG_DATA_GUI_ITEMS_DOSSIER_VEHICLEDOSSIER:Class = VehicleDossier;

      public static const NET_WG_DATA_MANAGERS_IMPL_DIALOGDISPATCHER:Class = DialogDispatcher;

      public static const NET_WG_DATA_MANAGERS_IMPL_NOTIFYPROPERTIES:Class = NotifyProperties;

      public static const NET_WG_DATA_MANAGERS_IMPL_TOOLTIPPARAMS:Class = ToolTipParams;

      public static const NET_WG_DATA_MANAGERS_IMPL_TOOLTIPPROPS:Class = TooltipProps;

      public static const NET_WG_DATA_MANAGERS_IMPL_TWEEN:Class = Tween;

      public static const NET_WG_DATA_UTILDATA_FORMATTEDINTEGER:Class = FormattedInteger;

      public static const NET_WG_DATA_UTILDATA_ITEMPRICE:Class = ItemPrice;

      public static const NET_WG_DATA_UTILDATA_TANKMANROLELEVEL:Class = TankmanRoleLevel;

      public static const NET_WG_DATA_UTILDATA_TANKMANSLOT:Class = TankmanSlot;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_ACCORDION:Class = Accordion;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_AMMUNITIONBUTTON:Class = AmmunitionButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_BLINKINGBUTTON:Class = BlinkingButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_BUTTONBAREX:Class = ButtonBarEx;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_BUTTONICONLOADER:Class = ButtonIconLoader;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_CLANEMBLEM:Class = ClanEmblem;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_CONTENTTABBAR:Class = ContentTabBar;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_CONTENTTABRENDERER:Class = ContentTabRenderer;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_COOLDOWNANIMATIONCONTROLLER:Class = CooldownAnimationController;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_COUNTEREX:Class = CounterEx;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_DOUBLEPROGRESSBAR:Class = DoubleProgressBar;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_EXTRAMODULEICON:Class = ExtraModuleIcon;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_FIELDSET:Class = FieldSet;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_HELPLAYOUTCONTROL:Class = HelpLayoutControl;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERACTIVESORTINGBUTTON:Class = InteractiveSortingButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_MODULEICON:Class = ModuleIcon;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_PORTRAITITEMRENDERER:Class = PortraitItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONBUTTON:Class = ScalableIconButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONWRAPPER:Class = ScalableIconWrapper;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLBUTTON:Class = ShellButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLSSET:Class = ShellsSet;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SKILLSITEMRENDERER:Class = SkillsItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTABLEHEADERBUTTONBAR:Class = SortableHeaderButtonBar;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTINGBUTTON:Class = SortingButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTINGBUTTONINFO:Class = SortingButtonInfo;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_TABBUTTON:Class = TabButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_TANKICON:Class = TankIcon;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREA:Class = TextArea;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREASIMPLE:Class = TextAreaSimple;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_TOGGLEBUTTON:Class = ToggleButton;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_UNCLICKABLESHADOWBG:Class = UnClickableShadowBG;

      public static const NET_WG_GUI_COMPONENTS_ADVANCED_VIEWSTACK:Class = ViewStack;

      public static const NET_WG_GUI_COMPONENTS_CAROUSELS_ACHIEVEMENTCAROUSEL:Class = AchievementCarousel;

      public static const NET_WG_GUI_COMPONENTS_CAROUSELS_CAROUSELBASE:Class = CarouselBase;

      public static const NET_WG_GUI_COMPONENTS_CAROUSELS_ICAROUSELITEMRENDERER:Class = ICarouselItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_CAROUSELS_PORTRAITSCAROUSEL:Class = PortraitsCarousel;

      public static const NET_WG_GUI_COMPONENTS_CAROUSELS_SKILLSCAROUSEL:Class = SkillsCarousel;

      public static const NET_WG_GUI_COMPONENTS_COMMON_BASELOGOVIEW:Class = BaseLogoView;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CURSORMANAGEDCONTAINER:Class = CursorManagedContainer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MAINVIEWCONTAINER:Class = MainViewContainer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MANAGEDCONTAINER:Class = ManagedContainer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VEHICLEMARKERALLY:Class = VehicleMarkerAlly;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VEHICLEMARKERENEMY:Class = VehicleMarkerEnemy;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITINGMANAGEDCONTAINER:Class = WaitingManagedContainer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_EQUALGAPSHORIZONTALLAYOUT:Class = EqualGapsHorizontalLayout;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUP:Class = Group;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUPEX:Class = GroupEx;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUPLAYOUT:Class = GroupLayout;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_HORIZONTALGROUPLAYOUT:Class = HorizontalGroupLayout;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_VERTICALGROUPLAYOUT:Class = VerticalGroupLayout;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CLIPQUANTITYBAR:Class = ClipQuantityBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRBASE:Class = CrosshairBase;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRPANELARCADE:Class = CrosshairPanelArcade;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRPANELBASE:Class = CrosshairPanelBase;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRPANELPOSTMORTEM:Class = CrosshairPanelPostmortem;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRPANELSNIPER:Class = CrosshairPanelSniper;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRPANELSTRATEGIC:Class = CrosshairPanelStrategic;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRSNIPER:Class = CrosshairSniper;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_CROSSHAIRSTRATEGIC:Class = CrosshairStrategic;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CROSSHAIR_RELOADINGTIMER:Class = ReloadingTimer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_CURSOR:Class = Cursor;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_BASE_BASEINFO:Class = BaseInfo;

      public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_BASE_DROPPINGCURSOR:Class = DroppingCursor;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DAMAGELABEL:Class = DamageLabel;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBAR:Class = HealthBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_VEHICLEMARKER:Class = VehicleMarker;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_HPDISPLAYMODE:Class = HPDisplayMode;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;

      public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERVO:Class = VehicleMarkerVO;

      public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_RSSENTRYVO:Class = RSSEntryVO;

      public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_TICKER:Class = Ticker;

      public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_TICKERITEM:Class = TickerItem;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_NETSTREAMSTATUSCODE:Class = NetStreamStatusCode;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_NETSTREAMSTATUSLEVEL:Class = NetStreamStatusLevel;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_PLAYERSTATUS:Class = net.wg.gui.components.common.video.PlayerStatus;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_SIMPLEVIDEOPLAYER:Class = SimpleVideoPlayer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_VIDEOPLAYEREVENT:Class = VideoPlayerEvent;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_VIDEOPLAYERSTATUSEVENT:Class = VideoPlayerStatusEvent;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_ABSTRACTPLAYERCONTROLLER:Class = AbstractPlayerController;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_ABSTRACTPLAYERPROGRESSBAR:Class = AbstractPlayerProgressBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_ADVANCEDVIDEOPLAYER:Class = AdvancedVideoPlayer;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_CONTROLBARCONTROLLER:Class = ControlBarController;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_KEYBOARDCONTROLLER:Class = KeyboardController;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_PROGRESSBARCONTROLLER:Class = ProgressBarController;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_PROGRESSBAREVENT:Class = ProgressBarEvent;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_PROGRESSBARSLIDER:Class = ProgressBarSlider;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_SLIDERPLAYERPROGRESSBAR:Class = SliderPlayerProgressBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_VIDEOPLAYERANIMATIONMANAGER:Class = VideoPlayerAnimationManager;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_VIDEOPLAYERCONTROLBAR:Class = VideoPlayerControlBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_ADVANCED_VIDEOPLAYERTITLEBAR:Class = VideoPlayerTitleBar;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITING:Class = Waiting;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGCOMPONENT:Class = WaitingComponent;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGMC:Class = WaitingMc;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGVIEW:Class = WaitingView;

      public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_EVENTS_WAITINGCHANGEVISIBILITYEVENT:Class = WaitingChangeVisibilityEvent;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACCORDIONSOUNDRENDERER:Class = AccordionSoundRenderer;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACTIONPRICE:Class = ActionPrice;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ALERTICO:Class = AlertIco;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_BITMAPFILL:Class = BitmapFill;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CAROUSEL:Class = Carousel;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CHECKBOX:Class = CheckBox;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CLOSEBUTTON:Class = CloseButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_COMPACTCHECKBOX:Class = CompactCheckBox;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENU:Class = ContextMenu;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENUITEM:Class = ContextMenuItem;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENUITEMSEPARATE:Class = ContextMenuItemSeparate;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_CORELISTEX:Class = CoreListEx;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_DRAGABLELISTITEMRENDERER:Class = DragableListItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNIMAGETEXT:Class = DropDownImageText;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNLISTITEMRENDERERSOUND:Class = DropDownListItemRendererSound;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNMENU:Class = DropdownMenu;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_DYNAMICSCROLLINGLISTEX:Class = DynamicScrollingListEx;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_FIGHTBUTTONSELECT:Class = FightButtonSelect;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_FIGHTLISTITEMRENDERER:Class = FightListItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_GLOWARROWASSET:Class = GlowArrowAsset;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_HYPERLINK:Class = HyperLink;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_IPROGRESSBAR:Class = IProgressBar;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONBUTTON:Class = IconButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONTEXT:Class = IconText;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONTEXTBUTTON:Class = IconTextButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_INFOICON:Class = InfoIcon;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_LABELCONTROL:Class = LabelControl;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTITEMREDERERIMAGETEXT:Class = ListItemRedererImageText;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTITEMRENDERERWITHFOCUSONDIS:Class = ListItemRendererWithFocusOnDis;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_MAINMENUBUTTON:Class = MainMenuButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_NATIONDROPDOWNMENU:Class = NationDropDownMenu;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_NUMERICSTEPPER:Class = NumericStepper;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_PROGRESSBAR:Class = ProgressBar;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_RADIOBUTTON:Class = RadioButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_READONLYSCROLLINGLIST:Class = ReadOnlyScrollingList;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_REGIONDROPDOWNMENU:Class = RegionDropdownMenu;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLBAR:Class = ScrollBar;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTAUTOSCROLL:Class = ScrollingListAutoScroll;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTEX:Class = ScrollingListEx;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTPX:Class = ScrollingListPx;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTWITHDISRENDERERS:Class = ScrollingListWithDisRenderers;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDER:Class = Slider;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDERBG:Class = SliderBg;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDERKEYPOINT:Class = SliderKeyPoint;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTBUTTON:Class = SortButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLESCROLLINGLIST:Class = SortableScrollingList;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDBUTTON:Class = SoundButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDBUTTONEX:Class = SoundButtonEx;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDLISTITEMRENDERER:Class = SoundListItemRenderer;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_STEPSLIDER:Class = StepSlider;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGBUTTON:Class = TankmanTrainingButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGSMALLBUTTON:Class = TankmanTrainingSmallButton;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_TEXTFIELDSHORT:Class = TextFieldShort;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_TEXTINPUT:Class = TextInput;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_TILELIST:Class = TileList;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_UILOADERALT:Class = UILoaderAlt;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_UILOADERCUT:Class = UILoaderCut;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_UNITCOMMANDERSTATS:Class = UnitCommanderStats;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_USERNAMEFIELD:Class = UserNameField;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_ACTIONPRICEVO:Class = ActionPriceVO;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICE:Class = Voice;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICEWAVE:Class = VoiceWave;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_WALLETRESOURCESSTATUS:Class = WalletResourcesStatus;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_WGSCROLLINGLIST:Class = WgScrollingList;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOMMON:Class = AchievementCommon;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOMMONVEHICLE:Class = AchievementCommonVehicle;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOUNTER:Class = AchievementCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOUNTERSMALL:Class = AchievementCounterSmall;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTDIVISION:Class = AchievementDivision;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTEVENT:Class = AchievementEvent;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESS:Class = AchievementProgress;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESSBAR:Class = AchievementProgressBar;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESSCOMPONENT:Class = AchievementProgressComponent;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_BEIGECOUNTER:Class = BeigeCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_COUNTERCOMPONENT:Class = CounterComponent;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_GREYRIBBONCOUNTER:Class = GreyRibbonCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_REDCOUNTER:Class = RedCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_SMALLCOUNTER:Class = SmallCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_YELLOWRIBBONCOUNTER:Class = YellowRibbonCounter;

      public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SCROLLBAREVENT:Class = ScrollBarEvent;

      public static const NET_WG_GUI_COMPONENTS_ICONS_BATTLETYPEICON:Class = BattleTypeIcon;

      public static const NET_WG_GUI_COMPONENTS_ICONS_PLAYERACTIONMARKER:Class = PlayerActionMarker;

      public static const NET_WG_GUI_COMPONENTS_ICONS_PLAYERACTIONMARKERCONTROLLER:Class = PlayerActionMarkerController;

      public static const NET_WG_GUI_COMPONENTS_ICONS_SQUADICON:Class = SquadIcon;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_POPOVER:Class = PopOver;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_POPOVERCONST:Class = PopOverConst;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_POPOVERCONTENTPADDING:Class = PopoverContentPadding;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_POPOVERINTERNALLAYOUT:Class = PopoverInternalLayout;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_SMARTPOPOVER:Class = SmartPopOver;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_SMARTPOPOVEREXTERNALLAYOUT:Class = SmartPopOverExternalLayout;

      public static const NET_WG_GUI_COMPONENTS_POPOVERS_SMARTPOPOVERLAYOUTINFO:Class = SmartPopOverLayoutInfo;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_ACHIEVEMENTSCUSTOMBLOCKITEM:Class = AchievementsCustomBlockItem;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_EXTRAMODULEINFO:Class = ExtraModuleInfo;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTBLOCK:Class = IgrQuestBlock;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTPROGRESSBLOCK:Class = IgrQuestProgressBlock;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_MODULEITEM:Class = ModuleItem;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SEPARATOR:Class = Separator;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_STATUS:Class = Status;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SUITABLEVEHICLEBLOCKITEM:Class = SuitableVehicleBlockItem;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPACHIEVEMENT:Class = ToolTipAchievement;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPBASE:Class = ToolTipBase;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPBUYSKILL:Class = ToolTipBuySkill;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCOMPLEX:Class = ToolTipComplex;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPEQUIPMENT:Class = ToolTipEquipment;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPFINALSTATS:Class = ToolTipFinalStats;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPHISTORICALAMMO:Class = ToolTipHistoricalAmmo;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPHISTORICALMODULES:Class = ToolTipHistoricalModules;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPIGR:Class = ToolTipIGR;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMAP:Class = ToolTipMap;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPRSSNEWS:Class = ToolTipRSSNews;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSELECTEDVEHICLE:Class = ToolTipSelectedVehicle;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSETTINGSCONTROL:Class = ToolTipSettingsControl;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSKILL:Class = ToolTipSkill;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSPECIAL:Class = ToolTipSpecial;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSUITABLEVEHICLE:Class = ToolTipSuitableVehicle;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPTANKCLASS:Class = ToolTipTankClass;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPTANKMEN:Class = ToolTipTankmen;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPVEHICLE:Class = ToolTipVehicle;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPUNITCOMMAND:Class = TooltipUnitCommand;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_ACHIEVEMENTVO:Class = AchievementVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_DIMENSION:Class = Dimension;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EQUIPMENTPARAMVO:Class = EquipmentParamVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EQUIPMENTVO:Class = EquipmentVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EXTRAMODULEINFOVO:Class = ExtraModuleInfoVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_HISTORICALMODULESVO:Class = HistoricalModulesVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_IGRVO:Class = IgrVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MAPVO:Class = MapVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MODULEVO:Class = net.wg.gui.components.tooltips.VO.ModuleVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SETTINGSCONTROLVO:Class = SettingsControlVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SUITABLEVEHICLEVO:Class = SuitableVehicleVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TANKMENVO:Class = TankmenVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKRESULTVO:Class = ToolTipBlockResultVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKRIGHTLISTITEMVO:Class = ToolTipBlockRightListItemVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKVO:Class = ToolTipBlockVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPFINALSTATSVO:Class = ToolTipFinalStatsVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSKILLVO:Class = ToolTipSkillVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSTATUSCOLORSVO:Class = ToolTipStatusColorsVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPVEHICLESELECTEDVO:Class = ToolTipVehicleSelectedVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_UNITCOMMANDVO:Class = UnitCommandVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_VEHICLEBASEVO:Class = VehicleBaseVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_VEHICLEVO:Class = net.wg.gui.components.tooltips.VO.VehicleVO;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_EFFICIENCYBLOCK:Class = EfficiencyBlock;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_EFFICIENCYCRITSBLOCK:Class = EfficiencyCritsBlock;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_HELPERS_TANKTYPEICO:Class = TankTypeIco;

      public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_HELPERS_UTILS:Class = Utils;

      public static const NET_WG_GUI_COMPONENTS_WINDOWS_MODULEINFO:Class = ModuleInfo;

      public static const NET_WG_GUI_COMPONENTS_WINDOWS_SCREENBG:Class = ScreenBg;

      public static const NET_WG_GUI_COMPONENTS_WINDOWS_WINDOW:Class = Window;

      public static const NET_WG_GUI_COMPONENTS_WINDOWS_WINDOWEVENT:Class = WindowEvent;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONEVENT:Class = CrewOperationEvent;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONINFOVO:Class = CrewOperationInfoVO;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONWARNINGVO:Class = CrewOperationWarningVO;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRFOOTER:Class = CrewOperationsIRFooter;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRENDERER:Class = CrewOperationsIRenderer;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSINITVO:Class = CrewOperationsInitVO;

      public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSPOPOVER:Class = CrewOperationsPopOver;

      public static const NET_WG_GUI_CYBERSPORT_CSCONSTANTS:Class = CSConstants;

      public static const NET_WG_GUI_CYBERSPORT_CSINVALIDATIONTYPE:Class = CSInvalidationType;

      public static const NET_WG_GUI_CYBERSPORT_CYBERSPORTMAINWINDOW:Class = CyberSportMainWindow;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_BUTTONDNMICON:Class = ButtonDnmIcon;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_BUTTONDNMICONSLIM:Class = ButtonDnmIconSlim;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSCANDIDATESSCROLLINGLIST:Class = CSCandidatesScrollingList;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTON:Class = CSVehicleButton;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTONLEVELS:Class = CSVehicleButtonLevels;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CANDIDATEITEMRENDERER:Class = CandidateItemRenderer;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_COMMANDRENDERER:Class = CommandRenderer;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DOUBLESLIDER:Class = DoubleSlider;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DYNAMICRANGEVEHICLES:Class = DynamicRangeVehicles;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_GRAYBUTTONTEXT:Class = GrayButtonText;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_GRAYTRANSPARENTBUTTON:Class = GrayTransparentButton;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MANUALSEARCHRENDERER:Class = ManualSearchRenderer;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MANUALSEARCHSCROLLINGLIST:Class = ManualSearchScrollingList;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MEDALVEHICLEVO:Class = MedalVehicleVO;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_NAVIGATIONBLOCK:Class = NavigationBlock;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_RANGEVIEWCOMPONENT:Class = RangeViewComponent;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_READYMSG:Class = ReadyMsg;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERBUTTONGROUP:Class = RosterButtonGroup;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERSETTINGSNUMERATIONBLOCK:Class = RosterSettingsNumerationBlock;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SELECTEDVEHICLESMSG:Class = SelectedVehiclesMsg;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SETTINGROSTERVO:Class = SettingRosterVO;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SETTINGSICONS:Class = SettingsIcons;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SLOTDROPINDICATOR:Class = SlotDropIndicator;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTOR:Class = VehicleSelector;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORFILTER:Class = VehicleSelectorFilter;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORITEMRENDERER:Class = VehicleSelectorItemRenderer;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_CSCOMPONENTEVENT:Class = CSComponentEvent;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_MANUALSEARCHEVENT:Class = ManualSearchEvent;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTOREVENT:Class = VehicleSelectorEvent;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTORFILTEREVENT:Class = VehicleSelectorFilterEvent;

      public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTORITEMEVENT:Class = VehicleSelectorItemEvent;

      public static const NET_WG_GUI_CYBERSPORT_DATA_CANDIDATESDATAPROVIDER:Class = CandidatesDataProvider;

      public static const NET_WG_GUI_CYBERSPORT_DATA_MANUALSEARCHDATAPROVIDER:Class = ManualSearchDataProvider;

      public static const NET_WG_GUI_CYBERSPORT_HELPERS_CSDRAGDROPDELEGATE:Class = CSDragDropDelegate;

      public static const NET_WG_GUI_CYBERSPORT_HELPERS_CSDRAGDROPLISTDELEGATECONTROLLER:Class = CSDragDropListDelegateController;

      public static const NET_WG_GUI_CYBERSPORT_HELPERS_CSPLAYERCIGENERATOR:Class = CSPlayerCIGenerator;

      public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICSAUTOSEARCHMAINVIEW:Class = ICSAutoSearchMainView;

      public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICHANNELCOMPONENTHOLDER:Class = IChannelComponentHolder;

      public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IMANUALSEARCHDATAPROVIDER:Class = IManualSearchDataProvider;

      public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IMANUALSEARCHRENDERER:Class = IManualSearchRenderer;

      public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IMANUALSEARCHSCROLLINGLIST:Class = IManualSearchScrollingList;

      public static const NET_WG_GUI_CYBERSPORT_POPUPS_VEHICLESELECTORPOPUP:Class = VehicleSelectorPopup;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_ANIMATEDROSTERSETTINGSVIEW:Class = AnimatedRosterSettingsView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_INTROVIEW:Class = IntroView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_RANGEROSTERSETTINGSVIEW:Class = RangeRosterSettingsView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSETTINGSVIEW:Class = RosterSettingsView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSLOTSETTINGSWINDOW:Class = RosterSlotSettingsWindow;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITVIEW:Class = UnitView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITSLISTVIEW:Class = UnitsListView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CSAUTOSEARCHMAINVIEW:Class = CSAutoSearchMainView;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CONFIRMATIONREADINESSSTATUS:Class = ConfirmationReadinessStatus;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_ERRORSTATE:Class = ErrorState;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHCOMMANDS:Class = SearchCommands;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHENEMY:Class = SearchEnemy;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_STATEVIEWBASE:Class = StateViewBase;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_WAITINGPLAYERS:Class = WaitingPlayers;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_CYBERSPORTEVENT:Class = CyberSportEvent;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_ROSTERSETTINGSEVENT:Class = RosterSettingsEvent;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_CHATSECTION:Class = ChatSection;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_JOINUNITSECTION:Class = JoinUnitSection;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SIMPLESLOTRENDERER:Class = SimpleSlotRenderer;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SLOTRENDERER:Class = SlotRenderer;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_TEAMSECTION:Class = TeamSection;

      public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_WAITLISTSECTION:Class = WaitListSection;

      public static const NET_WG_GUI_CYBERSPORT_VO_ACTIONBUTTONVO:Class = ActionButtonVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_AUTOSEARCHVO:Class = AutoSearchVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_CSCOMMANDVO:Class = CSCommandVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_NAVIGATIONBLOCKVO:Class = NavigationBlockVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_UNITCANDIDATEVO:Class = UnitCandidateVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_UNITSHORTVO:Class = UnitShortVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_UNITSLOTVO:Class = UnitSlotVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_UNITVO:Class = UnitVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_VEHICLESELECTORFILTERVO:Class = VehicleSelectorFilterVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_VEHICLESELECTORITEMVO:Class = VehicleSelectorItemVO;

      public static const NET_WG_GUI_CYBERSPORT_VO_VEHICLEVO:Class = net.wg.gui.cyberSport.vo.VehicleVO;

      public static const NET_WG_GUI_EVENTS_ACCORDIONRENDEREREVENT:Class = AccordionRendererEvent;

      public static const NET_WG_GUI_EVENTS_ARENAVOIPSETTINGSEVENT:Class = ArenaVoipSettingsEvent;

      public static const NET_WG_GUI_EVENTS_CONTEXTMENUEVENT:Class = ContextMenuEvent;

      public static const NET_WG_GUI_EVENTS_CREWEVENT:Class = CrewEvent;

      public static const NET_WG_GUI_EVENTS_DEVICEEVENT:Class = DeviceEvent;

      public static const NET_WG_GUI_EVENTS_EQUIPMENTEVENT:Class = EquipmentEvent;

      public static const NET_WG_GUI_EVENTS_FIGHTBUTTONEVENT:Class = FightButtonEvent;

      public static const NET_WG_GUI_EVENTS_FINALSTATISTICEVENT:Class = FinalStatisticEvent;

      public static const NET_WG_GUI_EVENTS_HEADERBUTTONBAREVENT:Class = HeaderButtonBarEvent;

      public static const NET_WG_GUI_EVENTS_HEADEREVENT:Class = HeaderEvent;

      public static const NET_WG_GUI_EVENTS_LISTEVENTEX:Class = ListEventEx;

      public static const NET_WG_GUI_EVENTS_LOBBYEVENT:Class = LobbyEvent;

      public static const NET_WG_GUI_EVENTS_LOBBYTDISPATCHEREVENT:Class = LobbyTDispatcherEvent;

      public static const NET_WG_GUI_EVENTS_MANAGEDCONTAINEREVENT:Class = ManagedContainerEvent;

      public static const NET_WG_GUI_EVENTS_MESSENGERBAREVENT:Class = MessengerBarEvent;

      public static const NET_WG_GUI_EVENTS_MODULEINFOEVENT:Class = ModuleInfoEvent;

      public static const NET_WG_GUI_EVENTS_NUMERICSTEPPEREVENT:Class = NumericStepperEvent;

      public static const NET_WG_GUI_EVENTS_PARAMSEVENT:Class = ParamsEvent;

      public static const NET_WG_GUI_EVENTS_PERSONALCASEEVENT:Class = PersonalCaseEvent;

      public static const NET_WG_GUI_EVENTS_QUESTEVENT:Class = QuestEvent;

      public static const NET_WG_GUI_EVENTS_RESIZABLEBLOCKEVENT:Class = ResizableBlockEvent;

      public static const NET_WG_GUI_EVENTS_SHELLRENDEREREVENT:Class = ShellRendererEvent;

      public static const NET_WG_GUI_EVENTS_SHOWDIALOGEVENT:Class = ShowDialogEvent;

      public static const NET_WG_GUI_EVENTS_STATEMANAGEREVENT:Class = StateManagerEvent;

      public static const NET_WG_GUI_EVENTS_TIMELINEEVENT:Class = TimelineEvent;

      public static const NET_WG_GUI_EVENTS_TRAININGEVENT:Class = TrainingEvent;

      public static const NET_WG_GUI_EVENTS_UILOADEREVENT:Class = UILoaderEvent;

      public static const NET_WG_GUI_EVENTS_VEHICLESELLDIALOGEVENT:Class = VehicleSellDialogEvent;

      public static const NET_WG_GUI_EVENTS_VIEWSTACKEVENT:Class = ViewStackEvent;

      public static const NET_WG_GUI_GAMELOADING_GAMELOADING:Class = GameLoading;

      public static const NET_WG_GUI_HISTORICALBATTLES_HISTORICALBATTLESLISTWINDOW:Class = HistoricalBattlesListWindow;

      public static const NET_WG_GUI_HISTORICALBATTLES_CONTROLS_BATTLECAROUSELITEMRENDERER:Class = BattleCarouselItemRenderer;

      public static const NET_WG_GUI_HISTORICALBATTLES_CONTROLS_BATTLESCAROUSEL:Class = BattlesCarousel;

      public static const NET_WG_GUI_HISTORICALBATTLES_CONTROLS_SIMPLEVEHICLELIST:Class = SimpleVehicleList;

      public static const NET_WG_GUI_HISTORICALBATTLES_CONTROLS_TEAMSVEHICLELIST:Class = TeamsVehicleList;

      public static const NET_WG_GUI_HISTORICALBATTLES_CONTROLS_VEHICLELISTITEMRENDERER:Class = VehicleListItemRenderer;

      public static const NET_WG_GUI_HISTORICALBATTLES_DATA_BATTLELISTITEMVO:Class = BattleListItemVO;

      public static const NET_WG_GUI_HISTORICALBATTLES_DATA_HISTORICALBATTLEVO:Class = HistoricalBattleVO;

      public static const NET_WG_GUI_HISTORICALBATTLES_DATA_VEHICLELISTITEMVO:Class = VehicleListItemVO;

      public static const NET_WG_GUI_HISTORICALBATTLES_EVENTS_TEAMSVEHICLELISTEVENT:Class = TeamsVehicleListEvent;

      public static const NET_WG_GUI_INTRO_INTROINFOVO:Class = IntroInfoVO;

      public static const NET_WG_GUI_INTRO_INTROPAGE:Class = IntroPage;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_CHANGEPROPERTYEVENT:Class = ChangePropertyEvent;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_COMPONENTCREATEEVENT:Class = ComponentCreateEvent;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_COMPONENTINFOVO:Class = ComponentInfoVo;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_COMPONENTLISTITEMRENDERER:Class = ComponentListItemRenderer;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_COMPONENTSPANEL:Class = ComponentsPanel;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_EDITABLEPROPERTYLISTITEMRENDERER:Class = EditablePropertyListItemRenderer;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_GECOMPONENTVO:Class = GEComponentVO;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_GEDESIGNERWINDOW:Class = GEDesignerWindow;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_GEINSPECTWINDOW:Class = GEInspectWindow;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_GUIEDITORHELPER:Class = GUIEditorHelper;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_DATA_COMPONENTPROPERTIES:Class = ComponentProperties;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_DATA_COMPONENTPROPERTYVO:Class = ComponentPropertyVO;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_DATA_PROPTYPES:Class = PropTypes;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_VIEWS_EVENTSVIEW:Class = EventsView;

      public static const NET_WG_GUI_LOBBY_GUIEDITOR_VIEWS_INSPECTORVIEW:Class = InspectorView;

      public static const NET_WG_GUI_LOBBY_LOBBYPAGE:Class = LobbyPage;

      public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKS:Class = Barracks;

      public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSFORM:Class = BarracksForm;

      public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSITEMRENDERER:Class = BarracksItemRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_BATTLERESULTS:Class = BattleResults;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_BATTLERESULTSEVENTRENDERER:Class = BattleResultsEventRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMMONSTATS:Class = CommonStats;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CUSTOMACHIEVEMENT:Class = CustomAchievement;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DETAILSBLOCK:Class = DetailsBlock;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DETAILSSTATS:Class = DetailsStats;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EFFICIENCYICONRENDERER:Class = EfficiencyIconRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EFFICIENCYRENDERER:Class = EfficiencyRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MEDALSLIST:Class = MedalsList;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSELEMENT:Class = ProgressElement;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TANKSTATSVIEW:Class = TankStatsView;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMMEMBERITEMRENDERER:Class = TeamMemberItemRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMMEMBERSTATSVIEW:Class = TeamMemberStatsView;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMSTATS:Class = TeamStats;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMSTATSLIST:Class = TeamStatsList;

      public static const NET_WG_GUI_LOBBY_BATTLERESULTS_VEHICLEDETAILS:Class = VehicleDetails;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_BATTLELOADING:Class = BattleLoading;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_BATTLELOADINGFORM:Class = BattleLoadingForm;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_PLAYERITEMRENDERER:Class = PlayerItemRenderer;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_CONSTANTS_PLAYERSTATUS:Class = net.wg.gui.lobby.battleloading.constants.PlayerStatus;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_CONSTANTS_VEHICLESTATUS:Class = VehicleStatus;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_DATA_ENEMYVEHICLESDATAPROVIDER:Class = EnemyVehiclesDataProvider;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_DATA_TEAMVEHICLESDATAPROVIDER:Class = TeamVehiclesDataProvider;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_INTERFACES_IVEHICLESDATAPROVIDER:Class = IVehiclesDataProvider;

      public static const NET_WG_GUI_LOBBY_BATTLELOADING_VO_VEHICLEINFOVO:Class = VehicleInfoVO;

      public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUE:Class = BattleQueue;

      public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUEITEMRENDERER:Class = BattleQueueItemRenderer;

      public static const NET_WG_GUI_LOBBY_BROWSER_BROWSERACTIONBTN:Class = BrowserActionBtn;

      public static const NET_WG_GUI_LOBBY_BROWSER_BROWSEREVENT:Class = BrowserEvent;

      public static const NET_WG_GUI_LOBBY_BROWSER_BROWSERHITAREA:Class = BrowserHitArea;

      public static const NET_WG_GUI_LOBBY_BROWSER_BROWSERWINDOW:Class = BrowserWindow;

      public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_CONFIRMMODULESETTINGSVO:Class = ConfirmModuleSettingsVO;

      public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_CONFIRMMODULEWINDOW:Class = ConfirmModuleWindow;

      public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_MODULEINFOVO:Class = ModuleInfoVo;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_BASETIMEDCUSTOMIZATIONGROUPVIEW:Class = BaseTimedCustomizationGroupView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_BASETIMEDCUSTOMIZATIONSECTIONVIEW:Class = BaseTimedCustomizationSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_CAMODROPBUTTON:Class = CamoDropButton;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_CAMOUFLAGEGROUPVIEW:Class = CamouflageGroupView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_CAMOUFLAGESECTIONVIEW:Class = CamouflageSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_CUSTOMIZATIONEVENT:Class = CustomizationEvent;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_EMBLEMLEFTSECTIONVIEW:Class = EmblemLeftSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_EMBLEMRIGHTSECTIONVIEW:Class = EmblemRightSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_INSCRIPTIONLEFTSECTIONVIEW:Class = InscriptionLeftSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_INSCRIPTIONRIGHTSECTIONVIEW:Class = InscriptionRightSectionView;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_VEHICLECUSTOMIZATION:Class = VehicleCustomization;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_DATA_CAMOUFLAGESDATAPROVIDER:Class = CamouflagesDataProvider;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_DATA_DAAPIITEMSDATAPROVIDER:Class = DAAPIItemsDataProvider;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_DATA_RENTALPACKAGEDAAPIDATAPROVIDER:Class = RentalPackageDAAPIDataProvider;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_CAMODEMORENDERER:Class = CamoDemoRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_CAMOUFLAGEITEMRENDERER:Class = CamouflageItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_CUSTOMIZATIONITEMRENDERER:Class = CustomizationItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_INSCRIPTIONITEMRENDERER:Class = InscriptionItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_PRICEITEMRENDERER:Class = PriceItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_RENDERERBORDER:Class = RendererBorder;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_RENTALPACKAGEITEMRENDERER:Class = RentalPackageItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_SECTIONITEMRENDERER:Class = SectionItemRenderer;

      public static const NET_WG_GUI_LOBBY_CUSTOMIZATION_RENDERERS_TEXTUREITEMRENDERER:Class = TextureItemRenderer;

      public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DEMONSTRATORWINDOW:Class = DemonstratorWindow;

      public static const NET_WG_GUI_LOBBY_DEMONSTRATION_MAPITEMRENDERER:Class = MapItemRenderer;

      public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_DEMONSTRATORVO:Class = DemonstratorVO;

      public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_MAPITEMVO:Class = MapItemVO;

      public static const NET_WG_GUI_LOBBY_DIALOGS_DEMOUNTDEVICEDIALOG:Class = DemountDeviceDialog;

      public static const NET_WG_GUI_LOBBY_DIALOGS_DESTROYDEVICEDIALOG:Class = DestroyDeviceDialog;

      public static const NET_WG_GUI_LOBBY_DIALOGS_DISMISSTANKMANDIALOG:Class = DismissTankmanDialog;

      public static const NET_WG_GUI_LOBBY_DIALOGS_FREEXPINFOWINDOW:Class = FreeXPInfoWindow;

      public static const NET_WG_GUI_LOBBY_DIALOGS_ICONDIALOG:Class = IconDialog;

      public static const NET_WG_GUI_LOBBY_DIALOGS_ICONPRICEDIALOG:Class = IconPriceDialog;

      public static const NET_WG_GUI_LOBBY_DIALOGS_ITEMSTATUSDATA:Class = ItemStatusData;

      public static const NET_WG_GUI_LOBBY_DIALOGS_PRICEMC:Class = PriceMc;

      public static const NET_WG_GUI_LOBBY_DIALOGS_SIMPLEDIALOG:Class = SimpleDialog;

      public static const NET_WG_GUI_LOBBY_ELITEWINDOW_ELITEWINDOW:Class = EliteWindow;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREWDROPDOWNEVENT:Class = CrewDropDownEvent;

      public static const NET_WG_GUI_LOBBY_HANGAR_HANGAR:Class = Hangar;

      public static const NET_WG_GUI_LOBBY_HANGAR_IGRLABEL:Class = IgrLabel;

      public static const NET_WG_GUI_LOBBY_HANGAR_PARAMS:Class = Params;

      public static const NET_WG_GUI_LOBBY_HANGAR_PARAMSLISTENER:Class = ParamsListener;

      public static const NET_WG_GUI_LOBBY_HANGAR_PARAMSVO:Class = ParamsVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_RESEARCHPANEL:Class = ResearchPanel;

      public static const NET_WG_GUI_LOBBY_HANGAR_TANKPARAM:Class = TankParam;

      public static const NET_WG_GUI_LOBBY_HANGAR_TMENXPPANEL:Class = TmenXpPanel;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_AMMUNITIONPANEL:Class = AmmunitionPanel;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_DEVICESLOT:Class = DeviceSlot;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EQUIPMENTSLOT:Class = EquipmentSlot;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EXTRAICON:Class = ExtraIcon;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_FITTINGLISTITEMRENDERER:Class = FittingListItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_FITTINGSELECT:Class = FittingSelect;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_HISTORICALMODULESOVERLAY:Class = HistoricalModulesOverlay;

      public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_MODULESLOT:Class = ModuleSlot;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREW:Class = Crew;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWITEMRENDERER:Class = CrewItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWSCROLLINGLIST:Class = CrewScrollingList;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_ICONSPROPS:Class = IconsProps;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_RECRUITITEMRENDERER:Class = RecruitItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_RECRUITRENDERERVO:Class = RecruitRendererVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_SKILLSVO:Class = SkillsVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_SMALLSKILLITEMRENDERER:Class = SmallSkillItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMENICONS:Class = TankmenIcons;

      public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TEXTOBJECT:Class = TextObject;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_AMMOBLOCKOVERLAY:Class = AmmoBlockOverlay;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTITEM:Class = EquipmentItem;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTLISTITEMRENDERER:Class = EquipmentListItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_MAINTENANCEDROPDOWN:Class = MaintenanceDropDown;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_MAINTENANCESTATUSINDICATOR:Class = MaintenanceStatusIndicator;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLITEMRENDERER:Class = ShellItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLLISTITEMRENDERER:Class = ShellListItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_TECHNICALMAINTENANCE:Class = TechnicalMaintenance;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_HISTORICALAMMOVO:Class = HistoricalAmmoVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_MAINTENANCEVO:Class = MaintenanceVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_MODULEVO:Class = net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_SHELLVO:Class = ShellVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EVENTS_ONEQUIPMENTRENDEREROVER:Class = OnEquipmentRendererOver;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CLANLOCKUI:Class = ClanLockUI;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSEL:Class = TankCarousel;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSELFILTERS:Class = TankCarouselFilters;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSELITEMRENDERER:Class = TankCarouselItemRenderer;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_VEHICLECAROUSELVO:Class = VehicleCarouselVO;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_VEHICLECAROUSELVOBUILDER:Class = VehicleCarouselVOBuilder;

      public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_VEHICLECAROUSELVOMANAGER:Class = VehicleCarouselVOManager;

      public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTINFO:Class = AccountInfo;

      public static const NET_WG_GUI_LOBBY_HEADER_FIGHTBUTTON:Class = FightButton;

      public static const NET_WG_GUI_LOBBY_HEADER_FIGHTBUTTONFANCYRENDERER:Class = FightButtonFancyRenderer;

      public static const NET_WG_GUI_LOBBY_HEADER_FIGHTBUTTONFANCYSELECT:Class = FightButtonFancySelect;

      public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR:Class = HeaderButtonBar;

      public static const NET_WG_GUI_LOBBY_HEADER_LOBBYHEADER:Class = LobbyHeader;

      public static const NET_WG_GUI_LOBBY_HEADER_MAINMENU:Class = MainMenu;

      public static const NET_WG_GUI_LOBBY_HEADER_QUESTSCONTROL:Class = QuestsControl;

      public static const NET_WG_GUI_LOBBY_HEADER_SERVERSTATS:Class = ServerStats;

      public static const NET_WG_GUI_LOBBY_HEADER_SERVERVO:Class = ServerVO;

      public static const NET_WG_GUI_LOBBY_HEADER_TANKPANEL:Class = TankPanel;

      public static const NET_WG_GUI_LOBBY_HEADER_TUTORIALCONTROL:Class = TutorialControl;

      public static const NET_WG_GUI_LOBBY_MENU_LOBBYMENU:Class = LobbyMenu;

      public static const NET_WG_GUI_LOBBY_MENU_LOBBYMENUFORM:Class = LobbyMenuForm;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERBAR:Class = MessengerBar;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_NOTIFICATIONLISTBUTTON:Class = NotificationListButton;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWGEOMETRYINBAR:Class = WindowGeometryInBar;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWOFFSETSINBAR:Class = WindowOffsetsInBar;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELBUTTON:Class = ChannelButton;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSEL:Class = ChannelCarousel;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSELSCROLLBAR:Class = ChannelCarouselScrollBar;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELLIST:Class = ChannelList;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELRENDERER:Class = ChannelRenderer;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_CHANNELLISTITEMVO:Class = ChannelListItemVO;

      public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_EVENTS_CHANNELLISTEVENT:Class = ChannelListEvent;

      public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEEFFECTS:Class = ModuleEffects;

      public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEPARAMETERS:Class = ModuleParameters;

      public static const NET_WG_GUI_LOBBY_PREMIUMFORM_DISCOUNTPRICE:Class = DiscountPrice;

      public static const NET_WG_GUI_LOBBY_PREMIUMFORM_PREMIUMFORM:Class = PremiumForm;

      public static const NET_WG_GUI_LOBBY_PREMIUMFORM_PREMIUMFORMITEMRENDERER:Class = PremiumFormItemRenderer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILE:Class = Profile;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILECONSTANTS:Class = ProfileConstants;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEINVALIDATIONTYPES:Class = ProfileInvalidationTypes;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEMENUINFOVO:Class = ProfileMenuInfoVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILESECTIONSIMPORTER:Class = ProfileSectionsImporter;

      public static const NET_WG_GUI_LOBBY_PROFILE_PROFILETABNAVIGATOR:Class = ProfileTabNavigator;

      public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONINFO:Class = SectionInfo;

      public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONVIEWINFO:Class = SectionViewInfo;

      public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONSDATAUTIL:Class = SectionsDataUtil;

      public static const NET_WG_GUI_LOBBY_PROFILE_USERINFOFORM:Class = UserInfoForm;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_ADVANCEDLINEDESCRICONTEXT:Class = AdvancedLineDescrIconText;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_AWARDSTILELISTBLOCK:Class = AwardsTileListBlock;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_BATTLESTYPEDROPDOWN:Class = BattlesTypeDropdown;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CENTEREDLINEICONTEXT:Class = CenteredLineIconText;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_COLOREDDESHLINETEXTITEM:Class = ColoredDeshLineTextItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_DASHLINE:Class = DashLine;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_DASHLINETEXTITEM:Class = DashLineTextItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_DATAVIEWSTACK:Class = DataViewStack;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_GRADIENTLINEBUTTONBAR:Class = GradientLineButtonBar;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_HIDABLESCROLLBAR:Class = HidableScrollBar;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_ICOUNTER:Class = ICounter;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_ILDITINFO:Class = ILditInfo;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_IRESIZABLECONTENT:Class = net.wg.gui.lobby.profile.components.IResizableContent;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITBATTLES:Class = LditBattles;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITMARKSOFMASTERY:Class = LditMarksOfMastery;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITVALUED:Class = LditValued;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINEBUTTONBAR:Class = LineButtonBar;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINEDESCRICONTEXT:Class = LineDescrIconText;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINEICONTEXT:Class = LineIconText;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINETEXTCOMPONENT:Class = LineTextComponent;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PERSONALSCORECOMPONENT:Class = PersonalScoreComponent;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEDASHLINETEXTITEM:Class = ProfileDashLineTextItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEFOOTER:Class = ProfileFooter;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEMEDALSLIST:Class = ProfileMedalsList;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEPAGEFOOTER:Class = ProfilePageFooter;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEWINDOWFOOTER:Class = ProfileWindowFooter;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLECONTENT:Class = ResizableContent;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLEINVALIDATIONTYPES:Class = ResizableInvalidationTypes;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLESCROLLPANE:Class = ResizableScrollPane;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLETILELIST:Class = ResizableTileList;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLEVIEWSTACK:Class = ResizableViewStack;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_SCROLLPANE:Class = ScrollPane;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_SIMPLELOADER:Class = SimpleLoader;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TECHMASTERYICON:Class = TechMasteryIcon;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TESTTRACK:Class = TestTrack;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_UNDERLINEDTEXT:Class = UnderlinedText;

      public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_USERDATEFOOTER:Class = UserDateFooter;

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

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEACHIEVEMENTVO:Class = ProfileAchievementVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEBASEINFOVO:Class = ProfileBaseInfoVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILECOMMONINFOVO:Class = ProfileCommonInfoVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEDOSSIERINFOVO:Class = ProfileDossierInfoVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEUSERVO:Class = ProfileUserVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_DATA_SECTIONLAYOUTMANAGER:Class = SectionLayoutManager;

      public static const NET_WG_GUI_LOBBY_PROFILE_HEADERBAR_PROFILEHEADERBUTTONBAR:Class = ProfileHeaderButtonBar;

      public static const NET_WG_GUI_LOBBY_PROFILE_HEADERBAR_PROFILETABBUTTON:Class = ProfileTabButton;

      public static const NET_WG_GUI_LOBBY_PROFILE_HEADERBAR_PROFILETABBUTTONBG:Class = ProfileTabButtonBg;

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

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_AXISPOINTLEVELS:Class = AxisPointLevels;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_AXISPOINTNATIONS:Class = AxisPointNations;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_AXISPOINTTYPES:Class = AxisPointTypes;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_COMMONSTATISTICS:Class = CommonStatistics;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_LEVELBARCHARTITEM:Class = LevelBarChartItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_LEVELSSTATISTICCHART:Class = LevelsStatisticChart;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_NATIONBARCHARTITEM:Class = NationBarChartItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_NATIONSSTATISTICSCHART:Class = NationsStatisticsChart;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICS:Class = ProfileStatistics;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICSVO:Class = ProfileStatisticsVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTAXISPOINT:Class = StatisticBarChartAxisPoint;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTINITIALIZER:Class = StatisticBarChartInitializer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTITEM:Class = StatisticBarChartItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTLAYOUT:Class = StatisticBarChartLayout;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICCHARTINFO:Class = StatisticChartInfo;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHART:Class = StatisticsBarChart;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHARTAXIS:Class = StatisticsBarChartAxis;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSCHARTITEMANIMCLIENT:Class = StatisticsChartItemAnimClient;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSCHARTSUTILS:Class = StatisticsChartsUtils;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSLAYOUTMANAGER:Class = StatisticsLayoutManager;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSTOOLTIPDATAVO:Class = StatisticsTooltipDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TFCONTAINER:Class = TfContainer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TYPEBARCHARTITEM:Class = TypeBarChartItem;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TYPESSTATISTICSCHART:Class = TypesStatisticsChart;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_BODYCONTAINER:Class = BodyContainer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSGROUP:Class = ChartsStatisticsGroup;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSVIEW:Class = ChartsStatisticsView;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_DETAILEDLABELDATAVO:Class = DetailedLabelDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_DETAILEDSTATISTICSLABELDATAVO:Class = DetailedStatisticsLabelDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_DETAILEDSTATISTICSUNIT:Class = DetailedStatisticsUnit;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_DETAILEDSTATISTICSUNITVO:Class = DetailedStatisticsUnitVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_DETAILEDSTATISTICSVIEW:Class = DetailedStatisticsView;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_PROFILESTATISTICSDETAILEDVO:Class = ProfileStatisticsDetailedVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICCHARTSINITDATAVO:Class = StatisticChartsInitDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSBODYVO:Class = StatisticsBodyVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSCHARTSTABDATAVO:Class = StatisticsChartsTabDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSDASHLINETEXTITEMIRENDERER:Class = StatisticsDashLineTextItemIRenderer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSLABELDATAVO:Class = StatisticsLabelDataVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_DETAILEDSTATISTICS_DETAILEDSTATISTICSGROUPEX:Class = DetailedStatisticsGroupEx;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERBGIMAGE:Class = HeaderBGImage;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERCONTAINER:Class = HeaderContainer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERITEMSTYPES:Class = HeaderItemsTypes;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_STATISTICSHEADERVO:Class = StatisticsHeaderVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_AWARDSLISTCOMPONENT:Class = AwardsListComponent;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_LINETEXTFIELDSLAYOUT:Class = LineTextFieldsLayout;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARY:Class = ProfileSummary;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYPAGE:Class = ProfileSummaryPage;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYVO:Class = ProfileSummaryVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYWINDOW:Class = ProfileSummaryWindow;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYINITVO:Class = SummaryInitVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYPAGEINITVO:Class = SummaryPageInitVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYVO:Class = SummaryVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_ACHIEVEMENTSMALL:Class = AchievementSmall;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILESORTINGBTNINFO:Class = ProfileSortingBtnInfo;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILESORTINGBUTTON:Class = ProfileSortingButton;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUE:Class = ProfileTechnique;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEEMPTYSCREEN:Class = ProfileTechniqueEmptyScreen;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEPAGE:Class = ProfileTechniquePage;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEWINDOW:Class = ProfileTechniqueWindow;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHSTATISTICSINITVO:Class = TechStatisticsInitVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNICSDASHLINETEXTITEMIRENDERER:Class = TechnicsDashLineTextItemIRenderer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTTAB:Class = TechniqueAchievementTab;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTSBLOCK:Class = TechniqueAchievementsBlock;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELIST:Class = TechniqueList;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELISTCOMPONENT:Class = TechniqueListComponent;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUERENDERER:Class = TechniqueRenderer;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTACKCOMPONENT:Class = TechniqueStackComponent;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTATISTICTAB:Class = TechniqueStatisticTab;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_PROFILEVEHICLEDOSSIERVO:Class = ProfileVehicleDossierVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_SORTINGSETTINGVO:Class = SortingSettingVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUELISTVEHICLEVO:Class = TechniqueListVehicleVO;

      public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUESTATISTICVO:Class = TechniqueStatisticVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONBLOCK:Class = ConditionBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONELEMENT:Class = ConditionElement;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DESCRIPTIONBLOCK:Class = DescriptionBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_HEADERBLOCK:Class = HeaderBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_IQUESTSTAB:Class = IQuestsTab;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTAWARDSBLOCK:Class = QuestAwardsBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTBLOCK:Class = QuestBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTCONTENT:Class = QuestContent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTRENDERER:Class = QuestRenderer;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSCROLLPANE:Class = QuestScrollPane;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSCURRENTTAB:Class = QuestsCurrentTab;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSFUTURETAB:Class = QuestsFutureTab;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSLIST:Class = QuestsList;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSWINDOW:Class = QuestsWindow;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_REQUIREMENTBLOCK:Class = RequirementBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKCOMPONENT:Class = SubtaskComponent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKSLIST:Class = SubtasksList;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_VEHICLEBLOCK:Class = VehicleBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ABSTRACTRESIZABLECONTENT:Class = AbstractResizableContent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ALERTMESSAGE:Class = AlertMessage;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_COMMONCONDITIONSBLOCK:Class = CommonConditionsBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CONDITIONSEPARATOR:Class = ConditionSeparator;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_EVENTSRESIZABLECONTENT:Class = EventsResizableContent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INNERRESIZABLECONTENT:Class = InnerResizableContent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_MOVABLEBLOCKSCONTAINER:Class = MovableBlocksContainer;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_PROGRESSBLOCK:Class = ProgressBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_PROGRESSQUESTINDICATOR:Class = ProgressQuestIndicator;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTICONELEMENT:Class = QuestIconElement;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSTATUSCOMPONENT:Class = QuestStatusComponent;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSCOUNTER:Class = QuestsCounter;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSDASHLINEITEM:Class = QuestsDashlineItem;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTAINER:Class = ResizableContainer;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTENTHEADER:Class = ResizableContentHeader;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_SORTINGPANEL:Class = SortingPanel;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TEXTPROGRESSELEMENT:Class = TextProgressElement;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLEITEMRENDERER:Class = VehicleItemRenderer;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLESSORTINGBLOCK:Class = VehiclesSortingBlock;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_COMPLEXTOOLTIPVO:Class = ComplexTooltipVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONELEMENTVO:Class = ConditionElementVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONSEPARATORVO:Class = ConditionSeparatorVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_DESCRIPTIONVO:Class = DescriptionVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_EVENTSRESIZABLECONTENTVO:Class = EventsResizableContentVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_HEADERDATAVO:Class = HeaderDataVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_INFODATAVO:Class = InfoDataVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PROGRESSBLOCKVO:Class = ProgressBlockVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDASHLINEITEMVO:Class = QuestDashlineItemVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDATAVO:Class = QuestDataVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTICONELEMENTVO:Class = QuestIconElementVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTRENDERERVO:Class = QuestRendererVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTVEHICLERENDERERVO:Class = QuestVehicleRendererVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_REQUIREMENTBLOCKVO:Class = RequirementBlockVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SORTEDBTNVO:Class = SortedBtnVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SUBTASKVO:Class = SubtaskVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLEBLOCKVO:Class = VehicleBlockVO;

      public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLESSORTINGBLOCKVO:Class = VehiclesSortingBlockVO;

      public static const NET_WG_GUI_LOBBY_RECRUITWINDOW_RECRUITWINDOW:Class = RecruitWindow;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWBLOCKVO:Class = RetrainCrewBlockVO;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWMAINBUTTONS:Class = RetrainCrewMainButtons;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWOPERATIONVO:Class = RetrainCrewOperationVO;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWROLEIR:Class = RetrainCrewRoleIR;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWVEHICLEVO:Class = RetrainCrewVehicleVO;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWWINDOW:Class = RetrainCrewWindow;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINTANKMANVO:Class = RetrainTankmanVO;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINVEHICLEBLOCKVO:Class = RetrainVehicleBlockVO;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_SELPRICEINFO:Class = SelPriceInfo;

      public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_TANKMANCREWRETRAININGSMALLBUTTON:Class = TankmanCrewRetrainingSmallButton;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_CONTROLQUESTIONCOMPONENT:Class = ControlQuestionComponent;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_MOVINGRESULT:Class = MovingResult;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SALEITEMBLOCKRENDERER:Class = SaleItemBlockRenderer;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLDEVICESCOMPONENT:Class = SellDevicesComponent;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLDIALOGLISTITEMRENDERER:Class = SellDialogListItemRenderer;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLHEADERCOMPONENT:Class = SellHeaderComponent;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLSLIDINGCOMPONENT:Class = SellSlidingComponent;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SETTINGSBUTTON:Class = SettingsButton;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_SLIDINGSCROLLINGLIST:Class = SlidingScrollingList;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_TOTALRESULT:Class = TotalResult;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_USERINPUTCONTROL:Class = UserInputControl;

      public static const NET_WG_GUI_LOBBY_SELLDIALOG_VEHICLESELLDIALOG:Class = VehicleSellDialog;

      public static const NET_WG_GUI_LOBBY_SETTINGS_ADVANCEDGRAPHICCONTENTFORM:Class = AdvancedGraphicContentForm;

      public static const NET_WG_GUI_LOBBY_SETTINGS_ADVANCEDGRAPHICSETTINGSFORM:Class = AdvancedGraphicSettingsForm;

      public static const NET_WG_GUI_LOBBY_SETTINGS_AIMSETTINGS:Class = AimSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_CONTROLSSETTINGS:Class = ControlsSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_GAMESETTINGS:Class = GameSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_GAMESETTINGSBASE:Class = GameSettingsBase;

      public static const NET_WG_GUI_LOBBY_SETTINGS_GRAPHICSETTINGS:Class = GraphicSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_GRAPHICSETTINGSBASE:Class = GraphicSettingsBase;

      public static const NET_WG_GUI_LOBBY_SETTINGS_MARKERSETTINGS:Class = MarkerSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SCREENSETTINGSFORM:Class = ScreenSettingsForm;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSAIMFORM:Class = SettingsAimForm;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSBASEVIEW:Class = SettingsBaseView;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSCHANGESMAP:Class = SettingsChangesMap;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSCONFIG:Class = SettingsConfig;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSMARKERSFORM:Class = SettingsMarkersForm;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSWINDOW:Class = SettingsWindow;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDSETTINGS:Class = SoundSettings;

      public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDSETTINGSBASE:Class = SoundSettingsBase;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYINPUT:Class = KeyInput;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYSITEMRENDERER:Class = KeysItemRenderer;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYSSCROLLINGLIST:Class = KeysScrollingList;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_RADIOBUTTONBAR:Class = RadioButtonBar;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SETTINGSSCROLLPANE:Class = SettingsScrollPane;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SETTINGSSTEPSLIDER:Class = SettingsStepSlider;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SOUNDVOICEWAVES:Class = SoundVoiceWaves;

      public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_EVNTS_KEYINPUTEVENTS:Class = KeyInputEvents;

      public static const NET_WG_GUI_LOBBY_SETTINGS_EVNTS_ALTERNATIVEVOICEEVENT:Class = AlternativeVoiceEvent;

      public static const NET_WG_GUI_LOBBY_SETTINGS_EVNTS_SETTINGVIEWEVENT:Class = SettingViewEvent;

      public static const NET_WG_GUI_LOBBY_SETTINGS_EVNTS_SETTINGSSUBVEWEVENT:Class = SettingsSubVewEvent;

      public static const NET_WG_GUI_LOBBY_SETTINGS_VO_SETTINGSCONTROLPROP:Class = SettingsControlProp;

      public static const NET_WG_GUI_LOBBY_SETTINGS_VO_SETTINGSKEYPROP:Class = SettingsKeyProp;

      public static const NET_WG_GUI_LOBBY_STORE_COMPLEXLISTITEMRENDERER:Class = ComplexListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_MODULERENDERERCREDITS:Class = ModuleRendererCredits;

      public static const NET_WG_GUI_LOBBY_STORE_NATIONFILTER:Class = NationFilter;

      public static const NET_WG_GUI_LOBBY_STORE_STORE_STATUS_COLOR:Class = STORE_STATUS_COLOR;

      public static const NET_WG_GUI_LOBBY_STORE_STORE:Class = Store;

      public static const NET_WG_GUI_LOBBY_STORE_STOREEVENT:Class = StoreEvent;

      public static const NET_WG_GUI_LOBBY_STORE_STOREFORM:Class = StoreForm;

      public static const NET_WG_GUI_LOBBY_STORE_STOREHELPER:Class = StoreHelper;

      public static const NET_WG_GUI_LOBBY_STORE_STORELISTITEMRENDERER:Class = StoreListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_STORETABLE:Class = StoreTable;

      public static const NET_WG_GUI_LOBBY_STORE_STORETABLEDATAPROVIDER:Class = StoreTableDataProvider;

      public static const NET_WG_GUI_LOBBY_STORE_STORETOOLTIPMAPVO:Class = StoreTooltipMapVO;

      public static const NET_WG_GUI_LOBBY_STORE_STOREVIEWSEVENT:Class = StoreViewsEvent;

      public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADER:Class = TableHeader;

      public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADERINFO:Class = TableHeaderInfo;

      public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORY:Class = Inventory;

      public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYMODULELISTITEMRENDERER:Class = InventoryModuleListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYVEHICLELISTITEMRDR:Class = InventoryVehicleListItemRdr;

      public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_BASE_INVENTORYLISTITEMRENDERER:Class = InventoryListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOP:Class = Shop;

      public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPMODULELISTITEMRENDERER:Class = ShopModuleListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPVEHICLELISTITEMRENDERER:Class = ShopVehicleListItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_SHOP_BASE_ACTION_CREDITS_STATES:Class = ACTION_CREDITS_STATES;

      public static const NET_WG_GUI_LOBBY_STORE_SHOP_BASE_SHOPTABLEITEMRENDERER:Class = ShopTableItemRenderer;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_EQUIPMENTVIEW:Class = EquipmentView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_MODULEVIEW:Class = ModuleView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_OPTIONALDEVICEVIEW:Class = OptionalDeviceView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_SHELLVIEW:Class = ShellView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_VEHICLEVIEW:Class = VehicleView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_BASESTOREMENUVIEW:Class = BaseStoreMenuView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_FITSSELECTABLESTOREMENUVIEW:Class = FitsSelectableStoreMenuView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_SIMPLESTOREMENUVIEW:Class = SimpleStoreMenuView;

      public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_VIEWUIELEMENTVO:Class = ViewUIElementVO;

      public static const NET_WG_GUI_LOBBY_TANKMAN_CAROUSELTANKMANSKILLSMODEL:Class = CarouselTankmanSkillsModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_CREWTANKMANRETRAINING:Class = CrewTankmanRetraining;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASE:Class = PersonalCase;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBASE:Class = PersonalCaseBase;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKITEM:Class = PersonalCaseBlockItem;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKSAREA:Class = PersonalCaseBlocksArea;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASECURRENTVEHICLE:Class = PersonalCaseCurrentVehicle;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCS:Class = PersonalCaseDocs;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCSMODEL:Class = PersonalCaseDocsModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEINPUTLIST:Class = PersonalCaseInputList;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEMODEL:Class = PersonalCaseModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASERETRAININGMODEL:Class = PersonalCaseRetrainingModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLS:Class = PersonalCaseSkills;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSITEMRENDERER:Class = PersonalCaseSkillsItemRenderer;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSMODEL:Class = PersonalCaseSkillsModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESPECIALIZATION:Class = PersonalCaseSpecialization;

      public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESTATS:Class = PersonalCaseStats;

      public static const NET_WG_GUI_LOBBY_TANKMAN_RANKELEMENT:Class = RankElement;

      public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPMODEL:Class = SkillDropModel;

      public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPWINDOW:Class = SkillDropWindow;

      public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLITEMVIEWMINI:Class = SkillItemViewMini;

      public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLSITEMSRENDERERRANKICON:Class = SkillsItemsRendererRankIcon;

      public static const NET_WG_GUI_LOBBY_TANKMAN_TANKMANSKILLSINFOBLOCK:Class = TankmanSkillsInfoBlock;

      public static const NET_WG_GUI_LOBBY_TANKMAN_VEHICLETYPEBUTTON:Class = VehicleTypeButton;

      public static const NET_WG_GUI_LOBBY_TECHTREE_MENUHANDLER:Class = MenuHandler;

      public static const NET_WG_GUI_LOBBY_TECHTREE_RESEARCHPAGE:Class = ResearchPage;

      public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEEVENT:Class = TechTreeEvent;

      public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEPAGE:Class = TechTreePage;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_ACTIONNAME:Class = ActionName;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_COLORINDEX:Class = ColorIndex;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_ICONTEXTRESOLVER:Class = IconTextResolver;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NAMEDLABELS:Class = NamedLabels;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NAVINDICATOR:Class = NavIndicator;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODEENTITYTYPE:Class = NodeEntityType;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODESTATE:Class = NodeState;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_OUTLITERAL:Class = OutLiteral;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_TTINVALIDATIONTYPE:Class = TTInvalidationType;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_TTSOUNDID:Class = TTSoundID;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_XPTYPESTRINGS:Class = XpTypeStrings;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_ACTIONBUTTON:Class = ActionButton;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_EXPERIENCEINFORMATION:Class = ExperienceInformation;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_EXPERIENCELABEL:Class = ExperienceLabel;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELDELIMITER:Class = LevelDelimiter;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELSCONTAINER:Class = LevelsContainer;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NAMEANDXPFIELD:Class = NameAndXpField;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONBUTTON:Class = NationButton;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONSBUTTONBAR:Class = NationsButtonBar;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NODECOMPONENT:Class = NodeComponent;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_PREMIUMDESCRIPTION:Class = PremiumDescription;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_PREMIUMLAYOUT:Class = PremiumLayout;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RESEARCHTITLEBAR:Class = ResearchTitleBar;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RETURNTOTTBUTTON:Class = ReturnToTTButton;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_TYPEANDLEVELFIELD:Class = TypeAndLevelField;

      public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_XPICON:Class = XPIcon;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_ABSTRACTDATAPROVIDER:Class = AbstractDataProvider;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_NATIONVODATAPROVIDER:Class = NationVODataProvider;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_NATIONXMLDATAPROVIDER:Class = NationXMLDataProvider;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHVODATAPROVIDER:Class = ResearchVODataProvider;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHXMLDATAPROVIDER:Class = ResearchXMLDataProvider;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_ANIMATIONPROPERTIES:Class = AnimationProperties;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_INVENTORYSTATEITEM:Class = InventoryStateItem;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATECOLLECTION:Class = NodeStateCollection;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATEITEM:Class = NodeStateItem;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_RESEARCHSTATEITEM:Class = ResearchStateItem;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_STATEPROPERTIES:Class = StateProperties;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_UNLOCKEDSTATEITEM:Class = UnlockedStateItem;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_ACTIONDATA:Class = ActionData;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_EXTRAINFORMATION:Class = ExtraInformation;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NTDISPLAYINFO:Class = NTDisplayInfo;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NATIONDISPLAYSETTINGS:Class = NationDisplaySettings;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NODEDATA:Class = NodeData;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_PRIMARYCLASS:Class = PrimaryClass;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_RESEARCHDISPLAYINFO:Class = ResearchDisplayInfo;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_SHOPPRICE:Class = ShopPrice;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_UNLOCKPROPS:Class = UnlockProps;

      public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_VEHGLOBALSTATS:Class = VehGlobalStats;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_DISTANCE:Class = Distance;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_LINESGRAPHICS:Class = LinesGraphics;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NTGRAPHICS:Class = NTGraphics;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NODEINDEXFILTER:Class = NodeIndexFilter;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_RESEARCHGRAPHICS:Class = ResearchGraphics;

      public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_TITLEAPPEARANCE:Class = TitleAppearance;

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

      public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_NATIONTREE:Class = NationTree;

      public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_RESEARCHITEMS:Class = ResearchItems;

      public static const NET_WG_GUI_LOBBY_TRAINING_ARENAVOIPSETTINGS:Class = ArenaVoipSettings;

      public static const NET_WG_GUI_LOBBY_TRAINING_DROPLIST:Class = DropList;

      public static const NET_WG_GUI_LOBBY_TRAINING_DROPTILELIST:Class = DropTileList;

      public static const NET_WG_GUI_LOBBY_TRAINING_MINIMAPENTITY:Class = MinimapEntity;

      public static const NET_WG_GUI_LOBBY_TRAINING_MINIMAPENTRY:Class = MinimapEntry;

      public static const NET_WG_GUI_LOBBY_TRAINING_MINIMAPLOBBY:Class = MinimapLobby;

      public static const NET_WG_GUI_LOBBY_TRAINING_PLAYERELEMENT:Class = PlayerElement;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGCONTROLLER:Class = TrainingDragController;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGDELEGATE:Class = TrainingDragDelegate;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGFORM:Class = TrainingForm;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGLISTITEMRENDERER:Class = TrainingListItemRenderer;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGPLAYERITEMRENDERER:Class = TrainingPlayerItemRenderer;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGROOM:Class = TrainingRoom;

      public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGWINDOW:Class = TrainingWindow;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_BODYMC:Class = BodyMc;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_BUYINGVEHICLEVO:Class = BuyingVehicleVO;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_EXPANDBUTTON:Class = ExpandButton;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_FOOTERMC:Class = FooterMc;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_HEADERMC:Class = HeaderMc;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_VEHICLEBUYWINDOW:Class = VehicleBuyWindow;

      public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_VEHICLEBUYWINDOWANIMMANAGER:Class = VehicleBuyWindowAnimManager;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_BASEBLOCK:Class = BaseBlock;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_CREWBLOCK:Class = CrewBlock;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_PROPBLOCK:Class = PropBlock;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFO:Class = VehicleInfo;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOBASE:Class = VehicleInfoBase;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOCREW:Class = VehicleInfoCrew;

      public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOPROPS:Class = VehicleInfoProps;

      public static const NET_WG_GUI_LOBBY_WINDOW_BASEEXCHANGEWINDOW:Class = BaseExchangeWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGECURRENCYWINDOW:Class = ExchangeCurrencyWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANINITVO:Class = ExchangeFreeToTankmanInitVO;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWARNING:Class = ExchangeFreeToTankmanXpWarning;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWINDOW:Class = ExchangeFreeToTankmanXpWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEHEADER:Class = ExchangeHeader;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEUTILS:Class = ExchangeUtils;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEVCOINWARNINGMC:Class = ExchangeVcoinWarningMC;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEVCOINWINDOW:Class = ExchangeVcoinWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEWINDOW:Class = ExchangeWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPFROMVEHICLEIR:Class = ExchangeXPFromVehicleIR;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPLIST:Class = ExchangeXPList;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPTANKMANSKILLSMODEL:Class = ExchangeXPTankmanSkillsModel;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPVEHICLEVO:Class = ExchangeXPVehicleVO;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWARNINGSCREEN:Class = ExchangeXPWarningScreen;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWINDOW:Class = ExchangeXPWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_EXTENDEDICONTEXT:Class = ExtendedIconText;

      public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOW:Class = ProfileWindow;

      public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOWINITVO:Class = ProfileWindowInitVO;

      public static const NET_WG_GUI_LOBBY_WINDOW_VCOINEXCHANGEDATAVO:Class = VcoinExchangeDataVO;

      public static const NET_WG_GUI_LOGIN_EULA_EULADLG:Class = EULADlg;

      public static const NET_WG_GUI_LOGIN_EULA_EULAFULLDLG:Class = EULAFullDlg;

      public static const NET_WG_GUI_LOGIN_ILOGINFORM:Class = ILoginForm;

      public static const NET_WG_GUI_LOGIN_ISPARKSMANAGER:Class = ISparksManager;

      public static const NET_WG_GUI_LOGIN_IMPL_LOGINCREATEANACCOUNTWINDOW:Class = LoginCreateAnAccountWindow;

      public static const NET_WG_GUI_LOGIN_IMPL_LOGINEVENT:Class = LoginEvent;

      public static const NET_WG_GUI_LOGIN_IMPL_LOGINFORM:Class = LoginForm;

      public static const NET_WG_GUI_LOGIN_IMPL_LOGINPAGE:Class = LoginPage;

      public static const NET_WG_GUI_LOGIN_IMPL_LOGINQUEUEWINDOW:Class = LoginQueueWindow;

      public static const NET_WG_GUI_LOGIN_IMPL_SPARK:Class = Spark;

      public static const NET_WG_GUI_LOGIN_IMPL_SPARKSMANAGER:Class = SparksManager;

      public static const NET_WG_GUI_MESSENGER_CHANNELCOMPONENT:Class = ChannelComponent;

      public static const NET_WG_GUI_MESSENGER_ICHANNELCOMPONENT:Class = IChannelComponent;

      public static const NET_WG_GUI_MESSENGER_SMILEYMAP:Class = SmileyMap;

      public static const NET_WG_GUI_MESSENGER_CONTROLS_CHANNELITEMRENDERER:Class = ChannelItemRenderer;

      public static const NET_WG_GUI_MESSENGER_CONTROLS_MEMBERITEMRENDERER:Class = MemberItemRenderer;

      public static const NET_WG_GUI_MESSENGER_DATA_CHANNELMEMBERVO:Class = ChannelMemberVO;

      public static const NET_WG_GUI_MESSENGER_EVNTS_CHANNELSFORMEVENT:Class = ChannelsFormEvent;

      public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSFORMEVENT:Class = ContactsFormEvent;

      public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSCREATEFORM:Class = ChannelsCreateForm;

      public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSSEARCHFORM:Class = ChannelsSearchForm;

      public static const NET_WG_GUI_MESSENGER_FORMS_CONTACTSLISTFORM:Class = ContactsListForm;

      public static const NET_WG_GUI_MESSENGER_FORMS_CONTACTSSEARCHFORM:Class = ContactsSearchForm;

      public static const NET_WG_GUI_MESSENGER_META_IBASECHANNELWINDOWMETA:Class = IBaseChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_ICHANNELCOMPONENTMETA:Class = net.wg.gui.messenger.meta.IChannelComponentMeta;

      public static const NET_WG_GUI_MESSENGER_META_ICHANNELSMANAGEMENTWINDOWMETA:Class = IChannelsManagementWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_ICONNECTTOSECURECHANNELWINDOWMETA:Class = IConnectToSecureChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_ICONTACTSWINDOWMETA:Class = IContactsWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IFAQWINDOWMETA:Class = IFAQWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_ILOBBYCHANNELWINDOWMETA:Class = ILobbyChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_BASECHANNELWINDOWMETA:Class = BaseChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELCOMPONENTMETA:Class = ChannelComponentMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELSMANAGEMENTWINDOWMETA:Class = ChannelsManagementWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_CONNECTTOSECURECHANNELWINDOWMETA:Class = ConnectToSecureChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSWINDOWMETA:Class = ContactsWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_FAQWINDOWMETA:Class = FAQWindowMeta;

      public static const NET_WG_GUI_MESSENGER_META_IMPL_LOBBYCHANNELWINDOWMETA:Class = LobbyChannelWindowMeta;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_BASECHANNELWINDOW:Class = BaseChannelWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_CHANNELSMANAGEMENTWINDOW:Class = ChannelsManagementWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_CONNECTTOSECURECHANNELWINDOW:Class = ConnectToSecureChannelWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_CONTACTSWINDOW:Class = ContactsWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_FAQWINDOW:Class = FAQWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_LAZYCHANNELWINDOW:Class = LazyChannelWindow;

      public static const NET_WG_GUI_MESSENGER_WINDOWS_LOBBYCHANNELWINDOW:Class = LobbyChannelWindow;

      public static const NET_WG_GUI_NOTIFICATION_CAPTCHA:Class = CAPTCHA;

      public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONLISTVIEW:Class = NotificationListView;

      public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONPOPUPVIEWER:Class = NotificationPopUpViewer;

      public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONTIMECOMPONENT:Class = NotificationTimeComponent;

      public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONSLIST:Class = NotificationsList;

      public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGE:Class = ServiceMessage;

      public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEITEMRENDERER:Class = ServiceMessageItemRenderer;

      public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEPOPUP:Class = ServiceMessagePopUp;

      public static const NET_WG_GUI_NOTIFICATION_SYSTEMMESSAGEDIALOG:Class = SystemMessageDialog;

      public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONSTATE:Class = ButtonState;

      public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONTYPE:Class = ButtonType;

      public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_MESSAGEMETRICS:Class = MessageMetrics;

      public static const NET_WG_GUI_NOTIFICATION_EVENTS_NOTIFICATIONLISTEVENT:Class = NotificationListEvent;

      public static const NET_WG_GUI_NOTIFICATION_EVENTS_SERVICEMESSAGEEVENT:Class = ServiceMessageEvent;

      public static const NET_WG_GUI_NOTIFICATION_VO_BUTTONVO:Class = ButtonVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_LAYOUTINFOVO:Class = LayoutInfoVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_MESSAGEINFOVO:Class = MessageInfoVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONDIALOGINITINFOVO:Class = NotificationDialogInitInfoVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONINFOVO:Class = NotificationInfoVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONSETTINGSVO:Class = NotificationSettingsVO;

      public static const NET_WG_GUI_NOTIFICATION_VO_POPUPNOTIFICATIONINFOVO:Class = PopUpNotificationInfoVO;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSLISTRENDERERVO:Class = BSListRendererVO;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLIST:Class = BattleSessionList;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLISTRENDERER:Class = BattleSessionListRenderer;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONWINDOW:Class = BattleSessionWindow;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_FLAGSLIST:Class = FlagsList;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_REQUIREMENTINFO:Class = RequirementInfo;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPINFO:Class = TopInfo;

      public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPSTATS:Class = TopStats;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANIESLISTWINDOW:Class = CompaniesListWindow;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANIESSCROLLINGLIST:Class = CompaniesScrollingList;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYDROPDOWNEVENT:Class = CompanyDropDownEvent;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYDROPITEMRENDERER:Class = CompanyDropItemRenderer;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYDROPLIST:Class = CompanyDropList;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYEVENT:Class = CompanyEvent;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYLISTITEMRENDERER:Class = CompanyListItemRenderer;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYWINDOW:Class = CompanyWindow;

      public static const NET_WG_GUI_PREBATTLE_COMPANY_GROUPPLAYERSDROPDOWNMENU:Class = GroupPlayersDropDownMenu;

      public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATEFLAGS:Class = PrebattleStateFlags;

      public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATESTRING:Class = PrebattleStateString;

      public static const NET_WG_GUI_PREBATTLE_CONTROLS_TEAMMEMBERRENDERER:Class = TeamMemberRenderer;

      public static const NET_WG_GUI_PREBATTLE_DATA_PLAYERPRBINFOVO:Class = PlayerPrbInfoVO;

      public static const NET_WG_GUI_PREBATTLE_DATA_RECEIVEDINVITEVO:Class = ReceivedInviteVO;

      public static const NET_WG_GUI_PREBATTLE_INVITES_INVITESTACKCONTAINERBASE:Class = InviteStackContainerBase;

      public static const NET_WG_GUI_PREBATTLE_INVITES_PRBINVITESEARCHUSERSFORM:Class = PrbInviteSearchUsersForm;

      public static const NET_WG_GUI_PREBATTLE_INVITES_PRBSENDINVITECIGENERATOR:Class = PrbSendInviteCIGenerator;

      public static const NET_WG_GUI_PREBATTLE_INVITES_PRBSENDINVITESWINDOW:Class = PrbSendInvitesWindow;

      public static const NET_WG_GUI_PREBATTLE_INVITES_RECEIVEDINVITEWINDOW:Class = ReceivedInviteWindow;

      public static const NET_WG_GUI_PREBATTLE_INVITES_SENDINVITESEVENT:Class = SendInvitesEvent;

      public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERITEMRENDERER:Class = UserRosterItemRenderer;

      public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERVIEW:Class = UserRosterView;

      public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONLISTMETA:Class = IBattleSessionListMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONWINDOWMETA:Class = IBattleSessionWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_ICHANNELWINDOWMETA:Class = IChannelWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_ICOMPANIESWINDOWMETA:Class = ICompaniesWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_ICOMPANYWINDOWMETA:Class = ICompanyWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IPREBATTLEWINDOWMETA:Class = IPrebattleWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IPREQUEUEWINDOWMETA:Class = IPrequeueWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IRECEIVEDINVITEWINDOWMETA:Class = IReceivedInviteWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_ABSTRACT_PREBATTLEWINDOWABSTRACT:Class = PrebattleWindowAbstract;

      public static const NET_WG_GUI_PREBATTLE_META_ABSTRACT_PREQUEUEWINDOW:Class = PrequeueWindow;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONLISTMETA:Class = BattleSessionListMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONWINDOWMETA:Class = BattleSessionWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_CHANNELWINDOWMETA:Class = ChannelWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_COMPANIESWINDOWMETA:Class = CompaniesWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_COMPANYWINDOWMETA:Class = CompanyWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREBATTLEWINDOWMETA:Class = PrebattleWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREQUEUEWINDOWMETA:Class = PrequeueWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_META_IMPL_RECEIVEDINVITEWINDOWMETA:Class = ReceivedInviteWindowMeta;

      public static const NET_WG_GUI_PREBATTLE_PAGES_CHANNELWINDOW:Class = ChannelWindow;

      public static const NET_WG_GUI_PREBATTLE_PAGES_LAZYWINDOW:Class = LazyWindow;

      public static const NET_WG_GUI_PREBATTLE_PAGES_MEMBERDATAPROVIDER:Class = MemberDataProvider;

      public static const NET_WG_GUI_PREBATTLE_SQUAD_MESSENGERUTILS:Class = MessengerUtils;

      public static const NET_WG_GUI_PREBATTLE_SQUAD_SQUADITEMRENDERER:Class = SquadItemRenderer;

      public static const NET_WG_GUI_PREBATTLE_SQUAD_SQUADWINDOW:Class = SquadWindow;

      public static const NET_WG_GUI_PREBATTLE_SQUAD_SQUADWINDOWCIGENERATOR:Class = SquadWindowCIGenerator;

      public static const NET_WG_GUI_PREBATTLE_SQUAD_USERDATAFLAGS:Class = UserDataFlags;

      public static const NET_WG_GUI_TUTORIAL_TUTORIALBATTLELOADING:Class = TutorialBattleLoading;

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

      public static const NET_WG_GUI_TUTORIAL_CONTROLS_TUTORIALBATTLELOADINGFORM:Class = TutorialBattleLoadingForm;

      public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLENORESULTSMETA:Class = ITutorialBattleNoResultsMeta;

      public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLESTATISTICMETA:Class = ITutorialBattleStatisticMeta;

      public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALDIALOGMETA:Class = ITutorialDialogMeta;

      public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLENORESULTSMETA:Class = TutorialBattleNoResultsMeta;

      public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLESTATISTICMETA:Class = TutorialBattleStatisticMeta;

      public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALDIALOGMETA:Class = TutorialDialogMeta;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLENORESULTSWINDOW:Class = TutorialBattleNoResultsWindow;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLESTATISTICWINDOW:Class = TutorialBattleStatisticWindow;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALDIALOG:Class = TutorialDialog;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALGREETINGDIALOG:Class = TutorialGreetingDialog;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALQUEUEDIALOG:Class = TutorialQueueDialog;

      public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALVIDEODIALOG:Class = TutorialVideoDialog;

      public static const NET_WG_GUI_UTILS_COMPLEXTOOLTIPHELPER:Class = ComplexTooltipHelper;

      public static const NET_WG_GUI_UTILS_EXCLUDETWEENMANAGER:Class = ExcludeTweenManager;

      public static const NET_WG_GUI_UTILS_FRAMEWALKER:Class = FrameWalker;

      public static const NET_WG_GUI_UTILS_IMAGESUBSTITUTION:Class = ImageSubstitution;

      public static const NET_WG_GUI_UTILS_VEHICLESTATESTRING:Class = VehicleStateString;

      public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTPOPOVERVIEW:Class = AbstractPopOverView;

      public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTWINDOWVIEW:Class = AbstractWindowView;

      public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTWRAPPERVIEW:Class = AbstractWrapperView;

      public static const NET_WG_INFRASTRUCTURE_BASE_BASELAYOUT:Class = BaseLayout;

      public static const NET_WG_INFRASTRUCTURE_BASE_BASEVIEWWRAPPER:Class = BaseViewWrapper;

      public static const NET_WG_INFRASTRUCTURE_BASE_DEFAULTWINDOWGEOMETRY:Class = DefaultWindowGeometry;

      public static const NET_WG_INFRASTRUCTURE_BASE_SMARTPOPOVERVIEW:Class = SmartPopOverView;

      public static const NET_WG_INFRASTRUCTURE_BASE_STOREDWINDOWGEOMETRY:Class = StoredWindowGeometry;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IAMMUNITIONPANELMETA:Class = IAmmunitionPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBARRACKSMETA:Class = IBarracksMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEEXCHANGEWINDOWMETA:Class = IBaseExchangeWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLELOADINGMETA:Class = IBattleLoadingMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEQUEUEMETA:Class = IBattleQueueMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLERESULTSMETA:Class = IBattleResultsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERMETA:Class = IBrowserMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICAPTCHAMETA:Class = ICAPTCHAMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHANNELCAROUSELMETA:Class = IChannelCarouselMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHANNELCOMPONENTMETA:Class = net.wg.infrastructure.base.meta.IChannelComponentMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMMODULEWINDOWMETA:Class = IConfirmModuleWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWMETA:Class = ICrewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWOPERATIONSPOPOVERMETA:Class = ICrewOperationsPopOverMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICURSORMETA:Class = ICursorMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTBASEVIEWMETA:Class = ICyberSportBaseViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTINTROMETA:Class = ICyberSportIntroMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTMAINWINDOWMETA:Class = ICyberSportMainWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITMETA:Class = ICyberSportUnitMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITSLISTMETA:Class = ICyberSportUnitsListMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IDEMONSTRATORWINDOWMETA:Class = IDemonstratorWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IDISMISSTANKMANDIALOGMETA:Class = IDismissTankmanDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IEULAMETA:Class = IEULAMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IELITEWINDOWMETA:Class = IEliteWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEFREETOTANKMANXPWINDOWMETA:Class = IExchangeFreeToTankmanXpWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEVCOINWINDOWMETA:Class = IExchangeVcoinWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEWINDOWMETA:Class = IExchangeWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEXPWINDOWMETA:Class = IExchangeXpWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IFIGHTBUTTONMETA:Class = IFightButtonMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IFREEXPINFOWINDOWMETA:Class = IFreeXPInfoWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IGEDESIGNERWINDOWMETA:Class = IGEDesignerWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IGEINSPECTWINDOWMETA:Class = IGEInspectWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IHANGARMETA:Class = IHangarMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IHISTORICALBATTLESLISTWINDOWMETA:Class = IHistoricalBattlesListWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONDIALOGMETA:Class = IIconDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONPRICEDIALOGMETA:Class = IIconPriceDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IINTROPAGEMETA:Class = IIntroPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IINVENTORYMETA:Class = IInventoryMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYHEADERMETA:Class = ILobbyHeaderMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYMENUMETA:Class = ILobbyMenuMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYMESSENGERMETA:Class = ILobbyMessengerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYMINIMAPMETA:Class = ILobbyMinimapMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYPAGEMETA:Class = ILobbyPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINCREATEANACCOUNTWINDOWMETA:Class = ILoginCreateAnAccountWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINPAGEMETA:Class = ILoginPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINQUEUEWINDOWMETA:Class = ILoginQueueWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMESSENGERBARMETA:Class = IMessengerBarMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMINIMAPENTITYMETA:Class = IMinimapEntityMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMINIMAPLOBBYMETA:Class = IMinimapLobbyMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMODULEINFOMETA:Class = IModuleInfoMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONLISTBUTTONMETA:Class = INotificationListButtonMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONPOPUPVIEWERMETA:Class = INotificationPopUpViewerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONSLISTMETA:Class = INotificationsListMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IORDERSPANELMETA:Class = IOrdersPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPARAMSMETA:Class = IParamsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALCASEMETA:Class = IPersonalCaseMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPOPOVERVIEWMETA:Class = IPopOverViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPRBSENDINVITESWINDOWMETA:Class = IPrbSendInvitesWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPREMIUMFORMMETA:Class = IPremiumFormMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEACHIEVEMENTSECTIONMETA:Class = IProfileAchievementSectionMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEAWARDSMETA:Class = IProfileAwardsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEMETA:Class = IProfileMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESECTIONMETA:Class = IProfileSectionMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESTATISTICSMETA:Class = IProfileStatisticsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESUMMARYMETA:Class = IProfileSummaryMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETABNAVIGATORMETA:Class = IProfileTabNavigatorMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEMETA:Class = IProfileTechniqueMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEPAGEMETA:Class = IProfileTechniquePageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEWINDOWMETA:Class = IProfileWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCONTROLMETA:Class = IQuestsControlMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCURRENTTABMETA:Class = IQuestsCurrentTabMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSFUTURETABMETA:Class = IQuestsFutureTabMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSWINDOWMETA:Class = IQuestsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IRECRUITWINDOWMETA:Class = IRecruitWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHMETA:Class = IResearchMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHPANELMETA:Class = IResearchPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHVIEWMETA:Class = IResearchViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IRETRAINCREWWINDOWMETA:Class = IRetrainCrewWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IROSTERSLOTSETTINGSWINDOWMETA:Class = IRosterSlotSettingsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISETTINGSWINDOWMETA:Class = ISettingsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISHOPMETA:Class = IShopMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISIMPLEDIALOGMETA:Class = ISimpleDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISKILLDROPMETA:Class = ISkillDropMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISMARTPOPOVERVIEWMETA:Class = ISmartPopOverViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTOREMETA:Class = IStoreMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORETABLEMETA:Class = IStoreTableMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ISYSTEMMESSAGEDIALOGMETA:Class = ISystemMessageDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKCAROUSELMETA:Class = ITankCarouselMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHTREEMETA:Class = ITechTreeMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHNICALMAINTENANCEMETA:Class = ITechnicalMaintenanceMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITICKERMETA:Class = ITickerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITMENXPPANELMETA:Class = ITmenXpPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGFORMMETA:Class = ITrainingFormMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGROOMMETA:Class = ITrainingRoomMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGWINDOWMETA:Class = ITrainingWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITUTORIALCONTROLMETA:Class = ITutorialControlMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_ITUTORIALLAYOUTMETA:Class = ITutorialLayoutMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEBUYWINDOWMETA:Class = IVehicleBuyWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECUSTOMIZATIONMETA:Class = IVehicleCustomizationMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEINFOMETA:Class = IVehicleInfoMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELECTORPOPUPMETA:Class = IVehicleSelectorPopupMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELLDIALOGMETA:Class = IVehicleSellDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IWAITINGVIEWMETA:Class = IWaitingViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IWINDOWVIEWMETA:Class = IWindowViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IWRAPPERVIEWMETA:Class = IWrapperViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AMMUNITIONPANELMETA:Class = AmmunitionPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BARRACKSMETA:Class = BarracksMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEEXCHANGEWINDOWMETA:Class = BaseExchangeWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLELOADINGMETA:Class = BattleLoadingMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEQUEUEMETA:Class = BattleQueueMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLERESULTSMETA:Class = BattleResultsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERMETA:Class = BrowserMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CAPTCHAMETA:Class = CAPTCHAMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHANNELCAROUSELMETA:Class = ChannelCarouselMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLASSMANAGERMETA:Class = ClassManagerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMMODULEWINDOWMETA:Class = ConfirmModuleWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWMETA:Class = CrewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWOPERATIONSPOPOVERMETA:Class = CrewOperationsPopOverMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CURSORMETA:Class = CursorMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTBASEVIEWMETA:Class = CyberSportBaseViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTINTROMETA:Class = CyberSportIntroMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTMAINWINDOWMETA:Class = CyberSportMainWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITMETA:Class = CyberSportUnitMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITSLISTMETA:Class = CyberSportUnitsListMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DEMONSTRATORWINDOWMETA:Class = DemonstratorWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DISMISSTANKMANDIALOGMETA:Class = DismissTankmanDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EULAMETA:Class = EULAMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ELITEWINDOWMETA:Class = EliteWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEFREETOTANKMANXPWINDOWMETA:Class = ExchangeFreeToTankmanXpWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEVCOINWINDOWMETA:Class = ExchangeVcoinWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEWINDOWMETA:Class = ExchangeWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEXPWINDOWMETA:Class = ExchangeXpWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FIGHTBUTTONMETA:Class = FightButtonMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FREEXPINFOWINDOWMETA:Class = FreeXPInfoWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HANGARMETA:Class = HangarMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HISTORICALBATTLESLISTWINDOWMETA:Class = HistoricalBattlesListWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONDIALOGMETA:Class = IconDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONPRICEDIALOGMETA:Class = IconPriceDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INTROPAGEMETA:Class = IntroPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INVENTORYMETA:Class = InventoryMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYHEADERMETA:Class = LobbyHeaderMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYMENUMETA:Class = LobbyMenuMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYMESSENGERMETA:Class = LobbyMessengerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYMINIMAPMETA:Class = LobbyMinimapMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYPAGEMETA:Class = LobbyPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINCREATEANACCOUNTWINDOWMETA:Class = LoginCreateAnAccountWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINPAGEMETA:Class = LoginPageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINQUEUEWINDOWMETA:Class = LoginQueueWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MESSENGERBARMETA:Class = MessengerBarMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MINIMAPENTITYMETA:Class = MinimapEntityMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MINIMAPLOBBYMETA:Class = MinimapLobbyMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MODULEINFOMETA:Class = ModuleInfoMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONLISTBUTTONMETA:Class = NotificationListButtonMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONPOPUPVIEWERMETA:Class = NotificationPopUpViewerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONSLISTMETA:Class = NotificationsListMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PARAMSMETA:Class = ParamsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALCASEMETA:Class = PersonalCaseMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_POPOVERVIEWMETA:Class = PopOverViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PRBSENDINVITESWINDOWMETA:Class = PrbSendInvitesWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PREMIUMFORMMETA:Class = PremiumFormMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEACHIEVEMENTSECTIONMETA:Class = ProfileAchievementSectionMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEAWARDSMETA:Class = ProfileAwardsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEMETA:Class = ProfileMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESECTIONMETA:Class = ProfileSectionMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESTATISTICSMETA:Class = ProfileStatisticsMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESUMMARYMETA:Class = ProfileSummaryMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETABNAVIGATORMETA:Class = ProfileTabNavigatorMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEMETA:Class = ProfileTechniqueMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEPAGEMETA:Class = ProfileTechniquePageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEWINDOWMETA:Class = ProfileWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCONTROLMETA:Class = QuestsControlMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCURRENTTABMETA:Class = QuestsCurrentTabMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSFUTURETABMETA:Class = QuestsFutureTabMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSWINDOWMETA:Class = QuestsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RECRUITWINDOWMETA:Class = RecruitWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHMETA:Class = ResearchMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHPANELMETA:Class = ResearchPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHVIEWMETA:Class = ResearchViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RETRAINCREWWINDOWMETA:Class = RetrainCrewWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ROSTERSLOTSETTINGSWINDOWMETA:Class = RosterSlotSettingsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SETTINGSWINDOWMETA:Class = SettingsWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SHOPMETA:Class = ShopMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SIMPLEDIALOGMETA:Class = SimpleDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SKILLDROPMETA:Class = SkillDropMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SMARTPOPOVERVIEWMETA:Class = SmartPopOverViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATSSTORAGEMETA:Class = StatsStorageMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STOREMETA:Class = StoreMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORETABLEMETA:Class = StoreTableMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SYSTEMMESSAGEDIALOGMETA:Class = SystemMessageDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKCAROUSELMETA:Class = TankCarouselMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHTREEMETA:Class = TechTreeMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHNICALMAINTENANCEMETA:Class = TechnicalMaintenanceMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TICKERMETA:Class = TickerMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TMENXPPANELMETA:Class = TmenXpPanelMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGFORMMETA:Class = TrainingFormMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGROOMMETA:Class = TrainingRoomMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGWINDOWMETA:Class = TrainingWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TUTORIALCONTROLMETA:Class = TutorialControlMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TUTORIALLAYOUTMETA:Class = TutorialLayoutMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEBUYWINDOWMETA:Class = VehicleBuyWindowMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECUSTOMIZATIONMETA:Class = VehicleCustomizationMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEINFOMETA:Class = VehicleInfoMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELECTORPOPUPMETA:Class = VehicleSelectorPopupMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELLDIALOGMETA:Class = VehicleSellDialogMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VIEWPRESENTERMETA:Class = ViewPresenterMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WAITINGVIEWMETA:Class = WaitingViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WINDOWVIEWMETA:Class = WindowViewMeta;

      public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WRAPPERVIEWMETA:Class = WrapperViewMeta;

      public static const NET_WG_INFRASTRUCTURE_CONSTANTS_WINDOWVIEWINVALIDATIONTYPE:Class = WindowViewInvalidationType;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_COLORSCHEMEEVENT:Class = ColorSchemeEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_DRAGEVENT:Class = DragEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_DROPEVENT:Class = DropEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_ENVIRONMENTEVENT:Class = EnvironmentEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_FOCUSEDVIEWEVENT:Class = FocusedViewEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_GAMEEVENT:Class = GameEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_LIBRARYLOADEREVENT:Class = LibraryLoaderEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_LOADEREVENT:Class = LoaderEvent;

      public static const NET_WG_INFRASTRUCTURE_EVENTS_VOICECHATEVENT:Class = VoiceChatEvent;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATE:Class = DragDelegate;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATECONTROLLER:Class = DragDelegateController;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATE:Class = DropListDelegate;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATECTRLR:Class = DropListDelegateCtrlr;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_LIBRARYLOADER:Class = LibraryLoader;

      public static const NET_WG_INFRASTRUCTURE_HELPERS_LOADEREX:Class = LoaderEx;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IABSTRACTPOPOVERVIEW:Class = IAbstractPopOverView;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IABSTRACTWINDOWVIEW:Class = IAbstractWindowView;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IBASELAYOUT:Class = IBaseLayout;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_ICOUNTERCOMPONENT:Class = ICounterComponent;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IDRAGDELEGATE:Class = IDragDelegate;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IDRAGGABLELIST:Class = IDraggableList;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IDROPLISTDELEGATE:Class = IDropListDelegate;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IRESIZABLECONTENT:Class = net.wg.infrastructure.interfaces.IResizableContent;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISORTABLE:Class = ISortable;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISTOREMENUVIEW:Class = IStoreMenuView;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISTORETABLE:Class = IStoreTable;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISUBTASKCOMPONENT:Class = ISubtaskComponent;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IWINDOW:Class = IWindow;

      public static const NET_WG_INFRASTRUCTURE_INTERFACES_IWINDOWGEOMETRY:Class = IWindowGeometry;
   }

}