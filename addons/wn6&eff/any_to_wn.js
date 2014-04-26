// Скрипт для замены одного представления рейтинга на другое в конфиге XVM 5.3.0+
// http://www.koreanrandom.com/forum/topic/3163-/#entry43725

// нужный текст
var text_rate   = "{{wn%4d|----}}";
var text_color  = "{{c:wn}}";
var text_alpha  = "{{a:wn}}";
var text_option = "\"xwnInCompany\": true";

// заменяемый текст
var find_rate   = /{{x?(wn|eff)[^}]*}}/g;
var find_color  = /{{c:x?(wn|eff)[^}]*}}/g;
var find_alpha  = /{{a:x?(wn|eff)[^}]*}}/g;
var find_option = /"xwnInCompany"[\s\t]*:[\s\t]*(true|false)/g;

var i=0;
do {
    // Имя файла берём из аргумента или задаем XVM.xc, если аргумент пуст
    var file_name = "xvm.xc";
    if ( WScript.Arguments.length > 0 )
        file_name = WScript.Arguments(i);

    var fso=WScript.CreateObject("Scripting.FileSystemObject");
    // если не найден файл, переходим к следующему
    if ( !fso.FileExists(file_name) )
        break;

    // Переносим исходный файл во временный
    var file_name_tmp = file_name+".tmp";
    if ( fso.FileExists(file_name_tmp) )
        fso.DeleteFile(file_name_tmp);
    fso.MoveFile(file_name, file_name_tmp);

    // создаем переменные для доступа к файлам
    var fold = fso.OpenTextFile(file_name_tmp,1,false,false);
    var fnew = fso.OpenTextFile(file_name,2,true,false);

    // читаем старый конфиг, пока не закончится
    while ( !fold.AtEndOfStream ) {
        var line = fold.ReadLine();

        // меняем макросы, если они есть в строке
        line = line.replace(find_rate, text_rate);
        line = line.replace(find_color, text_color);
        line = line.replace(find_alpha, text_alpha);
        line = line.replace(find_option, text_option);

        // пишем строку в новый файл
        fnew.WriteLine(line);
    }

    // закрываем файлы и удаляем временный
    fold.Close();
    fnew.Close();
    fso.DeleteFile(file_name_tmp);  // добавьте // вначале строки, чтобы оставались резервные копии файлов *.old

    i++
} while (i<WScript.Arguments.length);

// выходим из программы
WScript.Quit();