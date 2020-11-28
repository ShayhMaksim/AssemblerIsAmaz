/* описания для main.c */
 .text
      .global Start_DSP
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




                MOVE (A1),R6.Q
               A81 R6.Q,R8

               DO 4,go
               go: (A1)+

                MOVE (A1),R6.Q
                A81 R6.Q,R12

                 ADDL R12.L,R8.L,R8.L

                MOVE R8.L,(A3)

                ADDL 1,R0.L,R0.L

                MOVE 1,R10.L
        ii:NOP

        STOP




/* сегмент данных */
 .data
ArrayFirst: .space 8*8*4, 0
ArraySecond: .space 8*8*4, 0
.end
