/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Pavel Máca
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.events.MouseEvent;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.utils.getQualifiedClassName;
    import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
    import net.wg.data.constants.generated.BATTLE_RESULTS_PREMIUM_STATES;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer;
    import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
    import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
    import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
    import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
    import scaleform.clik.events.ListEvent;
    import scaleform.gfx.TextFieldEx;

    public dynamic class UI_CommonStats extends CommonStats
    {
        private const FIELD_POS_TITLE:String = "fieldPosTitle";
        private const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private const FIELD_POS_PREM:String = "fieldPosPrem";
        private const CSS_FIELD_CLASS:String = "xvm_bsField";
        private const XP_IMG_TXT:String = " <IMG SRC='img://gui/maps/icons/library/XpIcon-1.png' width='16' height='16' vspace='-2'/>";

        private var _fieldsInitialized:Boolean = false;
        private var _data:BattleResultsVO = null;
        private var _xdataList:XvmCommonStatsDataListVO = null;
        private var _currentTankIndex:int = 0;

        private var armorNames:Array = null;
        private var damageAssistedNames:Array = null;
        private var damageDealtNames:Array = null;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;

        private var spottedTotalField:EfficiencyIconRenderer;
        private var damageAssistedTotalField:EfficiencyIconRenderer;
        private var armorTotalField:EfficiencyIconRenderer;
        private var critsTotalField:EfficiencyIconRenderer;
        private var damageTotalField:EfficiencyIconRenderer;
        private var killsTotalField:EfficiencyIconRenderer;

        private var tooltips:Object;

        public function UI_CommonStats()
        {
            //Logger.add("UI_CommonStats");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            tooltips = { };
            tankSlot.addEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler, false, 0, true);
        }

        override protected function onDispose():void
        {
            tankSlot.removeEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler);

            _data = null;
            _xdataList = null;

            try
            {
                // Some error occurs for an unknown reason
                super.onDispose();
            }
            catch (ex:Error)
            {
                if (Config.IS_DEVELOPMENT)
                {
                    Logger.err(ex);
                }
            }
        }

        override protected function draw():void
        {
            super.draw();

            if (detailsMc.compareState.noPremTitleLbl.defaultTextFormat.leading == 2)
            {
                var textFormat:TextFormat = detailsMc.compareState.noPremTitleLbl.defaultTextFormat;
                textFormat.leading = -4;
                textFormat.align = TEXT_ALIGN.CENTER;
                detailsMc.compareState.noPremTitleLbl.setTextFormat(textFormat);
                detailsMc.compareState.premTitleLbl.setTextFormat(textFormat);
            }
        }

        override public function update(data:Object):void
        {
            //Logger.add("update");
            try
            {
                // Use data['common']['regionNameStr'] value to transfer XVM data.
                // Cannot add in data object because DAAPIDataClass is not dynamic.
                var xdataStr:String = data.common.regionNameStr;
                if (xdataStr.indexOf("\"__xvm\"") > 0)
                {
                    _xdataList = new XvmCommonStatsDataListVO(JSONx.parse(xdataStr));
                    data.common.regionNameStr = _xdataList.regionNameStr;
                }

                // search localized strings for tooltips and calculate total values
                var personal:PersonalDataVO = data.personal;
                for (var i:String in personal.details)
                {
                    var creditsData:Vector.<DetailedStatsItemVO> = personal.creditsData[i] as Vector.<DetailedStatsItemVO>;
                    _xdataList.data[i].creditsNoPremTotalStr = creditsData[creditsData.length - 1]["col1"];
                    _xdataList.data[i].creditsPremTotalStr = creditsData[creditsData.length - 1]["col3"];
                    for each (var detail:Object in personal.details[i])
                    {
                        if (armorNames == null)
                        {
                            armorNames = detail.armorNames;
                        }
                        if (damageAssistedNames == null)
                        {
                            damageAssistedNames = detail.damageAssistedNames;
                        }
                        if (damageDealtNames == null)
                        {
                            damageDealtNames = detail.damageDealtNames;
                        }
                    }
                }

                // original update
                super.update(data);

                // XVM update
                this._data = BattleResultsVO(data);

                detailsMc.validateNow();

                if (!_fieldsInitialized)
                {
                    _fieldsInitialized = true;
                    initializeFields();
                }

                hideQuestsShadows();

                efficiencyHeader.summArmorTF.visible =
                    efficiencyHeader.summAssistTF.visible =
                    efficiencyHeader.summCritsTF.visible =
                    efficiencyHeader.summDamageTF.visible =
                    efficiencyHeader.summKillTF.visible =
                    efficiencyHeader.summSpottedTF.visible = !Config.config.battleResults.showTotals;

                updateValues();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onDropDownIndexChangeHandler(e:ListEvent) : void
        {
            _currentTankIndex = e.index;
            updateValues();
        }

        private function initializeFields():void
        {
            compactQuests();

            if (Config.config.battleResults.showTotals)
            {
                initTotals();
            }

            if (_data.personal.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS)
            {
                if (Config.config.battleResults.showExtendedInfo)
                {
                    initTextFields();
                }

                if (Config.config.battleResults.showCrewExperience)
                {
                    initCrewExperience();
                }
            }
        }

        private function get _xdata():XvmCommonStatsDataVO
        {
            return _xdataList.data[_currentTankIndex];
        }

        private function compactQuests():void
        {
            if (xfw_progressReport)
            {
                xfw_progressReport.linkage = getQualifiedClassName(UI_BR_SubtaskComponent);
            }
        }

        private function hideQuestsShadows():void
        {
            upperShadow.visible = false;
            lowerShadow.visible = false;
        }

        private function initTextFields():void
        {
            // align standard fields
            detailsMc.compareState.noPremTitleLbl.y -= 13;
            detailsMc.compareState.premTitleLbl.y -= 13;
            detailsMc.compareState.creditsTitle.y -= 24;
            detailsMc.compareState.creditsLbl.y -= 24;
            detailsMc.compareState.premCreditsLbl.y -= 24;
            detailsMc.compareState.xpTitleLbl.y -= 24;
            detailsMc.compareState.xpLbl.y -= 24;
            detailsMc.compareState.premXpLbl.y -= 24;

            // add new fields
            shotsTitle = createTextField(FIELD_POS_TITLE, 1);
            shotsCount = createTextField(FIELD_POS_NON_PREM, 1);
            shotsPercent = createTextField(FIELD_POS_PREM, 1);
            damageAssistedTitle = createTextField(FIELD_POS_TITLE, 2);

            damageAssistedValue = createTextField(FIELD_POS_NON_PREM, 2);
            damageAssistedValue.name = BATTLE_EFFICIENCY_TYPES.ASSIST;
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);

            damageValue = createTextField(FIELD_POS_PREM, 2);
            damageValue.name = BATTLE_EFFICIENCY_TYPES.DAMAGE;
            damageValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            damageValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
        }

        private function initTotals():void
        {
            try
            {
                // TODO: Need add 'stun' column
                var x:int = efficiencyTitle.x + 269;
                var y:int = efficiencyTitle.y + 34;
                var w:Number = 33;

                // spotted
                spottedTotalField = addChild(createTotalItem( { x: x, y: y, kind: BATTLE_EFFICIENCY_TYPES.DETECTION })) as EfficiencyIconRenderer;

                // damage assisted (radio/tracks)
                damageAssistedTotalField = addChild(createTotalItem( { x: x + w * 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.ASSIST })) as EfficiencyIconRenderer;

                // armor
                armorTotalField = addChild(createTotalItem( { x: x + w * 2, y: y, kind: BATTLE_EFFICIENCY_TYPES.ARMOR })) as EfficiencyIconRenderer;

                // crits
                critsTotalField = addChild(createTotalItem( { x: x + w * 3, y: y, kind: BATTLE_EFFICIENCY_TYPES.CRITS })) as EfficiencyIconRenderer;

                // piercings
                damageTotalField = addChild(createTotalItem( { x: x + w * 4 + 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.DAMAGE })) as EfficiencyIconRenderer;

                // kills
                killsTotalField = addChild(createTotalItem( { x: x + w * 5 + 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.DESTRUCTION } )) as EfficiencyIconRenderer;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private static const CREW_EXP_OFFSET_X:int = 30;
        private function initCrewExperience():void
        {
            if (detailsMc.compareState.xpTitleLbl)
                detailsMc.compareState.xpTitleLbl.width += 50;
            if (detailsMc.compareState.noPremTitleLbl)
                detailsMc.compareState.noPremTitleLbl.x += CREW_EXP_OFFSET_X;
            if (detailsMc.compareState.creditsLbl)
                detailsMc.compareState.creditsLbl.x += CREW_EXP_OFFSET_X;
            if (detailsMc.compareState.xpLbl)
                detailsMc.compareState.xpLbl.x += CREW_EXP_OFFSET_X;
            if (shotsCount)
                shotsCount.x += CREW_EXP_OFFSET_X;
            if (damageAssistedValue)
                damageAssistedValue.x += CREW_EXP_OFFSET_X;
        }

        private function updateValues():void
        {
            if (Config.config.battleResults.showTotals)
            {
                showTotals();
            }

            if (_data.personal.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS)
            {
                if (Config.config.battleResults.showExtendedInfo)
                {
                    showExtendedInfo();
                }

                if (Config.config.battleResults.showTotalExperience)
                {
                    showTotalExperience();
                }

                if (Config.config.battleResults.showCrewExperience)
                {
                    showCrewExperience();
                }

                if (Config.config.battleResults.showNetIncome)
                {
                    showNetIncome();
                }
            }
        }

        private function showExtendedInfo():void
        {
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(_xdata.hits + "/" + _xdata.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitsRatio:Number = (_xdata.shots <= 0) ? 0 : (_xdata.hits / _xdata.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitsRatio) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(App.utils.locale.integer(_xdata.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(App.utils.locale.integer(_xdata.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function showTotals():void
        {
            var tooltipData:IconEfficiencyTooltipData;

            // spotted
            spottedTotalField.value = _xdata.spotted;
            spottedTotalField.enabled = _xdata.spotted > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.DETECTION] = new IconEfficiencyTooltipData();

            // kills
            killsTotalField.value = _xdata.kills;
            killsTotalField.enabled = _xdata.kills > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.DESTRUCTION] = new IconEfficiencyTooltipData();

            // damage
            damageTotalField.value = _xdata.piercings;
            damageTotalField.enabled = _xdata.piercings > 0;
            tooltipData = new IconEfficiencyTooltipData();
            tooltipData.setBaseValues(
                [App.utils.locale.integer(_xdata.damageDealt), _xdata.piercings],
                damageDealtNames,
                2);
            tooltips[BATTLE_EFFICIENCY_TYPES.DAMAGE] = tooltipData;

            // armor
            armorTotalField.value = _xdata.nonPenetrationsCount;
            armorTotalField.enabled = _xdata.nonPenetrationsCount > 0;
            tooltipData = new IconEfficiencyTooltipData();
            tooltipData.setBaseValues(
                [_xdata.ricochetsCount, _xdata.nonPenetrationsCount, App.utils.locale.integer(_xdata.damageBlockedByArmor)],
                armorNames,
                3);
            tooltips[BATTLE_EFFICIENCY_TYPES.ARMOR] = tooltipData;

            // assist (radio/tracks)
            damageAssistedTotalField.value = _xdata.damageAssistedCount;
            damageAssistedTotalField.enabled = _xdata.damageAssistedCount > 0;
            tooltipData = new IconEfficiencyTooltipData();
            tooltipData.totalAssistedDamage = _xdata.damageAssisted;
            tooltipData.setBaseValues(
                [App.utils.locale.integer(_xdata.damageAssistedRadio), App.utils.locale.integer(_xdata.damageAssistedTrack), App.utils.locale.integer(_xdata.damageAssisted)],
                damageAssistedNames,
                3);
            tooltips[BATTLE_EFFICIENCY_TYPES.ASSIST] = tooltipData;

            // crits
            critsTotalField.value = _xdata.critsCount;
            critsTotalField.enabled = _xdata.critsCount > 0;
            tooltipData = new IconEfficiencyTooltipData();
            //tooltipData.setCritValues(_xdata.criticalDevices, _xdata.destroyedTankmen, _xdata.destroyedDevices, _xdata.critsCount);
            tooltips[BATTLE_EFFICIENCY_TYPES.CRITS] = tooltipData;
        }

        private function showTotalExperience():void
        {
            detailsMc.compareState.xpLbl.htmlText = App.utils.locale.integer(_xdata.origXP) + XP_IMG_TXT;
            detailsMc.compareState.premXpLbl.htmlText = App.utils.locale.integer(_xdata.premXP) + XP_IMG_TXT;
        }

        private function showCrewExperience():void
        {
            detailsMc.compareState.xpTitleLbl.htmlText += " / " + Locale.get("BR_xpCrew");
            detailsMc.compareState.xpLbl.htmlText = detailsMc.compareState.xpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(_xdata.origCrewXP) + " <IMG SRC");
            detailsMc.compareState.premXpLbl.htmlText = detailsMc.compareState.premXpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(_xdata.premCrewXP) + " <IMG SRC");
        }

        private function showNetIncome():void
        {
            detailsMc.compareState.creditsLbl.htmlText = _xdata.creditsNoPremTotalStr;
            detailsMc.compareState.premCreditsLbl.htmlText = _xdata.creditsPremTotalStr;
        }

        // helpers

        private function createTextField(position:String, line:Number):TextField
        {
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = detailsMc.compareState.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = detailsMc.compareState.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = detailsMc.compareState.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.height = detailsMc.compareState.xpTitleLbl.height;
            newTf.alpha = 1;

            newTf.styleSheet = XfwUtils.createTextStyleSheet(CSS_FIELD_CLASS, detailsMc.compareState.xpTitleLbl.defaultTextFormat);
            newTf.mouseEnabled = false;
            newTf.selectable = false;
            TextFieldEx.setNoTranslate(newTf, true);
            newTf.antiAliasType = AntiAliasType.ADVANCED;

            var y_space:Number = detailsMc.compareState.xpTitleLbl.height;
            var y_pos:Number = detailsMc.compareState.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            detailsMc.addChild(newTf);

            return newTf;
        }

        private function createTotalItem(params:Object = null):EfficiencyIconRenderer
        {
            var icon:EfficiencyIconRenderer = App.utils.classFactory.getComponent("EfficiencyIconRendererGUI", EfficiencyIconRenderer, params);
            icon.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            icon.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
            return icon;
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function onRollHandler(e:MouseEvent):void
        {
            //Logger.add("onRollHandler: " + e.type);
            if (e.type == MouseEvent.ROLL_OVER)
            {
                var icon:EfficiencyIconRenderer = e.currentTarget as EfficiencyIconRenderer;
                var kind:String = icon != null ? icon.kind : e.currentTarget.name;
                var tooltip:IconEfficiencyTooltipData = tooltips[kind];
                if (tooltip == null)
                    return;
                tooltip.type = kind;
                tooltip.disabled = icon == null ? false : icon.value <= 0;
                tooltip.isGarage = _data.common.playerVehicles.length > 1;
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM, null, tooltip);
            }
            else
            {
                App.toolTipMgr.hide();
            }
        }
    }
}
