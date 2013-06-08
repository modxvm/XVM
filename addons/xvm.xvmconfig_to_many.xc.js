/******************************************************************************
      Скрипт для разбивки конфига XVM.xvmconf под формат XVM-4.0.0+
      Automatic conversion XVM.xvmconf to the new format XVM-4.0.0+
      
      Инструкции (instructions):
      http://www.koreanrandom.com/forum/topic/4643-
******************************************************************************/

// массив названий секций
var sections = [    // порядок секций лучше не менять
                    '"login"',
                    '"iconset"',
                    '"markers"',
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
                    '"battle"',
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
if (WScript.Arguments.length>0) {
    file_input=WScript.Arguments(0);
}
   
// Проверяем наличие файла XVM.xvmconf
if (!fso.FileExists(file_input)) {
    if (Rus)
        WScript.Echo("Файл \"XVM.xvmconf\" не найден, поместите его в эту же папку,\n или перетащите на скрипт.\n\nПодробнее: http://www.koreanrandom.com/forum/topic/4643-");
    else
        WScript.Echo("The file \"XVM.xvmconf\" not found, place it in the same folder,\n or drag'n'drop a config on the script.\n\nFor more information: http://www.koreanrandom.com/forum/topic/4643-");
    WScript.Quit();
}

// массив для хранения исходного конфига
var inputConfig = new Array();
var finput=fso.OpenTextFile(file_input,1,false,false);
var i = 0;

// считываем конфиг в массив
while(!finput.AtEndOfStream){
  inputConfig[i]=finput.ReadLine();
  i++;
}
finput.Close();

// создаем папку для конфига по имени прописанного в нем автора
i = 0;
while (i < inputConfig.length && !isStart(inputConfig[i], '"author"')){
  i++;
}
if (i == inputConfig.length) {
    var author = "autoscript by seriych";
} else {
    var author = inputConfig[i].substring(inputConfig[i].indexOf('"author"'));
    author = author.substring(8);
    author = author.substring(author.indexOf("\"")+1);
    author = author.substring(0, author.indexOf("\""));
}
// Если папка с именем автора существует, создаем новую с числовым индексом
if (fso.FolderExists(path+author)) {
    i = 1;
    while (fso.FolderExists(path+author+" "+i)) {
        i++;
    }
    author = author+" "+i;
}
fso.CreateFolder(path+author);

// ищем вхождения всех секций
for ( var j = 0; j < sections.length; j++) {
    i = 0;
    //ищем строку, содержащую секцию
    while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
        i++;
    // если не нашли, переходим к следующей секции
    if (i == inputConfig.length)
        continue;
    // получаем название секции без кавычек
    var section = sections[j].substring(0, sections[j].length-1);
    section = section.substring(1);
    // если секции миникарты или маркеров, то надо создавать под них папки
    var subfolder = "";
    if (section == "minimap" || section == "markers") {
        subfolder = section+"\\";
        fso.CreateFolder(path+author+"\\"+section);
    };
    // создаем файл для записи секции
    if (section == "userInfo" && fso.FileExists(path+author+"\\hangar.xc")) {
        var file_out = path+author+"\\hangar.xc";
        delStrings(file_out);
        var fout=fso.OpenTextFile(file_out,8,true,false);
        section = "hangar";
        fout.WriteLine("  },");
    } else if ( (section == "fragCorrelation" || section == "expertPanel") && fso.FileExists(path+author+"\\battle.xc")) {
        var file_out = path+author+"\\battle.xc";
        delStrings(file_out);
        var fout=fso.OpenTextFile(file_out,8,true,false);
        section = "battle";
        fout.WriteLine("  },");
    } else {
        file_out = sections[j].substring(0, sections[j].length-1);
        file_out = path+author+"\\"+subfolder+file_out.substring(1)+".xc";
        fout=fso.OpenTextFile(file_out,2,true,false);
        fout.WriteLine("{");
    }
    // записываем комментарии, предшествующие секции
    for (var k = numberComments(i); k > 0; k--)
      fout.WriteLine(inputConfig[i-k]);
    // считаем разницу между количеством открывающих и закрывающих скобок
    var diff = diffBraces(inputConfig[i]);
    // Пишем секцию в файл, пока не дойдем до конца секции (закроется последняя скобка секции)
    do {
      fout.WriteLine(inputConfig[i]);
      // удаляем записанную строку из исходного конфига
      inputConfig.splice(i, 1);
      diff = diff + diffBraces(inputConfig[i]);
    } while (diff > 0);  // выходим из цикла, если скобка закрылась
    // завершаем секцию и закрываем файл
    fout.WriteLine("  }");
    fout.WriteLine("}");
    fout.Close();
    // проверяем, надо ли записывать ссылку на секцию с учетом подпапки
    if (subfolder != "")
        subfolder=subfolder.substring(0, subfolder.length-1)+"/";
    // создаем строку для записи в главный файл конфига подстановки вместо секции
    input_string = "  "+sections[j]+": ${\""+subfolder+section+".xc\""+":"+sections[j]+"}";
    // если секция не последняя в конфиге, надо добавить запятую
    if (inputConfig[i].indexOf(",") != -1)
        input_string = input_string + ",";
    // записываем подстановку в главный файл конфига
    inputConfig.splice(i, 1, input_string, "");
}

// переносим отстатки главного конфига из массива в файл @XVM.xc
file_out = path+author+"\\@XVM.xc";
fout=fso.OpenTextFile(file_out,2,true,false);
for ( i = 0; i < inputConfig.length; i++) {
    fout.WriteLine(inputConfig[i]);
}
fout.WriteLine();
if (Rus)
    fout.WriteLine("//  РђРІС‚РѕРјР°С‚РёС‡РµСЃРєРё СЃРіРµРЅРµСЂРёСЂРѕРІР°РЅРѕ СЌС‚РёРј СЃРєСЂРёРїС‚РѕРј:");
else
    fout.WriteLine("//  Automatically generated by this script:");
fout.WriteLine("//  http://www.koreanrandom.com/forum/topic/4643-");
// закрываем файл
fout.Close();

/******************************************************************************
               Секция миникарты
******************************************************************************/

if (fso.FileExists(path+author+"\\minimap\\minimap.xc")) {
    // массив названий секций миникарты
    sections = [    // порядок секций лучше не менять
                        '"labels"',
                        '"circles"',
                        '"lines"'
                ];
    // массив для хранения исходного конфига
    inputConfig = new Array();
    finput=fso.OpenTextFile(path+author+"\\minimap\\minimap.xc",1,false,false);
    i = 0;

    // считываем конфиг в массив
    while(!finput.AtEndOfStream){
      inputConfig[i]=finput.ReadLine();
      i++;
    }
    finput.Close();

    // ищем вхождения всех секций
    for ( j = 0; j < sections.length; j++) {
        i = 0;
        //ищем строку, содержащую секцию
        while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
            i++;
        // если не нашли, переходим к следующей секции
        if (i == inputConfig.length)
            continue;
        // получаем название секции без кавычек
        section = sections[j].substring(0, sections[j].length-1);
        section = "minimap"+section.charAt(1).toUpperCase()+section.substring(2);
        // создаем файл для записи секции
        file_out = path+author+"\\minimap\\"+section+".xc";
        fout=fso.OpenTextFile(file_out,2,true,false);
        fout.WriteLine("{");
        // записываем комментарии, предшествующие секции
        for ( k = numberComments(i); k > 0; k--)
          fout.WriteLine(inputConfig[i-k]);
        // считаем разницу между количеством открывающих и закрывающих скобок
        diff = diffBraces(inputConfig[i]);
        // Пишем секцию в файл, пока не дойдем до конца секции (закроется последняя скобка секции)
        do {
          fout.WriteLine(inputConfig[i]);
          // удаляем записанную строку из исходного конфига
          inputConfig.splice(i, 1);
          diff = diff + diffBraces(inputConfig[i]);
        } while (diff > 0);  // выходим из цикла, если скобка закрылась
        // завершаем секцию и закрываем файл
        fout.WriteLine("  }");
        fout.WriteLine("}");
        fout.Close();
        // создаем строку для записи в главный файл конфига подстановки вместо секции
        input_string = "    "+sections[j]+": ${\""+section+".xc\""+":"+sections[j]+"}";
        // если секция не последняя в конфиге, надо добавить запятую
        if (inputConfig[i].indexOf(",") != -1)
            input_string = input_string + ",";
        // записываем подстановку в главный файл конфига
        inputConfig.splice(i, 1, input_string, "");
    }

    // переносим отстатки секции minimap из массива в файл minimap/minimap.xc
    file_out = path+author+"\\minimap\\minimap.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++) {
        fout.WriteLine(inputConfig[i]);
    }
    // закрываем файл
    fout.Close();
}

/******************************************************************************
                         Секция цветов
******************************************************************************/

if (fso.FileExists(path+author+"\\colors.xc")) {
    // массив названий секции цветов
    sections = [    // порядок секций лучше не менять
                        '"damage"'
                ];
    // массив для хранения исходного конфига
    inputConfig = new Array();
    finput=fso.OpenTextFile(path+author+"\\colors.xc",1,false,false);
    i = 0;

    // считываем конфиг в массив
    while(!finput.AtEndOfStream){
      inputConfig[i]=finput.ReadLine();
      i++;
    }
    finput.Close();

    // ищем вхождения всех секций
    for ( j = 0; j < sections.length; j++) {
        i = 0;
        //ищем строку, содержащую секцию
        while ( i < inputConfig.length && !isStart(inputConfig[i], sections[j]))
            i++;
        // если не нашли, переходим к следующей секции
        if (i == inputConfig.length)
            continue;
        // получаем название секции без кавычек
        section = sections[j].substring(0, sections[j].length-1);
        section = "colors"+section.charAt(1).toUpperCase()+section.substring(2);
        // создаем файл для записи секции
        file_out = path+author+"\\"+section+".xc";
        fout=fso.OpenTextFile(file_out,2,true,false);
        fout.WriteLine("{");
        // записываем комментарии, предшествующие секции
        for ( k = numberComments(i); k > 0; k--)
          fout.WriteLine(inputConfig[i-k]);
        // считаем разницу между количеством открывающих и закрывающих скобок
        diff = diffBraces(inputConfig[i]);
        // Пишем секцию в файл, пока не дойдем до конца секции (закроется последняя скобка секции)
        do {
          fout.WriteLine(inputConfig[i]);
          // удаляем записанную строку из исходного конфига
          inputConfig.splice(i, 1);
          diff = diff + diffBraces(inputConfig[i]);
        } while (diff > 0);  // выходим из цикла, если скобка закрылась
        // завершаем секцию и закрываем файл
        fout.WriteLine("  }");
        fout.WriteLine("}");
        fout.Close();
        // создаем строку для записи в главный файл конфига подстановки вместо секции
        input_string = "    "+sections[j]+": ${\""+section+".xc\""+":"+sections[j]+"}";
        // если секция не последняя в конфиге, надо добавить запятую
        if (inputConfig[i].indexOf(",") != -1)
            input_string = input_string + ",";
        // записываем подстановку в главный файл конфига
        inputConfig.splice(i, 1, input_string, "");
    }

    // переносим отстатки секции colors из массива в файл colors.xc
    file_out = path+author+"\\colors.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++) {
        fout.WriteLine(inputConfig[i]);
    }
    // закрываем файл
    fout.Close();
}

/******************************************************************************
                         Секция маркеров
******************************************************************************/

if (fso.FileExists(path+author+"\\markers\\markers.xc")) {
    var    enemy = ['"ally"', '"enemy"' ];       // массив свой/чужой
    var     dead = ['"alive"',  '"dead"' ];      // массив живой/мертвый
    var extended = ['"normal"', '"extended"' ];  // массив нормальный/расширенный режим
    // массив для хранения исходного конфига
    inputConfig = new Array();
    finput=fso.OpenTextFile(path+author+"\\markers\\markers.xc",1,false,false);

    i = 0;
    // считываем конфиг в массив
    while(!finput.AtEndOfStream){
      inputConfig[i]=finput.ReadLine();
      i++;
    }
    finput.Close();

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
                // если не нашли, переходим к следующей секции
                if (i == inputConfig.length)
                    continue;
                // получаем название секции без кавычек
                section = extended[p].substring(0, extended[p].length-1);
                section = dead[j].substring(0, dead[j].length-1)+section.charAt(1).toUpperCase()+section.substring(2);
                section = "markers"+section.charAt(1).toUpperCase()+section.substring(2);
                // создаем файл для записи секции
                file_out = path+author+"\\markers\\"+section+".xc";
                fout=fso.OpenTextFile(file_out,8,true,false);
                if ( m == 0)
                    fout.WriteLine("{");
                else
                    fout.WriteLine("        },");
                // записываем комментарии, предшествующие секции
                for ( k = numberComments(i); k > 0; k--)
                  fout.WriteLine(inputConfig[i-k]);
                // считаем разницу между количеством открывающих и закрывающих скобок
                diff = diffBraces(inputConfig[i]);
                // Пишем секцию в файл, пока не дойдем до конца секции (закроется последняя скобка секции)
                inputConfig[i] = inputConfig[i].replace(extended[p], enemy[m]);
                do {
                  fout.WriteLine(inputConfig[i]);
                  // удаляем записанную строку из исходного конфига
                  inputConfig.splice(i, 1);
                  diff = diff + diffBraces(inputConfig[i]);
                } while (diff > 0);  // выходим из цикла, если скобка закрылась
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
    file_out = path+author+"\\markers\\markers.xc";
    fout=fso.OpenTextFile(file_out,2,true,false);
    for ( i = 0; i < inputConfig.length; i++) {
        fout.WriteLine(inputConfig[i]);
    }
    // закрываем файл
    fout.Close();
}

// Прописываем созданный конфиг к загрузке, если конфиг скрипт лежал в res_mods/xvm/anyFolder/script.js
var xvmFolder = path.substring(0, path.length-1);
var scriptFolder = xvmFolder.substring(xvmFolder.lastIndexOf("\\")+1);
xvmFolder = xvmFolder.substring(0, xvmFolder.lastIndexOf("\\")+1);
var change = "";
if (xvmFolder.substring(xvmFolder.length-14) == "\\res_mods\\xvm\\") {
    file_out = xvmFolder+"xvm.xc";
    fso.GetFile(file_out).copy(xvmFolder+"xvm.xc.old");
    fout=fso.OpenTextFile(file_out,2,true,false);
    fout.WriteLine('${"'+scriptFolder+'/'+author+'/@xvm.xc":"."}');
    if (Rus)
        change = '\nИ прописан к загрузке в:\n"'+xvmFolder+'xvm.xc"';
    else
        change = '\nAnd set for loading in:\n"'+xvmFolder+'xvm.xc"';
}

// Отчитываемся о проделанной работе
if (Rus)
    WScript.Echo("Конфиг успешно сохранен в:\n\""+path+author+"\\\""+change);
else
    WScript.Echo("Config successfully saved in:\n\""+path+author+"\\\""+change);

// Завершаем выполнение скрипта
WScript.Quit();

/******************************************************************************
                     Вспомогательные функции
******************************************************************************/

// Функция подсчета разницы количества открывающих и закрывающих скобок в строке
function diffBraces(line) {
  var openBraces = 0;
  var closeBraces = 0;
  // Считаем открывающие
  if (line.indexOf("{") != -1)
    openBraces = line.match(/{/g).length;
  // Считаем закрывающие
  if (line.indexOf("}") != -1)
    closeBraces = line.match(/}/g).length;
  // возвращаем разницу
  return openBraces-closeBraces
}

// функция, возвращающая true, если строка содержит подстроку в начале или сразу после пробелов и табов
function isStart(line, sect) {
  while (line.indexOf(" ") == 0 || line.indexOf("   ") == 0 )
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
    while(k<n){
        finput.WriteLine(inputArr[k]);
        k++;
    }
    finput.Close();
}