#include <regdef.h>
#include <sys/asm.h>
#include <sys/syscall.h>

	.text
	.align	2

	.globl	mips_sort
	.ent	mips_sort
mips_sort:
	.set	noreorder
	.cpload	t9
	.set	nomacro
	addiu	sp, sp, -24 //reservo 7 lugares de memoria y el sp apunta a la posicion 24.
	sw		fp, 20(sp)  //cargo fp en la posicion 20 en memoria. 
	move	fp, sp      //copio en fp el contenido del sp.
	.cprestore	0

	addiu	t0,a0,0 // t0 = a0 (direc del primer elemento del array)
	addiu	t1,a1,-1 // t1 = a1-1 (cantidad de elementos - 1: len-1)

	addiu 	t2,a0,0 // t2 = a0 (dirección de la primer posición tmb)

	addiu	t3,zero,0 // inicializo i
	addiu	t4,zero,0 // inicializo j
	addiu	t5,zero,0 // inicializo inicio array nuevamente

	addiu	t6,t1,1	//t6 = t1+1 (len)

	loop:   addiu	t4,t3,1	//j = i+1
			addiu   t3,t3,1 //i++
			bgt     t3,t1,done //si i > len - 1, salgo
			nop
			addiu   t5,t0,0	//t5 = t0 para no pisar la direc de t0
			lw		t7,0(t0) //cargo en t7 lo que hay en la direc guardada en t0
			addiu	t2,t0,4 //direc del siguiente elemento a t0
			addiu	t0,t0,4 //direc del siguiente elemento
			loop2:	lw		t8,0(t2) //cargo en t8 lo que hay en t2
					bgt		t7,t8,condicion //si t7 > t8 cambio de lugar
					nop
                    addiu	t2,t2,4 //sumo 4 a t2 para avanzar a la siguiente direc
					addiu   t4,t4,1 // j++
					bge		t4,t6,loop //si j >= len vuelvo al loop grande
					nop

					b 		loop2		//sino vuelvo al lopp chico	
					nop

			condicion:	sw	t8,0(t5) //swapeo t8 con t7
						sw	t7,0(t2) //swapeo t7 con t8
						lw	t7,0(t5) //actualizo el valor de t7 con lo que hay en la direc guardada por t5
						addiu t2,t2,4 //sumo 4 a t2 para avanzar a la siguiente direc
						addiu t4,t4,1 //j ++
						bge	  t4,t6,loop //si j >= len vuelvo al loop grande
						nop
						b loop2	//vuelvo al loop chico
						nop
	
	done:	lw		fp, 20(fp) //cargo en fp el contenido que hay en la pos fp+20 en memoria, o sea 0.
			addiu	sp, sp, 24 //vuelvo a poner en 0 a sp sacandole las 7 posiciones que reserve.
			jr		ra		   //retorno a la direccion guardada en ra.

	.end	mips_sort
