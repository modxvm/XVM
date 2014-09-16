package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.battleResults.*;
    import xvm.hangar.UI.battleResults.*;

    /**
     * @author Pavel Máca
     */
    public class CommonView
    {
        private const FIELD_POS_TITLE:String = "fieldPosTitle";
        private const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private const FIELD_POS_PREM:String = "fieldPosPrem";
        private const CSS_FIELD_CLASS:String = "xvm_bsField";

        private var view:CommonStats;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;

        private var tooltips:Object;

        public static function init(view:CommonStats):void
        {
            var instance:CommonView = new CommonView();
            instance.view = view;

            instance.compactQuests();

            if (Config.config.battleResults.showExtendedInfo)
            {
                instance.hideDetailBtn();
                instance.hideQuestLabel();
                instance.initTextFields();
                instance.setData(view.detailsMc.data);
            }

            if (Config.config.battleResults.showTotals)
                instance.setTotals(view.detailsMc.data);

            if (Config.config.battleResults.showTotalExperience)
                instance.showTotalExperience(view.detailsMc.data);

            if (Config.config.battleResults.showCrewExperience)
                instance.showCrewExperience(view.detailsMc.data);

            if (Config.config.battleResults.showNetIncome)
                instance.showNetIncome(view.detailsMc.data);
        }

        public function CommonView()
        {
            tooltips = { };
        }

        private function compactQuests():void
        {
            view.questList.linkage = getQualifiedClassName(UI_BR_SubtaskComponent);

            // hide shadows
            view.upperShadow.visible = false;
            view.lowerShadow.visible = false;
        }

        private function hideDetailBtn():void
        {
            view.detailsMc.detailedReportBtn.visible = false;
        }

        private function hideQuestLabel():void
        {
            view.detailsMc.progressTF.visible = false;
        }

        private const XP_IMG_TXT:String = " <IMG SRC='img://gui/maps/icons/library/XpIcon-1.png' width='16' height='16' vspace='-2'/>";
        private function showTotalExperience(data:Object):void
        {
            var origXP:int = data.xp / (data.isPremium ? (data.premiumXPFactor10 / 10.0) : 1);
            var premXP:int = data.xp * (data.isPremium ? 1 : (data.premiumXPFactor10 / 10.0));
            view.detailsMc.xpLbl.htmlText = App.utils.locale.integer(origXP) + XP_IMG_TXT;
            view.detailsMc.premXpLbl.htmlText = App.utils.locale.integer(premXP) + XP_IMG_TXT;
       }

        private function showCrewExperience(data:Object):void
        {
            var origCrewXP:int = data.tmenXP / (data.isPremium ? (data.premiumXPFactor10 / 10.0) : 1);
            var premCrewXP:int = data.tmenXP * (data.isPremium ? 1 : (data.premiumXPFactor10 / 10.0));
            view.detailsMc.xpTitleLbl.htmlText += " / " + Locale.get("BR_xpCrew");
            view.detailsMc.xpLbl.htmlText = view.detailsMc.xpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(origCrewXP) + " <IMG SRC");
            view.detailsMc.premXpLbl.htmlText = view.detailsMc.premXpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(premCrewXP) + " <IMG SRC");
       }

        private function showNetIncome(data:Object):void
        {
            view.detailsMc.creditsLbl.htmlText = data.creditsNoPremTotalStr;
            view.detailsMc.premCreditsLbl.htmlText = data.creditsPremTotalStr;
        }

        private function initTextFields():void
        {
            shotsTitle = this.createTextField(FIELD_POS_TITLE, 1);

            shotsCount = this.createTextField(FIELD_POS_NON_PREM, 1);

            shotsPercent = this.createTextField(FIELD_POS_PREM, 1);

            damageAssistedTitle = this.createTextField(FIELD_POS_TITLE, 2);

            damageAssistedValue = this.createTextField(FIELD_POS_NON_PREM, 2);
            damageAssistedValue.name = EfficiencyIconRenderer.ASSIST;
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OVER, onOver);
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OUT, onOut);

            damageValue = this.createTextField(FIELD_POS_PREM, 2);
            damageValue.name = EfficiencyIconRenderer.DAMAGE;
            damageValue.addEventListener(MouseEvent.ROLL_OVER, onOver);
            damageValue.addEventListener(MouseEvent.ROLL_OUT, onOut);
        }

        private function createTextField(position:String, line:Number):TextField
        {
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = view.detailsMc.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = view.detailsMc.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = view.detailsMc.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.height = view.detailsMc.xpTitleLbl.height;
            newTf.alpha = 1;

            newTf.styleSheet = Utils.createTextStyleSheet(CSS_FIELD_CLASS, view.detailsMc.xpTitleLbl.defaultTextFormat);
            newTf.selectable = false;

            var y_space:Number = view.detailsMc.xpTitleLbl.height;
            var y_pos:Number = view.detailsMc.resTitleLbl && view.detailsMc.resTitleLbl.visible ? view.detailsMc.resTitleLbl.y : view.detailsMc.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            view.detailsMc.addChild(newTf);

            return newTf;
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function setData(data:Object):void
        {
            //Logger.addObject(data);
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(data.directHits + "/" + data.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitPercent:Number = (data.shots <= 0) ? 0 : (data.directHits / data.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitPercent) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(App.utils.locale.integer(data.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(App.utils.locale.integer(data.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function setTotals(data:Object):void
        {
            try
            {
                //Logger.addObject(data, 3);
                var x:int = view.effencyTitle.x + 294;
                var y:int = view.effencyTitle.y;
                var w:Number = 32;

                // spotted
                //view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.SPOTTED, x: x, y: y1, width: w, height:h,
                //    htmlText: getTotalSpottedStr(data) } ));
                view.addChild(createTotalItem( { x: x, y: y, kind: EfficiencyIconRenderer.SPOTTED,
                    value: getTotalSpotted(data),
                    tooltip: { } } ));

                // damage assisted (radio/tracks)
                view.addChild(createTotalItem( { x: x + w * 1, y: y, kind: EfficiencyIconRenderer.ASSIST,
                    value: getTotalAssistCount(data),
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        value: data.damageAssisted,
                        values: data.damageAssistedRadio + "<br/>" + data.damageAssistedTrack,
                        discript: data.details[0].damageAssistedNames // WG programmer is asshole!
                    } } ));

                // crits
                view.addChild(createTotalItem( { x: x + w * 2, y: y, kind: EfficiencyIconRenderer.CRITS,
                    value: getTotalCritsCount(data),
                    tooltip: { value: getTotalCritsCount(data) } } ));

                // piercings
                view.addChild(createTotalItem( { x: x + w * 3 - 1, y: y, kind: EfficiencyIconRenderer.DAMAGE,
                    value: data.piercings,
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        values: data.damageDealt + "<br/>" + data.piercings,
                        discript: data.details[0].damageDealtNames
                    } } ));

                // kills
                view.addChild(createTotalItem( { x: x + w * 4 - 2, y: y, kind: EfficiencyIconRenderer.KILL,
                    value: data.kills,
                    tooltip: { value: -1 } } ));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function calcDetails(data:Object, field:String):Number
        {
            var n:int = 0;
            for each (var obj:Object in data.details)
            {
                var v:* = obj[field];
                if (v is String)
                    n += int(parseInt(v));
                else if (v is Boolean)
                    n += v == true ? 1 : 0
                else
                    n += int(v);
            }
            return n;
        }

        private function getTotalSpotted(data:Object):Number
        {
            return calcDetails(data, "spotted");
        }

        private function getTotalAssistCount(data:Object):Number
        {
            var n:int = 0;
            for each (var obj:Object in data.details)
            {
                if (obj["damageAssistedRadio"] != 0 || obj["damageAssistedTrack"] != 0)
                    n++;
            }
            return n;
        }

        private function getTotalCritsCount(data:Object = null):Number
        {
            return calcDetails(data, "critsCount");
        }

        private function createTotalItem(params:Object = null):EfficiencyIconRenderer
        {
            if (params != null)
            {
                if (params.hasOwnProperty("tooltip"))
                {
                    tooltips[params.kind] = params.tooltip;
                    delete params.tooltip;
                }
            }

            var icon:EfficiencyIconRenderer = App.utils.classFactory.getComponent("EfficiencyIconRendererGUI", EfficiencyIconRenderer, params);
            icon.enabled = params.value > 0;
            icon.addEventListener(MouseEvent.ROLL_OVER, onOver);
            icon.addEventListener(MouseEvent.ROLL_OUT, onOut);

            return icon;
        }

        private function onOver(e:MouseEvent):void
        {
            var icon:EfficiencyIconRenderer = e.currentTarget as EfficiencyIconRenderer;
            var kind:String = icon != null ? icon.kind : e.currentTarget.name;
            var tooltip:* = tooltips[kind];
            if (tooltip == null)
                return;
            var data:Object = merge(tooltip, {
                "type":kind,
                "disabled":icon == null ? false : icon.value <= 0
            });
            App.toolTipMgr.showSpecial(Tooltips.EFFICIENCY_PARAM, null, kind, data);
        }

        private function onOut(m:MouseEvent):void
        {
            App.toolTipMgr.hide();
        }

        private function merge(obj1:Object, obj2:Object):Object
        {
            var result:Object = new Object();
            for (var param:String in obj1)
                result[param] = obj1[param];
            for (param in obj2)
                result[param] = obj2[param];
            return result;
        }
    }

}

/*
view.detailsMc.data: {
  "freeXP": 36,
  "achievementsLeft": [
    {
      "isEpic": false,
      "rare": false,
      "description": "markOfMastery_descr",
      "title": "Знак классности «3 степень»",
      "customData": "",
      "rareIconId": null,
      "block": "achievements",
      "icon": "../maps/icons/achievement/markOfMastery1.png",
      "specialIcon": null,
      "inactive": false,
      "localizedValue": "1",
      "rank": 1,
      "unic": false,
      "type": "markOfMastery"
    }
  ],
  "damageAssistedRadio": 217,
  "creditsPremStr": "39 408 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "sniperDamageDealt": 2571,
  "droppedCapturePoints": 0,
  "damageRating": 44.1625,
  "creditsData": [
    {
      "col3": "39 408 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Начислено за бой\n",
      "col1": "26 272 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Начислено за бой\n",
      "col2": "\n"
    },
    {
      "col3": "5 184 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "За достойное сопротивление\n",
      "col1": "3 456 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "За достойное сопротивление\n",
      "col2": "\n"
    },
    {
      "col3": "\n",
      "col4": "\n",
      "label": "\n",
      "col1": "\n",
      "lineType": null,
      "labelStripped": "\n",
      "col2": "\n"
    },
    {
      "col3": "0 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Штраф за урон союзникам\n",
      "col1": "<font color=\"#42433f\">0</font> <IMG SRC=\"img://gui/maps/icons/library/CreditsIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Штраф за урон союзникам\n",
      "col2": "\n"
    },
    {
      "col3": "0 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Компенсация за урон от союзников\n",
      "col1": "<font color=\"#42433f\">0</font> <IMG SRC=\"img://gui/maps/icons/library/CreditsIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Компенсация за урон от союзников\n",
      "col2": "\n"
    },
    {
      "col3": "\n",
      "col4": "\n",
      "label": "\n",
      "col1": "\n",
      "lineType": null,
      "labelStripped": "\n",
      "col2": "\n"
    },
    {
      "col3": "44 592 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Итого за бой:\n",
      "col1": "29 728 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Итого за бой:\n",
      "col2": "\n"
    },
    {
      "col3": "\n",
      "col4": "\n",
      "label": "\n",
      "col1": "\n",
      "lineType": null,
      "labelStripped": "\n",
      "col2": "\n"
    },
    {
      "col3": "<FONT color=\"#bc0000\">-11 000</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Автоматический ремонт техники\n",
      "col1": "<FONT color=\"#bc0000\">-11 000</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Автоматический ремонт техники\n",
      "col2": "\n"
    },
    {
      "col3": "<FONT color=\"#bc0000\">-9 630</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Автопополнение боекомплекта\n",
      "col1": "<FONT color=\"#bc0000\">-9 630</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Автопополнение боекомплекта\n",
      "col2": "\n"
    },
    {
      "col3": "0 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "<font color=\"#fbc062\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "label": "Автопополнение снаряжения\n",
      "col1": "<font color=\"#42433f\">0</font> <IMG SRC=\"img://gui/maps/icons/library/CreditsIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "wideLine",
      "labelStripped": "Автопополнение снаряжения\n",
      "col2": "<font color=\"#4d3d21\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>"
    },
    {
      "col3": "\n",
      "col4": "\n",
      "label": "\n",
      "col1": "\n",
      "lineType": null,
      "labelStripped": "\n",
      "col2": "\n"
    },
    {
      "col3": "23 962 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "<font color=\"#fbc062\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "label": "<font color=\"#d0ceb8\">Итого:</font>\n",
      "col1": "9 098 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "wideLine",
      "labelStripped": "Итого:\n",
      "col2": "<font color=\"#4d3d21\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>"
    }
  ],
  "xp": 744,
  "questsProgress": {
    "RU_01-01_Sep_2014_q08": [
      null,
      "[object Object]",
      "[object Object]"
    ]
  },
  "potentialDamageReceived": 1440,
  "xpNoPremStr": "466 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
  "directTeamHits": 0,
  "explosionHits": 0,
  "eventCredits": 0,
  "damageDealt": 3468,
  "autoEquipCost": [
    0,
    0
  ],
  "isPrematureLeave": false,
  "credits": 29728,
  "igrXPFactor10": 10,
  "marksOnGun": 0,
  "xpData": [
    {
      "col3": "699 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "34 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "Начислено за бой\n",
      "col1": "466 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Начислено за бой\n",
      "col2": "23 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
    },
    {
      "col3": "417 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "19 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "За достойное сопротивление\n",
      "col1": "278 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "За достойное сопротивление\n",
      "col2": "13 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
    },
    {
      "col3": "0 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "\n",
      "label": "Штраф за урон союзникам\n",
      "col1": "<font color=\"#4c4b45\">0</font> <IMG SRC=\"img://gui/maps/icons/library/XpIconInactive-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "normalLine",
      "labelStripped": "Штраф за урон союзникам\n",
      "col2": "\n"
    },
    {
      "col3": "\n",
      "col4": "\n",
      "label": "\n",
      "col1": "\n",
      "lineType": null,
      "labelStripped": "\n",
      "col2": "\n"
    },
    {
      "col3": "1 116 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "54 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "<font color=\"#d0ceb8\">Итого:</font>\n",
      "col1": "744 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Итого:\n",
      "col2": "36 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
    }
  ],
  "creditsPenalty": 0,
  "damageReceived": 1100,
  "tdamageDealt": 0,
  "orderXP": 0,
  "achievementFreeXP": 13,
  "creditsPremTotalStr": "23 962 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "dossierType": null,
  "damaged": 5,
  "premiumCreditsFactor10": 15,
  "typeCompDescr": 16657,
  "aogasFactor10": 10,
  "creditsContributionOut": 0,
  "kills": 2,
  "vehTypeLockTime": 0,
  "premiumXPFactor10": 15,
  "piercings": 8,
  "autoRepairCost": 11000,
  "achievementCredits": 3456,
  "tmenXP": 744,
  "fortResource": null,
  "directHitsReceived": 4,
  "dossierCompDescr": null,
  "hits": "8/8",
  "tkills": 0,
  "creditsNoPremStr": "26 272 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "histAmmoCost": [
    0,
    0
  ],
  "details": [
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "vlad7729 [GB11R]",
      "criticalDevices": "<IMG SRC=\"img://gui/maps/icons/library/crits/ammoBayCriticalSmall.png\" width=\"16\" height=\"16\" vspace=\"-5\"/><font color=\"#7b7969\">Боеукладка</font><br/><IMG SRC=\"img://gui/maps/icons/library/crits/fuelTankCriticalSmall.png\" width=\"16\" height=\"16\" vspace=\"-5\"/><font color=\"#7b7969\">Топливный бак</font>",
      "isAlly": false,
      "directHits": 3,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 1465,
      "critsCount": "2",
      "crits": 6,
      "fire": 0,
      "damageDealtVals": "1 465<br/>3",
      "damageAssisted": 0,
      "balanceWeight": 48.00000190734863,
      "killed": true,
      "spotted": 1,
      "damageAssistedVals": "0<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 5137,
      "vehicleId": 18982890,
      "playerName": "vlad7729",
      "damageAssistedRadio": 0,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "GB11R",
      "isFake": false,
      "vehicleName": "Tiger II",
      "piercings": 3,
      "deathReason": -1,
      "tankIcon": "../maps/icons/vehicle/small/germany-PzVIB_Tiger_II.png"
    },
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "Evgeniy68",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 1,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 415,
      "critsCount": "0",
      "crits": 0,
      "fire": 0,
      "damageDealtVals": "415<br/>1",
      "damageAssisted": 0,
      "balanceWeight": 48.00000190734863,
      "killed": false,
      "spotted": 1,
      "damageAssistedVals": "0<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 9217,
      "vehicleId": 18982891,
      "playerName": "Evgeniy68",
      "damageAssistedRadio": 0,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "",
      "isFake": false,
      "vehicleName": "ИС-6",
      "piercings": 1,
      "deathReason": -1,
      "tankIcon": "../maps/icons/vehicle/small/ussr-Object252.png"
    },
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "SHBB74 [15234]",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 1,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 440,
      "critsCount": "0",
      "crits": 0,
      "fire": 0,
      "damageDealtVals": "440<br/>1",
      "damageAssisted": 0,
      "balanceWeight": 48,
      "killed": true,
      "spotted": 0,
      "damageAssistedVals": "0<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 13345,
      "vehicleId": 18982906,
      "playerName": "SHBB74",
      "damageAssistedRadio": 0,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "15234",
      "isFake": false,
      "vehicleName": "T26E4",
      "piercings": 1,
      "deathReason": -1,
      "tankIcon": "../maps/icons/vehicle/small/usa-T26_E4_SuperPershing.png"
    },
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "rosia1947",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 2,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 666,
      "critsCount": "0",
      "crits": 0,
      "fire": 0,
      "damageDealtVals": "666<br/>2",
      "damageAssisted": 217,
      "balanceWeight": 27,
      "killed": true,
      "spotted": 1,
      "damageAssistedVals": "217<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 6657,
      "vehicleId": 18982901,
      "playerName": "rosia1947",
      "damageAssistedRadio": 217,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "",
      "isFake": false,
      "vehicleName": "Т-43",
      "piercings": 2,
      "deathReason": 0,
      "tankIcon": "../maps/icons/vehicle/small/ussr-T-43.png"
    },
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "t1tanum",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 1,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "<IMG SRC=\"img://gui/maps/icons/library/crits/commanderDestroyedSmall.png\" width=\"16\" height=\"16\" vspace=\"-5\"/><font color=\"#7b7969\">Командир</font>",
      "explosionHits": 0,
      "damageDealt": 482,
      "critsCount": "1",
      "crits": 16777216,
      "fire": 0,
      "damageDealtVals": "482<br/>1",
      "damageAssisted": 0,
      "balanceWeight": 18,
      "killed": true,
      "spotted": 0,
      "damageAssistedVals": "0<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 2561,
      "vehicleId": 18982888,
      "playerName": "t1tanum",
      "damageAssistedRadio": 0,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "",
      "isFake": false,
      "vehicleName": "Т-34-85",
      "piercings": 1,
      "deathReason": 0,
      "tankIcon": "../maps/icons/vehicle/small/ussr-T-34-85.png"
    }
  ],
  "capturePointsVal": "<FONT color=\"#414037\">0</FONT><FONT color=\"#414037\">/</FONT><FONT color=\"#414037\">0</FONT>",
  "eventXP": 0,
  "autoLoadCost": [
    9630,
    0
  ],
  "noDamageDirectHitsReceived": 0,
  "originalFreeXP": 36,
  "orderFortResource": 0,
  "damageAssistedTrack": 0,
  "directHits": 8,
  "achievements": [
    228,
    227
  ],
  "orderTMenXP": 0,
  "piercingsReceived": 4,
  "serviceProviderID": 0,
  "lifeTime": 232,
  "isTeamKiller": false,
  "dailyXPFactor10": 10,
  "team": 1,
  "repair": 11000,
  "xpStr": "466",
  "shots": 9,
  "orderFreeXP": 0,
  "capturePoints": 0,
  "xpPenalty": 0,
  "damageAssisted": 217,
  "creditsToDraw": 0,
  "originalCredits": 29728,
  "xpTitleStr": "Опыт",
  "isPremium": false,
  "gold": 0,
  "creditsNoPremTotalStr": "9 098 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "spotted": 3,
  "dossierPopUps": [
    [
      227,
      12
    ],
    [
      228,
      34
    ]
  ],
  "achievementXP": 278,
  "mileage": "0,57",
  "movingAvgDamage": 1461,
  "damagedKilled": "5/2",
  "creditsStr": "26 272",
  "accountDBID": 4516862,
  "eventGold": 0,
  "achievementsRight": [
    {
      "isEpic": false,
      "rare": false,
      "description": "Нанести наибольшее количество урона за бой с дистанции не менее 300 метров.",
      "title": "«Танкист-снайпер»",
      "customData": "",
      "rareIconId": null,
      "block": "achievements",
      "icon": "../maps/icons/achievement/sniper2.png",
      "specialIcon": null,
      "inactive": false,
      "localizedValue": "12",
      "rank": 12,
      "unic": true,
      "type": "sniper2"
    },
    {
      "isEpic": false,
      "rare": false,
      "description": "Нанести наибольшее количество урона за бой.",
      "title": "«Основной калибр»",
      "customData": "",
      "rareIconId": null,
      "block": "achievements",
      "icon": "../maps/icons/achievement/mainGun.png",
      "specialIcon": null,
      "inactive": false,
      "localizedValue": "34",
      "rank": 34,
      "unic": true,
      "type": "mainGun"
    }
  ],
  "xpPremStr": "699 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
  "eventTMenXP": 0,
  "originalXP": 744,
  "teamHitsDamage": "<FONT color=\"#414037\">0/0</FONT>",
  "orderCredits": 0,
  "eventFreeXP": 0,
  "statValues": [
    {
      "label": "Произведено выстрелов",
      "value": "9"
    },
    {
      "label": "\tпрямых попаданий/пробитий",
      "value": "8/8"
    },
    {
      "label": "\tосколочно-фугасных повреждений",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Нанесено урона",
      "value": "3 468"
    },
    {
      "label": "\tс дистанции свыше 300 м",
      "value": "2 571"
    },
    {
      "label": "Получено попаданий",
      "value": "4"
    },
    {
      "label": "\tпробитий",
      "value": "4"
    },
    {
      "label": "\tне нанёсших урон",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Получено попаданий осколками",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Урон, заблокированный бронёй",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Урон союзникам (уничтожено/повреждений)",
      "value": "<FONT color=\"#414037\">0/0</FONT>"
    },
    {
      "label": "Обнаружено машин противника",
      "value": "3"
    },
    {
      "label": "Повреждено/уничтожено машин противника",
      "value": "5/2"
    },
    {
      "label": "Урон, нанесённый с вашей помощью",
      "value": "217"
    },
    {
      "label": "Очки захвата/защиты базы",
      "value": "<FONT color=\"#414037\">0</FONT><FONT color=\"#414037\">/</FONT><FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Пройдено километров",
      "value": "0,57"
    }
  ],
  "health": 0,
  "creditsContributionIn": 0,
  "explosionHitsReceived": 0,
  "markOfMastery": 1,
  "deathReason": 0,
  "damageBlockedByArmor": 0,
  "killerID": 18982909
}
*/
