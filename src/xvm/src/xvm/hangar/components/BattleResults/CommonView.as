package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.types.veh.*;
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

            view.detailsMc.xpTitleLbl.width = 300;

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

        //

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
            var origXP:int = Utils.forceInt(data.xpData[data.xpData.length - 1]["col1"].split('<')[0]);
            var premXP:int = Utils.forceInt(data.xpData[data.xpData.length - 1]["col3"].split('<')[0]);
            view.detailsMc.xpLbl.htmlText = App.utils.locale.integer(origXP) + XP_IMG_TXT;
            view.detailsMc.premXpLbl.htmlText = App.utils.locale.integer(premXP) + XP_IMG_TXT;
       }

        private function showCrewExperience(data:Object):void
        {
            var origCrewXP:int = Utils.forceInt(data.xpData[data.xpData.length - 1]["col1"].split('<')[0]);
            var premCrewXP:int = Utils.forceInt(data.xpData[data.xpData.length - 1]["col3"].split('<')[0]);

            var vdata:VehicleData = VehicleInfo.get(data.typeCompDescr);
            if (vdata != null && vdata.premium)
            {
                origCrewXP *= 1.5;
                premCrewXP *= 1.5;
            }

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

            var hitsRatio:Number = (data.shots <= 0) ? 0 : (data.directHits / data.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitsRatio) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

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
  "sniperDamageDealt": 0,
  "droppedCapturePoints": 0,
  "creditsData": [
    {
      "col3": "5 371 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Начислено за бой\n",
      "col1": "3 581 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Начислено за бой\n",
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
      "col3": "<FONT color=\"#bc0000\">-325</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Автоматический ремонт техники\n",
      "col1": "<FONT color=\"#bc0000\">-325</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "normalLine",
      "labelStripped": "Автоматический ремонт техники\n",
      "col2": "\n"
    },
    {
      "col3": "<FONT color=\"#bc0000\">-75</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "\n",
      "label": "Автопополнение боекомплекта\n",
      "col1": "<FONT color=\"#bc0000\">-75</FONT> <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
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
      "col3": "4 971 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "col4": "<font color=\"#fbc062\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "label": "<font color=\"#d0ceb8\">Итого:</font>\n",
      "col1": "3 181 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
      "lineType": "wideLine",
      "labelStripped": "Итого:\n",
      "col2": "<font color=\"#4d3d21\">0</font> <IMG SRC=\"img://gui/maps/icons/library/GoldIconInactive-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>"
    }
  ],
  "questsProgress": {

  },
  "xp": 436,
  "potentialDamageReceived": 168,
  "directTeamHits": 0,
  "xpNoPremStr": "354 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
  "eventCredits": 0,
  "credits": 3581,
  "fortBuilding": null,
  "xpData": [
    {
      "col3": "177 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "7 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "Начислено за бой\n",
      "col1": "118 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Начислено за бой\n",
      "col2": "5 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
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
      "col3": "x3 <IMG SRC=\"img://gui/maps/icons/library/multyXp.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "x3 <IMG SRC=\"img://gui/maps/icons/library/multyXp.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "Награда за первую победу в день\n",
      "col1": "x3 <IMG SRC=\"img://gui/maps/icons/library/multyXp.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Награда за первую победу в день\n",
      "col2": "x3 <IMG SRC=\"img://gui/maps/icons/library/multyXp.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
    },
    {
      "col3": "82 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "0 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "Награда за выполнение боевых задач\n",
      "col1": "82 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Награда за выполнение боевых задач\n",
      "col2": "<font color=\"#34322a\">0</font> <IMG SRC=\"img://gui/maps/icons/library/FreeXpIconInactive-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
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
      "col3": "613 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "col4": "21 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "label": "<font color=\"#d0ceb8\">Итого:</font>\n",
      "col1": "436 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
      "lineType": "wideLine",
      "labelStripped": "Итого:\n",
      "col2": "15 <IMG SRC=\"img://gui/maps/icons/library/FreeXpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>"
    }
  ],
  "achievementFreeXP": 0,
  "igrXPFactor10": 10,
  "marksOnGun": 0,
  "damageReceived": 140,
  "tdamageDealt": 0,
  "dossierType": null,
  "premiumCreditsFactor10": 15,
  "typeCompDescr": 54529,
  "aogasFactor10": 10,
  "kills": 0,
  "piercings": 1,
  "autoRepairCost": 325,
  "fortResource": null,
  "directHitsReceived": 7,
  "autoLoadCost": [
    75,
    0
  ],
  "orderTMenXP": 0,
  "serviceProviderID": 0,
  "shots": 3,
  "lifeTime": 74,
  "xpStr": "354",
  "team": 2,
  "repair": 325,
  "creditsToDraw": 0,
  "isPremium": false,
  "creditsNoPremTotalStr": "3 181 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "achievementsLeft": [

  ],
  "mileage": "0,45",
  "creditsStr": "3 581",
  "statValues": [
    {
      "label": "Произведено выстрелов",
      "value": "3"
    },
    {
      "label": "\tпрямых попаданий/пробитий",
      "value": "1/1"
    },
    {
      "label": "\tосколочно-фугасных повреждений",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Нанесено урона",
      "value": "47"
    },
    {
      "label": "\tс дистанции свыше 300 м",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Получено попаданий",
      "value": "7"
    },
    {
      "label": "\tпробитий",
      "value": "6"
    },
    {
      "label": "\tне нанёсших урон",
      "value": "1"
    },
    {
      "label": "Получено попаданий осколками",
      "value": "<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Урон, заблокированный бронёй",
      "value": "12"
    },
    {
      "label": "Урон союзникам (уничтожено/повреждений)",
      "value": "<FONT color=\"#414037\">0/0</FONT>"
    },
    {
      "label": "Обнаружено машин противника",
      "value": "2"
    },
    {
      "label": "Повреждено/уничтожено машин противника",
      "value": "1/<FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Урон, нанесённый с вашей помощью",
      "value": "3"
    },
    {
      "label": "Очки захвата/защиты базы",
      "value": "<FONT color=\"#414037\">0</FONT><FONT color=\"#414037\">/</FONT><FONT color=\"#414037\">0</FONT>"
    },
    {
      "label": "Пройдено километров",
      "value": "0,45"
    }
  ],
  "accountDBID": 2178413,
  "achievementsRight": [

  ],
  "xpPremStr": "531 <IMG SRC=\"img://gui/maps/icons/library/XpIcon-1.png\" width=\"16\" height=\"16\" vspace=\"-2\"/>",
  "damageAssistedRadio": 3,
  "originalXP": 118,
  "orderCredits": 0,
  "explosionHitsReceived": 0,
  "freeXP": 15,
  "creditsPremStr": "5 371 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "damageRating": 0,
  "damageDealt": 47,
  "explosionHits": 0,
  "isPrematureLeave": false,
  "autoEquipCost": [
    0,
    0
  ],
  "creditsPenalty": 0,
  "orderXP": 0,
  "creditsPremTotalStr": "4 971 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "damaged": 1,
  "fairplayViolations": [
    0,
    0
  ],
  "creditsContributionOut": 0,
  "vehTypeLockTime": 0,
  "premiumXPFactor10": 15,
  "tdestroyedModules": false,
  "achievementCredits": 0,
  "tmenXP": 436,
  "originalFreeXP": 5,
  "eventXP": 82,
  "dossierCompDescr": null,
  "hits": "1/1",
  "tkills": 0,
  "capturePointsVal": "<FONT color=\"#414037\">0</FONT><FONT color=\"#414037\">/</FONT><FONT color=\"#414037\">0</FONT>",
  "histAmmoCost": [
    0,
    0
  ],
  "details": [
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "777Gastello777",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 0,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 0,
      "critsCount": "0",
      "crits": 0,
      "fire": 0,
      "damageDealtVals": "0<br/>0",
      "damageAssisted": 3,
      "balanceWeight": 3,
      "killed": true,
      "spotted": 1,
      "damageAssistedVals": "3<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 6177,
      "vehicleId": 14646451,
      "playerName": "777Gastello777",
      "damageAssistedRadio": 3,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "",
      "isFake": false,
      "vehicleName": "T18",
      "piercings": 0,
      "deathReason": -1,
      "tankIcon": "../maps/icons/vehicle/small/usa-T18.png"
    },
    {
      "damageDealtNames": "Суммарный урон (ед.)<br/>Всего пробитий",
      "playerFullName": "fedya199974",
      "criticalDevices": "",
      "isAlly": false,
      "directHits": 1,
      "damageAssistedTrack": 0,
      "destroyedTankmen": "",
      "explosionHits": 0,
      "damageDealt": 47,
      "critsCount": "0",
      "crits": 0,
      "fire": 0,
      "damageDealtVals": "47<br/>1",
      "damageAssisted": 0,
      "balanceWeight": 2,
      "killed": false,
      "spotted": 1,
      "damageAssistedVals": "0<br/>0",
      "destroyedDevices": "",
      "playerRegion": null,
      "typeCompDescr": 545,
      "vehicleId": 14646434,
      "playerName": "fedya199974",
      "damageAssistedRadio": 0,
      "damageAssistedNames": "По вашим разведданным (ед.)<br/>После попадания, сбившего гусеницу (ед.)",
      "playerClan": "",
      "isFake": false,
      "vehicleName": "T1",
      "piercings": 1,
      "deathReason": -1,
      "tankIcon": "../maps/icons/vehicle/small/usa-T1_Cunningham.png"
    }
  ],
  "creditsNoPremStr": "3 581 <IMG SRC=\"img://gui/maps/icons/library/CreditsIcon-2.png\" width=\"16\" height=\"16\" vspace=\"-3\"/>",
  "noDamageDirectHitsReceived": 1,
  "orderFortResource": 0,
  "damageAssistedTrack": 0,
  "directHits": 1,
  "achievements": [

  ],
  "piercingsReceived": 6,
  "xpPenalty": 0,
  "orderFreeXP": 0,
  "dailyXPFactor10": 30,
  "isTeamKiller": false,
  "xpTitleStr": "Опыт (х3 за первую победу в день)",
  "capturePoints": 0,
  "damageAssisted": 3,
  "originalCredits": 3581,
  "gold": 0,
  "spotted": 2,
  "eventGold": 0,
  "movingAvgDamage": 0,
  "achievementXP": 0,
  "dossierPopUps": [
    [
      218,
      47
    ]
  ],
  "damagedKilled": "1/<FONT color=\"#414037\">0</FONT>",
  "eventTMenXP": 0,
  "eventFreeXP": 0,
  "teamHitsDamage": "<FONT color=\"#414037\">0/0</FONT>",
  "health": 0,
  "creditsContributionIn": 0,
  "markOfMastery": 0,
  "killerID": 14646434,
  "damageBlockedByArmor": 12,
  "deathReason": 0
}
*/
