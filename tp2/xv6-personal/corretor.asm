
_corretor:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
                                        r->minute,
                                        r->second);
}


int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  return TRUE;
}

// testa a chamada date
int get_date(struct rtcdate *r) {
  if (date(r)) {
   f:	8d 5d e0             	lea    -0x20(%ebp),%ebx
                                        r->minute,
                                        r->second);
}


int main(int argc, char *argv[]) {
  12:	83 ec 28             	sub    $0x28,%esp
  struct rtcdate r;
  int call_ok = 1;

  printf(stdout, "[Caso 0] Testando o date\n");
  15:	68 a1 13 00 00       	push   $0x13a1
  1a:	ff 35 cc 19 00 00    	pushl  0x19cc
  20:	e8 7b 0c 00 00       	call   ca0 <printf>
  return TRUE;
}

// testa a chamada date
int get_date(struct rtcdate *r) {
  if (date(r)) {
  25:	89 1c 24             	mov    %ebx,(%esp)
  28:	e8 a5 0b 00 00       	call   bd2 <date>
  2d:	83 c4 10             	add    $0x10,%esp
  30:	85 c0                	test   %eax,%eax
  32:	75 60                	jne    94 <main+0x94>
  call_ok = get_date(&r);
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 0 - ERROR] Falhou!\n");
    exit();
  }
  print_date(&r);
  34:	83 ec 0c             	sub    $0xc,%esp
  37:	53                   	push   %ebx
  38:	e8 83 08 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 0] OK\n");
  3d:	58                   	pop    %eax
  3e:	5a                   	pop    %edx
  3f:	68 98 15 00 00       	push   $0x1598
  44:	ff 35 cc 19 00 00    	pushl  0x19cc
  4a:	e8 51 0c 00 00       	call   ca0 <printf>

  get_date(&r);
  4f:	89 1c 24             	mov    %ebx,(%esp)
  52:	e8 29 08 00 00       	call   880 <get_date>
  print_date(&r);
  57:	89 1c 24             	mov    %ebx,(%esp)
  5a:	e8 61 08 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 1] Testando o fork\n");
  5f:	59                   	pop    %ecx
  60:	58                   	pop    %eax
  61:	68 a5 15 00 00       	push   $0x15a5
  66:	ff 35 cc 19 00 00    	pushl  0x19cc
  6c:	e8 2f 0c 00 00       	call   ca0 <printf>
  call_ok = caso1fork();
  71:	e8 ca 02 00 00       	call   340 <caso1fork>
  if (call_ok == FALSE) {
  76:	83 c4 10             	add    $0x10,%esp
  79:	85 c0                	test   %eax,%eax
  7b:	75 40                	jne    bd <main+0xbd>
    printf(stdout, "[Caso 1 - ERROR] Falhou!\n");
  7d:	51                   	push   %ecx
  7e:	51                   	push   %ecx
  7f:	68 d5 13 00 00       	push   $0x13d5
  84:	ff 35 cc 19 00 00    	pushl  0x19cc
  8a:	e8 11 0c 00 00       	call   ca0 <printf>
    exit();
  8f:	e8 9e 0a 00 00       	call   b32 <exit>
}

// testa a chamada date
int get_date(struct rtcdate *r) {
  if (date(r)) {
    printf(stderr, "[ERROR] Erro na chamada de sistema date\n");
  94:	53                   	push   %ebx
  95:	53                   	push   %ebx
  96:	68 24 12 00 00       	push   $0x1224
  9b:	ff 35 c8 19 00 00    	pushl  0x19c8
  a1:	e8 fa 0b 00 00       	call   ca0 <printf>
  int call_ok = 1;

  printf(stdout, "[Caso 0] Testando o date\n");
  call_ok = get_date(&r);
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 0 - ERROR] Falhou!\n");
  a6:	58                   	pop    %eax
  a7:	5a                   	pop    %edx
  a8:	68 bb 13 00 00       	push   $0x13bb
  ad:	ff 35 cc 19 00 00    	pushl  0x19cc
  b3:	e8 e8 0b 00 00       	call   ca0 <printf>
    exit();
  b8:	e8 75 0a 00 00       	call   b32 <exit>
  call_ok = caso1fork();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 1 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 1] OK\n");
  bd:	50                   	push   %eax
  be:	50                   	push   %eax
  bf:	68 ef 13 00 00       	push   $0x13ef
  c4:	ff 35 cc 19 00 00    	pushl  0x19cc
  ca:	e8 d1 0b 00 00       	call   ca0 <printf>

  get_date(&r);
  cf:	89 1c 24             	mov    %ebx,(%esp)
  d2:	e8 a9 07 00 00       	call   880 <get_date>
  print_date(&r);
  d7:	89 1c 24             	mov    %ebx,(%esp)
  da:	e8 e1 07 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 2] Testando o forkcow\n");
  df:	58                   	pop    %eax
  e0:	5a                   	pop    %edx
  e1:	68 fc 13 00 00       	push   $0x13fc
  e6:	ff 35 cc 19 00 00    	pushl  0x19cc
  ec:	e8 af 0b 00 00       	call   ca0 <printf>
  call_ok = caso2forkcow();
  f1:	e8 ca 02 00 00       	call   3c0 <caso2forkcow>
  if (call_ok == FALSE) {
  f6:	83 c4 10             	add    $0x10,%esp
  f9:	85 c0                	test   %eax,%eax
  fb:	74 57                	je     154 <main+0x154>
    printf(stdout, "[Caso 2 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 2] OK\n");
  fd:	50                   	push   %eax
  fe:	50                   	push   %eax
  ff:	68 33 14 00 00       	push   $0x1433
 104:	ff 35 cc 19 00 00    	pushl  0x19cc
 10a:	e8 91 0b 00 00       	call   ca0 <printf>

  get_date(&r);
 10f:	89 1c 24             	mov    %ebx,(%esp)
 112:	e8 69 07 00 00       	call   880 <get_date>
  print_date(&r);
 117:	89 1c 24             	mov    %ebx,(%esp)
 11a:	e8 a1 07 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 3] Testando se o número de páginas é igual\n");
 11f:	58                   	pop    %eax
 120:	5a                   	pop    %edx
 121:	68 50 12 00 00       	push   $0x1250
 126:	ff 35 cc 19 00 00    	pushl  0x19cc
 12c:	e8 6f 0b 00 00       	call   ca0 <printf>
  call_ok = caso3numpgs();
 131:	e8 0a 03 00 00       	call   440 <caso3numpgs>
  if (call_ok == FALSE) {
 136:	83 c4 10             	add    $0x10,%esp
 139:	85 c0                	test   %eax,%eax
 13b:	75 2e                	jne    16b <main+0x16b>
    printf(stdout, "[Caso 3 - ERROR] Falhou!\n");
 13d:	51                   	push   %ecx
 13e:	51                   	push   %ecx
 13f:	68 40 14 00 00       	push   $0x1440
 144:	ff 35 cc 19 00 00    	pushl  0x19cc
 14a:	e8 51 0b 00 00       	call   ca0 <printf>
    exit();
 14f:	e8 de 09 00 00       	call   b32 <exit>
  get_date(&r);
  print_date(&r);
  printf(stdout, "[Caso 2] Testando o forkcow\n");
  call_ok = caso2forkcow();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 2 - ERROR] Falhou!\n");
 154:	51                   	push   %ecx
 155:	51                   	push   %ecx
 156:	68 19 14 00 00       	push   $0x1419
 15b:	ff 35 cc 19 00 00    	pushl  0x19cc
 161:	e8 3a 0b 00 00       	call   ca0 <printf>
    exit();
 166:	e8 c7 09 00 00       	call   b32 <exit>
  call_ok = caso3numpgs();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 3 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 3] OK\n");
 16b:	50                   	push   %eax
 16c:	50                   	push   %eax
 16d:	68 5a 14 00 00       	push   $0x145a
 172:	ff 35 cc 19 00 00    	pushl  0x19cc
 178:	e8 23 0b 00 00       	call   ca0 <printf>

  get_date(&r);
 17d:	89 1c 24             	mov    %ebx,(%esp)
 180:	e8 fb 06 00 00       	call   880 <get_date>
  print_date(&r);
 185:	89 1c 24             	mov    %ebx,(%esp)
 188:	e8 33 07 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 4] Testando se o endereço de uma constante é =\n");
 18d:	58                   	pop    %eax
 18e:	5a                   	pop    %edx
 18f:	68 88 12 00 00       	push   $0x1288
 194:	ff 35 cc 19 00 00    	pushl  0x19cc
 19a:	e8 01 0b 00 00       	call   ca0 <printf>
  call_ok = caso4mesmoaddr(); 
 19f:	e8 8c 03 00 00       	call   530 <caso4mesmoaddr>
  if (call_ok == FALSE) {
 1a4:	83 c4 10             	add    $0x10,%esp
 1a7:	85 c0                	test   %eax,%eax
 1a9:	74 57                	je     202 <main+0x202>
    printf(stdout, "[Caso 4 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 4] OK\n");
 1ab:	50                   	push   %eax
 1ac:	50                   	push   %eax
 1ad:	68 81 14 00 00       	push   $0x1481
 1b2:	ff 35 cc 19 00 00    	pushl  0x19cc
 1b8:	e8 e3 0a 00 00       	call   ca0 <printf>

  get_date(&r);
 1bd:	89 1c 24             	mov    %ebx,(%esp)
 1c0:	e8 bb 06 00 00       	call   880 <get_date>
  print_date(&r);
 1c5:	89 1c 24             	mov    %ebx,(%esp)
 1c8:	e8 f3 06 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 5] Testando se o endereço de uma global é =\n");
 1cd:	58                   	pop    %eax
 1ce:	5a                   	pop    %edx
 1cf:	68 c0 12 00 00       	push   $0x12c0
 1d4:	ff 35 cc 19 00 00    	pushl  0x19cc
 1da:	e8 c1 0a 00 00       	call   ca0 <printf>
  call_ok = caso5mesmoaddr();
 1df:	e8 7c 04 00 00       	call   660 <caso5mesmoaddr>
  if (call_ok == FALSE) {
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	85 c0                	test   %eax,%eax
 1e9:	75 2e                	jne    219 <main+0x219>
    printf(stdout, "[Caso 5 - ERROR] Falhou!\n");
 1eb:	51                   	push   %ecx
 1ec:	51                   	push   %ecx
 1ed:	68 8e 14 00 00       	push   $0x148e
 1f2:	ff 35 cc 19 00 00    	pushl  0x19cc
 1f8:	e8 a3 0a 00 00       	call   ca0 <printf>
    exit();
 1fd:	e8 30 09 00 00       	call   b32 <exit>
  get_date(&r);
  print_date(&r);
  printf(stdout, "[Caso 4] Testando se o endereço de uma constante é =\n");
  call_ok = caso4mesmoaddr(); 
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 4 - ERROR] Falhou!\n");
 202:	51                   	push   %ecx
 203:	51                   	push   %ecx
 204:	68 67 14 00 00       	push   $0x1467
 209:	ff 35 cc 19 00 00    	pushl  0x19cc
 20f:	e8 8c 0a 00 00       	call   ca0 <printf>
    exit();
 214:	e8 19 09 00 00       	call   b32 <exit>
  call_ok = caso5mesmoaddr();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 5 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 5] OK\n");
 219:	50                   	push   %eax
 21a:	50                   	push   %eax
 21b:	68 a8 14 00 00       	push   $0x14a8
 220:	ff 35 cc 19 00 00    	pushl  0x19cc
 226:	e8 75 0a 00 00       	call   ca0 <printf>

  get_date(&r);
 22b:	89 1c 24             	mov    %ebx,(%esp)
 22e:	e8 4d 06 00 00       	call   880 <get_date>
  print_date(&r);
 233:	89 1c 24             	mov    %ebx,(%esp)
 236:	e8 85 06 00 00       	call   8c0 <print_date>
  printf(stdout, "[Caso 6] Testando o COW\n");
 23b:	58                   	pop    %eax
 23c:	5a                   	pop    %edx
 23d:	68 b5 14 00 00       	push   $0x14b5
 242:	ff 35 cc 19 00 00    	pushl  0x19cc
 248:	e8 53 0a 00 00       	call   ca0 <printf>
  call_ok = caso6cow();
 24d:	e8 1e 05 00 00       	call   770 <caso6cow>
  if (call_ok == FALSE) {
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	75 17                	jne    270 <main+0x270>
    printf(stdout, "[Caso 6 - ERROR] Falhou!\n");
 259:	50                   	push   %eax
 25a:	50                   	push   %eax
 25b:	68 ce 14 00 00       	push   $0x14ce
 260:	ff 35 cc 19 00 00    	pushl  0x19cc
 266:	e8 35 0a 00 00       	call   ca0 <printf>
    exit();
 26b:	e8 c2 08 00 00       	call   b32 <exit>
  }
  printf(stdout, "[Caso 6] OK\n");
 270:	50                   	push   %eax
 271:	50                   	push   %eax
 272:	68 e8 14 00 00       	push   $0x14e8
 277:	ff 35 cc 19 00 00    	pushl  0x19cc
 27d:	e8 1e 0a 00 00       	call   ca0 <printf>
  printf(stdout, "\n");
 282:	58                   	pop    %eax
 283:	5a                   	pop    %edx
 284:	68 4e 15 00 00       	push   $0x154e
 289:	ff 35 cc 19 00 00    	pushl  0x19cc
 28f:	e8 0c 0a 00 00       	call   ca0 <printf>
  printf(stdout, "         (__)        \n");
 294:	59                   	pop    %ecx
 295:	5b                   	pop    %ebx
 296:	68 f5 14 00 00       	push   $0x14f5
 29b:	ff 35 cc 19 00 00    	pushl  0x19cc
 2a1:	e8 fa 09 00 00       	call   ca0 <printf>
  printf(stdout, "         (oo)        \n");
 2a6:	58                   	pop    %eax
 2a7:	5a                   	pop    %edx
 2a8:	68 0c 15 00 00       	push   $0x150c
 2ad:	ff 35 cc 19 00 00    	pushl  0x19cc
 2b3:	e8 e8 09 00 00       	call   ca0 <printf>
  printf(stdout, "   /------\\/        \n");
 2b8:	59                   	pop    %ecx
 2b9:	5b                   	pop    %ebx
 2ba:	68 23 15 00 00       	push   $0x1523
 2bf:	ff 35 cc 19 00 00    	pushl  0x19cc
 2c5:	e8 d6 09 00 00       	call   ca0 <printf>
  printf(stdout, "  / |    ||          \n");
 2ca:	58                   	pop    %eax
 2cb:	5a                   	pop    %edx
 2cc:	68 39 15 00 00       	push   $0x1539
 2d1:	ff 35 cc 19 00 00    	pushl  0x19cc
 2d7:	e8 c4 09 00 00       	call   ca0 <printf>
  printf(stdout, " *  /\\---/\\        \n");
 2dc:	59                   	pop    %ecx
 2dd:	5b                   	pop    %ebx
 2de:	68 50 15 00 00       	push   $0x1550
 2e3:	ff 35 cc 19 00 00    	pushl  0x19cc
 2e9:	e8 b2 09 00 00       	call   ca0 <printf>
  printf(stdout, "    ~~   ~~          \n");
 2ee:	58                   	pop    %eax
 2ef:	5a                   	pop    %edx
 2f0:	68 65 15 00 00       	push   $0x1565
 2f5:	ff 35 cc 19 00 00    	pushl  0x19cc
 2fb:	e8 a0 09 00 00       	call   ca0 <printf>
  printf(stdout, "....\"Congratulations! You have mooed!\"...\n");
 300:	59                   	pop    %ecx
 301:	5b                   	pop    %ebx
 302:	68 f8 12 00 00       	push   $0x12f8
 307:	ff 35 cc 19 00 00    	pushl  0x19cc
 30d:	e8 8e 09 00 00       	call   ca0 <printf>
  printf(stdout, "\n");
 312:	58                   	pop    %eax
 313:	5a                   	pop    %edx
 314:	68 4e 15 00 00       	push   $0x154e
 319:	ff 35 cc 19 00 00    	pushl  0x19cc
 31f:	e8 7c 09 00 00       	call   ca0 <printf>
  printf(stdout, "[0xDCC605 - COW] ALL OK!!!\n");
 324:	59                   	pop    %ecx
 325:	5b                   	pop    %ebx
 326:	68 7c 15 00 00       	push   $0x157c
 32b:	ff 35 cc 19 00 00    	pushl  0x19cc
 331:	e8 6a 09 00 00       	call   ca0 <printf>
  exit();
 336:	e8 f7 07 00 00       	call   b32 <exit>
 33b:	66 90                	xchg   %ax,%ax
 33d:	66 90                	xchg   %ax,%ax
 33f:	90                   	nop

00000340 <caso1fork>:


// testa o fork normal. garante que não quebramos nada
// N forks e waits consecutivos. existe um limite de 64
// processos no xv6, então temos que garantir que N <= 64
int caso1fork(void) {
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
  int n;
  int pid;

  printf(stdout, "[--Caso 1.1] Testando %d chamadas fork\n", N);

  for(n=0; n<N; n++){
 344:	31 db                	xor    %ebx,%ebx


// testa o fork normal. garante que não quebramos nada
// N forks e waits consecutivos. existe um limite de 64
// processos no xv6, então temos que garantir que N <= 64
int caso1fork(void) {
 346:	83 ec 08             	sub    $0x8,%esp
  int n;
  int pid;

  printf(stdout, "[--Caso 1.1] Testando %d chamadas fork\n", N);
 349:	6a 0a                	push   $0xa
 34b:	68 c0 0f 00 00       	push   $0xfc0
 350:	ff 35 cc 19 00 00    	pushl  0x19cc
 356:	e8 45 09 00 00       	call   ca0 <printf>
 35b:	83 c4 10             	add    $0x10,%esp
 35e:	66 90                	xchg   %ax,%ax

  for(n=0; n<N; n++){
    pid = fork();
 360:	e8 c5 07 00 00       	call   b2a <fork>
    if(pid < 0) {
 365:	85 c0                	test   %eax,%eax
 367:	78 27                	js     390 <caso1fork+0x50>
      printf(stdout, "[--Caso 1.1 - ERROR] Fork %d falhou!\n", n);
      return FALSE;
    }
    if(pid == 0)
 369:	74 4c                	je     3b7 <caso1fork+0x77>
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
 36b:	e8 ca 07 00 00       	call   b3a <wait>
 370:	85 c0                	test   %eax,%eax
 372:	78 3c                	js     3b0 <caso1fork+0x70>
  int n;
  int pid;

  printf(stdout, "[--Caso 1.1] Testando %d chamadas fork\n", N);

  for(n=0; n<N; n++){
 374:	83 c3 01             	add    $0x1,%ebx
 377:	83 fb 0a             	cmp    $0xa,%ebx
 37a:	75 e4                	jne    360 <caso1fork+0x20>
    if(pid == 0)
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
  }
  return TRUE;
 37c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 381:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 384:	c9                   	leave  
 385:	c3                   	ret    
 386:	8d 76 00             	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  printf(stdout, "[--Caso 1.1] Testando %d chamadas fork\n", N);

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0) {
      printf(stdout, "[--Caso 1.1 - ERROR] Fork %d falhou!\n", n);
 390:	83 ec 04             	sub    $0x4,%esp
 393:	53                   	push   %ebx
 394:	68 e8 0f 00 00       	push   $0xfe8
 399:	ff 35 cc 19 00 00    	pushl  0x19cc
 39f:	e8 fc 08 00 00       	call   ca0 <printf>
      return FALSE;
 3a4:	83 c4 10             	add    $0x10,%esp
 3a7:	31 c0                	xor    %eax,%eax
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
  }
  return TRUE;
}
 3a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ac:	c9                   	leave  
 3ad:	c3                   	ret    
 3ae:	66 90                	xchg   %ax,%ax
      return FALSE;
    }
    if(pid == 0)
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
 3b0:	31 c0                	xor    %eax,%eax
  }
  return TRUE;
}
 3b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3b5:	c9                   	leave  
 3b6:	c3                   	ret    
    if(pid < 0) {
      printf(stdout, "[--Caso 1.1 - ERROR] Fork %d falhou!\n", n);
      return FALSE;
    }
    if(pid == 0)
      exit();   // fecha filho
 3b7:	e8 76 07 00 00       	call   b32 <exit>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <caso2forkcow>:

// mesmo do caso 1 só que com o novo forkcow
// testa o fork cow. garante que não quebramos nada
// N forks e waits consecutivos. existe um limite de 64
// processos no xv6, então temos que garantir que N <= 64
int caso2forkcow(void) {
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
  int n;
  int pid;

  printf(stdout, "[--Caso 2.1] Testando %d chamadas forkcow\n", N);

  for(n=0; n<N; n++){
 3c4:	31 db                	xor    %ebx,%ebx

// mesmo do caso 1 só que com o novo forkcow
// testa o fork cow. garante que não quebramos nada
// N forks e waits consecutivos. existe um limite de 64
// processos no xv6, então temos que garantir que N <= 64
int caso2forkcow(void) {
 3c6:	83 ec 08             	sub    $0x8,%esp
  int n;
  int pid;

  printf(stdout, "[--Caso 2.1] Testando %d chamadas forkcow\n", N);
 3c9:	6a 0a                	push   $0xa
 3cb:	68 10 10 00 00       	push   $0x1010
 3d0:	ff 35 cc 19 00 00    	pushl  0x19cc
 3d6:	e8 c5 08 00 00       	call   ca0 <printf>
 3db:	83 c4 10             	add    $0x10,%esp
 3de:	66 90                	xchg   %ax,%ax

  for(n=0; n<N; n++){
    pid = forkcow();
 3e0:	e8 05 08 00 00       	call   bea <forkcow>
    if(pid < 0) {
 3e5:	85 c0                	test   %eax,%eax
 3e7:	78 27                	js     410 <caso2forkcow+0x50>
      printf(stdout, "[--Caso 2.1 - ERROR] Fork %d falhou!\n", n);
      return FALSE;
    }
    if(pid == 0)
 3e9:	74 4c                	je     437 <caso2forkcow+0x77>
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
 3eb:	e8 4a 07 00 00       	call   b3a <wait>
 3f0:	85 c0                	test   %eax,%eax
 3f2:	78 3c                	js     430 <caso2forkcow+0x70>
  int n;
  int pid;

  printf(stdout, "[--Caso 2.1] Testando %d chamadas forkcow\n", N);

  for(n=0; n<N; n++){
 3f4:	83 c3 01             	add    $0x1,%ebx
 3f7:	83 fb 0a             	cmp    $0xa,%ebx
 3fa:	75 e4                	jne    3e0 <caso2forkcow+0x20>
    if(pid == 0)
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
  }
  return TRUE;
 3fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
 401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 404:	c9                   	leave  
 405:	c3                   	ret    
 406:	8d 76 00             	lea    0x0(%esi),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  printf(stdout, "[--Caso 2.1] Testando %d chamadas forkcow\n", N);

  for(n=0; n<N; n++){
    pid = forkcow();
    if(pid < 0) {
      printf(stdout, "[--Caso 2.1 - ERROR] Fork %d falhou!\n", n);
 410:	83 ec 04             	sub    $0x4,%esp
 413:	53                   	push   %ebx
 414:	68 3c 10 00 00       	push   $0x103c
 419:	ff 35 cc 19 00 00    	pushl  0x19cc
 41f:	e8 7c 08 00 00       	call   ca0 <printf>
      return FALSE;
 424:	83 c4 10             	add    $0x10,%esp
 427:	31 c0                	xor    %eax,%eax
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
  }
  return TRUE;
}
 429:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 42c:	c9                   	leave  
 42d:	c3                   	ret    
 42e:	66 90                	xchg   %ax,%ax
      return FALSE;
    }
    if(pid == 0)
      exit();   // fecha filho
    else
      if (wait() < 0) return FALSE;
 430:	31 c0                	xor    %eax,%eax
  }
  return TRUE;
}
 432:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 435:	c9                   	leave  
 436:	c3                   	ret    
    if(pid < 0) {
      printf(stdout, "[--Caso 2.1 - ERROR] Fork %d falhou!\n", n);
      return FALSE;
    }
    if(pid == 0)
      exit();   // fecha filho
 437:	e8 f6 06 00 00       	call   b32 <exit>
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000440 <caso3numpgs>:

// testa que o processo parent e child tem o mesmo num de pgs
// embora durante o forkcow algumas páginas são escrita, os
// 2 processos não crescem nem em pilha nem em heap.
// pipes, wait e exit para comunicação e sync
int caso3numpgs(void) {
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	56                   	push   %esi
 444:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 445:	8d 45 dc             	lea    -0x24(%ebp),%eax

// testa que o processo parent e child tem o mesmo num de pgs
// embora durante o forkcow algumas páginas são escrita, os
// 2 processos não crescem nem em pilha nem em heap.
// pipes, wait e exit para comunicação e sync
int caso3numpgs(void) {
 448:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 44b:	50                   	push   %eax
 44c:	e8 f1 06 00 00       	call   b42 <pipe>
  int np = num_pages();
 451:	e8 8c 07 00 00       	call   be2 <num_pages>
 456:	89 c6                	mov    %eax,%esi
  char answer[20];     // com certeza menos de 99999999999999999999 pgs
  int pid = forkcow();
 458:	e8 8d 07 00 00       	call   bea <forkcow>
  if (pid == 0) { // child manda número de páginas de da exit
 45d:	83 c4 10             	add    $0x10,%esp
 460:	85 c0                	test   %eax,%eax
 462:	74 72                	je     4d6 <caso3numpgs+0x96>
    printf(fd[1], "%d\0", num_pages());
    printf(stdout, "[--Caso 3.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    close(fd[1]);
 464:	83 ec 0c             	sub    $0xc,%esp
 467:	ff 75 e0             	pushl  -0x20(%ebp)
    wait();
    printf(stdout, "[--Caso 3.3] Parent lendo num_pages\n");
    read(fd[0], answer, 20);
 46a:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
    printf(fd[1], "%d\0", num_pages());
    printf(stdout, "[--Caso 3.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    close(fd[1]);
 46d:	e8 e8 06 00 00       	call   b5a <close>
    wait();
 472:	e8 c3 06 00 00       	call   b3a <wait>
    printf(stdout, "[--Caso 3.3] Parent lendo num_pages\n");
 477:	58                   	pop    %eax
 478:	5a                   	pop    %edx
 479:	68 ac 10 00 00       	push   $0x10ac
 47e:	ff 35 cc 19 00 00    	pushl  0x19cc
 484:	e8 17 08 00 00       	call   ca0 <printf>
    read(fd[0], answer, 20);
 489:	83 c4 0c             	add    $0xc,%esp
 48c:	6a 14                	push   $0x14
 48e:	53                   	push   %ebx
 48f:	ff 75 dc             	pushl  -0x24(%ebp)
 492:	e8 b3 06 00 00       	call   b4a <read>
    printf(stdout, "[--Caso 3.4] Parent leu %d == %d\n", np, atoi(answer));
 497:	89 1c 24             	mov    %ebx,(%esp)
 49a:	e8 21 06 00 00       	call   ac0 <atoi>
 49f:	50                   	push   %eax
 4a0:	56                   	push   %esi
 4a1:	68 d4 10 00 00       	push   $0x10d4
 4a6:	ff 35 cc 19 00 00    	pushl  0x19cc
 4ac:	e8 ef 07 00 00       	call   ca0 <printf>
    close(fd[0]);
 4b1:	83 c4 14             	add    $0x14,%esp
 4b4:	ff 75 dc             	pushl  -0x24(%ebp)
 4b7:	e8 9e 06 00 00       	call   b5a <close>
    return atoi(answer) == np;
 4bc:	89 1c 24             	mov    %ebx,(%esp)
 4bf:	e8 fc 05 00 00       	call   ac0 <atoi>
 4c4:	83 c4 10             	add    $0x10,%esp
 4c7:	39 c6                	cmp    %eax,%esi
 4c9:	0f 94 c0             	sete   %al
  }
  return TRUE;
}
 4cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4cf:	0f b6 c0             	movzbl %al,%eax
 4d2:	5b                   	pop    %ebx
 4d3:	5e                   	pop    %esi
 4d4:	5d                   	pop    %ebp
 4d5:	c3                   	ret    
  pipe(fd);
  int np = num_pages();
  char answer[20];     // com certeza menos de 99999999999999999999 pgs
  int pid = forkcow();
  if (pid == 0) { // child manda número de páginas de da exit
    printf(stdout, "[--Caso 3.1] Child write num_pages %d\n", num_pages());
 4d6:	e8 07 07 00 00       	call   be2 <num_pages>
 4db:	51                   	push   %ecx
 4dc:	50                   	push   %eax
 4dd:	68 64 10 00 00       	push   $0x1064
 4e2:	ff 35 cc 19 00 00    	pushl  0x19cc
 4e8:	e8 b3 07 00 00       	call   ca0 <printf>
    close(fd[0]);
 4ed:	5b                   	pop    %ebx
 4ee:	ff 75 dc             	pushl  -0x24(%ebp)
 4f1:	e8 64 06 00 00       	call   b5a <close>
    printf(fd[1], "%d\0", num_pages());
 4f6:	e8 e7 06 00 00       	call   be2 <num_pages>
 4fb:	83 c4 0c             	add    $0xc,%esp
 4fe:	50                   	push   %eax
 4ff:	68 24 13 00 00       	push   $0x1324
 504:	ff 75 e0             	pushl  -0x20(%ebp)
 507:	e8 94 07 00 00       	call   ca0 <printf>
    printf(stdout, "[--Caso 3.2] Child indo embora\n");
 50c:	5e                   	pop    %esi
 50d:	58                   	pop    %eax
 50e:	68 8c 10 00 00       	push   $0x108c
 513:	ff 35 cc 19 00 00    	pushl  0x19cc
 519:	e8 82 07 00 00       	call   ca0 <printf>
    close(fd[1]);
 51e:	58                   	pop    %eax
 51f:	ff 75 e0             	pushl  -0x20(%ebp)
 522:	e8 33 06 00 00       	call   b5a <close>
    exit();
 527:	e8 06 06 00 00       	call   b32 <exit>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <caso4mesmoaddr>:


// testa que o processo parent e child tem o mesmo addr real
// para uma constante. usamos a GLOBAL1_RO
// pipes, wait e exit para comunicação e sync
int caso4mesmoaddr(void) {
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	56                   	push   %esi
 534:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 535:	8d 45 dc             	lea    -0x24(%ebp),%eax


// testa que o processo parent e child tem o mesmo addr real
// para uma constante. usamos a GLOBAL1_RO
// pipes, wait e exit para comunicação e sync
int caso4mesmoaddr(void) {
 538:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 53b:	50                   	push   %eax
 53c:	e8 01 06 00 00       	call   b42 <pipe>
  char answer[20];
  int pid = forkcow();
 541:	e8 a4 06 00 00       	call   bea <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL1_RO
 546:	83 c4 10             	add    $0x10,%esp
 549:	85 c0                	test   %eax,%eax
 54b:	0f 84 9c 00 00 00    	je     5ed <caso4mesmoaddr+0xbd>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 551:	83 ec 0c             	sub    $0xc,%esp
    printf(stdout, "Addr = %d\n", addr);
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
    wait();
    printf(stdout, "[--Caso 4.3] Parent lendo addr\n");
    read(fd[0], answer, 20);
 554:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 557:	68 28 13 00 00       	push   $0x1328
 55c:	e8 79 06 00 00       	call   bda <virt2real>
    printf(stdout, "Addr = %d\n", addr);
 561:	83 c4 0c             	add    $0xc,%esp
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 564:	89 c3                	mov    %eax,%ebx
    printf(stdout, "Addr = %d\n", addr);
 566:	50                   	push   %eax
 567:	68 49 13 00 00       	push   $0x1349
 56c:	ff 35 cc 19 00 00    	pushl  0x19cc
 572:	e8 29 07 00 00       	call   ca0 <printf>
 577:	89 d8                	mov    %ebx,%eax
 579:	c1 f8 1f             	sar    $0x1f,%eax
 57c:	31 c3                	xor    %eax,%ebx
 57e:	29 c3                	sub    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 580:	58                   	pop    %eax
 581:	ff 75 e0             	pushl  -0x20(%ebp)
 584:	e8 d1 05 00 00       	call   b5a <close>
    wait();
 589:	e8 ac 05 00 00       	call   b3a <wait>
    printf(stdout, "[--Caso 4.3] Parent lendo addr\n");
 58e:	5a                   	pop    %edx
 58f:	59                   	pop    %ecx
 590:	68 18 11 00 00       	push   $0x1118
 595:	ff 35 cc 19 00 00    	pushl  0x19cc
 59b:	e8 00 07 00 00       	call   ca0 <printf>
    read(fd[0], answer, 20);
 5a0:	83 c4 0c             	add    $0xc,%esp
 5a3:	6a 14                	push   $0x14
 5a5:	56                   	push   %esi
 5a6:	ff 75 dc             	pushl  -0x24(%ebp)
 5a9:	e8 9c 05 00 00       	call   b4a <read>
    printf(stdout, "[--Caso 4.4] Parent leu %d == %d\n",
 5ae:	89 34 24             	mov    %esi,(%esp)
 5b1:	e8 0a 05 00 00       	call   ac0 <atoi>
 5b6:	50                   	push   %eax
 5b7:	53                   	push   %ebx
 5b8:	68 38 11 00 00       	push   $0x1138
 5bd:	ff 35 cc 19 00 00    	pushl  0x19cc
 5c3:	e8 d8 06 00 00       	call   ca0 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 5c8:	83 c4 14             	add    $0x14,%esp
 5cb:	ff 75 dc             	pushl  -0x24(%ebp)
 5ce:	e8 87 05 00 00       	call   b5a <close>
    return addr == atoi(answer);
 5d3:	89 34 24             	mov    %esi,(%esp)
 5d6:	e8 e5 04 00 00       	call   ac0 <atoi>
 5db:	83 c4 10             	add    $0x10,%esp
 5de:	39 d8                	cmp    %ebx,%eax
 5e0:	0f 94 c0             	sete   %al
  }
  return TRUE;
}
 5e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5e6:	0f b6 c0             	movzbl %al,%eax
 5e9:	5b                   	pop    %ebx
 5ea:	5e                   	pop    %esi
 5eb:	5d                   	pop    %ebp
 5ec:	c3                   	ret    
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL1_RO
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 5ed:	83 ec 0c             	sub    $0xc,%esp
 5f0:	68 28 13 00 00       	push   $0x1328
 5f5:	e8 e0 05 00 00       	call   bda <virt2real>
 5fa:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 5fc:	c1 f8 1f             	sar    $0x1f,%eax
 5ff:	83 c4 0c             	add    $0xc,%esp
 602:	31 c3                	xor    %eax,%ebx
 604:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 4.1] Child write %d\n", addr);
 606:	53                   	push   %ebx
 607:	68 2c 13 00 00       	push   $0x132c
 60c:	ff 35 cc 19 00 00    	pushl  0x19cc
 612:	e8 89 06 00 00       	call   ca0 <printf>
    close(fd[0]);
 617:	5e                   	pop    %esi
 618:	ff 75 dc             	pushl  -0x24(%ebp)
 61b:	e8 3a 05 00 00       	call   b5a <close>
    printf(fd[1], "%d\0", addr);
 620:	83 c4 0c             	add    $0xc,%esp
 623:	53                   	push   %ebx
 624:	68 24 13 00 00       	push   $0x1324
 629:	ff 75 e0             	pushl  -0x20(%ebp)
 62c:	e8 6f 06 00 00       	call   ca0 <printf>
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
 631:	58                   	pop    %eax
 632:	5a                   	pop    %edx
 633:	68 f8 10 00 00       	push   $0x10f8
 638:	ff 35 cc 19 00 00    	pushl  0x19cc
 63e:	e8 5d 06 00 00       	call   ca0 <printf>
    close(fd[1]);
 643:	59                   	pop    %ecx
 644:	ff 75 e0             	pushl  -0x20(%ebp)
 647:	e8 0e 05 00 00       	call   b5a <close>
    exit();
 64c:	e8 e1 04 00 00       	call   b32 <exit>
 651:	eb 0d                	jmp    660 <caso5mesmoaddr>
 653:	90                   	nop
 654:	90                   	nop
 655:	90                   	nop
 656:	90                   	nop
 657:	90                   	nop
 658:	90                   	nop
 659:	90                   	nop
 65a:	90                   	nop
 65b:	90                   	nop
 65c:	90                   	nop
 65d:	90                   	nop
 65e:	90                   	nop
 65f:	90                   	nop

00000660 <caso5mesmoaddr>:


// testa que o processo parent e child tem o mesmo addr real
// para uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso5mesmoaddr(void) {
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	56                   	push   %esi
 664:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 665:	8d 45 dc             	lea    -0x24(%ebp),%eax


// testa que o processo parent e child tem o mesmo addr real
// para uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso5mesmoaddr(void) {
 668:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 66b:	50                   	push   %eax
 66c:	e8 d1 04 00 00       	call   b42 <pipe>
  char answer[20];
  int pid = forkcow();
 671:	e8 74 05 00 00       	call   bea <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL1_RO
 676:	83 c4 10             	add    $0x10,%esp
 679:	85 c0                	test   %eax,%eax
 67b:	0f 84 84 00 00 00    	je     705 <caso5mesmoaddr+0xa5>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 681:	83 ec 0c             	sub    $0xc,%esp
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
    wait();
    printf(stdout, "[--Caso 5.3] Parent lendo addr\n");
    read(fd[0], answer, 20);
 684:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 687:	68 c4 19 00 00       	push   $0x19c4
 68c:	e8 49 05 00 00       	call   bda <virt2real>
 691:	99                   	cltd   
 692:	31 d0                	xor    %edx,%eax
 694:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 696:	58                   	pop    %eax
 697:	ff 75 e0             	pushl  -0x20(%ebp)
 69a:	29 d3                	sub    %edx,%ebx
 69c:	e8 b9 04 00 00       	call   b5a <close>
    wait();
 6a1:	e8 94 04 00 00       	call   b3a <wait>
    printf(stdout, "[--Caso 5.3] Parent lendo addr\n");
 6a6:	5a                   	pop    %edx
 6a7:	59                   	pop    %ecx
 6a8:	68 7c 11 00 00       	push   $0x117c
 6ad:	ff 35 cc 19 00 00    	pushl  0x19cc
 6b3:	e8 e8 05 00 00       	call   ca0 <printf>
    read(fd[0], answer, 20);
 6b8:	83 c4 0c             	add    $0xc,%esp
 6bb:	6a 14                	push   $0x14
 6bd:	56                   	push   %esi
 6be:	ff 75 dc             	pushl  -0x24(%ebp)
 6c1:	e8 84 04 00 00       	call   b4a <read>
    printf(stdout, "[--Caso 5.4] Parent leu %d == %d\n",
 6c6:	89 34 24             	mov    %esi,(%esp)
 6c9:	e8 f2 03 00 00       	call   ac0 <atoi>
 6ce:	50                   	push   %eax
 6cf:	53                   	push   %ebx
 6d0:	68 9c 11 00 00       	push   $0x119c
 6d5:	ff 35 cc 19 00 00    	pushl  0x19cc
 6db:	e8 c0 05 00 00       	call   ca0 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 6e0:	83 c4 14             	add    $0x14,%esp
 6e3:	ff 75 dc             	pushl  -0x24(%ebp)
 6e6:	e8 6f 04 00 00       	call   b5a <close>
    return addr == atoi(answer);
 6eb:	89 34 24             	mov    %esi,(%esp)
 6ee:	e8 cd 03 00 00       	call   ac0 <atoi>
 6f3:	83 c4 10             	add    $0x10,%esp
 6f6:	39 d8                	cmp    %ebx,%eax
 6f8:	0f 94 c0             	sete   %al
  }
  return TRUE;
}
 6fb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6fe:	0f b6 c0             	movzbl %al,%eax
 701:	5b                   	pop    %ebx
 702:	5e                   	pop    %esi
 703:	5d                   	pop    %ebp
 704:	c3                   	ret    
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL1_RO
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 705:	83 ec 0c             	sub    $0xc,%esp
 708:	68 c4 19 00 00       	push   $0x19c4
 70d:	e8 c8 04 00 00       	call   bda <virt2real>
 712:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 714:	c1 f8 1f             	sar    $0x1f,%eax
 717:	83 c4 0c             	add    $0xc,%esp
 71a:	31 c3                	xor    %eax,%ebx
 71c:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 5.1] Child write %d\n", addr);
 71e:	53                   	push   %ebx
 71f:	68 54 13 00 00       	push   $0x1354
 724:	ff 35 cc 19 00 00    	pushl  0x19cc
 72a:	e8 71 05 00 00       	call   ca0 <printf>
    close(fd[0]);
 72f:	5e                   	pop    %esi
 730:	ff 75 dc             	pushl  -0x24(%ebp)
 733:	e8 22 04 00 00       	call   b5a <close>
    printf(fd[1], "%d\0", addr);
 738:	83 c4 0c             	add    $0xc,%esp
 73b:	53                   	push   %ebx
 73c:	68 24 13 00 00       	push   $0x1324
 741:	ff 75 e0             	pushl  -0x20(%ebp)
 744:	e8 57 05 00 00       	call   ca0 <printf>
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
 749:	58                   	pop    %eax
 74a:	5a                   	pop    %edx
 74b:	68 5c 11 00 00       	push   $0x115c
 750:	ff 35 cc 19 00 00    	pushl  0x19cc
 756:	e8 45 05 00 00       	call   ca0 <printf>
    close(fd[1]);
 75b:	59                   	pop    %ecx
 75c:	ff 75 e0             	pushl  -0x20(%ebp)
 75f:	e8 f6 03 00 00       	call   b5a <close>
    exit();
 764:	e8 c9 03 00 00       	call   b32 <exit>
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000770 <caso6cow>:


// testa que o processo parent e child tem o addr diferentes
// após um write em uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso6cow(void) {
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	56                   	push   %esi
 774:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 775:	8d 45 dc             	lea    -0x24(%ebp),%eax


// testa que o processo parent e child tem o addr diferentes
// após um write em uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso6cow(void) {
 778:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 77b:	50                   	push   %eax
 77c:	e8 c1 03 00 00       	call   b42 <pipe>
  char answer[20];
  int pid = forkcow();
 781:	e8 64 04 00 00       	call   bea <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL2_RW
 786:	83 c4 10             	add    $0x10,%esp
 789:	85 c0                	test   %eax,%eax
 78b:	0f 84 84 00 00 00    	je     815 <caso6cow+0xa5>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 791:	83 ec 0c             	sub    $0xc,%esp
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
    wait();
    printf(stdout, "[--Caso 6.3] Parent lendo addr\n");
    read(fd[0], answer, 20);
 794:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 797:	68 c4 19 00 00       	push   $0x19c4
 79c:	e8 39 04 00 00       	call   bda <virt2real>
 7a1:	99                   	cltd   
 7a2:	31 d0                	xor    %edx,%eax
 7a4:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 7a6:	58                   	pop    %eax
 7a7:	ff 75 e0             	pushl  -0x20(%ebp)
 7aa:	29 d3                	sub    %edx,%ebx
 7ac:	e8 a9 03 00 00       	call   b5a <close>
    wait();
 7b1:	e8 84 03 00 00       	call   b3a <wait>
    printf(stdout, "[--Caso 6.3] Parent lendo addr\n");
 7b6:	5a                   	pop    %edx
 7b7:	59                   	pop    %ecx
 7b8:	68 e0 11 00 00       	push   $0x11e0
 7bd:	ff 35 cc 19 00 00    	pushl  0x19cc
 7c3:	e8 d8 04 00 00       	call   ca0 <printf>
    read(fd[0], answer, 20);
 7c8:	83 c4 0c             	add    $0xc,%esp
 7cb:	6a 14                	push   $0x14
 7cd:	56                   	push   %esi
 7ce:	ff 75 dc             	pushl  -0x24(%ebp)
 7d1:	e8 74 03 00 00       	call   b4a <read>
    printf(stdout, "[--Caso 6.4] Parent leu %d != %d\n",
 7d6:	89 34 24             	mov    %esi,(%esp)
 7d9:	e8 e2 02 00 00       	call   ac0 <atoi>
 7de:	50                   	push   %eax
 7df:	53                   	push   %ebx
 7e0:	68 00 12 00 00       	push   $0x1200
 7e5:	ff 35 cc 19 00 00    	pushl  0x19cc
 7eb:	e8 b0 04 00 00       	call   ca0 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 7f0:	83 c4 14             	add    $0x14,%esp
 7f3:	ff 75 dc             	pushl  -0x24(%ebp)
 7f6:	e8 5f 03 00 00       	call   b5a <close>
    return addr != atoi(answer);
 7fb:	89 34 24             	mov    %esi,(%esp)
 7fe:	e8 bd 02 00 00       	call   ac0 <atoi>
 803:	83 c4 10             	add    $0x10,%esp
 806:	39 d8                	cmp    %ebx,%eax
 808:	0f 95 c0             	setne  %al
  }
  return TRUE;
}
 80b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 80e:	0f b6 c0             	movzbl %al,%eax
 811:	5b                   	pop    %ebx
 812:	5e                   	pop    %esi
 813:	5d                   	pop    %ebp
 814:	c3                   	ret    
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL2_RW
    GLOBAL2_RW--;
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 815:	83 ec 0c             	sub    $0xc,%esp
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL2_RW
    GLOBAL2_RW--;
 818:	83 2d c4 19 00 00 01 	subl   $0x1,0x19c4
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 81f:	68 c4 19 00 00       	push   $0x19c4
 824:	e8 b1 03 00 00       	call   bda <virt2real>
 829:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 82b:	c1 f8 1f             	sar    $0x1f,%eax
 82e:	83 c4 0c             	add    $0xc,%esp
 831:	31 c3                	xor    %eax,%ebx
 833:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 6.1] Child write %d\n", addr);
 835:	53                   	push   %ebx
 836:	68 71 13 00 00       	push   $0x1371
 83b:	ff 35 cc 19 00 00    	pushl  0x19cc
 841:	e8 5a 04 00 00       	call   ca0 <printf>
    close(fd[0]);
 846:	5e                   	pop    %esi
 847:	ff 75 dc             	pushl  -0x24(%ebp)
 84a:	e8 0b 03 00 00       	call   b5a <close>
    printf(fd[1], "%d\0", addr);
 84f:	83 c4 0c             	add    $0xc,%esp
 852:	53                   	push   %ebx
 853:	68 24 13 00 00       	push   $0x1324
 858:	ff 75 e0             	pushl  -0x20(%ebp)
 85b:	e8 40 04 00 00       	call   ca0 <printf>
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
 860:	58                   	pop    %eax
 861:	5a                   	pop    %edx
 862:	68 c0 11 00 00       	push   $0x11c0
 867:	ff 35 cc 19 00 00    	pushl  0x19cc
 86d:	e8 2e 04 00 00       	call   ca0 <printf>
    close(fd[1]);
 872:	59                   	pop    %ecx
 873:	ff 75 e0             	pushl  -0x20(%ebp)
 876:	e8 df 02 00 00       	call   b5a <close>
    exit();
 87b:	e8 b2 02 00 00       	call   b32 <exit>

00000880 <get_date>:
  }
  return TRUE;
}

// testa a chamada date
int get_date(struct rtcdate *r) {
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	83 ec 14             	sub    $0x14,%esp
  if (date(r)) {
 886:	ff 75 08             	pushl  0x8(%ebp)
 889:	e8 44 03 00 00       	call   bd2 <date>
 88e:	83 c4 10             	add    $0x10,%esp
 891:	85 c0                	test   %eax,%eax
 893:	ba 01 00 00 00       	mov    $0x1,%edx
 898:	74 18                	je     8b2 <get_date+0x32>
    printf(stderr, "[ERROR] Erro na chamada de sistema date\n");
 89a:	83 ec 08             	sub    $0x8,%esp
 89d:	68 24 12 00 00       	push   $0x1224
 8a2:	ff 35 c8 19 00 00    	pushl  0x19c8
 8a8:	e8 f3 03 00 00       	call   ca0 <printf>
 8ad:	83 c4 10             	add    $0x10,%esp
 8b0:	31 d2                	xor    %edx,%edx
    return FALSE;
  }
  return TRUE;
}
 8b2:	89 d0                	mov    %edx,%eax
 8b4:	c9                   	leave  
 8b5:	c3                   	ret    
 8b6:	8d 76 00             	lea    0x0(%esi),%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008c0 <print_date>:


void print_date(struct rtcdate *r) {
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	83 ec 08             	sub    $0x8,%esp
 8c6:	8b 45 08             	mov    0x8(%ebp),%eax
  printf(stdout, "%d/%d/%d %d:%d:%d\n", r->day,
 8c9:	ff 30                	pushl  (%eax)
 8cb:	ff 70 04             	pushl  0x4(%eax)
 8ce:	ff 70 08             	pushl  0x8(%eax)
 8d1:	ff 70 14             	pushl  0x14(%eax)
 8d4:	ff 70 10             	pushl  0x10(%eax)
 8d7:	ff 70 0c             	pushl  0xc(%eax)
 8da:	68 8e 13 00 00       	push   $0x138e
 8df:	ff 35 cc 19 00 00    	pushl  0x19cc
 8e5:	e8 b6 03 00 00       	call   ca0 <printf>
                                        r->month,
                                        r->year,
                                        r->hour,
                                        r->minute,
                                        r->second);
}
 8ea:	83 c4 20             	add    $0x20,%esp
 8ed:	c9                   	leave  
 8ee:	c3                   	ret    
 8ef:	90                   	nop

000008f0 <strcpy>:
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	8b 45 08             	mov    0x8(%ebp),%eax
 8f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 8fa:	89 c2                	mov    %eax,%edx
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 900:	83 c1 01             	add    $0x1,%ecx
 903:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 907:	83 c2 01             	add    $0x1,%edx
 90a:	84 db                	test   %bl,%bl
 90c:	88 5a ff             	mov    %bl,-0x1(%edx)
 90f:	75 ef                	jne    900 <strcpy+0x10>
 911:	5b                   	pop    %ebx
 912:	5d                   	pop    %ebp
 913:	c3                   	ret    
 914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 91a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000920 <strcmp>:
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	56                   	push   %esi
 924:	53                   	push   %ebx
 925:	8b 55 08             	mov    0x8(%ebp),%edx
 928:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 92b:	0f b6 02             	movzbl (%edx),%eax
 92e:	0f b6 19             	movzbl (%ecx),%ebx
 931:	84 c0                	test   %al,%al
 933:	75 1e                	jne    953 <strcmp+0x33>
 935:	eb 29                	jmp    960 <strcmp+0x40>
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 940:	83 c2 01             	add    $0x1,%edx
 943:	0f b6 02             	movzbl (%edx),%eax
 946:	8d 71 01             	lea    0x1(%ecx),%esi
 949:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 94d:	84 c0                	test   %al,%al
 94f:	74 0f                	je     960 <strcmp+0x40>
 951:	89 f1                	mov    %esi,%ecx
 953:	38 d8                	cmp    %bl,%al
 955:	74 e9                	je     940 <strcmp+0x20>
 957:	29 d8                	sub    %ebx,%eax
 959:	5b                   	pop    %ebx
 95a:	5e                   	pop    %esi
 95b:	5d                   	pop    %ebp
 95c:	c3                   	ret    
 95d:	8d 76 00             	lea    0x0(%esi),%esi
 960:	31 c0                	xor    %eax,%eax
 962:	29 d8                	sub    %ebx,%eax
 964:	5b                   	pop    %ebx
 965:	5e                   	pop    %esi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	90                   	nop
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000970 <strlen>:
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	8b 4d 08             	mov    0x8(%ebp),%ecx
 976:	80 39 00             	cmpb   $0x0,(%ecx)
 979:	74 12                	je     98d <strlen+0x1d>
 97b:	31 d2                	xor    %edx,%edx
 97d:	8d 76 00             	lea    0x0(%esi),%esi
 980:	83 c2 01             	add    $0x1,%edx
 983:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 987:	89 d0                	mov    %edx,%eax
 989:	75 f5                	jne    980 <strlen+0x10>
 98b:	5d                   	pop    %ebp
 98c:	c3                   	ret    
 98d:	31 c0                	xor    %eax,%eax
 98f:	5d                   	pop    %ebp
 990:	c3                   	ret    
 991:	eb 0d                	jmp    9a0 <memset>
 993:	90                   	nop
 994:	90                   	nop
 995:	90                   	nop
 996:	90                   	nop
 997:	90                   	nop
 998:	90                   	nop
 999:	90                   	nop
 99a:	90                   	nop
 99b:	90                   	nop
 99c:	90                   	nop
 99d:	90                   	nop
 99e:	90                   	nop
 99f:	90                   	nop

000009a0 <memset>:
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	8b 55 08             	mov    0x8(%ebp),%edx
 9a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 9aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 9ad:	89 d7                	mov    %edx,%edi
 9af:	fc                   	cld    
 9b0:	f3 aa                	rep stos %al,%es:(%edi)
 9b2:	89 d0                	mov    %edx,%eax
 9b4:	5f                   	pop    %edi
 9b5:	5d                   	pop    %ebp
 9b6:	c3                   	ret    
 9b7:	89 f6                	mov    %esi,%esi
 9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <strchr>:
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	53                   	push   %ebx
 9c4:	8b 45 08             	mov    0x8(%ebp),%eax
 9c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 9ca:	0f b6 10             	movzbl (%eax),%edx
 9cd:	84 d2                	test   %dl,%dl
 9cf:	74 1d                	je     9ee <strchr+0x2e>
 9d1:	38 d3                	cmp    %dl,%bl
 9d3:	89 d9                	mov    %ebx,%ecx
 9d5:	75 0d                	jne    9e4 <strchr+0x24>
 9d7:	eb 17                	jmp    9f0 <strchr+0x30>
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9e0:	38 ca                	cmp    %cl,%dl
 9e2:	74 0c                	je     9f0 <strchr+0x30>
 9e4:	83 c0 01             	add    $0x1,%eax
 9e7:	0f b6 10             	movzbl (%eax),%edx
 9ea:	84 d2                	test   %dl,%dl
 9ec:	75 f2                	jne    9e0 <strchr+0x20>
 9ee:	31 c0                	xor    %eax,%eax
 9f0:	5b                   	pop    %ebx
 9f1:	5d                   	pop    %ebp
 9f2:	c3                   	ret    
 9f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <gets>:
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	57                   	push   %edi
 a04:	56                   	push   %esi
 a05:	53                   	push   %ebx
 a06:	31 f6                	xor    %esi,%esi
 a08:	8d 7d e7             	lea    -0x19(%ebp),%edi
 a0b:	83 ec 1c             	sub    $0x1c,%esp
 a0e:	eb 29                	jmp    a39 <gets+0x39>
 a10:	83 ec 04             	sub    $0x4,%esp
 a13:	6a 01                	push   $0x1
 a15:	57                   	push   %edi
 a16:	6a 00                	push   $0x0
 a18:	e8 2d 01 00 00       	call   b4a <read>
 a1d:	83 c4 10             	add    $0x10,%esp
 a20:	85 c0                	test   %eax,%eax
 a22:	7e 1d                	jle    a41 <gets+0x41>
 a24:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 a28:	8b 55 08             	mov    0x8(%ebp),%edx
 a2b:	89 de                	mov    %ebx,%esi
 a2d:	3c 0a                	cmp    $0xa,%al
 a2f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 a33:	74 1b                	je     a50 <gets+0x50>
 a35:	3c 0d                	cmp    $0xd,%al
 a37:	74 17                	je     a50 <gets+0x50>
 a39:	8d 5e 01             	lea    0x1(%esi),%ebx
 a3c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 a3f:	7c cf                	jl     a10 <gets+0x10>
 a41:	8b 45 08             	mov    0x8(%ebp),%eax
 a44:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a4b:	5b                   	pop    %ebx
 a4c:	5e                   	pop    %esi
 a4d:	5f                   	pop    %edi
 a4e:	5d                   	pop    %ebp
 a4f:	c3                   	ret    
 a50:	8b 45 08             	mov    0x8(%ebp),%eax
 a53:	89 de                	mov    %ebx,%esi
 a55:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 a59:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a5c:	5b                   	pop    %ebx
 a5d:	5e                   	pop    %esi
 a5e:	5f                   	pop    %edi
 a5f:	5d                   	pop    %ebp
 a60:	c3                   	ret    
 a61:	eb 0d                	jmp    a70 <stat>
 a63:	90                   	nop
 a64:	90                   	nop
 a65:	90                   	nop
 a66:	90                   	nop
 a67:	90                   	nop
 a68:	90                   	nop
 a69:	90                   	nop
 a6a:	90                   	nop
 a6b:	90                   	nop
 a6c:	90                   	nop
 a6d:	90                   	nop
 a6e:	90                   	nop
 a6f:	90                   	nop

00000a70 <stat>:
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	56                   	push   %esi
 a74:	53                   	push   %ebx
 a75:	83 ec 08             	sub    $0x8,%esp
 a78:	6a 00                	push   $0x0
 a7a:	ff 75 08             	pushl  0x8(%ebp)
 a7d:	e8 f0 00 00 00       	call   b72 <open>
 a82:	83 c4 10             	add    $0x10,%esp
 a85:	85 c0                	test   %eax,%eax
 a87:	78 27                	js     ab0 <stat+0x40>
 a89:	83 ec 08             	sub    $0x8,%esp
 a8c:	ff 75 0c             	pushl  0xc(%ebp)
 a8f:	89 c3                	mov    %eax,%ebx
 a91:	50                   	push   %eax
 a92:	e8 f3 00 00 00       	call   b8a <fstat>
 a97:	89 c6                	mov    %eax,%esi
 a99:	89 1c 24             	mov    %ebx,(%esp)
 a9c:	e8 b9 00 00 00       	call   b5a <close>
 aa1:	83 c4 10             	add    $0x10,%esp
 aa4:	89 f0                	mov    %esi,%eax
 aa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 aa9:	5b                   	pop    %ebx
 aaa:	5e                   	pop    %esi
 aab:	5d                   	pop    %ebp
 aac:	c3                   	ret    
 aad:	8d 76 00             	lea    0x0(%esi),%esi
 ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ab5:	eb ef                	jmp    aa6 <stat+0x36>
 ab7:	89 f6                	mov    %esi,%esi
 ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ac0 <atoi>:
 ac0:	55                   	push   %ebp
 ac1:	89 e5                	mov    %esp,%ebp
 ac3:	53                   	push   %ebx
 ac4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 ac7:	0f be 11             	movsbl (%ecx),%edx
 aca:	8d 42 d0             	lea    -0x30(%edx),%eax
 acd:	3c 09                	cmp    $0x9,%al
 acf:	b8 00 00 00 00       	mov    $0x0,%eax
 ad4:	77 1f                	ja     af5 <atoi+0x35>
 ad6:	8d 76 00             	lea    0x0(%esi),%esi
 ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 ae0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 ae3:	83 c1 01             	add    $0x1,%ecx
 ae6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 aea:	0f be 11             	movsbl (%ecx),%edx
 aed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 af0:	80 fb 09             	cmp    $0x9,%bl
 af3:	76 eb                	jbe    ae0 <atoi+0x20>
 af5:	5b                   	pop    %ebx
 af6:	5d                   	pop    %ebp
 af7:	c3                   	ret    
 af8:	90                   	nop
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b00 <memmove>:
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	56                   	push   %esi
 b04:	53                   	push   %ebx
 b05:	8b 5d 10             	mov    0x10(%ebp),%ebx
 b08:	8b 45 08             	mov    0x8(%ebp),%eax
 b0b:	8b 75 0c             	mov    0xc(%ebp),%esi
 b0e:	85 db                	test   %ebx,%ebx
 b10:	7e 14                	jle    b26 <memmove+0x26>
 b12:	31 d2                	xor    %edx,%edx
 b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b18:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 b1c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 b1f:	83 c2 01             	add    $0x1,%edx
 b22:	39 da                	cmp    %ebx,%edx
 b24:	75 f2                	jne    b18 <memmove+0x18>
 b26:	5b                   	pop    %ebx
 b27:	5e                   	pop    %esi
 b28:	5d                   	pop    %ebp
 b29:	c3                   	ret    

00000b2a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b2a:	b8 01 00 00 00       	mov    $0x1,%eax
 b2f:	cd 40                	int    $0x40
 b31:	c3                   	ret    

00000b32 <exit>:
SYSCALL(exit)
 b32:	b8 02 00 00 00       	mov    $0x2,%eax
 b37:	cd 40                	int    $0x40
 b39:	c3                   	ret    

00000b3a <wait>:
SYSCALL(wait)
 b3a:	b8 03 00 00 00       	mov    $0x3,%eax
 b3f:	cd 40                	int    $0x40
 b41:	c3                   	ret    

00000b42 <pipe>:
SYSCALL(pipe)
 b42:	b8 04 00 00 00       	mov    $0x4,%eax
 b47:	cd 40                	int    $0x40
 b49:	c3                   	ret    

00000b4a <read>:
SYSCALL(read)
 b4a:	b8 05 00 00 00       	mov    $0x5,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <write>:
SYSCALL(write)
 b52:	b8 10 00 00 00       	mov    $0x10,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <close>:
SYSCALL(close)
 b5a:	b8 15 00 00 00       	mov    $0x15,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <kill>:
SYSCALL(kill)
 b62:	b8 06 00 00 00       	mov    $0x6,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <exec>:
SYSCALL(exec)
 b6a:	b8 07 00 00 00       	mov    $0x7,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    

00000b72 <open>:
SYSCALL(open)
 b72:	b8 0f 00 00 00       	mov    $0xf,%eax
 b77:	cd 40                	int    $0x40
 b79:	c3                   	ret    

00000b7a <mknod>:
SYSCALL(mknod)
 b7a:	b8 11 00 00 00       	mov    $0x11,%eax
 b7f:	cd 40                	int    $0x40
 b81:	c3                   	ret    

00000b82 <unlink>:
SYSCALL(unlink)
 b82:	b8 12 00 00 00       	mov    $0x12,%eax
 b87:	cd 40                	int    $0x40
 b89:	c3                   	ret    

00000b8a <fstat>:
SYSCALL(fstat)
 b8a:	b8 08 00 00 00       	mov    $0x8,%eax
 b8f:	cd 40                	int    $0x40
 b91:	c3                   	ret    

00000b92 <link>:
SYSCALL(link)
 b92:	b8 13 00 00 00       	mov    $0x13,%eax
 b97:	cd 40                	int    $0x40
 b99:	c3                   	ret    

00000b9a <mkdir>:
SYSCALL(mkdir)
 b9a:	b8 14 00 00 00       	mov    $0x14,%eax
 b9f:	cd 40                	int    $0x40
 ba1:	c3                   	ret    

00000ba2 <chdir>:
SYSCALL(chdir)
 ba2:	b8 09 00 00 00       	mov    $0x9,%eax
 ba7:	cd 40                	int    $0x40
 ba9:	c3                   	ret    

00000baa <dup>:
SYSCALL(dup)
 baa:	b8 0a 00 00 00       	mov    $0xa,%eax
 baf:	cd 40                	int    $0x40
 bb1:	c3                   	ret    

00000bb2 <getpid>:
SYSCALL(getpid)
 bb2:	b8 0b 00 00 00       	mov    $0xb,%eax
 bb7:	cd 40                	int    $0x40
 bb9:	c3                   	ret    

00000bba <sbrk>:
SYSCALL(sbrk)
 bba:	b8 0c 00 00 00       	mov    $0xc,%eax
 bbf:	cd 40                	int    $0x40
 bc1:	c3                   	ret    

00000bc2 <sleep>:
SYSCALL(sleep)
 bc2:	b8 0d 00 00 00       	mov    $0xd,%eax
 bc7:	cd 40                	int    $0x40
 bc9:	c3                   	ret    

00000bca <uptime>:
SYSCALL(uptime)
 bca:	b8 0e 00 00 00       	mov    $0xe,%eax
 bcf:	cd 40                	int    $0x40
 bd1:	c3                   	ret    

00000bd2 <date>:
SYSCALL(date)
 bd2:	b8 16 00 00 00       	mov    $0x16,%eax
 bd7:	cd 40                	int    $0x40
 bd9:	c3                   	ret    

00000bda <virt2real>:
SYSCALL(virt2real)
 bda:	b8 17 00 00 00       	mov    $0x17,%eax
 bdf:	cd 40                	int    $0x40
 be1:	c3                   	ret    

00000be2 <num_pages>:
SYSCALL(num_pages)
 be2:	b8 18 00 00 00       	mov    $0x18,%eax
 be7:	cd 40                	int    $0x40
 be9:	c3                   	ret    

00000bea <forkcow>:
SYSCALL(forkcow)
 bea:	b8 19 00 00 00       	mov    $0x19,%eax
 bef:	cd 40                	int    $0x40
 bf1:	c3                   	ret    
 bf2:	66 90                	xchg   %ax,%ax
 bf4:	66 90                	xchg   %ax,%ax
 bf6:	66 90                	xchg   %ax,%ax
 bf8:	66 90                	xchg   %ax,%ax
 bfa:	66 90                	xchg   %ax,%ax
 bfc:	66 90                	xchg   %ax,%ax
 bfe:	66 90                	xchg   %ax,%ax

00000c00 <printint>:
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	89 c6                	mov    %eax,%esi
 c08:	83 ec 3c             	sub    $0x3c,%esp
 c0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c0e:	85 db                	test   %ebx,%ebx
 c10:	74 7e                	je     c90 <printint+0x90>
 c12:	89 d0                	mov    %edx,%eax
 c14:	c1 e8 1f             	shr    $0x1f,%eax
 c17:	84 c0                	test   %al,%al
 c19:	74 75                	je     c90 <printint+0x90>
 c1b:	89 d0                	mov    %edx,%eax
 c1d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 c24:	f7 d8                	neg    %eax
 c26:	89 75 c0             	mov    %esi,-0x40(%ebp)
 c29:	31 ff                	xor    %edi,%edi
 c2b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 c2e:	89 ce                	mov    %ecx,%esi
 c30:	eb 08                	jmp    c3a <printint+0x3a>
 c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 c38:	89 cf                	mov    %ecx,%edi
 c3a:	31 d2                	xor    %edx,%edx
 c3c:	8d 4f 01             	lea    0x1(%edi),%ecx
 c3f:	f7 f6                	div    %esi
 c41:	0f b6 92 c8 15 00 00 	movzbl 0x15c8(%edx),%edx
 c48:	85 c0                	test   %eax,%eax
 c4a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 c4d:	75 e9                	jne    c38 <printint+0x38>
 c4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 c52:	8b 75 c0             	mov    -0x40(%ebp),%esi
 c55:	85 c0                	test   %eax,%eax
 c57:	74 08                	je     c61 <printint+0x61>
 c59:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 c5e:	8d 4f 02             	lea    0x2(%edi),%ecx
 c61:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 c65:	8d 76 00             	lea    0x0(%esi),%esi
 c68:	0f b6 07             	movzbl (%edi),%eax
 c6b:	83 ec 04             	sub    $0x4,%esp
 c6e:	83 ef 01             	sub    $0x1,%edi
 c71:	6a 01                	push   $0x1
 c73:	53                   	push   %ebx
 c74:	56                   	push   %esi
 c75:	88 45 d7             	mov    %al,-0x29(%ebp)
 c78:	e8 d5 fe ff ff       	call   b52 <write>
 c7d:	83 c4 10             	add    $0x10,%esp
 c80:	39 df                	cmp    %ebx,%edi
 c82:	75 e4                	jne    c68 <printint+0x68>
 c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c87:	5b                   	pop    %ebx
 c88:	5e                   	pop    %esi
 c89:	5f                   	pop    %edi
 c8a:	5d                   	pop    %ebp
 c8b:	c3                   	ret    
 c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 c90:	89 d0                	mov    %edx,%eax
 c92:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c99:	eb 8b                	jmp    c26 <printint+0x26>
 c9b:	90                   	nop
 c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ca0 <printf>:
 ca0:	55                   	push   %ebp
 ca1:	89 e5                	mov    %esp,%ebp
 ca3:	57                   	push   %edi
 ca4:	56                   	push   %esi
 ca5:	53                   	push   %ebx
 ca6:	8d 45 10             	lea    0x10(%ebp),%eax
 ca9:	83 ec 2c             	sub    $0x2c,%esp
 cac:	8b 75 0c             	mov    0xc(%ebp),%esi
 caf:	8b 7d 08             	mov    0x8(%ebp),%edi
 cb2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 cb5:	0f b6 1e             	movzbl (%esi),%ebx
 cb8:	83 c6 01             	add    $0x1,%esi
 cbb:	84 db                	test   %bl,%bl
 cbd:	0f 84 b0 00 00 00    	je     d73 <printf+0xd3>
 cc3:	31 d2                	xor    %edx,%edx
 cc5:	eb 39                	jmp    d00 <printf+0x60>
 cc7:	89 f6                	mov    %esi,%esi
 cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 cd0:	83 f8 25             	cmp    $0x25,%eax
 cd3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 cd6:	ba 25 00 00 00       	mov    $0x25,%edx
 cdb:	74 18                	je     cf5 <printf+0x55>
 cdd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 ce0:	83 ec 04             	sub    $0x4,%esp
 ce3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 ce6:	6a 01                	push   $0x1
 ce8:	50                   	push   %eax
 ce9:	57                   	push   %edi
 cea:	e8 63 fe ff ff       	call   b52 <write>
 cef:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 cf2:	83 c4 10             	add    $0x10,%esp
 cf5:	83 c6 01             	add    $0x1,%esi
 cf8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 cfc:	84 db                	test   %bl,%bl
 cfe:	74 73                	je     d73 <printf+0xd3>
 d00:	85 d2                	test   %edx,%edx
 d02:	0f be cb             	movsbl %bl,%ecx
 d05:	0f b6 c3             	movzbl %bl,%eax
 d08:	74 c6                	je     cd0 <printf+0x30>
 d0a:	83 fa 25             	cmp    $0x25,%edx
 d0d:	75 e6                	jne    cf5 <printf+0x55>
 d0f:	83 f8 64             	cmp    $0x64,%eax
 d12:	0f 84 f8 00 00 00    	je     e10 <printf+0x170>
 d18:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 d1e:	83 f9 70             	cmp    $0x70,%ecx
 d21:	74 5d                	je     d80 <printf+0xe0>
 d23:	83 f8 73             	cmp    $0x73,%eax
 d26:	0f 84 84 00 00 00    	je     db0 <printf+0x110>
 d2c:	83 f8 63             	cmp    $0x63,%eax
 d2f:	0f 84 ea 00 00 00    	je     e1f <printf+0x17f>
 d35:	83 f8 25             	cmp    $0x25,%eax
 d38:	0f 84 c2 00 00 00    	je     e00 <printf+0x160>
 d3e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d41:	83 ec 04             	sub    $0x4,%esp
 d44:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d48:	6a 01                	push   $0x1
 d4a:	50                   	push   %eax
 d4b:	57                   	push   %edi
 d4c:	e8 01 fe ff ff       	call   b52 <write>
 d51:	83 c4 0c             	add    $0xc,%esp
 d54:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d57:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d5a:	6a 01                	push   $0x1
 d5c:	50                   	push   %eax
 d5d:	57                   	push   %edi
 d5e:	83 c6 01             	add    $0x1,%esi
 d61:	e8 ec fd ff ff       	call   b52 <write>
 d66:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 d6a:	83 c4 10             	add    $0x10,%esp
 d6d:	31 d2                	xor    %edx,%edx
 d6f:	84 db                	test   %bl,%bl
 d71:	75 8d                	jne    d00 <printf+0x60>
 d73:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d76:	5b                   	pop    %ebx
 d77:	5e                   	pop    %esi
 d78:	5f                   	pop    %edi
 d79:	5d                   	pop    %ebp
 d7a:	c3                   	ret    
 d7b:	90                   	nop
 d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d80:	83 ec 0c             	sub    $0xc,%esp
 d83:	b9 10 00 00 00       	mov    $0x10,%ecx
 d88:	6a 00                	push   $0x0
 d8a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d8d:	89 f8                	mov    %edi,%eax
 d8f:	8b 13                	mov    (%ebx),%edx
 d91:	e8 6a fe ff ff       	call   c00 <printint>
 d96:	89 d8                	mov    %ebx,%eax
 d98:	83 c4 10             	add    $0x10,%esp
 d9b:	31 d2                	xor    %edx,%edx
 d9d:	83 c0 04             	add    $0x4,%eax
 da0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 da3:	e9 4d ff ff ff       	jmp    cf5 <printf+0x55>
 da8:	90                   	nop
 da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 db0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 db3:	8b 18                	mov    (%eax),%ebx
 db5:	83 c0 04             	add    $0x4,%eax
 db8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 dbb:	b8 bf 15 00 00       	mov    $0x15bf,%eax
 dc0:	85 db                	test   %ebx,%ebx
 dc2:	0f 44 d8             	cmove  %eax,%ebx
 dc5:	0f b6 03             	movzbl (%ebx),%eax
 dc8:	84 c0                	test   %al,%al
 dca:	74 23                	je     def <printf+0x14f>
 dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 dd0:	88 45 e3             	mov    %al,-0x1d(%ebp)
 dd3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 dd6:	83 ec 04             	sub    $0x4,%esp
 dd9:	6a 01                	push   $0x1
 ddb:	83 c3 01             	add    $0x1,%ebx
 dde:	50                   	push   %eax
 ddf:	57                   	push   %edi
 de0:	e8 6d fd ff ff       	call   b52 <write>
 de5:	0f b6 03             	movzbl (%ebx),%eax
 de8:	83 c4 10             	add    $0x10,%esp
 deb:	84 c0                	test   %al,%al
 ded:	75 e1                	jne    dd0 <printf+0x130>
 def:	31 d2                	xor    %edx,%edx
 df1:	e9 ff fe ff ff       	jmp    cf5 <printf+0x55>
 df6:	8d 76 00             	lea    0x0(%esi),%esi
 df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e00:	83 ec 04             	sub    $0x4,%esp
 e03:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 e06:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 e09:	6a 01                	push   $0x1
 e0b:	e9 4c ff ff ff       	jmp    d5c <printf+0xbc>
 e10:	83 ec 0c             	sub    $0xc,%esp
 e13:	b9 0a 00 00 00       	mov    $0xa,%ecx
 e18:	6a 01                	push   $0x1
 e1a:	e9 6b ff ff ff       	jmp    d8a <printf+0xea>
 e1f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 e22:	83 ec 04             	sub    $0x4,%esp
 e25:	8b 03                	mov    (%ebx),%eax
 e27:	6a 01                	push   $0x1
 e29:	88 45 e4             	mov    %al,-0x1c(%ebp)
 e2c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e2f:	50                   	push   %eax
 e30:	57                   	push   %edi
 e31:	e8 1c fd ff ff       	call   b52 <write>
 e36:	e9 5b ff ff ff       	jmp    d96 <printf+0xf6>
 e3b:	66 90                	xchg   %ax,%ax
 e3d:	66 90                	xchg   %ax,%ax
 e3f:	90                   	nop

00000e40 <free>:
 e40:	55                   	push   %ebp
 e41:	a1 d0 19 00 00       	mov    0x19d0,%eax
 e46:	89 e5                	mov    %esp,%ebp
 e48:	57                   	push   %edi
 e49:	56                   	push   %esi
 e4a:	53                   	push   %ebx
 e4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 e4e:	8b 10                	mov    (%eax),%edx
 e50:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e53:	39 c8                	cmp    %ecx,%eax
 e55:	73 19                	jae    e70 <free+0x30>
 e57:	89 f6                	mov    %esi,%esi
 e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e60:	39 d1                	cmp    %edx,%ecx
 e62:	72 1c                	jb     e80 <free+0x40>
 e64:	39 d0                	cmp    %edx,%eax
 e66:	73 18                	jae    e80 <free+0x40>
 e68:	89 d0                	mov    %edx,%eax
 e6a:	39 c8                	cmp    %ecx,%eax
 e6c:	8b 10                	mov    (%eax),%edx
 e6e:	72 f0                	jb     e60 <free+0x20>
 e70:	39 d0                	cmp    %edx,%eax
 e72:	72 f4                	jb     e68 <free+0x28>
 e74:	39 d1                	cmp    %edx,%ecx
 e76:	73 f0                	jae    e68 <free+0x28>
 e78:	90                   	nop
 e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 e80:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e83:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e86:	39 d7                	cmp    %edx,%edi
 e88:	74 19                	je     ea3 <free+0x63>
 e8a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 e8d:	8b 50 04             	mov    0x4(%eax),%edx
 e90:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e93:	39 f1                	cmp    %esi,%ecx
 e95:	74 23                	je     eba <free+0x7a>
 e97:	89 08                	mov    %ecx,(%eax)
 e99:	a3 d0 19 00 00       	mov    %eax,0x19d0
 e9e:	5b                   	pop    %ebx
 e9f:	5e                   	pop    %esi
 ea0:	5f                   	pop    %edi
 ea1:	5d                   	pop    %ebp
 ea2:	c3                   	ret    
 ea3:	03 72 04             	add    0x4(%edx),%esi
 ea6:	89 73 fc             	mov    %esi,-0x4(%ebx)
 ea9:	8b 10                	mov    (%eax),%edx
 eab:	8b 12                	mov    (%edx),%edx
 ead:	89 53 f8             	mov    %edx,-0x8(%ebx)
 eb0:	8b 50 04             	mov    0x4(%eax),%edx
 eb3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 eb6:	39 f1                	cmp    %esi,%ecx
 eb8:	75 dd                	jne    e97 <free+0x57>
 eba:	03 53 fc             	add    -0x4(%ebx),%edx
 ebd:	a3 d0 19 00 00       	mov    %eax,0x19d0
 ec2:	89 50 04             	mov    %edx,0x4(%eax)
 ec5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ec8:	89 10                	mov    %edx,(%eax)
 eca:	5b                   	pop    %ebx
 ecb:	5e                   	pop    %esi
 ecc:	5f                   	pop    %edi
 ecd:	5d                   	pop    %ebp
 ece:	c3                   	ret    
 ecf:	90                   	nop

00000ed0 <malloc>:
 ed0:	55                   	push   %ebp
 ed1:	89 e5                	mov    %esp,%ebp
 ed3:	57                   	push   %edi
 ed4:	56                   	push   %esi
 ed5:	53                   	push   %ebx
 ed6:	83 ec 0c             	sub    $0xc,%esp
 ed9:	8b 45 08             	mov    0x8(%ebp),%eax
 edc:	8b 15 d0 19 00 00    	mov    0x19d0,%edx
 ee2:	8d 78 07             	lea    0x7(%eax),%edi
 ee5:	c1 ef 03             	shr    $0x3,%edi
 ee8:	83 c7 01             	add    $0x1,%edi
 eeb:	85 d2                	test   %edx,%edx
 eed:	0f 84 a3 00 00 00    	je     f96 <malloc+0xc6>
 ef3:	8b 02                	mov    (%edx),%eax
 ef5:	8b 48 04             	mov    0x4(%eax),%ecx
 ef8:	39 cf                	cmp    %ecx,%edi
 efa:	76 74                	jbe    f70 <malloc+0xa0>
 efc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f02:	be 00 10 00 00       	mov    $0x1000,%esi
 f07:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 f0e:	0f 43 f7             	cmovae %edi,%esi
 f11:	ba 00 80 00 00       	mov    $0x8000,%edx
 f16:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 f1c:	0f 46 da             	cmovbe %edx,%ebx
 f1f:	eb 10                	jmp    f31 <malloc+0x61>
 f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 f28:	8b 02                	mov    (%edx),%eax
 f2a:	8b 48 04             	mov    0x4(%eax),%ecx
 f2d:	39 cf                	cmp    %ecx,%edi
 f2f:	76 3f                	jbe    f70 <malloc+0xa0>
 f31:	39 05 d0 19 00 00    	cmp    %eax,0x19d0
 f37:	89 c2                	mov    %eax,%edx
 f39:	75 ed                	jne    f28 <malloc+0x58>
 f3b:	83 ec 0c             	sub    $0xc,%esp
 f3e:	53                   	push   %ebx
 f3f:	e8 76 fc ff ff       	call   bba <sbrk>
 f44:	83 c4 10             	add    $0x10,%esp
 f47:	83 f8 ff             	cmp    $0xffffffff,%eax
 f4a:	74 1c                	je     f68 <malloc+0x98>
 f4c:	89 70 04             	mov    %esi,0x4(%eax)
 f4f:	83 ec 0c             	sub    $0xc,%esp
 f52:	83 c0 08             	add    $0x8,%eax
 f55:	50                   	push   %eax
 f56:	e8 e5 fe ff ff       	call   e40 <free>
 f5b:	8b 15 d0 19 00 00    	mov    0x19d0,%edx
 f61:	83 c4 10             	add    $0x10,%esp
 f64:	85 d2                	test   %edx,%edx
 f66:	75 c0                	jne    f28 <malloc+0x58>
 f68:	31 c0                	xor    %eax,%eax
 f6a:	eb 1c                	jmp    f88 <malloc+0xb8>
 f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 f70:	39 cf                	cmp    %ecx,%edi
 f72:	74 1c                	je     f90 <malloc+0xc0>
 f74:	29 f9                	sub    %edi,%ecx
 f76:	89 48 04             	mov    %ecx,0x4(%eax)
 f79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 f7c:	89 78 04             	mov    %edi,0x4(%eax)
 f7f:	89 15 d0 19 00 00    	mov    %edx,0x19d0
 f85:	83 c0 08             	add    $0x8,%eax
 f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f8b:	5b                   	pop    %ebx
 f8c:	5e                   	pop    %esi
 f8d:	5f                   	pop    %edi
 f8e:	5d                   	pop    %ebp
 f8f:	c3                   	ret    
 f90:	8b 08                	mov    (%eax),%ecx
 f92:	89 0a                	mov    %ecx,(%edx)
 f94:	eb e9                	jmp    f7f <malloc+0xaf>
 f96:	c7 05 d0 19 00 00 d4 	movl   $0x19d4,0x19d0
 f9d:	19 00 00 
 fa0:	c7 05 d4 19 00 00 d4 	movl   $0x19d4,0x19d4
 fa7:	19 00 00 
 faa:	b8 d4 19 00 00       	mov    $0x19d4,%eax
 faf:	c7 05 d8 19 00 00 00 	movl   $0x0,0x19d8
 fb6:	00 00 00 
 fb9:	e9 3e ff ff ff       	jmp    efc <malloc+0x2c>
