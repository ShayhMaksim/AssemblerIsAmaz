/****************************************************************
 *                       RISC_DSP project                       *
 *                                                              *
 *    Демонстрирует работу с DSP-ядром.                         *
 *    Вообще-то у NVCom-01 два DSP-ядра, но работа с ними       *
 *    полностью идентична. Поэтому здесь работаем только с      *
 *    ядром DSP0. Ну и, разумеется, с CPU-ядром -               *
 *    для управления DSP-ядрами                                 *
 *                                                              *
 ****************************************************************/

#include "nvcom_01.h"

// Адрес начала программы DSP-ядра
extern int Start_DSP;
extern int InI;
extern int InJ;
extern int ArrayFirst[8*8];
extern int ArraySecond[8*8];

main()
{
int i;
int j;
      for(i=0;i<8;i++)
      {
        for(j=0;j<8;j++)
        {
             ArrayFirst[i*8+j]=i-j+8;
             ArraySecond[i*8+j]=i-j+8;
        }
      }




   int ResultOld[8][8];
   int ResultFirst[8][8];

for (i=0;i<8;i++)
{
        for(j=0;j<8;j++)
        {
                ResultOld[i][j]=ArraySecond[i*8+j];
        }
}



// Останавливаем ядро 0
      DCSR(0)  = 0;
      SR(0)    = 0;

// Пишем в счётчик команд ядра 0
      PC(0)=((unsigned int)&Start_DSP - 0xb8440000)>>2;//(unsigned int)&PRAM)>>2;


// Пишем в первый сегмент памяти даннных XRAM
// A0(0)=((unsigned int)&InA - 0xb8400000)>>2;//(unsigned int)&XRAM)>>2;


// записываем значения входных переменных в память DSP-ядра


// Запускаем ядро 0
      DCSR(0) = 0x4000;

// ждем окончания процедуры
      while( !(QSTR_DSP & (1<<3)) ) ;

// забираем результат
for (i=0;i<8;i++)
{
        for(j=0;j<8;j++)
        {
                ResultFirst[i][j]=ArrayFirst[i*8+j];
                ResultOld[i][j]=ArraySecond[i*8+j];
        }
}

// "лишний" оператор для установки контрольной точки, чтобы посмотреть значения переменных
      while (1) ;
};
