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
	sw		fp, 20(sp) //cargo fp en la posicion 20 en memoria. 
	move	fp, sp    //copio en fp el contenido del sp.
	.cprestore	0

	addu	t0,zero,a0 //guardo el primer elemento del array en t0
	addu	t1,zero,a1 //guardo el tamanio del array en t1

	addiu 	t2,a0,4 //guardo el segundo elemento del array en t2

	addiu	t3,zero,0 //inicializo i
	addiu	t4,zero,0 //inicializo j
	addiu	t5,zero,0 //inicializo tmp

	move	t6,t1 //lo uso de condicion con j

	loop:	addiu	t4,t3,1
			subu	t1,t1,1
			bgt     t3,t1,done
			addiu   t3,t3,1
			lw		t7,0(t0)
			addiu	t0,t0,4
			loop2:	lw		t8,0(t2)
					bgt		t7,t8,condicion
					addiu	t2,t2,4
					addiu   t4,t4,1
					bgt		t4,t6,loop
					b 		loop2			
			condicion:	move t5,t7
						move t7,t8
						move t8,t5
						addiu t2,t2,4
						addiu t4,t4,1
						b loop2	
	
	done:	lw		fp, 20(fp) //cargo en fp el contenido que hay en la pos fp+20 en memoria, o sea 0.
			addiu	sp, sp, 24 //vuelvo a poner en 0 a sp sacandole las 7 posiciones que reserve.
			jr		ra		   //retorno a la direccion guardada en ra.

	.end	mips_sort
