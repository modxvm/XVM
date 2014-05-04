// Скрипт для замены одного представления рейтинга на другое в конфиге XVM 5.3.0+
// script.js [rating] [file1 folder1 folder2 folder3 file3 ...]
// http://www.koreanrandom.com/forum/topic/3163-/#entry43725

// Введите название рейтинга маленькими буквами кавычках
var rating = "eff"; // Примеры: "eff", "xeff", "wn8", "xwn8", "wn6", "xwn6", "wn", "xwn"

// массив поддерживаемых рейтингов
var Aratings = [ "eff", "xeff", "wn8", "xwn8", "wn6", "xwn6", "wn", "xwn" ];

// если в качестве первого аргумента передан какой-то рейтинг, применяем его для замен в файлах
if ( arg0isRating()==1 )
    rating = WScript.Arguments(0);

// нужный текст
if ( rating.indexOf("x")==0 )
    var text_rate   = "{{" + rating + "%2s|--}}"
else
    var text_rate   = "{{" + rating + "%4d|----}}";
var text_color      = "{{c:" + rating + "}}";
var text_alpha      = "{{a:" + rating + "}}";
var text_option     = "\"xwnInCompany\": false";
if ( rating.indexOf("wn")>=0 )
    text_option     = "\"xwnInCompany\": true";

// заменяемый текст
var find_rate   = /{{x?(wn|eff)[^}]*}}/g;
var find_color  = /{{c:x?(wn|eff)[^}]*}}/g;
var find_alpha  = /{{a:x?(wn|eff)[^}]*}}/g;
var find_option = /"xwnInCompany"[\s\t]*:[\s\t]*(true|false)/g;

var fso = new ActiveXObject("Scripting.FileSystemObject");
var fileList = "";

// Если не переданы файлы или папки в качестве аргументов, меняем во всех *.xc файлах в папке со скриптом
if ( WScript.Arguments.length == arg0isRating() )
	replaceInFolder( WScript.ScriptFullName.substr(0, (WScript.ScriptFullName.length - WScript.ScriptName.length)) )
else  // если переданы аргументы, кроме рейтинга, меняем в них
    for ( var i=arg0isRating(); i<WScript.Arguments.length; i++)
        // если аргумент- файл, меняем в нем
        if ( fso.FileExists(WScript.Arguments(i)) )
            replaceInFile( WScript.Arguments(i) )
		// если аргумент- папка, меняем в файлах в ней
        else if ( fso.FolderExists(WScript.Arguments(i)) )
			replaceInFolder( WScript.Arguments(i) )

//WScript.Echo(fileList);
// выходим из программы
WScript.Quit();

// возвращаем 1, если первый аргумент- какой-то из поддерживаемых рейтингов
function arg0isRating() {
    if ( WScript.Arguments.length > 0 )
        for (var i=0; i<Aratings.length; i++)
            if ( WScript.Arguments(0)==Aratings[i] )
                return 1;
    return 0;
}

// функция замены рейтингов в файле
function replaceInFile(file_name) {
    var fs = WScript.CreateObject("Scripting.FileSystemObject");
    // если не найден файл, переходим к следующему
    if ( !fs.FileExists(file_name) )
        return;

    // Переносим исходный файл во временный
    var file_name_tmp = file_name+".tmp";
    if ( fs.FileExists(file_name_tmp) )
        fs.DeleteFile(file_name_tmp);
    fs.MoveFile(file_name, file_name_tmp);

    // создаем переменные для доступа к файлам
    var fold = fs.OpenTextFile(file_name_tmp,1,false,false);
    var fnew = fs.OpenTextFile(file_name,2,true,false);

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
    fs.DeleteFile(file_name_tmp);  // добавьте // вначале строки, чтобы оставались резервные копии файлов *.old
    fileList = fileList + "\n" + file_name;
}

// функция замены рейтингов в папке
function replaceInFolder(folder_name) {
	var folderObj = fso.GetFolder(folder_name);
	var folderC = new Enumerator(folderObj.files);
	// меняем во всех *.xc, *.XC, *.xvmconf и *.XVMconf файлах внутри папки
	for (; !folderC.atEnd(); folderC.moveNext())
		if ( /(\.xc|\.XC|\.xvmconf|\.XVMconf)$/.test(folderC.item()) )
			replaceInFile( ""+folderC.item() );
}