// Скрипт для замены одного представления рейтинга на другое

// Искомый текст и текст замены
var text_sample1="{{eff:4}}";
var text_replace1="{{xeff}}";
var text_sample2="{{eff}}";
var text_replace2="{{xeff}}";
var text_sample3="{{c:eff}}";
var text_replace3="{{c:xeff}}";

var i=0;
do {
	// Имя файла берём из аргумента или задаем XVM.xvmconf, если аргумент пуст
	if (WScript.Arguments.length<1) {
		var file_name="XVM.xvmconf";
	}
	else {
		file_name=WScript.Arguments(i);
	}

	var fso=WScript.CreateObject("Scripting.FileSystemObject");
	if (!fso.FileExists(file_name))
	  break;
	// Переносим исходный файл во временный
	var file_name_tmp=file_name+".tmp";
	if(fso.FileExists(file_name_tmp))
	  fso.DeleteFile(file_name_tmp);
	fso.MoveFile(file_name,file_name_tmp);

	var fo=fso.OpenTextFile(file_name_tmp,1,false,false);
	var fr=fso.OpenTextFile(file_name,2,true,false);

	// Выполняем замену текста в каждой строке
	var re1=new RegExp(text_sample1);
	var re2=new RegExp(text_sample2);
	var re3=new RegExp(text_sample3);

	while(!fo.AtEndOfStream){
	  var line=fo.ReadLine();
	  var line_replace=line.replace(re1,text_replace1);
	  line_replace=line_replace.replace(re1,text_replace1);
	  line_replace=line_replace.replace(re2,text_replace2);
	  line_replace=line_replace.replace(re2,text_replace2);
	  line_replace=line_replace.replace(re3,text_replace3);
	  line_replace=line_replace.replace(re3,text_replace3);
	  fr.WriteLine(line_replace);
	}
	fo.Close();
	fr.Close();
	// Удаляем исходный файл
	fso.DeleteFile(file_name_tmp);
	
	i++
} while (i<WScript.Arguments.length);