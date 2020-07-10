#include <stdio.h>

int main()
{
	// Variable definitions
	char operator;
	double n1, n2;
	double result;

	/* Reading and parsing of equation
	 *
	 * The format provided in the 'scanf' function
	 * tells C how to read the given input and in
	 * which variable to store each part of the input
	 * %lf := long float aka double
	 * %c  := char 
	 */
	printf("Enter equation in the format 1 + 2: ");
	scanf("%lf %c %lf", &n1, &operator, &n2);

	// figure out which operator was used and
	// perform calculation accordingly
	if (operator == '+')
		result = n1 + n2;

	else if (operator == '-')
		result = n1 - n2;

	else if (operator == '*')
		result = n1 * n2;

	else if (operator == '/')
		result = n1 / n2;

	// output result
	printf("Result: %f\n", result);
}

