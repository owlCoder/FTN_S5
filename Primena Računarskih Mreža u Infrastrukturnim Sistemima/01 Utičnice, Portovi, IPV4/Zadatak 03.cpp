/*
	OSNOVNI ZADATAK
		1. Inicijalizovati Winsock biblioteku - WSAStartup()
		2. Kreirati adresnu strukturu koja koristi ip adresu 127.0.0.1 i broj porta 55555 - struct sockaddr_in
		3. Kreirati jedan TCP soket (utičnicu) - socket()
		4. Povezati soket sa kreiranom adresnom strukturom - bind()
		5. Zatvoriti soket - closesocket()
		6. Zatvoriti Winsock biblioteku - WSACleanup()

		DODATNI ZADATAK
		1. Dobaviti i ispisati lokalno ime i adresu računara - gethostbyname()
		2. Kreirati adresnu strukturu koja koristi dobijenu ip adresu iz prethodnog koraka - (umesto ip adrese 127.0.0.1) struct sockaddr_in
		3. Dobaviti i ispisati adresu soketa nakon povezivanja soketa sa kreiranom adresom - getsockname() 
*/
#define _WINSOCK_DEPRECATED_NO_WARNINGS
#define WIN32_LEAN_AND_MEAN

#ifdef _MSC_VER
#define _CRT_SECURE_NO_WARNINGS
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// REQUIRED NETWORK HEADERS
#include <Windows.h>
#include <WinSock2.h>
#include <WS2tcpip.h>

// ADDITIONAL LIBRARIES FOR NETWORK
#pragma comment(lib, "Ws2_32.lib")
#pragma comment(lib, "Mswsock.lib")
#pragma comment(lib, "AdvApi32.lib")

int main(void)
{
	WSADATA wsaData;


	if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0)
	{
		printf("WSAStartip failed with error: %d\n", WSAGetLastError());
	}

	// htonl - Host TO Network Long
	// htons - Host TO Network Short

	// ntohl - Network TO Host Long
	// ntohs - Network TO Host Short

	unsigned long podatak = 10;
	unsigned long mrezniRedosleBajtova;

	mrezniRedosleBajtova = htonl(podatak);
	
	/* PRETVARANJE IZ DECIMALNOG FORMATA U BINARNI FORMAT
	 * 
	 * inet_addr("192.168.10.37");
	 */

	 /* PRETVARANJE IZ BINARNOG FORMATA U DECIMALNU ADRESU (STRING)
	  *
	  * inet_ntoa(01101011001010);
	  */

	SOCKADDR_IN socketAdress;
	short port = 55555;

	socketAdress.sin_family       = AF_INET; // za IPV4 adrese
	socketAdress.sin_addr.s_addr  = inet_addr("127.0.0.1");
	socketAdress.sin_port         = htons(port);


	// KREIRANJE UTICNICE
	SOCKET soc = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

	// SPAJANJE UTICNICE I ADRESE

	int host_result = bind(soc, (struct sockaddr *) &socketAdress, sizeof(socketAdress));
	
	if (host_result == 0)
	{
		printf("Host socket binded successfully!\n");
	}
	else
	{
		printf("Error binding host socket!\n");
	}

	// 1. Dobaviti i ispisati lokalno ime i adresu računara - gethostbyname()
	char *adr = inet_ntoa(socketAdress.sin_addr);
	int len = sizeof(socketAdress.sin_addr.s_addr);
	auto hostnet_podaci = gethostbyname(adr);


	// ISPIS HOSTNET PODATAKA
	printf("\n------------------------ ISPIS PODATAKA --------------------------");
	printf("\n\tIP ADRESA: %s", hostnet_podaci -> h_name);

	// ZATVARANJE UTICNICA I OSLOBADJANJE RESURSA
	closesocket(soc);

	WSACleanup();

	return 0;
}
