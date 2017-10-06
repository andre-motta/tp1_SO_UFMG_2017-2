
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 80 71 10 80       	push   $0x80107180
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 65 42 00 00       	call   801042c0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 71 10 80       	push   $0x80107187
80100097:	50                   	push   %eax
80100098:	e8 13 41 00 00       	call   801041b0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 d7 42 00 00       	call   801043c0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 79 43 00 00       	call   801044e0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 40 00 00       	call   801041f0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 1f 00 00       	call   801020f0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 71 10 80       	push   $0x8010718e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 dd 40 00 00       	call   80104290 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 27 1f 00 00       	jmp    801020f0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 71 10 80       	push   $0x8010719f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 9c 40 00 00       	call   80104290 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 4c 40 00 00       	call   80104250 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 b0 41 00 00       	call   801043c0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 7f 42 00 00       	jmp    801044e0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 71 10 80       	push   $0x801071a6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 cb 14 00 00       	call   80101750 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 2f 41 00 00       	call   801043c0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 8e 3b 00 00       	call   80103e50 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 c9 35 00 00       	call   801038a0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 f5 41 00 00       	call   801044e0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 13 00 00       	call   80101670 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 95 41 00 00       	call   801044e0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 13 00 00       	call   80101670 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 82 24 00 00       	call   80102810 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 ad 71 10 80       	push   $0x801071ad
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 23 7b 10 80 	movl   $0x80107b23,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 23 3f 00 00       	call   801042e0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 c1 71 10 80       	push   $0x801071c1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 31 58 00 00       	call   80105c50 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 78 57 00 00       	call   80105c50 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 6c 57 00 00       	call   80105c50 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 60 57 00 00       	call   80105c50 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 c7 40 00 00       	call   801045e0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 02 40 00 00       	call   80104530 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 c5 71 10 80       	push   $0x801071c5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 f0 71 10 80 	movzbl -0x7fef8e10(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 3c 11 00 00       	call   80101750 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 a0 3d 00 00       	call   801043c0 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 94 3e 00 00       	call   801044e0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 1b 10 00 00       	call   80101670 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 ce 3d 00 00       	call   801044e0 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 d8 71 10 80       	mov    $0x801071d8,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 f3 3b 00 00       	call   801043c0 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 df 71 10 80       	push   $0x801071df
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 b8 3b 00 00       	call   801043c0 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100836:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 73 3c 00 00       	call   801044e0 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008f1:	68 a0 ff 10 80       	push   $0x8010ffa0
801008f6:	e8 05 37 00 00       	call   80104000 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100934:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 74 37 00 00       	jmp    801040f0 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 e8 71 10 80       	push   $0x801071e8
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 0b 39 00 00       	call   801042c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 c2 18 00 00       	call   801022a0 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 9f 2e 00 00       	call   801038a0 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 64 22 00 00       	call   80102c70 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 a9 14 00 00       	call   80101ec0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 43 0c 00 00       	call   80101670 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 12 0f 00 00       	call   80101950 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 b1 0e 00 00       	call   80101900 <iunlockput>
    end_op();
80100a4f:	e8 8c 22 00 00       	call   80102ce0 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 67 63 00 00       	call   80106de0 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 83 0e 00 00       	call   80101950 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 27 61 00 00       	call   80106c30 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 31 60 00 00       	call   80106b70 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 02 62 00 00       	call   80106d60 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 91 0d 00 00       	call   80101900 <iunlockput>
  end_op();
80100b6f:	e8 6c 21 00 00       	call   80102ce0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 96 60 00 00       	call   80106c30 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 af 61 00 00       	call   80106d60 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 1d 21 00 00       	call   80102ce0 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 01 72 10 80       	push   $0x80107201
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 8a 62 00 00       	call   80106e80 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 3e 3b 00 00       	call   80104770 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 2b 3b 00 00       	call   80104770 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 7a 64 00 00       	call   801070d0 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 10 64 00 00       	call   801070d0 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 2b 3a 00 00       	call   80104730 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 af 5c 00 00       	call   801069e0 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 27 60 00 00       	call   80106d60 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 0d 72 10 80       	push   $0x8010720d
80100d5b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d60:	e8 5b 35 00 00       	call   801042c0 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d81:	e8 3a 36 00 00       	call   801043c0 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dac:	68 c0 ff 10 80       	push   $0x8010ffc0
80100db1:	e8 2a 37 00 00       	call   801044e0 <release>
      return f;
80100db6:	89 d8                	mov    %ebx,%eax
80100db8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc8:	e8 13 37 00 00       	call   801044e0 <release>
  return 0;
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	31 c0                	xor    %eax,%eax
}
80100dd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd5:	c9                   	leave  
80100dd6:	c3                   	ret    
80100dd7:	89 f6                	mov    %esi,%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 c0 ff 10 80       	push   $0x8010ffc0
80100def:	e8 cc 35 00 00       	call   801043c0 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e0c:	e8 cf 36 00 00       	call   801044e0 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 14 72 10 80       	push   $0x80107214
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e41:	e8 7a 35 00 00       	call   801043c0 <acquire>
  if(f->ref < 1)
80100e46:	8b 47 04             	mov    0x4(%edi),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 47 04             	mov    %eax,0x4(%edi)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
    release(&ftable.lock);
80100e5e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e6c:	e9 6f 36 00 00       	jmp    801044e0 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e78:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e7c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e81:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e84:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e90:	68 c0 ff 10 80       	push   $0x8010ffc0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e98:	e8 43 36 00 00       	call   801044e0 <release>

  if(ff.type == FD_PIPE)
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 fb 01             	cmp    $0x1,%ebx
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ea5:	83 fb 02             	cmp    $0x2,%ebx
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 4a 25 00 00       	call   80103410 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 9b 1d 00 00       	call   80102c70 <begin_op>
    iput(ff.ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 c0 08 00 00       	call   801017a0 <iput>
    end_op();
80100ee0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eea:	e9 f1 1d 00 00       	jmp    80102ce0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 1c 72 10 80       	push   $0x8010721c
80100ef7:	e8 74 f4 ff ff       	call   80100370 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 56 07 00 00       	call   80101670 <ilock>
    stati(f->ip, st);
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 f9 09 00 00       	call   80101920 <stati>
    iunlock(f->ip);
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 20 08 00 00       	call   80101750 <iunlock>
    return 0;
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
    ilock(f->ip);
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 f1 06 00 00       	call   80101670 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 c4 09 00 00       	call   80101950 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
      f->off += r;
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 ad 07 00 00       	call   80101750 <iunlock>
    return r;
80100fa3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fa6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fbd:	e9 ee 25 00 00       	jmp    801035b0 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fcd:	eb d9                	jmp    80100fa8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 26 72 10 80       	push   $0x80107226
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d8 00 00 00    	jne    801010ee <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 ff                	xor    %edi,%edi
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101028:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101034:	e8 17 07 00 00       	call   80101750 <iunlock>
      end_op();
80101039:	e8 a2 1c 00 00       	call   80102ce0 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101044:	39 d8                	cmp    %ebx,%eax
80101046:	0f 85 95 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010104c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101066:	e8 05 1c 00 00       	call   80102c70 <begin_op>
      ilock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 fa 05 00 00       	call   80101670 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 c8 09 00 00       	call   80101a50 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 b3 06 00 00       	call   80101750 <iunlock>
      end_op();
8010109d:	e8 3e 1c 00 00       	call   80102ce0 <end_op>

      if(r < 0)
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010b4:	5b                   	pop    %ebx
801010b5:	5e                   	pop    %esi
801010b6:	5f                   	pop    %edi
801010b7:	5d                   	pop    %ebp
801010b8:	c3                   	ret    
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
  }
  panic("filewrite");
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 46 0c             	mov    0xc(%esi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 cf 23 00 00       	jmp    801034b0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 2f 72 10 80       	push   $0x8010722f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 35 72 10 80       	push   $0x80107235
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101109:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 85 00 00 00    	je     8010119f <balloc+0x9f>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2d                	jmp    8010117a <balloc+0x7a>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101150:	89 c1                	mov    %eax,%ecx
80101152:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101157:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101169:	85 d7                	test   %edx,%edi
8010116b:	74 43                	je     801011b0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116d:	83 c0 01             	add    $0x1,%eax
80101170:	83 c6 01             	add    $0x1,%esi
80101173:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101178:	74 05                	je     8010117f <balloc+0x7f>
8010117a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117d:	72 d1                	jb     80101150 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	ff 75 e4             	pushl  -0x1c(%ebp)
80101185:	e8 56 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010118a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101197:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010119d:	77 82                	ja     80101121 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010119f:	83 ec 0c             	sub    $0xc,%esp
801011a2:	68 3f 72 10 80       	push   $0x8010723f
801011a7:	e8 c4 f1 ff ff       	call   80100370 <panic>
801011ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b0:	09 fa                	or     %edi,%edx
801011b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011b5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011bc:	57                   	push   %edi
801011bd:	e8 8e 1c 00 00       	call   80102e50 <log_write>
        brelse(bp);
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 46 33 00 00       	call   80104530 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 5e 1c 00 00       	call   80102e50 <log_write>
  brelse(bp);
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101218:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101225:	68 e0 09 11 80       	push   $0x801109e0
8010122a:	e8 91 31 00 00       	call   801043c0 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101250:	74 4e                	je     801012a0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101262:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101265:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101268:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010126a:	68 e0 09 11 80       	push   $0x801109e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101272:	e8 69 32 00 00       	call   801044e0 <release>
      return ip;
80101277:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101299:	75 b7                	jne    80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012a4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ba:	68 e0 09 11 80       	push   $0x801109e0
801012bf:	e8 1c 32 00 00       	call   801044e0 <release>

  return ip;
801012c4:	83 c4 10             	add    $0x10,%esp
}
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 55 72 10 80       	push   $0x80107255
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012f3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012f6:	85 c0                	test   %eax,%eax
801012f8:	74 76                	je     80101370 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	5b                   	pop    %ebx
801012fe:	5e                   	pop    %esi
801012ff:	5f                   	pop    %edi
80101300:	5d                   	pop    %ebp
80101301:	c3                   	ret    
80101302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 83 00 00 00    	ja     80101397 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101314:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131a:	85 c0                	test   %eax,%eax
8010131c:	74 6a                	je     80101388 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	50                   	push   %eax
80101322:	ff 36                	pushl  (%esi)
80101324:	e8 a7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101329:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101330:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101332:	8b 1a                	mov    (%edx),%ebx
80101334:	85 db                	test   %ebx,%ebx
80101336:	75 1d                	jne    80101355 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133d:	e8 be fd ff ff       	call   80101100 <balloc>
80101342:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101345:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101348:	89 c3                	mov    %eax,%ebx
8010134a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010134c:	57                   	push   %edi
8010134d:	e8 fe 1a 00 00       	call   80102e50 <log_write>
80101352:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	57                   	push   %edi
80101359:	e8 82 ee ff ff       	call   801001e0 <brelse>
8010135e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101364:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101366:	5b                   	pop    %ebx
80101367:	5e                   	pop    %esi
80101368:	5f                   	pop    %edi
80101369:	5d                   	pop    %ebp
8010136a:	c3                   	ret    
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101370:	8b 06                	mov    (%esi),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101388:	8b 06                	mov    (%esi),%eax
8010138a:	e8 71 fd ff ff       	call   80101100 <balloc>
8010138f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101395:	eb 87                	jmp    8010131e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101397:	83 ec 0c             	sub    $0xc,%esp
8010139a:	68 65 72 10 80       	push   $0x80107265
8010139f:	e8 cc ef ff ff       	call   80100370 <panic>
801013a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013b0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013b8:	83 ec 08             	sub    $0x8,%esp
801013bb:	6a 01                	push   $0x1
801013bd:	ff 75 08             	pushl  0x8(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	6a 1c                	push   $0x1c
801013cf:	50                   	push   %eax
801013d0:	56                   	push   %esi
801013d1:	e8 0a 32 00 00       	call   801045e0 <memmove>
  brelse(bp);
801013d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013d9:	83 c4 10             	add    $0x10,%esp
}
801013dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013e2:	e9 f9 ed ff ff       	jmp    801001e0 <brelse>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	89 d3                	mov    %edx,%ebx
801013f7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013f9:	83 ec 08             	sub    $0x8,%esp
801013fc:	68 c0 09 11 80       	push   $0x801109c0
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101414:	52                   	push   %edx
80101415:	56                   	push   %esi
80101416:	e8 b5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010141b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010141d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101423:	ba 01 00 00 00       	mov    $0x1,%edx
80101428:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010142b:	c1 fb 03             	sar    $0x3,%ebx
8010142e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101431:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101433:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101438:	85 d1                	test   %edx,%ecx
8010143a:	74 27                	je     80101463 <bfree+0x73>
8010143c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010143e:	f7 d2                	not    %edx
80101440:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101442:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101445:	21 d0                	and    %edx,%eax
80101447:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010144b:	56                   	push   %esi
8010144c:	e8 ff 19 00 00       	call   80102e50 <log_write>
  brelse(bp);
80101451:	89 34 24             	mov    %esi,(%esp)
80101454:	e8 87 ed ff ff       	call   801001e0 <brelse>
}
80101459:	83 c4 10             	add    $0x10,%esp
8010145c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101463:	83 ec 0c             	sub    $0xc,%esp
80101466:	68 78 72 10 80       	push   $0x80107278
8010146b:	e8 00 ef ff ff       	call   80100370 <panic>

80101470 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010147c:	68 8b 72 10 80       	push   $0x8010728b
80101481:	68 e0 09 11 80       	push   $0x801109e0
80101486:	e8 35 2e 00 00       	call   801042c0 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 92 72 10 80       	push   $0x80107292
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 0c 2d 00 00       	call   801041b0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 c0 09 11 80       	push   $0x801109c0
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014bf:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014c5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014cb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014d1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014d7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014dd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014e3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014e9:	68 f8 72 10 80       	push   $0x801072f8
801014ee:	e8 6d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014f3:	83 c4 30             	add    $0x30,%esp
801014f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014f9:	c9                   	leave  
801014fa:	c3                   	ret    
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101500 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101510:	8b 45 0c             	mov    0xc(%ebp),%eax
80101513:	8b 75 08             	mov    0x8(%ebp),%esi
80101516:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	0f 86 91 00 00 00    	jbe    801015b0 <ialloc+0xb0>
8010151f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101524:	eb 21                	jmp    80101547 <ialloc+0x47>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101530:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101533:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101536:	57                   	push   %edi
80101537:	e8 a4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010153c:	83 c4 10             	add    $0x10,%esp
8010153f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101555:	50                   	push   %eax
80101556:	56                   	push   %esi
80101557:	e8 74 eb ff ff       	call   801000d0 <bread>
8010155c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010155e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101560:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101573:	83 ec 04             	sub    $0x4,%esp
80101576:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101579:	6a 40                	push   $0x40
8010157b:	6a 00                	push   $0x0
8010157d:	51                   	push   %ecx
8010157e:	e8 ad 2f 00 00       	call   80104530 <memset>
      dip->type = type;
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 bb 18 00 00       	call   80102e50 <log_write>
      brelse(bp);
80101595:	89 3c 24             	mov    %edi,(%esp)
80101598:	e8 43 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010159d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015a3:	89 da                	mov    %ebx,%edx
801015a5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a7:	5b                   	pop    %ebx
801015a8:	5e                   	pop    %esi
801015a9:	5f                   	pop    %edi
801015aa:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015ab:	e9 60 fc ff ff       	jmp    80101210 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015b0:	83 ec 0c             	sub    $0xc,%esp
801015b3:	68 98 72 10 80       	push   $0x80107298
801015b8:	e8 b3 ed ff ff       	call   80100370 <panic>
801015bd:	8d 76 00             	lea    0x0(%esi),%esi

801015c0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c8:	83 ec 08             	sub    $0x8,%esp
801015cb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ce:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d1:	c1 e8 03             	shr    $0x3,%eax
801015d4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015da:	50                   	push   %eax
801015db:	ff 73 a4             	pushl  -0x5c(%ebx)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
801015e3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ec:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ef:	83 e0 07             	and    $0x7,%eax
801015f2:	c1 e0 06             	shl    $0x6,%eax
801015f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101600:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101603:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101607:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010160b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010160f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101613:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101617:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010161a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161d:	6a 34                	push   $0x34
8010161f:	53                   	push   %ebx
80101620:	50                   	push   %eax
80101621:	e8 ba 2f 00 00       	call   801045e0 <memmove>
  log_write(bp);
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 22 18 00 00       	call   80102e50 <log_write>
  brelse(bp);
8010162e:	89 75 08             	mov    %esi,0x8(%ebp)
80101631:	83 c4 10             	add    $0x10,%esp
}
80101634:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010163a:	e9 a1 eb ff ff       	jmp    801001e0 <brelse>
8010163f:	90                   	nop

80101640 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	83 ec 10             	sub    $0x10,%esp
80101647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010164a:	68 e0 09 11 80       	push   $0x801109e0
8010164f:	e8 6c 2d 00 00       	call   801043c0 <acquire>
  ip->ref++;
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101658:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010165f:	e8 7c 2e 00 00       	call   801044e0 <release>
  return ip;
}
80101664:	89 d8                	mov    %ebx,%eax
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101678:	85 db                	test   %ebx,%ebx
8010167a:	0f 84 b7 00 00 00    	je     80101737 <ilock+0xc7>
80101680:	8b 53 08             	mov    0x8(%ebx),%edx
80101683:	85 d2                	test   %edx,%edx
80101685:	0f 8e ac 00 00 00    	jle    80101737 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010168b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010168e:	83 ec 0c             	sub    $0xc,%esp
80101691:	50                   	push   %eax
80101692:	e8 59 2b 00 00       	call   801041f0 <acquiresleep>

  if(ip->valid == 0){
80101697:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010169a:	83 c4 10             	add    $0x10,%esp
8010169d:	85 c0                	test   %eax,%eax
8010169f:	74 0f                	je     801016b0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016a4:	5b                   	pop    %ebx
801016a5:	5e                   	pop    %esi
801016a6:	5d                   	pop    %ebp
801016a7:	c3                   	ret    
801016a8:	90                   	nop
801016a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b0:	8b 43 04             	mov    0x4(%ebx),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	c1 e8 03             	shr    $0x3,%eax
801016b9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016bf:	50                   	push   %eax
801016c0:	ff 33                	pushl  (%ebx)
801016c2:	e8 09 ea ff ff       	call   801000d0 <bread>
801016c7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016d9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101701:	6a 34                	push   $0x34
80101703:	50                   	push   %eax
80101704:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101707:	50                   	push   %eax
80101708:	e8 d3 2e 00 00       	call   801045e0 <memmove>
    brelse(bp);
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010171d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101724:	0f 85 77 ff ff ff    	jne    801016a1 <ilock+0x31>
      panic("ilock: no type");
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	68 b0 72 10 80       	push   $0x801072b0
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 aa 72 10 80       	push   $0x801072aa
8010173f:	e8 2c ec ff ff       	call   80100370 <panic>
80101744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010174a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101750 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101758:	85 db                	test   %ebx,%ebx
8010175a:	74 28                	je     80101784 <iunlock+0x34>
8010175c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	56                   	push   %esi
80101763:	e8 28 2b 00 00       	call   80104290 <holdingsleep>
80101768:	83 c4 10             	add    $0x10,%esp
8010176b:	85 c0                	test   %eax,%eax
8010176d:	74 15                	je     80101784 <iunlock+0x34>
8010176f:	8b 43 08             	mov    0x8(%ebx),%eax
80101772:	85 c0                	test   %eax,%eax
80101774:	7e 0e                	jle    80101784 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101776:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101779:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010177f:	e9 cc 2a 00 00       	jmp    80104250 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 bf 72 10 80       	push   $0x801072bf
8010178c:	e8 df eb ff ff       	call   80100370 <panic>
80101791:	eb 0d                	jmp    801017a0 <iput>
80101793:	90                   	nop
80101794:	90                   	nop
80101795:	90                   	nop
80101796:	90                   	nop
80101797:	90                   	nop
80101798:	90                   	nop
80101799:	90                   	nop
8010179a:	90                   	nop
8010179b:	90                   	nop
8010179c:	90                   	nop
8010179d:	90                   	nop
8010179e:	90                   	nop
8010179f:	90                   	nop

801017a0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 28             	sub    $0x28,%esp
801017a9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801017af:	57                   	push   %edi
801017b0:	e8 3b 2a 00 00       	call   801041f0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 d2                	test   %edx,%edx
801017bd:	74 07                	je     801017c6 <iput+0x26>
801017bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017c4:	74 32                	je     801017f8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801017c6:	83 ec 0c             	sub    $0xc,%esp
801017c9:	57                   	push   %edi
801017ca:	e8 81 2a 00 00       	call   80104250 <releasesleep>

  acquire(&icache.lock);
801017cf:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017d6:	e8 e5 2b 00 00       	call   801043c0 <acquire>
  ip->ref--;
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801017e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ec:	5b                   	pop    %ebx
801017ed:	5e                   	pop    %esi
801017ee:	5f                   	pop    %edi
801017ef:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801017f0:	e9 eb 2c 00 00       	jmp    801044e0 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 e0 09 11 80       	push   $0x801109e0
80101800:	e8 bb 2b 00 00       	call   801043c0 <acquire>
    int r = ip->ref;
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101808:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010180f:	e8 cc 2c 00 00       	call   801044e0 <release>
    if(r == 1){
80101814:	83 c4 10             	add    $0x10,%esp
80101817:	83 fb 01             	cmp    $0x1,%ebx
8010181a:	75 aa                	jne    801017c6 <iput+0x26>
8010181c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101822:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101825:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101828:	89 cf                	mov    %ecx,%edi
8010182a:	eb 0b                	jmp    80101837 <iput+0x97>
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101830:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101833:	39 fb                	cmp    %edi,%ebx
80101835:	74 19                	je     80101850 <iput+0xb0>
    if(ip->addrs[i]){
80101837:	8b 13                	mov    (%ebx),%edx
80101839:	85 d2                	test   %edx,%edx
8010183b:	74 f3                	je     80101830 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010183d:	8b 06                	mov    (%esi),%eax
8010183f:	e8 ac fb ff ff       	call   801013f0 <bfree>
      ip->addrs[i] = 0;
80101844:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010184a:	eb e4                	jmp    80101830 <iput+0x90>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101850:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101856:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101859:	85 c0                	test   %eax,%eax
8010185b:	75 33                	jne    80101890 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010185d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101860:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101867:	56                   	push   %esi
80101868:	e8 53 fd ff ff       	call   801015c0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010186d:	31 c0                	xor    %eax,%eax
8010186f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101873:	89 34 24             	mov    %esi,(%esp)
80101876:	e8 45 fd ff ff       	call   801015c0 <iupdate>
      ip->valid = 0;
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101882:	83 c4 10             	add    $0x10,%esp
80101885:	e9 3c ff ff ff       	jmp    801017c6 <iput+0x26>
8010188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	50                   	push   %eax
80101894:	ff 36                	pushl  (%esi)
80101896:	e8 35 e8 ff ff       	call   801000d0 <bread>
8010189b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018a1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018a7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018aa:	83 c4 10             	add    $0x10,%esp
801018ad:	89 cf                	mov    %ecx,%edi
801018af:	eb 0e                	jmp    801018bf <iput+0x11f>
801018b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018b8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018bb:	39 fb                	cmp    %edi,%ebx
801018bd:	74 0f                	je     801018ce <iput+0x12e>
      if(a[j])
801018bf:	8b 13                	mov    (%ebx),%edx
801018c1:	85 d2                	test   %edx,%edx
801018c3:	74 f3                	je     801018b8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018c5:	8b 06                	mov    (%esi),%eax
801018c7:	e8 24 fb ff ff       	call   801013f0 <bfree>
801018cc:	eb ea                	jmp    801018b8 <iput+0x118>
    }
    brelse(bp);
801018ce:	83 ec 0c             	sub    $0xc,%esp
801018d1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018d7:	e8 04 e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018dc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018e2:	8b 06                	mov    (%esi),%eax
801018e4:	e8 07 fb ff ff       	call   801013f0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018e9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018f0:	00 00 00 
801018f3:	83 c4 10             	add    $0x10,%esp
801018f6:	e9 62 ff ff ff       	jmp    8010185d <iput+0xbd>
801018fb:	90                   	nop
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101900 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	53                   	push   %ebx
80101904:	83 ec 10             	sub    $0x10,%esp
80101907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010190a:	53                   	push   %ebx
8010190b:	e8 40 fe ff ff       	call   80101750 <iunlock>
  iput(ip);
80101910:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101913:	83 c4 10             	add    $0x10,%esp
}
80101916:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101919:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010191a:	e9 81 fe ff ff       	jmp    801017a0 <iput>
8010191f:	90                   	nop

80101920 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	8b 55 08             	mov    0x8(%ebp),%edx
80101926:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101929:	8b 0a                	mov    (%edx),%ecx
8010192b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010192e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101931:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101934:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101938:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010193b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010193f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101943:	8b 52 58             	mov    0x58(%edx),%edx
80101946:	89 50 10             	mov    %edx,0x10(%eax)
}
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	57                   	push   %edi
80101954:	56                   	push   %esi
80101955:	53                   	push   %ebx
80101956:	83 ec 1c             	sub    $0x1c,%esp
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010195f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101962:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101967:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010196a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010196d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101970:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101973:	0f 84 a7 00 00 00    	je     80101a20 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101979:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010197c:	8b 40 58             	mov    0x58(%eax),%eax
8010197f:	39 f0                	cmp    %esi,%eax
80101981:	0f 82 c1 00 00 00    	jb     80101a48 <readi+0xf8>
80101987:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010198a:	89 fa                	mov    %edi,%edx
8010198c:	01 f2                	add    %esi,%edx
8010198e:	0f 82 b4 00 00 00    	jb     80101a48 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101994:	89 c1                	mov    %eax,%ecx
80101996:	29 f1                	sub    %esi,%ecx
80101998:	39 d0                	cmp    %edx,%eax
8010199a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010199d:	31 ff                	xor    %edi,%edi
8010199f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019a4:	74 6d                	je     80101a13 <readi+0xc3>
801019a6:	8d 76 00             	lea    0x0(%esi),%esi
801019a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019b0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019b3:	89 f2                	mov    %esi,%edx
801019b5:	c1 ea 09             	shr    $0x9,%edx
801019b8:	89 d8                	mov    %ebx,%eax
801019ba:	e8 21 f9 ff ff       	call   801012e0 <bmap>
801019bf:	83 ec 08             	sub    $0x8,%esp
801019c2:	50                   	push   %eax
801019c3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
801019c5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ca:	e8 01 e7 ff ff       	call   801000d0 <bread>
801019cf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019d4:	89 f1                	mov    %esi,%ecx
801019d6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019dc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801019df:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019e2:	29 cb                	sub    %ecx,%ebx
801019e4:	29 f8                	sub    %edi,%eax
801019e6:	39 c3                	cmp    %eax,%ebx
801019e8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019eb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019ef:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f0:	01 df                	add    %ebx,%edi
801019f2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019f4:	50                   	push   %eax
801019f5:	ff 75 e0             	pushl  -0x20(%ebp)
801019f8:	e8 e3 2b 00 00       	call   801045e0 <memmove>
    brelse(bp);
801019fd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a00:	89 14 24             	mov    %edx,(%esp)
80101a03:	e8 d8 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a08:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a11:	77 9d                	ja     801019b0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a19:	5b                   	pop    %ebx
80101a1a:	5e                   	pop    %esi
80101a1b:	5f                   	pop    %edi
80101a1c:	5d                   	pop    %ebp
80101a1d:	c3                   	ret    
80101a1e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a24:	66 83 f8 09          	cmp    $0x9,%ax
80101a28:	77 1e                	ja     80101a48 <readi+0xf8>
80101a2a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a31:	85 c0                	test   %eax,%eax
80101a33:	74 13                	je     80101a48 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a35:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a3b:	5b                   	pop    %ebx
80101a3c:	5e                   	pop    %esi
80101a3d:	5f                   	pop    %edi
80101a3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a3f:	ff e0                	jmp    *%eax
80101a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a4d:	eb c7                	jmp    80101a16 <readi+0xc6>
80101a4f:	90                   	nop

80101a50 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 1c             	sub    $0x1c,%esp
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a5f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a6d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a70:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a73:	0f 84 b7 00 00 00    	je     80101b30 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a7f:	0f 82 eb 00 00 00    	jb     80101b70 <writei+0x120>
80101a85:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a88:	89 f8                	mov    %edi,%eax
80101a8a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a8c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a91:	0f 87 d9 00 00 00    	ja     80101b70 <writei+0x120>
80101a97:	39 c6                	cmp    %eax,%esi
80101a99:	0f 87 d1 00 00 00    	ja     80101b70 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a9f:	85 ff                	test   %edi,%edi
80101aa1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101aa8:	74 78                	je     80101b22 <writei+0xd2>
80101aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ab3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ab5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aba:	c1 ea 09             	shr    $0x9,%edx
80101abd:	89 f8                	mov    %edi,%eax
80101abf:	e8 1c f8 ff ff       	call   801012e0 <bmap>
80101ac4:	83 ec 08             	sub    $0x8,%esp
80101ac7:	50                   	push   %eax
80101ac8:	ff 37                	pushl  (%edi)
80101aca:	e8 01 e6 ff ff       	call   801000d0 <bread>
80101acf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ad1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ad4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ad7:	89 f1                	mov    %esi,%ecx
80101ad9:	83 c4 0c             	add    $0xc,%esp
80101adc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ae2:	29 cb                	sub    %ecx,%ebx
80101ae4:	39 c3                	cmp    %eax,%ebx
80101ae6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ae9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101aed:	53                   	push   %ebx
80101aee:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	50                   	push   %eax
80101af4:	e8 e7 2a 00 00       	call   801045e0 <memmove>
    log_write(bp);
80101af9:	89 3c 24             	mov    %edi,(%esp)
80101afc:	e8 4f 13 00 00       	call   80102e50 <log_write>
    brelse(bp);
80101b01:	89 3c 24             	mov    %edi,(%esp)
80101b04:	e8 d7 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b09:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b0c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b0f:	83 c4 10             	add    $0x10,%esp
80101b12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b15:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b18:	77 96                	ja     80101ab0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b1d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b20:	77 36                	ja     80101b58 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b28:	5b                   	pop    %ebx
80101b29:	5e                   	pop    %esi
80101b2a:	5f                   	pop    %edi
80101b2b:	5d                   	pop    %ebp
80101b2c:	c3                   	ret    
80101b2d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b34:	66 83 f8 09          	cmp    $0x9,%ax
80101b38:	77 36                	ja     80101b70 <writei+0x120>
80101b3a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b41:	85 c0                	test   %eax,%eax
80101b43:	74 2b                	je     80101b70 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b45:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b4b:	5b                   	pop    %ebx
80101b4c:	5e                   	pop    %esi
80101b4d:	5f                   	pop    %edi
80101b4e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b4f:	ff e0                	jmp    *%eax
80101b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b5b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b5e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b61:	50                   	push   %eax
80101b62:	e8 59 fa ff ff       	call   801015c0 <iupdate>
80101b67:	83 c4 10             	add    $0x10,%esp
80101b6a:	eb b6                	jmp    80101b22 <writei+0xd2>
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b75:	eb ae                	jmp    80101b25 <writei+0xd5>
80101b77:	89 f6                	mov    %esi,%esi
80101b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b86:	6a 0e                	push   $0xe
80101b88:	ff 75 0c             	pushl  0xc(%ebp)
80101b8b:	ff 75 08             	pushl  0x8(%ebp)
80101b8e:	e8 cd 2a 00 00       	call   80104660 <strncmp>
}
80101b93:	c9                   	leave  
80101b94:	c3                   	ret    
80101b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bb1:	0f 85 80 00 00 00    	jne    80101c37 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bb7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bba:	31 ff                	xor    %edi,%edi
80101bbc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bbf:	85 d2                	test   %edx,%edx
80101bc1:	75 0d                	jne    80101bd0 <dirlookup+0x30>
80101bc3:	eb 5b                	jmp    80101c20 <dirlookup+0x80>
80101bc5:	8d 76 00             	lea    0x0(%esi),%esi
80101bc8:	83 c7 10             	add    $0x10,%edi
80101bcb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bce:	76 50                	jbe    80101c20 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd0:	6a 10                	push   $0x10
80101bd2:	57                   	push   %edi
80101bd3:	56                   	push   %esi
80101bd4:	53                   	push   %ebx
80101bd5:	e8 76 fd ff ff       	call   80101950 <readi>
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	83 f8 10             	cmp    $0x10,%eax
80101be0:	75 48                	jne    80101c2a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101be2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101be7:	74 df                	je     80101bc8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101be9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bec:	83 ec 04             	sub    $0x4,%esp
80101bef:	6a 0e                	push   $0xe
80101bf1:	50                   	push   %eax
80101bf2:	ff 75 0c             	pushl  0xc(%ebp)
80101bf5:	e8 66 2a 00 00       	call   80104660 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bfa:	83 c4 10             	add    $0x10,%esp
80101bfd:	85 c0                	test   %eax,%eax
80101bff:	75 c7                	jne    80101bc8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c01:	8b 45 10             	mov    0x10(%ebp),%eax
80101c04:	85 c0                	test   %eax,%eax
80101c06:	74 05                	je     80101c0d <dirlookup+0x6d>
        *poff = off;
80101c08:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c0d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c11:	8b 03                	mov    (%ebx),%eax
80101c13:	e8 f8 f5 ff ff       	call   80101210 <iget>
    }
  }

  return 0;
}
80101c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1b:	5b                   	pop    %ebx
80101c1c:	5e                   	pop    %esi
80101c1d:	5f                   	pop    %edi
80101c1e:	5d                   	pop    %ebp
80101c1f:	c3                   	ret    
80101c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c23:	31 c0                	xor    %eax,%eax
}
80101c25:	5b                   	pop    %ebx
80101c26:	5e                   	pop    %esi
80101c27:	5f                   	pop    %edi
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c2a:	83 ec 0c             	sub    $0xc,%esp
80101c2d:	68 d9 72 10 80       	push   $0x801072d9
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 c7 72 10 80       	push   $0x801072c7
80101c3f:	e8 2c e7 ff ff       	call   80100370 <panic>
80101c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c50 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	89 cf                	mov    %ecx,%edi
80101c58:	89 c3                	mov    %eax,%ebx
80101c5a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c5d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c63:	0f 84 53 01 00 00    	je     80101dbc <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c69:	e8 32 1c 00 00       	call   801038a0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c6e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c71:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c74:	68 e0 09 11 80       	push   $0x801109e0
80101c79:	e8 42 27 00 00       	call   801043c0 <acquire>
  ip->ref++;
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c82:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c89:	e8 52 28 00 00       	call   801044e0 <release>
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	eb 08                	jmp    80101c9b <namex+0x4b>
80101c93:	90                   	nop
80101c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c98:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c9b:	0f b6 03             	movzbl (%ebx),%eax
80101c9e:	3c 2f                	cmp    $0x2f,%al
80101ca0:	74 f6                	je     80101c98 <namex+0x48>
    path++;
  if(*path == 0)
80101ca2:	84 c0                	test   %al,%al
80101ca4:	0f 84 e3 00 00 00    	je     80101d8d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101caa:	0f b6 03             	movzbl (%ebx),%eax
80101cad:	89 da                	mov    %ebx,%edx
80101caf:	84 c0                	test   %al,%al
80101cb1:	0f 84 ac 00 00 00    	je     80101d63 <namex+0x113>
80101cb7:	3c 2f                	cmp    $0x2f,%al
80101cb9:	75 09                	jne    80101cc4 <namex+0x74>
80101cbb:	e9 a3 00 00 00       	jmp    80101d63 <namex+0x113>
80101cc0:	84 c0                	test   %al,%al
80101cc2:	74 0a                	je     80101cce <namex+0x7e>
    path++;
80101cc4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cc7:	0f b6 02             	movzbl (%edx),%eax
80101cca:	3c 2f                	cmp    $0x2f,%al
80101ccc:	75 f2                	jne    80101cc0 <namex+0x70>
80101cce:	89 d1                	mov    %edx,%ecx
80101cd0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cd2:	83 f9 0d             	cmp    $0xd,%ecx
80101cd5:	0f 8e 8d 00 00 00    	jle    80101d68 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cdb:	83 ec 04             	sub    $0x4,%esp
80101cde:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ce1:	6a 0e                	push   $0xe
80101ce3:	53                   	push   %ebx
80101ce4:	57                   	push   %edi
80101ce5:	e8 f6 28 00 00       	call   801045e0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101ced:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cf0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cf2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cf5:	75 11                	jne    80101d08 <namex+0xb8>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d00:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d06:	74 f8                	je     80101d00 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d08:	83 ec 0c             	sub    $0xc,%esp
80101d0b:	56                   	push   %esi
80101d0c:	e8 5f f9 ff ff       	call   80101670 <ilock>
    if(ip->type != T_DIR){
80101d11:	83 c4 10             	add    $0x10,%esp
80101d14:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d19:	0f 85 7f 00 00 00    	jne    80101d9e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d22:	85 d2                	test   %edx,%edx
80101d24:	74 09                	je     80101d2f <namex+0xdf>
80101d26:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d29:	0f 84 a3 00 00 00    	je     80101dd2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d2f:	83 ec 04             	sub    $0x4,%esp
80101d32:	6a 00                	push   $0x0
80101d34:	57                   	push   %edi
80101d35:	56                   	push   %esi
80101d36:	e8 65 fe ff ff       	call   80101ba0 <dirlookup>
80101d3b:	83 c4 10             	add    $0x10,%esp
80101d3e:	85 c0                	test   %eax,%eax
80101d40:	74 5c                	je     80101d9e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d42:	83 ec 0c             	sub    $0xc,%esp
80101d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d48:	56                   	push   %esi
80101d49:	e8 02 fa ff ff       	call   80101750 <iunlock>
  iput(ip);
80101d4e:	89 34 24             	mov    %esi,(%esp)
80101d51:	e8 4a fa ff ff       	call   801017a0 <iput>
80101d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d59:	83 c4 10             	add    $0x10,%esp
80101d5c:	89 c6                	mov    %eax,%esi
80101d5e:	e9 38 ff ff ff       	jmp    80101c9b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d63:	31 c9                	xor    %ecx,%ecx
80101d65:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d68:	83 ec 04             	sub    $0x4,%esp
80101d6b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d6e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d71:	51                   	push   %ecx
80101d72:	53                   	push   %ebx
80101d73:	57                   	push   %edi
80101d74:	e8 67 28 00 00       	call   801045e0 <memmove>
    name[len] = 0;
80101d79:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	83 c4 10             	add    $0x10,%esp
80101d82:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d86:	89 d3                	mov    %edx,%ebx
80101d88:	e9 65 ff ff ff       	jmp    80101cf2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d90:	85 c0                	test   %eax,%eax
80101d92:	75 54                	jne    80101de8 <namex+0x198>
80101d94:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	5b                   	pop    %ebx
80101d9a:	5e                   	pop    %esi
80101d9b:	5f                   	pop    %edi
80101d9c:	5d                   	pop    %ebp
80101d9d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d9e:	83 ec 0c             	sub    $0xc,%esp
80101da1:	56                   	push   %esi
80101da2:	e8 a9 f9 ff ff       	call   80101750 <iunlock>
  iput(ip);
80101da7:	89 34 24             	mov    %esi,(%esp)
80101daa:	e8 f1 f9 ff ff       	call   801017a0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101daf:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101db2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101db5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101db7:	5b                   	pop    %ebx
80101db8:	5e                   	pop    %esi
80101db9:	5f                   	pop    %edi
80101dba:	5d                   	pop    %ebp
80101dbb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101dbc:	ba 01 00 00 00       	mov    $0x1,%edx
80101dc1:	b8 01 00 00 00       	mov    $0x1,%eax
80101dc6:	e8 45 f4 ff ff       	call   80101210 <iget>
80101dcb:	89 c6                	mov    %eax,%esi
80101dcd:	e9 c9 fe ff ff       	jmp    80101c9b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101dd2:	83 ec 0c             	sub    $0xc,%esp
80101dd5:	56                   	push   %esi
80101dd6:	e8 75 f9 ff ff       	call   80101750 <iunlock>
      return ip;
80101ddb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dde:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101de1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101de3:	5b                   	pop    %ebx
80101de4:	5e                   	pop    %esi
80101de5:	5f                   	pop    %edi
80101de6:	5d                   	pop    %ebp
80101de7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	56                   	push   %esi
80101dec:	e8 af f9 ff ff       	call   801017a0 <iput>
    return 0;
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	31 c0                	xor    %eax,%eax
80101df6:	eb 9e                	jmp    80101d96 <namex+0x146>
80101df8:	90                   	nop
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 20             	sub    $0x20,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e0c:	6a 00                	push   $0x0
80101e0e:	ff 75 0c             	pushl  0xc(%ebp)
80101e11:	53                   	push   %ebx
80101e12:	e8 89 fd ff ff       	call   80101ba0 <dirlookup>
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	75 67                	jne    80101e85 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e1e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e21:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e24:	85 ff                	test   %edi,%edi
80101e26:	74 29                	je     80101e51 <dirlink+0x51>
80101e28:	31 ff                	xor    %edi,%edi
80101e2a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e2d:	eb 09                	jmp    80101e38 <dirlink+0x38>
80101e2f:	90                   	nop
80101e30:	83 c7 10             	add    $0x10,%edi
80101e33:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e36:	76 19                	jbe    80101e51 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 0e fb ff ff       	call   80101950 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 4e                	jne    80101e98 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	75 df                	jne    80101e30 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e54:	83 ec 04             	sub    $0x4,%esp
80101e57:	6a 0e                	push   $0xe
80101e59:	ff 75 0c             	pushl  0xc(%ebp)
80101e5c:	50                   	push   %eax
80101e5d:	e8 6e 28 00 00       	call   801046d0 <strncpy>
  de.inum = inum;
80101e62:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e65:	6a 10                	push   $0x10
80101e67:	57                   	push   %edi
80101e68:	56                   	push   %esi
80101e69:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6e:	e8 dd fb ff ff       	call   80101a50 <writei>
80101e73:	83 c4 20             	add    $0x20,%esp
80101e76:	83 f8 10             	cmp    $0x10,%eax
80101e79:	75 2a                	jne    80101ea5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e7b:	31 c0                	xor    %eax,%eax
}
80101e7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e80:	5b                   	pop    %ebx
80101e81:	5e                   	pop    %esi
80101e82:	5f                   	pop    %edi
80101e83:	5d                   	pop    %ebp
80101e84:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	50                   	push   %eax
80101e89:	e8 12 f9 ff ff       	call   801017a0 <iput>
    return -1;
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb e5                	jmp    80101e7d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e98:	83 ec 0c             	sub    $0xc,%esp
80101e9b:	68 e8 72 10 80       	push   $0x801072e8
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 0a 79 10 80       	push   $0x8010790a
80101ead:	e8 be e4 ff ff       	call   80100370 <panic>
80101eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ec0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 7d fd ff ff       	call   80101c50 <namex>
}
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ee0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ee1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ee6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ee8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101eee:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101eef:	e9 5c fd ff ff       	jmp    80101c50 <namex>
80101ef4:	66 90                	xchg   %ax,%ax
80101ef6:	66 90                	xchg   %ax,%ax
80101ef8:	66 90                	xchg   %ax,%ax
80101efa:	66 90                	xchg   %ax,%ax
80101efc:	66 90                	xchg   %ax,%ax
80101efe:	66 90                	xchg   %ax,%ax

80101f00 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f00:	55                   	push   %ebp
  if(b == 0)
80101f01:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	56                   	push   %esi
80101f06:	53                   	push   %ebx
  if(b == 0)
80101f07:	0f 84 ad 00 00 00    	je     80101fba <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f0d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f10:	89 c1                	mov    %eax,%ecx
80101f12:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f18:	0f 87 8f 00 00 00    	ja     80101fad <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f1e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f23:	90                   	nop
80101f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f28:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f29:	83 e0 c0             	and    $0xffffffc0,%eax
80101f2c:	3c 40                	cmp    $0x40,%al
80101f2e:	75 f8                	jne    80101f28 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f30:	31 f6                	xor    %esi,%esi
80101f32:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f37:	89 f0                	mov    %esi,%eax
80101f39:	ee                   	out    %al,(%dx)
80101f3a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f3f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f44:	ee                   	out    %al,(%dx)
80101f45:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f4a:	89 d8                	mov    %ebx,%eax
80101f4c:	ee                   	out    %al,(%dx)
80101f4d:	89 d8                	mov    %ebx,%eax
80101f4f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f54:	c1 f8 08             	sar    $0x8,%eax
80101f57:	ee                   	out    %al,(%dx)
80101f58:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f5d:	89 f0                	mov    %esi,%eax
80101f5f:	ee                   	out    %al,(%dx)
80101f60:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f64:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f69:	83 e0 01             	and    $0x1,%eax
80101f6c:	c1 e0 04             	shl    $0x4,%eax
80101f6f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f72:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f73:	f6 01 04             	testb  $0x4,(%ecx)
80101f76:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f7b:	75 13                	jne    80101f90 <idestart+0x90>
80101f7d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f82:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5d                   	pop    %ebp
80101f89:	c3                   	ret    
80101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f90:	b8 30 00 00 00       	mov    $0x30,%eax
80101f95:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f96:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f9b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f9e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fa3:	fc                   	cld    
80101fa4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fa9:	5b                   	pop    %ebx
80101faa:	5e                   	pop    %esi
80101fab:	5d                   	pop    %ebp
80101fac:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101fad:	83 ec 0c             	sub    $0xc,%esp
80101fb0:	68 54 73 10 80       	push   $0x80107354
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 4b 73 10 80       	push   $0x8010734b
80101fc2:	e8 a9 e3 ff ff       	call   80100370 <panic>
80101fc7:	89 f6                	mov    %esi,%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fd6:	68 66 73 10 80       	push   $0x80107366
80101fdb:	68 80 a5 10 80       	push   $0x8010a580
80101fe0:	e8 db 22 00 00       	call   801042c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fe5:	58                   	pop    %eax
80101fe6:	a1 00 ad 14 80       	mov    0x8014ad00,%eax
80101feb:	5a                   	pop    %edx
80101fec:	83 e8 01             	sub    $0x1,%eax
80101fef:	50                   	push   %eax
80101ff0:	6a 0e                	push   $0xe
80101ff2:	e8 a9 02 00 00       	call   801022a0 <ioapicenable>
80101ff7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ffa:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fff:	90                   	nop
80102000:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102001:	83 e0 c0             	and    $0xffffffc0,%eax
80102004:	3c 40                	cmp    $0x40,%al
80102006:	75 f8                	jne    80102000 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102008:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010200d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102012:	ee                   	out    %al,(%dx)
80102013:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102018:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201d:	eb 06                	jmp    80102025 <ideinit+0x55>
8010201f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102020:	83 e9 01             	sub    $0x1,%ecx
80102023:	74 0f                	je     80102034 <ideinit+0x64>
80102025:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102026:	84 c0                	test   %al,%al
80102028:	74 f6                	je     80102020 <ideinit+0x50>
      havedisk1 = 1;
8010202a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102031:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102034:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102039:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010203e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010203f:	c9                   	leave  
80102040:	c3                   	ret    
80102041:	eb 0d                	jmp    80102050 <ideintr>
80102043:	90                   	nop
80102044:	90                   	nop
80102045:	90                   	nop
80102046:	90                   	nop
80102047:	90                   	nop
80102048:	90                   	nop
80102049:	90                   	nop
8010204a:	90                   	nop
8010204b:	90                   	nop
8010204c:	90                   	nop
8010204d:	90                   	nop
8010204e:	90                   	nop
8010204f:	90                   	nop

80102050 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102059:	68 80 a5 10 80       	push   $0x8010a580
8010205e:	e8 5d 23 00 00       	call   801043c0 <acquire>

  if((b = idequeue) == 0){
80102063:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	85 db                	test   %ebx,%ebx
8010206e:	74 34                	je     801020a4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102070:	8b 43 58             	mov    0x58(%ebx),%eax
80102073:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102078:	8b 33                	mov    (%ebx),%esi
8010207a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102080:	74 3e                	je     801020c0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102082:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102085:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102088:	83 ce 02             	or     $0x2,%esi
8010208b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010208d:	53                   	push   %ebx
8010208e:	e8 6d 1f 00 00       	call   80104000 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102093:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 c0                	test   %eax,%eax
8010209d:	74 05                	je     801020a4 <ideintr+0x54>
    idestart(idequeue);
8010209f:	e8 5c fe ff ff       	call   80101f00 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	68 80 a5 10 80       	push   $0x8010a580
801020ac:	e8 2f 24 00 00       	call   801044e0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b4:	5b                   	pop    %ebx
801020b5:	5e                   	pop    %esi
801020b6:	5f                   	pop    %edi
801020b7:	5d                   	pop    %ebp
801020b8:	c3                   	ret    
801020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c5:	8d 76 00             	lea    0x0(%esi),%esi
801020c8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c9:	89 c1                	mov    %eax,%ecx
801020cb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ce:	80 f9 40             	cmp    $0x40,%cl
801020d1:	75 f5                	jne    801020c8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020d3:	a8 21                	test   $0x21,%al
801020d5:	75 ab                	jne    80102082 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020d7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020da:	b9 80 00 00 00       	mov    $0x80,%ecx
801020df:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020e4:	fc                   	cld    
801020e5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e7:	8b 33                	mov    (%ebx),%esi
801020e9:	eb 97                	jmp    80102082 <ideintr+0x32>
801020eb:	90                   	nop
801020ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	53                   	push   %ebx
801020f4:	83 ec 10             	sub    $0x10,%esp
801020f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801020fd:	50                   	push   %eax
801020fe:	e8 8d 21 00 00       	call   80104290 <holdingsleep>
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	85 c0                	test   %eax,%eax
80102108:	0f 84 ad 00 00 00    	je     801021bb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	0f 84 b9 00 00 00    	je     801021d5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010211c:	8b 53 04             	mov    0x4(%ebx),%edx
8010211f:	85 d2                	test   %edx,%edx
80102121:	74 0d                	je     80102130 <iderw+0x40>
80102123:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102128:	85 c0                	test   %eax,%eax
8010212a:	0f 84 98 00 00 00    	je     801021c8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	68 80 a5 10 80       	push   $0x8010a580
80102138:	e8 83 22 00 00       	call   801043c0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102143:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102146:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010214d:	85 d2                	test   %edx,%edx
8010214f:	75 09                	jne    8010215a <iderw+0x6a>
80102151:	eb 58                	jmp    801021ab <iderw+0xbb>
80102153:	90                   	nop
80102154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102158:	89 c2                	mov    %eax,%edx
8010215a:	8b 42 58             	mov    0x58(%edx),%eax
8010215d:	85 c0                	test   %eax,%eax
8010215f:	75 f7                	jne    80102158 <iderw+0x68>
80102161:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102164:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102166:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010216c:	74 44                	je     801021b2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	74 23                	je     8010219b <iderw+0xab>
80102178:	90                   	nop
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102180:	83 ec 08             	sub    $0x8,%esp
80102183:	68 80 a5 10 80       	push   $0x8010a580
80102188:	53                   	push   %ebx
80102189:	e8 c2 1c 00 00       	call   80103e50 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 c4 10             	add    $0x10,%esp
80102193:	83 e0 06             	and    $0x6,%eax
80102196:	83 f8 02             	cmp    $0x2,%eax
80102199:	75 e5                	jne    80102180 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010219b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801021a6:	e9 35 23 00 00       	jmp    801044e0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ab:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021b0:	eb b2                	jmp    80102164 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021b2:	89 d8                	mov    %ebx,%eax
801021b4:	e8 47 fd ff ff       	call   80101f00 <idestart>
801021b9:	eb b3                	jmp    8010216e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021bb:	83 ec 0c             	sub    $0xc,%esp
801021be:	68 6a 73 10 80       	push   $0x8010736a
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 95 73 10 80       	push   $0x80107395
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 80 73 10 80       	push   $0x80107380
801021dd:	e8 8e e1 ff ff       	call   80100370 <panic>
801021e2:	66 90                	xchg   %ax,%ax
801021e4:	66 90                	xchg   %ax,%ax
801021e6:	66 90                	xchg   %ax,%ax
801021e8:	66 90                	xchg   %ax,%ax
801021ea:	66 90                	xchg   %ax,%ax
801021ec:	66 90                	xchg   %ax,%ax
801021ee:	66 90                	xchg   %ax,%ax

801021f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021f1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801021f8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021fb:	89 e5                	mov    %esp,%ebp
801021fd:	56                   	push   %esi
801021fe:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102206:	00 00 00 
  return ioapic->data;
80102209:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010220f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102212:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102218:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010221e:	0f b6 15 60 a7 14 80 	movzbl 0x8014a760,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102225:	89 f0                	mov    %esi,%eax
80102227:	c1 e8 10             	shr    $0x10,%eax
8010222a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010222d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102230:	c1 e8 18             	shr    $0x18,%eax
80102233:	39 d0                	cmp    %edx,%eax
80102235:	74 16                	je     8010224d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 b4 73 10 80       	push   $0x801073b4
8010223f:	e8 1c e4 ff ff       	call   80100660 <cprintf>
80102244:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010224a:	83 c4 10             	add    $0x10,%esp
8010224d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102250:	ba 10 00 00 00       	mov    $0x10,%edx
80102255:	b8 20 00 00 00       	mov    $0x20,%eax
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102260:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102262:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102268:	89 c3                	mov    %eax,%ebx
8010226a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102270:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102273:	89 59 10             	mov    %ebx,0x10(%ecx)
80102276:	8d 5a 01             	lea    0x1(%edx),%ebx
80102279:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102280:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102286:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010228d:	75 d1                	jne    80102260 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010228f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102292:	5b                   	pop    %ebx
80102293:	5e                   	pop    %esi
80102294:	5d                   	pop    %ebp
80102295:	c3                   	ret    
80102296:	8d 76 00             	lea    0x0(%esi),%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022a0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022a7:	89 e5                	mov    %esp,%ebp
801022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ac:	8d 50 20             	lea    0x20(%eax),%edx
801022af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022b5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022be:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022c6:	a1 34 26 11 80       	mov    0x80112634,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022cb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022ce:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022d1:	5d                   	pop    %ebp
801022d2:	c3                   	ret    
801022d3:	66 90                	xchg   %ax,%ax
801022d5:	66 90                	xchg   %ax,%ax
801022d7:	66 90                	xchg   %ax,%ax
801022d9:	66 90                	xchg   %ax,%ax
801022db:	66 90                	xchg   %ax,%ax
801022dd:	66 90                	xchg   %ax,%ax
801022df:	90                   	nop

801022e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 04             	sub    $0x4,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022f0:	75 70                	jne    80102362 <kfree+0x82>
801022f2:	81 fb a8 d4 14 80    	cmp    $0x8014d4a8,%ebx
801022f8:	72 68                	jb     80102362 <kfree+0x82>
801022fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102300:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102305:	77 5b                	ja     80102362 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102307:	83 ec 04             	sub    $0x4,%esp
8010230a:	68 00 10 00 00       	push   $0x1000
8010230f:	6a 01                	push   $0x1
80102311:	53                   	push   %ebx
80102312:	e8 19 22 00 00       	call   80104530 <memset>

  if(kmem.use_lock)
80102317:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010231d:	83 c4 10             	add    $0x10,%esp
80102320:	85 d2                	test   %edx,%edx
80102322:	75 2c                	jne    80102350 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102324:	a1 78 26 11 80       	mov    0x80112678,%eax
80102329:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010232b:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102330:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102336:	85 c0                	test   %eax,%eax
80102338:	75 06                	jne    80102340 <kfree+0x60>
    release(&kmem.lock);
}
8010233a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233d:	c9                   	leave  
8010233e:	c3                   	ret    
8010233f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102340:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102347:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010234a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010234b:	e9 90 21 00 00       	jmp    801044e0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 40 26 11 80       	push   $0x80112640
80102358:	e8 63 20 00 00       	call   801043c0 <acquire>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb c2                	jmp    80102324 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102362:	83 ec 0c             	sub    $0xc,%esp
80102365:	68 e6 73 10 80       	push   $0x801073e6
8010236a:	e8 01 e0 ff ff       	call   80100370 <panic>
8010236f:	90                   	nop

80102370 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102375:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102378:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010237b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102381:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102387:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010238d:	39 de                	cmp    %ebx,%esi
8010238f:	72 23                	jb     801023b4 <freerange+0x44>
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102398:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010239e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023a7:	50                   	push   %eax
801023a8:	e8 33 ff ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	39 f3                	cmp    %esi,%ebx
801023b2:	76 e4                	jbe    80102398 <freerange+0x28>
    kfree(p);
}
801023b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023b7:	5b                   	pop    %ebx
801023b8:	5e                   	pop    %esi
801023b9:	5d                   	pop    %ebp
801023ba:	c3                   	ret    
801023bb:	90                   	nop
801023bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023c0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023c8:	83 ec 08             	sub    $0x8,%esp
801023cb:	68 ec 73 10 80       	push   $0x801073ec
801023d0:	68 40 26 11 80       	push   $0x80112640
801023d5:	e8 e6 1e 00 00       	call   801042c0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023e0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801023e7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023fc:	39 de                	cmp    %ebx,%esi
801023fe:	72 1c                	jb     8010241c <kinit1+0x5c>
    kfree(p);
80102400:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102406:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102409:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010240f:	50                   	push   %eax
80102410:	e8 cb fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102415:	83 c4 10             	add    $0x10,%esp
80102418:	39 de                	cmp    %ebx,%esi
8010241a:	73 e4                	jae    80102400 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010241c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010241f:	5b                   	pop    %ebx
80102420:	5e                   	pop    %esi
80102421:	5d                   	pop    %ebp
80102422:	c3                   	ret    
80102423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	56                   	push   %esi
80102434:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102438:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102441:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102447:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244d:	39 de                	cmp    %ebx,%esi
8010244f:	72 23                	jb     80102474 <kinit2+0x44>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102458:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010245e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102467:	50                   	push   %eax
80102468:	e8 73 fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 e4                	jae    80102458 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102474:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010247b:	00 00 00 
}
8010247e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102481:	5b                   	pop    %ebx
80102482:	5e                   	pop    %esi
80102483:	5d                   	pop    %ebp
80102484:	c3                   	ret    
80102485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102497:	a1 74 26 11 80       	mov    0x80112674,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	75 30                	jne    801024d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024a0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024a6:	85 db                	test   %ebx,%ebx
801024a8:	74 1c                	je     801024c6 <kalloc+0x36>
    kmem.freelist = r->next;
801024aa:	8b 13                	mov    (%ebx),%edx
801024ac:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024b2:	85 c0                	test   %eax,%eax
801024b4:	74 10                	je     801024c6 <kalloc+0x36>
    release(&kmem.lock);
801024b6:	83 ec 0c             	sub    $0xc,%esp
801024b9:	68 40 26 11 80       	push   $0x80112640
801024be:	e8 1d 20 00 00       	call   801044e0 <release>
801024c3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024c6:	89 d8                	mov    %ebx,%eax
801024c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024cb:	c9                   	leave  
801024cc:	c3                   	ret    
801024cd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 40 26 11 80       	push   $0x80112640
801024d8:	e8 e3 1e 00 00       	call   801043c0 <acquire>
  r = kmem.freelist;
801024dd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024e3:	83 c4 10             	add    $0x10,%esp
801024e6:	a1 74 26 11 80       	mov    0x80112674,%eax
801024eb:	85 db                	test   %ebx,%ebx
801024ed:	75 bb                	jne    801024aa <kalloc+0x1a>
801024ef:	eb c1                	jmp    801024b2 <kalloc+0x22>
801024f1:	eb 0d                	jmp    80102500 <addRefCount>
801024f3:	90                   	nop
801024f4:	90                   	nop
801024f5:	90                   	nop
801024f6:	90                   	nop
801024f7:	90                   	nop
801024f8:	90                   	nop
801024f9:	90                   	nop
801024fa:	90                   	nop
801024fb:	90                   	nop
801024fc:	90                   	nop
801024fd:	90                   	nop
801024fe:	90                   	nop
801024ff:	90                   	nop

80102500 <addRefCount>:
  return (char*)r;
}

void
addRefCount(uint value)
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	53                   	push   %ebx
80102504:	83 ec 04             	sub    $0x4,%esp
80102507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010250a:	81 fb a8 d4 14 00    	cmp    $0x14d4a8,%ebx
80102510:	72 33                	jb     80102545 <addRefCount+0x45>
80102512:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102518:	77 2b                	ja     80102545 <addRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
8010251a:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])++;
8010251d:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
80102520:	68 40 26 11 80       	push   $0x80112640
80102525:	e8 96 1e 00 00       	call   801043c0 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])++;
8010252a:	83 04 9d 7c 26 11 80 	addl   $0x1,-0x7feed984(,%ebx,4)
80102531:	01 
  release(&kmem.lock);   
80102532:	83 c4 10             	add    $0x10,%esp
80102535:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)

}
8010253c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010253f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])++;
  release(&kmem.lock);   
80102540:	e9 9b 1f 00 00       	jmp    801044e0 <release>
void
addRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102545:	83 ec 0c             	sub    $0xc,%esp
80102548:	68 f1 73 10 80       	push   $0x801073f1
8010254d:	e8 1e de ff ff       	call   80100370 <panic>
80102552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102560 <minusRefCount>:

}

void
minusRefCount(uint value)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	53                   	push   %ebx
80102564:	83 ec 04             	sub    $0x4,%esp
80102567:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010256a:	81 fb a8 d4 14 00    	cmp    $0x14d4a8,%ebx
80102570:	72 33                	jb     801025a5 <minusRefCount+0x45>
80102572:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102578:	77 2b                	ja     801025a5 <minusRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
8010257a:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010257d:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
80102580:	68 40 26 11 80       	push   $0x80112640
80102585:	e8 36 1e 00 00       	call   801043c0 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010258a:	83 2c 9d 7c 26 11 80 	subl   $0x1,-0x7feed984(,%ebx,4)
80102591:	01 
  release(&kmem.lock);   
80102592:	83 c4 10             	add    $0x10,%esp
80102595:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)

}
8010259c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])--;
  release(&kmem.lock);   
801025a0:	e9 3b 1f 00 00       	jmp    801044e0 <release>
void
minusRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
801025a5:	83 ec 0c             	sub    $0xc,%esp
801025a8:	68 f1 73 10 80       	push   $0x801073f1
801025ad:	e8 be dd ff ff       	call   80100370 <panic>
801025b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <getRefCount>:

}

uint
getRefCount(uint value)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	53                   	push   %ebx
801025c4:	83 ec 04             	sub    $0x4,%esp
801025c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
801025ca:	81 fb a8 d4 14 00    	cmp    $0x14d4a8,%ebx
801025d0:	72 32                	jb     80102604 <getRefCount+0x44>
801025d2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
801025d8:	77 2a                	ja     80102604 <getRefCount+0x44>
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
801025da:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pageRefCount[value>>PGSHIFT];  
801025dd:	c1 eb 0c             	shr    $0xc,%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
801025e0:	68 40 26 11 80       	push   $0x80112640
801025e5:	e8 d6 1d 00 00       	call   801043c0 <acquire>
  count = kmem.pageRefCount[value>>PGSHIFT];  
801025ea:	8b 1c 9d 7c 26 11 80 	mov    -0x7feed984(,%ebx,4),%ebx
  release(&kmem.lock);
801025f1:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025f8:	e8 e3 1e 00 00       	call   801044e0 <release>
     
  return count;
}
801025fd:	89 d8                	mov    %ebx,%eax
801025ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102602:	c9                   	leave  
80102603:	c3                   	ret    
uint
getRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102604:	83 ec 0c             	sub    $0xc,%esp
80102607:	68 f1 73 10 80       	push   $0x801073f1
8010260c:	e8 5f dd ff ff       	call   80100370 <panic>
80102611:	66 90                	xchg   %ax,%ax
80102613:	66 90                	xchg   %ax,%ax
80102615:	66 90                	xchg   %ax,%ax
80102617:	66 90                	xchg   %ax,%ax
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102620:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102621:	ba 64 00 00 00       	mov    $0x64,%edx
80102626:	89 e5                	mov    %esp,%ebp
80102628:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102629:	a8 01                	test   $0x1,%al
8010262b:	0f 84 af 00 00 00    	je     801026e0 <kbdgetc+0xc0>
80102631:	ba 60 00 00 00       	mov    $0x60,%edx
80102636:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102637:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010263a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102640:	74 7e                	je     801026c0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102642:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102644:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010264a:	79 24                	jns    80102670 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010264c:	f6 c1 40             	test   $0x40,%cl
8010264f:	75 05                	jne    80102656 <kbdgetc+0x36>
80102651:	89 c2                	mov    %eax,%edx
80102653:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102656:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
8010265d:	83 c8 40             	or     $0x40,%eax
80102660:	0f b6 c0             	movzbl %al,%eax
80102663:	f7 d0                	not    %eax
80102665:	21 c8                	and    %ecx,%eax
80102667:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010266c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010266e:	5d                   	pop    %ebp
8010266f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102670:	f6 c1 40             	test   $0x40,%cl
80102673:	74 09                	je     8010267e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102675:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102678:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010267b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010267e:	0f b6 82 40 75 10 80 	movzbl -0x7fef8ac0(%edx),%eax
80102685:	09 c1                	or     %eax,%ecx
80102687:	0f b6 82 40 74 10 80 	movzbl -0x7fef8bc0(%edx),%eax
8010268e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102690:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102692:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102698:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010269b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010269e:	8b 04 85 20 74 10 80 	mov    -0x7fef8be0(,%eax,4),%eax
801026a5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801026a9:	74 c3                	je     8010266e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801026ab:	8d 50 9f             	lea    -0x61(%eax),%edx
801026ae:	83 fa 19             	cmp    $0x19,%edx
801026b1:	77 1d                	ja     801026d0 <kbdgetc+0xb0>
      c += 'A' - 'a';
801026b3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026b6:	5d                   	pop    %ebp
801026b7:	c3                   	ret    
801026b8:	90                   	nop
801026b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801026c0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801026c2:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026c9:	5d                   	pop    %ebp
801026ca:	c3                   	ret    
801026cb:	90                   	nop
801026cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801026d0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026d3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801026d6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801026d7:	83 f9 19             	cmp    $0x19,%ecx
801026da:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801026dd:	c3                   	ret    
801026de:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801026e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026e5:	5d                   	pop    %ebp
801026e6:	c3                   	ret    
801026e7:	89 f6                	mov    %esi,%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <kbdintr>:

void
kbdintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026f6:	68 20 26 10 80       	push   $0x80102620
801026fb:	e8 f0 e0 ff ff       	call   801007f0 <consoleintr>
}
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	c9                   	leave  
80102704:	c3                   	ret    
80102705:	66 90                	xchg   %ax,%ax
80102707:	66 90                	xchg   %ax,%ax
80102709:	66 90                	xchg   %ax,%ax
8010270b:	66 90                	xchg   %ax,%ax
8010270d:	66 90                	xchg   %ax,%ax
8010270f:	90                   	nop

80102710 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102710:	a1 7c a6 14 80       	mov    0x8014a67c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	0f 84 c8 00 00 00    	je     801027e8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102720:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102727:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010272d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102734:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102737:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010273a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102741:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102744:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102747:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010274e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102751:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102754:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010275b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102761:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102768:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010276b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010276e:	8b 50 30             	mov    0x30(%eax),%edx
80102771:	c1 ea 10             	shr    $0x10,%edx
80102774:	80 fa 03             	cmp    $0x3,%dl
80102777:	77 77                	ja     801027f0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102779:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102780:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102783:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102786:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010278d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102790:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102793:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010279a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010279d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027aa:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027c4:	8b 50 20             	mov    0x20(%eax),%edx
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027d6:	80 e6 10             	and    $0x10,%dh
801027d9:	75 f5                	jne    801027d0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027e8:	5d                   	pop    %ebp
801027e9:	c3                   	ret    
801027ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fa:	8b 50 20             	mov    0x20(%eax),%edx
801027fd:	e9 77 ff ff ff       	jmp    80102779 <lapicinit+0x69>
80102802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102810:	a1 7c a6 14 80       	mov    0x8014a67c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102815:	55                   	push   %ebp
80102816:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102818:	85 c0                	test   %eax,%eax
8010281a:	74 0c                	je     80102828 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010281c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010281f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102820:	c1 e8 18             	shr    $0x18,%eax
}
80102823:	c3                   	ret    
80102824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102828:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010282a:	5d                   	pop    %ebp
8010282b:	c3                   	ret    
8010282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102830 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102830:	a1 7c a6 14 80       	mov    0x8014a67c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0d                	je     80102849 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010283c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102843:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102846:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102849:	5d                   	pop    %ebp
8010284a:	c3                   	ret    
8010284b:	90                   	nop
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
}
80102853:	5d                   	pop    %ebp
80102854:	c3                   	ret    
80102855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102860 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102860:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102861:	ba 70 00 00 00       	mov    $0x70,%edx
80102866:	b8 0f 00 00 00       	mov    $0xf,%eax
8010286b:	89 e5                	mov    %esp,%ebp
8010286d:	53                   	push   %ebx
8010286e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102871:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102874:	ee                   	out    %al,(%dx)
80102875:	ba 71 00 00 00       	mov    $0x71,%edx
8010287a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010287f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102880:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102882:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102885:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010288b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010288d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102890:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102893:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102895:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102898:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010289e:	a1 7c a6 14 80       	mov    0x8014a67c,%eax
801028a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028b3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028c0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028cc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028de:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028ea:	5b                   	pop    %ebx
801028eb:	5d                   	pop    %ebp
801028ec:	c3                   	ret    
801028ed:	8d 76 00             	lea    0x0(%esi),%esi

801028f0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028f0:	55                   	push   %ebp
801028f1:	ba 70 00 00 00       	mov    $0x70,%edx
801028f6:	b8 0b 00 00 00       	mov    $0xb,%eax
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	57                   	push   %edi
801028fe:	56                   	push   %esi
801028ff:	53                   	push   %ebx
80102900:	83 ec 4c             	sub    $0x4c,%esp
80102903:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102904:	ba 71 00 00 00       	mov    $0x71,%edx
80102909:	ec                   	in     (%dx),%al
8010290a:	83 e0 04             	and    $0x4,%eax
8010290d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102910:	31 db                	xor    %ebx,%ebx
80102912:	88 45 b7             	mov    %al,-0x49(%ebp)
80102915:	bf 70 00 00 00       	mov    $0x70,%edi
8010291a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102920:	89 d8                	mov    %ebx,%eax
80102922:	89 fa                	mov    %edi,%edx
80102924:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102925:	b9 71 00 00 00       	mov    $0x71,%ecx
8010292a:	89 ca                	mov    %ecx,%edx
8010292c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010292d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102930:	89 fa                	mov    %edi,%edx
80102932:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102935:	b8 02 00 00 00       	mov    $0x2,%eax
8010293a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293b:	89 ca                	mov    %ecx,%edx
8010293d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010293e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102941:	89 fa                	mov    %edi,%edx
80102943:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102946:	b8 04 00 00 00       	mov    $0x4,%eax
8010294b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294c:	89 ca                	mov    %ecx,%edx
8010294e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010294f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102952:	89 fa                	mov    %edi,%edx
80102954:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102957:	b8 07 00 00 00       	mov    $0x7,%eax
8010295c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295d:	89 ca                	mov    %ecx,%edx
8010295f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102960:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102963:	89 fa                	mov    %edi,%edx
80102965:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102968:	b8 08 00 00 00       	mov    $0x8,%eax
8010296d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296e:	89 ca                	mov    %ecx,%edx
80102970:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102971:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102974:	89 fa                	mov    %edi,%edx
80102976:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102979:	b8 09 00 00 00       	mov    $0x9,%eax
8010297e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297f:	89 ca                	mov    %ecx,%edx
80102981:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102982:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102985:	89 fa                	mov    %edi,%edx
80102987:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010298a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010298f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102990:	89 ca                	mov    %ecx,%edx
80102992:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102993:	84 c0                	test   %al,%al
80102995:	78 89                	js     80102920 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102997:	89 d8                	mov    %ebx,%eax
80102999:	89 fa                	mov    %edi,%edx
8010299b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299c:	89 ca                	mov    %ecx,%edx
8010299e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010299f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a2:	89 fa                	mov    %edi,%edx
801029a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029a7:	b8 02 00 00 00       	mov    $0x2,%eax
801029ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ad:	89 ca                	mov    %ecx,%edx
801029af:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801029b0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b3:	89 fa                	mov    %edi,%edx
801029b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029b8:	b8 04 00 00 00       	mov    $0x4,%eax
801029bd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029be:	89 ca                	mov    %ecx,%edx
801029c0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801029c1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c4:	89 fa                	mov    %edi,%edx
801029c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029c9:	b8 07 00 00 00       	mov    $0x7,%eax
801029ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cf:	89 ca                	mov    %ecx,%edx
801029d1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801029d2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d5:	89 fa                	mov    %edi,%edx
801029d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029da:	b8 08 00 00 00       	mov    $0x8,%eax
801029df:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e0:	89 ca                	mov    %ecx,%edx
801029e2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801029e3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e6:	89 fa                	mov    %edi,%edx
801029e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029eb:	b8 09 00 00 00       	mov    $0x9,%eax
801029f0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f1:	89 ca                	mov    %ecx,%edx
801029f3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801029f4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029f7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801029fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029fd:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a00:	6a 18                	push   $0x18
80102a02:	56                   	push   %esi
80102a03:	50                   	push   %eax
80102a04:	e8 77 1b 00 00       	call   80104580 <memcmp>
80102a09:	83 c4 10             	add    $0x10,%esp
80102a0c:	85 c0                	test   %eax,%eax
80102a0e:	0f 85 0c ff ff ff    	jne    80102920 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102a14:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102a18:	75 78                	jne    80102a92 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a1a:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a1d:	89 c2                	mov    %eax,%edx
80102a1f:	83 e0 0f             	and    $0xf,%eax
80102a22:	c1 ea 04             	shr    $0x4,%edx
80102a25:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a28:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a2b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a2e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a31:	89 c2                	mov    %eax,%edx
80102a33:	83 e0 0f             	and    $0xf,%eax
80102a36:	c1 ea 04             	shr    $0x4,%edx
80102a39:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a3c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a42:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a45:	89 c2                	mov    %eax,%edx
80102a47:	83 e0 0f             	and    $0xf,%eax
80102a4a:	c1 ea 04             	shr    $0x4,%edx
80102a4d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a50:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a53:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a56:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a59:	89 c2                	mov    %eax,%edx
80102a5b:	83 e0 0f             	and    $0xf,%eax
80102a5e:	c1 ea 04             	shr    $0x4,%edx
80102a61:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a64:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a67:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a6a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a6d:	89 c2                	mov    %eax,%edx
80102a6f:	83 e0 0f             	and    $0xf,%eax
80102a72:	c1 ea 04             	shr    $0x4,%edx
80102a75:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a78:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a7b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a7e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a81:	89 c2                	mov    %eax,%edx
80102a83:	83 e0 0f             	and    $0xf,%eax
80102a86:	c1 ea 04             	shr    $0x4,%edx
80102a89:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a8c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a92:	8b 75 08             	mov    0x8(%ebp),%esi
80102a95:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a98:	89 06                	mov    %eax,(%esi)
80102a9a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a9d:	89 46 04             	mov    %eax,0x4(%esi)
80102aa0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102aa3:	89 46 08             	mov    %eax,0x8(%esi)
80102aa6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102aa9:	89 46 0c             	mov    %eax,0xc(%esi)
80102aac:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102aaf:	89 46 10             	mov    %eax,0x10(%esi)
80102ab2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ab5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ab8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102abf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ac2:	5b                   	pop    %ebx
80102ac3:	5e                   	pop    %esi
80102ac4:	5f                   	pop    %edi
80102ac5:	5d                   	pop    %ebp
80102ac6:	c3                   	ret    
80102ac7:	66 90                	xchg   %ax,%ax
80102ac9:	66 90                	xchg   %ax,%ax
80102acb:	66 90                	xchg   %ax,%ax
80102acd:	66 90                	xchg   %ax,%ax
80102acf:	90                   	nop

80102ad0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad0:	8b 0d c8 a6 14 80    	mov    0x8014a6c8,%ecx
80102ad6:	85 c9                	test   %ecx,%ecx
80102ad8:	0f 8e 85 00 00 00    	jle    80102b63 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	57                   	push   %edi
80102ae2:	56                   	push   %esi
80102ae3:	53                   	push   %ebx
80102ae4:	31 db                	xor    %ebx,%ebx
80102ae6:	83 ec 0c             	sub    $0xc,%esp
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102af0:	a1 b4 a6 14 80       	mov    0x8014a6b4,%eax
80102af5:	83 ec 08             	sub    $0x8,%esp
80102af8:	01 d8                	add    %ebx,%eax
80102afa:	83 c0 01             	add    $0x1,%eax
80102afd:	50                   	push   %eax
80102afe:	ff 35 c4 a6 14 80    	pushl  0x8014a6c4
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	58                   	pop    %eax
80102b0c:	5a                   	pop    %edx
80102b0d:	ff 34 9d cc a6 14 80 	pushl  -0x7feb5934(,%ebx,4)
80102b14:	ff 35 c4 a6 14 80    	pushl  0x8014a6c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1d:	e8 ae d5 ff ff       	call   801000d0 <bread>
80102b22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b27:	83 c4 0c             	add    $0xc,%esp
80102b2a:	68 00 02 00 00       	push   $0x200
80102b2f:	50                   	push   %eax
80102b30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b33:	50                   	push   %eax
80102b34:	e8 a7 1a 00 00       	call   801045e0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b39:	89 34 24             	mov    %esi,(%esp)
80102b3c:	e8 5f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b41:	89 3c 24             	mov    %edi,(%esp)
80102b44:	e8 97 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b51:	83 c4 10             	add    $0x10,%esp
80102b54:	39 1d c8 a6 14 80    	cmp    %ebx,0x8014a6c8
80102b5a:	7f 94                	jg     80102af0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b5f:	5b                   	pop    %ebx
80102b60:	5e                   	pop    %esi
80102b61:	5f                   	pop    %edi
80102b62:	5d                   	pop    %ebp
80102b63:	f3 c3                	repz ret 
80102b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	53                   	push   %ebx
80102b74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b77:	ff 35 b4 a6 14 80    	pushl  0x8014a6b4
80102b7d:	ff 35 c4 a6 14 80    	pushl  0x8014a6c4
80102b83:	e8 48 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b88:	8b 0d c8 a6 14 80    	mov    0x8014a6c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b8e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b91:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b93:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b95:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b98:	7e 1f                	jle    80102bb9 <write_head+0x49>
80102b9a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102ba1:	31 d2                	xor    %edx,%edx
80102ba3:	90                   	nop
80102ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102ba8:	8b 8a cc a6 14 80    	mov    -0x7feb5934(%edx),%ecx
80102bae:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102bb2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102bb5:	39 c2                	cmp    %eax,%edx
80102bb7:	75 ef                	jne    80102ba8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102bb9:	83 ec 0c             	sub    $0xc,%esp
80102bbc:	53                   	push   %ebx
80102bbd:	e8 de d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bc2:	89 1c 24             	mov    %ebx,(%esp)
80102bc5:	e8 16 d6 ff ff       	call   801001e0 <brelse>
}
80102bca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bcd:	c9                   	leave  
80102bce:	c3                   	ret    
80102bcf:	90                   	nop

80102bd0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	53                   	push   %ebx
80102bd4:	83 ec 2c             	sub    $0x2c,%esp
80102bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102bda:	68 40 76 10 80       	push   $0x80107640
80102bdf:	68 80 a6 14 80       	push   $0x8014a680
80102be4:	e8 d7 16 00 00       	call   801042c0 <initlock>
  readsb(dev, &sb);
80102be9:	58                   	pop    %eax
80102bea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bed:	5a                   	pop    %edx
80102bee:	50                   	push   %eax
80102bef:	53                   	push   %ebx
80102bf0:	e8 bb e7 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bf5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bf8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bfb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102bfc:	89 1d c4 a6 14 80    	mov    %ebx,0x8014a6c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c02:	89 15 b8 a6 14 80    	mov    %edx,0x8014a6b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c08:	a3 b4 a6 14 80       	mov    %eax,0x8014a6b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c0d:	5a                   	pop    %edx
80102c0e:	50                   	push   %eax
80102c0f:	53                   	push   %ebx
80102c10:	e8 bb d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c15:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c18:	83 c4 10             	add    $0x10,%esp
80102c1b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c1d:	89 0d c8 a6 14 80    	mov    %ecx,0x8014a6c8
  for (i = 0; i < log.lh.n; i++) {
80102c23:	7e 1c                	jle    80102c41 <initlog+0x71>
80102c25:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102c2c:	31 d2                	xor    %edx,%edx
80102c2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c34:	83 c2 04             	add    $0x4,%edx
80102c37:	89 8a c8 a6 14 80    	mov    %ecx,-0x7feb5938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c3d:	39 da                	cmp    %ebx,%edx
80102c3f:	75 ef                	jne    80102c30 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c41:	83 ec 0c             	sub    $0xc,%esp
80102c44:	50                   	push   %eax
80102c45:	e8 96 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c4a:	e8 81 fe ff ff       	call   80102ad0 <install_trans>
  log.lh.n = 0;
80102c4f:	c7 05 c8 a6 14 80 00 	movl   $0x0,0x8014a6c8
80102c56:	00 00 00 
  write_head(); // clear the log
80102c59:	e8 12 ff ff ff       	call   80102b70 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c61:	c9                   	leave  
80102c62:	c3                   	ret    
80102c63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c76:	68 80 a6 14 80       	push   $0x8014a680
80102c7b:	e8 40 17 00 00       	call   801043c0 <acquire>
80102c80:	83 c4 10             	add    $0x10,%esp
80102c83:	eb 18                	jmp    80102c9d <begin_op+0x2d>
80102c85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	83 ec 08             	sub    $0x8,%esp
80102c8b:	68 80 a6 14 80       	push   $0x8014a680
80102c90:	68 80 a6 14 80       	push   $0x8014a680
80102c95:	e8 b6 11 00 00       	call   80103e50 <sleep>
80102c9a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c9d:	a1 c0 a6 14 80       	mov    0x8014a6c0,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	75 e2                	jne    80102c88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca6:	a1 bc a6 14 80       	mov    0x8014a6bc,%eax
80102cab:	8b 15 c8 a6 14 80    	mov    0x8014a6c8,%edx
80102cb1:	83 c0 01             	add    $0x1,%eax
80102cb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cba:	83 fa 1e             	cmp    $0x1e,%edx
80102cbd:	7f c9                	jg     80102c88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cbf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102cc2:	a3 bc a6 14 80       	mov    %eax,0x8014a6bc
      release(&log.lock);
80102cc7:	68 80 a6 14 80       	push   $0x8014a680
80102ccc:	e8 0f 18 00 00       	call   801044e0 <release>
      break;
    }
  }
}
80102cd1:	83 c4 10             	add    $0x10,%esp
80102cd4:	c9                   	leave  
80102cd5:	c3                   	ret    
80102cd6:	8d 76 00             	lea    0x0(%esi),%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ce0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	57                   	push   %edi
80102ce4:	56                   	push   %esi
80102ce5:	53                   	push   %ebx
80102ce6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ce9:	68 80 a6 14 80       	push   $0x8014a680
80102cee:	e8 cd 16 00 00       	call   801043c0 <acquire>
  log.outstanding -= 1;
80102cf3:	a1 bc a6 14 80       	mov    0x8014a6bc,%eax
  if(log.committing)
80102cf8:	8b 1d c0 a6 14 80    	mov    0x8014a6c0,%ebx
80102cfe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d01:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102d04:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d06:	a3 bc a6 14 80       	mov    %eax,0x8014a6bc
  if(log.committing)
80102d0b:	0f 85 23 01 00 00    	jne    80102e34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d11:	85 c0                	test   %eax,%eax
80102d13:	0f 85 f7 00 00 00    	jne    80102e10 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d19:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102d1c:	c7 05 c0 a6 14 80 01 	movl   $0x1,0x8014a6c0
80102d23:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d26:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d28:	68 80 a6 14 80       	push   $0x8014a680
80102d2d:	e8 ae 17 00 00       	call   801044e0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d32:	8b 0d c8 a6 14 80    	mov    0x8014a6c8,%ecx
80102d38:	83 c4 10             	add    $0x10,%esp
80102d3b:	85 c9                	test   %ecx,%ecx
80102d3d:	0f 8e 8a 00 00 00    	jle    80102dcd <end_op+0xed>
80102d43:	90                   	nop
80102d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d48:	a1 b4 a6 14 80       	mov    0x8014a6b4,%eax
80102d4d:	83 ec 08             	sub    $0x8,%esp
80102d50:	01 d8                	add    %ebx,%eax
80102d52:	83 c0 01             	add    $0x1,%eax
80102d55:	50                   	push   %eax
80102d56:	ff 35 c4 a6 14 80    	pushl  0x8014a6c4
80102d5c:	e8 6f d3 ff ff       	call   801000d0 <bread>
80102d61:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d63:	58                   	pop    %eax
80102d64:	5a                   	pop    %edx
80102d65:	ff 34 9d cc a6 14 80 	pushl  -0x7feb5934(,%ebx,4)
80102d6c:	ff 35 c4 a6 14 80    	pushl  0x8014a6c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d72:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d75:	e8 56 d3 ff ff       	call   801000d0 <bread>
80102d7a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d7c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d7f:	83 c4 0c             	add    $0xc,%esp
80102d82:	68 00 02 00 00       	push   $0x200
80102d87:	50                   	push   %eax
80102d88:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d8b:	50                   	push   %eax
80102d8c:	e8 4f 18 00 00       	call   801045e0 <memmove>
    bwrite(to);  // write the log
80102d91:	89 34 24             	mov    %esi,(%esp)
80102d94:	e8 07 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d99:	89 3c 24             	mov    %edi,(%esp)
80102d9c:	e8 3f d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102da1:	89 34 24             	mov    %esi,(%esp)
80102da4:	e8 37 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102da9:	83 c4 10             	add    $0x10,%esp
80102dac:	3b 1d c8 a6 14 80    	cmp    0x8014a6c8,%ebx
80102db2:	7c 94                	jl     80102d48 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102db4:	e8 b7 fd ff ff       	call   80102b70 <write_head>
    install_trans(); // Now install writes to home locations
80102db9:	e8 12 fd ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dbe:	c7 05 c8 a6 14 80 00 	movl   $0x0,0x8014a6c8
80102dc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dc8:	e8 a3 fd ff ff       	call   80102b70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102dcd:	83 ec 0c             	sub    $0xc,%esp
80102dd0:	68 80 a6 14 80       	push   $0x8014a680
80102dd5:	e8 e6 15 00 00       	call   801043c0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102dda:	c7 04 24 80 a6 14 80 	movl   $0x8014a680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102de1:	c7 05 c0 a6 14 80 00 	movl   $0x0,0x8014a6c0
80102de8:	00 00 00 
    wakeup(&log);
80102deb:	e8 10 12 00 00       	call   80104000 <wakeup>
    release(&log.lock);
80102df0:	c7 04 24 80 a6 14 80 	movl   $0x8014a680,(%esp)
80102df7:	e8 e4 16 00 00       	call   801044e0 <release>
80102dfc:	83 c4 10             	add    $0x10,%esp
  }
}
80102dff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e02:	5b                   	pop    %ebx
80102e03:	5e                   	pop    %esi
80102e04:	5f                   	pop    %edi
80102e05:	5d                   	pop    %ebp
80102e06:	c3                   	ret    
80102e07:	89 f6                	mov    %esi,%esi
80102e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102e10:	83 ec 0c             	sub    $0xc,%esp
80102e13:	68 80 a6 14 80       	push   $0x8014a680
80102e18:	e8 e3 11 00 00       	call   80104000 <wakeup>
  }
  release(&log.lock);
80102e1d:	c7 04 24 80 a6 14 80 	movl   $0x8014a680,(%esp)
80102e24:	e8 b7 16 00 00       	call   801044e0 <release>
80102e29:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102e2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e2f:	5b                   	pop    %ebx
80102e30:	5e                   	pop    %esi
80102e31:	5f                   	pop    %edi
80102e32:	5d                   	pop    %ebp
80102e33:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102e34:	83 ec 0c             	sub    $0xc,%esp
80102e37:	68 44 76 10 80       	push   $0x80107644
80102e3c:	e8 2f d5 ff ff       	call   80100370 <panic>
80102e41:	eb 0d                	jmp    80102e50 <log_write>
80102e43:	90                   	nop
80102e44:	90                   	nop
80102e45:	90                   	nop
80102e46:	90                   	nop
80102e47:	90                   	nop
80102e48:	90                   	nop
80102e49:	90                   	nop
80102e4a:	90                   	nop
80102e4b:	90                   	nop
80102e4c:	90                   	nop
80102e4d:	90                   	nop
80102e4e:	90                   	nop
80102e4f:	90                   	nop

80102e50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e57:	8b 15 c8 a6 14 80    	mov    0x8014a6c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e60:	83 fa 1d             	cmp    $0x1d,%edx
80102e63:	0f 8f 97 00 00 00    	jg     80102f00 <log_write+0xb0>
80102e69:	a1 b8 a6 14 80       	mov    0x8014a6b8,%eax
80102e6e:	83 e8 01             	sub    $0x1,%eax
80102e71:	39 c2                	cmp    %eax,%edx
80102e73:	0f 8d 87 00 00 00    	jge    80102f00 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e79:	a1 bc a6 14 80       	mov    0x8014a6bc,%eax
80102e7e:	85 c0                	test   %eax,%eax
80102e80:	0f 8e 87 00 00 00    	jle    80102f0d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	68 80 a6 14 80       	push   $0x8014a680
80102e8e:	e8 2d 15 00 00       	call   801043c0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e93:	8b 15 c8 a6 14 80    	mov    0x8014a6c8,%edx
80102e99:	83 c4 10             	add    $0x10,%esp
80102e9c:	83 fa 00             	cmp    $0x0,%edx
80102e9f:	7e 50                	jle    80102ef1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102ea4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ea6:	3b 0d cc a6 14 80    	cmp    0x8014a6cc,%ecx
80102eac:	75 0b                	jne    80102eb9 <log_write+0x69>
80102eae:	eb 38                	jmp    80102ee8 <log_write+0x98>
80102eb0:	39 0c 85 cc a6 14 80 	cmp    %ecx,-0x7feb5934(,%eax,4)
80102eb7:	74 2f                	je     80102ee8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102eb9:	83 c0 01             	add    $0x1,%eax
80102ebc:	39 d0                	cmp    %edx,%eax
80102ebe:	75 f0                	jne    80102eb0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ec0:	89 0c 95 cc a6 14 80 	mov    %ecx,-0x7feb5934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ec7:	83 c2 01             	add    $0x1,%edx
80102eca:	89 15 c8 a6 14 80    	mov    %edx,0x8014a6c8
  b->flags |= B_DIRTY; // prevent eviction
80102ed0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ed3:	c7 45 08 80 a6 14 80 	movl   $0x8014a680,0x8(%ebp)
}
80102eda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102edd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102ede:	e9 fd 15 00 00       	jmp    801044e0 <release>
80102ee3:	90                   	nop
80102ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ee8:	89 0c 85 cc a6 14 80 	mov    %ecx,-0x7feb5934(,%eax,4)
80102eef:	eb df                	jmp    80102ed0 <log_write+0x80>
80102ef1:	8b 43 08             	mov    0x8(%ebx),%eax
80102ef4:	a3 cc a6 14 80       	mov    %eax,0x8014a6cc
  if (i == log.lh.n)
80102ef9:	75 d5                	jne    80102ed0 <log_write+0x80>
80102efb:	eb ca                	jmp    80102ec7 <log_write+0x77>
80102efd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 53 76 10 80       	push   $0x80107653
80102f08:	e8 63 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102f0d:	83 ec 0c             	sub    $0xc,%esp
80102f10:	68 69 76 10 80       	push   $0x80107669
80102f15:	e8 56 d4 ff ff       	call   80100370 <panic>
80102f1a:	66 90                	xchg   %ax,%ax
80102f1c:	66 90                	xchg   %ax,%ax
80102f1e:	66 90                	xchg   %ax,%ax

80102f20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f27:	e8 54 09 00 00       	call   80103880 <cpuid>
80102f2c:	89 c3                	mov    %eax,%ebx
80102f2e:	e8 4d 09 00 00       	call   80103880 <cpuid>
80102f33:	83 ec 04             	sub    $0x4,%esp
80102f36:	53                   	push   %ebx
80102f37:	50                   	push   %eax
80102f38:	68 84 76 10 80       	push   $0x80107684
80102f3d:	e8 1e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 59 29 00 00       	call   801058a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f47:	e8 b4 08 00 00       	call   80103800 <mycpu>
80102f4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f5a:	e8 01 0c 00 00       	call   80103b60 <scheduler>
80102f5f:	90                   	nop

80102f60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f66:	e8 55 3a 00 00       	call   801069c0 <switchkvm>
  seginit();
80102f6b:	e8 50 39 00 00       	call   801068c0 <seginit>
  lapicinit();
80102f70:	e8 9b f7 ff ff       	call   80102710 <lapicinit>
  mpmain();
80102f75:	e8 a6 ff ff ff       	call   80102f20 <mpmain>
80102f7a:	66 90                	xchg   %ax,%ax
80102f7c:	66 90                	xchg   %ax,%ax
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f84:	83 e4 f0             	and    $0xfffffff0,%esp
80102f87:	ff 71 fc             	pushl  -0x4(%ecx)
80102f8a:	55                   	push   %ebp
80102f8b:	89 e5                	mov    %esp,%ebp
80102f8d:	53                   	push   %ebx
80102f8e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f8f:	bb 80 a7 14 80       	mov    $0x8014a780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f94:	83 ec 08             	sub    $0x8,%esp
80102f97:	68 00 00 40 80       	push   $0x80400000
80102f9c:	68 a8 d4 14 80       	push   $0x8014d4a8
80102fa1:	e8 1a f4 ff ff       	call   801023c0 <kinit1>
  kvmalloc();      // kernel page table
80102fa6:	e8 b5 3e 00 00       	call   80106e60 <kvmalloc>
  mpinit();        // detect other processors
80102fab:	e8 70 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102fb0:	e8 5b f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb5:	e8 06 39 00 00       	call   801068c0 <seginit>
  picinit();       // disable pic
80102fba:	e8 31 03 00 00       	call   801032f0 <picinit>
  ioapicinit();    // another interrupt controller
80102fbf:	e8 2c f2 ff ff       	call   801021f0 <ioapicinit>
  consoleinit();   // console hardware
80102fc4:	e8 d7 d9 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102fc9:	e8 c2 2b 00 00       	call   80105b90 <uartinit>
  pinit();         // process table
80102fce:	e8 0d 08 00 00       	call   801037e0 <pinit>
  tvinit();        // trap vectors
80102fd3:	e8 28 28 00 00       	call   80105800 <tvinit>
  binit();         // buffer cache
80102fd8:	e8 63 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fdd:	e8 6e dd ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102fe2:	e8 e9 ef ff ff       	call   80101fd0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe7:	83 c4 0c             	add    $0xc,%esp
80102fea:	68 8a 00 00 00       	push   $0x8a
80102fef:	68 8c a4 10 80       	push   $0x8010a48c
80102ff4:	68 00 70 00 80       	push   $0x80007000
80102ff9:	e8 e2 15 00 00       	call   801045e0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ffe:	69 05 00 ad 14 80 b0 	imul   $0xb0,0x8014ad00,%eax
80103005:	00 00 00 
80103008:	83 c4 10             	add    $0x10,%esp
8010300b:	05 80 a7 14 80       	add    $0x8014a780,%eax
80103010:	39 d8                	cmp    %ebx,%eax
80103012:	76 6f                	jbe    80103083 <main+0x103>
80103014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103018:	e8 e3 07 00 00       	call   80103800 <mycpu>
8010301d:	39 d8                	cmp    %ebx,%eax
8010301f:	74 49                	je     8010306a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103021:	e8 6a f4 ff ff       	call   80102490 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103026:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
8010302b:	c7 05 f8 6f 00 80 60 	movl   $0x80102f60,0x80006ff8
80103032:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103035:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010303c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010303f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103044:	0f b6 03             	movzbl (%ebx),%eax
80103047:	83 ec 08             	sub    $0x8,%esp
8010304a:	68 00 70 00 00       	push   $0x7000
8010304f:	50                   	push   %eax
80103050:	e8 0b f8 ff ff       	call   80102860 <lapicstartap>
80103055:	83 c4 10             	add    $0x10,%esp
80103058:	90                   	nop
80103059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103060:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103066:	85 c0                	test   %eax,%eax
80103068:	74 f6                	je     80103060 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010306a:	69 05 00 ad 14 80 b0 	imul   $0xb0,0x8014ad00,%eax
80103071:	00 00 00 
80103074:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010307a:	05 80 a7 14 80       	add    $0x8014a780,%eax
8010307f:	39 c3                	cmp    %eax,%ebx
80103081:	72 95                	jb     80103018 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103083:	83 ec 08             	sub    $0x8,%esp
80103086:	68 00 00 00 8e       	push   $0x8e000000
8010308b:	68 00 00 40 80       	push   $0x80400000
80103090:	e8 9b f3 ff ff       	call   80102430 <kinit2>
  userinit();      // first user process
80103095:	e8 36 08 00 00       	call   801038d0 <userinit>
  mpmain();        // finish this processor's setup
8010309a:	e8 81 fe ff ff       	call   80102f20 <mpmain>
8010309f:	90                   	nop

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030ab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	73 48                	jae    801030fe <mpsearch1+0x5e>
801030b6:	8d 76 00             	lea    0x0(%esi),%esi
801030b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c0:	83 ec 04             	sub    $0x4,%esp
801030c3:	8d 7e 10             	lea    0x10(%esi),%edi
801030c6:	6a 04                	push   $0x4
801030c8:	68 98 76 10 80       	push   $0x80107698
801030cd:	56                   	push   %esi
801030ce:	e8 ad 14 00 00       	call   80104580 <memcmp>
801030d3:	83 c4 10             	add    $0x10,%esp
801030d6:	85 c0                	test   %eax,%eax
801030d8:	75 1e                	jne    801030f8 <mpsearch1+0x58>
801030da:	8d 7e 10             	lea    0x10(%esi),%edi
801030dd:	89 f2                	mov    %esi,%edx
801030df:	31 c9                	xor    %ecx,%ecx
801030e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030e8:	0f b6 02             	movzbl (%edx),%eax
801030eb:	83 c2 01             	add    $0x1,%edx
801030ee:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030f0:	39 fa                	cmp    %edi,%edx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c9                	test   %cl,%cl
801030f6:	74 10                	je     80103108 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030f8:	39 fb                	cmp    %edi,%ebx
801030fa:	89 fe                	mov    %edi,%esi
801030fc:	77 c2                	ja     801030c0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103101:	31 c0                	xor    %eax,%eax
}
80103103:	5b                   	pop    %ebx
80103104:	5e                   	pop    %esi
80103105:	5f                   	pop    %edi
80103106:	5d                   	pop    %ebp
80103107:	c3                   	ret    
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310b:	89 f0                	mov    %esi,%eax
8010310d:	5b                   	pop    %ebx
8010310e:	5e                   	pop    %esi
8010310f:	5f                   	pop    %edi
80103110:	5d                   	pop    %ebp
80103111:	c3                   	ret    
80103112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010316d:	0f 84 37 01 00 00    	je     801032aa <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103173:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103176:	8b 58 04             	mov    0x4(%eax),%ebx
80103179:	85 db                	test   %ebx,%ebx
8010317b:	0f 84 43 01 00 00    	je     801032c4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103181:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103187:	83 ec 04             	sub    $0x4,%esp
8010318a:	6a 04                	push   $0x4
8010318c:	68 9d 76 10 80       	push   $0x8010769d
80103191:	56                   	push   %esi
80103192:	e8 e9 13 00 00       	call   80104580 <memcmp>
80103197:	83 c4 10             	add    $0x10,%esp
8010319a:	85 c0                	test   %eax,%eax
8010319c:	0f 85 22 01 00 00    	jne    801032c4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031a9:	3c 01                	cmp    $0x1,%al
801031ab:	74 08                	je     801031b5 <mpinit+0x95>
801031ad:	3c 04                	cmp    $0x4,%al
801031af:	0f 85 0f 01 00 00    	jne    801032c4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031b5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031bc:	85 ff                	test   %edi,%edi
801031be:	74 21                	je     801031e1 <mpinit+0xc1>
801031c0:	31 d2                	xor    %edx,%edx
801031c2:	31 c0                	xor    %eax,%eax
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031c8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031cf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031d3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d5:	39 c7                	cmp    %eax,%edi
801031d7:	75 ef                	jne    801031c8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031d9:	84 d2                	test   %dl,%dl
801031db:	0f 85 e3 00 00 00    	jne    801032c4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031e1:	85 f6                	test   %esi,%esi
801031e3:	0f 84 db 00 00 00    	je     801032c4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031e9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031ef:	a3 7c a6 14 80       	mov    %eax,0x8014a67c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031f4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801031fb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103201:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103206:	01 d6                	add    %edx,%esi
80103208:	90                   	nop
80103209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103210:	39 c6                	cmp    %eax,%esi
80103212:	76 23                	jbe    80103237 <mpinit+0x117>
80103214:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103217:	80 fa 04             	cmp    $0x4,%dl
8010321a:	0f 87 c0 00 00 00    	ja     801032e0 <mpinit+0x1c0>
80103220:	ff 24 95 dc 76 10 80 	jmp    *-0x7fef8924(,%edx,4)
80103227:	89 f6                	mov    %esi,%esi
80103229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103230:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103233:	39 c6                	cmp    %eax,%esi
80103235:	77 dd                	ja     80103214 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103237:	85 db                	test   %ebx,%ebx
80103239:	0f 84 92 00 00 00    	je     801032d1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010323f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103242:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103246:	74 15                	je     8010325d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103248:	ba 22 00 00 00       	mov    $0x22,%edx
8010324d:	b8 70 00 00 00       	mov    $0x70,%eax
80103252:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103253:	ba 23 00 00 00       	mov    $0x23,%edx
80103258:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103259:	83 c8 01             	or     $0x1,%eax
8010325c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010325d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103260:	5b                   	pop    %ebx
80103261:	5e                   	pop    %esi
80103262:	5f                   	pop    %edi
80103263:	5d                   	pop    %ebp
80103264:	c3                   	ret    
80103265:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103268:	8b 0d 00 ad 14 80    	mov    0x8014ad00,%ecx
8010326e:	83 f9 07             	cmp    $0x7,%ecx
80103271:	7f 19                	jg     8010328c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103273:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103277:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010327d:	83 c1 01             	add    $0x1,%ecx
80103280:	89 0d 00 ad 14 80    	mov    %ecx,0x8014ad00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103286:	88 97 80 a7 14 80    	mov    %dl,-0x7feb5880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010328c:	83 c0 14             	add    $0x14,%eax
      continue;
8010328f:	e9 7c ff ff ff       	jmp    80103210 <mpinit+0xf0>
80103294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103298:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010329c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010329f:	88 15 60 a7 14 80    	mov    %dl,0x8014a760
      p += sizeof(struct mpioapic);
      continue;
801032a5:	e9 66 ff ff ff       	jmp    80103210 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032aa:	ba 00 00 01 00       	mov    $0x10000,%edx
801032af:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032b4:	e8 e7 fd ff ff       	call   801030a0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032b9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032be:	0f 85 af fe ff ff    	jne    80103173 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801032c4:	83 ec 0c             	sub    $0xc,%esp
801032c7:	68 a2 76 10 80       	push   $0x801076a2
801032cc:	e8 9f d0 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032d1:	83 ec 0c             	sub    $0xc,%esp
801032d4:	68 bc 76 10 80       	push   $0x801076bc
801032d9:	e8 92 d0 ff ff       	call   80100370 <panic>
801032de:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032e0:	31 db                	xor    %ebx,%ebx
801032e2:	e9 30 ff ff ff       	jmp    80103217 <mpinit+0xf7>
801032e7:	66 90                	xchg   %ax,%ax
801032e9:	66 90                	xchg   %ax,%ax
801032eb:	66 90                	xchg   %ax,%ax
801032ed:	66 90                	xchg   %ax,%ax
801032ef:	90                   	nop

801032f0 <picinit>:
801032f0:	55                   	push   %ebp
801032f1:	ba 21 00 00 00       	mov    $0x21,%edx
801032f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032fb:	89 e5                	mov    %esp,%ebp
801032fd:	ee                   	out    %al,(%dx)
801032fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103303:	ee                   	out    %al,(%dx)
80103304:	5d                   	pop    %ebp
80103305:	c3                   	ret    
80103306:	66 90                	xchg   %ax,%ax
80103308:	66 90                	xchg   %ax,%ax
8010330a:	66 90                	xchg   %ax,%ax
8010330c:	66 90                	xchg   %ax,%ax
8010330e:	66 90                	xchg   %ax,%ax

80103310 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	57                   	push   %edi
80103314:	56                   	push   %esi
80103315:	53                   	push   %ebx
80103316:	83 ec 0c             	sub    $0xc,%esp
80103319:	8b 75 08             	mov    0x8(%ebp),%esi
8010331c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010331f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103325:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010332b:	e8 40 da ff ff       	call   80100d70 <filealloc>
80103330:	85 c0                	test   %eax,%eax
80103332:	89 06                	mov    %eax,(%esi)
80103334:	0f 84 a8 00 00 00    	je     801033e2 <pipealloc+0xd2>
8010333a:	e8 31 da ff ff       	call   80100d70 <filealloc>
8010333f:	85 c0                	test   %eax,%eax
80103341:	89 03                	mov    %eax,(%ebx)
80103343:	0f 84 87 00 00 00    	je     801033d0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103349:	e8 42 f1 ff ff       	call   80102490 <kalloc>
8010334e:	85 c0                	test   %eax,%eax
80103350:	89 c7                	mov    %eax,%edi
80103352:	0f 84 b0 00 00 00    	je     80103408 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103358:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010335b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103362:	00 00 00 
  p->writeopen = 1;
80103365:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010336c:	00 00 00 
  p->nwrite = 0;
8010336f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103376:	00 00 00 
  p->nread = 0;
80103379:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103380:	00 00 00 
  initlock(&p->lock, "pipe");
80103383:	68 f0 76 10 80       	push   $0x801076f0
80103388:	50                   	push   %eax
80103389:	e8 32 0f 00 00       	call   801042c0 <initlock>
  (*f0)->type = FD_PIPE;
8010338e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103390:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103393:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103399:	8b 06                	mov    (%esi),%eax
8010339b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010339f:	8b 06                	mov    (%esi),%eax
801033a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033a5:	8b 06                	mov    (%esi),%eax
801033a7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033aa:	8b 03                	mov    (%ebx),%eax
801033ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033b2:	8b 03                	mov    (%ebx),%eax
801033b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033b8:	8b 03                	mov    (%ebx),%eax
801033ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033be:	8b 03                	mov    (%ebx),%eax
801033c0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033c6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033c8:	5b                   	pop    %ebx
801033c9:	5e                   	pop    %esi
801033ca:	5f                   	pop    %edi
801033cb:	5d                   	pop    %ebp
801033cc:	c3                   	ret    
801033cd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033d0:	8b 06                	mov    (%esi),%eax
801033d2:	85 c0                	test   %eax,%eax
801033d4:	74 1e                	je     801033f4 <pipealloc+0xe4>
    fileclose(*f0);
801033d6:	83 ec 0c             	sub    $0xc,%esp
801033d9:	50                   	push   %eax
801033da:	e8 51 da ff ff       	call   80100e30 <fileclose>
801033df:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033e2:	8b 03                	mov    (%ebx),%eax
801033e4:	85 c0                	test   %eax,%eax
801033e6:	74 0c                	je     801033f4 <pipealloc+0xe4>
    fileclose(*f1);
801033e8:	83 ec 0c             	sub    $0xc,%esp
801033eb:	50                   	push   %eax
801033ec:	e8 3f da ff ff       	call   80100e30 <fileclose>
801033f1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801033f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801033f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033fc:	5b                   	pop    %ebx
801033fd:	5e                   	pop    %esi
801033fe:	5f                   	pop    %edi
801033ff:	5d                   	pop    %ebp
80103400:	c3                   	ret    
80103401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103408:	8b 06                	mov    (%esi),%eax
8010340a:	85 c0                	test   %eax,%eax
8010340c:	75 c8                	jne    801033d6 <pipealloc+0xc6>
8010340e:	eb d2                	jmp    801033e2 <pipealloc+0xd2>

80103410 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	56                   	push   %esi
80103414:	53                   	push   %ebx
80103415:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103418:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010341b:	83 ec 0c             	sub    $0xc,%esp
8010341e:	53                   	push   %ebx
8010341f:	e8 9c 0f 00 00       	call   801043c0 <acquire>
  if(writable){
80103424:	83 c4 10             	add    $0x10,%esp
80103427:	85 f6                	test   %esi,%esi
80103429:	74 45                	je     80103470 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010342b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103431:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103434:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010343b:	00 00 00 
    wakeup(&p->nread);
8010343e:	50                   	push   %eax
8010343f:	e8 bc 0b 00 00       	call   80104000 <wakeup>
80103444:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103447:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010344d:	85 d2                	test   %edx,%edx
8010344f:	75 0a                	jne    8010345b <pipeclose+0x4b>
80103451:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103457:	85 c0                	test   %eax,%eax
80103459:	74 35                	je     80103490 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010345b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010345e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103461:	5b                   	pop    %ebx
80103462:	5e                   	pop    %esi
80103463:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103464:	e9 77 10 00 00       	jmp    801044e0 <release>
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103470:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103476:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103479:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103480:	00 00 00 
    wakeup(&p->nwrite);
80103483:	50                   	push   %eax
80103484:	e8 77 0b 00 00       	call   80104000 <wakeup>
80103489:	83 c4 10             	add    $0x10,%esp
8010348c:	eb b9                	jmp    80103447 <pipeclose+0x37>
8010348e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 47 10 00 00       	call   801044e0 <release>
    kfree((char*)p);
80103499:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010349c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010349f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034a2:	5b                   	pop    %ebx
801034a3:	5e                   	pop    %esi
801034a4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801034a5:	e9 36 ee ff ff       	jmp    801022e0 <kfree>
801034aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034b0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	57                   	push   %edi
801034b4:	56                   	push   %esi
801034b5:	53                   	push   %ebx
801034b6:	83 ec 28             	sub    $0x28,%esp
801034b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034bc:	53                   	push   %ebx
801034bd:	e8 fe 0e 00 00       	call   801043c0 <acquire>
  for(i = 0; i < n; i++){
801034c2:	8b 45 10             	mov    0x10(%ebp),%eax
801034c5:	83 c4 10             	add    $0x10,%esp
801034c8:	85 c0                	test   %eax,%eax
801034ca:	0f 8e b9 00 00 00    	jle    80103589 <pipewrite+0xd9>
801034d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034d3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034df:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801034e5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034e8:	03 4d 10             	add    0x10(%ebp),%ecx
801034eb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034ee:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034f4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801034fa:	39 d0                	cmp    %edx,%eax
801034fc:	74 38                	je     80103536 <pipewrite+0x86>
801034fe:	eb 59                	jmp    80103559 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103500:	e8 9b 03 00 00       	call   801038a0 <myproc>
80103505:	8b 48 24             	mov    0x24(%eax),%ecx
80103508:	85 c9                	test   %ecx,%ecx
8010350a:	75 34                	jne    80103540 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010350c:	83 ec 0c             	sub    $0xc,%esp
8010350f:	57                   	push   %edi
80103510:	e8 eb 0a 00 00       	call   80104000 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103515:	58                   	pop    %eax
80103516:	5a                   	pop    %edx
80103517:	53                   	push   %ebx
80103518:	56                   	push   %esi
80103519:	e8 32 09 00 00       	call   80103e50 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010351e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103524:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010352a:	83 c4 10             	add    $0x10,%esp
8010352d:	05 00 02 00 00       	add    $0x200,%eax
80103532:	39 c2                	cmp    %eax,%edx
80103534:	75 2a                	jne    80103560 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103536:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010353c:	85 c0                	test   %eax,%eax
8010353e:	75 c0                	jne    80103500 <pipewrite+0x50>
        release(&p->lock);
80103540:	83 ec 0c             	sub    $0xc,%esp
80103543:	53                   	push   %ebx
80103544:	e8 97 0f 00 00       	call   801044e0 <release>
        return -1;
80103549:	83 c4 10             	add    $0x10,%esp
8010354c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103551:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103554:	5b                   	pop    %ebx
80103555:	5e                   	pop    %esi
80103556:	5f                   	pop    %edi
80103557:	5d                   	pop    %ebp
80103558:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103559:	89 c2                	mov    %eax,%edx
8010355b:	90                   	nop
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103560:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103563:	8d 42 01             	lea    0x1(%edx),%eax
80103566:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010356a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103570:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103576:	0f b6 09             	movzbl (%ecx),%ecx
80103579:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010357d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103580:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103583:	0f 85 65 ff ff ff    	jne    801034ee <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103589:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010358f:	83 ec 0c             	sub    $0xc,%esp
80103592:	50                   	push   %eax
80103593:	e8 68 0a 00 00       	call   80104000 <wakeup>
  release(&p->lock);
80103598:	89 1c 24             	mov    %ebx,(%esp)
8010359b:	e8 40 0f 00 00       	call   801044e0 <release>
  return n;
801035a0:	83 c4 10             	add    $0x10,%esp
801035a3:	8b 45 10             	mov    0x10(%ebp),%eax
801035a6:	eb a9                	jmp    80103551 <pipewrite+0xa1>
801035a8:	90                   	nop
801035a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035b0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	57                   	push   %edi
801035b4:	56                   	push   %esi
801035b5:	53                   	push   %ebx
801035b6:	83 ec 18             	sub    $0x18,%esp
801035b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035bf:	53                   	push   %ebx
801035c0:	e8 fb 0d 00 00       	call   801043c0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035c5:	83 c4 10             	add    $0x10,%esp
801035c8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035ce:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801035d4:	75 6a                	jne    80103640 <piperead+0x90>
801035d6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035dc:	85 f6                	test   %esi,%esi
801035de:	0f 84 cc 00 00 00    	je     801036b0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035e4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801035ea:	eb 2d                	jmp    80103619 <piperead+0x69>
801035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035f0:	83 ec 08             	sub    $0x8,%esp
801035f3:	53                   	push   %ebx
801035f4:	56                   	push   %esi
801035f5:	e8 56 08 00 00       	call   80103e50 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035fa:	83 c4 10             	add    $0x10,%esp
801035fd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103603:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103609:	75 35                	jne    80103640 <piperead+0x90>
8010360b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103611:	85 d2                	test   %edx,%edx
80103613:	0f 84 97 00 00 00    	je     801036b0 <piperead+0x100>
    if(myproc()->killed){
80103619:	e8 82 02 00 00       	call   801038a0 <myproc>
8010361e:	8b 48 24             	mov    0x24(%eax),%ecx
80103621:	85 c9                	test   %ecx,%ecx
80103623:	74 cb                	je     801035f0 <piperead+0x40>
      release(&p->lock);
80103625:	83 ec 0c             	sub    $0xc,%esp
80103628:	53                   	push   %ebx
80103629:	e8 b2 0e 00 00       	call   801044e0 <release>
      return -1;
8010362e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103631:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103634:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103639:	5b                   	pop    %ebx
8010363a:	5e                   	pop    %esi
8010363b:	5f                   	pop    %edi
8010363c:	5d                   	pop    %ebp
8010363d:	c3                   	ret    
8010363e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103640:	8b 45 10             	mov    0x10(%ebp),%eax
80103643:	85 c0                	test   %eax,%eax
80103645:	7e 69                	jle    801036b0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103647:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364d:	31 c9                	xor    %ecx,%ecx
8010364f:	eb 15                	jmp    80103666 <piperead+0xb6>
80103651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103658:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103664:	74 5a                	je     801036c0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103666:	8d 70 01             	lea    0x1(%eax),%esi
80103669:	25 ff 01 00 00       	and    $0x1ff,%eax
8010366e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103674:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103679:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010367c:	83 c1 01             	add    $0x1,%ecx
8010367f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103682:	75 d4                	jne    80103658 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103684:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010368a:	83 ec 0c             	sub    $0xc,%esp
8010368d:	50                   	push   %eax
8010368e:	e8 6d 09 00 00       	call   80104000 <wakeup>
  release(&p->lock);
80103693:	89 1c 24             	mov    %ebx,(%esp)
80103696:	e8 45 0e 00 00       	call   801044e0 <release>
  return i;
8010369b:	8b 45 10             	mov    0x10(%ebp),%eax
8010369e:	83 c4 10             	add    $0x10,%esp
}
801036a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036a4:	5b                   	pop    %ebx
801036a5:	5e                   	pop    %esi
801036a6:	5f                   	pop    %edi
801036a7:	5d                   	pop    %ebp
801036a8:	c3                   	ret    
801036a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036b0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801036b7:	eb cb                	jmp    80103684 <piperead+0xd4>
801036b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801036c3:	eb bf                	jmp    80103684 <piperead+0xd4>
801036c5:	66 90                	xchg   %ax,%ax
801036c7:	66 90                	xchg   %ax,%ax
801036c9:	66 90                	xchg   %ax,%ax
801036cb:	66 90                	xchg   %ax,%ax
801036cd:	66 90                	xchg   %ax,%ax
801036cf:	90                   	nop

801036d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036d4:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036d9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801036dc:	68 20 ad 14 80       	push   $0x8014ad20
801036e1:	e8 da 0c 00 00       	call   801043c0 <acquire>
801036e6:	83 c4 10             	add    $0x10,%esp
801036e9:	eb 10                	jmp    801036fb <allocproc+0x2b>
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036f0:	83 c3 7c             	add    $0x7c,%ebx
801036f3:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
801036f9:	74 75                	je     80103770 <allocproc+0xa0>
    if(p->state == UNUSED)
801036fb:	8b 43 0c             	mov    0xc(%ebx),%eax
801036fe:	85 c0                	test   %eax,%eax
80103700:	75 ee                	jne    801036f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103702:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103707:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010370a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103711:	68 20 ad 14 80       	push   $0x8014ad20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103716:	8d 50 01             	lea    0x1(%eax),%edx
80103719:	89 43 10             	mov    %eax,0x10(%ebx)
8010371c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
80103722:	e8 b9 0d 00 00       	call   801044e0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103727:	e8 64 ed ff ff       	call   80102490 <kalloc>
8010372c:	83 c4 10             	add    $0x10,%esp
8010372f:	85 c0                	test   %eax,%eax
80103731:	89 43 08             	mov    %eax,0x8(%ebx)
80103734:	74 51                	je     80103787 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103736:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010373c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010373f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103744:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103747:	c7 40 14 e8 57 10 80 	movl   $0x801057e8,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010374e:	6a 14                	push   $0x14
80103750:	6a 00                	push   $0x0
80103752:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103753:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103756:	e8 d5 0d 00 00       	call   80104530 <memset>
  p->context->eip = (uint)forkret;
8010375b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010375e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103761:	c7 40 10 90 37 10 80 	movl   $0x80103790,0x10(%eax)

  return p;
80103768:	89 d8                	mov    %ebx,%eax
}
8010376a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010376d:	c9                   	leave  
8010376e:	c3                   	ret    
8010376f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103770:	83 ec 0c             	sub    $0xc,%esp
80103773:	68 20 ad 14 80       	push   $0x8014ad20
80103778:	e8 63 0d 00 00       	call   801044e0 <release>
  return 0;
8010377d:	83 c4 10             	add    $0x10,%esp
80103780:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103782:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103785:	c9                   	leave  
80103786:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103787:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010378e:	eb da                	jmp    8010376a <allocproc+0x9a>

80103790 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103796:	68 20 ad 14 80       	push   $0x8014ad20
8010379b:	e8 40 0d 00 00       	call   801044e0 <release>

  if (first) {
801037a0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037a5:	83 c4 10             	add    $0x10,%esp
801037a8:	85 c0                	test   %eax,%eax
801037aa:	75 04                	jne    801037b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037ac:	c9                   	leave  
801037ad:	c3                   	ret    
801037ae:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801037b0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801037b3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037ba:	00 00 00 
    iinit(ROOTDEV);
801037bd:	6a 01                	push   $0x1
801037bf:	e8 ac dc ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
801037c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037cb:	e8 00 f4 ff ff       	call   80102bd0 <initlog>
801037d0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037d3:	c9                   	leave  
801037d4:	c3                   	ret    
801037d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037e6:	68 f5 76 10 80       	push   $0x801076f5
801037eb:	68 20 ad 14 80       	push   $0x8014ad20
801037f0:	e8 cb 0a 00 00       	call   801042c0 <initlock>
}
801037f5:	83 c4 10             	add    $0x10,%esp
801037f8:	c9                   	leave  
801037f9:	c3                   	ret    
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103800 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	56                   	push   %esi
80103804:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103805:	9c                   	pushf  
80103806:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103807:	f6 c4 02             	test   $0x2,%ah
8010380a:	75 5b                	jne    80103867 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010380c:	e8 ff ef ff ff       	call   80102810 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103811:	8b 35 00 ad 14 80    	mov    0x8014ad00,%esi
80103817:	85 f6                	test   %esi,%esi
80103819:	7e 3f                	jle    8010385a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010381b:	0f b6 15 80 a7 14 80 	movzbl 0x8014a780,%edx
80103822:	39 d0                	cmp    %edx,%eax
80103824:	74 30                	je     80103856 <mycpu+0x56>
80103826:	b9 30 a8 14 80       	mov    $0x8014a830,%ecx
8010382b:	31 d2                	xor    %edx,%edx
8010382d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103830:	83 c2 01             	add    $0x1,%edx
80103833:	39 f2                	cmp    %esi,%edx
80103835:	74 23                	je     8010385a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103837:	0f b6 19             	movzbl (%ecx),%ebx
8010383a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103840:	39 d8                	cmp    %ebx,%eax
80103842:	75 ec                	jne    80103830 <mycpu+0x30>
      return &cpus[i];
80103844:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010384a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010384d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010384e:	05 80 a7 14 80       	add    $0x8014a780,%eax
  }
  panic("unknown apicid\n");
}
80103853:	5e                   	pop    %esi
80103854:	5d                   	pop    %ebp
80103855:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103856:	31 d2                	xor    %edx,%edx
80103858:	eb ea                	jmp    80103844 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010385a:	83 ec 0c             	sub    $0xc,%esp
8010385d:	68 fc 76 10 80       	push   $0x801076fc
80103862:	e8 09 cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103867:	83 ec 0c             	sub    $0xc,%esp
8010386a:	68 d8 77 10 80       	push   $0x801077d8
8010386f:	e8 fc ca ff ff       	call   80100370 <panic>
80103874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010387a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103880 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103886:	e8 75 ff ff ff       	call   80103800 <mycpu>
8010388b:	2d 80 a7 14 80       	sub    $0x8014a780,%eax
}
80103890:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103891:	c1 f8 04             	sar    $0x4,%eax
80103894:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010389a:	c3                   	ret    
8010389b:	90                   	nop
8010389c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038a0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	53                   	push   %ebx
801038a4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801038a7:	e8 d4 0a 00 00       	call   80104380 <pushcli>
  c = mycpu();
801038ac:	e8 4f ff ff ff       	call   80103800 <mycpu>
  p = c->proc;
801038b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038b7:	e8 b4 0b 00 00       	call   80104470 <popcli>
  return p;
}
801038bc:	83 c4 04             	add    $0x4,%esp
801038bf:	89 d8                	mov    %ebx,%eax
801038c1:	5b                   	pop    %ebx
801038c2:	5d                   	pop    %ebp
801038c3:	c3                   	ret    
801038c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038d0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	53                   	push   %ebx
801038d4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801038d7:	e8 f4 fd ff ff       	call   801036d0 <allocproc>
801038dc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801038de:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038e3:	e8 f8 34 00 00       	call   80106de0 <setupkvm>
801038e8:	85 c0                	test   %eax,%eax
801038ea:	89 43 04             	mov    %eax,0x4(%ebx)
801038ed:	0f 84 bd 00 00 00    	je     801039b0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038f3:	83 ec 04             	sub    $0x4,%esp
801038f6:	68 2c 00 00 00       	push   $0x2c
801038fb:	68 60 a4 10 80       	push   $0x8010a460
80103900:	50                   	push   %eax
80103901:	e8 ea 31 00 00       	call   80106af0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103906:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103909:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010390f:	6a 4c                	push   $0x4c
80103911:	6a 00                	push   $0x0
80103913:	ff 73 18             	pushl  0x18(%ebx)
80103916:	e8 15 0c 00 00       	call   80104530 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010391b:	8b 43 18             	mov    0x18(%ebx),%eax
8010391e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103923:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103928:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010392b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010392f:	8b 43 18             	mov    0x18(%ebx),%eax
80103932:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103936:	8b 43 18             	mov    0x18(%ebx),%eax
80103939:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010393d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103941:	8b 43 18             	mov    0x18(%ebx),%eax
80103944:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103948:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010394c:	8b 43 18             	mov    0x18(%ebx),%eax
8010394f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103960:	8b 43 18             	mov    0x18(%ebx),%eax
80103963:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010396a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010396d:	6a 10                	push   $0x10
8010396f:	68 25 77 10 80       	push   $0x80107725
80103974:	50                   	push   %eax
80103975:	e8 b6 0d 00 00       	call   80104730 <safestrcpy>
  p->cwd = namei("/");
8010397a:	c7 04 24 2e 77 10 80 	movl   $0x8010772e,(%esp)
80103981:	e8 3a e5 ff ff       	call   80101ec0 <namei>
80103986:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103989:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103990:	e8 2b 0a 00 00       	call   801043c0 <acquire>

  p->state = RUNNABLE;
80103995:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010399c:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801039a3:	e8 38 0b 00 00       	call   801044e0 <release>
}
801039a8:	83 c4 10             	add    $0x10,%esp
801039ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ae:	c9                   	leave  
801039af:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801039b0:	83 ec 0c             	sub    $0xc,%esp
801039b3:	68 0c 77 10 80       	push   $0x8010770c
801039b8:	e8 b3 c9 ff ff       	call   80100370 <panic>
801039bd:	8d 76 00             	lea    0x0(%esi),%esi

801039c0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	56                   	push   %esi
801039c4:	53                   	push   %ebx
801039c5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801039c8:	e8 b3 09 00 00       	call   80104380 <pushcli>
  c = mycpu();
801039cd:	e8 2e fe ff ff       	call   80103800 <mycpu>
  p = c->proc;
801039d2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d8:	e8 93 0a 00 00       	call   80104470 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801039dd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801039e0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039e2:	7e 34                	jle    80103a18 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039e4:	83 ec 04             	sub    $0x4,%esp
801039e7:	01 c6                	add    %eax,%esi
801039e9:	56                   	push   %esi
801039ea:	50                   	push   %eax
801039eb:	ff 73 04             	pushl  0x4(%ebx)
801039ee:	e8 3d 32 00 00       	call   80106c30 <allocuvm>
801039f3:	83 c4 10             	add    $0x10,%esp
801039f6:	85 c0                	test   %eax,%eax
801039f8:	74 36                	je     80103a30 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
801039fa:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801039fd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039ff:	53                   	push   %ebx
80103a00:	e8 db 2f 00 00       	call   801069e0 <switchuvm>
  return 0;
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	31 c0                	xor    %eax,%eax
}
80103a0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a0d:	5b                   	pop    %ebx
80103a0e:	5e                   	pop    %esi
80103a0f:	5d                   	pop    %ebp
80103a10:	c3                   	ret    
80103a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a18:	74 e0                	je     801039fa <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a1a:	83 ec 04             	sub    $0x4,%esp
80103a1d:	01 c6                	add    %eax,%esi
80103a1f:	56                   	push   %esi
80103a20:	50                   	push   %eax
80103a21:	ff 73 04             	pushl  0x4(%ebx)
80103a24:	e8 07 33 00 00       	call   80106d30 <deallocuvm>
80103a29:	83 c4 10             	add    $0x10,%esp
80103a2c:	85 c0                	test   %eax,%eax
80103a2e:	75 ca                	jne    801039fa <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a35:	eb d3                	jmp    80103a0a <growproc+0x4a>
80103a37:	89 f6                	mov    %esi,%esi
80103a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a40 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	57                   	push   %edi
80103a44:	56                   	push   %esi
80103a45:	53                   	push   %ebx
80103a46:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a49:	e8 32 09 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103a4e:	e8 ad fd ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103a53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a59:	e8 12 0a 00 00       	call   80104470 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103a5e:	e8 6d fc ff ff       	call   801036d0 <allocproc>
80103a63:	85 c0                	test   %eax,%eax
80103a65:	89 c7                	mov    %eax,%edi
80103a67:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a6a:	0f 84 b5 00 00 00    	je     80103b25 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a70:	83 ec 08             	sub    $0x8,%esp
80103a73:	ff 33                	pushl  (%ebx)
80103a75:	ff 73 04             	pushl  0x4(%ebx)
80103a78:	e8 33 34 00 00       	call   80106eb0 <copyuvm>
80103a7d:	83 c4 10             	add    $0x10,%esp
80103a80:	85 c0                	test   %eax,%eax
80103a82:	89 47 04             	mov    %eax,0x4(%edi)
80103a85:	0f 84 a1 00 00 00    	je     80103b2c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103a8b:	8b 03                	mov    (%ebx),%eax
80103a8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a90:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103a92:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103a95:	89 c8                	mov    %ecx,%eax
80103a97:	8b 79 18             	mov    0x18(%ecx),%edi
80103a9a:	8b 73 18             	mov    0x18(%ebx),%esi
80103a9d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103aa2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103aa4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103aa6:	8b 40 18             	mov    0x18(%eax),%eax
80103aa9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103ab0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ab4:	85 c0                	test   %eax,%eax
80103ab6:	74 13                	je     80103acb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ab8:	83 ec 0c             	sub    $0xc,%esp
80103abb:	50                   	push   %eax
80103abc:	e8 1f d3 ff ff       	call   80100de0 <filedup>
80103ac1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ac4:	83 c4 10             	add    $0x10,%esp
80103ac7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103acb:	83 c6 01             	add    $0x1,%esi
80103ace:	83 fe 10             	cmp    $0x10,%esi
80103ad1:	75 dd                	jne    80103ab0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ad3:	83 ec 0c             	sub    $0xc,%esp
80103ad6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ad9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103adc:	e8 5f db ff ff       	call   80101640 <idup>
80103ae1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ae4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ae7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103aea:	8d 47 6c             	lea    0x6c(%edi),%eax
80103aed:	6a 10                	push   $0x10
80103aef:	53                   	push   %ebx
80103af0:	50                   	push   %eax
80103af1:	e8 3a 0c 00 00       	call   80104730 <safestrcpy>

  pid = np->pid;
80103af6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103af9:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103b00:	e8 bb 08 00 00       	call   801043c0 <acquire>

  np->state = RUNNABLE;
80103b05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b0c:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103b13:	e8 c8 09 00 00       	call   801044e0 <release>

  return pid;
80103b18:	83 c4 10             	add    $0x10,%esp
80103b1b:	89 d8                	mov    %ebx,%eax
}
80103b1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b20:	5b                   	pop    %ebx
80103b21:	5e                   	pop    %esi
80103b22:	5f                   	pop    %edi
80103b23:	5d                   	pop    %ebp
80103b24:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b2a:	eb f1                	jmp    80103b1d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103b2c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b2f:	83 ec 0c             	sub    $0xc,%esp
80103b32:	ff 77 08             	pushl  0x8(%edi)
80103b35:	e8 a6 e7 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103b3a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103b41:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103b48:	83 c4 10             	add    $0x10,%esp
80103b4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b50:	eb cb                	jmp    80103b1d <fork+0xdd>
80103b52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	57                   	push   %edi
80103b64:	56                   	push   %esi
80103b65:	53                   	push   %ebx
80103b66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103b69:	e8 92 fc ff ff       	call   80103800 <mycpu>
80103b6e:	8d 78 04             	lea    0x4(%eax),%edi
80103b71:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b73:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b7a:	00 00 00 
80103b7d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b80:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b81:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b84:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b89:	68 20 ad 14 80       	push   $0x8014ad20
80103b8e:	e8 2d 08 00 00       	call   801043c0 <acquire>
80103b93:	83 c4 10             	add    $0x10,%esp
80103b96:	eb 13                	jmp    80103bab <scheduler+0x4b>
80103b98:	90                   	nop
80103b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba0:	83 c3 7c             	add    $0x7c,%ebx
80103ba3:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80103ba9:	74 45                	je     80103bf0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103bab:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103baf:	75 ef                	jne    80103ba0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103bb1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103bb4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bba:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bbb:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103bbe:	e8 1d 2e 00 00       	call   801069e0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103bc3:	58                   	pop    %eax
80103bc4:	5a                   	pop    %edx
80103bc5:	ff 73 a0             	pushl  -0x60(%ebx)
80103bc8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103bc9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103bd0:	e8 b6 0b 00 00       	call   8010478b <swtch>
      switchkvm();
80103bd5:	e8 e6 2d 00 00       	call   801069c0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103bda:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bdd:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103be3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bea:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bed:	75 bc                	jne    80103bab <scheduler+0x4b>
80103bef:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103bf0:	83 ec 0c             	sub    $0xc,%esp
80103bf3:	68 20 ad 14 80       	push   $0x8014ad20
80103bf8:	e8 e3 08 00 00       	call   801044e0 <release>

  }
80103bfd:	83 c4 10             	add    $0x10,%esp
80103c00:	e9 7b ff ff ff       	jmp    80103b80 <scheduler+0x20>
80103c05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c10 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c15:	e8 66 07 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103c1a:	e8 e1 fb ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103c1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c25:	e8 46 08 00 00       	call   80104470 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103c2a:	83 ec 0c             	sub    $0xc,%esp
80103c2d:	68 20 ad 14 80       	push   $0x8014ad20
80103c32:	e8 09 07 00 00       	call   80104340 <holding>
80103c37:	83 c4 10             	add    $0x10,%esp
80103c3a:	85 c0                	test   %eax,%eax
80103c3c:	74 4f                	je     80103c8d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103c3e:	e8 bd fb ff ff       	call   80103800 <mycpu>
80103c43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c4a:	75 68                	jne    80103cb4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103c4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c50:	74 55                	je     80103ca7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c52:	9c                   	pushf  
80103c53:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103c54:	f6 c4 02             	test   $0x2,%ah
80103c57:	75 41                	jne    80103c9a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c59:	e8 a2 fb ff ff       	call   80103800 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c5e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c67:	e8 94 fb ff ff       	call   80103800 <mycpu>
80103c6c:	83 ec 08             	sub    $0x8,%esp
80103c6f:	ff 70 04             	pushl  0x4(%eax)
80103c72:	53                   	push   %ebx
80103c73:	e8 13 0b 00 00       	call   8010478b <swtch>
  mycpu()->intena = intena;
80103c78:	e8 83 fb ff ff       	call   80103800 <mycpu>
}
80103c7d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103c80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c89:	5b                   	pop    %ebx
80103c8a:	5e                   	pop    %esi
80103c8b:	5d                   	pop    %ebp
80103c8c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c8d:	83 ec 0c             	sub    $0xc,%esp
80103c90:	68 30 77 10 80       	push   $0x80107730
80103c95:	e8 d6 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c9a:	83 ec 0c             	sub    $0xc,%esp
80103c9d:	68 5c 77 10 80       	push   $0x8010775c
80103ca2:	e8 c9 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	68 4e 77 10 80       	push   $0x8010774e
80103caf:	e8 bc c6 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103cb4:	83 ec 0c             	sub    $0xc,%esp
80103cb7:	68 42 77 10 80       	push   $0x80107742
80103cbc:	e8 af c6 ff ff       	call   80100370 <panic>
80103cc1:	eb 0d                	jmp    80103cd0 <exit>
80103cc3:	90                   	nop
80103cc4:	90                   	nop
80103cc5:	90                   	nop
80103cc6:	90                   	nop
80103cc7:	90                   	nop
80103cc8:	90                   	nop
80103cc9:	90                   	nop
80103cca:	90                   	nop
80103ccb:	90                   	nop
80103ccc:	90                   	nop
80103ccd:	90                   	nop
80103cce:	90                   	nop
80103ccf:	90                   	nop

80103cd0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103cd9:	e8 a2 06 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103cde:	e8 1d fb ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103ce3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ce9:	e8 82 07 00 00       	call   80104470 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103cee:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103cf4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103cf7:	8d 7e 68             	lea    0x68(%esi),%edi
80103cfa:	0f 84 e7 00 00 00    	je     80103de7 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103d00:	8b 03                	mov    (%ebx),%eax
80103d02:	85 c0                	test   %eax,%eax
80103d04:	74 12                	je     80103d18 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d06:	83 ec 0c             	sub    $0xc,%esp
80103d09:	50                   	push   %eax
80103d0a:	e8 21 d1 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103d0f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d15:	83 c4 10             	add    $0x10,%esp
80103d18:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d1b:	39 df                	cmp    %ebx,%edi
80103d1d:	75 e1                	jne    80103d00 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d1f:	e8 4c ef ff ff       	call   80102c70 <begin_op>
  iput(curproc->cwd);
80103d24:	83 ec 0c             	sub    $0xc,%esp
80103d27:	ff 76 68             	pushl  0x68(%esi)
80103d2a:	e8 71 da ff ff       	call   801017a0 <iput>
  end_op();
80103d2f:	e8 ac ef ff ff       	call   80102ce0 <end_op>
  curproc->cwd = 0;
80103d34:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103d3b:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103d42:	e8 79 06 00 00       	call   801043c0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103d47:	8b 56 14             	mov    0x14(%esi),%edx
80103d4a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d4d:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
80103d52:	eb 0e                	jmp    80103d62 <exit+0x92>
80103d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d58:	83 c0 7c             	add    $0x7c,%eax
80103d5b:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80103d60:	74 1c                	je     80103d7e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d62:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d66:	75 f0                	jne    80103d58 <exit+0x88>
80103d68:	3b 50 20             	cmp    0x20(%eax),%edx
80103d6b:	75 eb                	jne    80103d58 <exit+0x88>
      p->state = RUNNABLE;
80103d6d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d74:	83 c0 7c             	add    $0x7c,%eax
80103d77:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80103d7c:	75 e4                	jne    80103d62 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103d7e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103d84:	ba 54 ad 14 80       	mov    $0x8014ad54,%edx
80103d89:	eb 10                	jmp    80103d9b <exit+0xcb>
80103d8b:	90                   	nop
80103d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d90:	83 c2 7c             	add    $0x7c,%edx
80103d93:	81 fa 54 cc 14 80    	cmp    $0x8014cc54,%edx
80103d99:	74 33                	je     80103dce <exit+0xfe>
    if(p->parent == curproc){
80103d9b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d9e:	75 f0                	jne    80103d90 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103da0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103da4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103da7:	75 e7                	jne    80103d90 <exit+0xc0>
80103da9:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
80103dae:	eb 0a                	jmp    80103dba <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103db0:	83 c0 7c             	add    $0x7c,%eax
80103db3:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80103db8:	74 d6                	je     80103d90 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103dba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dbe:	75 f0                	jne    80103db0 <exit+0xe0>
80103dc0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103dc3:	75 eb                	jne    80103db0 <exit+0xe0>
      p->state = RUNNABLE;
80103dc5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dcc:	eb e2                	jmp    80103db0 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103dce:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dd5:	e8 36 fe ff ff       	call   80103c10 <sched>
  panic("zombie exit");
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 7d 77 10 80       	push   $0x8010777d
80103de2:	e8 89 c5 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103de7:	83 ec 0c             	sub    $0xc,%esp
80103dea:	68 70 77 10 80       	push   $0x80107770
80103def:	e8 7c c5 ff ff       	call   80100370 <panic>
80103df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e00 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	53                   	push   %ebx
80103e04:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e07:	68 20 ad 14 80       	push   $0x8014ad20
80103e0c:	e8 af 05 00 00       	call   801043c0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e11:	e8 6a 05 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103e16:	e8 e5 f9 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103e1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e21:	e8 4a 06 00 00       	call   80104470 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103e26:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e2d:	e8 de fd ff ff       	call   80103c10 <sched>
  release(&ptable.lock);
80103e32:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103e39:	e8 a2 06 00 00       	call   801044e0 <release>
}
80103e3e:	83 c4 10             	add    $0x10,%esp
80103e41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e44:	c9                   	leave  
80103e45:	c3                   	ret    
80103e46:	8d 76 00             	lea    0x0(%esi),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	57                   	push   %edi
80103e54:	56                   	push   %esi
80103e55:	53                   	push   %ebx
80103e56:	83 ec 0c             	sub    $0xc,%esp
80103e59:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e5c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e5f:	e8 1c 05 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103e64:	e8 97 f9 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103e69:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e6f:	e8 fc 05 00 00       	call   80104470 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103e74:	85 db                	test   %ebx,%ebx
80103e76:	0f 84 87 00 00 00    	je     80103f03 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103e7c:	85 f6                	test   %esi,%esi
80103e7e:	74 76                	je     80103ef6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e80:	81 fe 20 ad 14 80    	cmp    $0x8014ad20,%esi
80103e86:	74 50                	je     80103ed8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e88:	83 ec 0c             	sub    $0xc,%esp
80103e8b:	68 20 ad 14 80       	push   $0x8014ad20
80103e90:	e8 2b 05 00 00       	call   801043c0 <acquire>
    release(lk);
80103e95:	89 34 24             	mov    %esi,(%esp)
80103e98:	e8 43 06 00 00       	call   801044e0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103e9d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ea0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103ea7:	e8 64 fd ff ff       	call   80103c10 <sched>

  // Tidy up.
  p->chan = 0;
80103eac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103eb3:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103eba:	e8 21 06 00 00       	call   801044e0 <release>
    acquire(lk);
80103ebf:	89 75 08             	mov    %esi,0x8(%ebp)
80103ec2:	83 c4 10             	add    $0x10,%esp
  }
}
80103ec5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ec8:	5b                   	pop    %ebx
80103ec9:	5e                   	pop    %esi
80103eca:	5f                   	pop    %edi
80103ecb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103ecc:	e9 ef 04 00 00       	jmp    801043c0 <acquire>
80103ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103ed8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103edb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103ee2:	e8 29 fd ff ff       	call   80103c10 <sched>

  // Tidy up.
  p->chan = 0;
80103ee7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ef1:	5b                   	pop    %ebx
80103ef2:	5e                   	pop    %esi
80103ef3:	5f                   	pop    %edi
80103ef4:	5d                   	pop    %ebp
80103ef5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	68 8f 77 10 80       	push   $0x8010778f
80103efe:	e8 6d c4 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103f03:	83 ec 0c             	sub    $0xc,%esp
80103f06:	68 89 77 10 80       	push   $0x80107789
80103f0b:	e8 60 c4 ff ff       	call   80100370 <panic>

80103f10 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	56                   	push   %esi
80103f14:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f15:	e8 66 04 00 00       	call   80104380 <pushcli>
  c = mycpu();
80103f1a:	e8 e1 f8 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103f1f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f25:	e8 46 05 00 00       	call   80104470 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 20 ad 14 80       	push   $0x8014ad20
80103f32:	e8 89 04 00 00       	call   801043c0 <acquire>
80103f37:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f3a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f3c:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
80103f41:	eb 10                	jmp    80103f53 <wait+0x43>
80103f43:	90                   	nop
80103f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f48:	83 c3 7c             	add    $0x7c,%ebx
80103f4b:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80103f51:	74 1d                	je     80103f70 <wait+0x60>
      if(p->parent != curproc)
80103f53:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f56:	75 f0                	jne    80103f48 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103f58:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f5c:	74 30                	je     80103f8e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f5e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103f61:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f66:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80103f6c:	75 e5                	jne    80103f53 <wait+0x43>
80103f6e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103f70:	85 c0                	test   %eax,%eax
80103f72:	74 70                	je     80103fe4 <wait+0xd4>
80103f74:	8b 46 24             	mov    0x24(%esi),%eax
80103f77:	85 c0                	test   %eax,%eax
80103f79:	75 69                	jne    80103fe4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f7b:	83 ec 08             	sub    $0x8,%esp
80103f7e:	68 20 ad 14 80       	push   $0x8014ad20
80103f83:	56                   	push   %esi
80103f84:	e8 c7 fe ff ff       	call   80103e50 <sleep>
  }
80103f89:	83 c4 10             	add    $0x10,%esp
80103f8c:	eb ac                	jmp    80103f3a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f8e:	83 ec 0c             	sub    $0xc,%esp
80103f91:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f94:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f97:	e8 44 e3 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f9c:	5a                   	pop    %edx
80103f9d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103fa0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fa7:	e8 b4 2d 00 00       	call   80106d60 <freevm>
        p->pid = 0;
80103fac:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fb3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fba:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fbe:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fc5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fcc:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103fd3:	e8 08 05 00 00       	call   801044e0 <release>
        return pid;
80103fd8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fdb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103fde:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fe0:	5b                   	pop    %ebx
80103fe1:	5e                   	pop    %esi
80103fe2:	5d                   	pop    %ebp
80103fe3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103fe4:	83 ec 0c             	sub    $0xc,%esp
80103fe7:	68 20 ad 14 80       	push   $0x8014ad20
80103fec:	e8 ef 04 00 00       	call   801044e0 <release>
      return -1;
80103ff1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ff4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103ff7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ffc:	5b                   	pop    %ebx
80103ffd:	5e                   	pop    %esi
80103ffe:	5d                   	pop    %ebp
80103fff:	c3                   	ret    

80104000 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 10             	sub    $0x10,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010400a:	68 20 ad 14 80       	push   $0x8014ad20
8010400f:	e8 ac 03 00 00       	call   801043c0 <acquire>
80104014:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104017:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
8010401c:	eb 0c                	jmp    8010402a <wakeup+0x2a>
8010401e:	66 90                	xchg   %ax,%ax
80104020:	83 c0 7c             	add    $0x7c,%eax
80104023:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104028:	74 1c                	je     80104046 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010402a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010402e:	75 f0                	jne    80104020 <wakeup+0x20>
80104030:	3b 58 20             	cmp    0x20(%eax),%ebx
80104033:	75 eb                	jne    80104020 <wakeup+0x20>
      p->state = RUNNABLE;
80104035:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010403c:	83 c0 7c             	add    $0x7c,%eax
8010403f:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104044:	75 e4                	jne    8010402a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104046:	c7 45 08 20 ad 14 80 	movl   $0x8014ad20,0x8(%ebp)
}
8010404d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104050:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104051:	e9 8a 04 00 00       	jmp    801044e0 <release>
80104056:	8d 76 00             	lea    0x0(%esi),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	53                   	push   %ebx
80104064:	83 ec 10             	sub    $0x10,%esp
80104067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010406a:	68 20 ad 14 80       	push   $0x8014ad20
8010406f:	e8 4c 03 00 00       	call   801043c0 <acquire>
80104074:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104077:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
8010407c:	eb 0c                	jmp    8010408a <kill+0x2a>
8010407e:	66 90                	xchg   %ax,%ax
80104080:	83 c0 7c             	add    $0x7c,%eax
80104083:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104088:	74 3e                	je     801040c8 <kill+0x68>
    if(p->pid == pid){
8010408a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010408d:	75 f1                	jne    80104080 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010408f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104093:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010409a:	74 1c                	je     801040b8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010409c:	83 ec 0c             	sub    $0xc,%esp
8010409f:	68 20 ad 14 80       	push   $0x8014ad20
801040a4:	e8 37 04 00 00       	call   801044e0 <release>
      return 0;
801040a9:	83 c4 10             	add    $0x10,%esp
801040ac:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040b1:	c9                   	leave  
801040b2:	c3                   	ret    
801040b3:	90                   	nop
801040b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801040b8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040bf:	eb db                	jmp    8010409c <kill+0x3c>
801040c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801040c8:	83 ec 0c             	sub    $0xc,%esp
801040cb:	68 20 ad 14 80       	push   $0x8014ad20
801040d0:	e8 0b 04 00 00       	call   801044e0 <release>
  return -1;
801040d5:	83 c4 10             	add    $0x10,%esp
801040d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e0:	c9                   	leave  
801040e1:	c3                   	ret    
801040e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801040f9:	bb c0 ad 14 80       	mov    $0x8014adc0,%ebx
801040fe:	83 ec 3c             	sub    $0x3c,%esp
80104101:	eb 24                	jmp    80104127 <procdump+0x37>
80104103:	90                   	nop
80104104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104108:	83 ec 0c             	sub    $0xc,%esp
8010410b:	68 23 7b 10 80       	push   $0x80107b23
80104110:	e8 4b c5 ff ff       	call   80100660 <cprintf>
80104115:	83 c4 10             	add    $0x10,%esp
80104118:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010411b:	81 fb c0 cc 14 80    	cmp    $0x8014ccc0,%ebx
80104121:	0f 84 81 00 00 00    	je     801041a8 <procdump+0xb8>
    if(p->state == UNUSED)
80104127:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010412a:	85 c0                	test   %eax,%eax
8010412c:	74 ea                	je     80104118 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010412e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104131:	ba a0 77 10 80       	mov    $0x801077a0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104136:	77 11                	ja     80104149 <procdump+0x59>
80104138:	8b 14 85 00 78 10 80 	mov    -0x7fef8800(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010413f:	b8 a0 77 10 80       	mov    $0x801077a0,%eax
80104144:	85 d2                	test   %edx,%edx
80104146:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104149:	53                   	push   %ebx
8010414a:	52                   	push   %edx
8010414b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010414e:	68 a4 77 10 80       	push   $0x801077a4
80104153:	e8 08 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104158:	83 c4 10             	add    $0x10,%esp
8010415b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010415f:	75 a7                	jne    80104108 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104161:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104164:	83 ec 08             	sub    $0x8,%esp
80104167:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010416a:	50                   	push   %eax
8010416b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010416e:	8b 40 0c             	mov    0xc(%eax),%eax
80104171:	83 c0 08             	add    $0x8,%eax
80104174:	50                   	push   %eax
80104175:	e8 66 01 00 00       	call   801042e0 <getcallerpcs>
8010417a:	83 c4 10             	add    $0x10,%esp
8010417d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104180:	8b 17                	mov    (%edi),%edx
80104182:	85 d2                	test   %edx,%edx
80104184:	74 82                	je     80104108 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104186:	83 ec 08             	sub    $0x8,%esp
80104189:	83 c7 04             	add    $0x4,%edi
8010418c:	52                   	push   %edx
8010418d:	68 c1 71 10 80       	push   $0x801071c1
80104192:	e8 c9 c4 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104197:	83 c4 10             	add    $0x10,%esp
8010419a:	39 f7                	cmp    %esi,%edi
8010419c:	75 e2                	jne    80104180 <procdump+0x90>
8010419e:	e9 65 ff ff ff       	jmp    80104108 <procdump+0x18>
801041a3:	90                   	nop
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801041a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041ab:	5b                   	pop    %ebx
801041ac:	5e                   	pop    %esi
801041ad:	5f                   	pop    %edi
801041ae:	5d                   	pop    %ebp
801041af:	c3                   	ret    

801041b0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 0c             	sub    $0xc,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041ba:	68 18 78 10 80       	push   $0x80107818
801041bf:	8d 43 04             	lea    0x4(%ebx),%eax
801041c2:	50                   	push   %eax
801041c3:	e8 f8 00 00 00       	call   801042c0 <initlock>
  lk->name = name;
801041c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041cb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041d1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801041d4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801041db:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801041de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041e1:	c9                   	leave  
801041e2:	c3                   	ret    
801041e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041f0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	56                   	push   %esi
801041f4:	53                   	push   %ebx
801041f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041f8:	83 ec 0c             	sub    $0xc,%esp
801041fb:	8d 73 04             	lea    0x4(%ebx),%esi
801041fe:	56                   	push   %esi
801041ff:	e8 bc 01 00 00       	call   801043c0 <acquire>
  while (lk->locked) {
80104204:	8b 13                	mov    (%ebx),%edx
80104206:	83 c4 10             	add    $0x10,%esp
80104209:	85 d2                	test   %edx,%edx
8010420b:	74 16                	je     80104223 <acquiresleep+0x33>
8010420d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104210:	83 ec 08             	sub    $0x8,%esp
80104213:	56                   	push   %esi
80104214:	53                   	push   %ebx
80104215:	e8 36 fc ff ff       	call   80103e50 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010421a:	8b 03                	mov    (%ebx),%eax
8010421c:	83 c4 10             	add    $0x10,%esp
8010421f:	85 c0                	test   %eax,%eax
80104221:	75 ed                	jne    80104210 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104223:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104229:	e8 72 f6 ff ff       	call   801038a0 <myproc>
8010422e:	8b 40 10             	mov    0x10(%eax),%eax
80104231:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104234:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104237:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010423a:	5b                   	pop    %ebx
8010423b:	5e                   	pop    %esi
8010423c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010423d:	e9 9e 02 00 00       	jmp    801044e0 <release>
80104242:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104250 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
80104255:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104258:	83 ec 0c             	sub    $0xc,%esp
8010425b:	8d 73 04             	lea    0x4(%ebx),%esi
8010425e:	56                   	push   %esi
8010425f:	e8 5c 01 00 00       	call   801043c0 <acquire>
  lk->locked = 0;
80104264:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010426a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104271:	89 1c 24             	mov    %ebx,(%esp)
80104274:	e8 87 fd ff ff       	call   80104000 <wakeup>
  release(&lk->lk);
80104279:	89 75 08             	mov    %esi,0x8(%ebp)
8010427c:	83 c4 10             	add    $0x10,%esp
}
8010427f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104282:	5b                   	pop    %ebx
80104283:	5e                   	pop    %esi
80104284:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104285:	e9 56 02 00 00       	jmp    801044e0 <release>
8010428a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104290 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	56                   	push   %esi
80104294:	53                   	push   %ebx
80104295:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010429e:	53                   	push   %ebx
8010429f:	e8 1c 01 00 00       	call   801043c0 <acquire>
  r = lk->locked;
801042a4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801042a6:	89 1c 24             	mov    %ebx,(%esp)
801042a9:	e8 32 02 00 00       	call   801044e0 <release>
  return r;
}
801042ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042b1:	89 f0                	mov    %esi,%eax
801042b3:	5b                   	pop    %ebx
801042b4:	5e                   	pop    %esi
801042b5:	5d                   	pop    %ebp
801042b6:	c3                   	ret    
801042b7:	66 90                	xchg   %ax,%ax
801042b9:	66 90                	xchg   %ax,%ax
801042bb:	66 90                	xchg   %ax,%ax
801042bd:	66 90                	xchg   %ax,%ax
801042bf:	90                   	nop

801042c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801042cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801042d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801042d9:	5d                   	pop    %ebp
801042da:	c3                   	ret    
801042db:	90                   	nop
801042dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801042e4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801042e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801042ea:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801042ed:	31 c0                	xor    %eax,%eax
801042ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801042f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801042f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801042fc:	77 1a                	ja     80104318 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801042fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80104301:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104304:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104307:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104309:	83 f8 0a             	cmp    $0xa,%eax
8010430c:	75 e2                	jne    801042f0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010430e:	5b                   	pop    %ebx
8010430f:	5d                   	pop    %ebp
80104310:	c3                   	ret    
80104311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104318:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010431f:	83 c0 01             	add    $0x1,%eax
80104322:	83 f8 0a             	cmp    $0xa,%eax
80104325:	74 e7                	je     8010430e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104327:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010432e:	83 c0 01             	add    $0x1,%eax
80104331:	83 f8 0a             	cmp    $0xa,%eax
80104334:	75 e2                	jne    80104318 <getcallerpcs+0x38>
80104336:	eb d6                	jmp    8010430e <getcallerpcs+0x2e>
80104338:	90                   	nop
80104339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104340 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 04             	sub    $0x4,%esp
80104347:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010434a:	8b 02                	mov    (%edx),%eax
8010434c:	85 c0                	test   %eax,%eax
8010434e:	75 10                	jne    80104360 <holding+0x20>
}
80104350:	83 c4 04             	add    $0x4,%esp
80104353:	31 c0                	xor    %eax,%eax
80104355:	5b                   	pop    %ebx
80104356:	5d                   	pop    %ebp
80104357:	c3                   	ret    
80104358:	90                   	nop
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104360:	8b 5a 08             	mov    0x8(%edx),%ebx
80104363:	e8 98 f4 ff ff       	call   80103800 <mycpu>
80104368:	39 c3                	cmp    %eax,%ebx
8010436a:	0f 94 c0             	sete   %al
}
8010436d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104370:	0f b6 c0             	movzbl %al,%eax
}
80104373:	5b                   	pop    %ebx
80104374:	5d                   	pop    %ebp
80104375:	c3                   	ret    
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104380 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	83 ec 04             	sub    $0x4,%esp
80104387:	9c                   	pushf  
80104388:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104389:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010438a:	e8 71 f4 ff ff       	call   80103800 <mycpu>
8010438f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104395:	85 c0                	test   %eax,%eax
80104397:	75 11                	jne    801043aa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104399:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010439f:	e8 5c f4 ff ff       	call   80103800 <mycpu>
801043a4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043aa:	e8 51 f4 ff ff       	call   80103800 <mycpu>
801043af:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801043b6:	83 c4 04             	add    $0x4,%esp
801043b9:	5b                   	pop    %ebx
801043ba:	5d                   	pop    %ebp
801043bb:	c3                   	ret    
801043bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043c0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801043c5:	e8 b6 ff ff ff       	call   80104380 <pushcli>
  if(holding(lk))
801043ca:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801043cd:	8b 03                	mov    (%ebx),%eax
801043cf:	85 c0                	test   %eax,%eax
801043d1:	75 7d                	jne    80104450 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801043d3:	ba 01 00 00 00       	mov    $0x1,%edx
801043d8:	eb 09                	jmp    801043e3 <acquire+0x23>
801043da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043e3:	89 d0                	mov    %edx,%eax
801043e5:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801043e8:	85 c0                	test   %eax,%eax
801043ea:	75 f4                	jne    801043e0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801043ec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043f4:	e8 07 f4 ff ff       	call   80103800 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043f9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801043fb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043fe:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104401:	31 c0                	xor    %eax,%eax
80104403:	90                   	nop
80104404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104408:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010440e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104414:	77 1a                	ja     80104430 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104416:	8b 5a 04             	mov    0x4(%edx),%ebx
80104419:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010441c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010441f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104421:	83 f8 0a             	cmp    $0xa,%eax
80104424:	75 e2                	jne    80104408 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104426:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104429:	5b                   	pop    %ebx
8010442a:	5e                   	pop    %esi
8010442b:	5d                   	pop    %ebp
8010442c:	c3                   	ret    
8010442d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104430:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104437:	83 c0 01             	add    $0x1,%eax
8010443a:	83 f8 0a             	cmp    $0xa,%eax
8010443d:	74 e7                	je     80104426 <acquire+0x66>
    pcs[i] = 0;
8010443f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104446:	83 c0 01             	add    $0x1,%eax
80104449:	83 f8 0a             	cmp    $0xa,%eax
8010444c:	75 e2                	jne    80104430 <acquire+0x70>
8010444e:	eb d6                	jmp    80104426 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104450:	8b 73 08             	mov    0x8(%ebx),%esi
80104453:	e8 a8 f3 ff ff       	call   80103800 <mycpu>
80104458:	39 c6                	cmp    %eax,%esi
8010445a:	0f 85 73 ff ff ff    	jne    801043d3 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104460:	83 ec 0c             	sub    $0xc,%esp
80104463:	68 23 78 10 80       	push   $0x80107823
80104468:	e8 03 bf ff ff       	call   80100370 <panic>
8010446d:	8d 76 00             	lea    0x0(%esi),%esi

80104470 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104476:	9c                   	pushf  
80104477:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104478:	f6 c4 02             	test   $0x2,%ah
8010447b:	75 52                	jne    801044cf <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010447d:	e8 7e f3 ff ff       	call   80103800 <mycpu>
80104482:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104488:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010448b:	85 d2                	test   %edx,%edx
8010448d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104493:	78 2d                	js     801044c2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104495:	e8 66 f3 ff ff       	call   80103800 <mycpu>
8010449a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801044a0:	85 d2                	test   %edx,%edx
801044a2:	74 0c                	je     801044b0 <popcli+0x40>
    sti();
}
801044a4:	c9                   	leave  
801044a5:	c3                   	ret    
801044a6:	8d 76 00             	lea    0x0(%esi),%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801044b0:	e8 4b f3 ff ff       	call   80103800 <mycpu>
801044b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801044bb:	85 c0                	test   %eax,%eax
801044bd:	74 e5                	je     801044a4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801044bf:	fb                   	sti    
    sti();
}
801044c0:	c9                   	leave  
801044c1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801044c2:	83 ec 0c             	sub    $0xc,%esp
801044c5:	68 42 78 10 80       	push   $0x80107842
801044ca:	e8 a1 be ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801044cf:	83 ec 0c             	sub    $0xc,%esp
801044d2:	68 2b 78 10 80       	push   $0x8010782b
801044d7:	e8 94 be ff ff       	call   80100370 <panic>
801044dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044e0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	56                   	push   %esi
801044e4:	53                   	push   %ebx
801044e5:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044e8:	8b 03                	mov    (%ebx),%eax
801044ea:	85 c0                	test   %eax,%eax
801044ec:	75 12                	jne    80104500 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801044ee:	83 ec 0c             	sub    $0xc,%esp
801044f1:	68 49 78 10 80       	push   $0x80107849
801044f6:	e8 75 be ff ff       	call   80100370 <panic>
801044fb:	90                   	nop
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104500:	8b 73 08             	mov    0x8(%ebx),%esi
80104503:	e8 f8 f2 ff ff       	call   80103800 <mycpu>
80104508:	39 c6                	cmp    %eax,%esi
8010450a:	75 e2                	jne    801044ee <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
8010450c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104513:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010451a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010451f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104525:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104528:	5b                   	pop    %ebx
80104529:	5e                   	pop    %esi
8010452a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010452b:	e9 40 ff ff ff       	jmp    80104470 <popcli>

80104530 <memset>:
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	53                   	push   %ebx
80104535:	8b 55 08             	mov    0x8(%ebp),%edx
80104538:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010453b:	f6 c2 03             	test   $0x3,%dl
8010453e:	75 05                	jne    80104545 <memset+0x15>
80104540:	f6 c1 03             	test   $0x3,%cl
80104543:	74 13                	je     80104558 <memset+0x28>
80104545:	89 d7                	mov    %edx,%edi
80104547:	8b 45 0c             	mov    0xc(%ebp),%eax
8010454a:	fc                   	cld    
8010454b:	f3 aa                	rep stos %al,%es:(%edi)
8010454d:	5b                   	pop    %ebx
8010454e:	89 d0                	mov    %edx,%eax
80104550:	5f                   	pop    %edi
80104551:	5d                   	pop    %ebp
80104552:	c3                   	ret    
80104553:	90                   	nop
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104558:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010455c:	c1 e9 02             	shr    $0x2,%ecx
8010455f:	89 fb                	mov    %edi,%ebx
80104561:	89 f8                	mov    %edi,%eax
80104563:	c1 e3 18             	shl    $0x18,%ebx
80104566:	c1 e0 10             	shl    $0x10,%eax
80104569:	09 d8                	or     %ebx,%eax
8010456b:	09 f8                	or     %edi,%eax
8010456d:	c1 e7 08             	shl    $0x8,%edi
80104570:	09 f8                	or     %edi,%eax
80104572:	89 d7                	mov    %edx,%edi
80104574:	fc                   	cld    
80104575:	f3 ab                	rep stos %eax,%es:(%edi)
80104577:	5b                   	pop    %ebx
80104578:	89 d0                	mov    %edx,%eax
8010457a:	5f                   	pop    %edi
8010457b:	5d                   	pop    %ebp
8010457c:	c3                   	ret    
8010457d:	8d 76 00             	lea    0x0(%esi),%esi

80104580 <memcmp>:
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	57                   	push   %edi
80104584:	56                   	push   %esi
80104585:	8b 45 10             	mov    0x10(%ebp),%eax
80104588:	53                   	push   %ebx
80104589:	8b 75 0c             	mov    0xc(%ebp),%esi
8010458c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010458f:	85 c0                	test   %eax,%eax
80104591:	74 29                	je     801045bc <memcmp+0x3c>
80104593:	0f b6 13             	movzbl (%ebx),%edx
80104596:	0f b6 0e             	movzbl (%esi),%ecx
80104599:	38 d1                	cmp    %dl,%cl
8010459b:	75 2b                	jne    801045c8 <memcmp+0x48>
8010459d:	8d 78 ff             	lea    -0x1(%eax),%edi
801045a0:	31 c0                	xor    %eax,%eax
801045a2:	eb 14                	jmp    801045b8 <memcmp+0x38>
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045a8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801045ad:	83 c0 01             	add    $0x1,%eax
801045b0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801045b4:	38 ca                	cmp    %cl,%dl
801045b6:	75 10                	jne    801045c8 <memcmp+0x48>
801045b8:	39 f8                	cmp    %edi,%eax
801045ba:	75 ec                	jne    801045a8 <memcmp+0x28>
801045bc:	5b                   	pop    %ebx
801045bd:	31 c0                	xor    %eax,%eax
801045bf:	5e                   	pop    %esi
801045c0:	5f                   	pop    %edi
801045c1:	5d                   	pop    %ebp
801045c2:	c3                   	ret    
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045c8:	0f b6 c2             	movzbl %dl,%eax
801045cb:	5b                   	pop    %ebx
801045cc:	29 c8                	sub    %ecx,%eax
801045ce:	5e                   	pop    %esi
801045cf:	5f                   	pop    %edi
801045d0:	5d                   	pop    %ebp
801045d1:	c3                   	ret    
801045d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <memmove>:
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	56                   	push   %esi
801045e4:	53                   	push   %ebx
801045e5:	8b 45 08             	mov    0x8(%ebp),%eax
801045e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801045eb:	8b 5d 10             	mov    0x10(%ebp),%ebx
801045ee:	39 c6                	cmp    %eax,%esi
801045f0:	73 2e                	jae    80104620 <memmove+0x40>
801045f2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801045f5:	39 c8                	cmp    %ecx,%eax
801045f7:	73 27                	jae    80104620 <memmove+0x40>
801045f9:	85 db                	test   %ebx,%ebx
801045fb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801045fe:	74 17                	je     80104617 <memmove+0x37>
80104600:	29 d9                	sub    %ebx,%ecx
80104602:	89 cb                	mov    %ecx,%ebx
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104608:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010460c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
8010460f:	83 ea 01             	sub    $0x1,%edx
80104612:	83 fa ff             	cmp    $0xffffffff,%edx
80104615:	75 f1                	jne    80104608 <memmove+0x28>
80104617:	5b                   	pop    %ebx
80104618:	5e                   	pop    %esi
80104619:	5d                   	pop    %ebp
8010461a:	c3                   	ret    
8010461b:	90                   	nop
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104620:	31 d2                	xor    %edx,%edx
80104622:	85 db                	test   %ebx,%ebx
80104624:	74 f1                	je     80104617 <memmove+0x37>
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104630:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104634:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104637:	83 c2 01             	add    $0x1,%edx
8010463a:	39 d3                	cmp    %edx,%ebx
8010463c:	75 f2                	jne    80104630 <memmove+0x50>
8010463e:	5b                   	pop    %ebx
8010463f:	5e                   	pop    %esi
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <memcpy>:
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	5d                   	pop    %ebp
80104654:	eb 8a                	jmp    801045e0 <memmove>
80104656:	8d 76 00             	lea    0x0(%esi),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <strncmp>:
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104668:	53                   	push   %ebx
80104669:	8b 7d 08             	mov    0x8(%ebp),%edi
8010466c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010466f:	85 c9                	test   %ecx,%ecx
80104671:	74 37                	je     801046aa <strncmp+0x4a>
80104673:	0f b6 17             	movzbl (%edi),%edx
80104676:	0f b6 1e             	movzbl (%esi),%ebx
80104679:	84 d2                	test   %dl,%dl
8010467b:	74 3f                	je     801046bc <strncmp+0x5c>
8010467d:	38 d3                	cmp    %dl,%bl
8010467f:	75 3b                	jne    801046bc <strncmp+0x5c>
80104681:	8d 47 01             	lea    0x1(%edi),%eax
80104684:	01 cf                	add    %ecx,%edi
80104686:	eb 1b                	jmp    801046a3 <strncmp+0x43>
80104688:	90                   	nop
80104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104690:	0f b6 10             	movzbl (%eax),%edx
80104693:	84 d2                	test   %dl,%dl
80104695:	74 21                	je     801046b8 <strncmp+0x58>
80104697:	0f b6 19             	movzbl (%ecx),%ebx
8010469a:	83 c0 01             	add    $0x1,%eax
8010469d:	89 ce                	mov    %ecx,%esi
8010469f:	38 da                	cmp    %bl,%dl
801046a1:	75 19                	jne    801046bc <strncmp+0x5c>
801046a3:	39 c7                	cmp    %eax,%edi
801046a5:	8d 4e 01             	lea    0x1(%esi),%ecx
801046a8:	75 e6                	jne    80104690 <strncmp+0x30>
801046aa:	5b                   	pop    %ebx
801046ab:	31 c0                	xor    %eax,%eax
801046ad:	5e                   	pop    %esi
801046ae:	5f                   	pop    %edi
801046af:	5d                   	pop    %ebp
801046b0:	c3                   	ret    
801046b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
801046bc:	0f b6 c2             	movzbl %dl,%eax
801046bf:	29 d8                	sub    %ebx,%eax
801046c1:	5b                   	pop    %ebx
801046c2:	5e                   	pop    %esi
801046c3:	5f                   	pop    %edi
801046c4:	5d                   	pop    %ebp
801046c5:	c3                   	ret    
801046c6:	8d 76 00             	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <strncpy>:
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 45 08             	mov    0x8(%ebp),%eax
801046d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046db:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046de:	89 c2                	mov    %eax,%edx
801046e0:	eb 19                	jmp    801046fb <strncpy+0x2b>
801046e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046e8:	83 c3 01             	add    $0x1,%ebx
801046eb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046ef:	83 c2 01             	add    $0x1,%edx
801046f2:	84 c9                	test   %cl,%cl
801046f4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046f7:	74 09                	je     80104702 <strncpy+0x32>
801046f9:	89 f1                	mov    %esi,%ecx
801046fb:	85 c9                	test   %ecx,%ecx
801046fd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104700:	7f e6                	jg     801046e8 <strncpy+0x18>
80104702:	31 c9                	xor    %ecx,%ecx
80104704:	85 f6                	test   %esi,%esi
80104706:	7e 17                	jle    8010471f <strncpy+0x4f>
80104708:	90                   	nop
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104710:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104714:	89 f3                	mov    %esi,%ebx
80104716:	83 c1 01             	add    $0x1,%ecx
80104719:	29 cb                	sub    %ecx,%ebx
8010471b:	85 db                	test   %ebx,%ebx
8010471d:	7f f1                	jg     80104710 <strncpy+0x40>
8010471f:	5b                   	pop    %ebx
80104720:	5e                   	pop    %esi
80104721:	5d                   	pop    %ebp
80104722:	c3                   	ret    
80104723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <safestrcpy>:
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104738:	8b 45 08             	mov    0x8(%ebp),%eax
8010473b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010473e:	85 c9                	test   %ecx,%ecx
80104740:	7e 26                	jle    80104768 <safestrcpy+0x38>
80104742:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104746:	89 c1                	mov    %eax,%ecx
80104748:	eb 17                	jmp    80104761 <safestrcpy+0x31>
8010474a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104750:	83 c2 01             	add    $0x1,%edx
80104753:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104757:	83 c1 01             	add    $0x1,%ecx
8010475a:	84 db                	test   %bl,%bl
8010475c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010475f:	74 04                	je     80104765 <safestrcpy+0x35>
80104761:	39 f2                	cmp    %esi,%edx
80104763:	75 eb                	jne    80104750 <safestrcpy+0x20>
80104765:	c6 01 00             	movb   $0x0,(%ecx)
80104768:	5b                   	pop    %ebx
80104769:	5e                   	pop    %esi
8010476a:	5d                   	pop    %ebp
8010476b:	c3                   	ret    
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104770 <strlen>:
80104770:	55                   	push   %ebp
80104771:	31 c0                	xor    %eax,%eax
80104773:	89 e5                	mov    %esp,%ebp
80104775:	8b 55 08             	mov    0x8(%ebp),%edx
80104778:	80 3a 00             	cmpb   $0x0,(%edx)
8010477b:	74 0c                	je     80104789 <strlen+0x19>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi
80104780:	83 c0 01             	add    $0x1,%eax
80104783:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104787:	75 f7                	jne    80104780 <strlen+0x10>
80104789:	5d                   	pop    %ebp
8010478a:	c3                   	ret    

8010478b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010478b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010478f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104793:	55                   	push   %ebp
  pushl %ebx
80104794:	53                   	push   %ebx
  pushl %esi
80104795:	56                   	push   %esi
  pushl %edi
80104796:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104797:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104799:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010479b:	5f                   	pop    %edi
  popl %esi
8010479c:	5e                   	pop    %esi
  popl %ebx
8010479d:	5b                   	pop    %ebx
  popl %ebp
8010479e:	5d                   	pop    %ebp
  ret
8010479f:	c3                   	ret    

801047a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 04             	sub    $0x4,%esp
801047a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801047aa:	e8 f1 f0 ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047af:	8b 00                	mov    (%eax),%eax
801047b1:	39 d8                	cmp    %ebx,%eax
801047b3:	76 1b                	jbe    801047d0 <fetchint+0x30>
801047b5:	8d 53 04             	lea    0x4(%ebx),%edx
801047b8:	39 d0                	cmp    %edx,%eax
801047ba:	72 14                	jb     801047d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801047bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801047bf:	8b 13                	mov    (%ebx),%edx
801047c1:	89 10                	mov    %edx,(%eax)
  return 0;
801047c3:	31 c0                	xor    %eax,%eax
}
801047c5:	83 c4 04             	add    $0x4,%esp
801047c8:	5b                   	pop    %ebx
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    
801047cb:	90                   	nop
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801047d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047d5:	eb ee                	jmp    801047c5 <fetchint+0x25>
801047d7:	89 f6                	mov    %esi,%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	53                   	push   %ebx
801047e4:	83 ec 04             	sub    $0x4,%esp
801047e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801047ea:	e8 b1 f0 ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz)
801047ef:	39 18                	cmp    %ebx,(%eax)
801047f1:	76 29                	jbe    8010481c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047f6:	89 da                	mov    %ebx,%edx
801047f8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801047fa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801047fc:	39 c3                	cmp    %eax,%ebx
801047fe:	73 1c                	jae    8010481c <fetchstr+0x3c>
    if(*s == 0)
80104800:	80 3b 00             	cmpb   $0x0,(%ebx)
80104803:	75 10                	jne    80104815 <fetchstr+0x35>
80104805:	eb 29                	jmp    80104830 <fetchstr+0x50>
80104807:	89 f6                	mov    %esi,%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104810:	80 3a 00             	cmpb   $0x0,(%edx)
80104813:	74 1b                	je     80104830 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104815:	83 c2 01             	add    $0x1,%edx
80104818:	39 d0                	cmp    %edx,%eax
8010481a:	77 f4                	ja     80104810 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010481c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010481f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104824:	5b                   	pop    %ebx
80104825:	5d                   	pop    %ebp
80104826:	c3                   	ret    
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104830:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104833:	89 d0                	mov    %edx,%eax
80104835:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104837:	5b                   	pop    %ebx
80104838:	5d                   	pop    %ebp
80104839:	c3                   	ret    
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	56                   	push   %esi
80104844:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104845:	e8 56 f0 ff ff       	call   801038a0 <myproc>
8010484a:	8b 40 18             	mov    0x18(%eax),%eax
8010484d:	8b 55 08             	mov    0x8(%ebp),%edx
80104850:	8b 40 44             	mov    0x44(%eax),%eax
80104853:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104856:	e8 45 f0 ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010485b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010485d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104860:	39 c6                	cmp    %eax,%esi
80104862:	73 1c                	jae    80104880 <argint+0x40>
80104864:	8d 53 08             	lea    0x8(%ebx),%edx
80104867:	39 d0                	cmp    %edx,%eax
80104869:	72 15                	jb     80104880 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010486b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010486e:	8b 53 04             	mov    0x4(%ebx),%edx
80104871:	89 10                	mov    %edx,(%eax)
  return 0;
80104873:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104875:	5b                   	pop    %ebx
80104876:	5e                   	pop    %esi
80104877:	5d                   	pop    %ebp
80104878:	c3                   	ret    
80104879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104885:	eb ee                	jmp    80104875 <argint+0x35>
80104887:	89 f6                	mov    %esi,%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
80104895:	83 ec 10             	sub    $0x10,%esp
80104898:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010489b:	e8 00 f0 ff ff       	call   801038a0 <myproc>
801048a0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801048a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048a5:	83 ec 08             	sub    $0x8,%esp
801048a8:	50                   	push   %eax
801048a9:	ff 75 08             	pushl  0x8(%ebp)
801048ac:	e8 8f ff ff ff       	call   80104840 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801048b1:	c1 e8 1f             	shr    $0x1f,%eax
801048b4:	83 c4 10             	add    $0x10,%esp
801048b7:	84 c0                	test   %al,%al
801048b9:	75 2d                	jne    801048e8 <argptr+0x58>
801048bb:	89 d8                	mov    %ebx,%eax
801048bd:	c1 e8 1f             	shr    $0x1f,%eax
801048c0:	84 c0                	test   %al,%al
801048c2:	75 24                	jne    801048e8 <argptr+0x58>
801048c4:	8b 16                	mov    (%esi),%edx
801048c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048c9:	39 c2                	cmp    %eax,%edx
801048cb:	76 1b                	jbe    801048e8 <argptr+0x58>
801048cd:	01 c3                	add    %eax,%ebx
801048cf:	39 da                	cmp    %ebx,%edx
801048d1:	72 15                	jb     801048e8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801048d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801048d6:	89 02                	mov    %eax,(%edx)
  return 0;
801048d8:	31 c0                	xor    %eax,%eax
}
801048da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048dd:	5b                   	pop    %ebx
801048de:	5e                   	pop    %esi
801048df:	5d                   	pop    %ebp
801048e0:	c3                   	ret    
801048e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
801048e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048ed:	eb eb                	jmp    801048da <argptr+0x4a>
801048ef:	90                   	nop

801048f0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801048f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048f9:	50                   	push   %eax
801048fa:	ff 75 08             	pushl  0x8(%ebp)
801048fd:	e8 3e ff ff ff       	call   80104840 <argint>
80104902:	83 c4 10             	add    $0x10,%esp
80104905:	85 c0                	test   %eax,%eax
80104907:	78 17                	js     80104920 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104909:	83 ec 08             	sub    $0x8,%esp
8010490c:	ff 75 0c             	pushl  0xc(%ebp)
8010490f:	ff 75 f4             	pushl  -0xc(%ebp)
80104912:	e8 c9 fe ff ff       	call   801047e0 <fetchstr>
80104917:	83 c4 10             	add    $0x10,%esp
}
8010491a:	c9                   	leave  
8010491b:	c3                   	ret    
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104925:	c9                   	leave  
80104926:	c3                   	ret    
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <syscall>:
[SYS_num_pages]     sys_num_pages,
};

void
syscall(void)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104935:	e8 66 ef ff ff       	call   801038a0 <myproc>

  num = curproc->tf->eax;
8010493a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
8010493d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010493f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104942:	8d 50 ff             	lea    -0x1(%eax),%edx
80104945:	83 fa 17             	cmp    $0x17,%edx
80104948:	77 1e                	ja     80104968 <syscall+0x38>
8010494a:	8b 14 85 80 78 10 80 	mov    -0x7fef8780(,%eax,4),%edx
80104951:	85 d2                	test   %edx,%edx
80104953:	74 13                	je     80104968 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104955:	ff d2                	call   *%edx
80104957:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010495a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010495d:	5b                   	pop    %ebx
8010495e:	5e                   	pop    %esi
8010495f:	5d                   	pop    %ebp
80104960:	c3                   	ret    
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104968:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104969:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010496c:	50                   	push   %eax
8010496d:	ff 73 10             	pushl  0x10(%ebx)
80104970:	68 51 78 10 80       	push   $0x80107851
80104975:	e8 e6 bc ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
8010497a:	8b 43 18             	mov    0x18(%ebx),%eax
8010497d:	83 c4 10             	add    $0x10,%esp
80104980:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104987:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010498a:	5b                   	pop    %ebx
8010498b:	5e                   	pop    %esi
8010498c:	5d                   	pop    %ebp
8010498d:	c3                   	ret    
8010498e:	66 90                	xchg   %ax,%ax

80104990 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	57                   	push   %edi
80104994:	56                   	push   %esi
80104995:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104996:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104999:	83 ec 44             	sub    $0x44,%esp
8010499c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010499f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801049a2:	56                   	push   %esi
801049a3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801049a4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801049a7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801049aa:	e8 31 d5 ff ff       	call   80101ee0 <nameiparent>
801049af:	83 c4 10             	add    $0x10,%esp
801049b2:	85 c0                	test   %eax,%eax
801049b4:	0f 84 f6 00 00 00    	je     80104ab0 <create+0x120>
    return 0;
  ilock(dp);
801049ba:	83 ec 0c             	sub    $0xc,%esp
801049bd:	89 c7                	mov    %eax,%edi
801049bf:	50                   	push   %eax
801049c0:	e8 ab cc ff ff       	call   80101670 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801049c5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801049c8:	83 c4 0c             	add    $0xc,%esp
801049cb:	50                   	push   %eax
801049cc:	56                   	push   %esi
801049cd:	57                   	push   %edi
801049ce:	e8 cd d1 ff ff       	call   80101ba0 <dirlookup>
801049d3:	83 c4 10             	add    $0x10,%esp
801049d6:	85 c0                	test   %eax,%eax
801049d8:	89 c3                	mov    %eax,%ebx
801049da:	74 54                	je     80104a30 <create+0xa0>
    iunlockput(dp);
801049dc:	83 ec 0c             	sub    $0xc,%esp
801049df:	57                   	push   %edi
801049e0:	e8 1b cf ff ff       	call   80101900 <iunlockput>
    ilock(ip);
801049e5:	89 1c 24             	mov    %ebx,(%esp)
801049e8:	e8 83 cc ff ff       	call   80101670 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801049ed:	83 c4 10             	add    $0x10,%esp
801049f0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801049f5:	75 19                	jne    80104a10 <create+0x80>
801049f7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
801049fc:	89 d8                	mov    %ebx,%eax
801049fe:	75 10                	jne    80104a10 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a03:	5b                   	pop    %ebx
80104a04:	5e                   	pop    %esi
80104a05:	5f                   	pop    %edi
80104a06:	5d                   	pop    %ebp
80104a07:	c3                   	ret    
80104a08:	90                   	nop
80104a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104a10:	83 ec 0c             	sub    $0xc,%esp
80104a13:	53                   	push   %ebx
80104a14:	e8 e7 ce ff ff       	call   80101900 <iunlockput>
    return 0;
80104a19:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104a1f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a21:	5b                   	pop    %ebx
80104a22:	5e                   	pop    %esi
80104a23:	5f                   	pop    %edi
80104a24:	5d                   	pop    %ebp
80104a25:	c3                   	ret    
80104a26:	8d 76 00             	lea    0x0(%esi),%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104a30:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104a34:	83 ec 08             	sub    $0x8,%esp
80104a37:	50                   	push   %eax
80104a38:	ff 37                	pushl  (%edi)
80104a3a:	e8 c1 ca ff ff       	call   80101500 <ialloc>
80104a3f:	83 c4 10             	add    $0x10,%esp
80104a42:	85 c0                	test   %eax,%eax
80104a44:	89 c3                	mov    %eax,%ebx
80104a46:	0f 84 cc 00 00 00    	je     80104b18 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104a4c:	83 ec 0c             	sub    $0xc,%esp
80104a4f:	50                   	push   %eax
80104a50:	e8 1b cc ff ff       	call   80101670 <ilock>
  ip->major = major;
80104a55:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104a59:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104a5d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104a61:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104a65:	b8 01 00 00 00       	mov    $0x1,%eax
80104a6a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104a6e:	89 1c 24             	mov    %ebx,(%esp)
80104a71:	e8 4a cb ff ff       	call   801015c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104a76:	83 c4 10             	add    $0x10,%esp
80104a79:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104a7e:	74 40                	je     80104ac0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104a80:	83 ec 04             	sub    $0x4,%esp
80104a83:	ff 73 04             	pushl  0x4(%ebx)
80104a86:	56                   	push   %esi
80104a87:	57                   	push   %edi
80104a88:	e8 73 d3 ff ff       	call   80101e00 <dirlink>
80104a8d:	83 c4 10             	add    $0x10,%esp
80104a90:	85 c0                	test   %eax,%eax
80104a92:	78 77                	js     80104b0b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104a94:	83 ec 0c             	sub    $0xc,%esp
80104a97:	57                   	push   %edi
80104a98:	e8 63 ce ff ff       	call   80101900 <iunlockput>

  return ip;
80104a9d:	83 c4 10             	add    $0x10,%esp
}
80104aa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104aa3:	89 d8                	mov    %ebx,%eax
}
80104aa5:	5b                   	pop    %ebx
80104aa6:	5e                   	pop    %esi
80104aa7:	5f                   	pop    %edi
80104aa8:	5d                   	pop    %ebp
80104aa9:	c3                   	ret    
80104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104ab0:	31 c0                	xor    %eax,%eax
80104ab2:	e9 49 ff ff ff       	jmp    80104a00 <create+0x70>
80104ab7:	89 f6                	mov    %esi,%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104ac0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104ac5:	83 ec 0c             	sub    $0xc,%esp
80104ac8:	57                   	push   %edi
80104ac9:	e8 f2 ca ff ff       	call   801015c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104ace:	83 c4 0c             	add    $0xc,%esp
80104ad1:	ff 73 04             	pushl  0x4(%ebx)
80104ad4:	68 00 79 10 80       	push   $0x80107900
80104ad9:	53                   	push   %ebx
80104ada:	e8 21 d3 ff ff       	call   80101e00 <dirlink>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	78 18                	js     80104afe <create+0x16e>
80104ae6:	83 ec 04             	sub    $0x4,%esp
80104ae9:	ff 77 04             	pushl  0x4(%edi)
80104aec:	68 ff 78 10 80       	push   $0x801078ff
80104af1:	53                   	push   %ebx
80104af2:	e8 09 d3 ff ff       	call   80101e00 <dirlink>
80104af7:	83 c4 10             	add    $0x10,%esp
80104afa:	85 c0                	test   %eax,%eax
80104afc:	79 82                	jns    80104a80 <create+0xf0>
      panic("create dots");
80104afe:	83 ec 0c             	sub    $0xc,%esp
80104b01:	68 f3 78 10 80       	push   $0x801078f3
80104b06:	e8 65 b8 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104b0b:	83 ec 0c             	sub    $0xc,%esp
80104b0e:	68 02 79 10 80       	push   $0x80107902
80104b13:	e8 58 b8 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104b18:	83 ec 0c             	sub    $0xc,%esp
80104b1b:	68 e4 78 10 80       	push   $0x801078e4
80104b20:	e8 4b b8 ff ff       	call   80100370 <panic>
80104b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
80104b35:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104b37:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104b3a:	89 d3                	mov    %edx,%ebx
80104b3c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104b3f:	50                   	push   %eax
80104b40:	6a 00                	push   $0x0
80104b42:	e8 f9 fc ff ff       	call   80104840 <argint>
80104b47:	83 c4 10             	add    $0x10,%esp
80104b4a:	85 c0                	test   %eax,%eax
80104b4c:	78 32                	js     80104b80 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b4e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b52:	77 2c                	ja     80104b80 <argfd.constprop.0+0x50>
80104b54:	e8 47 ed ff ff       	call   801038a0 <myproc>
80104b59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b5c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b60:	85 c0                	test   %eax,%eax
80104b62:	74 1c                	je     80104b80 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104b64:	85 f6                	test   %esi,%esi
80104b66:	74 02                	je     80104b6a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104b68:	89 16                	mov    %edx,(%esi)
  if(pf)
80104b6a:	85 db                	test   %ebx,%ebx
80104b6c:	74 22                	je     80104b90 <argfd.constprop.0+0x60>
    *pf = f;
80104b6e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104b70:	31 c0                	xor    %eax,%eax
}
80104b72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b75:	5b                   	pop    %ebx
80104b76:	5e                   	pop    %esi
80104b77:	5d                   	pop    %ebp
80104b78:	c3                   	ret    
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b80:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104b83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104b88:	5b                   	pop    %ebx
80104b89:	5e                   	pop    %esi
80104b8a:	5d                   	pop    %ebp
80104b8b:	c3                   	ret    
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104b90:	31 c0                	xor    %eax,%eax
80104b92:	eb de                	jmp    80104b72 <argfd.constprop.0+0x42>
80104b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ba0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104ba0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104ba1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104ba3:	89 e5                	mov    %esp,%ebp
80104ba5:	56                   	push   %esi
80104ba6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104ba7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104baa:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104bad:	e8 7e ff ff ff       	call   80104b30 <argfd.constprop.0>
80104bb2:	85 c0                	test   %eax,%eax
80104bb4:	78 1a                	js     80104bd0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104bb6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104bb8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104bbb:	e8 e0 ec ff ff       	call   801038a0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104bc0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104bc4:	85 d2                	test   %edx,%edx
80104bc6:	74 18                	je     80104be0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104bc8:	83 c3 01             	add    $0x1,%ebx
80104bcb:	83 fb 10             	cmp    $0x10,%ebx
80104bce:	75 f0                	jne    80104bc0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104bd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104bd8:	5b                   	pop    %ebx
80104bd9:	5e                   	pop    %esi
80104bda:	5d                   	pop    %ebp
80104bdb:	c3                   	ret    
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104be0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104be4:	83 ec 0c             	sub    $0xc,%esp
80104be7:	ff 75 f4             	pushl  -0xc(%ebp)
80104bea:	e8 f1 c1 ff ff       	call   80100de0 <filedup>
  return fd;
80104bef:	83 c4 10             	add    $0x10,%esp
}
80104bf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104bf5:	89 d8                	mov    %ebx,%eax
}
80104bf7:	5b                   	pop    %ebx
80104bf8:	5e                   	pop    %esi
80104bf9:	5d                   	pop    %ebp
80104bfa:	c3                   	ret    
80104bfb:	90                   	nop
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c00 <sys_read>:

int
sys_read(void)
{
80104c00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c01:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104c03:	89 e5                	mov    %esp,%ebp
80104c05:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c0b:	e8 20 ff ff ff       	call   80104b30 <argfd.constprop.0>
80104c10:	85 c0                	test   %eax,%eax
80104c12:	78 4c                	js     80104c60 <sys_read+0x60>
80104c14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c17:	83 ec 08             	sub    $0x8,%esp
80104c1a:	50                   	push   %eax
80104c1b:	6a 02                	push   $0x2
80104c1d:	e8 1e fc ff ff       	call   80104840 <argint>
80104c22:	83 c4 10             	add    $0x10,%esp
80104c25:	85 c0                	test   %eax,%eax
80104c27:	78 37                	js     80104c60 <sys_read+0x60>
80104c29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c2c:	83 ec 04             	sub    $0x4,%esp
80104c2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c32:	50                   	push   %eax
80104c33:	6a 01                	push   $0x1
80104c35:	e8 56 fc ff ff       	call   80104890 <argptr>
80104c3a:	83 c4 10             	add    $0x10,%esp
80104c3d:	85 c0                	test   %eax,%eax
80104c3f:	78 1f                	js     80104c60 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104c41:	83 ec 04             	sub    $0x4,%esp
80104c44:	ff 75 f0             	pushl  -0x10(%ebp)
80104c47:	ff 75 f4             	pushl  -0xc(%ebp)
80104c4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c4d:	e8 fe c2 ff ff       	call   80100f50 <fileread>
80104c52:	83 c4 10             	add    $0x10,%esp
}
80104c55:	c9                   	leave  
80104c56:	c3                   	ret    
80104c57:	89 f6                	mov    %esi,%esi
80104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104c65:	c9                   	leave  
80104c66:	c3                   	ret    
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <sys_write>:

int
sys_write(void)
{
80104c70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c71:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104c73:	89 e5                	mov    %esp,%ebp
80104c75:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c7b:	e8 b0 fe ff ff       	call   80104b30 <argfd.constprop.0>
80104c80:	85 c0                	test   %eax,%eax
80104c82:	78 4c                	js     80104cd0 <sys_write+0x60>
80104c84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c87:	83 ec 08             	sub    $0x8,%esp
80104c8a:	50                   	push   %eax
80104c8b:	6a 02                	push   $0x2
80104c8d:	e8 ae fb ff ff       	call   80104840 <argint>
80104c92:	83 c4 10             	add    $0x10,%esp
80104c95:	85 c0                	test   %eax,%eax
80104c97:	78 37                	js     80104cd0 <sys_write+0x60>
80104c99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c9c:	83 ec 04             	sub    $0x4,%esp
80104c9f:	ff 75 f0             	pushl  -0x10(%ebp)
80104ca2:	50                   	push   %eax
80104ca3:	6a 01                	push   $0x1
80104ca5:	e8 e6 fb ff ff       	call   80104890 <argptr>
80104caa:	83 c4 10             	add    $0x10,%esp
80104cad:	85 c0                	test   %eax,%eax
80104caf:	78 1f                	js     80104cd0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104cb1:	83 ec 04             	sub    $0x4,%esp
80104cb4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cb7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cba:	ff 75 ec             	pushl  -0x14(%ebp)
80104cbd:	e8 1e c3 ff ff       	call   80100fe0 <filewrite>
80104cc2:	83 c4 10             	add    $0x10,%esp
}
80104cc5:	c9                   	leave  
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_close>:

int
sys_close(void)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104ce6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ce9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cec:	e8 3f fe ff ff       	call   80104b30 <argfd.constprop.0>
80104cf1:	85 c0                	test   %eax,%eax
80104cf3:	78 2b                	js     80104d20 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104cf5:	e8 a6 eb ff ff       	call   801038a0 <myproc>
80104cfa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104cfd:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104d00:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d07:	00 
  fileclose(f);
80104d08:	ff 75 f4             	pushl  -0xc(%ebp)
80104d0b:	e8 20 c1 ff ff       	call   80100e30 <fileclose>
  return 0;
80104d10:	83 c4 10             	add    $0x10,%esp
80104d13:	31 c0                	xor    %eax,%eax
}
80104d15:	c9                   	leave  
80104d16:	c3                   	ret    
80104d17:	89 f6                	mov    %esi,%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104d25:	c9                   	leave  
80104d26:	c3                   	ret    
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <sys_fstat>:

int
sys_fstat(void)
{
80104d30:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d31:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104d38:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d3b:	e8 f0 fd ff ff       	call   80104b30 <argfd.constprop.0>
80104d40:	85 c0                	test   %eax,%eax
80104d42:	78 2c                	js     80104d70 <sys_fstat+0x40>
80104d44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d47:	83 ec 04             	sub    $0x4,%esp
80104d4a:	6a 14                	push   $0x14
80104d4c:	50                   	push   %eax
80104d4d:	6a 01                	push   $0x1
80104d4f:	e8 3c fb ff ff       	call   80104890 <argptr>
80104d54:	83 c4 10             	add    $0x10,%esp
80104d57:	85 c0                	test   %eax,%eax
80104d59:	78 15                	js     80104d70 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104d5b:	83 ec 08             	sub    $0x8,%esp
80104d5e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d61:	ff 75 f0             	pushl  -0x10(%ebp)
80104d64:	e8 97 c1 ff ff       	call   80100f00 <filestat>
80104d69:	83 c4 10             	add    $0x10,%esp
}
80104d6c:	c9                   	leave  
80104d6d:	c3                   	ret    
80104d6e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d80 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	56                   	push   %esi
80104d85:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d86:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104d89:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d8c:	50                   	push   %eax
80104d8d:	6a 00                	push   $0x0
80104d8f:	e8 5c fb ff ff       	call   801048f0 <argstr>
80104d94:	83 c4 10             	add    $0x10,%esp
80104d97:	85 c0                	test   %eax,%eax
80104d99:	0f 88 fb 00 00 00    	js     80104e9a <sys_link+0x11a>
80104d9f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104da2:	83 ec 08             	sub    $0x8,%esp
80104da5:	50                   	push   %eax
80104da6:	6a 01                	push   $0x1
80104da8:	e8 43 fb ff ff       	call   801048f0 <argstr>
80104dad:	83 c4 10             	add    $0x10,%esp
80104db0:	85 c0                	test   %eax,%eax
80104db2:	0f 88 e2 00 00 00    	js     80104e9a <sys_link+0x11a>
    return -1;

  begin_op();
80104db8:	e8 b3 de ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
80104dbd:	83 ec 0c             	sub    $0xc,%esp
80104dc0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104dc3:	e8 f8 d0 ff ff       	call   80101ec0 <namei>
80104dc8:	83 c4 10             	add    $0x10,%esp
80104dcb:	85 c0                	test   %eax,%eax
80104dcd:	89 c3                	mov    %eax,%ebx
80104dcf:	0f 84 f3 00 00 00    	je     80104ec8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104dd5:	83 ec 0c             	sub    $0xc,%esp
80104dd8:	50                   	push   %eax
80104dd9:	e8 92 c8 ff ff       	call   80101670 <ilock>
  if(ip->type == T_DIR){
80104dde:	83 c4 10             	add    $0x10,%esp
80104de1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104de6:	0f 84 c4 00 00 00    	je     80104eb0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104dec:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104df1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104df4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104df7:	53                   	push   %ebx
80104df8:	e8 c3 c7 ff ff       	call   801015c0 <iupdate>
  iunlock(ip);
80104dfd:	89 1c 24             	mov    %ebx,(%esp)
80104e00:	e8 4b c9 ff ff       	call   80101750 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104e05:	58                   	pop    %eax
80104e06:	5a                   	pop    %edx
80104e07:	57                   	push   %edi
80104e08:	ff 75 d0             	pushl  -0x30(%ebp)
80104e0b:	e8 d0 d0 ff ff       	call   80101ee0 <nameiparent>
80104e10:	83 c4 10             	add    $0x10,%esp
80104e13:	85 c0                	test   %eax,%eax
80104e15:	89 c6                	mov    %eax,%esi
80104e17:	74 5b                	je     80104e74 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104e19:	83 ec 0c             	sub    $0xc,%esp
80104e1c:	50                   	push   %eax
80104e1d:	e8 4e c8 ff ff       	call   80101670 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	8b 03                	mov    (%ebx),%eax
80104e27:	39 06                	cmp    %eax,(%esi)
80104e29:	75 3d                	jne    80104e68 <sys_link+0xe8>
80104e2b:	83 ec 04             	sub    $0x4,%esp
80104e2e:	ff 73 04             	pushl  0x4(%ebx)
80104e31:	57                   	push   %edi
80104e32:	56                   	push   %esi
80104e33:	e8 c8 cf ff ff       	call   80101e00 <dirlink>
80104e38:	83 c4 10             	add    $0x10,%esp
80104e3b:	85 c0                	test   %eax,%eax
80104e3d:	78 29                	js     80104e68 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104e3f:	83 ec 0c             	sub    $0xc,%esp
80104e42:	56                   	push   %esi
80104e43:	e8 b8 ca ff ff       	call   80101900 <iunlockput>
  iput(ip);
80104e48:	89 1c 24             	mov    %ebx,(%esp)
80104e4b:	e8 50 c9 ff ff       	call   801017a0 <iput>

  end_op();
80104e50:	e8 8b de ff ff       	call   80102ce0 <end_op>

  return 0;
80104e55:	83 c4 10             	add    $0x10,%esp
80104e58:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104e5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e5d:	5b                   	pop    %ebx
80104e5e:	5e                   	pop    %esi
80104e5f:	5f                   	pop    %edi
80104e60:	5d                   	pop    %ebp
80104e61:	c3                   	ret    
80104e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104e68:	83 ec 0c             	sub    $0xc,%esp
80104e6b:	56                   	push   %esi
80104e6c:	e8 8f ca ff ff       	call   80101900 <iunlockput>
    goto bad;
80104e71:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	53                   	push   %ebx
80104e78:	e8 f3 c7 ff ff       	call   80101670 <ilock>
  ip->nlink--;
80104e7d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e82:	89 1c 24             	mov    %ebx,(%esp)
80104e85:	e8 36 c7 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
80104e8a:	89 1c 24             	mov    %ebx,(%esp)
80104e8d:	e8 6e ca ff ff       	call   80101900 <iunlockput>
  end_op();
80104e92:	e8 49 de ff ff       	call   80102ce0 <end_op>
  return -1;
80104e97:	83 c4 10             	add    $0x10,%esp
}
80104e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104e9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ea2:	5b                   	pop    %ebx
80104ea3:	5e                   	pop    %esi
80104ea4:	5f                   	pop    %edi
80104ea5:	5d                   	pop    %ebp
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104eb0:	83 ec 0c             	sub    $0xc,%esp
80104eb3:	53                   	push   %ebx
80104eb4:	e8 47 ca ff ff       	call   80101900 <iunlockput>
    end_op();
80104eb9:	e8 22 de ff ff       	call   80102ce0 <end_op>
    return -1;
80104ebe:	83 c4 10             	add    $0x10,%esp
80104ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ec6:	eb 92                	jmp    80104e5a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104ec8:	e8 13 de ff ff       	call   80102ce0 <end_op>
    return -1;
80104ecd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ed2:	eb 86                	jmp    80104e5a <sys_link+0xda>
80104ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ee0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	57                   	push   %edi
80104ee4:	56                   	push   %esi
80104ee5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104ee6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104ee9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104eec:	50                   	push   %eax
80104eed:	6a 00                	push   $0x0
80104eef:	e8 fc f9 ff ff       	call   801048f0 <argstr>
80104ef4:	83 c4 10             	add    $0x10,%esp
80104ef7:	85 c0                	test   %eax,%eax
80104ef9:	0f 88 82 01 00 00    	js     80105081 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104eff:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104f02:	e8 69 dd ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f07:	83 ec 08             	sub    $0x8,%esp
80104f0a:	53                   	push   %ebx
80104f0b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f0e:	e8 cd cf ff ff       	call   80101ee0 <nameiparent>
80104f13:	83 c4 10             	add    $0x10,%esp
80104f16:	85 c0                	test   %eax,%eax
80104f18:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f1b:	0f 84 6a 01 00 00    	je     8010508b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104f21:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104f24:	83 ec 0c             	sub    $0xc,%esp
80104f27:	56                   	push   %esi
80104f28:	e8 43 c7 ff ff       	call   80101670 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104f2d:	58                   	pop    %eax
80104f2e:	5a                   	pop    %edx
80104f2f:	68 00 79 10 80       	push   $0x80107900
80104f34:	53                   	push   %ebx
80104f35:	e8 46 cc ff ff       	call   80101b80 <namecmp>
80104f3a:	83 c4 10             	add    $0x10,%esp
80104f3d:	85 c0                	test   %eax,%eax
80104f3f:	0f 84 fc 00 00 00    	je     80105041 <sys_unlink+0x161>
80104f45:	83 ec 08             	sub    $0x8,%esp
80104f48:	68 ff 78 10 80       	push   $0x801078ff
80104f4d:	53                   	push   %ebx
80104f4e:	e8 2d cc ff ff       	call   80101b80 <namecmp>
80104f53:	83 c4 10             	add    $0x10,%esp
80104f56:	85 c0                	test   %eax,%eax
80104f58:	0f 84 e3 00 00 00    	je     80105041 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104f5e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f61:	83 ec 04             	sub    $0x4,%esp
80104f64:	50                   	push   %eax
80104f65:	53                   	push   %ebx
80104f66:	56                   	push   %esi
80104f67:	e8 34 cc ff ff       	call   80101ba0 <dirlookup>
80104f6c:	83 c4 10             	add    $0x10,%esp
80104f6f:	85 c0                	test   %eax,%eax
80104f71:	89 c3                	mov    %eax,%ebx
80104f73:	0f 84 c8 00 00 00    	je     80105041 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104f79:	83 ec 0c             	sub    $0xc,%esp
80104f7c:	50                   	push   %eax
80104f7d:	e8 ee c6 ff ff       	call   80101670 <ilock>

  if(ip->nlink < 1)
80104f82:	83 c4 10             	add    $0x10,%esp
80104f85:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f8a:	0f 8e 24 01 00 00    	jle    801050b4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f90:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f95:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104f98:	74 66                	je     80105000 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104f9a:	83 ec 04             	sub    $0x4,%esp
80104f9d:	6a 10                	push   $0x10
80104f9f:	6a 00                	push   $0x0
80104fa1:	56                   	push   %esi
80104fa2:	e8 89 f5 ff ff       	call   80104530 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104fa7:	6a 10                	push   $0x10
80104fa9:	ff 75 c4             	pushl  -0x3c(%ebp)
80104fac:	56                   	push   %esi
80104fad:	ff 75 b4             	pushl  -0x4c(%ebp)
80104fb0:	e8 9b ca ff ff       	call   80101a50 <writei>
80104fb5:	83 c4 20             	add    $0x20,%esp
80104fb8:	83 f8 10             	cmp    $0x10,%eax
80104fbb:	0f 85 e6 00 00 00    	jne    801050a7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104fc1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fc6:	0f 84 9c 00 00 00    	je     80105068 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104fcc:	83 ec 0c             	sub    $0xc,%esp
80104fcf:	ff 75 b4             	pushl  -0x4c(%ebp)
80104fd2:	e8 29 c9 ff ff       	call   80101900 <iunlockput>

  ip->nlink--;
80104fd7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fdc:	89 1c 24             	mov    %ebx,(%esp)
80104fdf:	e8 dc c5 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
80104fe4:	89 1c 24             	mov    %ebx,(%esp)
80104fe7:	e8 14 c9 ff ff       	call   80101900 <iunlockput>

  end_op();
80104fec:	e8 ef dc ff ff       	call   80102ce0 <end_op>

  return 0;
80104ff1:	83 c4 10             	add    $0x10,%esp
80104ff4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ff9:	5b                   	pop    %ebx
80104ffa:	5e                   	pop    %esi
80104ffb:	5f                   	pop    %edi
80104ffc:	5d                   	pop    %ebp
80104ffd:	c3                   	ret    
80104ffe:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105000:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105004:	76 94                	jbe    80104f9a <sys_unlink+0xba>
80105006:	bf 20 00 00 00       	mov    $0x20,%edi
8010500b:	eb 0f                	jmp    8010501c <sys_unlink+0x13c>
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
80105010:	83 c7 10             	add    $0x10,%edi
80105013:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105016:	0f 83 7e ff ff ff    	jae    80104f9a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010501c:	6a 10                	push   $0x10
8010501e:	57                   	push   %edi
8010501f:	56                   	push   %esi
80105020:	53                   	push   %ebx
80105021:	e8 2a c9 ff ff       	call   80101950 <readi>
80105026:	83 c4 10             	add    $0x10,%esp
80105029:	83 f8 10             	cmp    $0x10,%eax
8010502c:	75 6c                	jne    8010509a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010502e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105033:	74 db                	je     80105010 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105035:	83 ec 0c             	sub    $0xc,%esp
80105038:	53                   	push   %ebx
80105039:	e8 c2 c8 ff ff       	call   80101900 <iunlockput>
    goto bad;
8010503e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105041:	83 ec 0c             	sub    $0xc,%esp
80105044:	ff 75 b4             	pushl  -0x4c(%ebp)
80105047:	e8 b4 c8 ff ff       	call   80101900 <iunlockput>
  end_op();
8010504c:	e8 8f dc ff ff       	call   80102ce0 <end_op>
  return -1;
80105051:	83 c4 10             	add    $0x10,%esp
}
80105054:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105057:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010505c:	5b                   	pop    %ebx
8010505d:	5e                   	pop    %esi
8010505e:	5f                   	pop    %edi
8010505f:	5d                   	pop    %ebp
80105060:	c3                   	ret    
80105061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105068:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010506b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010506e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105073:	50                   	push   %eax
80105074:	e8 47 c5 ff ff       	call   801015c0 <iupdate>
80105079:	83 c4 10             	add    $0x10,%esp
8010507c:	e9 4b ff ff ff       	jmp    80104fcc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105086:	e9 6b ff ff ff       	jmp    80104ff6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010508b:	e8 50 dc ff ff       	call   80102ce0 <end_op>
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105095:	e9 5c ff ff ff       	jmp    80104ff6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010509a:	83 ec 0c             	sub    $0xc,%esp
8010509d:	68 24 79 10 80       	push   $0x80107924
801050a2:	e8 c9 b2 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801050a7:	83 ec 0c             	sub    $0xc,%esp
801050aa:	68 36 79 10 80       	push   $0x80107936
801050af:	e8 bc b2 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	68 12 79 10 80       	push   $0x80107912
801050bc:	e8 af b2 ff ff       	call   80100370 <panic>
801050c1:	eb 0d                	jmp    801050d0 <sys_open>
801050c3:	90                   	nop
801050c4:	90                   	nop
801050c5:	90                   	nop
801050c6:	90                   	nop
801050c7:	90                   	nop
801050c8:	90                   	nop
801050c9:	90                   	nop
801050ca:	90                   	nop
801050cb:	90                   	nop
801050cc:	90                   	nop
801050cd:	90                   	nop
801050ce:	90                   	nop
801050cf:	90                   	nop

801050d0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	57                   	push   %edi
801050d4:	56                   	push   %esi
801050d5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050d6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801050d9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801050dc:	50                   	push   %eax
801050dd:	6a 00                	push   $0x0
801050df:	e8 0c f8 ff ff       	call   801048f0 <argstr>
801050e4:	83 c4 10             	add    $0x10,%esp
801050e7:	85 c0                	test   %eax,%eax
801050e9:	0f 88 9e 00 00 00    	js     8010518d <sys_open+0xbd>
801050ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801050f2:	83 ec 08             	sub    $0x8,%esp
801050f5:	50                   	push   %eax
801050f6:	6a 01                	push   $0x1
801050f8:	e8 43 f7 ff ff       	call   80104840 <argint>
801050fd:	83 c4 10             	add    $0x10,%esp
80105100:	85 c0                	test   %eax,%eax
80105102:	0f 88 85 00 00 00    	js     8010518d <sys_open+0xbd>
    return -1;

  begin_op();
80105108:	e8 63 db ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
8010510d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105111:	0f 85 89 00 00 00    	jne    801051a0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105117:	83 ec 0c             	sub    $0xc,%esp
8010511a:	ff 75 e0             	pushl  -0x20(%ebp)
8010511d:	e8 9e cd ff ff       	call   80101ec0 <namei>
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	85 c0                	test   %eax,%eax
80105127:	89 c6                	mov    %eax,%esi
80105129:	0f 84 8e 00 00 00    	je     801051bd <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010512f:	83 ec 0c             	sub    $0xc,%esp
80105132:	50                   	push   %eax
80105133:	e8 38 c5 ff ff       	call   80101670 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105138:	83 c4 10             	add    $0x10,%esp
8010513b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105140:	0f 84 d2 00 00 00    	je     80105218 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105146:	e8 25 bc ff ff       	call   80100d70 <filealloc>
8010514b:	85 c0                	test   %eax,%eax
8010514d:	89 c7                	mov    %eax,%edi
8010514f:	74 2b                	je     8010517c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105151:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105153:	e8 48 e7 ff ff       	call   801038a0 <myproc>
80105158:	90                   	nop
80105159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105160:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105164:	85 d2                	test   %edx,%edx
80105166:	74 68                	je     801051d0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105168:	83 c3 01             	add    $0x1,%ebx
8010516b:	83 fb 10             	cmp    $0x10,%ebx
8010516e:	75 f0                	jne    80105160 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105170:	83 ec 0c             	sub    $0xc,%esp
80105173:	57                   	push   %edi
80105174:	e8 b7 bc ff ff       	call   80100e30 <fileclose>
80105179:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010517c:	83 ec 0c             	sub    $0xc,%esp
8010517f:	56                   	push   %esi
80105180:	e8 7b c7 ff ff       	call   80101900 <iunlockput>
    end_op();
80105185:	e8 56 db ff ff       	call   80102ce0 <end_op>
    return -1;
8010518a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010518d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105195:	5b                   	pop    %ebx
80105196:	5e                   	pop    %esi
80105197:	5f                   	pop    %edi
80105198:	5d                   	pop    %ebp
80105199:	c3                   	ret    
8010519a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801051a0:	83 ec 0c             	sub    $0xc,%esp
801051a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801051a6:	31 c9                	xor    %ecx,%ecx
801051a8:	6a 00                	push   $0x0
801051aa:	ba 02 00 00 00       	mov    $0x2,%edx
801051af:	e8 dc f7 ff ff       	call   80104990 <create>
    if(ip == 0){
801051b4:	83 c4 10             	add    $0x10,%esp
801051b7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801051b9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801051bb:	75 89                	jne    80105146 <sys_open+0x76>
      end_op();
801051bd:	e8 1e db ff ff       	call   80102ce0 <end_op>
      return -1;
801051c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051c7:	eb 43                	jmp    8010520c <sys_open+0x13c>
801051c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051d0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801051d3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051d7:	56                   	push   %esi
801051d8:	e8 73 c5 ff ff       	call   80101750 <iunlock>
  end_op();
801051dd:	e8 fe da ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
801051e2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801051e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051eb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801051ee:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801051f1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801051f8:	89 d0                	mov    %edx,%eax
801051fa:	83 e0 01             	and    $0x1,%eax
801051fd:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105200:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105203:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105206:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010520a:	89 d8                	mov    %ebx,%eax
}
8010520c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010520f:	5b                   	pop    %ebx
80105210:	5e                   	pop    %esi
80105211:	5f                   	pop    %edi
80105212:	5d                   	pop    %ebp
80105213:	c3                   	ret    
80105214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105218:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010521b:	85 c9                	test   %ecx,%ecx
8010521d:	0f 84 23 ff ff ff    	je     80105146 <sys_open+0x76>
80105223:	e9 54 ff ff ff       	jmp    8010517c <sys_open+0xac>
80105228:	90                   	nop
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105230 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105236:	e8 35 da ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010523b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010523e:	83 ec 08             	sub    $0x8,%esp
80105241:	50                   	push   %eax
80105242:	6a 00                	push   $0x0
80105244:	e8 a7 f6 ff ff       	call   801048f0 <argstr>
80105249:	83 c4 10             	add    $0x10,%esp
8010524c:	85 c0                	test   %eax,%eax
8010524e:	78 30                	js     80105280 <sys_mkdir+0x50>
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105256:	31 c9                	xor    %ecx,%ecx
80105258:	6a 00                	push   $0x0
8010525a:	ba 01 00 00 00       	mov    $0x1,%edx
8010525f:	e8 2c f7 ff ff       	call   80104990 <create>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	74 15                	je     80105280 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010526b:	83 ec 0c             	sub    $0xc,%esp
8010526e:	50                   	push   %eax
8010526f:	e8 8c c6 ff ff       	call   80101900 <iunlockput>
  end_op();
80105274:	e8 67 da ff ff       	call   80102ce0 <end_op>
  return 0;
80105279:	83 c4 10             	add    $0x10,%esp
8010527c:	31 c0                	xor    %eax,%eax
}
8010527e:	c9                   	leave  
8010527f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105280:	e8 5b da ff ff       	call   80102ce0 <end_op>
    return -1;
80105285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010528a:	c9                   	leave  
8010528b:	c3                   	ret    
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105290 <sys_mknod>:

int
sys_mknod(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105296:	e8 d5 d9 ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010529b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010529e:	83 ec 08             	sub    $0x8,%esp
801052a1:	50                   	push   %eax
801052a2:	6a 00                	push   $0x0
801052a4:	e8 47 f6 ff ff       	call   801048f0 <argstr>
801052a9:	83 c4 10             	add    $0x10,%esp
801052ac:	85 c0                	test   %eax,%eax
801052ae:	78 60                	js     80105310 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801052b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b3:	83 ec 08             	sub    $0x8,%esp
801052b6:	50                   	push   %eax
801052b7:	6a 01                	push   $0x1
801052b9:	e8 82 f5 ff ff       	call   80104840 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801052be:	83 c4 10             	add    $0x10,%esp
801052c1:	85 c0                	test   %eax,%eax
801052c3:	78 4b                	js     80105310 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801052c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052c8:	83 ec 08             	sub    $0x8,%esp
801052cb:	50                   	push   %eax
801052cc:	6a 02                	push   $0x2
801052ce:	e8 6d f5 ff ff       	call   80104840 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801052d3:	83 c4 10             	add    $0x10,%esp
801052d6:	85 c0                	test   %eax,%eax
801052d8:	78 36                	js     80105310 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801052da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801052de:	83 ec 0c             	sub    $0xc,%esp
801052e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801052e5:	ba 03 00 00 00       	mov    $0x3,%edx
801052ea:	50                   	push   %eax
801052eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052ee:	e8 9d f6 ff ff       	call   80104990 <create>
801052f3:	83 c4 10             	add    $0x10,%esp
801052f6:	85 c0                	test   %eax,%eax
801052f8:	74 16                	je     80105310 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801052fa:	83 ec 0c             	sub    $0xc,%esp
801052fd:	50                   	push   %eax
801052fe:	e8 fd c5 ff ff       	call   80101900 <iunlockput>
  end_op();
80105303:	e8 d8 d9 ff ff       	call   80102ce0 <end_op>
  return 0;
80105308:	83 c4 10             	add    $0x10,%esp
8010530b:	31 c0                	xor    %eax,%eax
}
8010530d:	c9                   	leave  
8010530e:	c3                   	ret    
8010530f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105310:	e8 cb d9 ff ff       	call   80102ce0 <end_op>
    return -1;
80105315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010531a:	c9                   	leave  
8010531b:	c3                   	ret    
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_chdir>:

int
sys_chdir(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
80105325:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105328:	e8 73 e5 ff ff       	call   801038a0 <myproc>
8010532d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010532f:	e8 3c d9 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105334:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105337:	83 ec 08             	sub    $0x8,%esp
8010533a:	50                   	push   %eax
8010533b:	6a 00                	push   $0x0
8010533d:	e8 ae f5 ff ff       	call   801048f0 <argstr>
80105342:	83 c4 10             	add    $0x10,%esp
80105345:	85 c0                	test   %eax,%eax
80105347:	78 77                	js     801053c0 <sys_chdir+0xa0>
80105349:	83 ec 0c             	sub    $0xc,%esp
8010534c:	ff 75 f4             	pushl  -0xc(%ebp)
8010534f:	e8 6c cb ff ff       	call   80101ec0 <namei>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	89 c3                	mov    %eax,%ebx
8010535b:	74 63                	je     801053c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010535d:	83 ec 0c             	sub    $0xc,%esp
80105360:	50                   	push   %eax
80105361:	e8 0a c3 ff ff       	call   80101670 <ilock>
  if(ip->type != T_DIR){
80105366:	83 c4 10             	add    $0x10,%esp
80105369:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010536e:	75 30                	jne    801053a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	53                   	push   %ebx
80105374:	e8 d7 c3 ff ff       	call   80101750 <iunlock>
  iput(curproc->cwd);
80105379:	58                   	pop    %eax
8010537a:	ff 76 68             	pushl  0x68(%esi)
8010537d:	e8 1e c4 ff ff       	call   801017a0 <iput>
  end_op();
80105382:	e8 59 d9 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
80105387:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010538a:	83 c4 10             	add    $0x10,%esp
8010538d:	31 c0                	xor    %eax,%eax
}
8010538f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105392:	5b                   	pop    %ebx
80105393:	5e                   	pop    %esi
80105394:	5d                   	pop    %ebp
80105395:	c3                   	ret    
80105396:	8d 76 00             	lea    0x0(%esi),%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	53                   	push   %ebx
801053a4:	e8 57 c5 ff ff       	call   80101900 <iunlockput>
    end_op();
801053a9:	e8 32 d9 ff ff       	call   80102ce0 <end_op>
    return -1;
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053b6:	eb d7                	jmp    8010538f <sys_chdir+0x6f>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801053c0:	e8 1b d9 ff ff       	call   80102ce0 <end_op>
    return -1;
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ca:	eb c3                	jmp    8010538f <sys_chdir+0x6f>
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053d0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	57                   	push   %edi
801053d4:	56                   	push   %esi
801053d5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053d6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801053dc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801053e2:	50                   	push   %eax
801053e3:	6a 00                	push   $0x0
801053e5:	e8 06 f5 ff ff       	call   801048f0 <argstr>
801053ea:	83 c4 10             	add    $0x10,%esp
801053ed:	85 c0                	test   %eax,%eax
801053ef:	78 7f                	js     80105470 <sys_exec+0xa0>
801053f1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801053f7:	83 ec 08             	sub    $0x8,%esp
801053fa:	50                   	push   %eax
801053fb:	6a 01                	push   $0x1
801053fd:	e8 3e f4 ff ff       	call   80104840 <argint>
80105402:	83 c4 10             	add    $0x10,%esp
80105405:	85 c0                	test   %eax,%eax
80105407:	78 67                	js     80105470 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105409:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010540f:	83 ec 04             	sub    $0x4,%esp
80105412:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105418:	68 80 00 00 00       	push   $0x80
8010541d:	6a 00                	push   $0x0
8010541f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105425:	50                   	push   %eax
80105426:	31 db                	xor    %ebx,%ebx
80105428:	e8 03 f1 ff ff       	call   80104530 <memset>
8010542d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105430:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105436:	83 ec 08             	sub    $0x8,%esp
80105439:	57                   	push   %edi
8010543a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010543d:	50                   	push   %eax
8010543e:	e8 5d f3 ff ff       	call   801047a0 <fetchint>
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	78 26                	js     80105470 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010544a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105450:	85 c0                	test   %eax,%eax
80105452:	74 2c                	je     80105480 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105454:	83 ec 08             	sub    $0x8,%esp
80105457:	56                   	push   %esi
80105458:	50                   	push   %eax
80105459:	e8 82 f3 ff ff       	call   801047e0 <fetchstr>
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	85 c0                	test   %eax,%eax
80105463:	78 0b                	js     80105470 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105465:	83 c3 01             	add    $0x1,%ebx
80105468:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010546b:	83 fb 20             	cmp    $0x20,%ebx
8010546e:	75 c0                	jne    80105430 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105470:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105473:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105478:	5b                   	pop    %ebx
80105479:	5e                   	pop    %esi
8010547a:	5f                   	pop    %edi
8010547b:	5d                   	pop    %ebp
8010547c:	c3                   	ret    
8010547d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105480:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105486:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105489:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105490:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105494:	50                   	push   %eax
80105495:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010549b:	e8 50 b5 ff ff       	call   801009f0 <exec>
801054a0:	83 c4 10             	add    $0x10,%esp
}
801054a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054a6:	5b                   	pop    %ebx
801054a7:	5e                   	pop    %esi
801054a8:	5f                   	pop    %edi
801054a9:	5d                   	pop    %ebp
801054aa:	c3                   	ret    
801054ab:	90                   	nop
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_pipe>:

int
sys_pipe(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	57                   	push   %edi
801054b4:	56                   	push   %esi
801054b5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801054b6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801054b9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801054bc:	6a 08                	push   $0x8
801054be:	50                   	push   %eax
801054bf:	6a 00                	push   $0x0
801054c1:	e8 ca f3 ff ff       	call   80104890 <argptr>
801054c6:	83 c4 10             	add    $0x10,%esp
801054c9:	85 c0                	test   %eax,%eax
801054cb:	78 4a                	js     80105517 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801054cd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054d0:	83 ec 08             	sub    $0x8,%esp
801054d3:	50                   	push   %eax
801054d4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801054d7:	50                   	push   %eax
801054d8:	e8 33 de ff ff       	call   80103310 <pipealloc>
801054dd:	83 c4 10             	add    $0x10,%esp
801054e0:	85 c0                	test   %eax,%eax
801054e2:	78 33                	js     80105517 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801054e4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054e6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801054e9:	e8 b2 e3 ff ff       	call   801038a0 <myproc>
801054ee:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801054f0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801054f4:	85 f6                	test   %esi,%esi
801054f6:	74 30                	je     80105528 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801054f8:	83 c3 01             	add    $0x1,%ebx
801054fb:	83 fb 10             	cmp    $0x10,%ebx
801054fe:	75 f0                	jne    801054f0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	ff 75 e0             	pushl  -0x20(%ebp)
80105506:	e8 25 b9 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010550b:	58                   	pop    %eax
8010550c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010550f:	e8 1c b9 ff ff       	call   80100e30 <fileclose>
    return -1;
80105514:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105517:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010551a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010551f:	5b                   	pop    %ebx
80105520:	5e                   	pop    %esi
80105521:	5f                   	pop    %edi
80105522:	5d                   	pop    %ebp
80105523:	c3                   	ret    
80105524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105528:	8d 73 08             	lea    0x8(%ebx),%esi
8010552b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010552f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105532:	e8 69 e3 ff ff       	call   801038a0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105537:	31 d2                	xor    %edx,%edx
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105540:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105544:	85 c9                	test   %ecx,%ecx
80105546:	74 18                	je     80105560 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105548:	83 c2 01             	add    $0x1,%edx
8010554b:	83 fa 10             	cmp    $0x10,%edx
8010554e:	75 f0                	jne    80105540 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105550:	e8 4b e3 ff ff       	call   801038a0 <myproc>
80105555:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010555c:	00 
8010555d:	eb a1                	jmp    80105500 <sys_pipe+0x50>
8010555f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105560:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105564:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105567:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105569:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010556c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010556f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105572:	31 c0                	xor    %eax,%eax
}
80105574:	5b                   	pop    %ebx
80105575:	5e                   	pop    %esi
80105576:	5f                   	pop    %edi
80105577:	5d                   	pop    %ebp
80105578:	c3                   	ret    
80105579:	66 90                	xchg   %ax,%ax
8010557b:	66 90                	xchg   %ax,%ax
8010557d:	66 90                	xchg   %ax,%ax
8010557f:	90                   	nop

80105580 <sys_fork>:
#include "mmu.h"
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105583:	5d                   	pop    %ebp
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
  return fork();
80105584:	e9 b7 e4 ff ff       	jmp    80103a40 <fork>
80105589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_exit>:
}

int
sys_exit(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 08             	sub    $0x8,%esp
  exit();
80105596:	e8 35 e7 ff ff       	call   80103cd0 <exit>
  return 0;  // not reached
}
8010559b:	31 c0                	xor    %eax,%eax
8010559d:	c9                   	leave  
8010559e:	c3                   	ret    
8010559f:	90                   	nop

801055a0 <sys_wait>:

int
sys_wait(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801055a3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801055a4:	e9 67 e9 ff ff       	jmp    80103f10 <wait>
801055a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055b0 <sys_kill>:
}

int
sys_kill(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801055b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055b9:	50                   	push   %eax
801055ba:	6a 00                	push   $0x0
801055bc:	e8 7f f2 ff ff       	call   80104840 <argint>
801055c1:	83 c4 10             	add    $0x10,%esp
801055c4:	85 c0                	test   %eax,%eax
801055c6:	78 18                	js     801055e0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801055c8:	83 ec 0c             	sub    $0xc,%esp
801055cb:	ff 75 f4             	pushl  -0xc(%ebp)
801055ce:	e8 8d ea ff ff       	call   80104060 <kill>
801055d3:	83 c4 10             	add    $0x10,%esp
}
801055d6:	c9                   	leave  
801055d7:	c3                   	ret    
801055d8:	90                   	nop
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801055e5:	c9                   	leave  
801055e6:	c3                   	ret    
801055e7:	89 f6                	mov    %esi,%esi
801055e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055f0 <sys_getpid>:

int
sys_getpid(void)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801055f6:	e8 a5 e2 ff ff       	call   801038a0 <myproc>
801055fb:	8b 40 10             	mov    0x10(%eax),%eax
}
801055fe:	c9                   	leave  
801055ff:	c3                   	ret    

80105600 <sys_sbrk>:

int
sys_sbrk(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105604:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105607:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010560a:	50                   	push   %eax
8010560b:	6a 00                	push   $0x0
8010560d:	e8 2e f2 ff ff       	call   80104840 <argint>
80105612:	83 c4 10             	add    $0x10,%esp
80105615:	85 c0                	test   %eax,%eax
80105617:	78 27                	js     80105640 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105619:	e8 82 e2 ff ff       	call   801038a0 <myproc>
  if(growproc(n) < 0)
8010561e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105621:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105623:	ff 75 f4             	pushl  -0xc(%ebp)
80105626:	e8 95 e3 ff ff       	call   801039c0 <growproc>
8010562b:	83 c4 10             	add    $0x10,%esp
8010562e:	85 c0                	test   %eax,%eax
80105630:	78 0e                	js     80105640 <sys_sbrk+0x40>
    return -1;
  return addr;
80105632:	89 d8                	mov    %ebx,%eax
}
80105634:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105637:	c9                   	leave  
80105638:	c3                   	ret    
80105639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105645:	eb ed                	jmp    80105634 <sys_sbrk+0x34>
80105647:	89 f6                	mov    %esi,%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105650 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105654:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105657:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010565a:	50                   	push   %eax
8010565b:	6a 00                	push   $0x0
8010565d:	e8 de f1 ff ff       	call   80104840 <argint>
80105662:	83 c4 10             	add    $0x10,%esp
80105665:	85 c0                	test   %eax,%eax
80105667:	0f 88 8a 00 00 00    	js     801056f7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010566d:	83 ec 0c             	sub    $0xc,%esp
80105670:	68 60 cc 14 80       	push   $0x8014cc60
80105675:	e8 46 ed ff ff       	call   801043c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010567a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010567d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105680:	8b 1d a0 d4 14 80    	mov    0x8014d4a0,%ebx
  while(ticks - ticks0 < n){
80105686:	85 d2                	test   %edx,%edx
80105688:	75 27                	jne    801056b1 <sys_sleep+0x61>
8010568a:	eb 54                	jmp    801056e0 <sys_sleep+0x90>
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105690:	83 ec 08             	sub    $0x8,%esp
80105693:	68 60 cc 14 80       	push   $0x8014cc60
80105698:	68 a0 d4 14 80       	push   $0x8014d4a0
8010569d:	e8 ae e7 ff ff       	call   80103e50 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801056a2:	a1 a0 d4 14 80       	mov    0x8014d4a0,%eax
801056a7:	83 c4 10             	add    $0x10,%esp
801056aa:	29 d8                	sub    %ebx,%eax
801056ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801056af:	73 2f                	jae    801056e0 <sys_sleep+0x90>
    if(myproc()->killed){
801056b1:	e8 ea e1 ff ff       	call   801038a0 <myproc>
801056b6:	8b 40 24             	mov    0x24(%eax),%eax
801056b9:	85 c0                	test   %eax,%eax
801056bb:	74 d3                	je     80105690 <sys_sleep+0x40>
      release(&tickslock);
801056bd:	83 ec 0c             	sub    $0xc,%esp
801056c0:	68 60 cc 14 80       	push   $0x8014cc60
801056c5:	e8 16 ee ff ff       	call   801044e0 <release>
      return -1;
801056ca:	83 c4 10             	add    $0x10,%esp
801056cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801056d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    
801056d7:	89 f6                	mov    %esi,%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801056e0:	83 ec 0c             	sub    $0xc,%esp
801056e3:	68 60 cc 14 80       	push   $0x8014cc60
801056e8:	e8 f3 ed ff ff       	call   801044e0 <release>
  return 0;
801056ed:	83 c4 10             	add    $0x10,%esp
801056f0:	31 c0                	xor    %eax,%eax
}
801056f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056f5:	c9                   	leave  
801056f6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801056f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fc:	eb d4                	jmp    801056d2 <sys_sleep+0x82>
801056fe:	66 90                	xchg   %ax,%ax

80105700 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	53                   	push   %ebx
80105704:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105707:	68 60 cc 14 80       	push   $0x8014cc60
8010570c:	e8 af ec ff ff       	call   801043c0 <acquire>
  xticks = ticks;
80105711:	8b 1d a0 d4 14 80    	mov    0x8014d4a0,%ebx
  release(&tickslock);
80105717:	c7 04 24 60 cc 14 80 	movl   $0x8014cc60,(%esp)
8010571e:	e8 bd ed ff ff       	call   801044e0 <release>
  return xticks;
}
80105723:	89 d8                	mov    %ebx,%eax
80105725:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105728:	c9                   	leave  
80105729:	c3                   	ret    
8010572a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105730 <sys_date>:

int
sys_date(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 1c             	sub    $0x1c,%esp
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
80105736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105739:	6a 04                	push   $0x4
8010573b:	50                   	push   %eax
8010573c:	6a 00                	push   $0x0
8010573e:	e8 4d f1 ff ff       	call   80104890 <argptr>
80105743:	83 c4 10             	add    $0x10,%esp
80105746:	85 c0                	test   %eax,%eax
80105748:	78 16                	js     80105760 <sys_date+0x30>
   {
    return -1;
   }
  cmostime((struct rtcdate *)ptr);
8010574a:	83 ec 0c             	sub    $0xc,%esp
8010574d:	ff 75 f4             	pushl  -0xc(%ebp)
80105750:	e8 9b d1 ff ff       	call   801028f0 <cmostime>
  return 0;
80105755:	83 c4 10             	add    $0x10,%esp
80105758:	31 c0                	xor    %eax,%eax

}
8010575a:	c9                   	leave  
8010575b:	c3                   	ret    
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_date(void)
{
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
   {
    return -1;
80105760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   }
  cmostime((struct rtcdate *)ptr);
  return 0;

}
80105765:	c9                   	leave  
80105766:	c3                   	ret    
80105767:	89 f6                	mov    %esi,%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105770 <sys_virt2real>:

int
sys_virt2real(char *va)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	53                   	push   %ebx
80105774:	83 ec 04             	sub    $0x4,%esp
80105777:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010577a:	e8 21 e1 ff ff       	call   801038a0 <myproc>
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010577f:	8b 40 04             	mov    0x4(%eax),%eax
80105782:	89 da                	mov    %ebx,%edx
  return (int)pgtab[PTX(va)];
80105784:	c1 eb 0c             	shr    $0xc,%ebx
{
  struct proc *curproc = myproc();
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105787:	c1 ea 16             	shr    $0x16,%edx
  return (int)pgtab[PTX(va)];
8010578a:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80105790:	8b 04 90             	mov    (%eax,%edx,4),%eax
80105793:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105798:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax

}
8010579f:	83 c4 04             	add    $0x4,%esp
801057a2:	5b                   	pop    %ebx
801057a3:	5d                   	pop    %ebp
801057a4:	c3                   	ret    
801057a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <sys_num_pages>:

int
sys_num_pages(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801057b6:	e8 e5 e0 ff ff       	call   801038a0 <myproc>
  int temp = curproc->sz>>PGSHIFT;
801057bb:	8b 10                	mov    (%eax),%edx
    return temp;
  }
  else{
    return (temp+1);
  }
}
801057bd:	c9                   	leave  

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz>>PGSHIFT;
801057be:	89 d0                	mov    %edx,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
801057c0:	81 e2 ff 0f 00 00    	and    $0xfff,%edx

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz>>PGSHIFT;
801057c6:	c1 e8 0c             	shr    $0xc,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
    return temp;
  }
  else{
    return (temp+1);
801057c9:	83 fa 01             	cmp    $0x1,%edx
801057cc:	83 d8 ff             	sbb    $0xffffffff,%eax
  }
}
801057cf:	c3                   	ret    

801057d0 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801057d0:	1e                   	push   %ds
  pushl %es
801057d1:	06                   	push   %es
  pushl %fs
801057d2:	0f a0                	push   %fs
  pushl %gs
801057d4:	0f a8                	push   %gs
  pushal
801057d6:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801057d7:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801057db:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801057dd:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801057df:	54                   	push   %esp
  call trap
801057e0:	e8 eb 00 00 00       	call   801058d0 <trap>
  addl $4, %esp
801057e5:	83 c4 04             	add    $0x4,%esp

801057e8 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801057e8:	61                   	popa   
  popl %gs
801057e9:	0f a9                	pop    %gs
  popl %fs
801057eb:	0f a1                	pop    %fs
  popl %es
801057ed:	07                   	pop    %es
  popl %ds
801057ee:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801057ef:	83 c4 08             	add    $0x8,%esp
  iret
801057f2:	cf                   	iret   
801057f3:	66 90                	xchg   %ax,%ax
801057f5:	66 90                	xchg   %ax,%ax
801057f7:	66 90                	xchg   %ax,%ax
801057f9:	66 90                	xchg   %ax,%ax
801057fb:	66 90                	xchg   %ax,%ax
801057fd:	66 90                	xchg   %ax,%ax
801057ff:	90                   	nop

80105800 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105800:	31 c0                	xor    %eax,%eax
80105802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105808:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010580f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105814:	c6 04 c5 a4 cc 14 80 	movb   $0x0,-0x7feb335c(,%eax,8)
8010581b:	00 
8010581c:	66 89 0c c5 a2 cc 14 	mov    %cx,-0x7feb335e(,%eax,8)
80105823:	80 
80105824:	c6 04 c5 a5 cc 14 80 	movb   $0x8e,-0x7feb335b(,%eax,8)
8010582b:	8e 
8010582c:	66 89 14 c5 a0 cc 14 	mov    %dx,-0x7feb3360(,%eax,8)
80105833:	80 
80105834:	c1 ea 10             	shr    $0x10,%edx
80105837:	66 89 14 c5 a6 cc 14 	mov    %dx,-0x7feb335a(,%eax,8)
8010583e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010583f:	83 c0 01             	add    $0x1,%eax
80105842:	3d 00 01 00 00       	cmp    $0x100,%eax
80105847:	75 bf                	jne    80105808 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105849:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010584a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010584f:	89 e5                	mov    %esp,%ebp
80105851:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105854:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105859:	68 45 79 10 80       	push   $0x80107945
8010585e:	68 60 cc 14 80       	push   $0x8014cc60
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105863:	66 89 15 a2 ce 14 80 	mov    %dx,0x8014cea2
8010586a:	c6 05 a4 ce 14 80 00 	movb   $0x0,0x8014cea4
80105871:	66 a3 a0 ce 14 80    	mov    %ax,0x8014cea0
80105877:	c1 e8 10             	shr    $0x10,%eax
8010587a:	c6 05 a5 ce 14 80 ef 	movb   $0xef,0x8014cea5
80105881:	66 a3 a6 ce 14 80    	mov    %ax,0x8014cea6

  initlock(&tickslock, "time");
80105887:	e8 34 ea ff ff       	call   801042c0 <initlock>
}
8010588c:	83 c4 10             	add    $0x10,%esp
8010588f:	c9                   	leave  
80105890:	c3                   	ret    
80105891:	eb 0d                	jmp    801058a0 <idtinit>
80105893:	90                   	nop
80105894:	90                   	nop
80105895:	90                   	nop
80105896:	90                   	nop
80105897:	90                   	nop
80105898:	90                   	nop
80105899:	90                   	nop
8010589a:	90                   	nop
8010589b:	90                   	nop
8010589c:	90                   	nop
8010589d:	90                   	nop
8010589e:	90                   	nop
8010589f:	90                   	nop

801058a0 <idtinit>:

void
idtinit(void)
{
801058a0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801058a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058a6:	89 e5                	mov    %esp,%ebp
801058a8:	83 ec 10             	sub    $0x10,%esp
801058ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801058af:	b8 a0 cc 14 80       	mov    $0x8014cca0,%eax
801058b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801058b8:	c1 e8 10             	shr    $0x10,%eax
801058bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801058bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801058c5:	c9                   	leave  
801058c6:	c3                   	ret    
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	57                   	push   %edi
801058d4:	56                   	push   %esi
801058d5:	53                   	push   %ebx
801058d6:	83 ec 1c             	sub    $0x1c,%esp
801058d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801058dc:	8b 47 30             	mov    0x30(%edi),%eax
801058df:	83 f8 40             	cmp    $0x40,%eax
801058e2:	0f 84 88 01 00 00    	je     80105a70 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801058e8:	83 e8 20             	sub    $0x20,%eax
801058eb:	83 f8 1f             	cmp    $0x1f,%eax
801058ee:	77 10                	ja     80105900 <trap+0x30>
801058f0:	ff 24 85 ec 79 10 80 	jmp    *-0x7fef8614(,%eax,4)
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105900:	e8 9b df ff ff       	call   801038a0 <myproc>
80105905:	85 c0                	test   %eax,%eax
80105907:	0f 84 d7 01 00 00    	je     80105ae4 <trap+0x214>
8010590d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105911:	0f 84 cd 01 00 00    	je     80105ae4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105917:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010591a:	8b 57 38             	mov    0x38(%edi),%edx
8010591d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105920:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105923:	e8 58 df ff ff       	call   80103880 <cpuid>
80105928:	8b 77 34             	mov    0x34(%edi),%esi
8010592b:	8b 5f 30             	mov    0x30(%edi),%ebx
8010592e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105931:	e8 6a df ff ff       	call   801038a0 <myproc>
80105936:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105939:	e8 62 df ff ff       	call   801038a0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010593e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105941:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105944:	51                   	push   %ecx
80105945:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105946:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105949:	ff 75 e4             	pushl  -0x1c(%ebp)
8010594c:	56                   	push   %esi
8010594d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010594e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105951:	52                   	push   %edx
80105952:	ff 70 10             	pushl  0x10(%eax)
80105955:	68 a8 79 10 80       	push   $0x801079a8
8010595a:	e8 01 ad ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010595f:	83 c4 20             	add    $0x20,%esp
80105962:	e8 39 df ff ff       	call   801038a0 <myproc>
80105967:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010596e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105970:	e8 2b df ff ff       	call   801038a0 <myproc>
80105975:	85 c0                	test   %eax,%eax
80105977:	74 0c                	je     80105985 <trap+0xb5>
80105979:	e8 22 df ff ff       	call   801038a0 <myproc>
8010597e:	8b 50 24             	mov    0x24(%eax),%edx
80105981:	85 d2                	test   %edx,%edx
80105983:	75 4b                	jne    801059d0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105985:	e8 16 df ff ff       	call   801038a0 <myproc>
8010598a:	85 c0                	test   %eax,%eax
8010598c:	74 0b                	je     80105999 <trap+0xc9>
8010598e:	e8 0d df ff ff       	call   801038a0 <myproc>
80105993:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105997:	74 4f                	je     801059e8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105999:	e8 02 df ff ff       	call   801038a0 <myproc>
8010599e:	85 c0                	test   %eax,%eax
801059a0:	74 1d                	je     801059bf <trap+0xef>
801059a2:	e8 f9 de ff ff       	call   801038a0 <myproc>
801059a7:	8b 40 24             	mov    0x24(%eax),%eax
801059aa:	85 c0                	test   %eax,%eax
801059ac:	74 11                	je     801059bf <trap+0xef>
801059ae:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059b2:	83 e0 03             	and    $0x3,%eax
801059b5:	66 83 f8 03          	cmp    $0x3,%ax
801059b9:	0f 84 da 00 00 00    	je     80105a99 <trap+0x1c9>
    exit();
}
801059bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059c2:	5b                   	pop    %ebx
801059c3:	5e                   	pop    %esi
801059c4:	5f                   	pop    %edi
801059c5:	5d                   	pop    %ebp
801059c6:	c3                   	ret    
801059c7:	89 f6                	mov    %esi,%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059d0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059d4:	83 e0 03             	and    $0x3,%eax
801059d7:	66 83 f8 03          	cmp    $0x3,%ax
801059db:	75 a8                	jne    80105985 <trap+0xb5>
    exit();
801059dd:	e8 ee e2 ff ff       	call   80103cd0 <exit>
801059e2:	eb a1                	jmp    80105985 <trap+0xb5>
801059e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059e8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801059ec:	75 ab                	jne    80105999 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
801059ee:	e8 0d e4 ff ff       	call   80103e00 <yield>
801059f3:	eb a4                	jmp    80105999 <trap+0xc9>
801059f5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801059f8:	e8 83 de ff ff       	call   80103880 <cpuid>
801059fd:	85 c0                	test   %eax,%eax
801059ff:	0f 84 ab 00 00 00    	je     80105ab0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105a05:	e8 26 ce ff ff       	call   80102830 <lapiceoi>
    break;
80105a0a:	e9 61 ff ff ff       	jmp    80105970 <trap+0xa0>
80105a0f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105a10:	e8 db cc ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80105a15:	e8 16 ce ff ff       	call   80102830 <lapiceoi>
    break;
80105a1a:	e9 51 ff ff ff       	jmp    80105970 <trap+0xa0>
80105a1f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105a20:	e8 5b 02 00 00       	call   80105c80 <uartintr>
    lapiceoi();
80105a25:	e8 06 ce ff ff       	call   80102830 <lapiceoi>
    break;
80105a2a:	e9 41 ff ff ff       	jmp    80105970 <trap+0xa0>
80105a2f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a30:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a34:	8b 77 38             	mov    0x38(%edi),%esi
80105a37:	e8 44 de ff ff       	call   80103880 <cpuid>
80105a3c:	56                   	push   %esi
80105a3d:	53                   	push   %ebx
80105a3e:	50                   	push   %eax
80105a3f:	68 50 79 10 80       	push   $0x80107950
80105a44:	e8 17 ac ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105a49:	e8 e2 cd ff ff       	call   80102830 <lapiceoi>
    break;
80105a4e:	83 c4 10             	add    $0x10,%esp
80105a51:	e9 1a ff ff ff       	jmp    80105970 <trap+0xa0>
80105a56:	8d 76 00             	lea    0x0(%esi),%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105a60:	e8 eb c5 ff ff       	call   80102050 <ideintr>
80105a65:	eb 9e                	jmp    80105a05 <trap+0x135>
80105a67:	89 f6                	mov    %esi,%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105a70:	e8 2b de ff ff       	call   801038a0 <myproc>
80105a75:	8b 58 24             	mov    0x24(%eax),%ebx
80105a78:	85 db                	test   %ebx,%ebx
80105a7a:	75 2c                	jne    80105aa8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105a7c:	e8 1f de ff ff       	call   801038a0 <myproc>
80105a81:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105a84:	e8 a7 ee ff ff       	call   80104930 <syscall>
    if(myproc()->killed)
80105a89:	e8 12 de ff ff       	call   801038a0 <myproc>
80105a8e:	8b 48 24             	mov    0x24(%eax),%ecx
80105a91:	85 c9                	test   %ecx,%ecx
80105a93:	0f 84 26 ff ff ff    	je     801059bf <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105a99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a9c:	5b                   	pop    %ebx
80105a9d:	5e                   	pop    %esi
80105a9e:	5f                   	pop    %edi
80105a9f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105aa0:	e9 2b e2 ff ff       	jmp    80103cd0 <exit>
80105aa5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105aa8:	e8 23 e2 ff ff       	call   80103cd0 <exit>
80105aad:	eb cd                	jmp    80105a7c <trap+0x1ac>
80105aaf:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105ab0:	83 ec 0c             	sub    $0xc,%esp
80105ab3:	68 60 cc 14 80       	push   $0x8014cc60
80105ab8:	e8 03 e9 ff ff       	call   801043c0 <acquire>
      ticks++;
      wakeup(&ticks);
80105abd:	c7 04 24 a0 d4 14 80 	movl   $0x8014d4a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105ac4:	83 05 a0 d4 14 80 01 	addl   $0x1,0x8014d4a0
      wakeup(&ticks);
80105acb:	e8 30 e5 ff ff       	call   80104000 <wakeup>
      release(&tickslock);
80105ad0:	c7 04 24 60 cc 14 80 	movl   $0x8014cc60,(%esp)
80105ad7:	e8 04 ea ff ff       	call   801044e0 <release>
80105adc:	83 c4 10             	add    $0x10,%esp
80105adf:	e9 21 ff ff ff       	jmp    80105a05 <trap+0x135>
80105ae4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ae7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105aea:	e8 91 dd ff ff       	call   80103880 <cpuid>
80105aef:	83 ec 0c             	sub    $0xc,%esp
80105af2:	56                   	push   %esi
80105af3:	53                   	push   %ebx
80105af4:	50                   	push   %eax
80105af5:	ff 77 30             	pushl  0x30(%edi)
80105af8:	68 74 79 10 80       	push   $0x80107974
80105afd:	e8 5e ab ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105b02:	83 c4 14             	add    $0x14,%esp
80105b05:	68 4a 79 10 80       	push   $0x8010794a
80105b0a:	e8 61 a8 ff ff       	call   80100370 <panic>
80105b0f:	90                   	nop

80105b10 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b10:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105b15:	55                   	push   %ebp
80105b16:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b18:	85 c0                	test   %eax,%eax
80105b1a:	74 1c                	je     80105b38 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b1c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b21:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b22:	a8 01                	test   $0x1,%al
80105b24:	74 12                	je     80105b38 <uartgetc+0x28>
80105b26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b2b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b2c:	0f b6 c0             	movzbl %al,%eax
}
80105b2f:	5d                   	pop    %ebp
80105b30:	c3                   	ret    
80105b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105b38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105b3d:	5d                   	pop    %ebp
80105b3e:	c3                   	ret    
80105b3f:	90                   	nop

80105b40 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	57                   	push   %edi
80105b44:	56                   	push   %esi
80105b45:	53                   	push   %ebx
80105b46:	89 c7                	mov    %eax,%edi
80105b48:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b4d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b52:	83 ec 0c             	sub    $0xc,%esp
80105b55:	eb 1b                	jmp    80105b72 <uartputc.part.0+0x32>
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105b60:	83 ec 0c             	sub    $0xc,%esp
80105b63:	6a 0a                	push   $0xa
80105b65:	e8 e6 cc ff ff       	call   80102850 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105b6a:	83 c4 10             	add    $0x10,%esp
80105b6d:	83 eb 01             	sub    $0x1,%ebx
80105b70:	74 07                	je     80105b79 <uartputc.part.0+0x39>
80105b72:	89 f2                	mov    %esi,%edx
80105b74:	ec                   	in     (%dx),%al
80105b75:	a8 20                	test   $0x20,%al
80105b77:	74 e7                	je     80105b60 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105b79:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b7e:	89 f8                	mov    %edi,%eax
80105b80:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105b81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b84:	5b                   	pop    %ebx
80105b85:	5e                   	pop    %esi
80105b86:	5f                   	pop    %edi
80105b87:	5d                   	pop    %ebp
80105b88:	c3                   	ret    
80105b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b90 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105b90:	55                   	push   %ebp
80105b91:	31 c9                	xor    %ecx,%ecx
80105b93:	89 c8                	mov    %ecx,%eax
80105b95:	89 e5                	mov    %esp,%ebp
80105b97:	57                   	push   %edi
80105b98:	56                   	push   %esi
80105b99:	53                   	push   %ebx
80105b9a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105b9f:	89 da                	mov    %ebx,%edx
80105ba1:	83 ec 0c             	sub    $0xc,%esp
80105ba4:	ee                   	out    %al,(%dx)
80105ba5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105baa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105baf:	89 fa                	mov    %edi,%edx
80105bb1:	ee                   	out    %al,(%dx)
80105bb2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105bb7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bbc:	ee                   	out    %al,(%dx)
80105bbd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105bc2:	89 c8                	mov    %ecx,%eax
80105bc4:	89 f2                	mov    %esi,%edx
80105bc6:	ee                   	out    %al,(%dx)
80105bc7:	b8 03 00 00 00       	mov    $0x3,%eax
80105bcc:	89 fa                	mov    %edi,%edx
80105bce:	ee                   	out    %al,(%dx)
80105bcf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105bd4:	89 c8                	mov    %ecx,%eax
80105bd6:	ee                   	out    %al,(%dx)
80105bd7:	b8 01 00 00 00       	mov    $0x1,%eax
80105bdc:	89 f2                	mov    %esi,%edx
80105bde:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105bdf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105be4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105be5:	3c ff                	cmp    $0xff,%al
80105be7:	74 5a                	je     80105c43 <uartinit+0xb3>
    return;
  uart = 1;
80105be9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105bf0:	00 00 00 
80105bf3:	89 da                	mov    %ebx,%edx
80105bf5:	ec                   	in     (%dx),%al
80105bf6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bfb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105bfc:	83 ec 08             	sub    $0x8,%esp
80105bff:	bb 6c 7a 10 80       	mov    $0x80107a6c,%ebx
80105c04:	6a 00                	push   $0x0
80105c06:	6a 04                	push   $0x4
80105c08:	e8 93 c6 ff ff       	call   801022a0 <ioapicenable>
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	b8 78 00 00 00       	mov    $0x78,%eax
80105c15:	eb 13                	jmp    80105c2a <uartinit+0x9a>
80105c17:	89 f6                	mov    %esi,%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105c20:	83 c3 01             	add    $0x1,%ebx
80105c23:	0f be 03             	movsbl (%ebx),%eax
80105c26:	84 c0                	test   %al,%al
80105c28:	74 19                	je     80105c43 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105c2a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c30:	85 d2                	test   %edx,%edx
80105c32:	74 ec                	je     80105c20 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105c34:	83 c3 01             	add    $0x1,%ebx
80105c37:	e8 04 ff ff ff       	call   80105b40 <uartputc.part.0>
80105c3c:	0f be 03             	movsbl (%ebx),%eax
80105c3f:	84 c0                	test   %al,%al
80105c41:	75 e7                	jne    80105c2a <uartinit+0x9a>
    uartputc(*p);
}
80105c43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c46:	5b                   	pop    %ebx
80105c47:	5e                   	pop    %esi
80105c48:	5f                   	pop    %edi
80105c49:	5d                   	pop    %ebp
80105c4a:	c3                   	ret    
80105c4b:	90                   	nop
80105c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c50 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105c50:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105c56:	55                   	push   %ebp
80105c57:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105c59:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105c5e:	74 10                	je     80105c70 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105c60:	5d                   	pop    %ebp
80105c61:	e9 da fe ff ff       	jmp    80105b40 <uartputc.part.0>
80105c66:	8d 76 00             	lea    0x0(%esi),%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c70:	5d                   	pop    %ebp
80105c71:	c3                   	ret    
80105c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c80 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105c86:	68 10 5b 10 80       	push   $0x80105b10
80105c8b:	e8 60 ab ff ff       	call   801007f0 <consoleintr>
}
80105c90:	83 c4 10             	add    $0x10,%esp
80105c93:	c9                   	leave  
80105c94:	c3                   	ret    

80105c95 <vector0>:
80105c95:	6a 00                	push   $0x0
80105c97:	6a 00                	push   $0x0
80105c99:	e9 32 fb ff ff       	jmp    801057d0 <alltraps>

80105c9e <vector1>:
80105c9e:	6a 00                	push   $0x0
80105ca0:	6a 01                	push   $0x1
80105ca2:	e9 29 fb ff ff       	jmp    801057d0 <alltraps>

80105ca7 <vector2>:
80105ca7:	6a 00                	push   $0x0
80105ca9:	6a 02                	push   $0x2
80105cab:	e9 20 fb ff ff       	jmp    801057d0 <alltraps>

80105cb0 <vector3>:
80105cb0:	6a 00                	push   $0x0
80105cb2:	6a 03                	push   $0x3
80105cb4:	e9 17 fb ff ff       	jmp    801057d0 <alltraps>

80105cb9 <vector4>:
80105cb9:	6a 00                	push   $0x0
80105cbb:	6a 04                	push   $0x4
80105cbd:	e9 0e fb ff ff       	jmp    801057d0 <alltraps>

80105cc2 <vector5>:
80105cc2:	6a 00                	push   $0x0
80105cc4:	6a 05                	push   $0x5
80105cc6:	e9 05 fb ff ff       	jmp    801057d0 <alltraps>

80105ccb <vector6>:
80105ccb:	6a 00                	push   $0x0
80105ccd:	6a 06                	push   $0x6
80105ccf:	e9 fc fa ff ff       	jmp    801057d0 <alltraps>

80105cd4 <vector7>:
80105cd4:	6a 00                	push   $0x0
80105cd6:	6a 07                	push   $0x7
80105cd8:	e9 f3 fa ff ff       	jmp    801057d0 <alltraps>

80105cdd <vector8>:
80105cdd:	6a 08                	push   $0x8
80105cdf:	e9 ec fa ff ff       	jmp    801057d0 <alltraps>

80105ce4 <vector9>:
80105ce4:	6a 00                	push   $0x0
80105ce6:	6a 09                	push   $0x9
80105ce8:	e9 e3 fa ff ff       	jmp    801057d0 <alltraps>

80105ced <vector10>:
80105ced:	6a 0a                	push   $0xa
80105cef:	e9 dc fa ff ff       	jmp    801057d0 <alltraps>

80105cf4 <vector11>:
80105cf4:	6a 0b                	push   $0xb
80105cf6:	e9 d5 fa ff ff       	jmp    801057d0 <alltraps>

80105cfb <vector12>:
80105cfb:	6a 0c                	push   $0xc
80105cfd:	e9 ce fa ff ff       	jmp    801057d0 <alltraps>

80105d02 <vector13>:
80105d02:	6a 0d                	push   $0xd
80105d04:	e9 c7 fa ff ff       	jmp    801057d0 <alltraps>

80105d09 <vector14>:
80105d09:	6a 0e                	push   $0xe
80105d0b:	e9 c0 fa ff ff       	jmp    801057d0 <alltraps>

80105d10 <vector15>:
80105d10:	6a 00                	push   $0x0
80105d12:	6a 0f                	push   $0xf
80105d14:	e9 b7 fa ff ff       	jmp    801057d0 <alltraps>

80105d19 <vector16>:
80105d19:	6a 00                	push   $0x0
80105d1b:	6a 10                	push   $0x10
80105d1d:	e9 ae fa ff ff       	jmp    801057d0 <alltraps>

80105d22 <vector17>:
80105d22:	6a 11                	push   $0x11
80105d24:	e9 a7 fa ff ff       	jmp    801057d0 <alltraps>

80105d29 <vector18>:
80105d29:	6a 00                	push   $0x0
80105d2b:	6a 12                	push   $0x12
80105d2d:	e9 9e fa ff ff       	jmp    801057d0 <alltraps>

80105d32 <vector19>:
80105d32:	6a 00                	push   $0x0
80105d34:	6a 13                	push   $0x13
80105d36:	e9 95 fa ff ff       	jmp    801057d0 <alltraps>

80105d3b <vector20>:
80105d3b:	6a 00                	push   $0x0
80105d3d:	6a 14                	push   $0x14
80105d3f:	e9 8c fa ff ff       	jmp    801057d0 <alltraps>

80105d44 <vector21>:
80105d44:	6a 00                	push   $0x0
80105d46:	6a 15                	push   $0x15
80105d48:	e9 83 fa ff ff       	jmp    801057d0 <alltraps>

80105d4d <vector22>:
80105d4d:	6a 00                	push   $0x0
80105d4f:	6a 16                	push   $0x16
80105d51:	e9 7a fa ff ff       	jmp    801057d0 <alltraps>

80105d56 <vector23>:
80105d56:	6a 00                	push   $0x0
80105d58:	6a 17                	push   $0x17
80105d5a:	e9 71 fa ff ff       	jmp    801057d0 <alltraps>

80105d5f <vector24>:
80105d5f:	6a 00                	push   $0x0
80105d61:	6a 18                	push   $0x18
80105d63:	e9 68 fa ff ff       	jmp    801057d0 <alltraps>

80105d68 <vector25>:
80105d68:	6a 00                	push   $0x0
80105d6a:	6a 19                	push   $0x19
80105d6c:	e9 5f fa ff ff       	jmp    801057d0 <alltraps>

80105d71 <vector26>:
80105d71:	6a 00                	push   $0x0
80105d73:	6a 1a                	push   $0x1a
80105d75:	e9 56 fa ff ff       	jmp    801057d0 <alltraps>

80105d7a <vector27>:
80105d7a:	6a 00                	push   $0x0
80105d7c:	6a 1b                	push   $0x1b
80105d7e:	e9 4d fa ff ff       	jmp    801057d0 <alltraps>

80105d83 <vector28>:
80105d83:	6a 00                	push   $0x0
80105d85:	6a 1c                	push   $0x1c
80105d87:	e9 44 fa ff ff       	jmp    801057d0 <alltraps>

80105d8c <vector29>:
80105d8c:	6a 00                	push   $0x0
80105d8e:	6a 1d                	push   $0x1d
80105d90:	e9 3b fa ff ff       	jmp    801057d0 <alltraps>

80105d95 <vector30>:
80105d95:	6a 00                	push   $0x0
80105d97:	6a 1e                	push   $0x1e
80105d99:	e9 32 fa ff ff       	jmp    801057d0 <alltraps>

80105d9e <vector31>:
80105d9e:	6a 00                	push   $0x0
80105da0:	6a 1f                	push   $0x1f
80105da2:	e9 29 fa ff ff       	jmp    801057d0 <alltraps>

80105da7 <vector32>:
80105da7:	6a 00                	push   $0x0
80105da9:	6a 20                	push   $0x20
80105dab:	e9 20 fa ff ff       	jmp    801057d0 <alltraps>

80105db0 <vector33>:
80105db0:	6a 00                	push   $0x0
80105db2:	6a 21                	push   $0x21
80105db4:	e9 17 fa ff ff       	jmp    801057d0 <alltraps>

80105db9 <vector34>:
80105db9:	6a 00                	push   $0x0
80105dbb:	6a 22                	push   $0x22
80105dbd:	e9 0e fa ff ff       	jmp    801057d0 <alltraps>

80105dc2 <vector35>:
80105dc2:	6a 00                	push   $0x0
80105dc4:	6a 23                	push   $0x23
80105dc6:	e9 05 fa ff ff       	jmp    801057d0 <alltraps>

80105dcb <vector36>:
80105dcb:	6a 00                	push   $0x0
80105dcd:	6a 24                	push   $0x24
80105dcf:	e9 fc f9 ff ff       	jmp    801057d0 <alltraps>

80105dd4 <vector37>:
80105dd4:	6a 00                	push   $0x0
80105dd6:	6a 25                	push   $0x25
80105dd8:	e9 f3 f9 ff ff       	jmp    801057d0 <alltraps>

80105ddd <vector38>:
80105ddd:	6a 00                	push   $0x0
80105ddf:	6a 26                	push   $0x26
80105de1:	e9 ea f9 ff ff       	jmp    801057d0 <alltraps>

80105de6 <vector39>:
80105de6:	6a 00                	push   $0x0
80105de8:	6a 27                	push   $0x27
80105dea:	e9 e1 f9 ff ff       	jmp    801057d0 <alltraps>

80105def <vector40>:
80105def:	6a 00                	push   $0x0
80105df1:	6a 28                	push   $0x28
80105df3:	e9 d8 f9 ff ff       	jmp    801057d0 <alltraps>

80105df8 <vector41>:
80105df8:	6a 00                	push   $0x0
80105dfa:	6a 29                	push   $0x29
80105dfc:	e9 cf f9 ff ff       	jmp    801057d0 <alltraps>

80105e01 <vector42>:
80105e01:	6a 00                	push   $0x0
80105e03:	6a 2a                	push   $0x2a
80105e05:	e9 c6 f9 ff ff       	jmp    801057d0 <alltraps>

80105e0a <vector43>:
80105e0a:	6a 00                	push   $0x0
80105e0c:	6a 2b                	push   $0x2b
80105e0e:	e9 bd f9 ff ff       	jmp    801057d0 <alltraps>

80105e13 <vector44>:
80105e13:	6a 00                	push   $0x0
80105e15:	6a 2c                	push   $0x2c
80105e17:	e9 b4 f9 ff ff       	jmp    801057d0 <alltraps>

80105e1c <vector45>:
80105e1c:	6a 00                	push   $0x0
80105e1e:	6a 2d                	push   $0x2d
80105e20:	e9 ab f9 ff ff       	jmp    801057d0 <alltraps>

80105e25 <vector46>:
80105e25:	6a 00                	push   $0x0
80105e27:	6a 2e                	push   $0x2e
80105e29:	e9 a2 f9 ff ff       	jmp    801057d0 <alltraps>

80105e2e <vector47>:
80105e2e:	6a 00                	push   $0x0
80105e30:	6a 2f                	push   $0x2f
80105e32:	e9 99 f9 ff ff       	jmp    801057d0 <alltraps>

80105e37 <vector48>:
80105e37:	6a 00                	push   $0x0
80105e39:	6a 30                	push   $0x30
80105e3b:	e9 90 f9 ff ff       	jmp    801057d0 <alltraps>

80105e40 <vector49>:
80105e40:	6a 00                	push   $0x0
80105e42:	6a 31                	push   $0x31
80105e44:	e9 87 f9 ff ff       	jmp    801057d0 <alltraps>

80105e49 <vector50>:
80105e49:	6a 00                	push   $0x0
80105e4b:	6a 32                	push   $0x32
80105e4d:	e9 7e f9 ff ff       	jmp    801057d0 <alltraps>

80105e52 <vector51>:
80105e52:	6a 00                	push   $0x0
80105e54:	6a 33                	push   $0x33
80105e56:	e9 75 f9 ff ff       	jmp    801057d0 <alltraps>

80105e5b <vector52>:
80105e5b:	6a 00                	push   $0x0
80105e5d:	6a 34                	push   $0x34
80105e5f:	e9 6c f9 ff ff       	jmp    801057d0 <alltraps>

80105e64 <vector53>:
80105e64:	6a 00                	push   $0x0
80105e66:	6a 35                	push   $0x35
80105e68:	e9 63 f9 ff ff       	jmp    801057d0 <alltraps>

80105e6d <vector54>:
80105e6d:	6a 00                	push   $0x0
80105e6f:	6a 36                	push   $0x36
80105e71:	e9 5a f9 ff ff       	jmp    801057d0 <alltraps>

80105e76 <vector55>:
80105e76:	6a 00                	push   $0x0
80105e78:	6a 37                	push   $0x37
80105e7a:	e9 51 f9 ff ff       	jmp    801057d0 <alltraps>

80105e7f <vector56>:
80105e7f:	6a 00                	push   $0x0
80105e81:	6a 38                	push   $0x38
80105e83:	e9 48 f9 ff ff       	jmp    801057d0 <alltraps>

80105e88 <vector57>:
80105e88:	6a 00                	push   $0x0
80105e8a:	6a 39                	push   $0x39
80105e8c:	e9 3f f9 ff ff       	jmp    801057d0 <alltraps>

80105e91 <vector58>:
80105e91:	6a 00                	push   $0x0
80105e93:	6a 3a                	push   $0x3a
80105e95:	e9 36 f9 ff ff       	jmp    801057d0 <alltraps>

80105e9a <vector59>:
80105e9a:	6a 00                	push   $0x0
80105e9c:	6a 3b                	push   $0x3b
80105e9e:	e9 2d f9 ff ff       	jmp    801057d0 <alltraps>

80105ea3 <vector60>:
80105ea3:	6a 00                	push   $0x0
80105ea5:	6a 3c                	push   $0x3c
80105ea7:	e9 24 f9 ff ff       	jmp    801057d0 <alltraps>

80105eac <vector61>:
80105eac:	6a 00                	push   $0x0
80105eae:	6a 3d                	push   $0x3d
80105eb0:	e9 1b f9 ff ff       	jmp    801057d0 <alltraps>

80105eb5 <vector62>:
80105eb5:	6a 00                	push   $0x0
80105eb7:	6a 3e                	push   $0x3e
80105eb9:	e9 12 f9 ff ff       	jmp    801057d0 <alltraps>

80105ebe <vector63>:
80105ebe:	6a 00                	push   $0x0
80105ec0:	6a 3f                	push   $0x3f
80105ec2:	e9 09 f9 ff ff       	jmp    801057d0 <alltraps>

80105ec7 <vector64>:
80105ec7:	6a 00                	push   $0x0
80105ec9:	6a 40                	push   $0x40
80105ecb:	e9 00 f9 ff ff       	jmp    801057d0 <alltraps>

80105ed0 <vector65>:
80105ed0:	6a 00                	push   $0x0
80105ed2:	6a 41                	push   $0x41
80105ed4:	e9 f7 f8 ff ff       	jmp    801057d0 <alltraps>

80105ed9 <vector66>:
80105ed9:	6a 00                	push   $0x0
80105edb:	6a 42                	push   $0x42
80105edd:	e9 ee f8 ff ff       	jmp    801057d0 <alltraps>

80105ee2 <vector67>:
80105ee2:	6a 00                	push   $0x0
80105ee4:	6a 43                	push   $0x43
80105ee6:	e9 e5 f8 ff ff       	jmp    801057d0 <alltraps>

80105eeb <vector68>:
80105eeb:	6a 00                	push   $0x0
80105eed:	6a 44                	push   $0x44
80105eef:	e9 dc f8 ff ff       	jmp    801057d0 <alltraps>

80105ef4 <vector69>:
80105ef4:	6a 00                	push   $0x0
80105ef6:	6a 45                	push   $0x45
80105ef8:	e9 d3 f8 ff ff       	jmp    801057d0 <alltraps>

80105efd <vector70>:
80105efd:	6a 00                	push   $0x0
80105eff:	6a 46                	push   $0x46
80105f01:	e9 ca f8 ff ff       	jmp    801057d0 <alltraps>

80105f06 <vector71>:
80105f06:	6a 00                	push   $0x0
80105f08:	6a 47                	push   $0x47
80105f0a:	e9 c1 f8 ff ff       	jmp    801057d0 <alltraps>

80105f0f <vector72>:
80105f0f:	6a 00                	push   $0x0
80105f11:	6a 48                	push   $0x48
80105f13:	e9 b8 f8 ff ff       	jmp    801057d0 <alltraps>

80105f18 <vector73>:
80105f18:	6a 00                	push   $0x0
80105f1a:	6a 49                	push   $0x49
80105f1c:	e9 af f8 ff ff       	jmp    801057d0 <alltraps>

80105f21 <vector74>:
80105f21:	6a 00                	push   $0x0
80105f23:	6a 4a                	push   $0x4a
80105f25:	e9 a6 f8 ff ff       	jmp    801057d0 <alltraps>

80105f2a <vector75>:
80105f2a:	6a 00                	push   $0x0
80105f2c:	6a 4b                	push   $0x4b
80105f2e:	e9 9d f8 ff ff       	jmp    801057d0 <alltraps>

80105f33 <vector76>:
80105f33:	6a 00                	push   $0x0
80105f35:	6a 4c                	push   $0x4c
80105f37:	e9 94 f8 ff ff       	jmp    801057d0 <alltraps>

80105f3c <vector77>:
80105f3c:	6a 00                	push   $0x0
80105f3e:	6a 4d                	push   $0x4d
80105f40:	e9 8b f8 ff ff       	jmp    801057d0 <alltraps>

80105f45 <vector78>:
80105f45:	6a 00                	push   $0x0
80105f47:	6a 4e                	push   $0x4e
80105f49:	e9 82 f8 ff ff       	jmp    801057d0 <alltraps>

80105f4e <vector79>:
80105f4e:	6a 00                	push   $0x0
80105f50:	6a 4f                	push   $0x4f
80105f52:	e9 79 f8 ff ff       	jmp    801057d0 <alltraps>

80105f57 <vector80>:
80105f57:	6a 00                	push   $0x0
80105f59:	6a 50                	push   $0x50
80105f5b:	e9 70 f8 ff ff       	jmp    801057d0 <alltraps>

80105f60 <vector81>:
80105f60:	6a 00                	push   $0x0
80105f62:	6a 51                	push   $0x51
80105f64:	e9 67 f8 ff ff       	jmp    801057d0 <alltraps>

80105f69 <vector82>:
80105f69:	6a 00                	push   $0x0
80105f6b:	6a 52                	push   $0x52
80105f6d:	e9 5e f8 ff ff       	jmp    801057d0 <alltraps>

80105f72 <vector83>:
80105f72:	6a 00                	push   $0x0
80105f74:	6a 53                	push   $0x53
80105f76:	e9 55 f8 ff ff       	jmp    801057d0 <alltraps>

80105f7b <vector84>:
80105f7b:	6a 00                	push   $0x0
80105f7d:	6a 54                	push   $0x54
80105f7f:	e9 4c f8 ff ff       	jmp    801057d0 <alltraps>

80105f84 <vector85>:
80105f84:	6a 00                	push   $0x0
80105f86:	6a 55                	push   $0x55
80105f88:	e9 43 f8 ff ff       	jmp    801057d0 <alltraps>

80105f8d <vector86>:
80105f8d:	6a 00                	push   $0x0
80105f8f:	6a 56                	push   $0x56
80105f91:	e9 3a f8 ff ff       	jmp    801057d0 <alltraps>

80105f96 <vector87>:
80105f96:	6a 00                	push   $0x0
80105f98:	6a 57                	push   $0x57
80105f9a:	e9 31 f8 ff ff       	jmp    801057d0 <alltraps>

80105f9f <vector88>:
80105f9f:	6a 00                	push   $0x0
80105fa1:	6a 58                	push   $0x58
80105fa3:	e9 28 f8 ff ff       	jmp    801057d0 <alltraps>

80105fa8 <vector89>:
80105fa8:	6a 00                	push   $0x0
80105faa:	6a 59                	push   $0x59
80105fac:	e9 1f f8 ff ff       	jmp    801057d0 <alltraps>

80105fb1 <vector90>:
80105fb1:	6a 00                	push   $0x0
80105fb3:	6a 5a                	push   $0x5a
80105fb5:	e9 16 f8 ff ff       	jmp    801057d0 <alltraps>

80105fba <vector91>:
80105fba:	6a 00                	push   $0x0
80105fbc:	6a 5b                	push   $0x5b
80105fbe:	e9 0d f8 ff ff       	jmp    801057d0 <alltraps>

80105fc3 <vector92>:
80105fc3:	6a 00                	push   $0x0
80105fc5:	6a 5c                	push   $0x5c
80105fc7:	e9 04 f8 ff ff       	jmp    801057d0 <alltraps>

80105fcc <vector93>:
80105fcc:	6a 00                	push   $0x0
80105fce:	6a 5d                	push   $0x5d
80105fd0:	e9 fb f7 ff ff       	jmp    801057d0 <alltraps>

80105fd5 <vector94>:
80105fd5:	6a 00                	push   $0x0
80105fd7:	6a 5e                	push   $0x5e
80105fd9:	e9 f2 f7 ff ff       	jmp    801057d0 <alltraps>

80105fde <vector95>:
80105fde:	6a 00                	push   $0x0
80105fe0:	6a 5f                	push   $0x5f
80105fe2:	e9 e9 f7 ff ff       	jmp    801057d0 <alltraps>

80105fe7 <vector96>:
80105fe7:	6a 00                	push   $0x0
80105fe9:	6a 60                	push   $0x60
80105feb:	e9 e0 f7 ff ff       	jmp    801057d0 <alltraps>

80105ff0 <vector97>:
80105ff0:	6a 00                	push   $0x0
80105ff2:	6a 61                	push   $0x61
80105ff4:	e9 d7 f7 ff ff       	jmp    801057d0 <alltraps>

80105ff9 <vector98>:
80105ff9:	6a 00                	push   $0x0
80105ffb:	6a 62                	push   $0x62
80105ffd:	e9 ce f7 ff ff       	jmp    801057d0 <alltraps>

80106002 <vector99>:
80106002:	6a 00                	push   $0x0
80106004:	6a 63                	push   $0x63
80106006:	e9 c5 f7 ff ff       	jmp    801057d0 <alltraps>

8010600b <vector100>:
8010600b:	6a 00                	push   $0x0
8010600d:	6a 64                	push   $0x64
8010600f:	e9 bc f7 ff ff       	jmp    801057d0 <alltraps>

80106014 <vector101>:
80106014:	6a 00                	push   $0x0
80106016:	6a 65                	push   $0x65
80106018:	e9 b3 f7 ff ff       	jmp    801057d0 <alltraps>

8010601d <vector102>:
8010601d:	6a 00                	push   $0x0
8010601f:	6a 66                	push   $0x66
80106021:	e9 aa f7 ff ff       	jmp    801057d0 <alltraps>

80106026 <vector103>:
80106026:	6a 00                	push   $0x0
80106028:	6a 67                	push   $0x67
8010602a:	e9 a1 f7 ff ff       	jmp    801057d0 <alltraps>

8010602f <vector104>:
8010602f:	6a 00                	push   $0x0
80106031:	6a 68                	push   $0x68
80106033:	e9 98 f7 ff ff       	jmp    801057d0 <alltraps>

80106038 <vector105>:
80106038:	6a 00                	push   $0x0
8010603a:	6a 69                	push   $0x69
8010603c:	e9 8f f7 ff ff       	jmp    801057d0 <alltraps>

80106041 <vector106>:
80106041:	6a 00                	push   $0x0
80106043:	6a 6a                	push   $0x6a
80106045:	e9 86 f7 ff ff       	jmp    801057d0 <alltraps>

8010604a <vector107>:
8010604a:	6a 00                	push   $0x0
8010604c:	6a 6b                	push   $0x6b
8010604e:	e9 7d f7 ff ff       	jmp    801057d0 <alltraps>

80106053 <vector108>:
80106053:	6a 00                	push   $0x0
80106055:	6a 6c                	push   $0x6c
80106057:	e9 74 f7 ff ff       	jmp    801057d0 <alltraps>

8010605c <vector109>:
8010605c:	6a 00                	push   $0x0
8010605e:	6a 6d                	push   $0x6d
80106060:	e9 6b f7 ff ff       	jmp    801057d0 <alltraps>

80106065 <vector110>:
80106065:	6a 00                	push   $0x0
80106067:	6a 6e                	push   $0x6e
80106069:	e9 62 f7 ff ff       	jmp    801057d0 <alltraps>

8010606e <vector111>:
8010606e:	6a 00                	push   $0x0
80106070:	6a 6f                	push   $0x6f
80106072:	e9 59 f7 ff ff       	jmp    801057d0 <alltraps>

80106077 <vector112>:
80106077:	6a 00                	push   $0x0
80106079:	6a 70                	push   $0x70
8010607b:	e9 50 f7 ff ff       	jmp    801057d0 <alltraps>

80106080 <vector113>:
80106080:	6a 00                	push   $0x0
80106082:	6a 71                	push   $0x71
80106084:	e9 47 f7 ff ff       	jmp    801057d0 <alltraps>

80106089 <vector114>:
80106089:	6a 00                	push   $0x0
8010608b:	6a 72                	push   $0x72
8010608d:	e9 3e f7 ff ff       	jmp    801057d0 <alltraps>

80106092 <vector115>:
80106092:	6a 00                	push   $0x0
80106094:	6a 73                	push   $0x73
80106096:	e9 35 f7 ff ff       	jmp    801057d0 <alltraps>

8010609b <vector116>:
8010609b:	6a 00                	push   $0x0
8010609d:	6a 74                	push   $0x74
8010609f:	e9 2c f7 ff ff       	jmp    801057d0 <alltraps>

801060a4 <vector117>:
801060a4:	6a 00                	push   $0x0
801060a6:	6a 75                	push   $0x75
801060a8:	e9 23 f7 ff ff       	jmp    801057d0 <alltraps>

801060ad <vector118>:
801060ad:	6a 00                	push   $0x0
801060af:	6a 76                	push   $0x76
801060b1:	e9 1a f7 ff ff       	jmp    801057d0 <alltraps>

801060b6 <vector119>:
801060b6:	6a 00                	push   $0x0
801060b8:	6a 77                	push   $0x77
801060ba:	e9 11 f7 ff ff       	jmp    801057d0 <alltraps>

801060bf <vector120>:
801060bf:	6a 00                	push   $0x0
801060c1:	6a 78                	push   $0x78
801060c3:	e9 08 f7 ff ff       	jmp    801057d0 <alltraps>

801060c8 <vector121>:
801060c8:	6a 00                	push   $0x0
801060ca:	6a 79                	push   $0x79
801060cc:	e9 ff f6 ff ff       	jmp    801057d0 <alltraps>

801060d1 <vector122>:
801060d1:	6a 00                	push   $0x0
801060d3:	6a 7a                	push   $0x7a
801060d5:	e9 f6 f6 ff ff       	jmp    801057d0 <alltraps>

801060da <vector123>:
801060da:	6a 00                	push   $0x0
801060dc:	6a 7b                	push   $0x7b
801060de:	e9 ed f6 ff ff       	jmp    801057d0 <alltraps>

801060e3 <vector124>:
801060e3:	6a 00                	push   $0x0
801060e5:	6a 7c                	push   $0x7c
801060e7:	e9 e4 f6 ff ff       	jmp    801057d0 <alltraps>

801060ec <vector125>:
801060ec:	6a 00                	push   $0x0
801060ee:	6a 7d                	push   $0x7d
801060f0:	e9 db f6 ff ff       	jmp    801057d0 <alltraps>

801060f5 <vector126>:
801060f5:	6a 00                	push   $0x0
801060f7:	6a 7e                	push   $0x7e
801060f9:	e9 d2 f6 ff ff       	jmp    801057d0 <alltraps>

801060fe <vector127>:
801060fe:	6a 00                	push   $0x0
80106100:	6a 7f                	push   $0x7f
80106102:	e9 c9 f6 ff ff       	jmp    801057d0 <alltraps>

80106107 <vector128>:
80106107:	6a 00                	push   $0x0
80106109:	68 80 00 00 00       	push   $0x80
8010610e:	e9 bd f6 ff ff       	jmp    801057d0 <alltraps>

80106113 <vector129>:
80106113:	6a 00                	push   $0x0
80106115:	68 81 00 00 00       	push   $0x81
8010611a:	e9 b1 f6 ff ff       	jmp    801057d0 <alltraps>

8010611f <vector130>:
8010611f:	6a 00                	push   $0x0
80106121:	68 82 00 00 00       	push   $0x82
80106126:	e9 a5 f6 ff ff       	jmp    801057d0 <alltraps>

8010612b <vector131>:
8010612b:	6a 00                	push   $0x0
8010612d:	68 83 00 00 00       	push   $0x83
80106132:	e9 99 f6 ff ff       	jmp    801057d0 <alltraps>

80106137 <vector132>:
80106137:	6a 00                	push   $0x0
80106139:	68 84 00 00 00       	push   $0x84
8010613e:	e9 8d f6 ff ff       	jmp    801057d0 <alltraps>

80106143 <vector133>:
80106143:	6a 00                	push   $0x0
80106145:	68 85 00 00 00       	push   $0x85
8010614a:	e9 81 f6 ff ff       	jmp    801057d0 <alltraps>

8010614f <vector134>:
8010614f:	6a 00                	push   $0x0
80106151:	68 86 00 00 00       	push   $0x86
80106156:	e9 75 f6 ff ff       	jmp    801057d0 <alltraps>

8010615b <vector135>:
8010615b:	6a 00                	push   $0x0
8010615d:	68 87 00 00 00       	push   $0x87
80106162:	e9 69 f6 ff ff       	jmp    801057d0 <alltraps>

80106167 <vector136>:
80106167:	6a 00                	push   $0x0
80106169:	68 88 00 00 00       	push   $0x88
8010616e:	e9 5d f6 ff ff       	jmp    801057d0 <alltraps>

80106173 <vector137>:
80106173:	6a 00                	push   $0x0
80106175:	68 89 00 00 00       	push   $0x89
8010617a:	e9 51 f6 ff ff       	jmp    801057d0 <alltraps>

8010617f <vector138>:
8010617f:	6a 00                	push   $0x0
80106181:	68 8a 00 00 00       	push   $0x8a
80106186:	e9 45 f6 ff ff       	jmp    801057d0 <alltraps>

8010618b <vector139>:
8010618b:	6a 00                	push   $0x0
8010618d:	68 8b 00 00 00       	push   $0x8b
80106192:	e9 39 f6 ff ff       	jmp    801057d0 <alltraps>

80106197 <vector140>:
80106197:	6a 00                	push   $0x0
80106199:	68 8c 00 00 00       	push   $0x8c
8010619e:	e9 2d f6 ff ff       	jmp    801057d0 <alltraps>

801061a3 <vector141>:
801061a3:	6a 00                	push   $0x0
801061a5:	68 8d 00 00 00       	push   $0x8d
801061aa:	e9 21 f6 ff ff       	jmp    801057d0 <alltraps>

801061af <vector142>:
801061af:	6a 00                	push   $0x0
801061b1:	68 8e 00 00 00       	push   $0x8e
801061b6:	e9 15 f6 ff ff       	jmp    801057d0 <alltraps>

801061bb <vector143>:
801061bb:	6a 00                	push   $0x0
801061bd:	68 8f 00 00 00       	push   $0x8f
801061c2:	e9 09 f6 ff ff       	jmp    801057d0 <alltraps>

801061c7 <vector144>:
801061c7:	6a 00                	push   $0x0
801061c9:	68 90 00 00 00       	push   $0x90
801061ce:	e9 fd f5 ff ff       	jmp    801057d0 <alltraps>

801061d3 <vector145>:
801061d3:	6a 00                	push   $0x0
801061d5:	68 91 00 00 00       	push   $0x91
801061da:	e9 f1 f5 ff ff       	jmp    801057d0 <alltraps>

801061df <vector146>:
801061df:	6a 00                	push   $0x0
801061e1:	68 92 00 00 00       	push   $0x92
801061e6:	e9 e5 f5 ff ff       	jmp    801057d0 <alltraps>

801061eb <vector147>:
801061eb:	6a 00                	push   $0x0
801061ed:	68 93 00 00 00       	push   $0x93
801061f2:	e9 d9 f5 ff ff       	jmp    801057d0 <alltraps>

801061f7 <vector148>:
801061f7:	6a 00                	push   $0x0
801061f9:	68 94 00 00 00       	push   $0x94
801061fe:	e9 cd f5 ff ff       	jmp    801057d0 <alltraps>

80106203 <vector149>:
80106203:	6a 00                	push   $0x0
80106205:	68 95 00 00 00       	push   $0x95
8010620a:	e9 c1 f5 ff ff       	jmp    801057d0 <alltraps>

8010620f <vector150>:
8010620f:	6a 00                	push   $0x0
80106211:	68 96 00 00 00       	push   $0x96
80106216:	e9 b5 f5 ff ff       	jmp    801057d0 <alltraps>

8010621b <vector151>:
8010621b:	6a 00                	push   $0x0
8010621d:	68 97 00 00 00       	push   $0x97
80106222:	e9 a9 f5 ff ff       	jmp    801057d0 <alltraps>

80106227 <vector152>:
80106227:	6a 00                	push   $0x0
80106229:	68 98 00 00 00       	push   $0x98
8010622e:	e9 9d f5 ff ff       	jmp    801057d0 <alltraps>

80106233 <vector153>:
80106233:	6a 00                	push   $0x0
80106235:	68 99 00 00 00       	push   $0x99
8010623a:	e9 91 f5 ff ff       	jmp    801057d0 <alltraps>

8010623f <vector154>:
8010623f:	6a 00                	push   $0x0
80106241:	68 9a 00 00 00       	push   $0x9a
80106246:	e9 85 f5 ff ff       	jmp    801057d0 <alltraps>

8010624b <vector155>:
8010624b:	6a 00                	push   $0x0
8010624d:	68 9b 00 00 00       	push   $0x9b
80106252:	e9 79 f5 ff ff       	jmp    801057d0 <alltraps>

80106257 <vector156>:
80106257:	6a 00                	push   $0x0
80106259:	68 9c 00 00 00       	push   $0x9c
8010625e:	e9 6d f5 ff ff       	jmp    801057d0 <alltraps>

80106263 <vector157>:
80106263:	6a 00                	push   $0x0
80106265:	68 9d 00 00 00       	push   $0x9d
8010626a:	e9 61 f5 ff ff       	jmp    801057d0 <alltraps>

8010626f <vector158>:
8010626f:	6a 00                	push   $0x0
80106271:	68 9e 00 00 00       	push   $0x9e
80106276:	e9 55 f5 ff ff       	jmp    801057d0 <alltraps>

8010627b <vector159>:
8010627b:	6a 00                	push   $0x0
8010627d:	68 9f 00 00 00       	push   $0x9f
80106282:	e9 49 f5 ff ff       	jmp    801057d0 <alltraps>

80106287 <vector160>:
80106287:	6a 00                	push   $0x0
80106289:	68 a0 00 00 00       	push   $0xa0
8010628e:	e9 3d f5 ff ff       	jmp    801057d0 <alltraps>

80106293 <vector161>:
80106293:	6a 00                	push   $0x0
80106295:	68 a1 00 00 00       	push   $0xa1
8010629a:	e9 31 f5 ff ff       	jmp    801057d0 <alltraps>

8010629f <vector162>:
8010629f:	6a 00                	push   $0x0
801062a1:	68 a2 00 00 00       	push   $0xa2
801062a6:	e9 25 f5 ff ff       	jmp    801057d0 <alltraps>

801062ab <vector163>:
801062ab:	6a 00                	push   $0x0
801062ad:	68 a3 00 00 00       	push   $0xa3
801062b2:	e9 19 f5 ff ff       	jmp    801057d0 <alltraps>

801062b7 <vector164>:
801062b7:	6a 00                	push   $0x0
801062b9:	68 a4 00 00 00       	push   $0xa4
801062be:	e9 0d f5 ff ff       	jmp    801057d0 <alltraps>

801062c3 <vector165>:
801062c3:	6a 00                	push   $0x0
801062c5:	68 a5 00 00 00       	push   $0xa5
801062ca:	e9 01 f5 ff ff       	jmp    801057d0 <alltraps>

801062cf <vector166>:
801062cf:	6a 00                	push   $0x0
801062d1:	68 a6 00 00 00       	push   $0xa6
801062d6:	e9 f5 f4 ff ff       	jmp    801057d0 <alltraps>

801062db <vector167>:
801062db:	6a 00                	push   $0x0
801062dd:	68 a7 00 00 00       	push   $0xa7
801062e2:	e9 e9 f4 ff ff       	jmp    801057d0 <alltraps>

801062e7 <vector168>:
801062e7:	6a 00                	push   $0x0
801062e9:	68 a8 00 00 00       	push   $0xa8
801062ee:	e9 dd f4 ff ff       	jmp    801057d0 <alltraps>

801062f3 <vector169>:
801062f3:	6a 00                	push   $0x0
801062f5:	68 a9 00 00 00       	push   $0xa9
801062fa:	e9 d1 f4 ff ff       	jmp    801057d0 <alltraps>

801062ff <vector170>:
801062ff:	6a 00                	push   $0x0
80106301:	68 aa 00 00 00       	push   $0xaa
80106306:	e9 c5 f4 ff ff       	jmp    801057d0 <alltraps>

8010630b <vector171>:
8010630b:	6a 00                	push   $0x0
8010630d:	68 ab 00 00 00       	push   $0xab
80106312:	e9 b9 f4 ff ff       	jmp    801057d0 <alltraps>

80106317 <vector172>:
80106317:	6a 00                	push   $0x0
80106319:	68 ac 00 00 00       	push   $0xac
8010631e:	e9 ad f4 ff ff       	jmp    801057d0 <alltraps>

80106323 <vector173>:
80106323:	6a 00                	push   $0x0
80106325:	68 ad 00 00 00       	push   $0xad
8010632a:	e9 a1 f4 ff ff       	jmp    801057d0 <alltraps>

8010632f <vector174>:
8010632f:	6a 00                	push   $0x0
80106331:	68 ae 00 00 00       	push   $0xae
80106336:	e9 95 f4 ff ff       	jmp    801057d0 <alltraps>

8010633b <vector175>:
8010633b:	6a 00                	push   $0x0
8010633d:	68 af 00 00 00       	push   $0xaf
80106342:	e9 89 f4 ff ff       	jmp    801057d0 <alltraps>

80106347 <vector176>:
80106347:	6a 00                	push   $0x0
80106349:	68 b0 00 00 00       	push   $0xb0
8010634e:	e9 7d f4 ff ff       	jmp    801057d0 <alltraps>

80106353 <vector177>:
80106353:	6a 00                	push   $0x0
80106355:	68 b1 00 00 00       	push   $0xb1
8010635a:	e9 71 f4 ff ff       	jmp    801057d0 <alltraps>

8010635f <vector178>:
8010635f:	6a 00                	push   $0x0
80106361:	68 b2 00 00 00       	push   $0xb2
80106366:	e9 65 f4 ff ff       	jmp    801057d0 <alltraps>

8010636b <vector179>:
8010636b:	6a 00                	push   $0x0
8010636d:	68 b3 00 00 00       	push   $0xb3
80106372:	e9 59 f4 ff ff       	jmp    801057d0 <alltraps>

80106377 <vector180>:
80106377:	6a 00                	push   $0x0
80106379:	68 b4 00 00 00       	push   $0xb4
8010637e:	e9 4d f4 ff ff       	jmp    801057d0 <alltraps>

80106383 <vector181>:
80106383:	6a 00                	push   $0x0
80106385:	68 b5 00 00 00       	push   $0xb5
8010638a:	e9 41 f4 ff ff       	jmp    801057d0 <alltraps>

8010638f <vector182>:
8010638f:	6a 00                	push   $0x0
80106391:	68 b6 00 00 00       	push   $0xb6
80106396:	e9 35 f4 ff ff       	jmp    801057d0 <alltraps>

8010639b <vector183>:
8010639b:	6a 00                	push   $0x0
8010639d:	68 b7 00 00 00       	push   $0xb7
801063a2:	e9 29 f4 ff ff       	jmp    801057d0 <alltraps>

801063a7 <vector184>:
801063a7:	6a 00                	push   $0x0
801063a9:	68 b8 00 00 00       	push   $0xb8
801063ae:	e9 1d f4 ff ff       	jmp    801057d0 <alltraps>

801063b3 <vector185>:
801063b3:	6a 00                	push   $0x0
801063b5:	68 b9 00 00 00       	push   $0xb9
801063ba:	e9 11 f4 ff ff       	jmp    801057d0 <alltraps>

801063bf <vector186>:
801063bf:	6a 00                	push   $0x0
801063c1:	68 ba 00 00 00       	push   $0xba
801063c6:	e9 05 f4 ff ff       	jmp    801057d0 <alltraps>

801063cb <vector187>:
801063cb:	6a 00                	push   $0x0
801063cd:	68 bb 00 00 00       	push   $0xbb
801063d2:	e9 f9 f3 ff ff       	jmp    801057d0 <alltraps>

801063d7 <vector188>:
801063d7:	6a 00                	push   $0x0
801063d9:	68 bc 00 00 00       	push   $0xbc
801063de:	e9 ed f3 ff ff       	jmp    801057d0 <alltraps>

801063e3 <vector189>:
801063e3:	6a 00                	push   $0x0
801063e5:	68 bd 00 00 00       	push   $0xbd
801063ea:	e9 e1 f3 ff ff       	jmp    801057d0 <alltraps>

801063ef <vector190>:
801063ef:	6a 00                	push   $0x0
801063f1:	68 be 00 00 00       	push   $0xbe
801063f6:	e9 d5 f3 ff ff       	jmp    801057d0 <alltraps>

801063fb <vector191>:
801063fb:	6a 00                	push   $0x0
801063fd:	68 bf 00 00 00       	push   $0xbf
80106402:	e9 c9 f3 ff ff       	jmp    801057d0 <alltraps>

80106407 <vector192>:
80106407:	6a 00                	push   $0x0
80106409:	68 c0 00 00 00       	push   $0xc0
8010640e:	e9 bd f3 ff ff       	jmp    801057d0 <alltraps>

80106413 <vector193>:
80106413:	6a 00                	push   $0x0
80106415:	68 c1 00 00 00       	push   $0xc1
8010641a:	e9 b1 f3 ff ff       	jmp    801057d0 <alltraps>

8010641f <vector194>:
8010641f:	6a 00                	push   $0x0
80106421:	68 c2 00 00 00       	push   $0xc2
80106426:	e9 a5 f3 ff ff       	jmp    801057d0 <alltraps>

8010642b <vector195>:
8010642b:	6a 00                	push   $0x0
8010642d:	68 c3 00 00 00       	push   $0xc3
80106432:	e9 99 f3 ff ff       	jmp    801057d0 <alltraps>

80106437 <vector196>:
80106437:	6a 00                	push   $0x0
80106439:	68 c4 00 00 00       	push   $0xc4
8010643e:	e9 8d f3 ff ff       	jmp    801057d0 <alltraps>

80106443 <vector197>:
80106443:	6a 00                	push   $0x0
80106445:	68 c5 00 00 00       	push   $0xc5
8010644a:	e9 81 f3 ff ff       	jmp    801057d0 <alltraps>

8010644f <vector198>:
8010644f:	6a 00                	push   $0x0
80106451:	68 c6 00 00 00       	push   $0xc6
80106456:	e9 75 f3 ff ff       	jmp    801057d0 <alltraps>

8010645b <vector199>:
8010645b:	6a 00                	push   $0x0
8010645d:	68 c7 00 00 00       	push   $0xc7
80106462:	e9 69 f3 ff ff       	jmp    801057d0 <alltraps>

80106467 <vector200>:
80106467:	6a 00                	push   $0x0
80106469:	68 c8 00 00 00       	push   $0xc8
8010646e:	e9 5d f3 ff ff       	jmp    801057d0 <alltraps>

80106473 <vector201>:
80106473:	6a 00                	push   $0x0
80106475:	68 c9 00 00 00       	push   $0xc9
8010647a:	e9 51 f3 ff ff       	jmp    801057d0 <alltraps>

8010647f <vector202>:
8010647f:	6a 00                	push   $0x0
80106481:	68 ca 00 00 00       	push   $0xca
80106486:	e9 45 f3 ff ff       	jmp    801057d0 <alltraps>

8010648b <vector203>:
8010648b:	6a 00                	push   $0x0
8010648d:	68 cb 00 00 00       	push   $0xcb
80106492:	e9 39 f3 ff ff       	jmp    801057d0 <alltraps>

80106497 <vector204>:
80106497:	6a 00                	push   $0x0
80106499:	68 cc 00 00 00       	push   $0xcc
8010649e:	e9 2d f3 ff ff       	jmp    801057d0 <alltraps>

801064a3 <vector205>:
801064a3:	6a 00                	push   $0x0
801064a5:	68 cd 00 00 00       	push   $0xcd
801064aa:	e9 21 f3 ff ff       	jmp    801057d0 <alltraps>

801064af <vector206>:
801064af:	6a 00                	push   $0x0
801064b1:	68 ce 00 00 00       	push   $0xce
801064b6:	e9 15 f3 ff ff       	jmp    801057d0 <alltraps>

801064bb <vector207>:
801064bb:	6a 00                	push   $0x0
801064bd:	68 cf 00 00 00       	push   $0xcf
801064c2:	e9 09 f3 ff ff       	jmp    801057d0 <alltraps>

801064c7 <vector208>:
801064c7:	6a 00                	push   $0x0
801064c9:	68 d0 00 00 00       	push   $0xd0
801064ce:	e9 fd f2 ff ff       	jmp    801057d0 <alltraps>

801064d3 <vector209>:
801064d3:	6a 00                	push   $0x0
801064d5:	68 d1 00 00 00       	push   $0xd1
801064da:	e9 f1 f2 ff ff       	jmp    801057d0 <alltraps>

801064df <vector210>:
801064df:	6a 00                	push   $0x0
801064e1:	68 d2 00 00 00       	push   $0xd2
801064e6:	e9 e5 f2 ff ff       	jmp    801057d0 <alltraps>

801064eb <vector211>:
801064eb:	6a 00                	push   $0x0
801064ed:	68 d3 00 00 00       	push   $0xd3
801064f2:	e9 d9 f2 ff ff       	jmp    801057d0 <alltraps>

801064f7 <vector212>:
801064f7:	6a 00                	push   $0x0
801064f9:	68 d4 00 00 00       	push   $0xd4
801064fe:	e9 cd f2 ff ff       	jmp    801057d0 <alltraps>

80106503 <vector213>:
80106503:	6a 00                	push   $0x0
80106505:	68 d5 00 00 00       	push   $0xd5
8010650a:	e9 c1 f2 ff ff       	jmp    801057d0 <alltraps>

8010650f <vector214>:
8010650f:	6a 00                	push   $0x0
80106511:	68 d6 00 00 00       	push   $0xd6
80106516:	e9 b5 f2 ff ff       	jmp    801057d0 <alltraps>

8010651b <vector215>:
8010651b:	6a 00                	push   $0x0
8010651d:	68 d7 00 00 00       	push   $0xd7
80106522:	e9 a9 f2 ff ff       	jmp    801057d0 <alltraps>

80106527 <vector216>:
80106527:	6a 00                	push   $0x0
80106529:	68 d8 00 00 00       	push   $0xd8
8010652e:	e9 9d f2 ff ff       	jmp    801057d0 <alltraps>

80106533 <vector217>:
80106533:	6a 00                	push   $0x0
80106535:	68 d9 00 00 00       	push   $0xd9
8010653a:	e9 91 f2 ff ff       	jmp    801057d0 <alltraps>

8010653f <vector218>:
8010653f:	6a 00                	push   $0x0
80106541:	68 da 00 00 00       	push   $0xda
80106546:	e9 85 f2 ff ff       	jmp    801057d0 <alltraps>

8010654b <vector219>:
8010654b:	6a 00                	push   $0x0
8010654d:	68 db 00 00 00       	push   $0xdb
80106552:	e9 79 f2 ff ff       	jmp    801057d0 <alltraps>

80106557 <vector220>:
80106557:	6a 00                	push   $0x0
80106559:	68 dc 00 00 00       	push   $0xdc
8010655e:	e9 6d f2 ff ff       	jmp    801057d0 <alltraps>

80106563 <vector221>:
80106563:	6a 00                	push   $0x0
80106565:	68 dd 00 00 00       	push   $0xdd
8010656a:	e9 61 f2 ff ff       	jmp    801057d0 <alltraps>

8010656f <vector222>:
8010656f:	6a 00                	push   $0x0
80106571:	68 de 00 00 00       	push   $0xde
80106576:	e9 55 f2 ff ff       	jmp    801057d0 <alltraps>

8010657b <vector223>:
8010657b:	6a 00                	push   $0x0
8010657d:	68 df 00 00 00       	push   $0xdf
80106582:	e9 49 f2 ff ff       	jmp    801057d0 <alltraps>

80106587 <vector224>:
80106587:	6a 00                	push   $0x0
80106589:	68 e0 00 00 00       	push   $0xe0
8010658e:	e9 3d f2 ff ff       	jmp    801057d0 <alltraps>

80106593 <vector225>:
80106593:	6a 00                	push   $0x0
80106595:	68 e1 00 00 00       	push   $0xe1
8010659a:	e9 31 f2 ff ff       	jmp    801057d0 <alltraps>

8010659f <vector226>:
8010659f:	6a 00                	push   $0x0
801065a1:	68 e2 00 00 00       	push   $0xe2
801065a6:	e9 25 f2 ff ff       	jmp    801057d0 <alltraps>

801065ab <vector227>:
801065ab:	6a 00                	push   $0x0
801065ad:	68 e3 00 00 00       	push   $0xe3
801065b2:	e9 19 f2 ff ff       	jmp    801057d0 <alltraps>

801065b7 <vector228>:
801065b7:	6a 00                	push   $0x0
801065b9:	68 e4 00 00 00       	push   $0xe4
801065be:	e9 0d f2 ff ff       	jmp    801057d0 <alltraps>

801065c3 <vector229>:
801065c3:	6a 00                	push   $0x0
801065c5:	68 e5 00 00 00       	push   $0xe5
801065ca:	e9 01 f2 ff ff       	jmp    801057d0 <alltraps>

801065cf <vector230>:
801065cf:	6a 00                	push   $0x0
801065d1:	68 e6 00 00 00       	push   $0xe6
801065d6:	e9 f5 f1 ff ff       	jmp    801057d0 <alltraps>

801065db <vector231>:
801065db:	6a 00                	push   $0x0
801065dd:	68 e7 00 00 00       	push   $0xe7
801065e2:	e9 e9 f1 ff ff       	jmp    801057d0 <alltraps>

801065e7 <vector232>:
801065e7:	6a 00                	push   $0x0
801065e9:	68 e8 00 00 00       	push   $0xe8
801065ee:	e9 dd f1 ff ff       	jmp    801057d0 <alltraps>

801065f3 <vector233>:
801065f3:	6a 00                	push   $0x0
801065f5:	68 e9 00 00 00       	push   $0xe9
801065fa:	e9 d1 f1 ff ff       	jmp    801057d0 <alltraps>

801065ff <vector234>:
801065ff:	6a 00                	push   $0x0
80106601:	68 ea 00 00 00       	push   $0xea
80106606:	e9 c5 f1 ff ff       	jmp    801057d0 <alltraps>

8010660b <vector235>:
8010660b:	6a 00                	push   $0x0
8010660d:	68 eb 00 00 00       	push   $0xeb
80106612:	e9 b9 f1 ff ff       	jmp    801057d0 <alltraps>

80106617 <vector236>:
80106617:	6a 00                	push   $0x0
80106619:	68 ec 00 00 00       	push   $0xec
8010661e:	e9 ad f1 ff ff       	jmp    801057d0 <alltraps>

80106623 <vector237>:
80106623:	6a 00                	push   $0x0
80106625:	68 ed 00 00 00       	push   $0xed
8010662a:	e9 a1 f1 ff ff       	jmp    801057d0 <alltraps>

8010662f <vector238>:
8010662f:	6a 00                	push   $0x0
80106631:	68 ee 00 00 00       	push   $0xee
80106636:	e9 95 f1 ff ff       	jmp    801057d0 <alltraps>

8010663b <vector239>:
8010663b:	6a 00                	push   $0x0
8010663d:	68 ef 00 00 00       	push   $0xef
80106642:	e9 89 f1 ff ff       	jmp    801057d0 <alltraps>

80106647 <vector240>:
80106647:	6a 00                	push   $0x0
80106649:	68 f0 00 00 00       	push   $0xf0
8010664e:	e9 7d f1 ff ff       	jmp    801057d0 <alltraps>

80106653 <vector241>:
80106653:	6a 00                	push   $0x0
80106655:	68 f1 00 00 00       	push   $0xf1
8010665a:	e9 71 f1 ff ff       	jmp    801057d0 <alltraps>

8010665f <vector242>:
8010665f:	6a 00                	push   $0x0
80106661:	68 f2 00 00 00       	push   $0xf2
80106666:	e9 65 f1 ff ff       	jmp    801057d0 <alltraps>

8010666b <vector243>:
8010666b:	6a 00                	push   $0x0
8010666d:	68 f3 00 00 00       	push   $0xf3
80106672:	e9 59 f1 ff ff       	jmp    801057d0 <alltraps>

80106677 <vector244>:
80106677:	6a 00                	push   $0x0
80106679:	68 f4 00 00 00       	push   $0xf4
8010667e:	e9 4d f1 ff ff       	jmp    801057d0 <alltraps>

80106683 <vector245>:
80106683:	6a 00                	push   $0x0
80106685:	68 f5 00 00 00       	push   $0xf5
8010668a:	e9 41 f1 ff ff       	jmp    801057d0 <alltraps>

8010668f <vector246>:
8010668f:	6a 00                	push   $0x0
80106691:	68 f6 00 00 00       	push   $0xf6
80106696:	e9 35 f1 ff ff       	jmp    801057d0 <alltraps>

8010669b <vector247>:
8010669b:	6a 00                	push   $0x0
8010669d:	68 f7 00 00 00       	push   $0xf7
801066a2:	e9 29 f1 ff ff       	jmp    801057d0 <alltraps>

801066a7 <vector248>:
801066a7:	6a 00                	push   $0x0
801066a9:	68 f8 00 00 00       	push   $0xf8
801066ae:	e9 1d f1 ff ff       	jmp    801057d0 <alltraps>

801066b3 <vector249>:
801066b3:	6a 00                	push   $0x0
801066b5:	68 f9 00 00 00       	push   $0xf9
801066ba:	e9 11 f1 ff ff       	jmp    801057d0 <alltraps>

801066bf <vector250>:
801066bf:	6a 00                	push   $0x0
801066c1:	68 fa 00 00 00       	push   $0xfa
801066c6:	e9 05 f1 ff ff       	jmp    801057d0 <alltraps>

801066cb <vector251>:
801066cb:	6a 00                	push   $0x0
801066cd:	68 fb 00 00 00       	push   $0xfb
801066d2:	e9 f9 f0 ff ff       	jmp    801057d0 <alltraps>

801066d7 <vector252>:
801066d7:	6a 00                	push   $0x0
801066d9:	68 fc 00 00 00       	push   $0xfc
801066de:	e9 ed f0 ff ff       	jmp    801057d0 <alltraps>

801066e3 <vector253>:
801066e3:	6a 00                	push   $0x0
801066e5:	68 fd 00 00 00       	push   $0xfd
801066ea:	e9 e1 f0 ff ff       	jmp    801057d0 <alltraps>

801066ef <vector254>:
801066ef:	6a 00                	push   $0x0
801066f1:	68 fe 00 00 00       	push   $0xfe
801066f6:	e9 d5 f0 ff ff       	jmp    801057d0 <alltraps>

801066fb <vector255>:
801066fb:	6a 00                	push   $0x0
801066fd:	68 ff 00 00 00       	push   $0xff
80106702:	e9 c9 f0 ff ff       	jmp    801057d0 <alltraps>
80106707:	66 90                	xchg   %ax,%ax
80106709:	66 90                	xchg   %ax,%ax
8010670b:	66 90                	xchg   %ax,%ax
8010670d:	66 90                	xchg   %ax,%ax
8010670f:	90                   	nop

80106710 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106710:	55                   	push   %ebp
80106711:	89 e5                	mov    %esp,%ebp
80106713:	57                   	push   %edi
80106714:	56                   	push   %esi
80106715:	53                   	push   %ebx
80106716:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106718:	c1 ea 16             	shr    $0x16,%edx
8010671b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010671e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106721:	8b 07                	mov    (%edi),%eax
80106723:	a8 01                	test   $0x1,%al
80106725:	74 29                	je     80106750 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106727:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010672c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106732:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106735:	c1 eb 0a             	shr    $0xa,%ebx
80106738:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010673e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106741:	5b                   	pop    %ebx
80106742:	5e                   	pop    %esi
80106743:	5f                   	pop    %edi
80106744:	5d                   	pop    %ebp
80106745:	c3                   	ret    
80106746:	8d 76 00             	lea    0x0(%esi),%esi
80106749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106750:	85 c9                	test   %ecx,%ecx
80106752:	74 2c                	je     80106780 <walkpgdir+0x70>
80106754:	e8 37 bd ff ff       	call   80102490 <kalloc>
80106759:	85 c0                	test   %eax,%eax
8010675b:	89 c6                	mov    %eax,%esi
8010675d:	74 21                	je     80106780 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010675f:	83 ec 04             	sub    $0x4,%esp
80106762:	68 00 10 00 00       	push   $0x1000
80106767:	6a 00                	push   $0x0
80106769:	50                   	push   %eax
8010676a:	e8 c1 dd ff ff       	call   80104530 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010676f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106775:	83 c4 10             	add    $0x10,%esp
80106778:	83 c8 07             	or     $0x7,%eax
8010677b:	89 07                	mov    %eax,(%edi)
8010677d:	eb b3                	jmp    80106732 <walkpgdir+0x22>
8010677f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106780:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106783:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106785:	5b                   	pop    %ebx
80106786:	5e                   	pop    %esi
80106787:	5f                   	pop    %edi
80106788:	5d                   	pop    %ebp
80106789:	c3                   	ret    
8010678a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106790 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106790:	55                   	push   %ebp
80106791:	89 e5                	mov    %esp,%ebp
80106793:	57                   	push   %edi
80106794:	56                   	push   %esi
80106795:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106796:	89 d3                	mov    %edx,%ebx
80106798:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010679e:	83 ec 1c             	sub    $0x1c,%esp
801067a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801067b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801067b6:	29 df                	sub    %ebx,%edi
801067b8:	83 c8 01             	or     $0x1,%eax
801067bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801067be:	eb 15                	jmp    801067d5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801067c0:	f6 00 01             	testb  $0x1,(%eax)
801067c3:	75 45                	jne    8010680a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801067c5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801067c8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801067cb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801067cd:	74 31                	je     80106800 <mappages+0x70>
      break;
    a += PGSIZE;
801067cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801067d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801067dd:	89 da                	mov    %ebx,%edx
801067df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801067e2:	e8 29 ff ff ff       	call   80106710 <walkpgdir>
801067e7:	85 c0                	test   %eax,%eax
801067e9:	75 d5                	jne    801067c0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801067eb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801067ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801067f3:	5b                   	pop    %ebx
801067f4:	5e                   	pop    %esi
801067f5:	5f                   	pop    %edi
801067f6:	5d                   	pop    %ebp
801067f7:	c3                   	ret    
801067f8:	90                   	nop
801067f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106800:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106803:	31 c0                	xor    %eax,%eax
}
80106805:	5b                   	pop    %ebx
80106806:	5e                   	pop    %esi
80106807:	5f                   	pop    %edi
80106808:	5d                   	pop    %ebp
80106809:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010680a:	83 ec 0c             	sub    $0xc,%esp
8010680d:	68 74 7a 10 80       	push   $0x80107a74
80106812:	e8 59 9b ff ff       	call   80100370 <panic>
80106817:	89 f6                	mov    %esi,%esi
80106819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106820 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106820:	55                   	push   %ebp
80106821:	89 e5                	mov    %esp,%ebp
80106823:	57                   	push   %edi
80106824:	56                   	push   %esi
80106825:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106826:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010682c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010682e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106834:	83 ec 1c             	sub    $0x1c,%esp
80106837:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010683a:	39 d3                	cmp    %edx,%ebx
8010683c:	73 66                	jae    801068a4 <deallocuvm.part.0+0x84>
8010683e:	89 d6                	mov    %edx,%esi
80106840:	eb 3d                	jmp    8010687f <deallocuvm.part.0+0x5f>
80106842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106848:	8b 10                	mov    (%eax),%edx
8010684a:	f6 c2 01             	test   $0x1,%dl
8010684d:	74 26                	je     80106875 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010684f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106855:	74 58                	je     801068af <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106857:	83 ec 0c             	sub    $0xc,%esp
8010685a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106860:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106863:	52                   	push   %edx
80106864:	e8 77 ba ff ff       	call   801022e0 <kfree>
      *pte = 0;
80106869:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010686c:	83 c4 10             	add    $0x10,%esp
8010686f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106875:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010687b:	39 f3                	cmp    %esi,%ebx
8010687d:	73 25                	jae    801068a4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010687f:	31 c9                	xor    %ecx,%ecx
80106881:	89 da                	mov    %ebx,%edx
80106883:	89 f8                	mov    %edi,%eax
80106885:	e8 86 fe ff ff       	call   80106710 <walkpgdir>
    if(!pte)
8010688a:	85 c0                	test   %eax,%eax
8010688c:	75 ba                	jne    80106848 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010688e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106894:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010689a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068a0:	39 f3                	cmp    %esi,%ebx
801068a2:	72 db                	jb     8010687f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801068a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068aa:	5b                   	pop    %ebx
801068ab:	5e                   	pop    %esi
801068ac:	5f                   	pop    %edi
801068ad:	5d                   	pop    %ebp
801068ae:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801068af:	83 ec 0c             	sub    $0xc,%esp
801068b2:	68 e6 73 10 80       	push   $0x801073e6
801068b7:	e8 b4 9a ff ff       	call   80100370 <panic>
801068bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068c0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801068c6:	e8 b5 cf ff ff       	call   80103880 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801068cb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801068d1:	31 c9                	xor    %ecx,%ecx
801068d3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068d8:	66 89 90 f8 a7 14 80 	mov    %dx,-0x7feb5808(%eax)
801068df:	66 89 88 fa a7 14 80 	mov    %cx,-0x7feb5806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801068e6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068eb:	31 c9                	xor    %ecx,%ecx
801068ed:	66 89 90 00 a8 14 80 	mov    %dx,-0x7feb5800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801068f4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801068f9:	66 89 88 02 a8 14 80 	mov    %cx,-0x7feb57fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106900:	31 c9                	xor    %ecx,%ecx
80106902:	66 89 90 08 a8 14 80 	mov    %dx,-0x7feb57f8(%eax)
80106909:	66 89 88 0a a8 14 80 	mov    %cx,-0x7feb57f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106910:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106915:	31 c9                	xor    %ecx,%ecx
80106917:	66 89 90 10 a8 14 80 	mov    %dx,-0x7feb57f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010691e:	c6 80 fc a7 14 80 00 	movb   $0x0,-0x7feb5804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106925:	ba 2f 00 00 00       	mov    $0x2f,%edx
8010692a:	c6 80 fd a7 14 80 9a 	movb   $0x9a,-0x7feb5803(%eax)
80106931:	c6 80 fe a7 14 80 cf 	movb   $0xcf,-0x7feb5802(%eax)
80106938:	c6 80 ff a7 14 80 00 	movb   $0x0,-0x7feb5801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010693f:	c6 80 04 a8 14 80 00 	movb   $0x0,-0x7feb57fc(%eax)
80106946:	c6 80 05 a8 14 80 92 	movb   $0x92,-0x7feb57fb(%eax)
8010694d:	c6 80 06 a8 14 80 cf 	movb   $0xcf,-0x7feb57fa(%eax)
80106954:	c6 80 07 a8 14 80 00 	movb   $0x0,-0x7feb57f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010695b:	c6 80 0c a8 14 80 00 	movb   $0x0,-0x7feb57f4(%eax)
80106962:	c6 80 0d a8 14 80 fa 	movb   $0xfa,-0x7feb57f3(%eax)
80106969:	c6 80 0e a8 14 80 cf 	movb   $0xcf,-0x7feb57f2(%eax)
80106970:	c6 80 0f a8 14 80 00 	movb   $0x0,-0x7feb57f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106977:	66 89 88 12 a8 14 80 	mov    %cx,-0x7feb57ee(%eax)
8010697e:	c6 80 14 a8 14 80 00 	movb   $0x0,-0x7feb57ec(%eax)
80106985:	c6 80 15 a8 14 80 f2 	movb   $0xf2,-0x7feb57eb(%eax)
8010698c:	c6 80 16 a8 14 80 cf 	movb   $0xcf,-0x7feb57ea(%eax)
80106993:	c6 80 17 a8 14 80 00 	movb   $0x0,-0x7feb57e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
8010699a:	05 f0 a7 14 80       	add    $0x8014a7f0,%eax
8010699f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801069a3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801069a7:	c1 e8 10             	shr    $0x10,%eax
801069aa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801069ae:	8d 45 f2             	lea    -0xe(%ebp),%eax
801069b1:	0f 01 10             	lgdtl  (%eax)
}
801069b4:	c9                   	leave  
801069b5:	c3                   	ret    
801069b6:	8d 76 00             	lea    0x0(%esi),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069c0:	a1 a4 d4 14 80       	mov    0x8014d4a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801069c5:	55                   	push   %ebp
801069c6:	89 e5                	mov    %esp,%ebp
801069c8:	05 00 00 00 80       	add    $0x80000000,%eax
801069cd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
801069d0:	5d                   	pop    %ebp
801069d1:	c3                   	ret    
801069d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069e0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	57                   	push   %edi
801069e4:	56                   	push   %esi
801069e5:	53                   	push   %ebx
801069e6:	83 ec 1c             	sub    $0x1c,%esp
801069e9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801069ec:	85 f6                	test   %esi,%esi
801069ee:	0f 84 cd 00 00 00    	je     80106ac1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801069f4:	8b 46 08             	mov    0x8(%esi),%eax
801069f7:	85 c0                	test   %eax,%eax
801069f9:	0f 84 dc 00 00 00    	je     80106adb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801069ff:	8b 7e 04             	mov    0x4(%esi),%edi
80106a02:	85 ff                	test   %edi,%edi
80106a04:	0f 84 c4 00 00 00    	je     80106ace <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106a0a:	e8 71 d9 ff ff       	call   80104380 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a0f:	e8 ec cd ff ff       	call   80103800 <mycpu>
80106a14:	89 c3                	mov    %eax,%ebx
80106a16:	e8 e5 cd ff ff       	call   80103800 <mycpu>
80106a1b:	89 c7                	mov    %eax,%edi
80106a1d:	e8 de cd ff ff       	call   80103800 <mycpu>
80106a22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a25:	83 c7 08             	add    $0x8,%edi
80106a28:	e8 d3 cd ff ff       	call   80103800 <mycpu>
80106a2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a30:	83 c0 08             	add    $0x8,%eax
80106a33:	ba 67 00 00 00       	mov    $0x67,%edx
80106a38:	c1 e8 18             	shr    $0x18,%eax
80106a3b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106a42:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106a49:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106a50:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106a57:	83 c1 08             	add    $0x8,%ecx
80106a5a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106a60:	c1 e9 10             	shr    $0x10,%ecx
80106a63:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a69:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106a6e:	e8 8d cd ff ff       	call   80103800 <mycpu>
80106a73:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a7a:	e8 81 cd ff ff       	call   80103800 <mycpu>
80106a7f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106a84:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a88:	e8 73 cd ff ff       	call   80103800 <mycpu>
80106a8d:	8b 56 08             	mov    0x8(%esi),%edx
80106a90:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106a96:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a99:	e8 62 cd ff ff       	call   80103800 <mycpu>
80106a9e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106aa2:	b8 28 00 00 00       	mov    $0x28,%eax
80106aa7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106aaa:	8b 46 04             	mov    0x4(%esi),%eax
80106aad:	05 00 00 00 80       	add    $0x80000000,%eax
80106ab2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106ab5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ab8:	5b                   	pop    %ebx
80106ab9:	5e                   	pop    %esi
80106aba:	5f                   	pop    %edi
80106abb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106abc:	e9 af d9 ff ff       	jmp    80104470 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106ac1:	83 ec 0c             	sub    $0xc,%esp
80106ac4:	68 7a 7a 10 80       	push   $0x80107a7a
80106ac9:	e8 a2 98 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106ace:	83 ec 0c             	sub    $0xc,%esp
80106ad1:	68 a5 7a 10 80       	push   $0x80107aa5
80106ad6:	e8 95 98 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106adb:	83 ec 0c             	sub    $0xc,%esp
80106ade:	68 90 7a 10 80       	push   $0x80107a90
80106ae3:	e8 88 98 ff ff       	call   80100370 <panic>
80106ae8:	90                   	nop
80106ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106af0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	57                   	push   %edi
80106af4:	56                   	push   %esi
80106af5:	53                   	push   %ebx
80106af6:	83 ec 1c             	sub    $0x1c,%esp
80106af9:	8b 75 10             	mov    0x10(%ebp),%esi
80106afc:	8b 45 08             	mov    0x8(%ebp),%eax
80106aff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106b02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106b08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106b0b:	77 49                	ja     80106b56 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106b0d:	e8 7e b9 ff ff       	call   80102490 <kalloc>
  memset(mem, 0, PGSIZE);
80106b12:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106b15:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b17:	68 00 10 00 00       	push   $0x1000
80106b1c:	6a 00                	push   $0x0
80106b1e:	50                   	push   %eax
80106b1f:	e8 0c da ff ff       	call   80104530 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b24:	58                   	pop    %eax
80106b25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b2b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b30:	5a                   	pop    %edx
80106b31:	6a 06                	push   $0x6
80106b33:	50                   	push   %eax
80106b34:	31 d2                	xor    %edx,%edx
80106b36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b39:	e8 52 fc ff ff       	call   80106790 <mappages>
  memmove(mem, init, sz);
80106b3e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b41:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b44:	83 c4 10             	add    $0x10,%esp
80106b47:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b4d:	5b                   	pop    %ebx
80106b4e:	5e                   	pop    %esi
80106b4f:	5f                   	pop    %edi
80106b50:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106b51:	e9 8a da ff ff       	jmp    801045e0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106b56:	83 ec 0c             	sub    $0xc,%esp
80106b59:	68 b9 7a 10 80       	push   $0x80107ab9
80106b5e:	e8 0d 98 ff ff       	call   80100370 <panic>
80106b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b70 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106b79:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b80:	0f 85 91 00 00 00    	jne    80106c17 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106b86:	8b 75 18             	mov    0x18(%ebp),%esi
80106b89:	31 db                	xor    %ebx,%ebx
80106b8b:	85 f6                	test   %esi,%esi
80106b8d:	75 1a                	jne    80106ba9 <loaduvm+0x39>
80106b8f:	eb 6f                	jmp    80106c00 <loaduvm+0x90>
80106b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b9e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ba4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ba7:	76 57                	jbe    80106c00 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ba9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bac:	8b 45 08             	mov    0x8(%ebp),%eax
80106baf:	31 c9                	xor    %ecx,%ecx
80106bb1:	01 da                	add    %ebx,%edx
80106bb3:	e8 58 fb ff ff       	call   80106710 <walkpgdir>
80106bb8:	85 c0                	test   %eax,%eax
80106bba:	74 4e                	je     80106c0a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106bbc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bbe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106bc1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106bc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bcb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bd1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bd4:	01 d9                	add    %ebx,%ecx
80106bd6:	05 00 00 00 80       	add    $0x80000000,%eax
80106bdb:	57                   	push   %edi
80106bdc:	51                   	push   %ecx
80106bdd:	50                   	push   %eax
80106bde:	ff 75 10             	pushl  0x10(%ebp)
80106be1:	e8 6a ad ff ff       	call   80101950 <readi>
80106be6:	83 c4 10             	add    $0x10,%esp
80106be9:	39 c7                	cmp    %eax,%edi
80106beb:	74 ab                	je     80106b98 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106bf5:	5b                   	pop    %ebx
80106bf6:	5e                   	pop    %esi
80106bf7:	5f                   	pop    %edi
80106bf8:	5d                   	pop    %ebp
80106bf9:	c3                   	ret    
80106bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106c03:	31 c0                	xor    %eax,%eax
}
80106c05:	5b                   	pop    %ebx
80106c06:	5e                   	pop    %esi
80106c07:	5f                   	pop    %edi
80106c08:	5d                   	pop    %ebp
80106c09:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106c0a:	83 ec 0c             	sub    $0xc,%esp
80106c0d:	68 d3 7a 10 80       	push   $0x80107ad3
80106c12:	e8 59 97 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106c17:	83 ec 0c             	sub    $0xc,%esp
80106c1a:	68 74 7b 10 80       	push   $0x80107b74
80106c1f:	e8 4c 97 ff ff       	call   80100370 <panic>
80106c24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c30 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	57                   	push   %edi
80106c34:	56                   	push   %esi
80106c35:	53                   	push   %ebx
80106c36:	83 ec 0c             	sub    $0xc,%esp
80106c39:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106c3c:	85 ff                	test   %edi,%edi
80106c3e:	0f 88 ca 00 00 00    	js     80106d0e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106c44:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106c4a:	0f 82 82 00 00 00    	jb     80106cd2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106c50:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c56:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c5c:	39 df                	cmp    %ebx,%edi
80106c5e:	77 43                	ja     80106ca3 <allocuvm+0x73>
80106c60:	e9 bb 00 00 00       	jmp    80106d20 <allocuvm+0xf0>
80106c65:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106c68:	83 ec 04             	sub    $0x4,%esp
80106c6b:	68 00 10 00 00       	push   $0x1000
80106c70:	6a 00                	push   $0x0
80106c72:	50                   	push   %eax
80106c73:	e8 b8 d8 ff ff       	call   80104530 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c78:	58                   	pop    %eax
80106c79:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c7f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c84:	5a                   	pop    %edx
80106c85:	6a 06                	push   $0x6
80106c87:	50                   	push   %eax
80106c88:	89 da                	mov    %ebx,%edx
80106c8a:	8b 45 08             	mov    0x8(%ebp),%eax
80106c8d:	e8 fe fa ff ff       	call   80106790 <mappages>
80106c92:	83 c4 10             	add    $0x10,%esp
80106c95:	85 c0                	test   %eax,%eax
80106c97:	78 47                	js     80106ce0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106c99:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c9f:	39 df                	cmp    %ebx,%edi
80106ca1:	76 7d                	jbe    80106d20 <allocuvm+0xf0>
    mem = kalloc();
80106ca3:	e8 e8 b7 ff ff       	call   80102490 <kalloc>
    if(mem == 0){
80106ca8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106caa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106cac:	75 ba                	jne    80106c68 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106cae:	83 ec 0c             	sub    $0xc,%esp
80106cb1:	68 f1 7a 10 80       	push   $0x80107af1
80106cb6:	e8 a5 99 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106cbb:	83 c4 10             	add    $0x10,%esp
80106cbe:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106cc1:	76 4b                	jbe    80106d0e <allocuvm+0xde>
80106cc3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106cc6:	8b 45 08             	mov    0x8(%ebp),%eax
80106cc9:	89 fa                	mov    %edi,%edx
80106ccb:	e8 50 fb ff ff       	call   80106820 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106cd0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cd5:	5b                   	pop    %ebx
80106cd6:	5e                   	pop    %esi
80106cd7:	5f                   	pop    %edi
80106cd8:	5d                   	pop    %ebp
80106cd9:	c3                   	ret    
80106cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ce0:	83 ec 0c             	sub    $0xc,%esp
80106ce3:	68 09 7b 10 80       	push   $0x80107b09
80106ce8:	e8 73 99 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ced:	83 c4 10             	add    $0x10,%esp
80106cf0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106cf3:	76 0d                	jbe    80106d02 <allocuvm+0xd2>
80106cf5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106cf8:	8b 45 08             	mov    0x8(%ebp),%eax
80106cfb:	89 fa                	mov    %edi,%edx
80106cfd:	e8 1e fb ff ff       	call   80106820 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106d02:	83 ec 0c             	sub    $0xc,%esp
80106d05:	56                   	push   %esi
80106d06:	e8 d5 b5 ff ff       	call   801022e0 <kfree>
      return 0;
80106d0b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106d0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106d11:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106d13:	5b                   	pop    %ebx
80106d14:	5e                   	pop    %esi
80106d15:	5f                   	pop    %edi
80106d16:	5d                   	pop    %ebp
80106d17:	c3                   	ret    
80106d18:	90                   	nop
80106d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106d23:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106d25:	5b                   	pop    %ebx
80106d26:	5e                   	pop    %esi
80106d27:	5f                   	pop    %edi
80106d28:	5d                   	pop    %ebp
80106d29:	c3                   	ret    
80106d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d30 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d36:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d39:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106d3c:	39 d1                	cmp    %edx,%ecx
80106d3e:	73 10                	jae    80106d50 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106d40:	5d                   	pop    %ebp
80106d41:	e9 da fa ff ff       	jmp    80106820 <deallocuvm.part.0>
80106d46:	8d 76 00             	lea    0x0(%esi),%esi
80106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d50:	89 d0                	mov    %edx,%eax
80106d52:	5d                   	pop    %ebp
80106d53:	c3                   	ret    
80106d54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d60 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 0c             	sub    $0xc,%esp
80106d69:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d6c:	85 f6                	test   %esi,%esi
80106d6e:	74 59                	je     80106dc9 <freevm+0x69>
80106d70:	31 c9                	xor    %ecx,%ecx
80106d72:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d77:	89 f0                	mov    %esi,%eax
80106d79:	e8 a2 fa ff ff       	call   80106820 <deallocuvm.part.0>
80106d7e:	89 f3                	mov    %esi,%ebx
80106d80:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d86:	eb 0f                	jmp    80106d97 <freevm+0x37>
80106d88:	90                   	nop
80106d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d90:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106d93:	39 fb                	cmp    %edi,%ebx
80106d95:	74 23                	je     80106dba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106d97:	8b 03                	mov    (%ebx),%eax
80106d99:	a8 01                	test   $0x1,%al
80106d9b:	74 f3                	je     80106d90 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106d9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106da2:	83 ec 0c             	sub    $0xc,%esp
80106da5:	83 c3 04             	add    $0x4,%ebx
80106da8:	05 00 00 00 80       	add    $0x80000000,%eax
80106dad:	50                   	push   %eax
80106dae:	e8 2d b5 ff ff       	call   801022e0 <kfree>
80106db3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106db6:	39 fb                	cmp    %edi,%ebx
80106db8:	75 dd                	jne    80106d97 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106dba:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106dbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dc0:	5b                   	pop    %ebx
80106dc1:	5e                   	pop    %esi
80106dc2:	5f                   	pop    %edi
80106dc3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106dc4:	e9 17 b5 ff ff       	jmp    801022e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106dc9:	83 ec 0c             	sub    $0xc,%esp
80106dcc:	68 25 7b 10 80       	push   $0x80107b25
80106dd1:	e8 9a 95 ff ff       	call   80100370 <panic>
80106dd6:	8d 76 00             	lea    0x0(%esi),%esi
80106dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106de0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	56                   	push   %esi
80106de4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106de5:	e8 a6 b6 ff ff       	call   80102490 <kalloc>
80106dea:	85 c0                	test   %eax,%eax
80106dec:	74 6a                	je     80106e58 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106dee:	83 ec 04             	sub    $0x4,%esp
80106df1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106df3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106df8:	68 00 10 00 00       	push   $0x1000
80106dfd:	6a 00                	push   $0x0
80106dff:	50                   	push   %eax
80106e00:	e8 2b d7 ff ff       	call   80104530 <memset>
80106e05:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e08:	8b 43 04             	mov    0x4(%ebx),%eax
80106e0b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e0e:	83 ec 08             	sub    $0x8,%esp
80106e11:	8b 13                	mov    (%ebx),%edx
80106e13:	ff 73 0c             	pushl  0xc(%ebx)
80106e16:	50                   	push   %eax
80106e17:	29 c1                	sub    %eax,%ecx
80106e19:	89 f0                	mov    %esi,%eax
80106e1b:	e8 70 f9 ff ff       	call   80106790 <mappages>
80106e20:	83 c4 10             	add    $0x10,%esp
80106e23:	85 c0                	test   %eax,%eax
80106e25:	78 19                	js     80106e40 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e27:	83 c3 10             	add    $0x10,%ebx
80106e2a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e30:	75 d6                	jne    80106e08 <setupkvm+0x28>
80106e32:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106e34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e37:	5b                   	pop    %ebx
80106e38:	5e                   	pop    %esi
80106e39:	5d                   	pop    %ebp
80106e3a:	c3                   	ret    
80106e3b:	90                   	nop
80106e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	56                   	push   %esi
80106e44:	e8 17 ff ff ff       	call   80106d60 <freevm>
      return 0;
80106e49:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106e4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106e4f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106e51:	5b                   	pop    %ebx
80106e52:	5e                   	pop    %esi
80106e53:	5d                   	pop    %ebp
80106e54:	c3                   	ret    
80106e55:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106e58:	31 c0                	xor    %eax,%eax
80106e5a:	eb d8                	jmp    80106e34 <setupkvm+0x54>
80106e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e60 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e66:	e8 75 ff ff ff       	call   80106de0 <setupkvm>
80106e6b:	a3 a4 d4 14 80       	mov    %eax,0x8014d4a4
80106e70:	05 00 00 00 80       	add    $0x80000000,%eax
80106e75:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106e78:	c9                   	leave  
80106e79:	c3                   	ret    
80106e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e81:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e83:	89 e5                	mov    %esp,%ebp
80106e85:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e88:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e8e:	e8 7d f8 ff ff       	call   80106710 <walkpgdir>
  if(pte == 0)
80106e93:	85 c0                	test   %eax,%eax
80106e95:	74 05                	je     80106e9c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106e97:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106e9a:	c9                   	leave  
80106e9b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106e9c:	83 ec 0c             	sub    $0xc,%esp
80106e9f:	68 36 7b 10 80       	push   $0x80107b36
80106ea4:	e8 c7 94 ff ff       	call   80100370 <panic>
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106eb0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	57                   	push   %edi
80106eb4:	56                   	push   %esi
80106eb5:	53                   	push   %ebx
80106eb6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106eb9:	e8 22 ff ff ff       	call   80106de0 <setupkvm>
80106ebe:	85 c0                	test   %eax,%eax
80106ec0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ec3:	0f 84 b2 00 00 00    	je     80106f7b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ec9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ecc:	85 c9                	test   %ecx,%ecx
80106ece:	0f 84 9c 00 00 00    	je     80106f70 <copyuvm+0xc0>
80106ed4:	31 f6                	xor    %esi,%esi
80106ed6:	eb 4a                	jmp    80106f22 <copyuvm+0x72>
80106ed8:	90                   	nop
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106ee0:	83 ec 04             	sub    $0x4,%esp
80106ee3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106ee9:	68 00 10 00 00       	push   $0x1000
80106eee:	57                   	push   %edi
80106eef:	50                   	push   %eax
80106ef0:	e8 eb d6 ff ff       	call   801045e0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106ef5:	58                   	pop    %eax
80106ef6:	5a                   	pop    %edx
80106ef7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106efd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f00:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f03:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f08:	52                   	push   %edx
80106f09:	89 f2                	mov    %esi,%edx
80106f0b:	e8 80 f8 ff ff       	call   80106790 <mappages>
80106f10:	83 c4 10             	add    $0x10,%esp
80106f13:	85 c0                	test   %eax,%eax
80106f15:	78 3e                	js     80106f55 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f17:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f1d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106f20:	76 4e                	jbe    80106f70 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f22:	8b 45 08             	mov    0x8(%ebp),%eax
80106f25:	31 c9                	xor    %ecx,%ecx
80106f27:	89 f2                	mov    %esi,%edx
80106f29:	e8 e2 f7 ff ff       	call   80106710 <walkpgdir>
80106f2e:	85 c0                	test   %eax,%eax
80106f30:	74 5a                	je     80106f8c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106f32:	8b 18                	mov    (%eax),%ebx
80106f34:	f6 c3 01             	test   $0x1,%bl
80106f37:	74 46                	je     80106f7f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106f39:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80106f3b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80106f41:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106f44:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106f4a:	e8 41 b5 ff ff       	call   80102490 <kalloc>
80106f4f:	85 c0                	test   %eax,%eax
80106f51:	89 c3                	mov    %eax,%ebx
80106f53:	75 8b                	jne    80106ee0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106f55:	83 ec 0c             	sub    $0xc,%esp
80106f58:	ff 75 e0             	pushl  -0x20(%ebp)
80106f5b:	e8 00 fe ff ff       	call   80106d60 <freevm>
  return 0;
80106f60:	83 c4 10             	add    $0x10,%esp
80106f63:	31 c0                	xor    %eax,%eax
}
80106f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f68:	5b                   	pop    %ebx
80106f69:	5e                   	pop    %esi
80106f6a:	5f                   	pop    %edi
80106f6b:	5d                   	pop    %ebp
80106f6c:	c3                   	ret    
80106f6d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f70:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106f73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f76:	5b                   	pop    %ebx
80106f77:	5e                   	pop    %esi
80106f78:	5f                   	pop    %edi
80106f79:	5d                   	pop    %ebp
80106f7a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106f7b:	31 c0                	xor    %eax,%eax
80106f7d:	eb e6                	jmp    80106f65 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106f7f:	83 ec 0c             	sub    $0xc,%esp
80106f82:	68 5a 7b 10 80       	push   $0x80107b5a
80106f87:	e8 e4 93 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106f8c:	83 ec 0c             	sub    $0xc,%esp
80106f8f:	68 40 7b 10 80       	push   $0x80107b40
80106f94:	e8 d7 93 ff ff       	call   80100370 <panic>
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fa0 <copyuvmcow>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvmcow(pde_t *pgdir, uint sz)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	57                   	push   %edi
80106fa4:	56                   	push   %esi
80106fa5:	53                   	push   %ebx
80106fa6:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
80106fa9:	e8 32 fe ff ff       	call   80106de0 <setupkvm>
80106fae:	85 c0                	test   %eax,%eax
80106fb0:	0f 84 af 00 00 00    	je     80107065 <copyuvmcow+0xc5>
80106fb6:	89 c7                	mov    %eax,%edi
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fbb:	31 db                	xor    %ebx,%ebx
80106fbd:	85 c0                	test   %eax,%eax
80106fbf:	75 26                	jne    80106fe7 <copyuvmcow+0x47>
80106fc1:	e9 8a 00 00 00       	jmp    80107050 <copyuvmcow+0xb0>
80106fc6:	8d 76 00             	lea    0x0(%esi),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *pte &= ~PTE_W; 
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    addRefCount(pa);
80106fd0:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fd3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    *pte &= ~PTE_W; 
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    addRefCount(pa);
80106fd9:	56                   	push   %esi
80106fda:	e8 21 b5 ff ff       	call   80102500 <addRefCount>
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106fdf:	83 c4 10             	add    $0x10,%esp
80106fe2:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106fe5:	76 69                	jbe    80107050 <copyuvmcow+0xb0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80106fea:	31 c9                	xor    %ecx,%ecx
80106fec:	89 da                	mov    %ebx,%edx
80106fee:	e8 1d f7 ff ff       	call   80106710 <walkpgdir>
80106ff3:	85 c0                	test   %eax,%eax
80106ff5:	74 7f                	je     80107076 <copyuvmcow+0xd6>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106ff7:	8b 10                	mov    (%eax),%edx
80106ff9:	f6 c2 01             	test   $0x1,%dl
80106ffc:	74 6b                	je     80107069 <copyuvmcow+0xc9>
      panic("copyuvm: page not present");
    *pte &= ~PTE_W; 
80106ffe:	89 d1                	mov    %edx,%ecx
    pa = PTE_ADDR(*pte);
80107000:	89 d6                	mov    %edx,%esi
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107002:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W; 
80107005:	83 e1 fd             	and    $0xfffffffd,%ecx
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107008:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W; 
    pa = PTE_ADDR(*pte);
8010700e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W; 
80107014:	89 08                	mov    %ecx,(%eax)
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107016:	52                   	push   %edx
80107017:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010701c:	56                   	push   %esi
8010701d:	89 da                	mov    %ebx,%edx
8010701f:	89 f8                	mov    %edi,%eax
80107021:	e8 6a f7 ff ff       	call   80106790 <mappages>
80107026:	83 c4 10             	add    $0x10,%esp
80107029:	85 c0                	test   %eax,%eax
8010702b:	79 a3                	jns    80106fd0 <copyuvmcow+0x30>
  lcr3(V2P(pgdir));
  return d;
//         setar bit extra como flag de cow(flag PTE_COW)
//         implementar trap de PAGEFAULT
bad:
  freevm(d);
8010702d:	83 ec 0c             	sub    $0xc,%esp
80107030:	57                   	push   %edi
80107031:	e8 2a fd ff ff       	call   80106d60 <freevm>
80107036:	8b 45 08             	mov    0x8(%ebp),%eax
80107039:	05 00 00 00 80       	add    $0x80000000,%eax
8010703e:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(pgdir));
  return 0;
80107041:	31 c0                	xor    %eax,%eax
80107043:	83 c4 10             	add    $0x10,%esp
}
80107046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107049:	5b                   	pop    %ebx
8010704a:	5e                   	pop    %esi
8010704b:	5f                   	pop    %edi
8010704c:	5d                   	pop    %ebp
8010704d:	c3                   	ret    
8010704e:	66 90                	xchg   %ax,%ax
80107050:	8b 45 08             	mov    0x8(%ebp),%eax
80107053:	05 00 00 00 80       	add    $0x80000000,%eax
80107058:	0f 22 d8             	mov    %eax,%cr3
8010705b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    addRefCount(pa);
  }
  lcr3(V2P(pgdir));
  return d;
8010705e:	89 f8                	mov    %edi,%eax
//         implementar trap de PAGEFAULT
bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107060:	5b                   	pop    %ebx
80107061:	5e                   	pop    %esi
80107062:	5f                   	pop    %edi
80107063:	5d                   	pop    %ebp
80107064:	c3                   	ret    
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
80107065:	31 c0                	xor    %eax,%eax
80107067:	eb dd                	jmp    80107046 <copyuvmcow+0xa6>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107069:	83 ec 0c             	sub    $0xc,%esp
8010706c:	68 5a 7b 10 80       	push   $0x80107b5a
80107071:	e8 fa 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107076:	83 ec 0c             	sub    $0xc,%esp
80107079:	68 40 7b 10 80       	push   $0x80107b40
8010707e:	e8 ed 92 ff ff       	call   80100370 <panic>
80107083:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107090 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107090:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107091:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107093:	89 e5                	mov    %esp,%ebp
80107095:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107098:	8b 55 0c             	mov    0xc(%ebp),%edx
8010709b:	8b 45 08             	mov    0x8(%ebp),%eax
8010709e:	e8 6d f6 ff ff       	call   80106710 <walkpgdir>
  if((*pte & PTE_P) == 0)
801070a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801070a5:	89 c2                	mov    %eax,%edx
801070a7:	83 e2 05             	and    $0x5,%edx
801070aa:	83 fa 05             	cmp    $0x5,%edx
801070ad:	75 11                	jne    801070c0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801070b4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801070b5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801070ba:	c3                   	ret    
801070bb:	90                   	nop
801070bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801070c0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801070c2:	c9                   	leave  
801070c3:	c3                   	ret    
801070c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
801070d6:	83 ec 1c             	sub    $0x1c,%esp
801070d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801070dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801070df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070e2:	85 db                	test   %ebx,%ebx
801070e4:	75 40                	jne    80107126 <copyout+0x56>
801070e6:	eb 70                	jmp    80107158 <copyout+0x88>
801070e8:	90                   	nop
801070e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801070f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070f3:	89 f1                	mov    %esi,%ecx
801070f5:	29 d1                	sub    %edx,%ecx
801070f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801070fd:	39 d9                	cmp    %ebx,%ecx
801070ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107102:	29 f2                	sub    %esi,%edx
80107104:	83 ec 04             	sub    $0x4,%esp
80107107:	01 d0                	add    %edx,%eax
80107109:	51                   	push   %ecx
8010710a:	57                   	push   %edi
8010710b:	50                   	push   %eax
8010710c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010710f:	e8 cc d4 ff ff       	call   801045e0 <memmove>
    len -= n;
    buf += n;
80107114:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107117:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010711a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107120:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107122:	29 cb                	sub    %ecx,%ebx
80107124:	74 32                	je     80107158 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107126:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107128:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010712b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010712e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107134:	56                   	push   %esi
80107135:	ff 75 08             	pushl  0x8(%ebp)
80107138:	e8 53 ff ff ff       	call   80107090 <uva2ka>
    if(pa0 == 0)
8010713d:	83 c4 10             	add    $0x10,%esp
80107140:	85 c0                	test   %eax,%eax
80107142:	75 ac                	jne    801070f0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107144:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010714c:	5b                   	pop    %ebx
8010714d:	5e                   	pop    %esi
8010714e:	5f                   	pop    %edi
8010714f:	5d                   	pop    %ebp
80107150:	c3                   	ret    
80107151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010715b:	31 c0                	xor    %eax,%eax
}
8010715d:	5b                   	pop    %ebx
8010715e:	5e                   	pop    %esi
8010715f:	5f                   	pop    %edi
80107160:	5d                   	pop    %ebp
80107161:	c3                   	ret    
