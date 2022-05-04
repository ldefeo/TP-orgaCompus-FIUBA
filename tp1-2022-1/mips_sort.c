#include <stdio.h>

extern void mips_sort(int *, int);

void imprimir(const char *,int *,int);

void test(int *,int);

#if 0
void mips_sort(int *a, int len)
{
	int i, j;
	int tmp;

	/* Bubblesort. */
	for (i = 0; i < len - 1; i++) {
		for (j = i + 1; j < len; j++) {
			if (a[i] > a[j]) {
				tmp = a[i];
				a[i] = a[j];
				a[j] = tmp;
			}
		}
	}
}
#endif

void imprimir(const char *prefix, int *a, int len)
{
	const char *sep = "";
	int i;

	printf("%s", prefix);
	printf("(");
	for (i = 0; i < len; ++i) {
		printf("%s%d", sep, a[i]);
		sep = ", ";
	}
	printf(")");
	printf("\n");
}

void test(int *v,int tamanio){

	imprimir("\nantes: ", v, tamanio);
	mips_sort(v, tamanio);
	imprimir("despues: ", v, tamanio);
}

int main()
{
	int v1[] = {1, 3, -1, 7, 5};
	int v2[] = {1, 3, 4, 2, 6, 5, -1};
	int v3[] = {1, 3, 4, 2, 6, 5, 0, -1};
	int v4[] = {1, 7, 4, 2, 3, 5, -1, 8, 6, -3};

	test(v1,5);

	test(v2,7);

	test(v3,8);

	test(v4,10);

}
