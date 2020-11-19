/* описания для main.c */
 .text
      .global Start_DSP
      .global InI
      .global InJ
      .global ArrayFirst
      .global ArraySecond


/* сегмент кода */
Start_DSP:



         MOVE 8,R1.L /*const*/
         MOVE 8,R3.L /*const*/

         MOVE 1,R0.L  /*I - not a const*/
         MOVE 1,R10.L  /*J - not a const*/

         DO 8,ii
                SUBL R0.L,R1.L,R2.L /*const J*/

                MOVE ArrayFirst, A3 /* указатель на первый элемент */

                MOVE ArrayFirst, A1

                CLRL R6.L
                CLRD R6.D

                CLR R8
                CLRL R8.L
                CLRD R8.D

                CLR R12
                CLRL R12.L
                CLRD R12.D


                DECL R0.L,R4.L

                DO R4,miss
                        DO 8, litle
                                (A1)+
                                (A3)+
                        litle: NOP
                miss: NOP

                DO R2,jj
                jj:  (A3)+


             /*   DO 8,mm         */
            /*            MOVE (A1), R6.L */
           /*             ADDL R8.L, R6.L, R8.L    */
           /*             (A1)+ */
           /*     mm: NOP    */


                MOVE (A1),R6.Q
               MAC18 R6.Q,R8.Q


                MOVE R8.L,(A3)

                ADDL 1,R0.L,R0.L

                MOVE 1,R10.L
        ii:NOP

        STOP




/* сегмент данных */
 .data
InI:  .word 1
InJ:  .word 1
ArrayFirst: .space 8*8*4, 0
ArraySecond: .space 8*8*4, 0
.end
