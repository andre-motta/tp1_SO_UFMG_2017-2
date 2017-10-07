
_num_pages:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	e8 2c 03 00 00       	call   342 <num_pages>
  16:	85 c0                	test   %eax,%eax
  18:	78 19                	js     33 <main+0x33>
  1a:	83 ec 04             	sub    $0x4,%esp
  1d:	50                   	push   %eax
  1e:	68 3c 07 00 00       	push   $0x73c
  23:	ff 35 e4 09 00 00    	pushl  0x9e4
  29:	e8 d2 03 00 00       	call   400 <printf>
  2e:	e8 5f 02 00 00       	call   292 <exit>
  33:	50                   	push   %eax
  34:	50                   	push   %eax
  35:	68 20 07 00 00       	push   $0x720
  3a:	ff 35 e0 09 00 00    	pushl  0x9e0
  40:	e8 bb 03 00 00       	call   400 <printf>
  45:	e8 48 02 00 00       	call   292 <exit>
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <strcpy>:
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  54:	8b 45 08             	mov    0x8(%ebp),%eax
  57:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  5a:	89 c2                	mov    %eax,%edx
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  60:	83 c1 01             	add    $0x1,%ecx
  63:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  67:	83 c2 01             	add    $0x1,%edx
  6a:	84 db                	test   %bl,%bl
  6c:	88 5a ff             	mov    %bl,-0x1(%edx)
  6f:	75 ef                	jne    60 <strcpy+0x10>
  71:	5b                   	pop    %ebx
  72:	5d                   	pop    %ebp
  73:	c3                   	ret    
  74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000080 <strcmp>:
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	53                   	push   %ebx
  85:	8b 55 08             	mov    0x8(%ebp),%edx
  88:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8b:	0f b6 02             	movzbl (%edx),%eax
  8e:	0f b6 19             	movzbl (%ecx),%ebx
  91:	84 c0                	test   %al,%al
  93:	75 1e                	jne    b3 <strcmp+0x33>
  95:	eb 29                	jmp    c0 <strcmp+0x40>
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  a0:	83 c2 01             	add    $0x1,%edx
  a3:	0f b6 02             	movzbl (%edx),%eax
  a6:	8d 71 01             	lea    0x1(%ecx),%esi
  a9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  ad:	84 c0                	test   %al,%al
  af:	74 0f                	je     c0 <strcmp+0x40>
  b1:	89 f1                	mov    %esi,%ecx
  b3:	38 d8                	cmp    %bl,%al
  b5:	74 e9                	je     a0 <strcmp+0x20>
  b7:	29 d8                	sub    %ebx,%eax
  b9:	5b                   	pop    %ebx
  ba:	5e                   	pop    %esi
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	31 c0                	xor    %eax,%eax
  c2:	29 d8                	sub    %ebx,%eax
  c4:	5b                   	pop    %ebx
  c5:	5e                   	pop    %esi
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    
  c8:	90                   	nop
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000d0 <strlen>:
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 12                	je     ed <strlen+0x1d>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	83 c2 01             	add    $0x1,%edx
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	89 d0                	mov    %edx,%eax
  e9:	75 f5                	jne    e0 <strlen+0x10>
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
  ed:	31 c0                	xor    %eax,%eax
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	eb 0d                	jmp    100 <memset>
  f3:	90                   	nop
  f4:	90                   	nop
  f5:	90                   	nop
  f6:	90                   	nop
  f7:	90                   	nop
  f8:	90                   	nop
  f9:	90                   	nop
  fa:	90                   	nop
  fb:	90                   	nop
  fc:	90                   	nop
  fd:	90                   	nop
  fe:	90                   	nop
  ff:	90                   	nop

00000100 <memset>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	8b 55 08             	mov    0x8(%ebp),%edx
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	74 1d                	je     14e <strchr+0x2e>
 131:	38 d3                	cmp    %dl,%bl
 133:	89 d9                	mov    %ebx,%ecx
 135:	75 0d                	jne    144 <strchr+0x24>
 137:	eb 17                	jmp    150 <strchr+0x30>
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0c                	je     150 <strchr+0x30>
 144:	83 c0 01             	add    $0x1,%eax
 147:	0f b6 10             	movzbl (%eax),%edx
 14a:	84 d2                	test   %dl,%dl
 14c:	75 f2                	jne    140 <strchr+0x20>
 14e:	31 c0                	xor    %eax,%eax
 150:	5b                   	pop    %ebx
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <gets>:
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
 165:	53                   	push   %ebx
 166:	31 f6                	xor    %esi,%esi
 168:	8d 7d e7             	lea    -0x19(%ebp),%edi
 16b:	83 ec 1c             	sub    $0x1c,%esp
 16e:	eb 29                	jmp    199 <gets+0x39>
 170:	83 ec 04             	sub    $0x4,%esp
 173:	6a 01                	push   $0x1
 175:	57                   	push   %edi
 176:	6a 00                	push   $0x0
 178:	e8 2d 01 00 00       	call   2aa <read>
 17d:	83 c4 10             	add    $0x10,%esp
 180:	85 c0                	test   %eax,%eax
 182:	7e 1d                	jle    1a1 <gets+0x41>
 184:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 188:	8b 55 08             	mov    0x8(%ebp),%edx
 18b:	89 de                	mov    %ebx,%esi
 18d:	3c 0a                	cmp    $0xa,%al
 18f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
 193:	74 1b                	je     1b0 <gets+0x50>
 195:	3c 0d                	cmp    $0xd,%al
 197:	74 17                	je     1b0 <gets+0x50>
 199:	8d 5e 01             	lea    0x1(%esi),%ebx
 19c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 19f:	7c cf                	jl     170 <gets+0x10>
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
 1a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 1a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5f                   	pop    %edi
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	89 de                	mov    %ebx,%esi
 1b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
 1b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1bc:	5b                   	pop    %ebx
 1bd:	5e                   	pop    %esi
 1be:	5f                   	pop    %edi
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	eb 0d                	jmp    1d0 <stat>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <stat>:
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	6a 00                	push   $0x0
 1da:	ff 75 08             	pushl  0x8(%ebp)
 1dd:	e8 f0 00 00 00       	call   2d2 <open>
 1e2:	83 c4 10             	add    $0x10,%esp
 1e5:	85 c0                	test   %eax,%eax
 1e7:	78 27                	js     210 <stat+0x40>
 1e9:	83 ec 08             	sub    $0x8,%esp
 1ec:	ff 75 0c             	pushl  0xc(%ebp)
 1ef:	89 c3                	mov    %eax,%ebx
 1f1:	50                   	push   %eax
 1f2:	e8 f3 00 00 00       	call   2ea <fstat>
 1f7:	89 c6                	mov    %eax,%esi
 1f9:	89 1c 24             	mov    %ebx,(%esp)
 1fc:	e8 b9 00 00 00       	call   2ba <close>
 201:	83 c4 10             	add    $0x10,%esp
 204:	89 f0                	mov    %esi,%eax
 206:	8d 65 f8             	lea    -0x8(%ebp),%esp
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 215:	eb ef                	jmp    206 <stat+0x36>
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <atoi>:
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 4d 08             	mov    0x8(%ebp),%ecx
 227:	0f be 11             	movsbl (%ecx),%edx
 22a:	8d 42 d0             	lea    -0x30(%edx),%eax
 22d:	3c 09                	cmp    $0x9,%al
 22f:	b8 00 00 00 00       	mov    $0x0,%eax
 234:	77 1f                	ja     255 <atoi+0x35>
 236:	8d 76 00             	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 240:	8d 04 80             	lea    (%eax,%eax,4),%eax
 243:	83 c1 01             	add    $0x1,%ecx
 246:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 24a:	0f be 11             	movsbl (%ecx),%edx
 24d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
 255:	5b                   	pop    %ebx
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
 265:	8b 5d 10             	mov    0x10(%ebp),%ebx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
 26e:	85 db                	test   %ebx,%ebx
 270:	7e 14                	jle    286 <memmove+0x26>
 272:	31 d2                	xor    %edx,%edx
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
 282:	39 da                	cmp    %ebx,%edx
 284:	75 f2                	jne    278 <memmove+0x18>
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    

0000028a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28a:	b8 01 00 00 00       	mov    $0x1,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <exit>:
SYSCALL(exit)
 292:	b8 02 00 00 00       	mov    $0x2,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <wait>:
SYSCALL(wait)
 29a:	b8 03 00 00 00       	mov    $0x3,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <pipe>:
SYSCALL(pipe)
 2a2:	b8 04 00 00 00       	mov    $0x4,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <read>:
SYSCALL(read)
 2aa:	b8 05 00 00 00       	mov    $0x5,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <write>:
SYSCALL(write)
 2b2:	b8 10 00 00 00       	mov    $0x10,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <close>:
SYSCALL(close)
 2ba:	b8 15 00 00 00       	mov    $0x15,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <kill>:
SYSCALL(kill)
 2c2:	b8 06 00 00 00       	mov    $0x6,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <exec>:
SYSCALL(exec)
 2ca:	b8 07 00 00 00       	mov    $0x7,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <open>:
SYSCALL(open)
 2d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mknod>:
SYSCALL(mknod)
 2da:	b8 11 00 00 00       	mov    $0x11,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <unlink>:
SYSCALL(unlink)
 2e2:	b8 12 00 00 00       	mov    $0x12,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <fstat>:
SYSCALL(fstat)
 2ea:	b8 08 00 00 00       	mov    $0x8,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <link>:
SYSCALL(link)
 2f2:	b8 13 00 00 00       	mov    $0x13,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mkdir>:
SYSCALL(mkdir)
 2fa:	b8 14 00 00 00       	mov    $0x14,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <chdir>:
SYSCALL(chdir)
 302:	b8 09 00 00 00       	mov    $0x9,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <dup>:
SYSCALL(dup)
 30a:	b8 0a 00 00 00       	mov    $0xa,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <getpid>:
SYSCALL(getpid)
 312:	b8 0b 00 00 00       	mov    $0xb,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sbrk>:
SYSCALL(sbrk)
 31a:	b8 0c 00 00 00       	mov    $0xc,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <sleep>:
SYSCALL(sleep)
 322:	b8 0d 00 00 00       	mov    $0xd,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <uptime>:
SYSCALL(uptime)
 32a:	b8 0e 00 00 00       	mov    $0xe,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <date>:
SYSCALL(date)
 332:	b8 16 00 00 00       	mov    $0x16,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <virt2real>:
SYSCALL(virt2real)
 33a:	b8 17 00 00 00       	mov    $0x17,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <num_pages>:
SYSCALL(num_pages)
 342:	b8 18 00 00 00       	mov    $0x18,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <forkcow>:
SYSCALL(forkcow)
 34a:	b8 19 00 00 00       	mov    $0x19,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    
 352:	66 90                	xchg   %ax,%ax
 354:	66 90                	xchg   %ax,%ax
 356:	66 90                	xchg   %ax,%ax
 358:	66 90                	xchg   %ax,%ax
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <printint>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	89 c6                	mov    %eax,%esi
 368:	83 ec 3c             	sub    $0x3c,%esp
 36b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 36e:	85 db                	test   %ebx,%ebx
 370:	74 7e                	je     3f0 <printint+0x90>
 372:	89 d0                	mov    %edx,%eax
 374:	c1 e8 1f             	shr    $0x1f,%eax
 377:	84 c0                	test   %al,%al
 379:	74 75                	je     3f0 <printint+0x90>
 37b:	89 d0                	mov    %edx,%eax
 37d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 384:	f7 d8                	neg    %eax
 386:	89 75 c0             	mov    %esi,-0x40(%ebp)
 389:	31 ff                	xor    %edi,%edi
 38b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 38e:	89 ce                	mov    %ecx,%esi
 390:	eb 08                	jmp    39a <printint+0x3a>
 392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 398:	89 cf                	mov    %ecx,%edi
 39a:	31 d2                	xor    %edx,%edx
 39c:	8d 4f 01             	lea    0x1(%edi),%ecx
 39f:	f7 f6                	div    %esi
 3a1:	0f b6 92 48 07 00 00 	movzbl 0x748(%edx),%edx
 3a8:	85 c0                	test   %eax,%eax
 3aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 3ad:	75 e9                	jne    398 <printint+0x38>
 3af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3b5:	85 c0                	test   %eax,%eax
 3b7:	74 08                	je     3c1 <printint+0x61>
 3b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3be:	8d 4f 02             	lea    0x2(%edi),%ecx
 3c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
 3c8:	0f b6 07             	movzbl (%edi),%eax
 3cb:	83 ec 04             	sub    $0x4,%esp
 3ce:	83 ef 01             	sub    $0x1,%edi
 3d1:	6a 01                	push   $0x1
 3d3:	53                   	push   %ebx
 3d4:	56                   	push   %esi
 3d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 3d8:	e8 d5 fe ff ff       	call   2b2 <write>
 3dd:	83 c4 10             	add    $0x10,%esp
 3e0:	39 df                	cmp    %ebx,%edi
 3e2:	75 e4                	jne    3c8 <printint+0x68>
 3e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e7:	5b                   	pop    %ebx
 3e8:	5e                   	pop    %esi
 3e9:	5f                   	pop    %edi
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f0:	89 d0                	mov    %edx,%eax
 3f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3f9:	eb 8b                	jmp    386 <printint+0x26>
 3fb:	90                   	nop
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <printf>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	8d 45 10             	lea    0x10(%ebp),%eax
 409:	83 ec 2c             	sub    $0x2c,%esp
 40c:	8b 75 0c             	mov    0xc(%ebp),%esi
 40f:	8b 7d 08             	mov    0x8(%ebp),%edi
 412:	89 45 d0             	mov    %eax,-0x30(%ebp)
 415:	0f b6 1e             	movzbl (%esi),%ebx
 418:	83 c6 01             	add    $0x1,%esi
 41b:	84 db                	test   %bl,%bl
 41d:	0f 84 b0 00 00 00    	je     4d3 <printf+0xd3>
 423:	31 d2                	xor    %edx,%edx
 425:	eb 39                	jmp    460 <printf+0x60>
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 430:	83 f8 25             	cmp    $0x25,%eax
 433:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 436:	ba 25 00 00 00       	mov    $0x25,%edx
 43b:	74 18                	je     455 <printf+0x55>
 43d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 440:	83 ec 04             	sub    $0x4,%esp
 443:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 446:	6a 01                	push   $0x1
 448:	50                   	push   %eax
 449:	57                   	push   %edi
 44a:	e8 63 fe ff ff       	call   2b2 <write>
 44f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 452:	83 c4 10             	add    $0x10,%esp
 455:	83 c6 01             	add    $0x1,%esi
 458:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 45c:	84 db                	test   %bl,%bl
 45e:	74 73                	je     4d3 <printf+0xd3>
 460:	85 d2                	test   %edx,%edx
 462:	0f be cb             	movsbl %bl,%ecx
 465:	0f b6 c3             	movzbl %bl,%eax
 468:	74 c6                	je     430 <printf+0x30>
 46a:	83 fa 25             	cmp    $0x25,%edx
 46d:	75 e6                	jne    455 <printf+0x55>
 46f:	83 f8 64             	cmp    $0x64,%eax
 472:	0f 84 f8 00 00 00    	je     570 <printf+0x170>
 478:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 47e:	83 f9 70             	cmp    $0x70,%ecx
 481:	74 5d                	je     4e0 <printf+0xe0>
 483:	83 f8 73             	cmp    $0x73,%eax
 486:	0f 84 84 00 00 00    	je     510 <printf+0x110>
 48c:	83 f8 63             	cmp    $0x63,%eax
 48f:	0f 84 ea 00 00 00    	je     57f <printf+0x17f>
 495:	83 f8 25             	cmp    $0x25,%eax
 498:	0f 84 c2 00 00 00    	je     560 <printf+0x160>
 49e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a1:	83 ec 04             	sub    $0x4,%esp
 4a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4a8:	6a 01                	push   $0x1
 4aa:	50                   	push   %eax
 4ab:	57                   	push   %edi
 4ac:	e8 01 fe ff ff       	call   2b2 <write>
 4b1:	83 c4 0c             	add    $0xc,%esp
 4b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4ba:	6a 01                	push   $0x1
 4bc:	50                   	push   %eax
 4bd:	57                   	push   %edi
 4be:	83 c6 01             	add    $0x1,%esi
 4c1:	e8 ec fd ff ff       	call   2b2 <write>
 4c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4ca:	83 c4 10             	add    $0x10,%esp
 4cd:	31 d2                	xor    %edx,%edx
 4cf:	84 db                	test   %bl,%bl
 4d1:	75 8d                	jne    460 <printf+0x60>
 4d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d6:	5b                   	pop    %ebx
 4d7:	5e                   	pop    %esi
 4d8:	5f                   	pop    %edi
 4d9:	5d                   	pop    %ebp
 4da:	c3                   	ret    
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4e8:	6a 00                	push   $0x0
 4ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ed:	89 f8                	mov    %edi,%eax
 4ef:	8b 13                	mov    (%ebx),%edx
 4f1:	e8 6a fe ff ff       	call   360 <printint>
 4f6:	89 d8                	mov    %ebx,%eax
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	31 d2                	xor    %edx,%edx
 4fd:	83 c0 04             	add    $0x4,%eax
 500:	89 45 d0             	mov    %eax,-0x30(%ebp)
 503:	e9 4d ff ff ff       	jmp    455 <printf+0x55>
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 510:	8b 45 d0             	mov    -0x30(%ebp),%eax
 513:	8b 18                	mov    (%eax),%ebx
 515:	83 c0 04             	add    $0x4,%eax
 518:	89 45 d0             	mov    %eax,-0x30(%ebp)
 51b:	b8 40 07 00 00       	mov    $0x740,%eax
 520:	85 db                	test   %ebx,%ebx
 522:	0f 44 d8             	cmove  %eax,%ebx
 525:	0f b6 03             	movzbl (%ebx),%eax
 528:	84 c0                	test   %al,%al
 52a:	74 23                	je     54f <printf+0x14f>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 530:	88 45 e3             	mov    %al,-0x1d(%ebp)
 533:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 536:	83 ec 04             	sub    $0x4,%esp
 539:	6a 01                	push   $0x1
 53b:	83 c3 01             	add    $0x1,%ebx
 53e:	50                   	push   %eax
 53f:	57                   	push   %edi
 540:	e8 6d fd ff ff       	call   2b2 <write>
 545:	0f b6 03             	movzbl (%ebx),%eax
 548:	83 c4 10             	add    $0x10,%esp
 54b:	84 c0                	test   %al,%al
 54d:	75 e1                	jne    530 <printf+0x130>
 54f:	31 d2                	xor    %edx,%edx
 551:	e9 ff fe ff ff       	jmp    455 <printf+0x55>
 556:	8d 76 00             	lea    0x0(%esi),%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 566:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 569:	6a 01                	push   $0x1
 56b:	e9 4c ff ff ff       	jmp    4bc <printf+0xbc>
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
 578:	6a 01                	push   $0x1
 57a:	e9 6b ff ff ff       	jmp    4ea <printf+0xea>
 57f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 582:	83 ec 04             	sub    $0x4,%esp
 585:	8b 03                	mov    (%ebx),%eax
 587:	6a 01                	push   $0x1
 589:	88 45 e4             	mov    %al,-0x1c(%ebp)
 58c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 58f:	50                   	push   %eax
 590:	57                   	push   %edi
 591:	e8 1c fd ff ff       	call   2b2 <write>
 596:	e9 5b ff ff ff       	jmp    4f6 <printf+0xf6>
 59b:	66 90                	xchg   %ax,%ax
 59d:	66 90                	xchg   %ax,%ax
 59f:	90                   	nop

000005a0 <free>:
 5a0:	55                   	push   %ebp
 5a1:	a1 e8 09 00 00       	mov    0x9e8,%eax
 5a6:	89 e5                	mov    %esp,%ebp
 5a8:	57                   	push   %edi
 5a9:	56                   	push   %esi
 5aa:	53                   	push   %ebx
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ae:	8b 10                	mov    (%eax),%edx
 5b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5b3:	39 c8                	cmp    %ecx,%eax
 5b5:	73 19                	jae    5d0 <free+0x30>
 5b7:	89 f6                	mov    %esi,%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5c0:	39 d1                	cmp    %edx,%ecx
 5c2:	72 1c                	jb     5e0 <free+0x40>
 5c4:	39 d0                	cmp    %edx,%eax
 5c6:	73 18                	jae    5e0 <free+0x40>
 5c8:	89 d0                	mov    %edx,%eax
 5ca:	39 c8                	cmp    %ecx,%eax
 5cc:	8b 10                	mov    (%eax),%edx
 5ce:	72 f0                	jb     5c0 <free+0x20>
 5d0:	39 d0                	cmp    %edx,%eax
 5d2:	72 f4                	jb     5c8 <free+0x28>
 5d4:	39 d1                	cmp    %edx,%ecx
 5d6:	73 f0                	jae    5c8 <free+0x28>
 5d8:	90                   	nop
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5e6:	39 d7                	cmp    %edx,%edi
 5e8:	74 19                	je     603 <free+0x63>
 5ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5ed:	8b 50 04             	mov    0x4(%eax),%edx
 5f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f3:	39 f1                	cmp    %esi,%ecx
 5f5:	74 23                	je     61a <free+0x7a>
 5f7:	89 08                	mov    %ecx,(%eax)
 5f9:	a3 e8 09 00 00       	mov    %eax,0x9e8
 5fe:	5b                   	pop    %ebx
 5ff:	5e                   	pop    %esi
 600:	5f                   	pop    %edi
 601:	5d                   	pop    %ebp
 602:	c3                   	ret    
 603:	03 72 04             	add    0x4(%edx),%esi
 606:	89 73 fc             	mov    %esi,-0x4(%ebx)
 609:	8b 10                	mov    (%eax),%edx
 60b:	8b 12                	mov    (%edx),%edx
 60d:	89 53 f8             	mov    %edx,-0x8(%ebx)
 610:	8b 50 04             	mov    0x4(%eax),%edx
 613:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 616:	39 f1                	cmp    %esi,%ecx
 618:	75 dd                	jne    5f7 <free+0x57>
 61a:	03 53 fc             	add    -0x4(%ebx),%edx
 61d:	a3 e8 09 00 00       	mov    %eax,0x9e8
 622:	89 50 04             	mov    %edx,0x4(%eax)
 625:	8b 53 f8             	mov    -0x8(%ebx),%edx
 628:	89 10                	mov    %edx,(%eax)
 62a:	5b                   	pop    %ebx
 62b:	5e                   	pop    %esi
 62c:	5f                   	pop    %edi
 62d:	5d                   	pop    %ebp
 62e:	c3                   	ret    
 62f:	90                   	nop

00000630 <malloc>:
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 0c             	sub    $0xc,%esp
 639:	8b 45 08             	mov    0x8(%ebp),%eax
 63c:	8b 15 e8 09 00 00    	mov    0x9e8,%edx
 642:	8d 78 07             	lea    0x7(%eax),%edi
 645:	c1 ef 03             	shr    $0x3,%edi
 648:	83 c7 01             	add    $0x1,%edi
 64b:	85 d2                	test   %edx,%edx
 64d:	0f 84 a3 00 00 00    	je     6f6 <malloc+0xc6>
 653:	8b 02                	mov    (%edx),%eax
 655:	8b 48 04             	mov    0x4(%eax),%ecx
 658:	39 cf                	cmp    %ecx,%edi
 65a:	76 74                	jbe    6d0 <malloc+0xa0>
 65c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 662:	be 00 10 00 00       	mov    $0x1000,%esi
 667:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 66e:	0f 43 f7             	cmovae %edi,%esi
 671:	ba 00 80 00 00       	mov    $0x8000,%edx
 676:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 67c:	0f 46 da             	cmovbe %edx,%ebx
 67f:	eb 10                	jmp    691 <malloc+0x61>
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 688:	8b 02                	mov    (%edx),%eax
 68a:	8b 48 04             	mov    0x4(%eax),%ecx
 68d:	39 cf                	cmp    %ecx,%edi
 68f:	76 3f                	jbe    6d0 <malloc+0xa0>
 691:	39 05 e8 09 00 00    	cmp    %eax,0x9e8
 697:	89 c2                	mov    %eax,%edx
 699:	75 ed                	jne    688 <malloc+0x58>
 69b:	83 ec 0c             	sub    $0xc,%esp
 69e:	53                   	push   %ebx
 69f:	e8 76 fc ff ff       	call   31a <sbrk>
 6a4:	83 c4 10             	add    $0x10,%esp
 6a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6aa:	74 1c                	je     6c8 <malloc+0x98>
 6ac:	89 70 04             	mov    %esi,0x4(%eax)
 6af:	83 ec 0c             	sub    $0xc,%esp
 6b2:	83 c0 08             	add    $0x8,%eax
 6b5:	50                   	push   %eax
 6b6:	e8 e5 fe ff ff       	call   5a0 <free>
 6bb:	8b 15 e8 09 00 00    	mov    0x9e8,%edx
 6c1:	83 c4 10             	add    $0x10,%esp
 6c4:	85 d2                	test   %edx,%edx
 6c6:	75 c0                	jne    688 <malloc+0x58>
 6c8:	31 c0                	xor    %eax,%eax
 6ca:	eb 1c                	jmp    6e8 <malloc+0xb8>
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d0:	39 cf                	cmp    %ecx,%edi
 6d2:	74 1c                	je     6f0 <malloc+0xc0>
 6d4:	29 f9                	sub    %edi,%ecx
 6d6:	89 48 04             	mov    %ecx,0x4(%eax)
 6d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 6dc:	89 78 04             	mov    %edi,0x4(%eax)
 6df:	89 15 e8 09 00 00    	mov    %edx,0x9e8
 6e5:	83 c0 08             	add    $0x8,%eax
 6e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6eb:	5b                   	pop    %ebx
 6ec:	5e                   	pop    %esi
 6ed:	5f                   	pop    %edi
 6ee:	5d                   	pop    %ebp
 6ef:	c3                   	ret    
 6f0:	8b 08                	mov    (%eax),%ecx
 6f2:	89 0a                	mov    %ecx,(%edx)
 6f4:	eb e9                	jmp    6df <malloc+0xaf>
 6f6:	c7 05 e8 09 00 00 ec 	movl   $0x9ec,0x9e8
 6fd:	09 00 00 
 700:	c7 05 ec 09 00 00 ec 	movl   $0x9ec,0x9ec
 707:	09 00 00 
 70a:	b8 ec 09 00 00       	mov    $0x9ec,%eax
 70f:	c7 05 f0 09 00 00 00 	movl   $0x0,0x9f0
 716:	00 00 00 
 719:	e9 3e ff ff ff       	jmp    65c <malloc+0x2c>
