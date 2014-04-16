/******************************************************************************
      Скрипт для разбивки конфига XVM.xvmconf под формат XVM-4.0.0+
      Automatic conversion XVM.xvmconf to the new format XVM-4.0.0+

      Инструкции (instructions):
      http://www.koreanrandom.com/forum/topic/4643-
******************************************************************************/

// версия скрипта
var script_version = "9.7";

// массив названий секций
var sections = [    // порядок секций лучше не менять
                    '"battle"',
                    '"markers"',
                    '"iconset"',
                    '"login"',
                    '"vehicleNames"',
                    '"turretMarkers"',
                    '"texts"',
                    '"statisticForm"',
                    '"playersPanel"',
                    '"finalStatistic"',
                    '"battleLoading"',
                    '"captureBar"',
                    '"hitLog"',
                    '"hotkeys"',
                    '"fragCorrelation"',
                    '"expertPanel"',
                    '"hangar"',
                    '"userInfo"',
                    '"minimap"',
                    '"squad"',
                    '"colors"',
                    '"alpha"',
                    '"rating"'
                ];
// массив комментариев для секций
var sectionsComments = {
    markers: {
        ru: '  // РњР°СЂРєРµСЂС‹ РЅР°Рґ С‚Р°РЅРєР°РјРё.',
        en: '  // Over-target markers.'
    },
    login: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ СЌРєСЂР°РЅР° Р»РѕРіРёРЅР°.',
        en: '  // Parameters for login screen.'
    },
    iconset: {
        ru: '  // РќР°Р±РѕСЂС‹ РёРєРѕРЅРѕРє.',
        en: '  // Icon sets.'
    },
    vehicleNames: {
        ru: '  // Р—Р°РјРµРЅР° РЅР°Р·РІР°РЅРёР№ С‚Р°РЅРєРѕРІ.',
        en: '  // Vehicle names mapping.'
    },
    turretMarkers: {
        ru: '  // РћС‚РѕР±СЂР°Р¶Р°РµРјС‹Рµ СЃС‚СЂРѕРєРё {{turret}} РјР°СЂРєРµСЂР°.',
        en: '  // {{turret}} marker display strings.'
    },
    texts: {
        ru: '  // РўРµРєСЃС‚РѕРІС‹Рµ РїРѕРґСЃС‚Р°РЅРѕРІРєРё.',
        en: '  // Text substitutions.'
    },
    statisticForm: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ РѕРєРЅР° СЃС‚Р°С‚РёСЃС‚РёРєРё РїРѕ РєР»Р°РІРёС€Рµ Tab.',
        en: '  // Parameters of the Battle Statistics form.'
    },
    playersPanel: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ РїР°РЅРµР»РµР№ РёРіСЂРѕРєРѕРІ ("СѓС€РµР№").',
        en: '  // Parameters of the Players Panels ("ears").'
    },
    finalStatistic: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ РѕРєРЅР° РїРѕСЃР»РµР±РѕРµРІРѕР№ СЃС‚Р°С‚РёСЃС‚РёРєРё.',
        en: '  // Parameters of the After Battle Screen.'
    },
    battleLoading: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ СЌРєСЂР°РЅР° Р·Р°РіСЂСѓР·РєРё Р±РѕСЏ.',
        en: '  // Parameters of the Battle Loading screen.'
    },
    captureBar: {
        ru: '  // РџРѕР»РѕСЃР° Р·Р°С…РІР°С‚Р°.',
        en: '  // Capture bar.'
    },
    hitLog: {
        ru: '  // Р›РѕРі РїРѕРїР°РґР°РЅРёР№ (СЃС‡РµС‚С‡РёРє СЃРІРѕРёС… РїРѕРїР°РґР°РЅРёР№).',
        en: '  // Hit log (my hits calculator).'
    },
    hotkeys: {
        ru: '  // РЎРїРµС†РёР°Р»СЊРЅС‹Рµ РіРѕСЂСЏС‡РёРµ РєР»Р°РІРёС€Рё XVM.',
        en: '  // Special XVM hotkeys.'
    },
    battle: {
        ru: '  // РћР±С‰РёРµ РїР°СЂР°РјРµС‚СЂС‹ Р±РѕРµРІРѕРіРѕ РёРЅС‚РµСЂС„РµР№СЃР°.',
        en: '  // General parameters for the battle interface.'
    },
    fragCorrelation: {
        ru: '  // РџР°РЅРµР»СЊ СЃС‡С‘С‚Р° РІ Р±РѕСЋ.',
        en: '  // Frag counter panel.'
    },
    expertPanel: {
        ru: '  // Р’РЅСѓС‚СЂРёРёРіСЂРѕРІР°СЏ РїР°РЅРµР»СЊ РєСЂРёС‚РѕРІ РѕС‚ РЅР°РІС‹РєР° "СЌРєСЃРїРµСЂС‚".',
        en: '  // Ingame crits panel by "expert" skill.'
    },
    hangar: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ Р°РЅРіР°СЂР°.',
        en: '  // Parameters for hangar.'
    },
    userInfo: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ РѕРєРЅР° РґРѕСЃС‚РёР¶РµРЅРёР№.',
        en: '  // Parameters for userinfo window.'
    },
    minimap: {
        ru: '  // РњРёРЅРёРєР°СЂС‚Р°.',
        en: '  // Minimap.'
    },
    squad: {
        ru: '  // РџР°СЂР°РјРµС‚СЂС‹ РѕРєРЅР° РІР·РІРѕРґР°.',
        en: '  // Parameters for squad window.'
    },
    colors: {
        ru: '  // РќР°СЃС‚СЂРѕР№РєРё С†РІРµС‚РѕРІ.',
        en: '  // Color settings.'
    },
    alpha: {
        ru: '  // РќР°СЃС‚СЂРѕР№РєРё РґРёРЅР°РјРёС‡РµСЃРєРѕР№ РїСЂРѕР·СЂР°С‡РЅРѕСЃС‚Рё.',
        en: '  // Options for dynamic transparency.'
    },
    rating: {
        ru: '  // Р‘Р»РѕРє СѓРїСЂР°РІР»РµРЅРёРµРј СЃС‚Р°С‚РёСЃС‚РёРєРѕР№ (С‚РѕР»СЊРєРѕ СЃ xvm-stat).',
        en: '  // Options for player statistics (only with xvm-stat).'
    },
    elements: {
        ru: '  // Р‘Р»РѕРє СѓРїСЂР°РІР»РµРЅРёРµРј СЃС‚Р°С‚РёСЃС‚РёРєРѕР№ (С‚РѕР»СЊРєРѕ СЃ xvm-stat).',
        en: '  // Options for player statistics (only with xvm-stat).'
    },
    minimapCircles: {
        ru: '  // РљСЂСѓРіРё РЅР° РјРёРЅРёРєР°СЂС‚Рµ.',
        en: '  // Minimap circles.'
    },
    minimapLines: {
        ru: '  // Р›РёРЅРёРё РЅР° РјРёРЅРёРєР°СЂС‚Рµ.',
        en: '  // Minimap lines.'
    },
    minimapLabels: {
        ru: '  // РќР°РґРїРёСЃРё РЅР° РјРёРЅРёРєР°СЂС‚Рµ.',
        en: '  // Minimap labels.'
    }
}

var regexpOpen = /{/g;
var regexpClose = /}/g;
var openBr = "{";
var closeBr = "}";
	
// Определяем язык системы
var reg = WScript.CreateObject('WScript.Shell');
var Rus=reg.RegRead('HKLM\\SYSTEM\\CurrentControlSet\\Control\\Nls\\Language\\Default');
if (Rus=="0419" || Rus=="0422" || Rus=="0423" || Rus=="043f")
    Rus = true;
else
    Rus = false;

var fso=WScript.CreateObject("Scripting.FileSystemObject");
var wsh = WScript.CreateObject("WScript.Shell");
// путь до папки со скриптом
var path = WScript.ScriptFullName.substr(0, (WScript.ScriptFullName.length - WScript.ScriptName.length));

// Имя файла конфига берём из аргумента или задаем XVM.xvmconf, если аргумент пуст
var file_input="XVM.xvmconf";
if (WScript.Arguments.length>0)
    file_input=WScript.Arguments(0);

// Проверяем наличие файла XVM.xvmconf
if (!fso.FileExists(file_input)) {
    if (Rus)
        WScript.Echo("Файл \"XVM.xvmconf\" не найден, поместите его в эту же папку,\n или перетащите на скрипт.\n\nПодробнее: http://www.koreanrandom.com/forum/topic/4643-");
    else
        WScript.Echo("The file \"XVM.xvmconf\" not found, place it in the same folder,\n or drag'n'drop a config on the script.\n\nFor more information: http://www.koreanrandom.com/forum/topic/4643-");
    WScript.Quit();
}

// массив для хранения исходного конфига
var inputConfig = fileToArray(file_input);

// Ищем имя автора конфига
var i = 0;
while (i < inputConfig.length && !isStart(inputConfig[i], '"author"'))
  i++;
if (i == inputConfig.length) {
    i = 0;
    while (i < inputConfig.length && inputConfig[i].indexOf('"author"') == -1)
      i++;
}
if (i == inputConfig.length) {
    var author = "autoscript by seriych";
} else {
    author = inputConfig[i].substring(inputConfig[i].indexOf('"author"'));
    author = author.substring(8);
    author = author.substring(author.indexOf("\"")+1);
    author = author.substring(0, author.indexOf("\""));
}

// заменяем символы, которые нельзя использовать в именах файлов, на пробелы
author = author.replace( /[":*?><|&^\\\/]/g , ' ');

// Если папка с именем автора существует, создаем новую с числовым индексом
if (fso.FolderExists(path+author)) {
    i = 1;
    while (fso.FolderExists(path+author+" "+i))
        i++;
    author = author+" "+i;
}
fso.CreateFolder(path+author);

i = 0;
// ищем начало секции конфига
var startIndex = 0;
while ( i < inputConfig.length && !isStart(inputConfig[i], '{'))
        i++;
if (i != inputConfig.length)
    startIndex = i;

/******************************************************************************/
/**               Ищем вхождения всех секций                                  */
/******************************************************************************/
for ( var j = 0; j < sections.length; j++) {
    i = 0;
    //ищем строку, содержащую секцию
    while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
        i++;
    // получаем название секции без кавычек
    var section = sections[j].substring(0, sections[j].length-1);
    section = section.substring(1);
    // если не нашли, прописываем пустышку
    if (i == inputConfig.length) {
        inputConfig.splice(startIndex+1, 0, sectionsComments[section].en, sectionsComments[section].ru, "  "+sections[j]+": {", "    ", "  },");
        i = startIndex + 3;
        // если миникарта или battle пустышка, запоминаем это
        if (section == "minimap")
            var blankMinimap = true;
        if (section == "battle")
            var blankBattle = true;
    } else if (section == "minimap") {
        if ( diffBraces(inputConfig[i]) == 0)
            blankMinimap = true;
        else
            blankMinimap = false;
    } else if (section == "battle") {
        if ( diffBraces(inputConfig[i]) == 0)
            blankBattle = true;
        else
            blankBattle = false;
    }
    // если перед секцией нет комментария, записываем дефолтный
    if (numberComments(i)==0) {
        inputConfig.splice(i, 0, sectionsComments[section].en, sectionsComments[section].ru);
        i = i + 2;
    }
    // создаем файл для записи секции
    if (section == "userInfo")
        section = "hangar";
    if (section == "fragCorrelation" || section == "expertPanel")
        section = "battle";
    var file_out = path+author+"\\"+section+".xc";
    var startString = "{";
    // если файлы hangar.xc или battle.xc уже существуют, то в них надо удалить концовку и дописывать новую секцию
    if ((section == "hangar" || section == "battle") && fso.FileExists(file_out)) {
            delStrings(file_out);
            startString = "  },";
    }
    fout=fso.OpenTextFile(file_out,8,true,false);
    fout.WriteLine(startString);
    // копируем секцию в файл
    writeSection();
    // завершаем секцию и закрываем файл
    fout.WriteLine("  }");
    fout.WriteLine("}");
    fout.Close();
    // создаем строку для записи в главный файл конфига подстановки вместо секции
    var input_string = "  "+sections[j]+": ${\""+section+".xc\""+":"+sections[j]+"}";
    // если секция не последняя в конфиге, надо добавить запятую
    if (inputConfig[i].indexOf(",") != -1 && inputConfig[i].lastIndexOf("}") < inputConfig[i].lastIndexOf(","))
        input_string = input_string + ",";
    // записываем подстановку в главный файл конфига
    inputConfig.splice(i, 1, input_string, "");
}

// переносим отстатки главного конфига из массива в файл @XVM.xc
file_out = path+author+"\\@XVM.xc";
fout=fso.OpenTextFile(file_out,2,true,false);
for ( i = 0; i < inputConfig.length; i++)
    fout.WriteLine(inputConfig[i]);
fout.WriteLine();
if (Rus)
    fout.WriteLine("//  РђРІС‚РѕРјР°С‚РёС‡РµСЃРєРё СЃРіРµРЅРµСЂРёСЂРѕРІР°РЅРѕ СЌС‚РёРј СЃРєСЂРёРїС‚РѕРј:");
else
    fout.WriteLine("//  Automatically generated by this script:");
fout.WriteLine("//  http://www.koreanrandom.com/forum/topic/4643-");
// закрываем файл
fout.Close();

/******************************************************************************/
/**               Секция миникарты                                            */
/******************************************************************************/
if (fso.FileExists(path+author+"\\minimap.xc")) {
    // массив названий секций миникарты
    sections = [    // порядок секций лучше не менять
                        '"circles"',
                        '"labels"',
                        '"lines"'
               ];
    // массив для хранения исходного конфига
    inputConfig = fileToArray(path+author+"\\minimap.xc");

    i = 0;
    // ищем начало секции minimap
    while ( i < inputConfig.length && !isStart(inputConfig[i], '"minimap"'))
            i++;
    if (i != inputConfig.length)
        startIndex = i;

    // ищем вхождения всех секций
    for ( j = 0; j < sections.length; j++) {
        i = 0;
        //ищем строку, содержащую секцию
        while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
            i++;
        // получаем название секции без кавычек
        section = sections[j].substring(0, sections[j].length-1);
        section = "minimap"+section.charAt(1).toUpperCase()+section.substring(2);
        // если не нашли, прописываем пустышку
        if (i == inputConfig.length) {
            inputConfig.splice(startIndex+1, 0, sectionsComments[section].en, sectionsComments[section].ru, "  "+sections[j]+": {", "    ", "  },");
            i = startIndex+3;
            // фикс для не добавления запятой, если секция-пустышка завершает файл
            var lastRef = false;
            if (j == sections.length-1 && blankMinimap)
                lastRef = true;
        }
        // если перед секцией нет комментария, записываем дефолтный
        if (numberComments(i)==0) {
            inputConfig.splice(i, 0, sectionsComments[section].en, sectionsComments[section].ru);
            i = i + 2;
        }
        startIndex = i;
        // создаем файл для записи секции
        file_out = path+author+"\\"+section+".xc";
        fout=fso.OpenTextFile(file_out,2,true,false);
        fout.WriteLine("{");
        // копируем секцию в файл
        writeSection();
        // завершаем секцию и закрываем файл
        fout.WriteLine("  }");
        fout.WriteLine("}");
        fout.Close();
        // создаем строку для записи в главный файл конфига подстановки вместо секции
        input_string = "    "+sections[j]+": ${\""+section+".xc\""+":"+sections[j]+"}";
        // если секция не последняя в конфиге, надо добавить запятую
        if (inputConfig[i].indexOf(",") != -1 && !lastRef)
            input_string = input_string + ",";
        // записываем подстановку в главный файл конфига
        inputConfig.splice(i, 1, input_string, "");
    }

    // переносим отстатки секции minimap из массива в файл minimap/minimap.xc
    file_out = path+author+"\\minimap.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++)
        fout.WriteLine(inputConfig[i]);
    // закрываем файл
    fout.Close();
}

/******************************************************************************/
/**                         Секция маркеров                                   */
/******************************************************************************/
if (fso.FileExists(path+author+"\\markers.xc")) {
    var    enemy = ['"ally"', '"enemy"' ];       // массив свой/чужой
    var     dead = ['"alive"',  '"dead"' ];      // массив живой/мертвый
    var extended = ['"normal"', '"extended"' ];  // массив нормальный/расширенный режим
    // массив для хранения исходного конфига
    inputConfig = fileToArray(path+author+"\\markers.xc");

    for ( var m = 0; m < enemy.length; m++) {
        i = 0;
        //ищем строку, содержащую секцию
        while ( i < inputConfig.length && !isStart(inputConfig[i], enemy[m]))
            i++;
        // если не нашли, переходим к следующей секции
        if (i == inputConfig.length)
            continue;
        var i1 = i;
        // ищем вхождения всех подсекций
        for ( j = 0; j < dead.length; j++) {
            i = i1;
            //ищем строку, содержащую секцию
            while ( i < inputConfig.length && !isStart(inputConfig[i], dead[j]))
                i++;
            // если не нашли, переходим к следующей секции
            if (i == inputConfig.length)
                continue;
            var i2 = i;
            // ищем вхождения всех подсекций
            for ( p = 0; p < extended.length; p++) {
                //ищем строку, содержащую секцию
                i = i2;
                while ( i < inputConfig.length && !isStart(inputConfig[i], extended[p]))
                    i++;
                // получаем название секции без кавычек
                section = extended[p].substring(0, extended[p].length-1);
                section = dead[j].substring(0, dead[j].length-1)+section.charAt(1).toUpperCase()+section.substring(2);
                section = "markers"+section.charAt(1).toUpperCase()+section.substring(2);
                // если не нашли, переходим к следующей секции
                if (i == inputConfig.length)
                    continue;
                // создаем файл для записи секции
                file_out = path+author+"\\"+section+".xc";
                fout=fso.OpenTextFile(file_out,8,true,false);
                if ( m == 0)
                    fout.WriteLine("{");
                else
                    fout.WriteLine("        },");
                inputConfig[i] = inputConfig[i].replace(extended[p], enemy[m]);
                // копируем секцию в файл
                writeSection();
                // завершаем секцию и закрываем файл
                if ( m == 1) {
                    fout.WriteLine("        }");
                    fout.WriteLine("}");
                }
                fout.Close();
                // создаем строку для записи в главный файл конфига подстановки вместо секции
                input_string = "        "+extended[p]+": ${\""+section+".xc\""+":"+enemy[m]+"}";
                // если секция не последняя в конфиге, надо добавить запятую
                if (inputConfig[i].indexOf(",") != -1)
                    input_string = input_string + ",";
                // записываем подстановку в главный файл конфига
                inputConfig.splice(i, 1, input_string, "");
            }
        }
    }
    // переносим отстатки секции markers из массива в файл markers/markers.xc
    file_out = path+author+"\\markers.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++)
        fout.WriteLine(inputConfig[i]);
    // закрываем файл
    fout.Close();
}

/******************************************************************************/
/**               Секция battle                                               */
/******************************************************************************/
if (fso.FileExists(path+author+"\\battle.xc")) {
    // массив названий секций battle
    sections = [    // порядок секций лучше не менять
                        '"elements"'
               ];
    // массив для хранения исходного конфига
    inputConfig = fileToArray(path+author+"\\battle.xc");

    i = 0;
    // ищем начало секции battle
    while ( i < inputConfig.length && !isStart(inputConfig[i], '"battle"'))
            i++;
    if (i != inputConfig.length)
        startIndex = i;
		
	regexpOpen = /\[/g;
	regexpClose = /]/g;
	openBr = "[";
	closeBr = "]";
	
    // ищем вхождения всех секций
    for ( j = 0; j < sections.length; j++) {
        i = 0;
        //ищем строку, содержащую секцию
        while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
            i++;
        // получаем название секции без кавычек
        section = sections[j].substring(0, sections[j].length-1);
        section = section.substring(1);
        // если не нашли, прописываем пустышку
        if (i == inputConfig.length) {
            inputConfig.splice(startIndex+1, 0, sectionsComments[section].en, sectionsComments[section].ru, "  "+sections[j]+": [", "    ", "  ],");
            i = startIndex+3;
            // фикс для не добавления запятой, если секция-пустышка завершает файл
            var lastRef = false;
            if (j == sections.length-1 && blankBattle)
                lastRef = true;
        }
        // если перед секцией нет комментария, записываем дефолтный
        if (numberComments(i)==0) {
            inputConfig.splice(i, 0, sectionsComments[section].en, sectionsComments[section].ru);
            i = i + 2;
        }
        startIndex = i;
        // создаем файл для записи секции
        file_out = path+author+"\\"+section+".xc";
        fout=fso.OpenTextFile(file_out,2,true,false);
        fout.WriteLine("{");
        // копируем секцию в файл
        writeSection();
        // завершаем секцию и закрываем файл
        fout.WriteLine("  ]");
        fout.WriteLine("}");
        fout.Close();
        // создаем строку для записи в главный файл конфига подстановки вместо секции
        input_string = "    "+sections[j]+": ${\""+section+".xc\""+":"+sections[j]+"}";
        // если секция не последняя в конфиге, надо добавить запятую
        if (inputConfig[i].indexOf(",") != -1 && !lastRef)
            input_string = input_string + ",";
        // записываем подстановку в главный файл конфига
        inputConfig.splice(i, 1, input_string, "");
    }

    // переносим отстатки секции minimap из массива в файл minimap/minimap.xc
    file_out = path+author+"\\battle.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++)
        fout.WriteLine(inputConfig[i]);
    // закрываем файл
    fout.Close();
}

// Прописываем созданный конфиг к загрузке, если скрипт лежал в res_mods/xvm/anyFolder/script.js
var xvmFolder = path.substring(0, path.length-1);
xvmFolder = xvmFolder.substring(0, xvmFolder.lastIndexOf("\\")+1);
var change = "";
if (xvmFolder.substring(xvmFolder.length-14) == "\\res_mods\\xvm\\") {
    file_out = xvmFolder+"configs\\xvm.xc";
    if (fso.FileExists(file_out))
        fso.GetFile(file_out).copy(xvmFolder+"configs\\xvm.xc.old");
    fout=fso.OpenTextFile(file_out,2,true,false);
    fout.WriteLine('${"'+author+'/@xvm.xc":"."}');
    if (Rus)
        change = '\nИ прописан к загрузке в:\n"'+xvmFolder+'xvm.xc"';
    else
        change = '\nAnd set for loading in:\n"'+xvmFolder+'xvm.xc"';
}

// Отчитываемся о проделанной работе
if (Rus)
    WScript.Echo('Конфиг успешно сохранен в:\n"'+path+author+'\\"'+change);
else
    WScript.Echo('Config successfully saved in:\n"'+path+author+'\\"'+change);

// Завершаем выполнение скрипта
WScript.Quit();


/******************************************************************************/
/**                     Вспомогательные функции                               */
/******************************************************************************/

// Функция подсчета разницы количества открывающих и закрывающих скобок в строке
function diffBraces(line) {
  //WScript.Echo(brace);
  //WScript.Quit();
  var openBraces = 0;
  var closeBraces = 0;
  // Считаем открывающие
  if (line.indexOf(openBr) != -1)
    openBraces = line.match(regexpOpen).length;
  // Считаем закрывающие
  if (line.indexOf(closeBr) != -1)
    closeBraces = line.match(regexpClose).length;
  // возвращаем разницу
  return openBraces-closeBraces
}

// функция, возвращающая true, если строка содержит подстроку в начале или сразу после пробелов и табов
function isStart(line, sect) {
  if ( line.substring(0, 3) == "п»ї")
    line = line.substring(3);
  while (line.indexOf(" ") == 0 || line.indexOf("\t") == 0 )
    line = line.substring(1);
  if (line.indexOf(sect) == 0)
    return true
  else
    return false
}

// Функция проверки, является ли строка комментарием
function isComment(line) {
  return isStart(line, "//")
}

// функция, возвращающая количество строк подряд с комментариями выше i-й строки
function numberComments(i) {
  var n = 0;
  while (isComment(inputConfig[i-n-1]))
    n++;
  return n
}

// удаление последних двух строк из файла
function delStrings(file_out) {
    finput=fso.OpenTextFile(file_out,1,false,false);
    var n = 0;
    // считываем в массив
    var inputArr = new Array();
    while(!finput.AtEndOfStream){
        inputArr[n] = finput.ReadLine();
        n++;
    }
    finput.Close();
    n = n-2;
    finput=fso.OpenTextFile(file_out,2,true,false);
    var k = 0;
    while ( k < n) {
        finput.WriteLine(inputArr[k]);
        k++;
    }
    finput.Close();
}

// функция, удаляющая в строке последнее вхождение "}" или "},"
function delLastBrace(line) {
  if (section == "minimap" && diffBraces(inputConfig[i]) == 0)
    var minimapFix = ",";
  else
    minimapFix = "";
  if ( line.lastIndexOf("},") != -1 && line.lastIndexOf("},") == line.lastIndexOf("}"))
    return line.substring(0, line.lastIndexOf("},"))+minimapFix+line.substring(line.lastIndexOf("},")+2);
  else
    return line.substring(0, line.lastIndexOf("}"))+minimapFix+line.substring(line.lastIndexOf("}")+1);
}

// функция, копирующая секцию в файл
function writeSection() {
    // записываем комментарии, предшествующие секции
    for (var k = numberComments(i); k > 0; k--)
      fout.WriteLine(inputConfig[i-k]);
    // считаем разницу между количеством открывающих и закрывающих скобок
    var diff = diffBraces(inputConfig[i]);
    if (diff == 0)
        // если секция из одной строки, пишем в файл эту строку без последней скобки
        fout.WriteLine(delLastBrace(inputConfig[i]));
    else
        // Иначе пишем в файл, пока не дойдем до конца секции (закроется последняя скобка секции)
        while (diff > 0) {
            fout.WriteLine(inputConfig[i]);
            inputConfig.splice(i, 1);
            diff = diff + diffBraces(inputConfig[i]);
        }
}

// функция, считывающая файл в массив
function fileToArray(file_input) {
    var inputConfig = new Array();
    var finput = fso.OpenTextFile(file_input,1,false,false);
    var i = 0;
    // считываем конфиг в массив
    while(!finput.AtEndOfStream){
      inputConfig[i]=finput.ReadLine();
      i++;
    }
    finput.Close();
    return inputConfig;
}