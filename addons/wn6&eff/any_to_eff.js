// Скрипт для замены одного представления рейтинга на другое

// нужный текст
var text_replace1="{{eff:4}}";
var text_replace2="{{c:eff}}";
var text_replace3="{{a:eff}}";
var text_replace4="\"xwnInCompany\": false";

var text_samples1 = [    // заменяемый текст
                        "{{wn}}",
                        "{{wn6}}",
                        "{{wn8}}",
                        "{{eff:4}}",
                        "{{eff}}",
                        "{{xeff}}",
                        "{{xwn}}",
                        "{{xwn6}}",
                        "{{xwn8}}"
                    ];
var text_samples2 = [    // заменяемый текст
                        "{{c:wn}}",
                        "{{c:wn6}}",
                        "{{c:wn8}}",
                        "{{c:eff}}",
                        "{{c:xeff}}",
                        "{{c:xwn}}",
                        "{{c:xwn6}}",
                        "{{c:xwn8}}"
                    ];
var text_samples3 = [    // заменяемый текст
                        "{{a:wn}}",
                        "{{a:wn6}}",
                        "{{a:wn8}}",
                        "{{a:eff}}",
                        "{{a:xeff}}",
                        "{{a:xwn}}",
                        "{{a:xwn6}}",
                        "{{a:xwn8}}"
                    ];
var text_samples4 = [    // заменяемый текст
                        "\"xwnInCompany\": true",
                        "\"xwnInCompany\":\ttrue",
                        "\"xwnInCompany\": false",
                        "\"xwnInCompany\":\tfalse"
                    ];

var i=0;
do {
    // Имя файла берём из аргумента или задаем XVM.xc, если аргумент пуст
    if (WScript.Arguments.length<1) {
        var file_name="XVM.xc";
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
    // читаем файл, пока не закончится
    while(!fo.AtEndOfStream){
      var line=fo.ReadLine();
      var line_replace=line;
      // меняем первый макрос
      for ( var j = 0; j < text_samples1.length; j++) {
          var re=new RegExp(text_samples1[j]);
          line_replace=line_replace.replace(re,text_replace1);
          line_replace=line_replace.replace(re,text_replace1);
      }
      // меняем второй макрос
      for ( j = 0; j < text_samples2.length; j++) {
          re=new RegExp(text_samples2[j]);
          line_replace=line_replace.replace(re,text_replace2);
          line_replace=line_replace.replace(re,text_replace2);
      }
      // меняем третий макрос
      for ( j = 0; j < text_samples3.length; j++) {
          re=new RegExp(text_samples3[j]);
          line_replace=line_replace.replace(re,text_replace3);
          line_replace=line_replace.replace(re,text_replace3);
      }
      // меняем четвертый макрос
      for ( j = 0; j < text_samples4.length; j++) {
          re=new RegExp(text_samples4[j]);
          line_replace=line_replace.replace(re,text_replace4);
          line_replace=line_replace.replace(re,text_replace4);
      }
      fr.WriteLine(line_replace);
    }
    fo.Close();
    fr.Close();
    // Удаляем исходный файл
    fso.DeleteFile(file_name_tmp);

    i++
} while (i<WScript.Arguments.length);