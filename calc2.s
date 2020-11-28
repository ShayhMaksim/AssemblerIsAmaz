/* описания для main.c */
 .text
      .global Start_DSP
      .global ArrayFirst
      .global ArraySecond


/* сегмент кода */
Start_DSP:



         MOVE 8,R16.L /*const*/
         MOVE 8,R3.L /*const*/

         MOVE 1,R10.L  /*I - not a const*/
        ; MOVE 1,R10.L  /*J - not a const*/

         DO 8,ii
                SUBL R10.L,R16.L,R14.L /*const J*/

                MOVE ArrayFirst, A3 /* указатель на первый элемент */
                MOVE ArrayFirst, A1
                MOVE ArrayFirst, AT

                MOVE 1,IT

                CLRL R0.L
                CLRD R0.D

                CLR R8
                CLRL R8.L
                CLRD R8.D

                CLR R12
                CLRL R12.L
                CLRD R12.D

                DECL R10.L,R4.L

                DO R4,miss
                        DO 8, litle
                                (AT)+IT
                                (A3)+
                                (A1)+
                        litle: NOP
                miss: NOP

                DO R14,jj
                jj:  (A3)+


             ; Ниже закомментированный код является альтернативым решением
             ;   CLRL R0.L
             ;   MOVE (A1),R12.Q

             ;  MOVE 4,IT
             ;  (AT)+IT
             ;   MOVE (AT),R0.Q

             ;  ALL4 R12.Q,R0.Q,R8.Q
             ;  ALL2 R8.D,R9.D,R18.D
             ;  ADDL R18.L,R19.L,R20.L
             ;  MOVE R20.L,(A3)

             ; Текущий варинт варинт
             CLRD R20.D
             CLRD R12.D
             MOVE 4,IT
             MOVE (AT)+IT,R0.Q
             ; Ниже представлена параллельная операция

             DO 2, Last
             A81 R0.Q,R12 (AT)+IT,R0.Q
             ADDL R12.L,R20.L,R20.L
             Last: NOP
             MOVE R20.L,(A3)

                ADDL 1,R10.L,R10.L

               ; MOVE 1,R10.L
        ii:NOP

        STOP




/* сегмент данных */
 .data
ArrayFirst: .space 8*8*4, 0
ArraySecond: .space 8*8*4, 0
.end
