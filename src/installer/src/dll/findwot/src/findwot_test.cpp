#include <iostream>

extern "C" void __cdecl FindWotA(char *buffer, size_t size);

int main()
{
	char lol[256]{ 0 };
	FindWotA(&lol[0], 256);

	std::cout << lol;
	std::cin.get();
}