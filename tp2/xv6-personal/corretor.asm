
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
  15:	68 76 13 00 00       	push   $0x1376
  1a:	ff 35 a0 19 00 00    	pushl  0x19a0
  20:	e8 5b 0c 00 00       	call   c80 <printf>
  return TRUE;
}

// testa a chamada date
int get_date(struct rtcdate *r) {
  if (date(r)) {
  25:	89 1c 24             	mov    %ebx,(%esp)
  28:	e8 85 0b 00 00       	call   bb2 <date>
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
  38:	e8 63 08 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 0] OK\n");
  3d:	58                   	pop    %eax
  3e:	5a                   	pop    %edx
  3f:	68 6d 15 00 00       	push   $0x156d
  44:	ff 35 a0 19 00 00    	pushl  0x19a0
  4a:	e8 31 0c 00 00       	call   c80 <printf>

  get_date(&r);
  4f:	89 1c 24             	mov    %ebx,(%esp)
  52:	e8 09 08 00 00       	call   860 <get_date>
  print_date(&r);
  57:	89 1c 24             	mov    %ebx,(%esp)
  5a:	e8 41 08 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 1] Testando o fork\n");
  5f:	59                   	pop    %ecx
  60:	58                   	pop    %eax
  61:	68 7a 15 00 00       	push   $0x157a
  66:	ff 35 a0 19 00 00    	pushl  0x19a0
  6c:	e8 0f 0c 00 00       	call   c80 <printf>
  call_ok = caso1fork();
  71:	e8 ca 02 00 00       	call   340 <caso1fork>
  if (call_ok == FALSE) {
  76:	83 c4 10             	add    $0x10,%esp
  79:	85 c0                	test   %eax,%eax
  7b:	75 40                	jne    bd <main+0xbd>
    printf(stdout, "[Caso 1 - ERROR] Falhou!\n");
  7d:	51                   	push   %ecx
  7e:	51                   	push   %ecx
  7f:	68 aa 13 00 00       	push   $0x13aa
  84:	ff 35 a0 19 00 00    	pushl  0x19a0
  8a:	e8 f1 0b 00 00       	call   c80 <printf>
    exit();
  8f:	e8 7e 0a 00 00       	call   b12 <exit>
}

// testa a chamada date
int get_date(struct rtcdate *r) {
  if (date(r)) {
    printf(stderr, "[ERROR] Erro na chamada de sistema date\n");
  94:	53                   	push   %ebx
  95:	53                   	push   %ebx
  96:	68 04 12 00 00       	push   $0x1204
  9b:	ff 35 9c 19 00 00    	pushl  0x199c
  a1:	e8 da 0b 00 00       	call   c80 <printf>
  int call_ok = 1;

  printf(stdout, "[Caso 0] Testando o date\n");
  call_ok = get_date(&r);
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 0 - ERROR] Falhou!\n");
  a6:	58                   	pop    %eax
  a7:	5a                   	pop    %edx
  a8:	68 90 13 00 00       	push   $0x1390
  ad:	ff 35 a0 19 00 00    	pushl  0x19a0
  b3:	e8 c8 0b 00 00       	call   c80 <printf>
    exit();
  b8:	e8 55 0a 00 00       	call   b12 <exit>
  call_ok = caso1fork();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 1 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 1] OK\n");
  bd:	50                   	push   %eax
  be:	50                   	push   %eax
  bf:	68 c4 13 00 00       	push   $0x13c4
  c4:	ff 35 a0 19 00 00    	pushl  0x19a0
  ca:	e8 b1 0b 00 00       	call   c80 <printf>

  get_date(&r);
  cf:	89 1c 24             	mov    %ebx,(%esp)
  d2:	e8 89 07 00 00       	call   860 <get_date>
  print_date(&r);
  d7:	89 1c 24             	mov    %ebx,(%esp)
  da:	e8 c1 07 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 2] Testando o forkcow\n");
  df:	58                   	pop    %eax
  e0:	5a                   	pop    %edx
  e1:	68 d1 13 00 00       	push   $0x13d1
  e6:	ff 35 a0 19 00 00    	pushl  0x19a0
  ec:	e8 8f 0b 00 00       	call   c80 <printf>
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
  ff:	68 08 14 00 00       	push   $0x1408
 104:	ff 35 a0 19 00 00    	pushl  0x19a0
 10a:	e8 71 0b 00 00       	call   c80 <printf>

  get_date(&r);
 10f:	89 1c 24             	mov    %ebx,(%esp)
 112:	e8 49 07 00 00       	call   860 <get_date>
  print_date(&r);
 117:	89 1c 24             	mov    %ebx,(%esp)
 11a:	e8 81 07 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 3] Testando se o número de páginas é igual\n");
 11f:	58                   	pop    %eax
 120:	5a                   	pop    %edx
 121:	68 30 12 00 00       	push   $0x1230
 126:	ff 35 a0 19 00 00    	pushl  0x19a0
 12c:	e8 4f 0b 00 00       	call   c80 <printf>
  call_ok = caso3numpgs();
 131:	e8 0a 03 00 00       	call   440 <caso3numpgs>
  if (call_ok == FALSE) {
 136:	83 c4 10             	add    $0x10,%esp
 139:	85 c0                	test   %eax,%eax
 13b:	75 2e                	jne    16b <main+0x16b>
    printf(stdout, "[Caso 3 - ERROR] Falhou!\n");
 13d:	51                   	push   %ecx
 13e:	51                   	push   %ecx
 13f:	68 15 14 00 00       	push   $0x1415
 144:	ff 35 a0 19 00 00    	pushl  0x19a0
 14a:	e8 31 0b 00 00       	call   c80 <printf>
    exit();
 14f:	e8 be 09 00 00       	call   b12 <exit>
  get_date(&r);
  print_date(&r);
  printf(stdout, "[Caso 2] Testando o forkcow\n");
  call_ok = caso2forkcow();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 2 - ERROR] Falhou!\n");
 154:	51                   	push   %ecx
 155:	51                   	push   %ecx
 156:	68 ee 13 00 00       	push   $0x13ee
 15b:	ff 35 a0 19 00 00    	pushl  0x19a0
 161:	e8 1a 0b 00 00       	call   c80 <printf>
    exit();
 166:	e8 a7 09 00 00       	call   b12 <exit>
  call_ok = caso3numpgs();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 3 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 3] OK\n");
 16b:	50                   	push   %eax
 16c:	50                   	push   %eax
 16d:	68 2f 14 00 00       	push   $0x142f
 172:	ff 35 a0 19 00 00    	pushl  0x19a0
 178:	e8 03 0b 00 00       	call   c80 <printf>

  get_date(&r);
 17d:	89 1c 24             	mov    %ebx,(%esp)
 180:	e8 db 06 00 00       	call   860 <get_date>
  print_date(&r);
 185:	89 1c 24             	mov    %ebx,(%esp)
 188:	e8 13 07 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 4] Testando se o endereço de uma constante é =\n");
 18d:	58                   	pop    %eax
 18e:	5a                   	pop    %edx
 18f:	68 68 12 00 00       	push   $0x1268
 194:	ff 35 a0 19 00 00    	pushl  0x19a0
 19a:	e8 e1 0a 00 00       	call   c80 <printf>
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
 1ad:	68 56 14 00 00       	push   $0x1456
 1b2:	ff 35 a0 19 00 00    	pushl  0x19a0
 1b8:	e8 c3 0a 00 00       	call   c80 <printf>

  get_date(&r);
 1bd:	89 1c 24             	mov    %ebx,(%esp)
 1c0:	e8 9b 06 00 00       	call   860 <get_date>
  print_date(&r);
 1c5:	89 1c 24             	mov    %ebx,(%esp)
 1c8:	e8 d3 06 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 5] Testando se o endereço de uma global é =\n");
 1cd:	58                   	pop    %eax
 1ce:	5a                   	pop    %edx
 1cf:	68 a0 12 00 00       	push   $0x12a0
 1d4:	ff 35 a0 19 00 00    	pushl  0x19a0
 1da:	e8 a1 0a 00 00       	call   c80 <printf>
  call_ok = caso5mesmoaddr();
 1df:	e8 5c 04 00 00       	call   640 <caso5mesmoaddr>
  if (call_ok == FALSE) {
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	85 c0                	test   %eax,%eax
 1e9:	75 2e                	jne    219 <main+0x219>
    printf(stdout, "[Caso 5 - ERROR] Falhou!\n");
 1eb:	51                   	push   %ecx
 1ec:	51                   	push   %ecx
 1ed:	68 63 14 00 00       	push   $0x1463
 1f2:	ff 35 a0 19 00 00    	pushl  0x19a0
 1f8:	e8 83 0a 00 00       	call   c80 <printf>
    exit();
 1fd:	e8 10 09 00 00       	call   b12 <exit>
  get_date(&r);
  print_date(&r);
  printf(stdout, "[Caso 4] Testando se o endereço de uma constante é =\n");
  call_ok = caso4mesmoaddr();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 4 - ERROR] Falhou!\n");
 202:	51                   	push   %ecx
 203:	51                   	push   %ecx
 204:	68 3c 14 00 00       	push   $0x143c
 209:	ff 35 a0 19 00 00    	pushl  0x19a0
 20f:	e8 6c 0a 00 00       	call   c80 <printf>
    exit();
 214:	e8 f9 08 00 00       	call   b12 <exit>
  call_ok = caso5mesmoaddr();
  if (call_ok == FALSE) {
    printf(stdout, "[Caso 5 - ERROR] Falhou!\n");
    exit();
  }
  printf(stdout, "[Caso 5] OK\n");
 219:	50                   	push   %eax
 21a:	50                   	push   %eax
 21b:	68 7d 14 00 00       	push   $0x147d
 220:	ff 35 a0 19 00 00    	pushl  0x19a0
 226:	e8 55 0a 00 00       	call   c80 <printf>

  get_date(&r);
 22b:	89 1c 24             	mov    %ebx,(%esp)
 22e:	e8 2d 06 00 00       	call   860 <get_date>
  print_date(&r);
 233:	89 1c 24             	mov    %ebx,(%esp)
 236:	e8 65 06 00 00       	call   8a0 <print_date>
  printf(stdout, "[Caso 6] Testando o COW\n");
 23b:	58                   	pop    %eax
 23c:	5a                   	pop    %edx
 23d:	68 8a 14 00 00       	push   $0x148a
 242:	ff 35 a0 19 00 00    	pushl  0x19a0
 248:	e8 33 0a 00 00       	call   c80 <printf>
  call_ok = caso6cow();
 24d:	e8 fe 04 00 00       	call   750 <caso6cow>
  if (call_ok == FALSE) {
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	75 17                	jne    270 <main+0x270>
    printf(stdout, "[Caso 6 - ERROR] Falhou!\n");
 259:	50                   	push   %eax
 25a:	50                   	push   %eax
 25b:	68 a3 14 00 00       	push   $0x14a3
 260:	ff 35 a0 19 00 00    	pushl  0x19a0
 266:	e8 15 0a 00 00       	call   c80 <printf>
    exit();
 26b:	e8 a2 08 00 00       	call   b12 <exit>
  }
  printf(stdout, "[Caso 6] OK\n");
 270:	50                   	push   %eax
 271:	50                   	push   %eax
 272:	68 bd 14 00 00       	push   $0x14bd
 277:	ff 35 a0 19 00 00    	pushl  0x19a0
 27d:	e8 fe 09 00 00       	call   c80 <printf>
  printf(stdout, "\n");
 282:	58                   	pop    %eax
 283:	5a                   	pop    %edx
 284:	68 23 15 00 00       	push   $0x1523
 289:	ff 35 a0 19 00 00    	pushl  0x19a0
 28f:	e8 ec 09 00 00       	call   c80 <printf>
  printf(stdout, "         (__)        \n");
 294:	59                   	pop    %ecx
 295:	5b                   	pop    %ebx
 296:	68 ca 14 00 00       	push   $0x14ca
 29b:	ff 35 a0 19 00 00    	pushl  0x19a0
 2a1:	e8 da 09 00 00       	call   c80 <printf>
  printf(stdout, "         (oo)        \n");
 2a6:	58                   	pop    %eax
 2a7:	5a                   	pop    %edx
 2a8:	68 e1 14 00 00       	push   $0x14e1
 2ad:	ff 35 a0 19 00 00    	pushl  0x19a0
 2b3:	e8 c8 09 00 00       	call   c80 <printf>
  printf(stdout, "   /------\\/        \n");
 2b8:	59                   	pop    %ecx
 2b9:	5b                   	pop    %ebx
 2ba:	68 f8 14 00 00       	push   $0x14f8
 2bf:	ff 35 a0 19 00 00    	pushl  0x19a0
 2c5:	e8 b6 09 00 00       	call   c80 <printf>
  printf(stdout, "  / |    ||          \n");
 2ca:	58                   	pop    %eax
 2cb:	5a                   	pop    %edx
 2cc:	68 0e 15 00 00       	push   $0x150e
 2d1:	ff 35 a0 19 00 00    	pushl  0x19a0
 2d7:	e8 a4 09 00 00       	call   c80 <printf>
  printf(stdout, " *  /\\---/\\        \n");
 2dc:	59                   	pop    %ecx
 2dd:	5b                   	pop    %ebx
 2de:	68 25 15 00 00       	push   $0x1525
 2e3:	ff 35 a0 19 00 00    	pushl  0x19a0
 2e9:	e8 92 09 00 00       	call   c80 <printf>
  printf(stdout, "    ~~   ~~          \n");
 2ee:	58                   	pop    %eax
 2ef:	5a                   	pop    %edx
 2f0:	68 3a 15 00 00       	push   $0x153a
 2f5:	ff 35 a0 19 00 00    	pushl  0x19a0
 2fb:	e8 80 09 00 00       	call   c80 <printf>
  printf(stdout, "....\"Congratulations! You have mooed!\"...\n");
 300:	59                   	pop    %ecx
 301:	5b                   	pop    %ebx
 302:	68 d8 12 00 00       	push   $0x12d8
 307:	ff 35 a0 19 00 00    	pushl  0x19a0
 30d:	e8 6e 09 00 00       	call   c80 <printf>
  printf(stdout, "\n");
 312:	58                   	pop    %eax
 313:	5a                   	pop    %edx
 314:	68 23 15 00 00       	push   $0x1523
 319:	ff 35 a0 19 00 00    	pushl  0x19a0
 31f:	e8 5c 09 00 00       	call   c80 <printf>
  printf(stdout, "[0xDCC605 - COW] ALL OK!!!\n");
 324:	59                   	pop    %ecx
 325:	5b                   	pop    %ebx
 326:	68 51 15 00 00       	push   $0x1551
 32b:	ff 35 a0 19 00 00    	pushl  0x19a0
 331:	e8 4a 09 00 00       	call   c80 <printf>
  exit();
 336:	e8 d7 07 00 00       	call   b12 <exit>
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
 34b:	68 a0 0f 00 00       	push   $0xfa0
 350:	ff 35 a0 19 00 00    	pushl  0x19a0
 356:	e8 25 09 00 00       	call   c80 <printf>
 35b:	83 c4 10             	add    $0x10,%esp
 35e:	66 90                	xchg   %ax,%ax

  for(n=0; n<N; n++){
    pid = fork();
 360:	e8 a5 07 00 00       	call   b0a <fork>
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
 36b:	e8 aa 07 00 00       	call   b1a <wait>
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
 394:	68 c8 0f 00 00       	push   $0xfc8
 399:	ff 35 a0 19 00 00    	pushl  0x19a0
 39f:	e8 dc 08 00 00       	call   c80 <printf>
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
 3b7:	e8 56 07 00 00       	call   b12 <exit>
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
 3cb:	68 f0 0f 00 00       	push   $0xff0
 3d0:	ff 35 a0 19 00 00    	pushl  0x19a0
 3d6:	e8 a5 08 00 00       	call   c80 <printf>
 3db:	83 c4 10             	add    $0x10,%esp
 3de:	66 90                	xchg   %ax,%ax

  for(n=0; n<N; n++){
    pid = forkcow();
 3e0:	e8 e5 07 00 00       	call   bca <forkcow>
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
 3eb:	e8 2a 07 00 00       	call   b1a <wait>
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
 414:	68 1c 10 00 00       	push   $0x101c
 419:	ff 35 a0 19 00 00    	pushl  0x19a0
 41f:	e8 5c 08 00 00       	call   c80 <printf>
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
 437:	e8 d6 06 00 00       	call   b12 <exit>
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
 44c:	e8 d1 06 00 00       	call   b22 <pipe>
  int np = num_pages();
 451:	e8 6c 07 00 00       	call   bc2 <num_pages>
 456:	89 c6                	mov    %eax,%esi
  char answer[20];     // com certeza menos de 99999999999999999999 pgs
  int pid = forkcow();
 458:	e8 6d 07 00 00       	call   bca <forkcow>
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
 46d:	e8 c8 06 00 00       	call   b3a <close>
    wait();
 472:	e8 a3 06 00 00       	call   b1a <wait>
    printf(stdout, "[--Caso 3.3] Parent lendo num_pages\n");
 477:	58                   	pop    %eax
 478:	5a                   	pop    %edx
 479:	68 8c 10 00 00       	push   $0x108c
 47e:	ff 35 a0 19 00 00    	pushl  0x19a0
 484:	e8 f7 07 00 00       	call   c80 <printf>
    read(fd[0], answer, 20);
 489:	83 c4 0c             	add    $0xc,%esp
 48c:	6a 14                	push   $0x14
 48e:	53                   	push   %ebx
 48f:	ff 75 dc             	pushl  -0x24(%ebp)
 492:	e8 93 06 00 00       	call   b2a <read>
    printf(stdout, "[--Caso 3.4] Parent leu %d == %d\n", np, atoi(answer));
 497:	89 1c 24             	mov    %ebx,(%esp)
 49a:	e8 01 06 00 00       	call   aa0 <atoi>
 49f:	50                   	push   %eax
 4a0:	56                   	push   %esi
 4a1:	68 b4 10 00 00       	push   $0x10b4
 4a6:	ff 35 a0 19 00 00    	pushl  0x19a0
 4ac:	e8 cf 07 00 00       	call   c80 <printf>
    close(fd[0]);
 4b1:	83 c4 14             	add    $0x14,%esp
 4b4:	ff 75 dc             	pushl  -0x24(%ebp)
 4b7:	e8 7e 06 00 00       	call   b3a <close>
    return atoi(answer) == np;
 4bc:	89 1c 24             	mov    %ebx,(%esp)
 4bf:	e8 dc 05 00 00       	call   aa0 <atoi>
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
 4d6:	e8 e7 06 00 00       	call   bc2 <num_pages>
 4db:	51                   	push   %ecx
 4dc:	50                   	push   %eax
 4dd:	68 44 10 00 00       	push   $0x1044
 4e2:	ff 35 a0 19 00 00    	pushl  0x19a0
 4e8:	e8 93 07 00 00       	call   c80 <printf>
    close(fd[0]);
 4ed:	5b                   	pop    %ebx
 4ee:	ff 75 dc             	pushl  -0x24(%ebp)
 4f1:	e8 44 06 00 00       	call   b3a <close>
    printf(fd[1], "%d\0", num_pages());
 4f6:	e8 c7 06 00 00       	call   bc2 <num_pages>
 4fb:	83 c4 0c             	add    $0xc,%esp
 4fe:	50                   	push   %eax
 4ff:	68 04 13 00 00       	push   $0x1304
 504:	ff 75 e0             	pushl  -0x20(%ebp)
 507:	e8 74 07 00 00       	call   c80 <printf>
    printf(stdout, "[--Caso 3.2] Child indo embora\n");
 50c:	5e                   	pop    %esi
 50d:	58                   	pop    %eax
 50e:	68 6c 10 00 00       	push   $0x106c
 513:	ff 35 a0 19 00 00    	pushl  0x19a0
 519:	e8 62 07 00 00       	call   c80 <printf>
    close(fd[1]);
 51e:	58                   	pop    %eax
 51f:	ff 75 e0             	pushl  -0x20(%ebp)
 522:	e8 13 06 00 00       	call   b3a <close>
    exit();
 527:	e8 e6 05 00 00       	call   b12 <exit>
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
 53c:	e8 e1 05 00 00       	call   b22 <pipe>
  char answer[20];
  int pid = forkcow();
 541:	e8 84 06 00 00       	call   bca <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL1_RO
 546:	83 c4 10             	add    $0x10,%esp
 549:	85 c0                	test   %eax,%eax
 54b:	0f 84 84 00 00 00    	je     5d5 <caso4mesmoaddr+0xa5>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 551:	83 ec 0c             	sub    $0xc,%esp
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
 557:	68 08 13 00 00       	push   $0x1308
 55c:	e8 59 06 00 00       	call   bba <virt2real>
 561:	99                   	cltd   
 562:	31 d0                	xor    %edx,%eax
 564:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 566:	58                   	pop    %eax
 567:	ff 75 e0             	pushl  -0x20(%ebp)
 56a:	29 d3                	sub    %edx,%ebx
 56c:	e8 c9 05 00 00       	call   b3a <close>
    wait();
 571:	e8 a4 05 00 00       	call   b1a <wait>
    printf(stdout, "[--Caso 4.3] Parent lendo addr\n");
 576:	5a                   	pop    %edx
 577:	59                   	pop    %ecx
 578:	68 f8 10 00 00       	push   $0x10f8
 57d:	ff 35 a0 19 00 00    	pushl  0x19a0
 583:	e8 f8 06 00 00       	call   c80 <printf>
    read(fd[0], answer, 20);
 588:	83 c4 0c             	add    $0xc,%esp
 58b:	6a 14                	push   $0x14
 58d:	56                   	push   %esi
 58e:	ff 75 dc             	pushl  -0x24(%ebp)
 591:	e8 94 05 00 00       	call   b2a <read>
    printf(stdout, "[--Caso 4.4] Parent leu %d == %d\n",
 596:	89 34 24             	mov    %esi,(%esp)
 599:	e8 02 05 00 00       	call   aa0 <atoi>
 59e:	50                   	push   %eax
 59f:	53                   	push   %ebx
 5a0:	68 18 11 00 00       	push   $0x1118
 5a5:	ff 35 a0 19 00 00    	pushl  0x19a0
 5ab:	e8 d0 06 00 00       	call   c80 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 5b0:	83 c4 14             	add    $0x14,%esp
 5b3:	ff 75 dc             	pushl  -0x24(%ebp)
 5b6:	e8 7f 05 00 00       	call   b3a <close>
    return addr == atoi(answer);
 5bb:	89 34 24             	mov    %esi,(%esp)
 5be:	e8 dd 04 00 00       	call   aa0 <atoi>
 5c3:	83 c4 10             	add    $0x10,%esp
 5c6:	39 d8                	cmp    %ebx,%eax
 5c8:	0f 94 c0             	sete   %al
  }
  return TRUE;
}
 5cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5ce:	0f b6 c0             	movzbl %al,%eax
 5d1:	5b                   	pop    %ebx
 5d2:	5e                   	pop    %esi
 5d3:	5d                   	pop    %ebp
 5d4:	c3                   	ret    
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL1_RO
    int addr = (int)virt2real((char*)&GLOBAL1_RO);
 5d5:	83 ec 0c             	sub    $0xc,%esp
 5d8:	68 08 13 00 00       	push   $0x1308
 5dd:	e8 d8 05 00 00       	call   bba <virt2real>
 5e2:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 5e4:	c1 f8 1f             	sar    $0x1f,%eax
 5e7:	83 c4 0c             	add    $0xc,%esp
 5ea:	31 c3                	xor    %eax,%ebx
 5ec:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 4.1] Child write %d\n", addr);
 5ee:	53                   	push   %ebx
 5ef:	68 0c 13 00 00       	push   $0x130c
 5f4:	ff 35 a0 19 00 00    	pushl  0x19a0
 5fa:	e8 81 06 00 00       	call   c80 <printf>
    close(fd[0]);
 5ff:	5e                   	pop    %esi
 600:	ff 75 dc             	pushl  -0x24(%ebp)
 603:	e8 32 05 00 00       	call   b3a <close>
    printf(fd[1], "%d\0", addr);
 608:	83 c4 0c             	add    $0xc,%esp
 60b:	53                   	push   %ebx
 60c:	68 04 13 00 00       	push   $0x1304
 611:	ff 75 e0             	pushl  -0x20(%ebp)
 614:	e8 67 06 00 00       	call   c80 <printf>
    printf(stdout, "[--Caso 4.2] Child indo embora\n");
 619:	58                   	pop    %eax
 61a:	5a                   	pop    %edx
 61b:	68 d8 10 00 00       	push   $0x10d8
 620:	ff 35 a0 19 00 00    	pushl  0x19a0
 626:	e8 55 06 00 00       	call   c80 <printf>
    close(fd[1]);
 62b:	59                   	pop    %ecx
 62c:	ff 75 e0             	pushl  -0x20(%ebp)
 62f:	e8 06 05 00 00       	call   b3a <close>
    exit();
 634:	e8 d9 04 00 00       	call   b12 <exit>
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000640 <caso5mesmoaddr>:


// testa que o processo parent e child tem o mesmo addr real
// para uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso5mesmoaddr(void) {
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	56                   	push   %esi
 644:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 645:	8d 45 dc             	lea    -0x24(%ebp),%eax


// testa que o processo parent e child tem o mesmo addr real
// para uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso5mesmoaddr(void) {
 648:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 64b:	50                   	push   %eax
 64c:	e8 d1 04 00 00       	call   b22 <pipe>
  char answer[20];
  int pid = forkcow();
 651:	e8 74 05 00 00       	call   bca <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL1_RO
 656:	83 c4 10             	add    $0x10,%esp
 659:	85 c0                	test   %eax,%eax
 65b:	0f 84 84 00 00 00    	je     6e5 <caso5mesmoaddr+0xa5>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 661:	83 ec 0c             	sub    $0xc,%esp
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
    wait();
    printf(stdout, "[--Caso 5.3] Parent lendo addr\n");
    read(fd[0], answer, 20);
 664:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 667:	68 98 19 00 00       	push   $0x1998
 66c:	e8 49 05 00 00       	call   bba <virt2real>
 671:	99                   	cltd   
 672:	31 d0                	xor    %edx,%eax
 674:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 676:	58                   	pop    %eax
 677:	ff 75 e0             	pushl  -0x20(%ebp)
 67a:	29 d3                	sub    %edx,%ebx
 67c:	e8 b9 04 00 00       	call   b3a <close>
    wait();
 681:	e8 94 04 00 00       	call   b1a <wait>
    printf(stdout, "[--Caso 5.3] Parent lendo addr\n");
 686:	5a                   	pop    %edx
 687:	59                   	pop    %ecx
 688:	68 5c 11 00 00       	push   $0x115c
 68d:	ff 35 a0 19 00 00    	pushl  0x19a0
 693:	e8 e8 05 00 00       	call   c80 <printf>
    read(fd[0], answer, 20);
 698:	83 c4 0c             	add    $0xc,%esp
 69b:	6a 14                	push   $0x14
 69d:	56                   	push   %esi
 69e:	ff 75 dc             	pushl  -0x24(%ebp)
 6a1:	e8 84 04 00 00       	call   b2a <read>
    printf(stdout, "[--Caso 5.4] Parent leu %d == %d\n",
 6a6:	89 34 24             	mov    %esi,(%esp)
 6a9:	e8 f2 03 00 00       	call   aa0 <atoi>
 6ae:	50                   	push   %eax
 6af:	53                   	push   %ebx
 6b0:	68 7c 11 00 00       	push   $0x117c
 6b5:	ff 35 a0 19 00 00    	pushl  0x19a0
 6bb:	e8 c0 05 00 00       	call   c80 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 6c0:	83 c4 14             	add    $0x14,%esp
 6c3:	ff 75 dc             	pushl  -0x24(%ebp)
 6c6:	e8 6f 04 00 00       	call   b3a <close>
    return addr == atoi(answer);
 6cb:	89 34 24             	mov    %esi,(%esp)
 6ce:	e8 cd 03 00 00       	call   aa0 <atoi>
 6d3:	83 c4 10             	add    $0x10,%esp
 6d6:	39 d8                	cmp    %ebx,%eax
 6d8:	0f 94 c0             	sete   %al
  }
  return TRUE;
}
 6db:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6de:	0f b6 c0             	movzbl %al,%eax
 6e1:	5b                   	pop    %ebx
 6e2:	5e                   	pop    %esi
 6e3:	5d                   	pop    %ebp
 6e4:	c3                   	ret    
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL1_RO
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 6e5:	83 ec 0c             	sub    $0xc,%esp
 6e8:	68 98 19 00 00       	push   $0x1998
 6ed:	e8 c8 04 00 00       	call   bba <virt2real>
 6f2:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 6f4:	c1 f8 1f             	sar    $0x1f,%eax
 6f7:	83 c4 0c             	add    $0xc,%esp
 6fa:	31 c3                	xor    %eax,%ebx
 6fc:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 5.1] Child write %d\n", addr);
 6fe:	53                   	push   %ebx
 6ff:	68 29 13 00 00       	push   $0x1329
 704:	ff 35 a0 19 00 00    	pushl  0x19a0
 70a:	e8 71 05 00 00       	call   c80 <printf>
    close(fd[0]);
 70f:	5e                   	pop    %esi
 710:	ff 75 dc             	pushl  -0x24(%ebp)
 713:	e8 22 04 00 00       	call   b3a <close>
    printf(fd[1], "%d\0", addr);
 718:	83 c4 0c             	add    $0xc,%esp
 71b:	53                   	push   %ebx
 71c:	68 04 13 00 00       	push   $0x1304
 721:	ff 75 e0             	pushl  -0x20(%ebp)
 724:	e8 57 05 00 00       	call   c80 <printf>
    printf(stdout, "[--Caso 5.2] Child indo embora\n");
 729:	58                   	pop    %eax
 72a:	5a                   	pop    %edx
 72b:	68 3c 11 00 00       	push   $0x113c
 730:	ff 35 a0 19 00 00    	pushl  0x19a0
 736:	e8 45 05 00 00       	call   c80 <printf>
    close(fd[1]);
 73b:	59                   	pop    %ecx
 73c:	ff 75 e0             	pushl  -0x20(%ebp)
 73f:	e8 f6 03 00 00       	call   b3a <close>
    exit();
 744:	e8 c9 03 00 00       	call   b12 <exit>
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000750 <caso6cow>:


// testa que o processo parent e child tem o addr diferentes
// após um write em uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso6cow(void) {
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	56                   	push   %esi
 754:	53                   	push   %ebx
  int fd[2];
  pipe(fd);
 755:	8d 45 dc             	lea    -0x24(%ebp),%eax


// testa que o processo parent e child tem o addr diferentes
// após um write em uma GLOBAL. usamos a GLOBAL1_RW
// pipes, wait e exit para comunicação e sync
int caso6cow(void) {
 758:	83 ec 2c             	sub    $0x2c,%esp
  int fd[2];
  pipe(fd);
 75b:	50                   	push   %eax
 75c:	e8 c1 03 00 00       	call   b22 <pipe>
  char answer[20];
  int pid = forkcow();
 761:	e8 64 04 00 00       	call   bca <forkcow>
  if (pid == 0) { // child manda addr de GLOBAL2_RW
 766:	83 c4 10             	add    $0x10,%esp
 769:	85 c0                	test   %eax,%eax
 76b:	0f 84 84 00 00 00    	je     7f5 <caso6cow+0xa5>
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 771:	83 ec 0c             	sub    $0xc,%esp
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
    wait();
    printf(stdout, "[--Caso 6.3] Parent lendo addr\n");
    read(fd[0], answer, 20);
 774:	8d 75 e4             	lea    -0x1c(%ebp),%esi
    printf(fd[1], "%d\0", addr);
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
    close(fd[1]);
    exit();
  } else { // parent espera filho acabar e lê o fd
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 777:	68 98 19 00 00       	push   $0x1998
 77c:	e8 39 04 00 00       	call   bba <virt2real>
 781:	99                   	cltd   
 782:	31 d0                	xor    %edx,%eax
 784:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
    close(fd[1]);
 786:	58                   	pop    %eax
 787:	ff 75 e0             	pushl  -0x20(%ebp)
 78a:	29 d3                	sub    %edx,%ebx
 78c:	e8 a9 03 00 00       	call   b3a <close>
    wait();
 791:	e8 84 03 00 00       	call   b1a <wait>
    printf(stdout, "[--Caso 6.3] Parent lendo addr\n");
 796:	5a                   	pop    %edx
 797:	59                   	pop    %ecx
 798:	68 c0 11 00 00       	push   $0x11c0
 79d:	ff 35 a0 19 00 00    	pushl  0x19a0
 7a3:	e8 d8 04 00 00       	call   c80 <printf>
    read(fd[0], answer, 20);
 7a8:	83 c4 0c             	add    $0xc,%esp
 7ab:	6a 14                	push   $0x14
 7ad:	56                   	push   %esi
 7ae:	ff 75 dc             	pushl  -0x24(%ebp)
 7b1:	e8 74 03 00 00       	call   b2a <read>
    printf(stdout, "[--Caso 6.4] Parent leu %d != %d\n",
 7b6:	89 34 24             	mov    %esi,(%esp)
 7b9:	e8 e2 02 00 00       	call   aa0 <atoi>
 7be:	50                   	push   %eax
 7bf:	53                   	push   %ebx
 7c0:	68 e0 11 00 00       	push   $0x11e0
 7c5:	ff 35 a0 19 00 00    	pushl  0x19a0
 7cb:	e8 b0 04 00 00       	call   c80 <printf>
           addr,
           atoi(answer));
    close(fd[0]);
 7d0:	83 c4 14             	add    $0x14,%esp
 7d3:	ff 75 dc             	pushl  -0x24(%ebp)
 7d6:	e8 5f 03 00 00       	call   b3a <close>
    return addr != atoi(answer);
 7db:	89 34 24             	mov    %esi,(%esp)
 7de:	e8 bd 02 00 00       	call   aa0 <atoi>
 7e3:	83 c4 10             	add    $0x10,%esp
 7e6:	39 d8                	cmp    %ebx,%eax
 7e8:	0f 95 c0             	setne  %al
  }
  return TRUE;
}
 7eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7ee:	0f b6 c0             	movzbl %al,%eax
 7f1:	5b                   	pop    %ebx
 7f2:	5e                   	pop    %esi
 7f3:	5d                   	pop    %ebp
 7f4:	c3                   	ret    
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL2_RW
    GLOBAL2_RW--;
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 7f5:	83 ec 0c             	sub    $0xc,%esp
  int fd[2];
  pipe(fd);
  char answer[20];
  int pid = forkcow();
  if (pid == 0) { // child manda addr de GLOBAL2_RW
    GLOBAL2_RW--;
 7f8:	83 2d 98 19 00 00 01 	subl   $0x1,0x1998
    int addr = (int)virt2real((char*)&GLOBAL2_RW);
 7ff:	68 98 19 00 00       	push   $0x1998
 804:	e8 b1 03 00 00       	call   bba <virt2real>
 809:	89 c3                	mov    %eax,%ebx
    if (addr < 0) addr = -addr; // atoi falha quando <0, nao sei pq
 80b:	c1 f8 1f             	sar    $0x1f,%eax
 80e:	83 c4 0c             	add    $0xc,%esp
 811:	31 c3                	xor    %eax,%ebx
 813:	29 c3                	sub    %eax,%ebx
    printf(stdout, "[--Caso 6.1] Child write %d\n", addr);
 815:	53                   	push   %ebx
 816:	68 46 13 00 00       	push   $0x1346
 81b:	ff 35 a0 19 00 00    	pushl  0x19a0
 821:	e8 5a 04 00 00       	call   c80 <printf>
    close(fd[0]);
 826:	5e                   	pop    %esi
 827:	ff 75 dc             	pushl  -0x24(%ebp)
 82a:	e8 0b 03 00 00       	call   b3a <close>
    printf(fd[1], "%d\0", addr);
 82f:	83 c4 0c             	add    $0xc,%esp
 832:	53                   	push   %ebx
 833:	68 04 13 00 00       	push   $0x1304
 838:	ff 75 e0             	pushl  -0x20(%ebp)
 83b:	e8 40 04 00 00       	call   c80 <printf>
    printf(stdout, "[--Caso 6.2] Child indo embora\n");
 840:	58                   	pop    %eax
 841:	5a                   	pop    %edx
 842:	68 a0 11 00 00       	push   $0x11a0
 847:	ff 35 a0 19 00 00    	pushl  0x19a0
 84d:	e8 2e 04 00 00       	call   c80 <printf>
    close(fd[1]);
 852:	59                   	pop    %ecx
 853:	ff 75 e0             	pushl  -0x20(%ebp)
 856:	e8 df 02 00 00       	call   b3a <close>
    exit();
 85b:	e8 b2 02 00 00       	call   b12 <exit>

00000860 <get_date>:
  }
  return TRUE;
}

// testa a chamada date
int get_date(struct rtcdate *r) {
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	83 ec 14             	sub    $0x14,%esp
  if (date(r)) {
 866:	ff 75 08             	pushl  0x8(%ebp)
 869:	e8 44 03 00 00       	call   bb2 <date>
 86e:	83 c4 10             	add    $0x10,%esp
 871:	85 c0                	test   %eax,%eax
 873:	ba 01 00 00 00       	mov    $0x1,%edx
 878:	74 18                	je     892 <get_date+0x32>
    printf(stderr, "[ERROR] Erro na chamada de sistema date\n");
 87a:	83 ec 08             	sub    $0x8,%esp
 87d:	68 04 12 00 00       	push   $0x1204
 882:	ff 35 9c 19 00 00    	pushl  0x199c
 888:	e8 f3 03 00 00       	call   c80 <printf>
 88d:	83 c4 10             	add    $0x10,%esp
 890:	31 d2                	xor    %edx,%edx
    return FALSE;
  }
  return TRUE;
}
 892:	89 d0                	mov    %edx,%eax
 894:	c9                   	leave  
 895:	c3                   	ret    
 896:	8d 76 00             	lea    0x0(%esi),%esi
 899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <print_date>:


void print_date(struct rtcdate *r) {
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	83 ec 08             	sub    $0x8,%esp
 8a6:	8b 45 08             	mov    0x8(%ebp),%eax
  printf(stdout, "%d/%d/%d %d:%d:%d\n", r->day,
 8a9:	ff 30                	pushl  (%eax)
 8ab:	ff 70 04             	pushl  0x4(%eax)
 8ae:	ff 70 08             	pushl  0x8(%eax)
 8b1:	ff 70 14             	pushl  0x14(%eax)
 8b4:	ff 70 10             	pushl  0x10(%eax)
 8b7:	ff 70 0c             	pushl  0xc(%eax)
 8ba:	68 63 13 00 00       	push   $0x1363
 8bf:	ff 35 a0 19 00 00    	pushl  0x19a0
 8c5:	e8 b6 03 00 00       	call   c80 <printf>
                                        r->month,
                                        r->year,
                                        r->hour,
                                        r->minute,
                                        r->second);
}
 8ca:	83 c4 20             	add    $0x20,%esp
 8cd:	c9                   	leave  
 8ce:	c3                   	ret    
 8cf:	90                   	nop

000008d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	53                   	push   %ebx
 8d4:	8b 45 08             	mov    0x8(%ebp),%eax
 8d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 8da:	89 c2                	mov    %eax,%edx
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8e0:	83 c1 01             	add    $0x1,%ecx
 8e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 8e7:	83 c2 01             	add    $0x1,%edx
 8ea:	84 db                	test   %bl,%bl
 8ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 8ef:	75 ef                	jne    8e0 <strcpy+0x10>
    ;
  return os;
}
 8f1:	5b                   	pop    %ebx
 8f2:	5d                   	pop    %ebp
 8f3:	c3                   	ret    
 8f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000900 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	56                   	push   %esi
 904:	53                   	push   %ebx
 905:	8b 55 08             	mov    0x8(%ebp),%edx
 908:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 90b:	0f b6 02             	movzbl (%edx),%eax
 90e:	0f b6 19             	movzbl (%ecx),%ebx
 911:	84 c0                	test   %al,%al
 913:	75 1e                	jne    933 <strcmp+0x33>
 915:	eb 29                	jmp    940 <strcmp+0x40>
 917:	89 f6                	mov    %esi,%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 920:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 923:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 926:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 929:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 92d:	84 c0                	test   %al,%al
 92f:	74 0f                	je     940 <strcmp+0x40>
 931:	89 f1                	mov    %esi,%ecx
 933:	38 d8                	cmp    %bl,%al
 935:	74 e9                	je     920 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 937:	29 d8                	sub    %ebx,%eax
}
 939:	5b                   	pop    %ebx
 93a:	5e                   	pop    %esi
 93b:	5d                   	pop    %ebp
 93c:	c3                   	ret    
 93d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 940:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 942:	29 d8                	sub    %ebx,%eax
}
 944:	5b                   	pop    %ebx
 945:	5e                   	pop    %esi
 946:	5d                   	pop    %ebp
 947:	c3                   	ret    
 948:	90                   	nop
 949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000950 <strlen>:

uint
strlen(char *s)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 956:	80 39 00             	cmpb   $0x0,(%ecx)
 959:	74 12                	je     96d <strlen+0x1d>
 95b:	31 d2                	xor    %edx,%edx
 95d:	8d 76 00             	lea    0x0(%esi),%esi
 960:	83 c2 01             	add    $0x1,%edx
 963:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 967:	89 d0                	mov    %edx,%eax
 969:	75 f5                	jne    960 <strlen+0x10>
    ;
  return n;
}
 96b:	5d                   	pop    %ebp
 96c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 96d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 96f:	5d                   	pop    %ebp
 970:	c3                   	ret    
 971:	eb 0d                	jmp    980 <memset>
 973:	90                   	nop
 974:	90                   	nop
 975:	90                   	nop
 976:	90                   	nop
 977:	90                   	nop
 978:	90                   	nop
 979:	90                   	nop
 97a:	90                   	nop
 97b:	90                   	nop
 97c:	90                   	nop
 97d:	90                   	nop
 97e:	90                   	nop
 97f:	90                   	nop

00000980 <memset>:

void*
memset(void *dst, int c, uint n)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	57                   	push   %edi
 984:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 987:	8b 4d 10             	mov    0x10(%ebp),%ecx
 98a:	8b 45 0c             	mov    0xc(%ebp),%eax
 98d:	89 d7                	mov    %edx,%edi
 98f:	fc                   	cld    
 990:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 992:	89 d0                	mov    %edx,%eax
 994:	5f                   	pop    %edi
 995:	5d                   	pop    %ebp
 996:	c3                   	ret    
 997:	89 f6                	mov    %esi,%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <strchr>:

char*
strchr(const char *s, char c)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	53                   	push   %ebx
 9a4:	8b 45 08             	mov    0x8(%ebp),%eax
 9a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 9aa:	0f b6 10             	movzbl (%eax),%edx
 9ad:	84 d2                	test   %dl,%dl
 9af:	74 1d                	je     9ce <strchr+0x2e>
    if(*s == c)
 9b1:	38 d3                	cmp    %dl,%bl
 9b3:	89 d9                	mov    %ebx,%ecx
 9b5:	75 0d                	jne    9c4 <strchr+0x24>
 9b7:	eb 17                	jmp    9d0 <strchr+0x30>
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9c0:	38 ca                	cmp    %cl,%dl
 9c2:	74 0c                	je     9d0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 9c4:	83 c0 01             	add    $0x1,%eax
 9c7:	0f b6 10             	movzbl (%eax),%edx
 9ca:	84 d2                	test   %dl,%dl
 9cc:	75 f2                	jne    9c0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 9ce:	31 c0                	xor    %eax,%eax
}
 9d0:	5b                   	pop    %ebx
 9d1:	5d                   	pop    %ebp
 9d2:	c3                   	ret    
 9d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009e0 <gets>:

char*
gets(char *buf, int max)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9e6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 9e8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 9eb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9ee:	eb 29                	jmp    a19 <gets+0x39>
    cc = read(0, &c, 1);
 9f0:	83 ec 04             	sub    $0x4,%esp
 9f3:	6a 01                	push   $0x1
 9f5:	57                   	push   %edi
 9f6:	6a 00                	push   $0x0
 9f8:	e8 2d 01 00 00       	call   b2a <read>
    if(cc < 1)
 9fd:	83 c4 10             	add    $0x10,%esp
 a00:	85 c0                	test   %eax,%eax
 a02:	7e 1d                	jle    a21 <gets+0x41>
      break;
    buf[i++] = c;
 a04:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 a08:	8b 55 08             	mov    0x8(%ebp),%edx
 a0b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 a0d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 a0f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 a13:	74 1b                	je     a30 <gets+0x50>
 a15:	3c 0d                	cmp    $0xd,%al
 a17:	74 17                	je     a30 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a19:	8d 5e 01             	lea    0x1(%esi),%ebx
 a1c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 a1f:	7c cf                	jl     9f0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a21:	8b 45 08             	mov    0x8(%ebp),%eax
 a24:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a2b:	5b                   	pop    %ebx
 a2c:	5e                   	pop    %esi
 a2d:	5f                   	pop    %edi
 a2e:	5d                   	pop    %ebp
 a2f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a30:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a33:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 a35:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 a39:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a3c:	5b                   	pop    %ebx
 a3d:	5e                   	pop    %esi
 a3e:	5f                   	pop    %edi
 a3f:	5d                   	pop    %ebp
 a40:	c3                   	ret    
 a41:	eb 0d                	jmp    a50 <stat>
 a43:	90                   	nop
 a44:	90                   	nop
 a45:	90                   	nop
 a46:	90                   	nop
 a47:	90                   	nop
 a48:	90                   	nop
 a49:	90                   	nop
 a4a:	90                   	nop
 a4b:	90                   	nop
 a4c:	90                   	nop
 a4d:	90                   	nop
 a4e:	90                   	nop
 a4f:	90                   	nop

00000a50 <stat>:

int
stat(char *n, struct stat *st)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	56                   	push   %esi
 a54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a55:	83 ec 08             	sub    $0x8,%esp
 a58:	6a 00                	push   $0x0
 a5a:	ff 75 08             	pushl  0x8(%ebp)
 a5d:	e8 f0 00 00 00       	call   b52 <open>
  if(fd < 0)
 a62:	83 c4 10             	add    $0x10,%esp
 a65:	85 c0                	test   %eax,%eax
 a67:	78 27                	js     a90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 a69:	83 ec 08             	sub    $0x8,%esp
 a6c:	ff 75 0c             	pushl  0xc(%ebp)
 a6f:	89 c3                	mov    %eax,%ebx
 a71:	50                   	push   %eax
 a72:	e8 f3 00 00 00       	call   b6a <fstat>
 a77:	89 c6                	mov    %eax,%esi
  close(fd);
 a79:	89 1c 24             	mov    %ebx,(%esp)
 a7c:	e8 b9 00 00 00       	call   b3a <close>
  return r;
 a81:	83 c4 10             	add    $0x10,%esp
 a84:	89 f0                	mov    %esi,%eax
}
 a86:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a89:	5b                   	pop    %ebx
 a8a:	5e                   	pop    %esi
 a8b:	5d                   	pop    %ebp
 a8c:	c3                   	ret    
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a95:	eb ef                	jmp    a86 <stat+0x36>
 a97:	89 f6                	mov    %esi,%esi
 a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	53                   	push   %ebx
 aa4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 aa7:	0f be 11             	movsbl (%ecx),%edx
 aaa:	8d 42 d0             	lea    -0x30(%edx),%eax
 aad:	3c 09                	cmp    $0x9,%al
 aaf:	b8 00 00 00 00       	mov    $0x0,%eax
 ab4:	77 1f                	ja     ad5 <atoi+0x35>
 ab6:	8d 76 00             	lea    0x0(%esi),%esi
 ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 ac0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 ac3:	83 c1 01             	add    $0x1,%ecx
 ac6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 aca:	0f be 11             	movsbl (%ecx),%edx
 acd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 ad0:	80 fb 09             	cmp    $0x9,%bl
 ad3:	76 eb                	jbe    ac0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 ad5:	5b                   	pop    %ebx
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret    
 ad8:	90                   	nop
 ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	56                   	push   %esi
 ae4:	53                   	push   %ebx
 ae5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 ae8:	8b 45 08             	mov    0x8(%ebp),%eax
 aeb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 aee:	85 db                	test   %ebx,%ebx
 af0:	7e 14                	jle    b06 <memmove+0x26>
 af2:	31 d2                	xor    %edx,%edx
 af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 af8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 afc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 aff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b02:	39 da                	cmp    %ebx,%edx
 b04:	75 f2                	jne    af8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 b06:	5b                   	pop    %ebx
 b07:	5e                   	pop    %esi
 b08:	5d                   	pop    %ebp
 b09:	c3                   	ret    

00000b0a <fork>:
 b0a:	b8 01 00 00 00       	mov    $0x1,%eax
 b0f:	cd 40                	int    $0x40
 b11:	c3                   	ret    

00000b12 <exit>:
 b12:	b8 02 00 00 00       	mov    $0x2,%eax
 b17:	cd 40                	int    $0x40
 b19:	c3                   	ret    

00000b1a <wait>:
 b1a:	b8 03 00 00 00       	mov    $0x3,%eax
 b1f:	cd 40                	int    $0x40
 b21:	c3                   	ret    

00000b22 <pipe>:
 b22:	b8 04 00 00 00       	mov    $0x4,%eax
 b27:	cd 40                	int    $0x40
 b29:	c3                   	ret    

00000b2a <read>:
 b2a:	b8 05 00 00 00       	mov    $0x5,%eax
 b2f:	cd 40                	int    $0x40
 b31:	c3                   	ret    

00000b32 <write>:
 b32:	b8 10 00 00 00       	mov    $0x10,%eax
 b37:	cd 40                	int    $0x40
 b39:	c3                   	ret    

00000b3a <close>:
 b3a:	b8 15 00 00 00       	mov    $0x15,%eax
 b3f:	cd 40                	int    $0x40
 b41:	c3                   	ret    

00000b42 <kill>:
 b42:	b8 06 00 00 00       	mov    $0x6,%eax
 b47:	cd 40                	int    $0x40
 b49:	c3                   	ret    

00000b4a <exec>:
 b4a:	b8 07 00 00 00       	mov    $0x7,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <open>:
 b52:	b8 0f 00 00 00       	mov    $0xf,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <mknod>:
 b5a:	b8 11 00 00 00       	mov    $0x11,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <unlink>:
 b62:	b8 12 00 00 00       	mov    $0x12,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <fstat>:
 b6a:	b8 08 00 00 00       	mov    $0x8,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    

00000b72 <link>:
 b72:	b8 13 00 00 00       	mov    $0x13,%eax
 b77:	cd 40                	int    $0x40
 b79:	c3                   	ret    

00000b7a <mkdir>:
 b7a:	b8 14 00 00 00       	mov    $0x14,%eax
 b7f:	cd 40                	int    $0x40
 b81:	c3                   	ret    

00000b82 <chdir>:
 b82:	b8 09 00 00 00       	mov    $0x9,%eax
 b87:	cd 40                	int    $0x40
 b89:	c3                   	ret    

00000b8a <dup>:
 b8a:	b8 0a 00 00 00       	mov    $0xa,%eax
 b8f:	cd 40                	int    $0x40
 b91:	c3                   	ret    

00000b92 <getpid>:
 b92:	b8 0b 00 00 00       	mov    $0xb,%eax
 b97:	cd 40                	int    $0x40
 b99:	c3                   	ret    

00000b9a <sbrk>:
 b9a:	b8 0c 00 00 00       	mov    $0xc,%eax
 b9f:	cd 40                	int    $0x40
 ba1:	c3                   	ret    

00000ba2 <sleep>:
 ba2:	b8 0d 00 00 00       	mov    $0xd,%eax
 ba7:	cd 40                	int    $0x40
 ba9:	c3                   	ret    

00000baa <uptime>:
 baa:	b8 0e 00 00 00       	mov    $0xe,%eax
 baf:	cd 40                	int    $0x40
 bb1:	c3                   	ret    

00000bb2 <date>:
 bb2:	b8 16 00 00 00       	mov    $0x16,%eax
 bb7:	cd 40                	int    $0x40
 bb9:	c3                   	ret    

00000bba <virt2real>:
 bba:	b8 17 00 00 00       	mov    $0x17,%eax
 bbf:	cd 40                	int    $0x40
 bc1:	c3                   	ret    

00000bc2 <num_pages>:
 bc2:	b8 18 00 00 00       	mov    $0x18,%eax
 bc7:	cd 40                	int    $0x40
 bc9:	c3                   	ret    

00000bca <forkcow>:
 bca:	b8 19 00 00 00       	mov    $0x19,%eax
 bcf:	cd 40                	int    $0x40
 bd1:	c3                   	ret    
 bd2:	66 90                	xchg   %ax,%ax
 bd4:	66 90                	xchg   %ax,%ax
 bd6:	66 90                	xchg   %ax,%ax
 bd8:	66 90                	xchg   %ax,%ax
 bda:	66 90                	xchg   %ax,%ax
 bdc:	66 90                	xchg   %ax,%ax
 bde:	66 90                	xchg   %ax,%ax

00000be0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 be0:	55                   	push   %ebp
 be1:	89 e5                	mov    %esp,%ebp
 be3:	57                   	push   %edi
 be4:	56                   	push   %esi
 be5:	53                   	push   %ebx
 be6:	89 c6                	mov    %eax,%esi
 be8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 bee:	85 db                	test   %ebx,%ebx
 bf0:	74 7e                	je     c70 <printint+0x90>
 bf2:	89 d0                	mov    %edx,%eax
 bf4:	c1 e8 1f             	shr    $0x1f,%eax
 bf7:	84 c0                	test   %al,%al
 bf9:	74 75                	je     c70 <printint+0x90>
    neg = 1;
    x = -xx;
 bfb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 bfd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 c04:	f7 d8                	neg    %eax
 c06:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 c09:	31 ff                	xor    %edi,%edi
 c0b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 c0e:	89 ce                	mov    %ecx,%esi
 c10:	eb 08                	jmp    c1a <printint+0x3a>
 c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 c18:	89 cf                	mov    %ecx,%edi
 c1a:	31 d2                	xor    %edx,%edx
 c1c:	8d 4f 01             	lea    0x1(%edi),%ecx
 c1f:	f7 f6                	div    %esi
 c21:	0f b6 92 9c 15 00 00 	movzbl 0x159c(%edx),%edx
  }while((x /= base) != 0);
 c28:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 c2a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 c2d:	75 e9                	jne    c18 <printint+0x38>
  if(neg)
 c2f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 c32:	8b 75 c0             	mov    -0x40(%ebp),%esi
 c35:	85 c0                	test   %eax,%eax
 c37:	74 08                	je     c41 <printint+0x61>
    buf[i++] = '-';
 c39:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 c3e:	8d 4f 02             	lea    0x2(%edi),%ecx
 c41:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 c45:	8d 76 00             	lea    0x0(%esi),%esi
 c48:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c4b:	83 ec 04             	sub    $0x4,%esp
 c4e:	83 ef 01             	sub    $0x1,%edi
 c51:	6a 01                	push   $0x1
 c53:	53                   	push   %ebx
 c54:	56                   	push   %esi
 c55:	88 45 d7             	mov    %al,-0x29(%ebp)
 c58:	e8 d5 fe ff ff       	call   b32 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 c5d:	83 c4 10             	add    $0x10,%esp
 c60:	39 df                	cmp    %ebx,%edi
 c62:	75 e4                	jne    c48 <printint+0x68>
    putc(fd, buf[i]);
}
 c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c67:	5b                   	pop    %ebx
 c68:	5e                   	pop    %esi
 c69:	5f                   	pop    %edi
 c6a:	5d                   	pop    %ebp
 c6b:	c3                   	ret    
 c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 c70:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 c72:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c79:	eb 8b                	jmp    c06 <printint+0x26>
 c7b:	90                   	nop
 c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c80 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 c80:	55                   	push   %ebp
 c81:	89 e5                	mov    %esp,%ebp
 c83:	57                   	push   %edi
 c84:	56                   	push   %esi
 c85:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c86:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 c89:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c8c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 c8f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c92:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c95:	0f b6 1e             	movzbl (%esi),%ebx
 c98:	83 c6 01             	add    $0x1,%esi
 c9b:	84 db                	test   %bl,%bl
 c9d:	0f 84 b0 00 00 00    	je     d53 <printf+0xd3>
 ca3:	31 d2                	xor    %edx,%edx
 ca5:	eb 39                	jmp    ce0 <printf+0x60>
 ca7:	89 f6                	mov    %esi,%esi
 ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cb0:	83 f8 25             	cmp    $0x25,%eax
 cb3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 cb6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cbb:	74 18                	je     cd5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cbd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 cc0:	83 ec 04             	sub    $0x4,%esp
 cc3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 cc6:	6a 01                	push   $0x1
 cc8:	50                   	push   %eax
 cc9:	57                   	push   %edi
 cca:	e8 63 fe ff ff       	call   b32 <write>
 ccf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 cd2:	83 c4 10             	add    $0x10,%esp
 cd5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 cd8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 cdc:	84 db                	test   %bl,%bl
 cde:	74 73                	je     d53 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 ce0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 ce2:	0f be cb             	movsbl %bl,%ecx
 ce5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 ce8:	74 c6                	je     cb0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 cea:	83 fa 25             	cmp    $0x25,%edx
 ced:	75 e6                	jne    cd5 <printf+0x55>
      if(c == 'd'){
 cef:	83 f8 64             	cmp    $0x64,%eax
 cf2:	0f 84 f8 00 00 00    	je     df0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 cf8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 cfe:	83 f9 70             	cmp    $0x70,%ecx
 d01:	74 5d                	je     d60 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 d03:	83 f8 73             	cmp    $0x73,%eax
 d06:	0f 84 84 00 00 00    	je     d90 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d0c:	83 f8 63             	cmp    $0x63,%eax
 d0f:	0f 84 ea 00 00 00    	je     dff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d15:	83 f8 25             	cmp    $0x25,%eax
 d18:	0f 84 c2 00 00 00    	je     de0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d1e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d21:	83 ec 04             	sub    $0x4,%esp
 d24:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d28:	6a 01                	push   $0x1
 d2a:	50                   	push   %eax
 d2b:	57                   	push   %edi
 d2c:	e8 01 fe ff ff       	call   b32 <write>
 d31:	83 c4 0c             	add    $0xc,%esp
 d34:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d37:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d3a:	6a 01                	push   $0x1
 d3c:	50                   	push   %eax
 d3d:	57                   	push   %edi
 d3e:	83 c6 01             	add    $0x1,%esi
 d41:	e8 ec fd ff ff       	call   b32 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d46:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d4a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d4d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d4f:	84 db                	test   %bl,%bl
 d51:	75 8d                	jne    ce0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d56:	5b                   	pop    %ebx
 d57:	5e                   	pop    %esi
 d58:	5f                   	pop    %edi
 d59:	5d                   	pop    %ebp
 d5a:	c3                   	ret    
 d5b:	90                   	nop
 d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 d60:	83 ec 0c             	sub    $0xc,%esp
 d63:	b9 10 00 00 00       	mov    $0x10,%ecx
 d68:	6a 00                	push   $0x0
 d6a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d6d:	89 f8                	mov    %edi,%eax
 d6f:	8b 13                	mov    (%ebx),%edx
 d71:	e8 6a fe ff ff       	call   be0 <printint>
        ap++;
 d76:	89 d8                	mov    %ebx,%eax
 d78:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d7b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 d7d:	83 c0 04             	add    $0x4,%eax
 d80:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d83:	e9 4d ff ff ff       	jmp    cd5 <printf+0x55>
 d88:	90                   	nop
 d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 d90:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d93:	8b 18                	mov    (%eax),%ebx
        ap++;
 d95:	83 c0 04             	add    $0x4,%eax
 d98:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 d9b:	b8 94 15 00 00       	mov    $0x1594,%eax
 da0:	85 db                	test   %ebx,%ebx
 da2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 da5:	0f b6 03             	movzbl (%ebx),%eax
 da8:	84 c0                	test   %al,%al
 daa:	74 23                	je     dcf <printf+0x14f>
 dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 db0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 db3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 db6:	83 ec 04             	sub    $0x4,%esp
 db9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 dbb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dbe:	50                   	push   %eax
 dbf:	57                   	push   %edi
 dc0:	e8 6d fd ff ff       	call   b32 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 dc5:	0f b6 03             	movzbl (%ebx),%eax
 dc8:	83 c4 10             	add    $0x10,%esp
 dcb:	84 c0                	test   %al,%al
 dcd:	75 e1                	jne    db0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 dcf:	31 d2                	xor    %edx,%edx
 dd1:	e9 ff fe ff ff       	jmp    cd5 <printf+0x55>
 dd6:	8d 76 00             	lea    0x0(%esi),%esi
 dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 de0:	83 ec 04             	sub    $0x4,%esp
 de3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 de6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 de9:	6a 01                	push   $0x1
 deb:	e9 4c ff ff ff       	jmp    d3c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 df0:	83 ec 0c             	sub    $0xc,%esp
 df3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 df8:	6a 01                	push   $0x1
 dfa:	e9 6b ff ff ff       	jmp    d6a <printf+0xea>
 dff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 e02:	83 ec 04             	sub    $0x4,%esp
 e05:	8b 03                	mov    (%ebx),%eax
 e07:	6a 01                	push   $0x1
 e09:	88 45 e4             	mov    %al,-0x1c(%ebp)
 e0c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e0f:	50                   	push   %eax
 e10:	57                   	push   %edi
 e11:	e8 1c fd ff ff       	call   b32 <write>
 e16:	e9 5b ff ff ff       	jmp    d76 <printf+0xf6>
 e1b:	66 90                	xchg   %ax,%ax
 e1d:	66 90                	xchg   %ax,%ax
 e1f:	90                   	nop

00000e20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e21:	a1 a4 19 00 00       	mov    0x19a4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 e26:	89 e5                	mov    %esp,%ebp
 e28:	57                   	push   %edi
 e29:	56                   	push   %esi
 e2a:	53                   	push   %ebx
 e2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e2e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e30:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e33:	39 c8                	cmp    %ecx,%eax
 e35:	73 19                	jae    e50 <free+0x30>
 e37:	89 f6                	mov    %esi,%esi
 e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 e40:	39 d1                	cmp    %edx,%ecx
 e42:	72 1c                	jb     e60 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e44:	39 d0                	cmp    %edx,%eax
 e46:	73 18                	jae    e60 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e48:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e4a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e4c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e4e:	72 f0                	jb     e40 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e50:	39 d0                	cmp    %edx,%eax
 e52:	72 f4                	jb     e48 <free+0x28>
 e54:	39 d1                	cmp    %edx,%ecx
 e56:	73 f0                	jae    e48 <free+0x28>
 e58:	90                   	nop
 e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 e60:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e63:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e66:	39 d7                	cmp    %edx,%edi
 e68:	74 19                	je     e83 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e6d:	8b 50 04             	mov    0x4(%eax),%edx
 e70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e73:	39 f1                	cmp    %esi,%ecx
 e75:	74 23                	je     e9a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e77:	89 08                	mov    %ecx,(%eax)
  freep = p;
 e79:	a3 a4 19 00 00       	mov    %eax,0x19a4
}
 e7e:	5b                   	pop    %ebx
 e7f:	5e                   	pop    %esi
 e80:	5f                   	pop    %edi
 e81:	5d                   	pop    %ebp
 e82:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 e83:	03 72 04             	add    0x4(%edx),%esi
 e86:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e89:	8b 10                	mov    (%eax),%edx
 e8b:	8b 12                	mov    (%edx),%edx
 e8d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 e90:	8b 50 04             	mov    0x4(%eax),%edx
 e93:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e96:	39 f1                	cmp    %esi,%ecx
 e98:	75 dd                	jne    e77 <free+0x57>
    p->s.size += bp->s.size;
 e9a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 e9d:	a3 a4 19 00 00       	mov    %eax,0x19a4
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ea2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ea5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ea8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 eaa:	5b                   	pop    %ebx
 eab:	5e                   	pop    %esi
 eac:	5f                   	pop    %edi
 ead:	5d                   	pop    %ebp
 eae:	c3                   	ret    
 eaf:	90                   	nop

00000eb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 eb0:	55                   	push   %ebp
 eb1:	89 e5                	mov    %esp,%ebp
 eb3:	57                   	push   %edi
 eb4:	56                   	push   %esi
 eb5:	53                   	push   %ebx
 eb6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 ebc:	8b 15 a4 19 00 00    	mov    0x19a4,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ec2:	8d 78 07             	lea    0x7(%eax),%edi
 ec5:	c1 ef 03             	shr    $0x3,%edi
 ec8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 ecb:	85 d2                	test   %edx,%edx
 ecd:	0f 84 a3 00 00 00    	je     f76 <malloc+0xc6>
 ed3:	8b 02                	mov    (%edx),%eax
 ed5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ed8:	39 cf                	cmp    %ecx,%edi
 eda:	76 74                	jbe    f50 <malloc+0xa0>
 edc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ee2:	be 00 10 00 00       	mov    $0x1000,%esi
 ee7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 eee:	0f 43 f7             	cmovae %edi,%esi
 ef1:	ba 00 80 00 00       	mov    $0x8000,%edx
 ef6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 efc:	0f 46 da             	cmovbe %edx,%ebx
 eff:	eb 10                	jmp    f11 <malloc+0x61>
 f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f08:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f0a:	8b 48 04             	mov    0x4(%eax),%ecx
 f0d:	39 cf                	cmp    %ecx,%edi
 f0f:	76 3f                	jbe    f50 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f11:	39 05 a4 19 00 00    	cmp    %eax,0x19a4
 f17:	89 c2                	mov    %eax,%edx
 f19:	75 ed                	jne    f08 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 f1b:	83 ec 0c             	sub    $0xc,%esp
 f1e:	53                   	push   %ebx
 f1f:	e8 76 fc ff ff       	call   b9a <sbrk>
  if(p == (char*)-1)
 f24:	83 c4 10             	add    $0x10,%esp
 f27:	83 f8 ff             	cmp    $0xffffffff,%eax
 f2a:	74 1c                	je     f48 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 f2c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 f2f:	83 ec 0c             	sub    $0xc,%esp
 f32:	83 c0 08             	add    $0x8,%eax
 f35:	50                   	push   %eax
 f36:	e8 e5 fe ff ff       	call   e20 <free>
  return freep;
 f3b:	8b 15 a4 19 00 00    	mov    0x19a4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 f41:	83 c4 10             	add    $0x10,%esp
 f44:	85 d2                	test   %edx,%edx
 f46:	75 c0                	jne    f08 <malloc+0x58>
        return 0;
 f48:	31 c0                	xor    %eax,%eax
 f4a:	eb 1c                	jmp    f68 <malloc+0xb8>
 f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f50:	39 cf                	cmp    %ecx,%edi
 f52:	74 1c                	je     f70 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f54:	29 f9                	sub    %edi,%ecx
 f56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f5c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 f5f:	89 15 a4 19 00 00    	mov    %edx,0x19a4
      return (void*)(p + 1);
 f65:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f68:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f6b:	5b                   	pop    %ebx
 f6c:	5e                   	pop    %esi
 f6d:	5f                   	pop    %edi
 f6e:	5d                   	pop    %ebp
 f6f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 f70:	8b 08                	mov    (%eax),%ecx
 f72:	89 0a                	mov    %ecx,(%edx)
 f74:	eb e9                	jmp    f5f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 f76:	c7 05 a4 19 00 00 a8 	movl   $0x19a8,0x19a4
 f7d:	19 00 00 
 f80:	c7 05 a8 19 00 00 a8 	movl   $0x19a8,0x19a8
 f87:	19 00 00 
    base.s.size = 0;
 f8a:	b8 a8 19 00 00       	mov    $0x19a8,%eax
 f8f:	c7 05 ac 19 00 00 00 	movl   $0x0,0x19ac
 f96:	00 00 00 
 f99:	e9 3e ff ff ff       	jmp    edc <malloc+0x2c>
