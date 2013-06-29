################
# 0. Изменения #
################

В версии 0.4.0 добавлен пинг серверов WoT (показывается в окне логина)

В описании изменены следующие пункты:

  2. Сменилась точка монтирования с res_mods/.stat на res_mods/xvm/.xvmfs
  3. Добавилось описание нового параметра.

Добавлен п.4 - примеры использования.

#######################
# 1. Краткое описание #
#######################

XvmFS - это виртуальная файловая система на основе FUSE. Используется для 
отображения статистики игроков в моде XVM.

XVM - популярный мод для многопользовательской онлайновой игры 'World of Tanks'

XVM, XVM-STAT и XvmFS распространяются по свободной лицензии GNU GPL v3.  
Исходный код и готовый мод доступен по адресу http://code.google.com/p/wot-xvm/ 
Установка и настройка XVM подробно описывается на официальном сайте проекта.  
Подразумевается, что XVM уже установлен и настроен.

############################
# 2. Установка и настройка #
############################

Для работы XvmFS требуется:
 - Поддержка FUSE со стороны ядра. Работает на ядрах 2.4.X и 2.6.X, включено по 
   умолчанию в большинстве современных дистрибутивов.

 - Интерпретатор Python версии 2.X. Также включен в базовую версию большинства 
   дистрибутивов. Проверена работа XvmFS на Python 2.6.5 и 2.7.3

 - Библиотеки FUSE для Python. Нужно установить вручную. См. примеры установки 
   для различных операционных систем.

   Debian, Ubuntu:

   $ sudo apt-get install python-fuse

   RedHat, CentOS:

   # yum install fuse-python

   ArchLinux:

   # pacman -S python2-fuse

   Gentoo:

   # emerge -av dev-python/fuse-python

Начиная с версии 0.4.0, XvmFS должен быть смонтирован в каталог 
res_mods/xvm/.xvmfs , которая находится в основном каталоге игры. Если этого 
каталога не существует, его необходимо создать:

$ cd ~/.wine/drive_c/Games/World_of_Tanks
$ mkdir -p res_mods/xvm/.xvmfs

Если игра установлена на раздел NTFS, то для корректной работы XVM требуется 
указать путь к папке с игрой, как он будет выглядеть для самой игры, запущенной 
под WINE. Например, если игра установлена в папку
  /home/user/wine-wot/drive_c/World_of_Tanks
тогда xvmfs надо запускать с параметром -o game_dir='C:\World_of_Tanks' Если же 
игра установлена на линуксовый раздел (ext2, ext3, reiserfs и т.д.), то опцию 
'-o game_dir=...' можно не указывать.

Опция '-o log_dir=...' указывает, в каком каталоге создавать лог-файлы. По 
умолчанию логи пишутся в текущий каталог.

Для работы XvmFS требуется несколько файлов с настройками:
 - Настройки лаунчера World of Tanks - файл называется 'WOTLauncher.cfg' и 
   находится в основной папке с игрой.

 - Настройки XVM-STAT - файл 'xvm-stat.exe.config' от базовой версии xvm-stat, 
   распространяется вместе с XvmFS

 - Путь к папке 'res_mods' - используется для поиска остальных конфигурационных 
   файлов. В текущей версии используется для доступа к 'res/scripts_config.xml'.

По умолчанию считается, что оба файла и папка 'res_mods' находятся в текущем 
каталоге.  Если это не так, то местонахождение этих файлов можно указать опциями 
'-o wot_cfg=...', '-o xvm_cfg=...' и '-o res_mods=...' соответственно.

##########################
# 3. Использование XvmFS #
##########################

Распакуйте архив xvmfs-X.X.X.tar.gz в папку с игрой:
    $ cd ~/.wine/drive_c/Games/World_of_Tanks
    $ tar -zxf xvmfs-*.tar.gz

Общая схема использования:
    $ ./xvmfs [точка монтирования] [параметры]

Точка монтирования должна указывать на каталог 'res_mods/xvm/.xvmfs', 
находящийся в основной папке игры. После успешного монтирования в этом каталоге 
будет виден файл 'README', доступный только на чтение.

Описание параметров:

-h, --help
    Показывает краткую справку о параметрах и способах запуска.

-o opt,[opt...]
    Список опций монтирования. Описание отдельных опций см.ниже.

-o xvm_cfg=FILE
    Файл с настройками xvm-stat. По умолчанию называется 'xvm-stat.exe.config' и 
    ищется в текущем каталоге.

-o wot_cfg=FILE
    Файл с настройками лаунчера World of Tanks. По умолчанию называется 
    'WOTLauncher.cfg' и ищется в текущем каталоге. При поиске не учитывается 
    регистр в имени файла (только файла, а не содержащего его каталога).

-o game_dir=DIR
    Полный путь к папке с игрой, как он должен быть виден для программы, 
    запущенной под WINE. Например, если игра установлена в 
    '~/.wine/drive_c/Games/World_of_Tanks', то значение DIR должно быть 
    'C:\Games\World_of_Tanks'.

-o log_dir=DIR
    Каталог, в котором будут созданы лог-файлы XvmFS.  По умолчанию логи пишутся 
    в текущий каталог.

-o res_mods=DIR
    Путь к папке 'res_mods', находящейся в основной папке игры. Используется для 
    определения пути к игровым конфигурационным файлам и точки монтирования по 
    умолчанию.

-o debug
    Включить отладочные сообщения в лог-файлы.

При запуске XvmFS пытается прочитать настройки по очереди из следующих файлов:

    /etc/default/xvmfs
    /etc/xvm/xvmfs.conf
    /etc/xvmfs.conf
    ~/.xvmfsrc

Опции, указанные в командной строке, имеют наивысший приоритет.  Все доступные 
опции указаны в файле 'default.xvmfsrc'.

##############
# 4. Примеры #
##############

После того, как XvmFS смонтирована в нужный каталог, можно запускать игру точно 
так же, как это делалось ранее. При перезапуске игры дополнительно делать ничего 
не надо. Рекомендуется размонтировать XvmFS после того, как Вы закончили играть.

Вариант 1: установка в папку с игрой.

    $ cd ~/.wine/drive_c/Games/World_Of_Tanks
    $ tar -zxf ~/xvmfs-X.X.X.tar.gz
    $ mkdir -p res_mods/xvm/.xvmfs

    Показ справки:

    $ ./xvmfs --help

    Обычный запуск XvmFS:

    $ ./xvmfs

    Запись логов в каталог /tmp/xvm:

    $ ./xvmfs -o log_dir=/tmp/xvm

    Опции можно указывать в одном параметре через запятую:

    $ ./xvmfs -o debug,log_dir=/tmp/xvm,game_dir='С:\WOT'

    Завершение работы с XvmFS:

    $ fusermount -u res_mods/xvm/.xvmfs

#############

Вариант 2: установка в произвольную папку

    $ mkdir ~/xvm
    $ cd ~/xvm
    $ tar -zxf ~/xvmfs-X.X.X.tar.gz
    $ cd ~/.wine/drive_c/Games/World_of_Tanks
    $ mkdir -p res_mods/xvm/.xvmfs

    Запуск из папки с игрой:

    $ ~/xvm/xvmfs -o xvm_cfg=~/xvm/xvm-stat.exe.config

    Или из папки установки:

    $ cd ~/xvm
    $ ./xvmfs -o res_mods=~/.wine/drive_c/Games/World_of_Tanks/res_mods,\
    > wot_cfg=~/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg

Использование файла настроек XvmFS:

    $ cat << EOF > ~/.xvmfsrc
xvm_cfg = ~/xvm/xvm-stat.exe.config
wot_cfg = ~/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg
res_mods = ~/.wine/drive_c/Games/World_of_Tanks/res_mods
log_dir = /tmp
EOF

    $ cd ~/.wine/drive_c/Games/World_of_Tanks
    $ ~/xvm/xvmfs

###############

Вариант 3: монтирование через fstab на примере Ubuntu 12.04

Добавляем пользователя в группу fuse:
    $ whoami
    user
    $ sudo usermod -a -G fuse user

После этого надо перелогиниться, чтобы изменения вступили в силу.
Проверяем, что мы добавлены:
    $ id
    uid=1001(user) gid=1001(user) группы=1001(user),4(adm),24(cdrom),
    27(sudo),30(dip),46(plugdev),104(fuse),109(lpadmin),124(sambashare)

Добавляем xvmfs в системную папку:
    $ cd ~/xvm
    $ sudo mkdir /usr/lib/xvmfs
    $ sudo cp xvmfs xvm_utils.py xvm_bxml.py /usr/lib/xvmfs
    
Создаем ссылки на исполняемые файлы:
    $ cd /usr/local/bin
    $ sudo ln -s /usr/lib/xvmfs/xvmfs
    $ sudo ln -s xvmfs mount.xvmfs

Создаем папку для логов:
    $ cd /var/log
    $ sudo bash -c 'mkdir xvm; chown root:fuse xvm; chmod g+w xvm'

Создаем папку с настройками:
    $ sudo mkdir /etc/xvm
    $ cd /etc/xvm
    $ sudo cp ~/xvm/xvm-stat.exe.config .
    $ cat << EOF | sudo tee xvmfs.conf
xvm_cfg = /etc/xvm/xvm-stat.exe.config
wot_cfg = /home/user/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg
res_mods = /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods
log_dir = /var/log/xvm
EOF

В файле /etc/fuse.conf раскомментируем опцию 'user_allow_other':
    $ sudo nano /etc/fuse.conf

Добавляем запись в fstab:
    $ sudo nano -w /etc/fstab
xvmfs /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/xvm/.xvmfs fuse.xvmfs ro,noauto,users,allow_other 0 2

Настройка завершена. Монтируем:
    $ mount xvmfs

Проверяем:
    $ mount | grep xvmfs
    xvmfs on /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/xvm/.xvmfs
    type fuse.xvmfs (ro,noexec,nosuid,nodev,allow_other,user=user)

Размонтируем:
    $ umount xvmfs

##########################
# 5. Диагностика проблем #
##########################

Если статисика в игре не отображается, в логах должны быть сообщения о том, что 
и как происходит. Если в логах попадаются сообщения с 'HTTP Error' - то скорее 
всего, проблема в большой нагрузке на внешний прокси-сервер, к которому идёт 
обращение из XvmFS. Самостоятельно исправить это никак не получится.

Для более подробного логирования XvmFS можно запустить с опцией '-o debug'.

Перед первым запуском убедитесь, что основной скрипт xvmfs доступен к 
исполнению.  Установить права на исполнение файла можно так:

$ chmod +x xvmfs

