#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h> 
#include <windows.h>
#include <math.h>
#include <curl/curl.h>

//libcurldll.a - это надо добавить в линковщик, если не взлетает библиотека curl
 


struct BASE{ //база статистики игрока
char tank[30];
char lname[30];
struct BASE *same[4]; //ссылки на похожие танки
float same_rate[4]; //похожесть
float koef[8]; //какая-то фигня, не реализовано
float ABC[4];
struct TANK *link; //ссылка на танк в базе танков
long int battles;
long int wins;
float rate;
float rate_plus; //скорректированный винрейт по танку
float damage;
int surv;
float frags;
int stack;
int spotted;
}base[300];

struct TANK{ //база танков
char name[30];
int country;
int level;
int type;
long int hp;
int speed;
int turn;
int see;
float acc;
float dam55;
float dam5;
int len;
}tanks[500];


char *Rus(const char *text);
char *reader(char *str,char *result, char c);
void deleter(char *str);
float av_rate(void);
float av_rate_plus(void);
int first_del(int battles);
int search(struct BASE *current);
float generate(struct BASE *current, int step);
float damage(struct BASE *current);
float cutter(struct BASE *current);
void matrix(struct BASE *current);
char *lower(char *str);



float generate(struct BASE *current, int step){ //рекурсивный движок 
int i;int m;
float rate=cutter(current);
current->stack=1;

printf("\nBegin for %s	%f	%f	%f",current->tank,current->rate,current->link->acc,damage(current));
//getchar();

if(current->rate<45)current->rate_plus=current->rate;
if(current->rate_plus){printf("\nReturn good rate %f",current->rate_plus);current->stack=0;return current->rate_plus;} //проверка вдруг танк уже анализировали


m=search(current); //найти похожие танки, m - их количество


if((damage(current)*(current->link->level+10)+current->link->acc*(21-current->link->level))/31>1-0.1*step || (cutter(current->same[0])+cutter(current->same[1])+cutter(current->same[2]))/m>current->rate){ //если танку в целом верим или на похожих стата не хуже
	current->rate_plus=cutter(current); //немного порезать стату по дамагу
	printf("\nReturn cutted rate %f",current->rate_plus);
	current->stack=0; 
	return current->rate_plus;} //и успокоиться

printf("\nSame tanks:  ");
for(i=0;i<m;i++)printf("%s %f,	",current->same[i]->tank,current->same_rate[i]);
if(!m)printf("nobody");


for(i=0;i<m;i++){
if(!current->same[i])break;
printf("\nSee other tank %s	%f",current->same[i]->tank, current->same[i]->rate);
if(current->same[i]->rate_plus){printf("\nAdd good rate %f",current->same[i]->rate_plus);rate+=current->same[i]->rate_plus;} //складывать похожие танки, если их уже посчитали
else if((damage(current)*(current->link->level+10)+current->link->acc*(21-current->link->level))/31>1-0.1*step){printf("\nAdd cutted rate %f",cutter(current->same[i]));rate+=cutter(current->same[i]);} //если не посчитали и верим их стате - тоже складывать, но перед этим чуток резать
else {printf("\nCheck other tank");rate+=generate(current->same[i],step+1);} //если не верим - искать глубже
}

printf("\nReturn middle rate of %s %f",current->tank, (float)rate/(i+1));
current->stack=0;

current->rate_plus=(float)rate/(i+1);
return (float)rate/(i+1); //вернуть усредненную стату по сабжу и похожим на него танкам
}

float cutter(struct BASE *current){ //резалка по дамагу
float rate;
if(!current)return 0;

rate=(current->rate-45)*(damage(current)*(current->link->level+10)+current->link->acc*(21-current->link->level))/31+45;
if(rate>current->rate)return current->rate;
else return rate;
}



float damage(struct BASE *current){ //считалка достаточности дамага
float hp=current->link->hp;

//if(current->link->level<3)hp=hp*1.5;

if(current->link->dam55)return current->damage/(current->link->dam55+current->link->dam5*(current->rate-55)/5);

if(current->link->type==1)return current->damage/(hp*(20+current->rate-55)/20);
if(current->link->type==2)return current->damage/(hp*1.2*(20+current->rate-55)/20);
if(current->link->type==3)return current->damage/(hp*3.2*(20+current->rate-55)/20);
if(current->link->type==4)return current->damage/(hp*0.7*(20+current->rate-55)/20);
if(current->link->type==5)return current->damage/(hp*(20+current->rate-55)/20);
return 0;
}


static size_t write_data(void *ptr, size_t size, size_t nmemb, void *stream)
{
  int written = fwrite(ptr, size, nmemb, (FILE *)stream);
  return written;
}

int main(int argc, char *argv[]){ //непонятная функция, в основном занимается скачиванием статы с сайта и ее парсингом
  setlocale(LC_ALL,"ru_RU.UTF-8");
  FILE *fp=0, *fp2=0;
  long int i,j,n;
  char str[50];
  char str2[256];
  char file[300][200];
  int f[300];
  char *p=0;
  char result[50];
  char nik[30];
  char name[200]="http://worldoftanks.ru/community/accounts/";
  char url[200]="http://worldoftanks.ru/uc/accounts/named/";

  CURL *curl_handle;
  static const char *headerfilename = "head.out";
  FILE *headerfile;
  static const char *bodyfilename = "body.out";
  FILE *bodyfile;

  //printf("\n%s",argv[1]);
  //getchar();
  nik[0]=0;
  if(argc>1)
    strcat(nik,argv[1]);
  else{
    printf("\nEnter your WoT account name :	");
    scanf("%s",nik);}
  strcat(url,nik);
  strcat(url,"/");

 curl_global_init(CURL_GLOBAL_ALL);
 
  /* инициализация сессии curl */ 
  curl_handle = curl_easy_init();
 
  /* установка URL */ 
  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
 

  /* нам не нужено уведомление о прогрессе */ 
  curl_easy_setopt(curl_handle, CURLOPT_NOPROGRESS, 1L);
 
  /* посылать все данные в эту функцию  */ 
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, write_data);
 
  /* открытие файлов */ 
  headerfile = fopen("1.txt","w");
  if (headerfile == NULL) {
    curl_easy_cleanup(curl_handle);
    return -1;
  }
 
  /* помещать заголовки в этот файловый дескриптор */ 
  curl_easy_setopt(curl_handle,   CURLOPT_WRITEHEADER, headerfile);
  /*
   * Обратите внимание, если вы хотите выводить не в stdout,
   * вам необходимо использовать опцию CURLOPT_WRITEDATA.  */ 
 
  /* получить! */ 
  curl_easy_perform(curl_handle);
 
    /* закрытие файлового дескриптора */ 
  fclose(headerfile);
 
  /* очистка */ 
  curl_easy_cleanup(curl_handle);

 
if((fp=fopen("1.txt","r+b"))==NULL){
   printf("\nERROR while loading file.");getchar();
   exit(0);}




for(j=0;j<20;j++){
if(!fgets(str2,200,fp))exit(0);
p=strstr(str2,"accounts/");
if(p)break;}
p+=9;

for(i=0;i<15 && isdigit(*(p+i));i++);
*(p+i)='\0';


strcat(name,p);
strcat(name,"/api/1.8/?source_token=WG-WoT_Assistant-test");





  /* инициализация сессии curl */ 
  curl_handle = curl_easy_init();
 
  /* установка URL */ 
  curl_easy_setopt(curl_handle, CURLOPT_URL, name);
 


  /* нам не нужено уведомление о прогрессе */ 
  curl_easy_setopt(curl_handle, CURLOPT_NOPROGRESS, 1L);
 
  /* посылать все данные в эту функцию  */ 
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, write_data);
 
  /* открытие файлов */ 
  headerfile = fopen("1.txt","w");
  if (headerfile == NULL) {
    curl_easy_cleanup(curl_handle);
    return -1;
  }
  bodyfile = fopen("stata.txt","w");
  if (bodyfile == NULL) {
    curl_easy_cleanup(curl_handle);
    return -1;
  }
 
  /* помещать заголовки в этот файловый дескриптор */ 
  curl_easy_setopt(curl_handle,   CURLOPT_WRITEHEADER, headerfile);
  curl_easy_setopt(curl_handle,   CURLOPT_WRITEDATA, bodyfile);
  /*
   * Обратите внимание, если вы хотите выводить не в stdout,
   * вам необходимо использовать опцию CURLOPT_WRITEDATA.  */ 
 
  /* получить! */ 
  curl_easy_perform(curl_handle);
 
    /* закрытие файлового дескриптора */ 
  fclose(headerfile);
 
  /* очистка */ 
  curl_easy_cleanup(curl_handle);

  fclose(fp);
  //  fclose(headerfile);
  fclose(bodyfile);

  if((fp=fopen("stata.txt","r+b"))==NULL){
    printf("\nERROR while loading file.");getchar();
    exit(0);}


  if((fp2=fopen("base.csv","r+b"))==NULL){
    printf("\nERROR while loading file2.");getchar();
    exit(0);}




  for(i=0;i<500;i++){
    if(!fgets(str2,200,fp2))break;
    p=str2;

    p=reader(p, result,';');

if(!strcmp(result, "СССР"))tanks[i].country=1;
if(!strcmp(result, "Германия"))tanks[i].country=2;
if(!strcmp(result, "США"))tanks[i].country=3;
if(!strcmp(result, "Китай"))tanks[i].country=4;
if(!strcmp(result, "Франция"))tanks[i].country=5;
if(!strcmp(result, "Британия"))tanks[i].country=6;

//printf("\n%s %d",Rus(result),tanks[i].country);

p=reader(p, result,';');

if(!strcmp(result, "Тяжёлый танк"))tanks[i].type=1;
if(!strcmp(result, "ПТ-САУ"))tanks[i].type=2;
if(!strcmp(result, "САУ"))tanks[i].type=3;
if(!strcmp(result, "Лёгкий танк"))tanks[i].type=4;
if(!strcmp(result, "Средний танк"))tanks[i].type=5;

    //printf("\n%s %d",Rus(result),tanks[i].type);

    p=reader(p, result,';');
    tanks[i].level=atof(result);

    //printf("\n%s %d",Rus(result),tanks[i].level);

    p=reader(p, result,';');
    memcpy(tanks[i].name, Rus(result), 30);
	lower(tanks[i].name);

    //printf("\n%d %s",i, tanks[i].name);

    p=reader(p, result,';');
    tanks[i].hp=atof(result);

    //printf("\n%d",tanks[i].hp);

    p=reader(p, result,';');
    tanks[i].speed=atof(result);

    //printf("\n%d",tanks[i].speed);

    p=reader(p, result,';');
    tanks[i].turn=atof(result);

    //printf("\n%d",tanks[i].turn);

    p=reader(p, result,';');
    tanks[i].see=atof(result);

    //printf("\n%d",tanks[i].see);

    p=reader(p, result,';');
    tanks[i].acc=atof(result);
//	printf("\n%f",tanks[i].acc);

    p=reader(p, result,';');
    tanks[i].dam55=atof(result);

    p=reader(p, result,';');
    tanks[i].dam5=atof(result);

    tanks[i].len=strlen(tanks[i].name);

    //printf("\n%d	%s	%f	%f",i,tanks[i].name,tanks[i].dam55,tanks[i].dam5 );

  }
//getchar();

  for(j=0;j<300;j++){

    for(i=0;i<300;i++){
      if(!fgets(str2,200,fp)){j=300;break;}
      p=strstr(str2,"localized_name");
      if(p)break;}
    if(j==300)break;

    p+=18;
    for(i=0;i<30 && *(p+i)!='"';i++);
    *(p+i)='\0';
    strcat(base[j].lname,p);


    fgets(str2,200,fp);
    p=strstr(str2,"name");
    p+=8;
    for(i=0;i<30 && *(p+i)!='"';i++);
    *(p+i)='\0';
    strcat(base[j].tank,p);
    lower(base[j].tank);

	if(!strcmp(base[j].tank,"a-20"))break;
	if(!strcmp(base[j].tank,"m103"))break;


    for(n=0;n<500;n++){
      //	printf("\n%s1	%s1",base[j].tank,tanks[n].name);
      //	getchar();
      if(!strlen(tanks[n].name)){printf("\nNot found %d	%s	%s	%d	%d",n,base[j].tank,tanks[n].name,strlen(tanks[n].name), strlen(base[j].tank));base[j].link=0;break;}
      if(!strcmp(base[j].tank, tanks[n].name)){base[j].link=&tanks[n];break;}}

    fgets(str2,200,fp);
    
    fgets(str2,200,fp);
    p=strstr(str2,"damageDealt");
    p+=14;
    for(i=0;i<30 && *(p+i)!=',';i++);
    *(p+i)='\0';
    base[j].damage=atof(p);
    
    fgets(str2,200,fp);
    
    fgets(str2,200,fp);
    p=strstr(str2,"battle_count");
    p+=15;
    for(i=0;i<30 && *(p+i)!=',';i++);
    *(p+i)='\0';
    base[j].battles=atoi(p);
    if(base[j].battles<100){base[j].link=0;break;}
    base[j].damage=base[j].damage/base[j].battles;

    fgets(str2,200,fp);
    fgets(str2,200,fp);
    fgets(str2,200,fp);

    fgets(str2,200,fp);
    p=strstr(str2,"win_count");
    p+=12;
    for(i=0;i<30 && *(p+i)!=',';i++);
    *(p+i)='\0';
    base[j].wins=atoi(p);
    base[j].rate=(float)base[j].wins/base[j].battles*100;

   // printf("\n %d %s %d %d %f %f",i, base[j].tank, base[j].battles, base[j].wins, base[j].rate, base[j].damage);
    //    getchar();
  }




  printf("\nLoading of stata is complite");
  for(i=0;i<500000000;i++);

  if(!first_del(1000)){printf("\nNot enought battles");getchar();exit(0);}


  //for(i=0;i<300;i++){printf("\n%s	%f	%f	%f	%f	%f",base[i].tank,base[i].rate,base[i].damage,base[i].link->dam55,base[i].link->dam5,damage(&base[i]));
  //getchar();}




  for(i=0;i<300;i++){

//	  if(i==5){getchar();getchar();}
//	  if(i==15){getchar();getchar();}
//	  if(i==30){getchar();getchar();}
    if(!base[i].link)continue;
    printf("\n");
    base[i].rate_plus=generate(&base[i],1);
  }









  printf("\n\n");
  
  printf("\nBegin  winrate is: %f\n",av_rate());
  printf("\nBegin rate	Corrected rate	Ka		Kd	Tank\n");

  for(i=0;i<300;i++)if(base[i].link && base[i].rate)printf("\n%f	%f	%f	%f %s", base[i].rate, base[i].rate_plus, base[i].link->acc, damage(&base[i]), base[i].tank);

  printf("\n\nCorrected winrate is: %f",av_rate_plus());

  printf("\n\nAll done");
  getchar();
  getchar();

  fclose(fp);
  fclose(fp2);
  return 1;
}


    char *Rus(const char *text){
char bufRus[256];
        CharToOem(text,bufRus);
        return bufRus;
    }


	char *reader(char *str, char *result, char c){ //парсер
int i=0;
while(*(str+i)!=c){*(result+i)=*(str+i);i++;}
*(result+i)='\0';

return str+i+1;
	}

	void deleter(char *str){ //что-то удаляет, вероятно находит и ставит концы строк
int i=30;
while(*(str+i)!=13 && i>0)i--;
*(str+i)='\0';
}

	float av_rate(void){ //считает средний винрейт
long int i,n=0,m=0;


for(i=0;i<300;i++){
if(!base[i].link)continue;
n+=base[i].battles;
m+=base[i].wins;}

return (float)m/n*100;
}

	float av_rate_plus(void){ //считает средний скорректированный винрейт
long int i,n=0,m=0;
long int b7=0,b8=0,b9=0;
float rate=0;

for(i=0;i<300;i++){
if(!base[i].link)continue;
n+=base[i].battles;

if(base[i].link->level>6)b7+=base[i].battles;
if(base[i].link->level>7)b8+=base[i].battles;
if(base[i].link->level>8)b9+=base[i].battles;

m+=base[i].rate_plus*base[i].battles/100;}

if((float)m/n*100>53 && b7<300)return 53;
if((float)m/n*100>55 && b8<300)return 55;
if((float)m/n*100>57 && b9<300)return 57;

return (float)m/n*100;
}

	int first_del(int battles){ //удаляет 1000 боев с херовой статой
long int i,min;
float min_rate;

	while(battles>0){
		min_rate=1000;
		for(i=0;i<300;i++)if(base[i].rate<min_rate && base[i].link && (base[i].link->level<8 && base[i].link->type!=3 || base[i].link->level<5 && base[i].link->type==3)&& base[i].rate<53){min_rate=base[i].rate;min=i;}
		if(min_rate==1000)return 1;		
		base[min].link=0;
		battles-=base[min].battles;
	//	printf("\n%s %f	%d Deleted",base[min].tank, base[min].rate, base[min].battles);
		}
return 1;
}

	int search(struct BASE *current){ //ищет похожие танки
long int i,j, max;
float same[300];
float max_same;

for(i=0;i<300;i++){
if(!base[i].link)continue;
same[i]=0;
if(current->link->type==base[i].link->type)same[i]++;
else if(current->link->type==3 || base[i].link->type==3)same[i]-=2;

if(current->link->type==4 && base[i].link->type!=4 && (base[i].link->type!=5 || base[i].link->level<8))same[i]--;

same[i]+=1-fabs(current->link->level-base[i].link->level)*0.1;
same[i]+=1-fabs(current->link->hp-base[i].link->hp)/(current->link->hp+base[i].link->hp)*2;
same[i]+=1-fabs(current->link->speed-base[i].link->speed)/(current->link->speed+base[i].link->speed)*2;
same[i]+=1-fabs(current->link->turn-base[i].link->turn)/(current->link->turn+base[i].link->turn)*2;
same[i]+=1-fabs(current->link->see-base[i].link->see)/(current->link->see+base[i].link->see)*2;
same[i]+=current->link->acc;
same[i]=same[i]/7;


//printf("\n%s	%s				%f", base[current].link->name, base[i].link->name, same[i]);
}


for (j=0;j<4;j++){
max_same=-1000;
for (i=0;i<300;i++)if(same[i]>max_same && base[i].link && &base[i]!=current && !base[i].stack && same[i]>0.5){max_same=same[i];max=i;}
if(max_same==-1000){current->same[j]=0;current->same_rate[j]=0;break;}
current->same[j]=&base[max];
current->same_rate[j]=max_same;
same[max]=0;
}

current->koef[3]=1;
return j;
}


	char *lower(char *str){
		while(*str){*str=tolower(*str);str++;}
		return str;
	}