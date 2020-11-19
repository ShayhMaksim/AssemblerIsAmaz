/****************************************************************
 *                       RISC_DSP project                       *
 *                                                              *
 *    ������������� ������ � DSP-�����.                         *
 *    ������-�� � NVCom-01 ��� DSP-����, �� ������ � ����       *
 *    ��������� ���������. ������� ����� �������� ������ �      *
 *    ����� DSP0. �� �, ����������, � CPU-����� -               *
 *    ��� ���������� DSP-������                                 *
 *                                                              *
 ****************************************************************/

#include "nvcom_01.h"

// ����� ������ ��������� DSP-����
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



// ������������� ���� 0
      DCSR(0)  = 0;
      SR(0)    = 0;

// ����� � ������� ������ ���� 0
      PC(0)=((unsigned int)&Start_DSP - 0xb8440000)>>2;//(unsigned int)&PRAM)>>2;


// ����� � ������ ������� ������ ������� XRAM
// A0(0)=((unsigned int)&InA - 0xb8400000)>>2;//(unsigned int)&XRAM)>>2;


// ���������� �������� ������� ���������� � ������ DSP-����


// ��������� ���� 0
      DCSR(0) = 0x4000;

// ���� ��������� ���������
      while( !(QSTR_DSP & (1<<3)) ) ;

// �������� ���������
for (i=0;i<8;i++)
{
        for(j=0;j<8;j++)
        {
                ResultFirst[i][j]=ArrayFirst[i*8+j];
                ResultOld[i][j]=ArraySecond[i*8+j];
        }
}

// "������" �������� ��� ��������� ����������� �����, ����� ���������� �������� ����������
      while (1) ;
};
