#include <stdio.h>

extern void mips_sort(int *, int);

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

int main()
{
	int v[] = {1, 3, -1, 7, 5};

	imprimir("antes: ", v, 5);
	mips_sort(v, 5);
	imprimir("despues: ", v, 5);
}
