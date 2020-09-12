
extern char acMatmul(); //for the 8 order masking (9 shares)
extern char acMatmul5o(); //for the 4 order masking (5 shares)
int main()
{
	acMatmul();
//	acMatmul5o();
	return 1;
}