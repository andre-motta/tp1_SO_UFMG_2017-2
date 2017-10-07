
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

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
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 74 10 80       	push   $0x801074a0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 d5 43 00 00       	call   80104430 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
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
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 74 10 80       	push   $0x801074a7
80100097:	50                   	push   %eax
80100098:	e8 83 42 00 00       	call   80104320 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax

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
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
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
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 47 44 00 00       	call   80104530 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 e9 44 00 00       	call   80104650 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 41 00 00       	call   80104360 <acquiresleep>
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
80100193:	68 ae 74 10 80       	push   $0x801074ae
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
801001ae:	e8 4d 42 00 00       	call   80104400 <holdingsleep>
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
801001cc:	68 bf 74 10 80       	push   $0x801074bf
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
801001ef:	e8 0c 42 00 00       	call   80104400 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 41 00 00       	call   801043c0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 20 43 00 00       	call   80104530 <acquire>
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
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
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
8010025c:	e9 ef 43 00 00       	jmp    80104650 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 74 10 80       	push   $0x801074c6
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
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 9f 42 00 00       	call   80104530 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002a6:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 b5 10 80       	push   $0x8010b520
801002b8:	68 a0 0f 11 80       	push   $0x80110fa0
801002bd:	e8 fe 3c 00 00       	call   80103fc0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 c9 35 00 00       	call   801038a0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 b5 10 80       	push   $0x8010b520
801002e6:	e8 65 43 00 00       	call   80104650 <release>
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
8010030b:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 0f 11 80 	movsbl -0x7feef0e0(%edx),%edx
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
80100341:	68 20 b5 10 80       	push   $0x8010b520
80100346:	e8 05 43 00 00       	call   80104650 <release>
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
80100360:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
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
80100379:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
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
80100392:	68 cd 74 10 80       	push   $0x801074cd
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 7a 7f 10 80 	movl   $0x80107f7a,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 93 40 00 00       	call   80104450 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 74 10 80       	push   $0x801074e1
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
801003d9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
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
801003f0:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
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
8010041a:	e8 c1 59 00 00       	call   80105de0 <uartputc>
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
801004d3:	e8 08 59 00 00       	call   80105de0 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 fc 58 00 00       	call   80105de0 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 f0 58 00 00       	call   80105de0 <uartputc>
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
80100514:	e8 37 42 00 00       	call   80104750 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 72 41 00 00       	call   801046a0 <memset>
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
80100540:	68 e5 74 10 80       	push   $0x801074e5
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
801005b1:	0f b6 92 10 75 10 80 	movzbl -0x7fef8af0(%edx),%edx
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
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 10 3f 00 00       	call   80104530 <acquire>
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
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 04 40 00 00       	call   80104650 <release>
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
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
80100708:	68 20 b5 10 80       	push   $0x8010b520
8010070d:	e8 3e 3f 00 00       	call   80104650 <release>
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
80100788:	b8 f8 74 10 80       	mov    $0x801074f8,%eax
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
801007c3:	68 20 b5 10 80       	push   $0x8010b520
801007c8:	e8 63 3d 00 00       	call   80104530 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 ff 74 10 80       	push   $0x801074ff
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
801007fe:	68 20 b5 10 80       	push   $0x8010b520
80100803:	e8 28 3d 00 00       	call   80104530 <acquire>
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
80100831:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100836:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
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
80100863:	68 20 b5 10 80       	push   $0x8010b520
80100868:	e8 e3 3d 00 00       	call   80104650 <release>
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
80100889:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
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
801008a8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
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
801008ec:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
801008f1:	68 a0 0f 11 80       	push   $0x80110fa0
801008f6:	e8 75 38 00 00       	call   80104170 <wakeup>
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
80100908:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010090d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100934:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
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
80100948:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
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
80100977:	e9 e4 38 00 00       	jmp    80104260 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
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
801009a6:	68 08 75 10 80       	push   $0x80107508
801009ab:	68 20 b5 10 80       	push   $0x8010b520
801009b0:	e8 7b 3a 00 00       	call   80104430 <initlock>

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
801009bb:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
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
80100a74:	e8 f7 64 00 00       	call   80106f70 <setupkvm>
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
80100b04:	e8 b7 62 00 00       	call   80106dc0 <allocuvm>
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
80100b3a:	e8 c1 61 00 00       	call   80106d00 <loaduvm>
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
80100b59:	e8 92 63 00 00       	call   80106ef0 <freevm>
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
80100b95:	e8 26 62 00 00       	call   80106dc0 <allocuvm>
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
80100bac:	e8 3f 63 00 00       	call   80106ef0 <freevm>
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
80100bc6:	68 21 75 10 80       	push   $0x80107521
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
80100bf1:	e8 1a 64 00 00       	call   80107010 <clearpteu>
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
80100c2d:	e8 ae 3c 00 00       	call   801048e0 <strlen>
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
80100c40:	e8 9b 3c 00 00       	call   801048e0 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 2a 66 00 00       	call   80107280 <copyout>
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
80100cbb:	e8 c0 65 00 00       	call   80107280 <copyout>
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
80100d00:	e8 9b 3b 00 00       	call   801048a0 <safestrcpy>

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
80100d2c:	e8 3f 5e 00 00       	call   80106b70 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 b7 61 00 00       	call   80106ef0 <freevm>
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
80100d56:	68 2d 75 10 80       	push   $0x8010752d
80100d5b:	68 c0 0f 11 80       	push   $0x80110fc0
80100d60:	e8 cb 36 00 00       	call   80104430 <initlock>
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
80100d74:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 c0 0f 11 80       	push   $0x80110fc0
80100d81:	e8 aa 37 00 00       	call   80104530 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 19 11 80    	cmp    $0x80111954,%ebx
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
80100dac:	68 c0 0f 11 80       	push   $0x80110fc0
80100db1:	e8 9a 38 00 00       	call   80104650 <release>
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
80100dc3:	68 c0 0f 11 80       	push   $0x80110fc0
80100dc8:	e8 83 38 00 00       	call   80104650 <release>
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
80100dea:	68 c0 0f 11 80       	push   $0x80110fc0
80100def:	e8 3c 37 00 00       	call   80104530 <acquire>
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
80100e07:	68 c0 0f 11 80       	push   $0x80110fc0
80100e0c:	e8 3f 38 00 00       	call   80104650 <release>
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
80100e1b:	68 34 75 10 80       	push   $0x80107534
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
80100e3c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e41:	e8 ea 36 00 00       	call   80104530 <acquire>
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
80100e5e:	c7 45 08 c0 0f 11 80 	movl   $0x80110fc0,0x8(%ebp)
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
80100e6c:	e9 df 37 00 00       	jmp    80104650 <release>
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
80100e90:	68 c0 0f 11 80       	push   $0x80110fc0
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
80100e98:	e8 b3 37 00 00       	call   80104650 <release>

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
80100ef2:	68 3c 75 10 80       	push   $0x8010753c
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
80100fd2:	68 46 75 10 80       	push   $0x80107546
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
801010e4:	68 4f 75 10 80       	push   $0x8010754f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 55 75 10 80       	push   $0x80107555
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
80101109:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
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
8010112c:	03 05 d8 19 11 80    	add    0x801119d8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 c0 19 11 80       	mov    0x801119c0,%eax
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
80101197:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010119d:	77 82                	ja     80101121 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010119f:	83 ec 0c             	sub    $0xc,%esp
801011a2:	68 5f 75 10 80       	push   $0x8010755f
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
801011e5:	e8 b6 34 00 00       	call   801046a0 <memset>
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
8010121a:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
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
80101225:	68 e0 19 11 80       	push   $0x801119e0
8010122a:	e8 01 33 00 00       	call   80104530 <acquire>
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
8010124a:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
8010126a:	68 e0 19 11 80       	push   $0x801119e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101272:	e8 d9 33 00 00       	call   80104650 <release>
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
80101293:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
801012ba:	68 e0 19 11 80       	push   $0x801119e0
801012bf:	e8 8c 33 00 00       	call   80104650 <release>

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
801012d4:	68 75 75 10 80       	push   $0x80107575
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
8010139a:	68 85 75 10 80       	push   $0x80107585
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
801013d1:	e8 7a 33 00 00       	call   80104750 <memmove>
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
801013fc:	68 c0 19 11 80       	push   $0x801119c0
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 d8 19 11 80    	add    0x801119d8,%edx
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
80101466:	68 98 75 10 80       	push   $0x80107598
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
80101474:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010147c:	68 ab 75 10 80       	push   $0x801075ab
80101481:	68 e0 19 11 80       	push   $0x801119e0
80101486:	e8 a5 2f 00 00       	call   80104430 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 b2 75 10 80       	push   $0x801075b2
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 7c 2e 00 00       	call   80104320 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 c0 19 11 80       	push   $0x801119c0
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014bf:	ff 35 d8 19 11 80    	pushl  0x801119d8
801014c5:	ff 35 d4 19 11 80    	pushl  0x801119d4
801014cb:	ff 35 d0 19 11 80    	pushl  0x801119d0
801014d1:	ff 35 cc 19 11 80    	pushl  0x801119cc
801014d7:	ff 35 c8 19 11 80    	pushl  0x801119c8
801014dd:	ff 35 c4 19 11 80    	pushl  0x801119c4
801014e3:	ff 35 c0 19 11 80    	pushl  0x801119c0
801014e9:	68 18 76 10 80       	push   $0x80107618
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
80101509:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
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
8010153f:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
8010157e:	e8 1d 31 00 00       	call   801046a0 <memset>
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
801015b3:	68 b8 75 10 80       	push   $0x801075b8
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
801015d4:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
80101621:	e8 2a 31 00 00       	call   80104750 <memmove>
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
8010164a:	68 e0 19 11 80       	push   $0x801119e0
8010164f:	e8 dc 2e 00 00       	call   80104530 <acquire>
  ip->ref++;
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101658:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010165f:	e8 ec 2f 00 00       	call   80104650 <release>
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
80101692:	e8 c9 2c 00 00       	call   80104360 <acquiresleep>

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
801016b9:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
80101708:	e8 43 30 00 00       	call   80104750 <memmove>
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
8010172d:	68 d0 75 10 80       	push   $0x801075d0
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 ca 75 10 80       	push   $0x801075ca
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
80101763:	e8 98 2c 00 00       	call   80104400 <holdingsleep>
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
8010177f:	e9 3c 2c 00 00       	jmp    801043c0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 df 75 10 80       	push   $0x801075df
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
801017b0:	e8 ab 2b 00 00       	call   80104360 <acquiresleep>
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
801017ca:	e8 f1 2b 00 00       	call   801043c0 <releasesleep>

  acquire(&icache.lock);
801017cf:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801017d6:	e8 55 2d 00 00       	call   80104530 <acquire>
  ip->ref--;
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
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
801017f0:	e9 5b 2e 00 00       	jmp    80104650 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 e0 19 11 80       	push   $0x801119e0
80101800:	e8 2b 2d 00 00       	call   80104530 <acquire>
    int r = ip->ref;
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101808:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010180f:	e8 3c 2e 00 00       	call   80104650 <release>
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
801019f8:	e8 53 2d 00 00       	call   80104750 <memmove>
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
80101a2a:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
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
80101af4:	e8 57 2c 00 00       	call   80104750 <memmove>
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
80101b3a:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
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
80101b8e:	e8 3d 2c 00 00       	call   801047d0 <strncmp>
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
80101bf5:	e8 d6 2b 00 00       	call   801047d0 <strncmp>
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
80101c2d:	68 f9 75 10 80       	push   $0x801075f9
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 e7 75 10 80       	push   $0x801075e7
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
80101c74:	68 e0 19 11 80       	push   $0x801119e0
80101c79:	e8 b2 28 00 00       	call   80104530 <acquire>
  ip->ref++;
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c82:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101c89:	e8 c2 29 00 00       	call   80104650 <release>
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
80101ce5:	e8 66 2a 00 00       	call   80104750 <memmove>
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
80101d74:	e8 d7 29 00 00       	call   80104750 <memmove>
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
80101e5d:	e8 de 29 00 00       	call   80104840 <strncpy>
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
80101e9b:	68 08 76 10 80       	push   $0x80107608
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 ae 7c 10 80       	push   $0x80107cae
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
80101fb0:	68 74 76 10 80       	push   $0x80107674
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 6b 76 10 80       	push   $0x8010766b
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
80101fd6:	68 86 76 10 80       	push   $0x80107686
80101fdb:	68 80 b5 10 80       	push   $0x8010b580
80101fe0:	e8 4b 24 00 00       	call   80104430 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fe5:	58                   	pop    %eax
80101fe6:	a1 00 bd 14 80       	mov    0x8014bd00,%eax
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
8010202a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
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
80102059:	68 80 b5 10 80       	push   $0x8010b580
8010205e:	e8 cd 24 00 00       	call   80104530 <acquire>

  if((b = idequeue) == 0){
80102063:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	85 db                	test   %ebx,%ebx
8010206e:	74 34                	je     801020a4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102070:	8b 43 58             	mov    0x58(%ebx),%eax
80102073:	a3 64 b5 10 80       	mov    %eax,0x8010b564

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
8010208e:	e8 dd 20 00 00       	call   80104170 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102093:	a1 64 b5 10 80       	mov    0x8010b564,%eax
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
801020a7:	68 80 b5 10 80       	push   $0x8010b580
801020ac:	e8 9f 25 00 00       	call   80104650 <release>
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
801020fe:	e8 fd 22 00 00       	call   80104400 <holdingsleep>
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
80102123:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102128:	85 c0                	test   %eax,%eax
8010212a:	0f 84 98 00 00 00    	je     801021c8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	68 80 b5 10 80       	push   $0x8010b580
80102138:	e8 f3 23 00 00       	call   80104530 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
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
80102166:	3b 1d 64 b5 10 80    	cmp    0x8010b564,%ebx
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
80102183:	68 80 b5 10 80       	push   $0x8010b580
80102188:	53                   	push   %ebx
80102189:	e8 32 1e 00 00       	call   80103fc0 <sleep>
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
8010219b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801021a6:	e9 a5 24 00 00       	jmp    80104650 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ab:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
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
801021be:	68 8a 76 10 80       	push   $0x8010768a
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 b5 76 10 80       	push   $0x801076b5
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 a0 76 10 80       	push   $0x801076a0
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
801021f1:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
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
80102209:	8b 15 34 36 11 80    	mov    0x80113634,%edx
8010220f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102212:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102218:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010221e:	0f b6 15 60 b7 14 80 	movzbl 0x8014b760,%edx
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
8010223a:	68 d4 76 10 80       	push   $0x801076d4
8010223f:	e8 1c e4 ff ff       	call   80100660 <cprintf>
80102244:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
80102262:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
80102280:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801022a1:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801022b5:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801022c6:	a1 34 36 11 80       	mov    0x80113634,%eax
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
801022f2:	81 fb a8 e4 14 80    	cmp    $0x8014e4a8,%ebx
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
80102312:	e8 89 23 00 00       	call   801046a0 <memset>

  if(kmem.use_lock)
80102317:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010231d:	83 c4 10             	add    $0x10,%esp
80102320:	85 d2                	test   %edx,%edx
80102322:	75 2c                	jne    80102350 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102324:	a1 78 36 11 80       	mov    0x80113678,%eax
80102329:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010232b:	a1 74 36 11 80       	mov    0x80113674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102330:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
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
80102340:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
80102347:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010234a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010234b:	e9 00 23 00 00       	jmp    80104650 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 40 36 11 80       	push   $0x80113640
80102358:	e8 d3 21 00 00       	call   80104530 <acquire>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb c2                	jmp    80102324 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102362:	83 ec 0c             	sub    $0xc,%esp
80102365:	68 06 77 10 80       	push   $0x80107706
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
801023cb:	68 0c 77 10 80       	push   $0x8010770c
801023d0:	68 40 36 11 80       	push   $0x80113640
801023d5:	e8 56 20 00 00       	call   80104430 <initlock>

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
801023e0:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
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
80102474:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
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
80102497:	a1 74 36 11 80       	mov    0x80113674,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	75 30                	jne    801024d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024a0:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r)
801024a6:	85 db                	test   %ebx,%ebx
801024a8:	74 1c                	je     801024c6 <kalloc+0x36>
    kmem.freelist = r->next;
801024aa:	8b 13                	mov    (%ebx),%edx
801024ac:	89 15 78 36 11 80    	mov    %edx,0x80113678
  if(kmem.use_lock)
801024b2:	85 c0                	test   %eax,%eax
801024b4:	74 10                	je     801024c6 <kalloc+0x36>
    release(&kmem.lock);
801024b6:	83 ec 0c             	sub    $0xc,%esp
801024b9:	68 40 36 11 80       	push   $0x80113640
801024be:	e8 8d 21 00 00       	call   80104650 <release>
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
801024d3:	68 40 36 11 80       	push   $0x80113640
801024d8:	e8 53 20 00 00       	call   80104530 <acquire>
  r = kmem.freelist;
801024dd:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r)
801024e3:	83 c4 10             	add    $0x10,%esp
801024e6:	a1 74 36 11 80       	mov    0x80113674,%eax
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
8010250a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
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
80102520:	68 40 36 11 80       	push   $0x80113640
80102525:	e8 06 20 00 00       	call   80104530 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])++;
8010252a:	83 04 9d 7c 36 11 80 	addl   $0x1,-0x7feec984(,%ebx,4)
80102531:	01 
  release(&kmem.lock);   
80102532:	83 c4 10             	add    $0x10,%esp
80102535:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
8010253c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010253f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])++;
  release(&kmem.lock);   
80102540:	e9 0b 21 00 00       	jmp    80104650 <release>
void
addRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102545:	83 ec 0c             	sub    $0xc,%esp
80102548:	68 11 77 10 80       	push   $0x80107711
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
8010256a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
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
80102580:	68 40 36 11 80       	push   $0x80113640
80102585:	e8 a6 1f 00 00       	call   80104530 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010258a:	83 2c 9d 7c 36 11 80 	subl   $0x1,-0x7feec984(,%ebx,4)
80102591:	01 
  release(&kmem.lock);   
80102592:	83 c4 10             	add    $0x10,%esp
80102595:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
8010259c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])--;
  release(&kmem.lock);   
801025a0:	e9 ab 20 00 00       	jmp    80104650 <release>
void
minusRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
801025a5:	83 ec 0c             	sub    $0xc,%esp
801025a8:	68 11 77 10 80       	push   $0x80107711
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
801025ca:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
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
801025e0:	68 40 36 11 80       	push   $0x80113640
801025e5:	e8 46 1f 00 00       	call   80104530 <acquire>
  count = kmem.pageRefCount[value>>PGSHIFT];  
801025ea:	8b 1c 9d 7c 36 11 80 	mov    -0x7feec984(,%ebx,4),%ebx
  release(&kmem.lock);
801025f1:	c7 04 24 40 36 11 80 	movl   $0x80113640,(%esp)
801025f8:	e8 53 20 00 00       	call   80104650 <release>
     
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
80102607:	68 11 77 10 80       	push   $0x80107711
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
80102644:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx
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
80102656:	0f b6 82 60 78 10 80 	movzbl -0x7fef87a0(%edx),%eax
8010265d:	83 c8 40             	or     $0x40,%eax
80102660:	0f b6 c0             	movzbl %al,%eax
80102663:	f7 d0                	not    %eax
80102665:	21 c8                	and    %ecx,%eax
80102667:	a3 b4 b5 10 80       	mov    %eax,0x8010b5b4
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
8010267e:	0f b6 82 60 78 10 80 	movzbl -0x7fef87a0(%edx),%eax
80102685:	09 c1                	or     %eax,%ecx
80102687:	0f b6 82 60 77 10 80 	movzbl -0x7fef88a0(%edx),%eax
8010268e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102690:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102692:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102698:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010269b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010269e:	8b 04 85 40 77 10 80 	mov    -0x7fef88c0(,%eax,4),%eax
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
801026c2:	83 0d b4 b5 10 80 40 	orl    $0x40,0x8010b5b4
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
80102710:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
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
80102810:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
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
80102830:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
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
8010289e:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
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
80102a04:	e8 e7 1c 00 00       	call   801046f0 <memcmp>
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
80102ad0:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
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
80102af0:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102af5:	83 ec 08             	sub    $0x8,%esp
80102af8:	01 d8                	add    %ebx,%eax
80102afa:	83 c0 01             	add    $0x1,%eax
80102afd:	50                   	push   %eax
80102afe:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	58                   	pop    %eax
80102b0c:	5a                   	pop    %edx
80102b0d:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102b14:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
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
80102b34:	e8 17 1c 00 00       	call   80104750 <memmove>
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
80102b54:	39 1d c8 b6 14 80    	cmp    %ebx,0x8014b6c8
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
80102b77:	ff 35 b4 b6 14 80    	pushl  0x8014b6b4
80102b7d:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102b83:	e8 48 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b88:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
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
80102ba8:	8b 8a cc b6 14 80    	mov    -0x7feb4934(%edx),%ecx
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
80102bda:	68 60 79 10 80       	push   $0x80107960
80102bdf:	68 80 b6 14 80       	push   $0x8014b680
80102be4:	e8 47 18 00 00       	call   80104430 <initlock>
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
80102bfc:	89 1d c4 b6 14 80    	mov    %ebx,0x8014b6c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c02:	89 15 b8 b6 14 80    	mov    %edx,0x8014b6b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c08:	a3 b4 b6 14 80       	mov    %eax,0x8014b6b4

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
80102c1d:	89 0d c8 b6 14 80    	mov    %ecx,0x8014b6c8
  for (i = 0; i < log.lh.n; i++) {
80102c23:	7e 1c                	jle    80102c41 <initlog+0x71>
80102c25:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102c2c:	31 d2                	xor    %edx,%edx
80102c2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c34:	83 c2 04             	add    $0x4,%edx
80102c37:	89 8a c8 b6 14 80    	mov    %ecx,-0x7feb4938(%edx)
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
80102c4f:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
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
80102c76:	68 80 b6 14 80       	push   $0x8014b680
80102c7b:	e8 b0 18 00 00       	call   80104530 <acquire>
80102c80:	83 c4 10             	add    $0x10,%esp
80102c83:	eb 18                	jmp    80102c9d <begin_op+0x2d>
80102c85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c88:	83 ec 08             	sub    $0x8,%esp
80102c8b:	68 80 b6 14 80       	push   $0x8014b680
80102c90:	68 80 b6 14 80       	push   $0x8014b680
80102c95:	e8 26 13 00 00       	call   80103fc0 <sleep>
80102c9a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c9d:	a1 c0 b6 14 80       	mov    0x8014b6c0,%eax
80102ca2:	85 c0                	test   %eax,%eax
80102ca4:	75 e2                	jne    80102c88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ca6:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102cab:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
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
80102cc2:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
      release(&log.lock);
80102cc7:	68 80 b6 14 80       	push   $0x8014b680
80102ccc:	e8 7f 19 00 00       	call   80104650 <release>
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
80102ce9:	68 80 b6 14 80       	push   $0x8014b680
80102cee:	e8 3d 18 00 00       	call   80104530 <acquire>
  log.outstanding -= 1;
80102cf3:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
  if(log.committing)
80102cf8:	8b 1d c0 b6 14 80    	mov    0x8014b6c0,%ebx
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
80102d06:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
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
80102d1c:	c7 05 c0 b6 14 80 01 	movl   $0x1,0x8014b6c0
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
80102d28:	68 80 b6 14 80       	push   $0x8014b680
80102d2d:	e8 1e 19 00 00       	call   80104650 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d32:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
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
80102d48:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102d4d:	83 ec 08             	sub    $0x8,%esp
80102d50:	01 d8                	add    %ebx,%eax
80102d52:	83 c0 01             	add    $0x1,%eax
80102d55:	50                   	push   %eax
80102d56:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102d5c:	e8 6f d3 ff ff       	call   801000d0 <bread>
80102d61:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d63:	58                   	pop    %eax
80102d64:	5a                   	pop    %edx
80102d65:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102d6c:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
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
80102d8c:	e8 bf 19 00 00       	call   80104750 <memmove>
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
80102dac:	3b 1d c8 b6 14 80    	cmp    0x8014b6c8,%ebx
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
80102dbe:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
80102dc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dc8:	e8 a3 fd ff ff       	call   80102b70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102dcd:	83 ec 0c             	sub    $0xc,%esp
80102dd0:	68 80 b6 14 80       	push   $0x8014b680
80102dd5:	e8 56 17 00 00       	call   80104530 <acquire>
    log.committing = 0;
    wakeup(&log);
80102dda:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102de1:	c7 05 c0 b6 14 80 00 	movl   $0x0,0x8014b6c0
80102de8:	00 00 00 
    wakeup(&log);
80102deb:	e8 80 13 00 00       	call   80104170 <wakeup>
    release(&log.lock);
80102df0:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102df7:	e8 54 18 00 00       	call   80104650 <release>
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
80102e13:	68 80 b6 14 80       	push   $0x8014b680
80102e18:	e8 53 13 00 00       	call   80104170 <wakeup>
  }
  release(&log.lock);
80102e1d:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102e24:	e8 27 18 00 00       	call   80104650 <release>
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
80102e37:	68 64 79 10 80       	push   $0x80107964
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
80102e57:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
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
80102e69:	a1 b8 b6 14 80       	mov    0x8014b6b8,%eax
80102e6e:	83 e8 01             	sub    $0x1,%eax
80102e71:	39 c2                	cmp    %eax,%edx
80102e73:	0f 8d 87 00 00 00    	jge    80102f00 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e79:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102e7e:	85 c0                	test   %eax,%eax
80102e80:	0f 8e 87 00 00 00    	jle    80102f0d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e86:	83 ec 0c             	sub    $0xc,%esp
80102e89:	68 80 b6 14 80       	push   $0x8014b680
80102e8e:	e8 9d 16 00 00       	call   80104530 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e93:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
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
80102ea6:	3b 0d cc b6 14 80    	cmp    0x8014b6cc,%ecx
80102eac:	75 0b                	jne    80102eb9 <log_write+0x69>
80102eae:	eb 38                	jmp    80102ee8 <log_write+0x98>
80102eb0:	39 0c 85 cc b6 14 80 	cmp    %ecx,-0x7feb4934(,%eax,4)
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
80102ec0:	89 0c 95 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ec7:	83 c2 01             	add    $0x1,%edx
80102eca:	89 15 c8 b6 14 80    	mov    %edx,0x8014b6c8
  b->flags |= B_DIRTY; // prevent eviction
80102ed0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ed3:	c7 45 08 80 b6 14 80 	movl   $0x8014b680,0x8(%ebp)
}
80102eda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102edd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102ede:	e9 6d 17 00 00       	jmp    80104650 <release>
80102ee3:	90                   	nop
80102ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ee8:	89 0c 85 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%eax,4)
80102eef:	eb df                	jmp    80102ed0 <log_write+0x80>
80102ef1:	8b 43 08             	mov    0x8(%ebx),%eax
80102ef4:	a3 cc b6 14 80       	mov    %eax,0x8014b6cc
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
80102f03:	68 73 79 10 80       	push   $0x80107973
80102f08:	e8 63 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102f0d:	83 ec 0c             	sub    $0xc,%esp
80102f10:	68 89 79 10 80       	push   $0x80107989
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
80102f38:	68 a4 79 10 80       	push   $0x801079a4
80102f3d:	e8 1e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f42:	e8 c9 2a 00 00       	call   80105a10 <idtinit>
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
80102f5a:	e8 71 0d 00 00       	call   80103cd0 <scheduler>
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
80102f66:	e8 e5 3b 00 00       	call   80106b50 <switchkvm>
  seginit();
80102f6b:	e8 e0 3a 00 00       	call   80106a50 <seginit>
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
80102f8f:	bb 80 b7 14 80       	mov    $0x8014b780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f94:	83 ec 08             	sub    $0x8,%esp
80102f97:	68 00 00 40 80       	push   $0x80400000
80102f9c:	68 a8 e4 14 80       	push   $0x8014e4a8
80102fa1:	e8 1a f4 ff ff       	call   801023c0 <kinit1>
  kvmalloc();      // kernel page table
80102fa6:	e8 45 40 00 00       	call   80106ff0 <kvmalloc>
  mpinit();        // detect other processors
80102fab:	e8 70 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102fb0:	e8 5b f7 ff ff       	call   80102710 <lapicinit>
  seginit();       // segment descriptors
80102fb5:	e8 96 3a 00 00       	call   80106a50 <seginit>
  picinit();       // disable pic
80102fba:	e8 31 03 00 00       	call   801032f0 <picinit>
  ioapicinit();    // another interrupt controller
80102fbf:	e8 2c f2 ff ff       	call   801021f0 <ioapicinit>
  consoleinit();   // console hardware
80102fc4:	e8 d7 d9 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102fc9:	e8 52 2d 00 00       	call   80105d20 <uartinit>
  pinit();         // process table
80102fce:	e8 0d 08 00 00       	call   801037e0 <pinit>
  tvinit();        // trap vectors
80102fd3:	e8 98 29 00 00       	call   80105970 <tvinit>
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
80102fef:	68 8c b4 10 80       	push   $0x8010b48c
80102ff4:	68 00 70 00 80       	push   $0x80007000
80102ff9:	e8 52 17 00 00       	call   80104750 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ffe:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
80103005:	00 00 00 
80103008:	83 c4 10             	add    $0x10,%esp
8010300b:	05 80 b7 14 80       	add    $0x8014b780,%eax
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
80103035:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010303c:	a0 10 00 

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
8010306a:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
80103071:	00 00 00 
80103074:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010307a:	05 80 b7 14 80       	add    $0x8014b780,%eax
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
801030c8:	68 b8 79 10 80       	push   $0x801079b8
801030cd:	56                   	push   %esi
801030ce:	e8 1d 16 00 00       	call   801046f0 <memcmp>
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
8010318c:	68 bd 79 10 80       	push   $0x801079bd
80103191:	56                   	push   %esi
80103192:	e8 59 15 00 00       	call   801046f0 <memcmp>
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
801031ef:	a3 7c b6 14 80       	mov    %eax,0x8014b67c
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
80103220:	ff 24 95 fc 79 10 80 	jmp    *-0x7fef8604(,%edx,4)
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
80103268:	8b 0d 00 bd 14 80    	mov    0x8014bd00,%ecx
8010326e:	83 f9 07             	cmp    $0x7,%ecx
80103271:	7f 19                	jg     8010328c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103273:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103277:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010327d:	83 c1 01             	add    $0x1,%ecx
80103280:	89 0d 00 bd 14 80    	mov    %ecx,0x8014bd00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103286:	88 97 80 b7 14 80    	mov    %dl,-0x7feb4880(%edi)
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
8010329f:	88 15 60 b7 14 80    	mov    %dl,0x8014b760
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
801032c7:	68 c2 79 10 80       	push   $0x801079c2
801032cc:	e8 9f d0 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032d1:	83 ec 0c             	sub    $0xc,%esp
801032d4:	68 dc 79 10 80       	push   $0x801079dc
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
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032f0:	55                   	push   %ebp
801032f1:	ba 21 00 00 00       	mov    $0x21,%edx
801032f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032fb:	89 e5                	mov    %esp,%ebp
801032fd:	ee                   	out    %al,(%dx)
801032fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103303:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
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
80103383:	68 10 7a 10 80       	push   $0x80107a10
80103388:	50                   	push   %eax
80103389:	e8 a2 10 00 00       	call   80104430 <initlock>
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
8010341f:	e8 0c 11 00 00       	call   80104530 <acquire>
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
8010343f:	e8 2c 0d 00 00       	call   80104170 <wakeup>
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
80103464:	e9 e7 11 00 00       	jmp    80104650 <release>
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
80103484:	e8 e7 0c 00 00       	call   80104170 <wakeup>
80103489:	83 c4 10             	add    $0x10,%esp
8010348c:	eb b9                	jmp    80103447 <pipeclose+0x37>
8010348e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 b7 11 00 00       	call   80104650 <release>
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
801034bd:	e8 6e 10 00 00       	call   80104530 <acquire>
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
80103510:	e8 5b 0c 00 00       	call   80104170 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103515:	58                   	pop    %eax
80103516:	5a                   	pop    %edx
80103517:	53                   	push   %ebx
80103518:	56                   	push   %esi
80103519:	e8 a2 0a 00 00       	call   80103fc0 <sleep>
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
80103544:	e8 07 11 00 00       	call   80104650 <release>
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
80103593:	e8 d8 0b 00 00       	call   80104170 <wakeup>
  release(&p->lock);
80103598:	89 1c 24             	mov    %ebx,(%esp)
8010359b:	e8 b0 10 00 00       	call   80104650 <release>
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
801035c0:	e8 6b 0f 00 00       	call   80104530 <acquire>
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
801035f5:	e8 c6 09 00 00       	call   80103fc0 <sleep>
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
80103629:	e8 22 10 00 00       	call   80104650 <release>
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
8010368e:	e8 dd 0a 00 00       	call   80104170 <wakeup>
  release(&p->lock);
80103693:	89 1c 24             	mov    %ebx,(%esp)
80103696:	e8 b5 0f 00 00       	call   80104650 <release>
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
801036d4:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
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
801036dc:	68 20 bd 14 80       	push   $0x8014bd20
801036e1:	e8 4a 0e 00 00       	call   80104530 <acquire>
801036e6:	83 c4 10             	add    $0x10,%esp
801036e9:	eb 10                	jmp    801036fb <allocproc+0x2b>
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036f0:	83 c3 7c             	add    $0x7c,%ebx
801036f3:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
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
80103702:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103707:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010370a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103711:	68 20 bd 14 80       	push   $0x8014bd20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103716:	8d 50 01             	lea    0x1(%eax),%edx
80103719:	89 43 10             	mov    %eax,0x10(%ebx)
8010371c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80103722:	e8 29 0f 00 00       	call   80104650 <release>

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
80103747:	c7 40 14 61 59 10 80 	movl   $0x80105961,0x14(%eax)

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
80103756:	e8 45 0f 00 00       	call   801046a0 <memset>
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
80103773:	68 20 bd 14 80       	push   $0x8014bd20
80103778:	e8 d3 0e 00 00       	call   80104650 <release>
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
80103796:	68 20 bd 14 80       	push   $0x8014bd20
8010379b:	e8 b0 0e 00 00       	call   80104650 <release>

  if (first) {
801037a0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
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
801037b3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
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
801037e6:	68 15 7a 10 80       	push   $0x80107a15
801037eb:	68 20 bd 14 80       	push   $0x8014bd20
801037f0:	e8 3b 0c 00 00       	call   80104430 <initlock>
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
80103811:	8b 35 00 bd 14 80    	mov    0x8014bd00,%esi
80103817:	85 f6                	test   %esi,%esi
80103819:	7e 3f                	jle    8010385a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010381b:	0f b6 15 80 b7 14 80 	movzbl 0x8014b780,%edx
80103822:	39 d0                	cmp    %edx,%eax
80103824:	74 30                	je     80103856 <mycpu+0x56>
80103826:	b9 30 b8 14 80       	mov    $0x8014b830,%ecx
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
8010384e:	05 80 b7 14 80       	add    $0x8014b780,%eax
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
8010385d:	68 1c 7a 10 80       	push   $0x80107a1c
80103862:	e8 09 cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103867:	83 ec 0c             	sub    $0xc,%esp
8010386a:	68 58 7b 10 80       	push   $0x80107b58
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
8010388b:	2d 80 b7 14 80       	sub    $0x8014b780,%eax
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
801038a7:	e8 44 0c 00 00       	call   801044f0 <pushcli>
  c = mycpu();
801038ac:	e8 4f ff ff ff       	call   80103800 <mycpu>
  p = c->proc;
801038b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038b7:	e8 24 0d 00 00       	call   801045e0 <popcli>
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
801038de:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801038e3:	e8 88 36 00 00       	call   80106f70 <setupkvm>
801038e8:	85 c0                	test   %eax,%eax
801038ea:	89 43 04             	mov    %eax,0x4(%ebx)
801038ed:	0f 84 bd 00 00 00    	je     801039b0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038f3:	83 ec 04             	sub    $0x4,%esp
801038f6:	68 2c 00 00 00       	push   $0x2c
801038fb:	68 60 b4 10 80       	push   $0x8010b460
80103900:	50                   	push   %eax
80103901:	e8 7a 33 00 00       	call   80106c80 <inituvm>
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
80103916:	e8 85 0d 00 00       	call   801046a0 <memset>
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
8010396f:	68 45 7a 10 80       	push   $0x80107a45
80103974:	50                   	push   %eax
80103975:	e8 26 0f 00 00       	call   801048a0 <safestrcpy>
  p->cwd = namei("/");
8010397a:	c7 04 24 4e 7a 10 80 	movl   $0x80107a4e,(%esp)
80103981:	e8 3a e5 ff ff       	call   80101ec0 <namei>
80103986:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103989:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103990:	e8 9b 0b 00 00       	call   80104530 <acquire>

  p->state = RUNNABLE;
80103995:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010399c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
801039a3:	e8 a8 0c 00 00       	call   80104650 <release>
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
801039b3:	68 2c 7a 10 80       	push   $0x80107a2c
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
801039c8:	e8 23 0b 00 00       	call   801044f0 <pushcli>
  c = mycpu();
801039cd:	e8 2e fe ff ff       	call   80103800 <mycpu>
  p = c->proc;
801039d2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d8:	e8 03 0c 00 00       	call   801045e0 <popcli>
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
801039ee:	e8 cd 33 00 00       	call   80106dc0 <allocuvm>
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
80103a00:	e8 6b 31 00 00       	call   80106b70 <switchuvm>
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
80103a24:	e8 97 34 00 00       	call   80106ec0 <deallocuvm>
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
80103a49:	e8 a2 0a 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103a4e:	e8 ad fd ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103a53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a59:	e8 82 0b 00 00       	call   801045e0 <popcli>
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
80103a78:	e8 c3 35 00 00       	call   80107040 <copyuvm>
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
80103af1:	e8 aa 0d 00 00       	call   801048a0 <safestrcpy>

  pid = np->pid;
80103af6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103af9:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103b00:	e8 2b 0a 00 00       	call   80104530 <acquire>

  np->state = RUNNABLE;
80103b05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b0c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103b13:	e8 38 0b 00 00       	call   80104650 <release>

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

80103b60 <forkcow>:
  return pid;
}

int
forkcow(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	57                   	push   %edi
80103b64:	56                   	push   %esi
80103b65:	53                   	push   %ebx
80103b66:	83 ec 28             	sub    $0x28,%esp
  cprintf("Entrou no forkcow\n");
80103b69:	68 50 7a 10 80       	push   $0x80107a50
80103b6e:	e8 ed ca ff ff       	call   80100660 <cprintf>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b73:	e8 78 09 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103b78:	e8 83 fc ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103b7d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b83:	e8 58 0a 00 00       	call   801045e0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103b88:	e8 43 fb ff ff       	call   801036d0 <allocproc>
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	85 c0                	test   %eax,%eax
80103b92:	89 c7                	mov    %eax,%edi
80103b94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b97:	0f 84 f5 00 00 00    	je     80103c92 <forkcow+0x132>
    return -1;
  }

  // Copy process state from proc.
  cprintf("Entrou no copyuvmcow\n");
80103b9d:	83 ec 0c             	sub    $0xc,%esp
80103ba0:	68 63 7a 10 80       	push   $0x80107a63
80103ba5:	e8 b6 ca ff ff       	call   80100660 <cprintf>
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
80103baa:	5e                   	pop    %esi
80103bab:	58                   	pop    %eax
80103bac:	ff 33                	pushl  (%ebx)
80103bae:	ff 73 04             	pushl  0x4(%ebx)
80103bb1:	e8 7a 35 00 00       	call   80107130 <copyuvmcow>
80103bb6:	83 c4 10             	add    $0x10,%esp
80103bb9:	85 c0                	test   %eax,%eax
80103bbb:	89 47 04             	mov    %eax,0x4(%edi)
80103bbe:	0f 84 d5 00 00 00    	je     80103c99 <forkcow+0x139>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103bc4:	8b 03                	mov    (%ebx),%eax
80103bc6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  np->parent = curproc;
  *np->tf = *curproc->tf;
  cprintf("Copiou as coisas pro processo novo\n");
80103bc9:	83 ec 0c             	sub    $0xc,%esp
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103bcc:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103bce:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103bd1:	8b 79 18             	mov    0x18(%ecx),%edi
80103bd4:	8b 73 18             	mov    0x18(%ebx),%esi
80103bd7:	b9 13 00 00 00       	mov    $0x13,%ecx
80103bdc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  cprintf("Copiou as coisas pro processo novo\n");
80103bde:	68 80 7b 10 80       	push   $0x80107b80

  // Clear %eax so that fork returns 0 in the child.
  cprintf("Limpou o eax\n");
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103be3:	31 f6                	xor    %esi,%esi
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;
  cprintf("Copiou as coisas pro processo novo\n");
80103be5:	e8 76 ca ff ff       	call   80100660 <cprintf>

  // Clear %eax so that fork returns 0 in the child.
  cprintf("Limpou o eax\n");
80103bea:	c7 04 24 8d 7a 10 80 	movl   $0x80107a8d,(%esp)
80103bf1:	e8 6a ca ff ff       	call   80100660 <cprintf>
  np->tf->eax = 0;
80103bf6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103bf9:	83 c4 10             	add    $0x10,%esp
80103bfc:	8b 41 18             	mov    0x18(%ecx),%eax
80103bff:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103c06:	8d 76 00             	lea    0x0(%esi),%esi
80103c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103c10:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c14:	85 c0                	test   %eax,%eax
80103c16:	74 13                	je     80103c2b <forkcow+0xcb>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c18:	83 ec 0c             	sub    $0xc,%esp
80103c1b:	50                   	push   %eax
80103c1c:	e8 bf d1 ff ff       	call   80100de0 <filedup>
80103c21:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c24:	83 c4 10             	add    $0x10,%esp
80103c27:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)

  // Clear %eax so that fork returns 0 in the child.
  cprintf("Limpou o eax\n");
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c2b:	83 c6 01             	add    $0x1,%esi
80103c2e:	83 fe 10             	cmp    $0x10,%esi
80103c31:	75 dd                	jne    80103c10 <forkcow+0xb0>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c33:	83 ec 0c             	sub    $0xc,%esp
80103c36:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c39:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c3c:	e8 ff d9 ff ff       	call   80101640 <idup>
80103c41:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c44:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c47:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c4a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c4d:	6a 10                	push   $0x10
80103c4f:	53                   	push   %ebx
80103c50:	50                   	push   %eax
80103c51:	e8 4a 0c 00 00       	call   801048a0 <safestrcpy>

  pid = np->pid;
80103c56:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103c59:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103c60:	e8 cb 08 00 00       	call   80104530 <acquire>

  np->state = RUNNABLE;
80103c65:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103c6c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103c73:	e8 d8 09 00 00       	call   80104650 <release>
  cprintf("pid retornado : %d\n", pid);
80103c78:	58                   	pop    %eax
80103c79:	5a                   	pop    %edx
80103c7a:	53                   	push   %ebx
80103c7b:	68 9b 7a 10 80       	push   $0x80107a9b
80103c80:	e8 db c9 ff ff       	call   80100660 <cprintf>
  return pid;
80103c85:	83 c4 10             	add    $0x10,%esp
80103c88:	89 d8                	mov    %ebx,%eax
}
80103c8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c8d:	5b                   	pop    %ebx
80103c8e:	5e                   	pop    %esi
80103c8f:	5f                   	pop    %edi
80103c90:	5d                   	pop    %ebp
80103c91:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103c92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c97:	eb f1                	jmp    80103c8a <forkcow+0x12a>
  }

  // Copy process state from proc.
  cprintf("Entrou no copyuvmcow\n");
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
    cprintf("ERRO NO COPYUVMCOW\n");
80103c99:	83 ec 0c             	sub    $0xc,%esp
80103c9c:	68 79 7a 10 80       	push   $0x80107a79
80103ca1:	e8 ba c9 ff ff       	call   80100660 <cprintf>
    kfree(np->kstack);
80103ca6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103ca9:	59                   	pop    %ecx
80103caa:	ff 77 08             	pushl  0x8(%edi)
80103cad:	e8 2e e6 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103cb2:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103cb9:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103cc0:	83 c4 10             	add    $0x10,%esp
80103cc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cc8:	eb c0                	jmp    80103c8a <forkcow+0x12a>
80103cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103cd0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103cd9:	e8 22 fb ff ff       	call   80103800 <mycpu>
80103cde:	8d 78 04             	lea    0x4(%eax),%edi
80103ce1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ce3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cea:	00 00 00 
80103ced:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103cf0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103cf1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf4:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103cf9:	68 20 bd 14 80       	push   $0x8014bd20
80103cfe:	e8 2d 08 00 00       	call   80104530 <acquire>
80103d03:	83 c4 10             	add    $0x10,%esp
80103d06:	eb 13                	jmp    80103d1b <scheduler+0x4b>
80103d08:	90                   	nop
80103d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d10:	83 c3 7c             	add    $0x7c,%ebx
80103d13:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80103d19:	74 45                	je     80103d60 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103d1b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d1f:	75 ef                	jne    80103d10 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d21:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103d24:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d2a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d2b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d2e:	e8 3d 2e 00 00       	call   80106b70 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103d33:	58                   	pop    %eax
80103d34:	5a                   	pop    %edx
80103d35:	ff 73 a0             	pushl  -0x60(%ebx)
80103d38:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103d39:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103d40:	e8 b6 0b 00 00       	call   801048fb <swtch>
      switchkvm();
80103d45:	e8 06 2e 00 00       	call   80106b50 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d4a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d4d:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d53:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d5a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d5d:	75 bc                	jne    80103d1b <scheduler+0x4b>
80103d5f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103d60:	83 ec 0c             	sub    $0xc,%esp
80103d63:	68 20 bd 14 80       	push   $0x8014bd20
80103d68:	e8 e3 08 00 00       	call   80104650 <release>

  }
80103d6d:	83 c4 10             	add    $0x10,%esp
80103d70:	e9 7b ff ff ff       	jmp    80103cf0 <scheduler+0x20>
80103d75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d80 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	56                   	push   %esi
80103d84:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d85:	e8 66 07 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103d8a:	e8 71 fa ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103d8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d95:	e8 46 08 00 00       	call   801045e0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103d9a:	83 ec 0c             	sub    $0xc,%esp
80103d9d:	68 20 bd 14 80       	push   $0x8014bd20
80103da2:	e8 09 07 00 00       	call   801044b0 <holding>
80103da7:	83 c4 10             	add    $0x10,%esp
80103daa:	85 c0                	test   %eax,%eax
80103dac:	74 4f                	je     80103dfd <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103dae:	e8 4d fa ff ff       	call   80103800 <mycpu>
80103db3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dba:	75 68                	jne    80103e24 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103dbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103dc0:	74 55                	je     80103e17 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dc2:	9c                   	pushf  
80103dc3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103dc4:	f6 c4 02             	test   $0x2,%ah
80103dc7:	75 41                	jne    80103e0a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103dc9:	e8 32 fa ff ff       	call   80103800 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dce:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103dd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103dd7:	e8 24 fa ff ff       	call   80103800 <mycpu>
80103ddc:	83 ec 08             	sub    $0x8,%esp
80103ddf:	ff 70 04             	pushl  0x4(%eax)
80103de2:	53                   	push   %ebx
80103de3:	e8 13 0b 00 00       	call   801048fb <swtch>
  mycpu()->intena = intena;
80103de8:	e8 13 fa ff ff       	call   80103800 <mycpu>
}
80103ded:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103df0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103df6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df9:	5b                   	pop    %ebx
80103dfa:	5e                   	pop    %esi
80103dfb:	5d                   	pop    %ebp
80103dfc:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103dfd:	83 ec 0c             	sub    $0xc,%esp
80103e00:	68 af 7a 10 80       	push   $0x80107aaf
80103e05:	e8 66 c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 db 7a 10 80       	push   $0x80107adb
80103e12:	e8 59 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 cd 7a 10 80       	push   $0x80107acd
80103e1f:	e8 4c c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103e24:	83 ec 0c             	sub    $0xc,%esp
80103e27:	68 c1 7a 10 80       	push   $0x80107ac1
80103e2c:	e8 3f c5 ff ff       	call   80100370 <panic>
80103e31:	eb 0d                	jmp    80103e40 <exit>
80103e33:	90                   	nop
80103e34:	90                   	nop
80103e35:	90                   	nop
80103e36:	90                   	nop
80103e37:	90                   	nop
80103e38:	90                   	nop
80103e39:	90                   	nop
80103e3a:	90                   	nop
80103e3b:	90                   	nop
80103e3c:	90                   	nop
80103e3d:	90                   	nop
80103e3e:	90                   	nop
80103e3f:	90                   	nop

80103e40 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e49:	e8 a2 06 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103e4e:	e8 ad f9 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103e53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e59:	e8 82 07 00 00       	call   801045e0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103e5e:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103e64:	8d 5e 28             	lea    0x28(%esi),%ebx
80103e67:	8d 7e 68             	lea    0x68(%esi),%edi
80103e6a:	0f 84 e7 00 00 00    	je     80103f57 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103e70:	8b 03                	mov    (%ebx),%eax
80103e72:	85 c0                	test   %eax,%eax
80103e74:	74 12                	je     80103e88 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103e76:	83 ec 0c             	sub    $0xc,%esp
80103e79:	50                   	push   %eax
80103e7a:	e8 b1 cf ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103e7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103e85:	83 c4 10             	add    $0x10,%esp
80103e88:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e8b:	39 df                	cmp    %ebx,%edi
80103e8d:	75 e1                	jne    80103e70 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103e8f:	e8 dc ed ff ff       	call   80102c70 <begin_op>
  iput(curproc->cwd);
80103e94:	83 ec 0c             	sub    $0xc,%esp
80103e97:	ff 76 68             	pushl  0x68(%esi)
80103e9a:	e8 01 d9 ff ff       	call   801017a0 <iput>
  end_op();
80103e9f:	e8 3c ee ff ff       	call   80102ce0 <end_op>
  curproc->cwd = 0;
80103ea4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103eab:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103eb2:	e8 79 06 00 00       	call   80104530 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103eb7:	8b 56 14             	mov    0x14(%esi),%edx
80103eba:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ebd:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103ec2:	eb 0e                	jmp    80103ed2 <exit+0x92>
80103ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ec8:	83 c0 7c             	add    $0x7c,%eax
80103ecb:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103ed0:	74 1c                	je     80103eee <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103ed2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ed6:	75 f0                	jne    80103ec8 <exit+0x88>
80103ed8:	3b 50 20             	cmp    0x20(%eax),%edx
80103edb:	75 eb                	jne    80103ec8 <exit+0x88>
      p->state = RUNNABLE;
80103edd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ee4:	83 c0 7c             	add    $0x7c,%eax
80103ee7:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103eec:	75 e4                	jne    80103ed2 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103eee:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
80103ef4:	ba 54 bd 14 80       	mov    $0x8014bd54,%edx
80103ef9:	eb 10                	jmp    80103f0b <exit+0xcb>
80103efb:	90                   	nop
80103efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f00:	83 c2 7c             	add    $0x7c,%edx
80103f03:	81 fa 54 dc 14 80    	cmp    $0x8014dc54,%edx
80103f09:	74 33                	je     80103f3e <exit+0xfe>
    if(p->parent == curproc){
80103f0b:	39 72 14             	cmp    %esi,0x14(%edx)
80103f0e:	75 f0                	jne    80103f00 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103f10:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f14:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f17:	75 e7                	jne    80103f00 <exit+0xc0>
80103f19:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103f1e:	eb 0a                	jmp    80103f2a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f20:	83 c0 7c             	add    $0x7c,%eax
80103f23:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f28:	74 d6                	je     80103f00 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f2e:	75 f0                	jne    80103f20 <exit+0xe0>
80103f30:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f33:	75 eb                	jne    80103f20 <exit+0xe0>
      p->state = RUNNABLE;
80103f35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f3c:	eb e2                	jmp    80103f20 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f3e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f45:	e8 36 fe ff ff       	call   80103d80 <sched>
  panic("zombie exit");
80103f4a:	83 ec 0c             	sub    $0xc,%esp
80103f4d:	68 fc 7a 10 80       	push   $0x80107afc
80103f52:	e8 19 c4 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103f57:	83 ec 0c             	sub    $0xc,%esp
80103f5a:	68 ef 7a 10 80       	push   $0x80107aef
80103f5f:	e8 0c c4 ff ff       	call   80100370 <panic>
80103f64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103f70 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	53                   	push   %ebx
80103f74:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f77:	68 20 bd 14 80       	push   $0x8014bd20
80103f7c:	e8 af 05 00 00       	call   80104530 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f81:	e8 6a 05 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103f86:	e8 75 f8 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103f8b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f91:	e8 4a 06 00 00       	call   801045e0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103f96:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103f9d:	e8 de fd ff ff       	call   80103d80 <sched>
  release(&ptable.lock);
80103fa2:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103fa9:	e8 a2 06 00 00       	call   80104650 <release>
}
80103fae:	83 c4 10             	add    $0x10,%esp
80103fb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb4:	c9                   	leave  
80103fb5:	c3                   	ret    
80103fb6:	8d 76 00             	lea    0x0(%esi),%esi
80103fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fc0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	57                   	push   %edi
80103fc4:	56                   	push   %esi
80103fc5:	53                   	push   %ebx
80103fc6:	83 ec 0c             	sub    $0xc,%esp
80103fc9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103fcc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fcf:	e8 1c 05 00 00       	call   801044f0 <pushcli>
  c = mycpu();
80103fd4:	e8 27 f8 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103fd9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fdf:	e8 fc 05 00 00       	call   801045e0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103fe4:	85 db                	test   %ebx,%ebx
80103fe6:	0f 84 87 00 00 00    	je     80104073 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103fec:	85 f6                	test   %esi,%esi
80103fee:	74 76                	je     80104066 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ff0:	81 fe 20 bd 14 80    	cmp    $0x8014bd20,%esi
80103ff6:	74 50                	je     80104048 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ff8:	83 ec 0c             	sub    $0xc,%esp
80103ffb:	68 20 bd 14 80       	push   $0x8014bd20
80104000:	e8 2b 05 00 00       	call   80104530 <acquire>
    release(lk);
80104005:	89 34 24             	mov    %esi,(%esp)
80104008:	e8 43 06 00 00       	call   80104650 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010400d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104010:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104017:	e8 64 fd ff ff       	call   80103d80 <sched>

  // Tidy up.
  p->chan = 0;
8010401c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104023:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
8010402a:	e8 21 06 00 00       	call   80104650 <release>
    acquire(lk);
8010402f:	89 75 08             	mov    %esi,0x8(%ebp)
80104032:	83 c4 10             	add    $0x10,%esp
  }
}
80104035:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104038:	5b                   	pop    %ebx
80104039:	5e                   	pop    %esi
8010403a:	5f                   	pop    %edi
8010403b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010403c:	e9 ef 04 00 00       	jmp    80104530 <acquire>
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104048:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010404b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104052:	e8 29 fd ff ff       	call   80103d80 <sched>

  // Tidy up.
  p->chan = 0;
80104057:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010405e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104061:	5b                   	pop    %ebx
80104062:	5e                   	pop    %esi
80104063:	5f                   	pop    %edi
80104064:	5d                   	pop    %ebp
80104065:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104066:	83 ec 0c             	sub    $0xc,%esp
80104069:	68 0e 7b 10 80       	push   $0x80107b0e
8010406e:	e8 fd c2 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104073:	83 ec 0c             	sub    $0xc,%esp
80104076:	68 08 7b 10 80       	push   $0x80107b08
8010407b:	e8 f0 c2 ff ff       	call   80100370 <panic>

80104080 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	56                   	push   %esi
80104084:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104085:	e8 66 04 00 00       	call   801044f0 <pushcli>
  c = mycpu();
8010408a:	e8 71 f7 ff ff       	call   80103800 <mycpu>
  p = c->proc;
8010408f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104095:	e8 46 05 00 00       	call   801045e0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010409a:	83 ec 0c             	sub    $0xc,%esp
8010409d:	68 20 bd 14 80       	push   $0x8014bd20
801040a2:	e8 89 04 00 00       	call   80104530 <acquire>
801040a7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801040aa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ac:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
801040b1:	eb 10                	jmp    801040c3 <wait+0x43>
801040b3:	90                   	nop
801040b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040b8:	83 c3 7c             	add    $0x7c,%ebx
801040bb:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
801040c1:	74 1d                	je     801040e0 <wait+0x60>
      if(p->parent != curproc)
801040c3:	39 73 14             	cmp    %esi,0x14(%ebx)
801040c6:	75 f0                	jne    801040b8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801040c8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040cc:	74 30                	je     801040fe <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ce:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
801040d1:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040d6:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
801040dc:	75 e5                	jne    801040c3 <wait+0x43>
801040de:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801040e0:	85 c0                	test   %eax,%eax
801040e2:	74 70                	je     80104154 <wait+0xd4>
801040e4:	8b 46 24             	mov    0x24(%esi),%eax
801040e7:	85 c0                	test   %eax,%eax
801040e9:	75 69                	jne    80104154 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801040eb:	83 ec 08             	sub    $0x8,%esp
801040ee:	68 20 bd 14 80       	push   $0x8014bd20
801040f3:	56                   	push   %esi
801040f4:	e8 c7 fe ff ff       	call   80103fc0 <sleep>
  }
801040f9:	83 c4 10             	add    $0x10,%esp
801040fc:	eb ac                	jmp    801040aa <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
801040fe:	83 ec 0c             	sub    $0xc,%esp
80104101:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104104:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104107:	e8 d4 e1 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010410c:	5a                   	pop    %edx
8010410d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104110:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104117:	e8 d4 2d 00 00       	call   80106ef0 <freevm>
        p->pid = 0;
8010411c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104123:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010412a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010412e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104135:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010413c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80104143:	e8 08 05 00 00       	call   80104650 <release>
        return pid;
80104148:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010414b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010414e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104150:	5b                   	pop    %ebx
80104151:	5e                   	pop    %esi
80104152:	5d                   	pop    %ebp
80104153:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104154:	83 ec 0c             	sub    $0xc,%esp
80104157:	68 20 bd 14 80       	push   $0x8014bd20
8010415c:	e8 ef 04 00 00       	call   80104650 <release>
      return -1;
80104161:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104164:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104167:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010416c:	5b                   	pop    %ebx
8010416d:	5e                   	pop    %esi
8010416e:	5d                   	pop    %ebp
8010416f:	c3                   	ret    

80104170 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	53                   	push   %ebx
80104174:	83 ec 10             	sub    $0x10,%esp
80104177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010417a:	68 20 bd 14 80       	push   $0x8014bd20
8010417f:	e8 ac 03 00 00       	call   80104530 <acquire>
80104184:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104187:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
8010418c:	eb 0c                	jmp    8010419a <wakeup+0x2a>
8010418e:	66 90                	xchg   %ax,%ax
80104190:	83 c0 7c             	add    $0x7c,%eax
80104193:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80104198:	74 1c                	je     801041b6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010419a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010419e:	75 f0                	jne    80104190 <wakeup+0x20>
801041a0:	3b 58 20             	cmp    0x20(%eax),%ebx
801041a3:	75 eb                	jne    80104190 <wakeup+0x20>
      p->state = RUNNABLE;
801041a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041ac:	83 c0 7c             	add    $0x7c,%eax
801041af:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
801041b4:	75 e4                	jne    8010419a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041b6:	c7 45 08 20 bd 14 80 	movl   $0x8014bd20,0x8(%ebp)
}
801041bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041c0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041c1:	e9 8a 04 00 00       	jmp    80104650 <release>
801041c6:	8d 76 00             	lea    0x0(%esi),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 10             	sub    $0x10,%esp
801041d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041da:	68 20 bd 14 80       	push   $0x8014bd20
801041df:	e8 4c 03 00 00       	call   80104530 <acquire>
801041e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e7:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
801041ec:	eb 0c                	jmp    801041fa <kill+0x2a>
801041ee:	66 90                	xchg   %ax,%ax
801041f0:	83 c0 7c             	add    $0x7c,%eax
801041f3:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
801041f8:	74 3e                	je     80104238 <kill+0x68>
    if(p->pid == pid){
801041fa:	39 58 10             	cmp    %ebx,0x10(%eax)
801041fd:	75 f1                	jne    801041f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801041ff:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104203:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010420a:	74 1c                	je     80104228 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010420c:	83 ec 0c             	sub    $0xc,%esp
8010420f:	68 20 bd 14 80       	push   $0x8014bd20
80104214:	e8 37 04 00 00       	call   80104650 <release>
      return 0;
80104219:	83 c4 10             	add    $0x10,%esp
8010421c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010421e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104221:	c9                   	leave  
80104222:	c3                   	ret    
80104223:	90                   	nop
80104224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104228:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010422f:	eb db                	jmp    8010420c <kill+0x3c>
80104231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	68 20 bd 14 80       	push   $0x8014bd20
80104240:	e8 0b 04 00 00       	call   80104650 <release>
  return -1;
80104245:	83 c4 10             	add    $0x10,%esp
80104248:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010424d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104250:	c9                   	leave  
80104251:	c3                   	ret    
80104252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	57                   	push   %edi
80104264:	56                   	push   %esi
80104265:	53                   	push   %ebx
80104266:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104269:	bb c0 bd 14 80       	mov    $0x8014bdc0,%ebx
8010426e:	83 ec 3c             	sub    $0x3c,%esp
80104271:	eb 24                	jmp    80104297 <procdump+0x37>
80104273:	90                   	nop
80104274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	68 7a 7f 10 80       	push   $0x80107f7a
80104280:	e8 db c3 ff ff       	call   80100660 <cprintf>
80104285:	83 c4 10             	add    $0x10,%esp
80104288:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010428b:	81 fb c0 dc 14 80    	cmp    $0x8014dcc0,%ebx
80104291:	0f 84 81 00 00 00    	je     80104318 <procdump+0xb8>
    if(p->state == UNUSED)
80104297:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010429a:	85 c0                	test   %eax,%eax
8010429c:	74 ea                	je     80104288 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010429e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801042a1:	ba 1f 7b 10 80       	mov    $0x80107b1f,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042a6:	77 11                	ja     801042b9 <procdump+0x59>
801042a8:	8b 14 85 a4 7b 10 80 	mov    -0x7fef845c(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801042af:	b8 1f 7b 10 80       	mov    $0x80107b1f,%eax
801042b4:	85 d2                	test   %edx,%edx
801042b6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042b9:	53                   	push   %ebx
801042ba:	52                   	push   %edx
801042bb:	ff 73 a4             	pushl  -0x5c(%ebx)
801042be:	68 23 7b 10 80       	push   $0x80107b23
801042c3:	e8 98 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801042c8:	83 c4 10             	add    $0x10,%esp
801042cb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801042cf:	75 a7                	jne    80104278 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042d1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042d4:	83 ec 08             	sub    $0x8,%esp
801042d7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042da:	50                   	push   %eax
801042db:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042de:	8b 40 0c             	mov    0xc(%eax),%eax
801042e1:	83 c0 08             	add    $0x8,%eax
801042e4:	50                   	push   %eax
801042e5:	e8 66 01 00 00       	call   80104450 <getcallerpcs>
801042ea:	83 c4 10             	add    $0x10,%esp
801042ed:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801042f0:	8b 17                	mov    (%edi),%edx
801042f2:	85 d2                	test   %edx,%edx
801042f4:	74 82                	je     80104278 <procdump+0x18>
        cprintf(" %p", pc[i]);
801042f6:	83 ec 08             	sub    $0x8,%esp
801042f9:	83 c7 04             	add    $0x4,%edi
801042fc:	52                   	push   %edx
801042fd:	68 e1 74 10 80       	push   $0x801074e1
80104302:	e8 59 c3 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104307:	83 c4 10             	add    $0x10,%esp
8010430a:	39 f7                	cmp    %esi,%edi
8010430c:	75 e2                	jne    801042f0 <procdump+0x90>
8010430e:	e9 65 ff ff ff       	jmp    80104278 <procdump+0x18>
80104313:	90                   	nop
80104314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104318:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010431b:	5b                   	pop    %ebx
8010431c:	5e                   	pop    %esi
8010431d:	5f                   	pop    %edi
8010431e:	5d                   	pop    %ebp
8010431f:	c3                   	ret    

80104320 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	53                   	push   %ebx
80104324:	83 ec 0c             	sub    $0xc,%esp
80104327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010432a:	68 bc 7b 10 80       	push   $0x80107bbc
8010432f:	8d 43 04             	lea    0x4(%ebx),%eax
80104332:	50                   	push   %eax
80104333:	e8 f8 00 00 00       	call   80104430 <initlock>
  lk->name = name;
80104338:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010433b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104341:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104344:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010434b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010434e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104351:	c9                   	leave  
80104352:	c3                   	ret    
80104353:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104360 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	8d 73 04             	lea    0x4(%ebx),%esi
8010436e:	56                   	push   %esi
8010436f:	e8 bc 01 00 00       	call   80104530 <acquire>
  while (lk->locked) {
80104374:	8b 13                	mov    (%ebx),%edx
80104376:	83 c4 10             	add    $0x10,%esp
80104379:	85 d2                	test   %edx,%edx
8010437b:	74 16                	je     80104393 <acquiresleep+0x33>
8010437d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104380:	83 ec 08             	sub    $0x8,%esp
80104383:	56                   	push   %esi
80104384:	53                   	push   %ebx
80104385:	e8 36 fc ff ff       	call   80103fc0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010438a:	8b 03                	mov    (%ebx),%eax
8010438c:	83 c4 10             	add    $0x10,%esp
8010438f:	85 c0                	test   %eax,%eax
80104391:	75 ed                	jne    80104380 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104393:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104399:	e8 02 f5 ff ff       	call   801038a0 <myproc>
8010439e:	8b 40 10             	mov    0x10(%eax),%eax
801043a1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043a4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043aa:	5b                   	pop    %ebx
801043ab:	5e                   	pop    %esi
801043ac:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801043ad:	e9 9e 02 00 00       	jmp    80104650 <release>
801043b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043c0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043c8:	83 ec 0c             	sub    $0xc,%esp
801043cb:	8d 73 04             	lea    0x4(%ebx),%esi
801043ce:	56                   	push   %esi
801043cf:	e8 5c 01 00 00       	call   80104530 <acquire>
  lk->locked = 0;
801043d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043da:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043e1:	89 1c 24             	mov    %ebx,(%esp)
801043e4:	e8 87 fd ff ff       	call   80104170 <wakeup>
  release(&lk->lk);
801043e9:	89 75 08             	mov    %esi,0x8(%ebp)
801043ec:	83 c4 10             	add    $0x10,%esp
}
801043ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043f2:	5b                   	pop    %ebx
801043f3:	5e                   	pop    %esi
801043f4:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801043f5:	e9 56 02 00 00       	jmp    80104650 <release>
801043fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104400 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010440e:	53                   	push   %ebx
8010440f:	e8 1c 01 00 00       	call   80104530 <acquire>
  r = lk->locked;
80104414:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104416:	89 1c 24             	mov    %ebx,(%esp)
80104419:	e8 32 02 00 00       	call   80104650 <release>
  return r;
}
8010441e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104421:	89 f0                	mov    %esi,%eax
80104423:	5b                   	pop    %ebx
80104424:	5e                   	pop    %esi
80104425:	5d                   	pop    %ebp
80104426:	c3                   	ret    
80104427:	66 90                	xchg   %ax,%ax
80104429:	66 90                	xchg   %ax,%ax
8010442b:	66 90                	xchg   %ax,%ax
8010442d:	66 90                	xchg   %ax,%ax
8010442f:	90                   	nop

80104430 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104436:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104439:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010443f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104442:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104449:	5d                   	pop    %ebp
8010444a:	c3                   	ret    
8010444b:	90                   	nop
8010444c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104450 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104454:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104457:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010445a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010445d:	31 c0                	xor    %eax,%eax
8010445f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104460:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104466:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010446c:	77 1a                	ja     80104488 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010446e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104471:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104474:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104477:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104479:	83 f8 0a             	cmp    $0xa,%eax
8010447c:	75 e2                	jne    80104460 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010447e:	5b                   	pop    %ebx
8010447f:	5d                   	pop    %ebp
80104480:	c3                   	ret    
80104481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104488:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010448f:	83 c0 01             	add    $0x1,%eax
80104492:	83 f8 0a             	cmp    $0xa,%eax
80104495:	74 e7                	je     8010447e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104497:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010449e:	83 c0 01             	add    $0x1,%eax
801044a1:	83 f8 0a             	cmp    $0xa,%eax
801044a4:	75 e2                	jne    80104488 <getcallerpcs+0x38>
801044a6:	eb d6                	jmp    8010447e <getcallerpcs+0x2e>
801044a8:	90                   	nop
801044a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044b0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	53                   	push   %ebx
801044b4:	83 ec 04             	sub    $0x4,%esp
801044b7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801044ba:	8b 02                	mov    (%edx),%eax
801044bc:	85 c0                	test   %eax,%eax
801044be:	75 10                	jne    801044d0 <holding+0x20>
}
801044c0:	83 c4 04             	add    $0x4,%esp
801044c3:	31 c0                	xor    %eax,%eax
801044c5:	5b                   	pop    %ebx
801044c6:	5d                   	pop    %ebp
801044c7:	c3                   	ret    
801044c8:	90                   	nop
801044c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044d0:	8b 5a 08             	mov    0x8(%edx),%ebx
801044d3:	e8 28 f3 ff ff       	call   80103800 <mycpu>
801044d8:	39 c3                	cmp    %eax,%ebx
801044da:	0f 94 c0             	sete   %al
}
801044dd:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044e0:	0f b6 c0             	movzbl %al,%eax
}
801044e3:	5b                   	pop    %ebx
801044e4:	5d                   	pop    %ebp
801044e5:	c3                   	ret    
801044e6:	8d 76 00             	lea    0x0(%esi),%esi
801044e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 04             	sub    $0x4,%esp
801044f7:	9c                   	pushf  
801044f8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801044f9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801044fa:	e8 01 f3 ff ff       	call   80103800 <mycpu>
801044ff:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104505:	85 c0                	test   %eax,%eax
80104507:	75 11                	jne    8010451a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104509:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010450f:	e8 ec f2 ff ff       	call   80103800 <mycpu>
80104514:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010451a:	e8 e1 f2 ff ff       	call   80103800 <mycpu>
8010451f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104526:	83 c4 04             	add    $0x4,%esp
80104529:	5b                   	pop    %ebx
8010452a:	5d                   	pop    %ebp
8010452b:	c3                   	ret    
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104535:	e8 b6 ff ff ff       	call   801044f0 <pushcli>
  if(holding(lk))
8010453a:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
8010453d:	8b 03                	mov    (%ebx),%eax
8010453f:	85 c0                	test   %eax,%eax
80104541:	75 7d                	jne    801045c0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104543:	ba 01 00 00 00       	mov    $0x1,%edx
80104548:	eb 09                	jmp    80104553 <acquire+0x23>
8010454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104550:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104553:	89 d0                	mov    %edx,%eax
80104555:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104558:	85 c0                	test   %eax,%eax
8010455a:	75 f4                	jne    80104550 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010455c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104561:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104564:	e8 97 f2 ff ff       	call   80103800 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104569:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010456b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010456e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104571:	31 c0                	xor    %eax,%eax
80104573:	90                   	nop
80104574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104578:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010457e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104584:	77 1a                	ja     801045a0 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104586:	8b 5a 04             	mov    0x4(%edx),%ebx
80104589:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010458c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010458f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104591:	83 f8 0a             	cmp    $0xa,%eax
80104594:	75 e2                	jne    80104578 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104596:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104599:	5b                   	pop    %ebx
8010459a:	5e                   	pop    %esi
8010459b:	5d                   	pop    %ebp
8010459c:	c3                   	ret    
8010459d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801045a0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045a7:	83 c0 01             	add    $0x1,%eax
801045aa:	83 f8 0a             	cmp    $0xa,%eax
801045ad:	74 e7                	je     80104596 <acquire+0x66>
    pcs[i] = 0;
801045af:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045b6:	83 c0 01             	add    $0x1,%eax
801045b9:	83 f8 0a             	cmp    $0xa,%eax
801045bc:	75 e2                	jne    801045a0 <acquire+0x70>
801045be:	eb d6                	jmp    80104596 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045c0:	8b 73 08             	mov    0x8(%ebx),%esi
801045c3:	e8 38 f2 ff ff       	call   80103800 <mycpu>
801045c8:	39 c6                	cmp    %eax,%esi
801045ca:	0f 85 73 ff ff ff    	jne    80104543 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801045d0:	83 ec 0c             	sub    $0xc,%esp
801045d3:	68 c7 7b 10 80       	push   $0x80107bc7
801045d8:	e8 93 bd ff ff       	call   80100370 <panic>
801045dd:	8d 76 00             	lea    0x0(%esi),%esi

801045e0 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045e6:	9c                   	pushf  
801045e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045e8:	f6 c4 02             	test   $0x2,%ah
801045eb:	75 52                	jne    8010463f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045ed:	e8 0e f2 ff ff       	call   80103800 <mycpu>
801045f2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801045f8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801045fb:	85 d2                	test   %edx,%edx
801045fd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104603:	78 2d                	js     80104632 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104605:	e8 f6 f1 ff ff       	call   80103800 <mycpu>
8010460a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104610:	85 d2                	test   %edx,%edx
80104612:	74 0c                	je     80104620 <popcli+0x40>
    sti();
}
80104614:	c9                   	leave  
80104615:	c3                   	ret    
80104616:	8d 76 00             	lea    0x0(%esi),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104620:	e8 db f1 ff ff       	call   80103800 <mycpu>
80104625:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010462b:	85 c0                	test   %eax,%eax
8010462d:	74 e5                	je     80104614 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010462f:	fb                   	sti    
    sti();
}
80104630:	c9                   	leave  
80104631:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104632:	83 ec 0c             	sub    $0xc,%esp
80104635:	68 e6 7b 10 80       	push   $0x80107be6
8010463a:	e8 31 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010463f:	83 ec 0c             	sub    $0xc,%esp
80104642:	68 cf 7b 10 80       	push   $0x80107bcf
80104647:	e8 24 bd ff ff       	call   80100370 <panic>
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104650 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104658:	8b 03                	mov    (%ebx),%eax
8010465a:	85 c0                	test   %eax,%eax
8010465c:	75 12                	jne    80104670 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010465e:	83 ec 0c             	sub    $0xc,%esp
80104661:	68 ed 7b 10 80       	push   $0x80107bed
80104666:	e8 05 bd ff ff       	call   80100370 <panic>
8010466b:	90                   	nop
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104670:	8b 73 08             	mov    0x8(%ebx),%esi
80104673:	e8 88 f1 ff ff       	call   80103800 <mycpu>
80104678:	39 c6                	cmp    %eax,%esi
8010467a:	75 e2                	jne    8010465e <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
8010467c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104683:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010468a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010468f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104695:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104698:	5b                   	pop    %ebx
80104699:	5e                   	pop    %esi
8010469a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010469b:	e9 40 ff ff ff       	jmp    801045e0 <popcli>

801046a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	57                   	push   %edi
801046a4:	53                   	push   %ebx
801046a5:	8b 55 08             	mov    0x8(%ebp),%edx
801046a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046ab:	f6 c2 03             	test   $0x3,%dl
801046ae:	75 05                	jne    801046b5 <memset+0x15>
801046b0:	f6 c1 03             	test   $0x3,%cl
801046b3:	74 13                	je     801046c8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801046b5:	89 d7                	mov    %edx,%edi
801046b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ba:	fc                   	cld    
801046bb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046bd:	5b                   	pop    %ebx
801046be:	89 d0                	mov    %edx,%eax
801046c0:	5f                   	pop    %edi
801046c1:	5d                   	pop    %ebp
801046c2:	c3                   	ret    
801046c3:	90                   	nop
801046c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801046c8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801046cc:	c1 e9 02             	shr    $0x2,%ecx
801046cf:	89 fb                	mov    %edi,%ebx
801046d1:	89 f8                	mov    %edi,%eax
801046d3:	c1 e3 18             	shl    $0x18,%ebx
801046d6:	c1 e0 10             	shl    $0x10,%eax
801046d9:	09 d8                	or     %ebx,%eax
801046db:	09 f8                	or     %edi,%eax
801046dd:	c1 e7 08             	shl    $0x8,%edi
801046e0:	09 f8                	or     %edi,%eax
801046e2:	89 d7                	mov    %edx,%edi
801046e4:	fc                   	cld    
801046e5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046e7:	5b                   	pop    %ebx
801046e8:	89 d0                	mov    %edx,%eax
801046ea:	5f                   	pop    %edi
801046eb:	5d                   	pop    %ebp
801046ec:	c3                   	ret    
801046ed:	8d 76 00             	lea    0x0(%esi),%esi

801046f0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	57                   	push   %edi
801046f4:	56                   	push   %esi
801046f5:	8b 45 10             	mov    0x10(%ebp),%eax
801046f8:	53                   	push   %ebx
801046f9:	8b 75 0c             	mov    0xc(%ebp),%esi
801046fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046ff:	85 c0                	test   %eax,%eax
80104701:	74 29                	je     8010472c <memcmp+0x3c>
    if(*s1 != *s2)
80104703:	0f b6 13             	movzbl (%ebx),%edx
80104706:	0f b6 0e             	movzbl (%esi),%ecx
80104709:	38 d1                	cmp    %dl,%cl
8010470b:	75 2b                	jne    80104738 <memcmp+0x48>
8010470d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104710:	31 c0                	xor    %eax,%eax
80104712:	eb 14                	jmp    80104728 <memcmp+0x38>
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104718:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010471d:	83 c0 01             	add    $0x1,%eax
80104720:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104724:	38 ca                	cmp    %cl,%dl
80104726:	75 10                	jne    80104738 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104728:	39 f8                	cmp    %edi,%eax
8010472a:	75 ec                	jne    80104718 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010472c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010472d:	31 c0                	xor    %eax,%eax
}
8010472f:	5e                   	pop    %esi
80104730:	5f                   	pop    %edi
80104731:	5d                   	pop    %ebp
80104732:	c3                   	ret    
80104733:	90                   	nop
80104734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104738:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010473b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010473c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010473e:	5e                   	pop    %esi
8010473f:	5f                   	pop    %edi
80104740:	5d                   	pop    %ebp
80104741:	c3                   	ret    
80104742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	8b 45 08             	mov    0x8(%ebp),%eax
80104758:	8b 75 0c             	mov    0xc(%ebp),%esi
8010475b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010475e:	39 c6                	cmp    %eax,%esi
80104760:	73 2e                	jae    80104790 <memmove+0x40>
80104762:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104765:	39 c8                	cmp    %ecx,%eax
80104767:	73 27                	jae    80104790 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104769:	85 db                	test   %ebx,%ebx
8010476b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010476e:	74 17                	je     80104787 <memmove+0x37>
      *--d = *--s;
80104770:	29 d9                	sub    %ebx,%ecx
80104772:	89 cb                	mov    %ecx,%ebx
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104778:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010477c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010477f:	83 ea 01             	sub    $0x1,%edx
80104782:	83 fa ff             	cmp    $0xffffffff,%edx
80104785:	75 f1                	jne    80104778 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104787:	5b                   	pop    %ebx
80104788:	5e                   	pop    %esi
80104789:	5d                   	pop    %ebp
8010478a:	c3                   	ret    
8010478b:	90                   	nop
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104790:	31 d2                	xor    %edx,%edx
80104792:	85 db                	test   %ebx,%ebx
80104794:	74 f1                	je     80104787 <memmove+0x37>
80104796:	8d 76 00             	lea    0x0(%esi),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801047a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047a7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047aa:	39 d3                	cmp    %edx,%ebx
801047ac:	75 f2                	jne    801047a0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801047ae:	5b                   	pop    %ebx
801047af:	5e                   	pop    %esi
801047b0:	5d                   	pop    %ebp
801047b1:	c3                   	ret    
801047b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801047c3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801047c4:	eb 8a                	jmp    80104750 <memmove>
801047c6:	8d 76 00             	lea    0x0(%esi),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	57                   	push   %edi
801047d4:	56                   	push   %esi
801047d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047d8:	53                   	push   %ebx
801047d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801047dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801047df:	85 c9                	test   %ecx,%ecx
801047e1:	74 37                	je     8010481a <strncmp+0x4a>
801047e3:	0f b6 17             	movzbl (%edi),%edx
801047e6:	0f b6 1e             	movzbl (%esi),%ebx
801047e9:	84 d2                	test   %dl,%dl
801047eb:	74 3f                	je     8010482c <strncmp+0x5c>
801047ed:	38 d3                	cmp    %dl,%bl
801047ef:	75 3b                	jne    8010482c <strncmp+0x5c>
801047f1:	8d 47 01             	lea    0x1(%edi),%eax
801047f4:	01 cf                	add    %ecx,%edi
801047f6:	eb 1b                	jmp    80104813 <strncmp+0x43>
801047f8:	90                   	nop
801047f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104800:	0f b6 10             	movzbl (%eax),%edx
80104803:	84 d2                	test   %dl,%dl
80104805:	74 21                	je     80104828 <strncmp+0x58>
80104807:	0f b6 19             	movzbl (%ecx),%ebx
8010480a:	83 c0 01             	add    $0x1,%eax
8010480d:	89 ce                	mov    %ecx,%esi
8010480f:	38 da                	cmp    %bl,%dl
80104811:	75 19                	jne    8010482c <strncmp+0x5c>
80104813:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104815:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104818:	75 e6                	jne    80104800 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010481a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010481b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010481d:	5e                   	pop    %esi
8010481e:	5f                   	pop    %edi
8010481f:	5d                   	pop    %ebp
80104820:	c3                   	ret    
80104821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104828:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010482c:	0f b6 c2             	movzbl %dl,%eax
8010482f:	29 d8                	sub    %ebx,%eax
}
80104831:	5b                   	pop    %ebx
80104832:	5e                   	pop    %esi
80104833:	5f                   	pop    %edi
80104834:	5d                   	pop    %ebp
80104835:	c3                   	ret    
80104836:	8d 76 00             	lea    0x0(%esi),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104840 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	56                   	push   %esi
80104844:	53                   	push   %ebx
80104845:	8b 45 08             	mov    0x8(%ebp),%eax
80104848:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010484b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010484e:	89 c2                	mov    %eax,%edx
80104850:	eb 19                	jmp    8010486b <strncpy+0x2b>
80104852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104858:	83 c3 01             	add    $0x1,%ebx
8010485b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010485f:	83 c2 01             	add    $0x1,%edx
80104862:	84 c9                	test   %cl,%cl
80104864:	88 4a ff             	mov    %cl,-0x1(%edx)
80104867:	74 09                	je     80104872 <strncpy+0x32>
80104869:	89 f1                	mov    %esi,%ecx
8010486b:	85 c9                	test   %ecx,%ecx
8010486d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104870:	7f e6                	jg     80104858 <strncpy+0x18>
    ;
  while(n-- > 0)
80104872:	31 c9                	xor    %ecx,%ecx
80104874:	85 f6                	test   %esi,%esi
80104876:	7e 17                	jle    8010488f <strncpy+0x4f>
80104878:	90                   	nop
80104879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104880:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104884:	89 f3                	mov    %esi,%ebx
80104886:	83 c1 01             	add    $0x1,%ecx
80104889:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010488b:	85 db                	test   %ebx,%ebx
8010488d:	7f f1                	jg     80104880 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010488f:	5b                   	pop    %ebx
80104890:	5e                   	pop    %esi
80104891:	5d                   	pop    %ebp
80104892:	c3                   	ret    
80104893:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048a0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
801048a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048a8:	8b 45 08             	mov    0x8(%ebp),%eax
801048ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048ae:	85 c9                	test   %ecx,%ecx
801048b0:	7e 26                	jle    801048d8 <safestrcpy+0x38>
801048b2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048b6:	89 c1                	mov    %eax,%ecx
801048b8:	eb 17                	jmp    801048d1 <safestrcpy+0x31>
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048c0:	83 c2 01             	add    $0x1,%edx
801048c3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048c7:	83 c1 01             	add    $0x1,%ecx
801048ca:	84 db                	test   %bl,%bl
801048cc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048cf:	74 04                	je     801048d5 <safestrcpy+0x35>
801048d1:	39 f2                	cmp    %esi,%edx
801048d3:	75 eb                	jne    801048c0 <safestrcpy+0x20>
    ;
  *s = 0;
801048d5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801048d8:	5b                   	pop    %ebx
801048d9:	5e                   	pop    %esi
801048da:	5d                   	pop    %ebp
801048db:	c3                   	ret    
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048e0 <strlen>:

int
strlen(const char *s)
{
801048e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801048e1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801048e3:	89 e5                	mov    %esp,%ebp
801048e5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801048e8:	80 3a 00             	cmpb   $0x0,(%edx)
801048eb:	74 0c                	je     801048f9 <strlen+0x19>
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
801048f0:	83 c0 01             	add    $0x1,%eax
801048f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048f7:	75 f7                	jne    801048f0 <strlen+0x10>
    ;
  return n;
}
801048f9:	5d                   	pop    %ebp
801048fa:	c3                   	ret    

801048fb <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801048fb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801048ff:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104903:	55                   	push   %ebp
  pushl %ebx
80104904:	53                   	push   %ebx
  pushl %esi
80104905:	56                   	push   %esi
  pushl %edi
80104906:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104907:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104909:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010490b:	5f                   	pop    %edi
  popl %esi
8010490c:	5e                   	pop    %esi
  popl %ebx
8010490d:	5b                   	pop    %ebx
  popl %ebp
8010490e:	5d                   	pop    %ebp
  ret
8010490f:	c3                   	ret    

80104910 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
80104917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010491a:	e8 81 ef ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010491f:	8b 00                	mov    (%eax),%eax
80104921:	39 d8                	cmp    %ebx,%eax
80104923:	76 1b                	jbe    80104940 <fetchint+0x30>
80104925:	8d 53 04             	lea    0x4(%ebx),%edx
80104928:	39 d0                	cmp    %edx,%eax
8010492a:	72 14                	jb     80104940 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010492c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492f:	8b 13                	mov    (%ebx),%edx
80104931:	89 10                	mov    %edx,(%eax)
  return 0;
80104933:	31 c0                	xor    %eax,%eax
}
80104935:	83 c4 04             	add    $0x4,%esp
80104938:	5b                   	pop    %ebx
80104939:	5d                   	pop    %ebp
8010493a:	c3                   	ret    
8010493b:	90                   	nop
8010493c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104945:	eb ee                	jmp    80104935 <fetchint+0x25>
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010495a:	e8 41 ef ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz)
8010495f:	39 18                	cmp    %ebx,(%eax)
80104961:	76 29                	jbe    8010498c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104963:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104966:	89 da                	mov    %ebx,%edx
80104968:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010496a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010496c:	39 c3                	cmp    %eax,%ebx
8010496e:	73 1c                	jae    8010498c <fetchstr+0x3c>
    if(*s == 0)
80104970:	80 3b 00             	cmpb   $0x0,(%ebx)
80104973:	75 10                	jne    80104985 <fetchstr+0x35>
80104975:	eb 29                	jmp    801049a0 <fetchstr+0x50>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104980:	80 3a 00             	cmpb   $0x0,(%edx)
80104983:	74 1b                	je     801049a0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104985:	83 c2 01             	add    $0x1,%edx
80104988:	39 d0                	cmp    %edx,%eax
8010498a:	77 f4                	ja     80104980 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010498c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010498f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104994:	5b                   	pop    %ebx
80104995:	5d                   	pop    %ebp
80104996:	c3                   	ret    
80104997:	89 f6                	mov    %esi,%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049a0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801049a3:	89 d0                	mov    %edx,%eax
801049a5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801049a7:	5b                   	pop    %ebx
801049a8:	5d                   	pop    %ebp
801049a9:	c3                   	ret    
801049aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049b5:	e8 e6 ee ff ff       	call   801038a0 <myproc>
801049ba:	8b 40 18             	mov    0x18(%eax),%eax
801049bd:	8b 55 08             	mov    0x8(%ebp),%edx
801049c0:	8b 40 44             	mov    0x44(%eax),%eax
801049c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801049c6:	e8 d5 ee ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049cb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049cd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049d0:	39 c6                	cmp    %eax,%esi
801049d2:	73 1c                	jae    801049f0 <argint+0x40>
801049d4:	8d 53 08             	lea    0x8(%ebx),%edx
801049d7:	39 d0                	cmp    %edx,%eax
801049d9:	72 15                	jb     801049f0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
801049db:	8b 45 0c             	mov    0xc(%ebp),%eax
801049de:	8b 53 04             	mov    0x4(%ebx),%edx
801049e1:	89 10                	mov    %edx,(%eax)
  return 0;
801049e3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801049e5:	5b                   	pop    %ebx
801049e6:	5e                   	pop    %esi
801049e7:	5d                   	pop    %ebp
801049e8:	c3                   	ret    
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801049f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049f5:	eb ee                	jmp    801049e5 <argint+0x35>
801049f7:	89 f6                	mov    %esi,%esi
801049f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	83 ec 10             	sub    $0x10,%esp
80104a08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a0b:	e8 90 ee ff ff       	call   801038a0 <myproc>
80104a10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104a12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a15:	83 ec 08             	sub    $0x8,%esp
80104a18:	50                   	push   %eax
80104a19:	ff 75 08             	pushl  0x8(%ebp)
80104a1c:	e8 8f ff ff ff       	call   801049b0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a21:	c1 e8 1f             	shr    $0x1f,%eax
80104a24:	83 c4 10             	add    $0x10,%esp
80104a27:	84 c0                	test   %al,%al
80104a29:	75 2d                	jne    80104a58 <argptr+0x58>
80104a2b:	89 d8                	mov    %ebx,%eax
80104a2d:	c1 e8 1f             	shr    $0x1f,%eax
80104a30:	84 c0                	test   %al,%al
80104a32:	75 24                	jne    80104a58 <argptr+0x58>
80104a34:	8b 16                	mov    (%esi),%edx
80104a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a39:	39 c2                	cmp    %eax,%edx
80104a3b:	76 1b                	jbe    80104a58 <argptr+0x58>
80104a3d:	01 c3                	add    %eax,%ebx
80104a3f:	39 da                	cmp    %ebx,%edx
80104a41:	72 15                	jb     80104a58 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104a43:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a46:	89 02                	mov    %eax,(%edx)
  return 0;
80104a48:	31 c0                	xor    %eax,%eax
}
80104a4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a4d:	5b                   	pop    %ebx
80104a4e:	5e                   	pop    %esi
80104a4f:	5d                   	pop    %ebp
80104a50:	c3                   	ret    
80104a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a5d:	eb eb                	jmp    80104a4a <argptr+0x4a>
80104a5f:	90                   	nop

80104a60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a69:	50                   	push   %eax
80104a6a:	ff 75 08             	pushl  0x8(%ebp)
80104a6d:	e8 3e ff ff ff       	call   801049b0 <argint>
80104a72:	83 c4 10             	add    $0x10,%esp
80104a75:	85 c0                	test   %eax,%eax
80104a77:	78 17                	js     80104a90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a79:	83 ec 08             	sub    $0x8,%esp
80104a7c:	ff 75 0c             	pushl  0xc(%ebp)
80104a7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a82:	e8 c9 fe ff ff       	call   80104950 <fetchstr>
80104a87:	83 c4 10             	add    $0x10,%esp
}
80104a8a:	c9                   	leave  
80104a8b:	c3                   	ret    
80104a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a95:	c9                   	leave  
80104a96:	c3                   	ret    
80104a97:	89 f6                	mov    %esi,%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <syscall>:
[SYS_forkcow]       sys_forkcow,
};

void
syscall(void)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104aa5:	e8 f6 ed ff ff       	call   801038a0 <myproc>

  num = curproc->tf->eax;
80104aaa:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104aad:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104aaf:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ab2:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ab5:	83 fa 18             	cmp    $0x18,%edx
80104ab8:	77 1e                	ja     80104ad8 <syscall+0x38>
80104aba:	8b 14 85 20 7c 10 80 	mov    -0x7fef83e0(,%eax,4),%edx
80104ac1:	85 d2                	test   %edx,%edx
80104ac3:	74 13                	je     80104ad8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104ac5:	ff d2                	call   *%edx
80104ac7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104aca:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104acd:	5b                   	pop    %ebx
80104ace:	5e                   	pop    %esi
80104acf:	5d                   	pop    %ebp
80104ad0:	c3                   	ret    
80104ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104ad8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ad9:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104adc:	50                   	push   %eax
80104add:	ff 73 10             	pushl  0x10(%ebx)
80104ae0:	68 f5 7b 10 80       	push   $0x80107bf5
80104ae5:	e8 76 bb ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104aea:	8b 43 18             	mov    0x18(%ebx),%eax
80104aed:	83 c4 10             	add    $0x10,%esp
80104af0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104af7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104afa:	5b                   	pop    %ebx
80104afb:	5e                   	pop    %esi
80104afc:	5d                   	pop    %ebp
80104afd:	c3                   	ret    
80104afe:	66 90                	xchg   %ax,%ax

80104b00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	57                   	push   %edi
80104b04:	56                   	push   %esi
80104b05:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b06:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b09:	83 ec 44             	sub    $0x44,%esp
80104b0c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b12:	56                   	push   %esi
80104b13:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b14:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b17:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b1a:	e8 c1 d3 ff ff       	call   80101ee0 <nameiparent>
80104b1f:	83 c4 10             	add    $0x10,%esp
80104b22:	85 c0                	test   %eax,%eax
80104b24:	0f 84 f6 00 00 00    	je     80104c20 <create+0x120>
    return 0;
  ilock(dp);
80104b2a:	83 ec 0c             	sub    $0xc,%esp
80104b2d:	89 c7                	mov    %eax,%edi
80104b2f:	50                   	push   %eax
80104b30:	e8 3b cb ff ff       	call   80101670 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b35:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b38:	83 c4 0c             	add    $0xc,%esp
80104b3b:	50                   	push   %eax
80104b3c:	56                   	push   %esi
80104b3d:	57                   	push   %edi
80104b3e:	e8 5d d0 ff ff       	call   80101ba0 <dirlookup>
80104b43:	83 c4 10             	add    $0x10,%esp
80104b46:	85 c0                	test   %eax,%eax
80104b48:	89 c3                	mov    %eax,%ebx
80104b4a:	74 54                	je     80104ba0 <create+0xa0>
    iunlockput(dp);
80104b4c:	83 ec 0c             	sub    $0xc,%esp
80104b4f:	57                   	push   %edi
80104b50:	e8 ab cd ff ff       	call   80101900 <iunlockput>
    ilock(ip);
80104b55:	89 1c 24             	mov    %ebx,(%esp)
80104b58:	e8 13 cb ff ff       	call   80101670 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b5d:	83 c4 10             	add    $0x10,%esp
80104b60:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b65:	75 19                	jne    80104b80 <create+0x80>
80104b67:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104b6c:	89 d8                	mov    %ebx,%eax
80104b6e:	75 10                	jne    80104b80 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b73:	5b                   	pop    %ebx
80104b74:	5e                   	pop    %esi
80104b75:	5f                   	pop    %edi
80104b76:	5d                   	pop    %ebp
80104b77:	c3                   	ret    
80104b78:	90                   	nop
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b80:	83 ec 0c             	sub    $0xc,%esp
80104b83:	53                   	push   %ebx
80104b84:	e8 77 cd ff ff       	call   80101900 <iunlockput>
    return 0;
80104b89:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104b8f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b91:	5b                   	pop    %ebx
80104b92:	5e                   	pop    %esi
80104b93:	5f                   	pop    %edi
80104b94:	5d                   	pop    %ebp
80104b95:	c3                   	ret    
80104b96:	8d 76 00             	lea    0x0(%esi),%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104ba0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ba4:	83 ec 08             	sub    $0x8,%esp
80104ba7:	50                   	push   %eax
80104ba8:	ff 37                	pushl  (%edi)
80104baa:	e8 51 c9 ff ff       	call   80101500 <ialloc>
80104baf:	83 c4 10             	add    $0x10,%esp
80104bb2:	85 c0                	test   %eax,%eax
80104bb4:	89 c3                	mov    %eax,%ebx
80104bb6:	0f 84 cc 00 00 00    	je     80104c88 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104bbc:	83 ec 0c             	sub    $0xc,%esp
80104bbf:	50                   	push   %eax
80104bc0:	e8 ab ca ff ff       	call   80101670 <ilock>
  ip->major = major;
80104bc5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104bc9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104bcd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104bd1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104bd5:	b8 01 00 00 00       	mov    $0x1,%eax
80104bda:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104bde:	89 1c 24             	mov    %ebx,(%esp)
80104be1:	e8 da c9 ff ff       	call   801015c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104be6:	83 c4 10             	add    $0x10,%esp
80104be9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104bee:	74 40                	je     80104c30 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104bf0:	83 ec 04             	sub    $0x4,%esp
80104bf3:	ff 73 04             	pushl  0x4(%ebx)
80104bf6:	56                   	push   %esi
80104bf7:	57                   	push   %edi
80104bf8:	e8 03 d2 ff ff       	call   80101e00 <dirlink>
80104bfd:	83 c4 10             	add    $0x10,%esp
80104c00:	85 c0                	test   %eax,%eax
80104c02:	78 77                	js     80104c7b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104c04:	83 ec 0c             	sub    $0xc,%esp
80104c07:	57                   	push   %edi
80104c08:	e8 f3 cc ff ff       	call   80101900 <iunlockput>

  return ip;
80104c0d:	83 c4 10             	add    $0x10,%esp
}
80104c10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104c13:	89 d8                	mov    %ebx,%eax
}
80104c15:	5b                   	pop    %ebx
80104c16:	5e                   	pop    %esi
80104c17:	5f                   	pop    %edi
80104c18:	5d                   	pop    %ebp
80104c19:	c3                   	ret    
80104c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104c20:	31 c0                	xor    %eax,%eax
80104c22:	e9 49 ff ff ff       	jmp    80104b70 <create+0x70>
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104c30:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104c35:	83 ec 0c             	sub    $0xc,%esp
80104c38:	57                   	push   %edi
80104c39:	e8 82 c9 ff ff       	call   801015c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c3e:	83 c4 0c             	add    $0xc,%esp
80104c41:	ff 73 04             	pushl  0x4(%ebx)
80104c44:	68 a4 7c 10 80       	push   $0x80107ca4
80104c49:	53                   	push   %ebx
80104c4a:	e8 b1 d1 ff ff       	call   80101e00 <dirlink>
80104c4f:	83 c4 10             	add    $0x10,%esp
80104c52:	85 c0                	test   %eax,%eax
80104c54:	78 18                	js     80104c6e <create+0x16e>
80104c56:	83 ec 04             	sub    $0x4,%esp
80104c59:	ff 77 04             	pushl  0x4(%edi)
80104c5c:	68 a3 7c 10 80       	push   $0x80107ca3
80104c61:	53                   	push   %ebx
80104c62:	e8 99 d1 ff ff       	call   80101e00 <dirlink>
80104c67:	83 c4 10             	add    $0x10,%esp
80104c6a:	85 c0                	test   %eax,%eax
80104c6c:	79 82                	jns    80104bf0 <create+0xf0>
      panic("create dots");
80104c6e:	83 ec 0c             	sub    $0xc,%esp
80104c71:	68 97 7c 10 80       	push   $0x80107c97
80104c76:	e8 f5 b6 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104c7b:	83 ec 0c             	sub    $0xc,%esp
80104c7e:	68 a6 7c 10 80       	push   $0x80107ca6
80104c83:	e8 e8 b6 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104c88:	83 ec 0c             	sub    $0xc,%esp
80104c8b:	68 88 7c 10 80       	push   $0x80107c88
80104c90:	e8 db b6 ff ff       	call   80100370 <panic>
80104c95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	56                   	push   %esi
80104ca4:	53                   	push   %ebx
80104ca5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104ca7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104caa:	89 d3                	mov    %edx,%ebx
80104cac:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104caf:	50                   	push   %eax
80104cb0:	6a 00                	push   $0x0
80104cb2:	e8 f9 fc ff ff       	call   801049b0 <argint>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	78 32                	js     80104cf0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104cbe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104cc2:	77 2c                	ja     80104cf0 <argfd.constprop.0+0x50>
80104cc4:	e8 d7 eb ff ff       	call   801038a0 <myproc>
80104cc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ccc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104cd0:	85 c0                	test   %eax,%eax
80104cd2:	74 1c                	je     80104cf0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104cd4:	85 f6                	test   %esi,%esi
80104cd6:	74 02                	je     80104cda <argfd.constprop.0+0x3a>
    *pfd = fd;
80104cd8:	89 16                	mov    %edx,(%esi)
  if(pf)
80104cda:	85 db                	test   %ebx,%ebx
80104cdc:	74 22                	je     80104d00 <argfd.constprop.0+0x60>
    *pf = f;
80104cde:	89 03                	mov    %eax,(%ebx)
  return 0;
80104ce0:	31 c0                	xor    %eax,%eax
}
80104ce2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce5:	5b                   	pop    %ebx
80104ce6:	5e                   	pop    %esi
80104ce7:	5d                   	pop    %ebp
80104ce8:	c3                   	ret    
80104ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cf0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104cf3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104cf8:	5b                   	pop    %ebx
80104cf9:	5e                   	pop    %esi
80104cfa:	5d                   	pop    %ebp
80104cfb:	c3                   	ret    
80104cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104d00:	31 c0                	xor    %eax,%eax
80104d02:	eb de                	jmp    80104ce2 <argfd.constprop.0+0x42>
80104d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d10 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104d10:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d11:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104d13:	89 e5                	mov    %esp,%ebp
80104d15:	56                   	push   %esi
80104d16:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d17:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104d1a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d1d:	e8 7e ff ff ff       	call   80104ca0 <argfd.constprop.0>
80104d22:	85 c0                	test   %eax,%eax
80104d24:	78 1a                	js     80104d40 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d26:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104d28:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104d2b:	e8 70 eb ff ff       	call   801038a0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104d30:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d34:	85 d2                	test   %edx,%edx
80104d36:	74 18                	je     80104d50 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d38:	83 c3 01             	add    $0x1,%ebx
80104d3b:	83 fb 10             	cmp    $0x10,%ebx
80104d3e:	75 f0                	jne    80104d30 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d48:	5b                   	pop    %ebx
80104d49:	5e                   	pop    %esi
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
80104d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104d50:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104d54:	83 ec 0c             	sub    $0xc,%esp
80104d57:	ff 75 f4             	pushl  -0xc(%ebp)
80104d5a:	e8 81 c0 ff ff       	call   80100de0 <filedup>
  return fd;
80104d5f:	83 c4 10             	add    $0x10,%esp
}
80104d62:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104d65:	89 d8                	mov    %ebx,%eax
}
80104d67:	5b                   	pop    %ebx
80104d68:	5e                   	pop    %esi
80104d69:	5d                   	pop    %ebp
80104d6a:	c3                   	ret    
80104d6b:	90                   	nop
80104d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d70 <sys_read>:

int
sys_read(void)
{
80104d70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d71:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104d73:	89 e5                	mov    %esp,%ebp
80104d75:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d7b:	e8 20 ff ff ff       	call   80104ca0 <argfd.constprop.0>
80104d80:	85 c0                	test   %eax,%eax
80104d82:	78 4c                	js     80104dd0 <sys_read+0x60>
80104d84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d87:	83 ec 08             	sub    $0x8,%esp
80104d8a:	50                   	push   %eax
80104d8b:	6a 02                	push   $0x2
80104d8d:	e8 1e fc ff ff       	call   801049b0 <argint>
80104d92:	83 c4 10             	add    $0x10,%esp
80104d95:	85 c0                	test   %eax,%eax
80104d97:	78 37                	js     80104dd0 <sys_read+0x60>
80104d99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d9c:	83 ec 04             	sub    $0x4,%esp
80104d9f:	ff 75 f0             	pushl  -0x10(%ebp)
80104da2:	50                   	push   %eax
80104da3:	6a 01                	push   $0x1
80104da5:	e8 56 fc ff ff       	call   80104a00 <argptr>
80104daa:	83 c4 10             	add    $0x10,%esp
80104dad:	85 c0                	test   %eax,%eax
80104daf:	78 1f                	js     80104dd0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104db1:	83 ec 04             	sub    $0x4,%esp
80104db4:	ff 75 f0             	pushl  -0x10(%ebp)
80104db7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dba:	ff 75 ec             	pushl  -0x14(%ebp)
80104dbd:	e8 8e c1 ff ff       	call   80100f50 <fileread>
80104dc2:	83 c4 10             	add    $0x10,%esp
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <sys_write>:

int
sys_write(void)
{
80104de0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104de1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104de3:	89 e5                	mov    %esp,%ebp
80104de5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104de8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104deb:	e8 b0 fe ff ff       	call   80104ca0 <argfd.constprop.0>
80104df0:	85 c0                	test   %eax,%eax
80104df2:	78 4c                	js     80104e40 <sys_write+0x60>
80104df4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104df7:	83 ec 08             	sub    $0x8,%esp
80104dfa:	50                   	push   %eax
80104dfb:	6a 02                	push   $0x2
80104dfd:	e8 ae fb ff ff       	call   801049b0 <argint>
80104e02:	83 c4 10             	add    $0x10,%esp
80104e05:	85 c0                	test   %eax,%eax
80104e07:	78 37                	js     80104e40 <sys_write+0x60>
80104e09:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e0c:	83 ec 04             	sub    $0x4,%esp
80104e0f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e12:	50                   	push   %eax
80104e13:	6a 01                	push   $0x1
80104e15:	e8 e6 fb ff ff       	call   80104a00 <argptr>
80104e1a:	83 c4 10             	add    $0x10,%esp
80104e1d:	85 c0                	test   %eax,%eax
80104e1f:	78 1f                	js     80104e40 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104e21:	83 ec 04             	sub    $0x4,%esp
80104e24:	ff 75 f0             	pushl  -0x10(%ebp)
80104e27:	ff 75 f4             	pushl  -0xc(%ebp)
80104e2a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e2d:	e8 ae c1 ff ff       	call   80100fe0 <filewrite>
80104e32:	83 c4 10             	add    $0x10,%esp
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	89 f6                	mov    %esi,%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <sys_close>:

int
sys_close(void)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104e56:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e59:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e5c:	e8 3f fe ff ff       	call   80104ca0 <argfd.constprop.0>
80104e61:	85 c0                	test   %eax,%eax
80104e63:	78 2b                	js     80104e90 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104e65:	e8 36 ea ff ff       	call   801038a0 <myproc>
80104e6a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e6d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104e70:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e77:	00 
  fileclose(f);
80104e78:	ff 75 f4             	pushl  -0xc(%ebp)
80104e7b:	e8 b0 bf ff ff       	call   80100e30 <fileclose>
  return 0;
80104e80:	83 c4 10             	add    $0x10,%esp
80104e83:	31 c0                	xor    %eax,%eax
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <sys_fstat>:

int
sys_fstat(void)
{
80104ea0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ea1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ea3:	89 e5                	mov    %esp,%ebp
80104ea5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ea8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104eab:	e8 f0 fd ff ff       	call   80104ca0 <argfd.constprop.0>
80104eb0:	85 c0                	test   %eax,%eax
80104eb2:	78 2c                	js     80104ee0 <sys_fstat+0x40>
80104eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eb7:	83 ec 04             	sub    $0x4,%esp
80104eba:	6a 14                	push   $0x14
80104ebc:	50                   	push   %eax
80104ebd:	6a 01                	push   $0x1
80104ebf:	e8 3c fb ff ff       	call   80104a00 <argptr>
80104ec4:	83 c4 10             	add    $0x10,%esp
80104ec7:	85 c0                	test   %eax,%eax
80104ec9:	78 15                	js     80104ee0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104ecb:	83 ec 08             	sub    $0x8,%esp
80104ece:	ff 75 f4             	pushl  -0xc(%ebp)
80104ed1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ed4:	e8 27 c0 ff ff       	call   80100f00 <filestat>
80104ed9:	83 c4 10             	add    $0x10,%esp
}
80104edc:	c9                   	leave  
80104edd:	c3                   	ret    
80104ede:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104ee5:	c9                   	leave  
80104ee6:	c3                   	ret    
80104ee7:	89 f6                	mov    %esi,%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	57                   	push   %edi
80104ef4:	56                   	push   %esi
80104ef5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ef6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ef9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104efc:	50                   	push   %eax
80104efd:	6a 00                	push   $0x0
80104eff:	e8 5c fb ff ff       	call   80104a60 <argstr>
80104f04:	83 c4 10             	add    $0x10,%esp
80104f07:	85 c0                	test   %eax,%eax
80104f09:	0f 88 fb 00 00 00    	js     8010500a <sys_link+0x11a>
80104f0f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f12:	83 ec 08             	sub    $0x8,%esp
80104f15:	50                   	push   %eax
80104f16:	6a 01                	push   $0x1
80104f18:	e8 43 fb ff ff       	call   80104a60 <argstr>
80104f1d:	83 c4 10             	add    $0x10,%esp
80104f20:	85 c0                	test   %eax,%eax
80104f22:	0f 88 e2 00 00 00    	js     8010500a <sys_link+0x11a>
    return -1;

  begin_op();
80104f28:	e8 43 dd ff ff       	call   80102c70 <begin_op>
  if((ip = namei(old)) == 0){
80104f2d:	83 ec 0c             	sub    $0xc,%esp
80104f30:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f33:	e8 88 cf ff ff       	call   80101ec0 <namei>
80104f38:	83 c4 10             	add    $0x10,%esp
80104f3b:	85 c0                	test   %eax,%eax
80104f3d:	89 c3                	mov    %eax,%ebx
80104f3f:	0f 84 f3 00 00 00    	je     80105038 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104f45:	83 ec 0c             	sub    $0xc,%esp
80104f48:	50                   	push   %eax
80104f49:	e8 22 c7 ff ff       	call   80101670 <ilock>
  if(ip->type == T_DIR){
80104f4e:	83 c4 10             	add    $0x10,%esp
80104f51:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f56:	0f 84 c4 00 00 00    	je     80105020 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104f5c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f61:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104f64:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104f67:	53                   	push   %ebx
80104f68:	e8 53 c6 ff ff       	call   801015c0 <iupdate>
  iunlock(ip);
80104f6d:	89 1c 24             	mov    %ebx,(%esp)
80104f70:	e8 db c7 ff ff       	call   80101750 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104f75:	58                   	pop    %eax
80104f76:	5a                   	pop    %edx
80104f77:	57                   	push   %edi
80104f78:	ff 75 d0             	pushl  -0x30(%ebp)
80104f7b:	e8 60 cf ff ff       	call   80101ee0 <nameiparent>
80104f80:	83 c4 10             	add    $0x10,%esp
80104f83:	85 c0                	test   %eax,%eax
80104f85:	89 c6                	mov    %eax,%esi
80104f87:	74 5b                	je     80104fe4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104f89:	83 ec 0c             	sub    $0xc,%esp
80104f8c:	50                   	push   %eax
80104f8d:	e8 de c6 ff ff       	call   80101670 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f92:	83 c4 10             	add    $0x10,%esp
80104f95:	8b 03                	mov    (%ebx),%eax
80104f97:	39 06                	cmp    %eax,(%esi)
80104f99:	75 3d                	jne    80104fd8 <sys_link+0xe8>
80104f9b:	83 ec 04             	sub    $0x4,%esp
80104f9e:	ff 73 04             	pushl  0x4(%ebx)
80104fa1:	57                   	push   %edi
80104fa2:	56                   	push   %esi
80104fa3:	e8 58 ce ff ff       	call   80101e00 <dirlink>
80104fa8:	83 c4 10             	add    $0x10,%esp
80104fab:	85 c0                	test   %eax,%eax
80104fad:	78 29                	js     80104fd8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104faf:	83 ec 0c             	sub    $0xc,%esp
80104fb2:	56                   	push   %esi
80104fb3:	e8 48 c9 ff ff       	call   80101900 <iunlockput>
  iput(ip);
80104fb8:	89 1c 24             	mov    %ebx,(%esp)
80104fbb:	e8 e0 c7 ff ff       	call   801017a0 <iput>

  end_op();
80104fc0:	e8 1b dd ff ff       	call   80102ce0 <end_op>

  return 0;
80104fc5:	83 c4 10             	add    $0x10,%esp
80104fc8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fcd:	5b                   	pop    %ebx
80104fce:	5e                   	pop    %esi
80104fcf:	5f                   	pop    %edi
80104fd0:	5d                   	pop    %ebp
80104fd1:	c3                   	ret    
80104fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104fd8:	83 ec 0c             	sub    $0xc,%esp
80104fdb:	56                   	push   %esi
80104fdc:	e8 1f c9 ff ff       	call   80101900 <iunlockput>
    goto bad;
80104fe1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104fe4:	83 ec 0c             	sub    $0xc,%esp
80104fe7:	53                   	push   %ebx
80104fe8:	e8 83 c6 ff ff       	call   80101670 <ilock>
  ip->nlink--;
80104fed:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ff2:	89 1c 24             	mov    %ebx,(%esp)
80104ff5:	e8 c6 c5 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
80104ffa:	89 1c 24             	mov    %ebx,(%esp)
80104ffd:	e8 fe c8 ff ff       	call   80101900 <iunlockput>
  end_op();
80105002:	e8 d9 dc ff ff       	call   80102ce0 <end_op>
  return -1;
80105007:	83 c4 10             	add    $0x10,%esp
}
8010500a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010500d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105012:	5b                   	pop    %ebx
80105013:	5e                   	pop    %esi
80105014:	5f                   	pop    %edi
80105015:	5d                   	pop    %ebp
80105016:	c3                   	ret    
80105017:	89 f6                	mov    %esi,%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105020:	83 ec 0c             	sub    $0xc,%esp
80105023:	53                   	push   %ebx
80105024:	e8 d7 c8 ff ff       	call   80101900 <iunlockput>
    end_op();
80105029:	e8 b2 dc ff ff       	call   80102ce0 <end_op>
    return -1;
8010502e:	83 c4 10             	add    $0x10,%esp
80105031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105036:	eb 92                	jmp    80104fca <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105038:	e8 a3 dc ff ff       	call   80102ce0 <end_op>
    return -1;
8010503d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105042:	eb 86                	jmp    80104fca <sys_link+0xda>
80105044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010504a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105050 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	57                   	push   %edi
80105054:	56                   	push   %esi
80105055:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105056:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105059:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010505c:	50                   	push   %eax
8010505d:	6a 00                	push   $0x0
8010505f:	e8 fc f9 ff ff       	call   80104a60 <argstr>
80105064:	83 c4 10             	add    $0x10,%esp
80105067:	85 c0                	test   %eax,%eax
80105069:	0f 88 82 01 00 00    	js     801051f1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010506f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105072:	e8 f9 db ff ff       	call   80102c70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105077:	83 ec 08             	sub    $0x8,%esp
8010507a:	53                   	push   %ebx
8010507b:	ff 75 c0             	pushl  -0x40(%ebp)
8010507e:	e8 5d ce ff ff       	call   80101ee0 <nameiparent>
80105083:	83 c4 10             	add    $0x10,%esp
80105086:	85 c0                	test   %eax,%eax
80105088:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010508b:	0f 84 6a 01 00 00    	je     801051fb <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105091:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105094:	83 ec 0c             	sub    $0xc,%esp
80105097:	56                   	push   %esi
80105098:	e8 d3 c5 ff ff       	call   80101670 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010509d:	58                   	pop    %eax
8010509e:	5a                   	pop    %edx
8010509f:	68 a4 7c 10 80       	push   $0x80107ca4
801050a4:	53                   	push   %ebx
801050a5:	e8 d6 ca ff ff       	call   80101b80 <namecmp>
801050aa:	83 c4 10             	add    $0x10,%esp
801050ad:	85 c0                	test   %eax,%eax
801050af:	0f 84 fc 00 00 00    	je     801051b1 <sys_unlink+0x161>
801050b5:	83 ec 08             	sub    $0x8,%esp
801050b8:	68 a3 7c 10 80       	push   $0x80107ca3
801050bd:	53                   	push   %ebx
801050be:	e8 bd ca ff ff       	call   80101b80 <namecmp>
801050c3:	83 c4 10             	add    $0x10,%esp
801050c6:	85 c0                	test   %eax,%eax
801050c8:	0f 84 e3 00 00 00    	je     801051b1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801050ce:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050d1:	83 ec 04             	sub    $0x4,%esp
801050d4:	50                   	push   %eax
801050d5:	53                   	push   %ebx
801050d6:	56                   	push   %esi
801050d7:	e8 c4 ca ff ff       	call   80101ba0 <dirlookup>
801050dc:	83 c4 10             	add    $0x10,%esp
801050df:	85 c0                	test   %eax,%eax
801050e1:	89 c3                	mov    %eax,%ebx
801050e3:	0f 84 c8 00 00 00    	je     801051b1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
801050e9:	83 ec 0c             	sub    $0xc,%esp
801050ec:	50                   	push   %eax
801050ed:	e8 7e c5 ff ff       	call   80101670 <ilock>

  if(ip->nlink < 1)
801050f2:	83 c4 10             	add    $0x10,%esp
801050f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050fa:	0f 8e 24 01 00 00    	jle    80105224 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105100:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105105:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105108:	74 66                	je     80105170 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010510a:	83 ec 04             	sub    $0x4,%esp
8010510d:	6a 10                	push   $0x10
8010510f:	6a 00                	push   $0x0
80105111:	56                   	push   %esi
80105112:	e8 89 f5 ff ff       	call   801046a0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105117:	6a 10                	push   $0x10
80105119:	ff 75 c4             	pushl  -0x3c(%ebp)
8010511c:	56                   	push   %esi
8010511d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105120:	e8 2b c9 ff ff       	call   80101a50 <writei>
80105125:	83 c4 20             	add    $0x20,%esp
80105128:	83 f8 10             	cmp    $0x10,%eax
8010512b:	0f 85 e6 00 00 00    	jne    80105217 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105131:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105136:	0f 84 9c 00 00 00    	je     801051d8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010513c:	83 ec 0c             	sub    $0xc,%esp
8010513f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105142:	e8 b9 c7 ff ff       	call   80101900 <iunlockput>

  ip->nlink--;
80105147:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010514c:	89 1c 24             	mov    %ebx,(%esp)
8010514f:	e8 6c c4 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
80105154:	89 1c 24             	mov    %ebx,(%esp)
80105157:	e8 a4 c7 ff ff       	call   80101900 <iunlockput>

  end_op();
8010515c:	e8 7f db ff ff       	call   80102ce0 <end_op>

  return 0;
80105161:	83 c4 10             	add    $0x10,%esp
80105164:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105169:	5b                   	pop    %ebx
8010516a:	5e                   	pop    %esi
8010516b:	5f                   	pop    %edi
8010516c:	5d                   	pop    %ebp
8010516d:	c3                   	ret    
8010516e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105170:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105174:	76 94                	jbe    8010510a <sys_unlink+0xba>
80105176:	bf 20 00 00 00       	mov    $0x20,%edi
8010517b:	eb 0f                	jmp    8010518c <sys_unlink+0x13c>
8010517d:	8d 76 00             	lea    0x0(%esi),%esi
80105180:	83 c7 10             	add    $0x10,%edi
80105183:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105186:	0f 83 7e ff ff ff    	jae    8010510a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010518c:	6a 10                	push   $0x10
8010518e:	57                   	push   %edi
8010518f:	56                   	push   %esi
80105190:	53                   	push   %ebx
80105191:	e8 ba c7 ff ff       	call   80101950 <readi>
80105196:	83 c4 10             	add    $0x10,%esp
80105199:	83 f8 10             	cmp    $0x10,%eax
8010519c:	75 6c                	jne    8010520a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010519e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051a3:	74 db                	je     80105180 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801051a5:	83 ec 0c             	sub    $0xc,%esp
801051a8:	53                   	push   %ebx
801051a9:	e8 52 c7 ff ff       	call   80101900 <iunlockput>
    goto bad;
801051ae:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801051b1:	83 ec 0c             	sub    $0xc,%esp
801051b4:	ff 75 b4             	pushl  -0x4c(%ebp)
801051b7:	e8 44 c7 ff ff       	call   80101900 <iunlockput>
  end_op();
801051bc:	e8 1f db ff ff       	call   80102ce0 <end_op>
  return -1;
801051c1:	83 c4 10             	add    $0x10,%esp
}
801051c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801051c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051cc:	5b                   	pop    %ebx
801051cd:	5e                   	pop    %esi
801051ce:	5f                   	pop    %edi
801051cf:	5d                   	pop    %ebp
801051d0:	c3                   	ret    
801051d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051d8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801051db:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051de:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801051e3:	50                   	push   %eax
801051e4:	e8 d7 c3 ff ff       	call   801015c0 <iupdate>
801051e9:	83 c4 10             	add    $0x10,%esp
801051ec:	e9 4b ff ff ff       	jmp    8010513c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
801051f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051f6:	e9 6b ff ff ff       	jmp    80105166 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
801051fb:	e8 e0 da ff ff       	call   80102ce0 <end_op>
    return -1;
80105200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105205:	e9 5c ff ff ff       	jmp    80105166 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010520a:	83 ec 0c             	sub    $0xc,%esp
8010520d:	68 c8 7c 10 80       	push   $0x80107cc8
80105212:	e8 59 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105217:	83 ec 0c             	sub    $0xc,%esp
8010521a:	68 da 7c 10 80       	push   $0x80107cda
8010521f:	e8 4c b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105224:	83 ec 0c             	sub    $0xc,%esp
80105227:	68 b6 7c 10 80       	push   $0x80107cb6
8010522c:	e8 3f b1 ff ff       	call   80100370 <panic>
80105231:	eb 0d                	jmp    80105240 <sys_open>
80105233:	90                   	nop
80105234:	90                   	nop
80105235:	90                   	nop
80105236:	90                   	nop
80105237:	90                   	nop
80105238:	90                   	nop
80105239:	90                   	nop
8010523a:	90                   	nop
8010523b:	90                   	nop
8010523c:	90                   	nop
8010523d:	90                   	nop
8010523e:	90                   	nop
8010523f:	90                   	nop

80105240 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	57                   	push   %edi
80105244:	56                   	push   %esi
80105245:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105246:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105249:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010524c:	50                   	push   %eax
8010524d:	6a 00                	push   $0x0
8010524f:	e8 0c f8 ff ff       	call   80104a60 <argstr>
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
80105259:	0f 88 9e 00 00 00    	js     801052fd <sys_open+0xbd>
8010525f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105262:	83 ec 08             	sub    $0x8,%esp
80105265:	50                   	push   %eax
80105266:	6a 01                	push   $0x1
80105268:	e8 43 f7 ff ff       	call   801049b0 <argint>
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	85 c0                	test   %eax,%eax
80105272:	0f 88 85 00 00 00    	js     801052fd <sys_open+0xbd>
    return -1;

  begin_op();
80105278:	e8 f3 d9 ff ff       	call   80102c70 <begin_op>

  if(omode & O_CREATE){
8010527d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105281:	0f 85 89 00 00 00    	jne    80105310 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105287:	83 ec 0c             	sub    $0xc,%esp
8010528a:	ff 75 e0             	pushl  -0x20(%ebp)
8010528d:	e8 2e cc ff ff       	call   80101ec0 <namei>
80105292:	83 c4 10             	add    $0x10,%esp
80105295:	85 c0                	test   %eax,%eax
80105297:	89 c6                	mov    %eax,%esi
80105299:	0f 84 8e 00 00 00    	je     8010532d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010529f:	83 ec 0c             	sub    $0xc,%esp
801052a2:	50                   	push   %eax
801052a3:	e8 c8 c3 ff ff       	call   80101670 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052a8:	83 c4 10             	add    $0x10,%esp
801052ab:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052b0:	0f 84 d2 00 00 00    	je     80105388 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052b6:	e8 b5 ba ff ff       	call   80100d70 <filealloc>
801052bb:	85 c0                	test   %eax,%eax
801052bd:	89 c7                	mov    %eax,%edi
801052bf:	74 2b                	je     801052ec <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052c1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801052c3:	e8 d8 e5 ff ff       	call   801038a0 <myproc>
801052c8:	90                   	nop
801052c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801052d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052d4:	85 d2                	test   %edx,%edx
801052d6:	74 68                	je     80105340 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052d8:	83 c3 01             	add    $0x1,%ebx
801052db:	83 fb 10             	cmp    $0x10,%ebx
801052de:	75 f0                	jne    801052d0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	57                   	push   %edi
801052e4:	e8 47 bb ff ff       	call   80100e30 <fileclose>
801052e9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	56                   	push   %esi
801052f0:	e8 0b c6 ff ff       	call   80101900 <iunlockput>
    end_op();
801052f5:	e8 e6 d9 ff ff       	call   80102ce0 <end_op>
    return -1;
801052fa:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801052fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105305:	5b                   	pop    %ebx
80105306:	5e                   	pop    %esi
80105307:	5f                   	pop    %edi
80105308:	5d                   	pop    %ebp
80105309:	c3                   	ret    
8010530a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105310:	83 ec 0c             	sub    $0xc,%esp
80105313:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105316:	31 c9                	xor    %ecx,%ecx
80105318:	6a 00                	push   $0x0
8010531a:	ba 02 00 00 00       	mov    $0x2,%edx
8010531f:	e8 dc f7 ff ff       	call   80104b00 <create>
    if(ip == 0){
80105324:	83 c4 10             	add    $0x10,%esp
80105327:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105329:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010532b:	75 89                	jne    801052b6 <sys_open+0x76>
      end_op();
8010532d:	e8 ae d9 ff ff       	call   80102ce0 <end_op>
      return -1;
80105332:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105337:	eb 43                	jmp    8010537c <sys_open+0x13c>
80105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105340:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105343:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105347:	56                   	push   %esi
80105348:	e8 03 c4 ff ff       	call   80101750 <iunlock>
  end_op();
8010534d:	e8 8e d9 ff ff       	call   80102ce0 <end_op>

  f->type = FD_INODE;
80105352:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105358:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010535b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010535e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105361:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105368:	89 d0                	mov    %edx,%eax
8010536a:	83 e0 01             	and    $0x1,%eax
8010536d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105370:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105373:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105376:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010537a:	89 d8                	mov    %ebx,%eax
}
8010537c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010537f:	5b                   	pop    %ebx
80105380:	5e                   	pop    %esi
80105381:	5f                   	pop    %edi
80105382:	5d                   	pop    %ebp
80105383:	c3                   	ret    
80105384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105388:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010538b:	85 c9                	test   %ecx,%ecx
8010538d:	0f 84 23 ff ff ff    	je     801052b6 <sys_open+0x76>
80105393:	e9 54 ff ff ff       	jmp    801052ec <sys_open+0xac>
80105398:	90                   	nop
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053a0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053a6:	e8 c5 d8 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ae:	83 ec 08             	sub    $0x8,%esp
801053b1:	50                   	push   %eax
801053b2:	6a 00                	push   $0x0
801053b4:	e8 a7 f6 ff ff       	call   80104a60 <argstr>
801053b9:	83 c4 10             	add    $0x10,%esp
801053bc:	85 c0                	test   %eax,%eax
801053be:	78 30                	js     801053f0 <sys_mkdir+0x50>
801053c0:	83 ec 0c             	sub    $0xc,%esp
801053c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053c6:	31 c9                	xor    %ecx,%ecx
801053c8:	6a 00                	push   $0x0
801053ca:	ba 01 00 00 00       	mov    $0x1,%edx
801053cf:	e8 2c f7 ff ff       	call   80104b00 <create>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	74 15                	je     801053f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053db:	83 ec 0c             	sub    $0xc,%esp
801053de:	50                   	push   %eax
801053df:	e8 1c c5 ff ff       	call   80101900 <iunlockput>
  end_op();
801053e4:	e8 f7 d8 ff ff       	call   80102ce0 <end_op>
  return 0;
801053e9:	83 c4 10             	add    $0x10,%esp
801053ec:	31 c0                	xor    %eax,%eax
}
801053ee:	c9                   	leave  
801053ef:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801053f0:	e8 eb d8 ff ff       	call   80102ce0 <end_op>
    return -1;
801053f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053fa:	c9                   	leave  
801053fb:	c3                   	ret    
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105400 <sys_mknod>:

int
sys_mknod(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105406:	e8 65 d8 ff ff       	call   80102c70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010540b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010540e:	83 ec 08             	sub    $0x8,%esp
80105411:	50                   	push   %eax
80105412:	6a 00                	push   $0x0
80105414:	e8 47 f6 ff ff       	call   80104a60 <argstr>
80105419:	83 c4 10             	add    $0x10,%esp
8010541c:	85 c0                	test   %eax,%eax
8010541e:	78 60                	js     80105480 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105420:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105423:	83 ec 08             	sub    $0x8,%esp
80105426:	50                   	push   %eax
80105427:	6a 01                	push   $0x1
80105429:	e8 82 f5 ff ff       	call   801049b0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	85 c0                	test   %eax,%eax
80105433:	78 4b                	js     80105480 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105435:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105438:	83 ec 08             	sub    $0x8,%esp
8010543b:	50                   	push   %eax
8010543c:	6a 02                	push   $0x2
8010543e:	e8 6d f5 ff ff       	call   801049b0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	78 36                	js     80105480 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010544a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010544e:	83 ec 0c             	sub    $0xc,%esp
80105451:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105455:	ba 03 00 00 00       	mov    $0x3,%edx
8010545a:	50                   	push   %eax
8010545b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010545e:	e8 9d f6 ff ff       	call   80104b00 <create>
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	74 16                	je     80105480 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010546a:	83 ec 0c             	sub    $0xc,%esp
8010546d:	50                   	push   %eax
8010546e:	e8 8d c4 ff ff       	call   80101900 <iunlockput>
  end_op();
80105473:	e8 68 d8 ff ff       	call   80102ce0 <end_op>
  return 0;
80105478:	83 c4 10             	add    $0x10,%esp
8010547b:	31 c0                	xor    %eax,%eax
}
8010547d:	c9                   	leave  
8010547e:	c3                   	ret    
8010547f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105480:	e8 5b d8 ff ff       	call   80102ce0 <end_op>
    return -1;
80105485:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010548a:	c9                   	leave  
8010548b:	c3                   	ret    
8010548c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105490 <sys_chdir>:

int
sys_chdir(void)
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	56                   	push   %esi
80105494:	53                   	push   %ebx
80105495:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105498:	e8 03 e4 ff ff       	call   801038a0 <myproc>
8010549d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010549f:	e8 cc d7 ff ff       	call   80102c70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054a7:	83 ec 08             	sub    $0x8,%esp
801054aa:	50                   	push   %eax
801054ab:	6a 00                	push   $0x0
801054ad:	e8 ae f5 ff ff       	call   80104a60 <argstr>
801054b2:	83 c4 10             	add    $0x10,%esp
801054b5:	85 c0                	test   %eax,%eax
801054b7:	78 77                	js     80105530 <sys_chdir+0xa0>
801054b9:	83 ec 0c             	sub    $0xc,%esp
801054bc:	ff 75 f4             	pushl  -0xc(%ebp)
801054bf:	e8 fc c9 ff ff       	call   80101ec0 <namei>
801054c4:	83 c4 10             	add    $0x10,%esp
801054c7:	85 c0                	test   %eax,%eax
801054c9:	89 c3                	mov    %eax,%ebx
801054cb:	74 63                	je     80105530 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054cd:	83 ec 0c             	sub    $0xc,%esp
801054d0:	50                   	push   %eax
801054d1:	e8 9a c1 ff ff       	call   80101670 <ilock>
  if(ip->type != T_DIR){
801054d6:	83 c4 10             	add    $0x10,%esp
801054d9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054de:	75 30                	jne    80105510 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	53                   	push   %ebx
801054e4:	e8 67 c2 ff ff       	call   80101750 <iunlock>
  iput(curproc->cwd);
801054e9:	58                   	pop    %eax
801054ea:	ff 76 68             	pushl  0x68(%esi)
801054ed:	e8 ae c2 ff ff       	call   801017a0 <iput>
  end_op();
801054f2:	e8 e9 d7 ff ff       	call   80102ce0 <end_op>
  curproc->cwd = ip;
801054f7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801054fa:	83 c4 10             	add    $0x10,%esp
801054fd:	31 c0                	xor    %eax,%eax
}
801054ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105502:	5b                   	pop    %ebx
80105503:	5e                   	pop    %esi
80105504:	5d                   	pop    %ebp
80105505:	c3                   	ret    
80105506:	8d 76 00             	lea    0x0(%esi),%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	53                   	push   %ebx
80105514:	e8 e7 c3 ff ff       	call   80101900 <iunlockput>
    end_op();
80105519:	e8 c2 d7 ff ff       	call   80102ce0 <end_op>
    return -1;
8010551e:	83 c4 10             	add    $0x10,%esp
80105521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105526:	eb d7                	jmp    801054ff <sys_chdir+0x6f>
80105528:	90                   	nop
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105530:	e8 ab d7 ff ff       	call   80102ce0 <end_op>
    return -1;
80105535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553a:	eb c3                	jmp    801054ff <sys_chdir+0x6f>
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	57                   	push   %edi
80105544:	56                   	push   %esi
80105545:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105546:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010554c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105552:	50                   	push   %eax
80105553:	6a 00                	push   $0x0
80105555:	e8 06 f5 ff ff       	call   80104a60 <argstr>
8010555a:	83 c4 10             	add    $0x10,%esp
8010555d:	85 c0                	test   %eax,%eax
8010555f:	78 7f                	js     801055e0 <sys_exec+0xa0>
80105561:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105567:	83 ec 08             	sub    $0x8,%esp
8010556a:	50                   	push   %eax
8010556b:	6a 01                	push   $0x1
8010556d:	e8 3e f4 ff ff       	call   801049b0 <argint>
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	85 c0                	test   %eax,%eax
80105577:	78 67                	js     801055e0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105579:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010557f:	83 ec 04             	sub    $0x4,%esp
80105582:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105588:	68 80 00 00 00       	push   $0x80
8010558d:	6a 00                	push   $0x0
8010558f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105595:	50                   	push   %eax
80105596:	31 db                	xor    %ebx,%ebx
80105598:	e8 03 f1 ff ff       	call   801046a0 <memset>
8010559d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055a0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055a6:	83 ec 08             	sub    $0x8,%esp
801055a9:	57                   	push   %edi
801055aa:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055ad:	50                   	push   %eax
801055ae:	e8 5d f3 ff ff       	call   80104910 <fetchint>
801055b3:	83 c4 10             	add    $0x10,%esp
801055b6:	85 c0                	test   %eax,%eax
801055b8:	78 26                	js     801055e0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801055ba:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055c0:	85 c0                	test   %eax,%eax
801055c2:	74 2c                	je     801055f0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055c4:	83 ec 08             	sub    $0x8,%esp
801055c7:	56                   	push   %esi
801055c8:	50                   	push   %eax
801055c9:	e8 82 f3 ff ff       	call   80104950 <fetchstr>
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	85 c0                	test   %eax,%eax
801055d3:	78 0b                	js     801055e0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801055d5:	83 c3 01             	add    $0x1,%ebx
801055d8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801055db:	83 fb 20             	cmp    $0x20,%ebx
801055de:	75 c0                	jne    801055a0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801055e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801055e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801055e8:	5b                   	pop    %ebx
801055e9:	5e                   	pop    %esi
801055ea:	5f                   	pop    %edi
801055eb:	5d                   	pop    %ebp
801055ec:	c3                   	ret    
801055ed:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801055f0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055f6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801055f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105600:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105604:	50                   	push   %eax
80105605:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010560b:	e8 e0 b3 ff ff       	call   801009f0 <exec>
80105610:	83 c4 10             	add    $0x10,%esp
}
80105613:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105616:	5b                   	pop    %ebx
80105617:	5e                   	pop    %esi
80105618:	5f                   	pop    %edi
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	90                   	nop
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105620 <sys_pipe>:

int
sys_pipe(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
80105625:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105626:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105629:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010562c:	6a 08                	push   $0x8
8010562e:	50                   	push   %eax
8010562f:	6a 00                	push   $0x0
80105631:	e8 ca f3 ff ff       	call   80104a00 <argptr>
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	85 c0                	test   %eax,%eax
8010563b:	78 4a                	js     80105687 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010563d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105640:	83 ec 08             	sub    $0x8,%esp
80105643:	50                   	push   %eax
80105644:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105647:	50                   	push   %eax
80105648:	e8 c3 dc ff ff       	call   80103310 <pipealloc>
8010564d:	83 c4 10             	add    $0x10,%esp
80105650:	85 c0                	test   %eax,%eax
80105652:	78 33                	js     80105687 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105654:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105656:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105659:	e8 42 e2 ff ff       	call   801038a0 <myproc>
8010565e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105660:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105664:	85 f6                	test   %esi,%esi
80105666:	74 30                	je     80105698 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105668:	83 c3 01             	add    $0x1,%ebx
8010566b:	83 fb 10             	cmp    $0x10,%ebx
8010566e:	75 f0                	jne    80105660 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	ff 75 e0             	pushl  -0x20(%ebp)
80105676:	e8 b5 b7 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010567b:	58                   	pop    %eax
8010567c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010567f:	e8 ac b7 ff ff       	call   80100e30 <fileclose>
    return -1;
80105684:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105687:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010568a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010568f:	5b                   	pop    %ebx
80105690:	5e                   	pop    %esi
80105691:	5f                   	pop    %edi
80105692:	5d                   	pop    %ebp
80105693:	c3                   	ret    
80105694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105698:	8d 73 08             	lea    0x8(%ebx),%esi
8010569b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010569f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056a2:	e8 f9 e1 ff ff       	call   801038a0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801056a7:	31 d2                	xor    %edx,%edx
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056b0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056b4:	85 c9                	test   %ecx,%ecx
801056b6:	74 18                	je     801056d0 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056b8:	83 c2 01             	add    $0x1,%edx
801056bb:	83 fa 10             	cmp    $0x10,%edx
801056be:	75 f0                	jne    801056b0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056c0:	e8 db e1 ff ff       	call   801038a0 <myproc>
801056c5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056cc:	00 
801056cd:	eb a1                	jmp    80105670 <sys_pipe+0x50>
801056cf:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056d0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801056d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056d7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056dc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
801056df:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
801056e2:	31 c0                	xor    %eax,%eax
}
801056e4:	5b                   	pop    %ebx
801056e5:	5e                   	pop    %esi
801056e6:	5f                   	pop    %edi
801056e7:	5d                   	pop    %ebp
801056e8:	c3                   	ret    
801056e9:	66 90                	xchg   %ax,%ax
801056eb:	66 90                	xchg   %ax,%ax
801056ed:	66 90                	xchg   %ax,%ax
801056ef:	90                   	nop

801056f0 <sys_fork>:
#include "mmu.h"
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801056f3:	5d                   	pop    %ebp
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
  return fork();
801056f4:	e9 47 e3 ff ff       	jmp    80103a40 <fork>
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_exit>:
}


int
sys_exit(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 08             	sub    $0x8,%esp
  exit();
80105706:	e8 35 e7 ff ff       	call   80103e40 <exit>
  return 0;  // not reached
}
8010570b:	31 c0                	xor    %eax,%eax
8010570d:	c9                   	leave  
8010570e:	c3                   	ret    
8010570f:	90                   	nop

80105710 <sys_wait>:

int
sys_wait(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105713:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105714:	e9 67 e9 ff ff       	jmp    80104080 <wait>
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_kill>:
}

int
sys_kill(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105726:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105729:	50                   	push   %eax
8010572a:	6a 00                	push   $0x0
8010572c:	e8 7f f2 ff ff       	call   801049b0 <argint>
80105731:	83 c4 10             	add    $0x10,%esp
80105734:	85 c0                	test   %eax,%eax
80105736:	78 18                	js     80105750 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105738:	83 ec 0c             	sub    $0xc,%esp
8010573b:	ff 75 f4             	pushl  -0xc(%ebp)
8010573e:	e8 8d ea ff ff       	call   801041d0 <kill>
80105743:	83 c4 10             	add    $0x10,%esp
}
80105746:	c9                   	leave  
80105747:	c3                   	ret    
80105748:	90                   	nop
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105755:	c9                   	leave  
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105760 <sys_getpid>:

int
sys_getpid(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105766:	e8 35 e1 ff ff       	call   801038a0 <myproc>
8010576b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010576e:	c9                   	leave  
8010576f:	c3                   	ret    

80105770 <sys_sbrk>:

int
sys_sbrk(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105774:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105777:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010577a:	50                   	push   %eax
8010577b:	6a 00                	push   $0x0
8010577d:	e8 2e f2 ff ff       	call   801049b0 <argint>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	85 c0                	test   %eax,%eax
80105787:	78 27                	js     801057b0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105789:	e8 12 e1 ff ff       	call   801038a0 <myproc>
  if(growproc(n) < 0)
8010578e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105791:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105793:	ff 75 f4             	pushl  -0xc(%ebp)
80105796:	e8 25 e2 ff ff       	call   801039c0 <growproc>
8010579b:	83 c4 10             	add    $0x10,%esp
8010579e:	85 c0                	test   %eax,%eax
801057a0:	78 0e                	js     801057b0 <sys_sbrk+0x40>
    return -1;
  return addr;
801057a2:	89 d8                	mov    %ebx,%eax
}
801057a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057a7:	c9                   	leave  
801057a8:	c3                   	ret    
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801057b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057b5:	eb ed                	jmp    801057a4 <sys_sbrk+0x34>
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801057c7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 de f1 ff ff       	call   801049b0 <argint>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	0f 88 8a 00 00 00    	js     80105867 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057dd:	83 ec 0c             	sub    $0xc,%esp
801057e0:	68 60 dc 14 80       	push   $0x8014dc60
801057e5:	e8 46 ed ff ff       	call   80104530 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057ed:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801057f0:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  while(ticks - ticks0 < n){
801057f6:	85 d2                	test   %edx,%edx
801057f8:	75 27                	jne    80105821 <sys_sleep+0x61>
801057fa:	eb 54                	jmp    80105850 <sys_sleep+0x90>
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105800:	83 ec 08             	sub    $0x8,%esp
80105803:	68 60 dc 14 80       	push   $0x8014dc60
80105808:	68 a0 e4 14 80       	push   $0x8014e4a0
8010580d:	e8 ae e7 ff ff       	call   80103fc0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105812:	a1 a0 e4 14 80       	mov    0x8014e4a0,%eax
80105817:	83 c4 10             	add    $0x10,%esp
8010581a:	29 d8                	sub    %ebx,%eax
8010581c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010581f:	73 2f                	jae    80105850 <sys_sleep+0x90>
    if(myproc()->killed){
80105821:	e8 7a e0 ff ff       	call   801038a0 <myproc>
80105826:	8b 40 24             	mov    0x24(%eax),%eax
80105829:	85 c0                	test   %eax,%eax
8010582b:	74 d3                	je     80105800 <sys_sleep+0x40>
      release(&tickslock);
8010582d:	83 ec 0c             	sub    $0xc,%esp
80105830:	68 60 dc 14 80       	push   $0x8014dc60
80105835:	e8 16 ee ff ff       	call   80104650 <release>
      return -1;
8010583a:	83 c4 10             	add    $0x10,%esp
8010583d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105845:	c9                   	leave  
80105846:	c3                   	ret    
80105847:	89 f6                	mov    %esi,%esi
80105849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105850:	83 ec 0c             	sub    $0xc,%esp
80105853:	68 60 dc 14 80       	push   $0x8014dc60
80105858:	e8 f3 ed ff ff       	call   80104650 <release>
  return 0;
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	31 c0                	xor    %eax,%eax
}
80105862:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105865:	c9                   	leave  
80105866:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105867:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586c:	eb d4                	jmp    80105842 <sys_sleep+0x82>
8010586e:	66 90                	xchg   %ax,%ax

80105870 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	53                   	push   %ebx
80105874:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105877:	68 60 dc 14 80       	push   $0x8014dc60
8010587c:	e8 af ec ff ff       	call   80104530 <acquire>
  xticks = ticks;
80105881:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  release(&tickslock);
80105887:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
8010588e:	e8 bd ed ff ff       	call   80104650 <release>
  return xticks;
}
80105893:	89 d8                	mov    %ebx,%eax
80105895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105898:	c9                   	leave  
80105899:	c3                   	ret    
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058a0 <sys_date>:

int
sys_date(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 1c             	sub    $0x1c,%esp
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	6a 04                	push   $0x4
801058ab:	50                   	push   %eax
801058ac:	6a 00                	push   $0x0
801058ae:	e8 4d f1 ff ff       	call   80104a00 <argptr>
801058b3:	83 c4 10             	add    $0x10,%esp
801058b6:	85 c0                	test   %eax,%eax
801058b8:	78 16                	js     801058d0 <sys_date+0x30>
   {
    return -1;
   }
  cmostime((struct rtcdate *)ptr);
801058ba:	83 ec 0c             	sub    $0xc,%esp
801058bd:	ff 75 f4             	pushl  -0xc(%ebp)
801058c0:	e8 2b d0 ff ff       	call   801028f0 <cmostime>
  return 0;
801058c5:	83 c4 10             	add    $0x10,%esp
801058c8:	31 c0                	xor    %eax,%eax

}
801058ca:	c9                   	leave  
801058cb:	c3                   	ret    
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_date(void)
{
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
   {
    return -1;
801058d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   }
  cmostime((struct rtcdate *)ptr);
  return 0;

}
801058d5:	c9                   	leave  
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <sys_virt2real>:

int
sys_virt2real(char *va)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	53                   	push   %ebx
801058e4:	83 ec 04             	sub    $0x4,%esp
801058e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801058ea:	e8 b1 df ff ff       	call   801038a0 <myproc>
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801058ef:	8b 40 04             	mov    0x4(%eax),%eax
801058f2:	89 da                	mov    %ebx,%edx
  return (int)pgtab[PTX(va)];
801058f4:	c1 eb 0c             	shr    $0xc,%ebx
{
  struct proc *curproc = myproc();
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801058f7:	c1 ea 16             	shr    $0x16,%edx
  return (int)pgtab[PTX(va)];
801058fa:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80105900:	8b 04 90             	mov    (%eax,%edx,4),%eax
80105903:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105908:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax

}
8010590f:	83 c4 04             	add    $0x4,%esp
80105912:	5b                   	pop    %ebx
80105913:	5d                   	pop    %ebp
80105914:	c3                   	ret    
80105915:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_num_pages>:

int
sys_num_pages(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105926:	e8 75 df ff ff       	call   801038a0 <myproc>
  int temp = curproc->sz>>PGSHIFT;
8010592b:	8b 10                	mov    (%eax),%edx
    return temp;
  }
  else{
    return (temp+1);
  }
}
8010592d:	c9                   	leave  

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz>>PGSHIFT;
8010592e:	89 d0                	mov    %edx,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
80105930:	81 e2 ff 0f 00 00    	and    $0xfff,%edx

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz>>PGSHIFT;
80105936:	c1 e8 0c             	shr    $0xc,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
    return temp;
  }
  else{
    return (temp+1);
80105939:	83 fa 01             	cmp    $0x1,%edx
8010593c:	83 d8 ff             	sbb    $0xffffffff,%eax
  }
}
8010593f:	c3                   	ret    

80105940 <sys_forkcow>:

int
sys_forkcow(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
  return forkcow();
80105943:	5d                   	pop    %ebp
}

int
sys_forkcow(void)
{
  return forkcow();
80105944:	e9 17 e2 ff ff       	jmp    80103b60 <forkcow>

80105949 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105949:	1e                   	push   %ds
  pushl %es
8010594a:	06                   	push   %es
  pushl %fs
8010594b:	0f a0                	push   %fs
  pushl %gs
8010594d:	0f a8                	push   %gs
  pushal
8010594f:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105950:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105954:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105956:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105958:	54                   	push   %esp
  call trap
80105959:	e8 e2 00 00 00       	call   80105a40 <trap>
  addl $4, %esp
8010595e:	83 c4 04             	add    $0x4,%esp

80105961 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105961:	61                   	popa   
  popl %gs
80105962:	0f a9                	pop    %gs
  popl %fs
80105964:	0f a1                	pop    %fs
  popl %es
80105966:	07                   	pop    %es
  popl %ds
80105967:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105968:	83 c4 08             	add    $0x8,%esp
  iret
8010596b:	cf                   	iret   
8010596c:	66 90                	xchg   %ax,%ax
8010596e:	66 90                	xchg   %ax,%ax

80105970 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105970:	31 c0                	xor    %eax,%eax
80105972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105978:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
8010597f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105984:	c6 04 c5 a4 dc 14 80 	movb   $0x0,-0x7feb235c(,%eax,8)
8010598b:	00 
8010598c:	66 89 0c c5 a2 dc 14 	mov    %cx,-0x7feb235e(,%eax,8)
80105993:	80 
80105994:	c6 04 c5 a5 dc 14 80 	movb   $0x8e,-0x7feb235b(,%eax,8)
8010599b:	8e 
8010599c:	66 89 14 c5 a0 dc 14 	mov    %dx,-0x7feb2360(,%eax,8)
801059a3:	80 
801059a4:	c1 ea 10             	shr    $0x10,%edx
801059a7:	66 89 14 c5 a6 dc 14 	mov    %dx,-0x7feb235a(,%eax,8)
801059ae:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059af:	83 c0 01             	add    $0x1,%eax
801059b2:	3d 00 01 00 00       	cmp    $0x100,%eax
801059b7:	75 bf                	jne    80105978 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059b9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059ba:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059bf:	89 e5                	mov    %esp,%ebp
801059c1:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059c4:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
801059c9:	68 e9 7c 10 80       	push   $0x80107ce9
801059ce:	68 60 dc 14 80       	push   $0x8014dc60
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059d3:	66 89 15 a2 de 14 80 	mov    %dx,0x8014dea2
801059da:	c6 05 a4 de 14 80 00 	movb   $0x0,0x8014dea4
801059e1:	66 a3 a0 de 14 80    	mov    %ax,0x8014dea0
801059e7:	c1 e8 10             	shr    $0x10,%eax
801059ea:	c6 05 a5 de 14 80 ef 	movb   $0xef,0x8014dea5
801059f1:	66 a3 a6 de 14 80    	mov    %ax,0x8014dea6

  initlock(&tickslock, "time");
801059f7:	e8 34 ea ff ff       	call   80104430 <initlock>
}
801059fc:	83 c4 10             	add    $0x10,%esp
801059ff:	c9                   	leave  
80105a00:	c3                   	ret    
80105a01:	eb 0d                	jmp    80105a10 <idtinit>
80105a03:	90                   	nop
80105a04:	90                   	nop
80105a05:	90                   	nop
80105a06:	90                   	nop
80105a07:	90                   	nop
80105a08:	90                   	nop
80105a09:	90                   	nop
80105a0a:	90                   	nop
80105a0b:	90                   	nop
80105a0c:	90                   	nop
80105a0d:	90                   	nop
80105a0e:	90                   	nop
80105a0f:	90                   	nop

80105a10 <idtinit>:

void
idtinit(void)
{
80105a10:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a16:	89 e5                	mov    %esp,%ebp
80105a18:	83 ec 10             	sub    $0x10,%esp
80105a1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a1f:	b8 a0 dc 14 80       	mov    $0x8014dca0,%eax
80105a24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a28:	c1 e8 10             	shr    $0x10,%eax
80105a2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a35:	c9                   	leave  
80105a36:	c3                   	ret    
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
80105a46:	83 ec 1c             	sub    $0x1c,%esp
80105a49:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a4c:	8b 47 30             	mov    0x30(%edi),%eax
80105a4f:	83 f8 40             	cmp    $0x40,%eax
80105a52:	0f 84 a8 01 00 00    	je     80105c00 <trap+0x1c0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a58:	83 e8 0e             	sub    $0xe,%eax
80105a5b:	83 f8 31             	cmp    $0x31,%eax
80105a5e:	77 10                	ja     80105a70 <trap+0x30>
80105a60:	ff 24 85 90 7d 10 80 	jmp    *-0x7fef8270(,%eax,4)
80105a67:	89 f6                	mov    %esi,%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a70:	e8 2b de ff ff       	call   801038a0 <myproc>
80105a75:	85 c0                	test   %eax,%eax
80105a77:	0f 84 f7 01 00 00    	je     80105c74 <trap+0x234>
80105a7d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105a81:	0f 84 ed 01 00 00    	je     80105c74 <trap+0x234>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a87:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a8a:	8b 57 38             	mov    0x38(%edi),%edx
80105a8d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105a90:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105a93:	e8 e8 dd ff ff       	call   80103880 <cpuid>
80105a98:	8b 77 34             	mov    0x34(%edi),%esi
80105a9b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105a9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105aa1:	e8 fa dd ff ff       	call   801038a0 <myproc>
80105aa6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105aa9:	e8 f2 dd ff ff       	call   801038a0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ab1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ab4:	51                   	push   %ecx
80105ab5:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105ab6:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ab9:	ff 75 e4             	pushl  -0x1c(%ebp)
80105abc:	56                   	push   %esi
80105abd:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105abe:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ac1:	52                   	push   %edx
80105ac2:	ff 70 10             	pushl  0x10(%eax)
80105ac5:	68 4c 7d 10 80       	push   $0x80107d4c
80105aca:	e8 91 ab ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105acf:	83 c4 20             	add    $0x20,%esp
80105ad2:	e8 c9 dd ff ff       	call   801038a0 <myproc>
80105ad7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105ade:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ae0:	e8 bb dd ff ff       	call   801038a0 <myproc>
80105ae5:	85 c0                	test   %eax,%eax
80105ae7:	74 0c                	je     80105af5 <trap+0xb5>
80105ae9:	e8 b2 dd ff ff       	call   801038a0 <myproc>
80105aee:	8b 50 24             	mov    0x24(%eax),%edx
80105af1:	85 d2                	test   %edx,%edx
80105af3:	75 4b                	jne    80105b40 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105af5:	e8 a6 dd ff ff       	call   801038a0 <myproc>
80105afa:	85 c0                	test   %eax,%eax
80105afc:	74 0b                	je     80105b09 <trap+0xc9>
80105afe:	e8 9d dd ff ff       	call   801038a0 <myproc>
80105b03:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b07:	74 4f                	je     80105b58 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b09:	e8 92 dd ff ff       	call   801038a0 <myproc>
80105b0e:	85 c0                	test   %eax,%eax
80105b10:	74 1d                	je     80105b2f <trap+0xef>
80105b12:	e8 89 dd ff ff       	call   801038a0 <myproc>
80105b17:	8b 40 24             	mov    0x24(%eax),%eax
80105b1a:	85 c0                	test   %eax,%eax
80105b1c:	74 11                	je     80105b2f <trap+0xef>
80105b1e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b22:	83 e0 03             	and    $0x3,%eax
80105b25:	66 83 f8 03          	cmp    $0x3,%ax
80105b29:	0f 84 fa 00 00 00    	je     80105c29 <trap+0x1e9>
    exit();
}
80105b2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b32:	5b                   	pop    %ebx
80105b33:	5e                   	pop    %esi
80105b34:	5f                   	pop    %edi
80105b35:	5d                   	pop    %ebp
80105b36:	c3                   	ret    
80105b37:	89 f6                	mov    %esi,%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b40:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b44:	83 e0 03             	and    $0x3,%eax
80105b47:	66 83 f8 03          	cmp    $0x3,%ax
80105b4b:	75 a8                	jne    80105af5 <trap+0xb5>
    exit();
80105b4d:	e8 ee e2 ff ff       	call   80103e40 <exit>
80105b52:	eb a1                	jmp    80105af5 <trap+0xb5>
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b58:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b5c:	75 ab                	jne    80105b09 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105b5e:	e8 0d e4 ff ff       	call   80103f70 <yield>
80105b63:	eb a4                	jmp    80105b09 <trap+0xc9>
80105b65:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_PGFLT:
    pagefault(tf->err);
80105b68:	83 ec 0c             	sub    $0xc,%esp
80105b6b:	ff 77 34             	pushl  0x34(%edi)
80105b6e:	e8 ad 17 00 00       	call   80107320 <pagefault>
    break;
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	e9 65 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105b7b:	90                   	nop
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105b80:	e8 fb dc ff ff       	call   80103880 <cpuid>
80105b85:	85 c0                	test   %eax,%eax
80105b87:	0f 84 b3 00 00 00    	je     80105c40 <trap+0x200>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b8d:	e8 9e cc ff ff       	call   80102830 <lapiceoi>
    break;
80105b92:	e9 49 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105b97:	89 f6                	mov    %esi,%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105ba0:	e8 4b cb ff ff       	call   801026f0 <kbdintr>
    lapiceoi();
80105ba5:	e8 86 cc ff ff       	call   80102830 <lapiceoi>
    break;
80105baa:	e9 31 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105baf:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105bb0:	e8 5b 02 00 00       	call   80105e10 <uartintr>
    lapiceoi();
80105bb5:	e8 76 cc ff ff       	call   80102830 <lapiceoi>
    break;
80105bba:	e9 21 ff ff ff       	jmp    80105ae0 <trap+0xa0>
80105bbf:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105bc0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105bc4:	8b 77 38             	mov    0x38(%edi),%esi
80105bc7:	e8 b4 dc ff ff       	call   80103880 <cpuid>
80105bcc:	56                   	push   %esi
80105bcd:	53                   	push   %ebx
80105bce:	50                   	push   %eax
80105bcf:	68 f4 7c 10 80       	push   $0x80107cf4
80105bd4:	e8 87 aa ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105bd9:	e8 52 cc ff ff       	call   80102830 <lapiceoi>
    break;
80105bde:	83 c4 10             	add    $0x10,%esp
80105be1:	e9 fa fe ff ff       	jmp    80105ae0 <trap+0xa0>
80105be6:	8d 76 00             	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bf0:	e8 5b c4 ff ff       	call   80102050 <ideintr>
80105bf5:	eb 96                	jmp    80105b8d <trap+0x14d>
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105c00:	e8 9b dc ff ff       	call   801038a0 <myproc>
80105c05:	8b 58 24             	mov    0x24(%eax),%ebx
80105c08:	85 db                	test   %ebx,%ebx
80105c0a:	75 2c                	jne    80105c38 <trap+0x1f8>
      exit();
    myproc()->tf = tf;
80105c0c:	e8 8f dc ff ff       	call   801038a0 <myproc>
80105c11:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105c14:	e8 87 ee ff ff       	call   80104aa0 <syscall>
    if(myproc()->killed)
80105c19:	e8 82 dc ff ff       	call   801038a0 <myproc>
80105c1e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c21:	85 c9                	test   %ecx,%ecx
80105c23:	0f 84 06 ff ff ff    	je     80105b2f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c2c:	5b                   	pop    %ebx
80105c2d:	5e                   	pop    %esi
80105c2e:	5f                   	pop    %edi
80105c2f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105c30:	e9 0b e2 ff ff       	jmp    80103e40 <exit>
80105c35:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105c38:	e8 03 e2 ff ff       	call   80103e40 <exit>
80105c3d:	eb cd                	jmp    80105c0c <trap+0x1cc>
80105c3f:	90                   	nop
  case T_PGFLT:
    pagefault(tf->err);
    break;
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	68 60 dc 14 80       	push   $0x8014dc60
80105c48:	e8 e3 e8 ff ff       	call   80104530 <acquire>
      ticks++;
      wakeup(&ticks);
80105c4d:	c7 04 24 a0 e4 14 80 	movl   $0x8014e4a0,(%esp)
    pagefault(tf->err);
    break;
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105c54:	83 05 a0 e4 14 80 01 	addl   $0x1,0x8014e4a0
      wakeup(&ticks);
80105c5b:	e8 10 e5 ff ff       	call   80104170 <wakeup>
      release(&tickslock);
80105c60:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
80105c67:	e8 e4 e9 ff ff       	call   80104650 <release>
80105c6c:	83 c4 10             	add    $0x10,%esp
80105c6f:	e9 19 ff ff ff       	jmp    80105b8d <trap+0x14d>
80105c74:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c77:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c7a:	e8 01 dc ff ff       	call   80103880 <cpuid>
80105c7f:	83 ec 0c             	sub    $0xc,%esp
80105c82:	56                   	push   %esi
80105c83:	53                   	push   %ebx
80105c84:	50                   	push   %eax
80105c85:	ff 77 30             	pushl  0x30(%edi)
80105c88:	68 18 7d 10 80       	push   $0x80107d18
80105c8d:	e8 ce a9 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c92:	83 c4 14             	add    $0x14,%esp
80105c95:	68 ee 7c 10 80       	push   $0x80107cee
80105c9a:	e8 d1 a6 ff ff       	call   80100370 <panic>
80105c9f:	90                   	nop

80105ca0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ca0:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105ca5:	55                   	push   %ebp
80105ca6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ca8:	85 c0                	test   %eax,%eax
80105caa:	74 1c                	je     80105cc8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cac:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cb1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cb2:	a8 01                	test   $0x1,%al
80105cb4:	74 12                	je     80105cc8 <uartgetc+0x28>
80105cb6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cbb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cbc:	0f b6 c0             	movzbl %al,%eax
}
80105cbf:	5d                   	pop    %ebp
80105cc0:	c3                   	ret    
80105cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105cc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105ccd:	5d                   	pop    %ebp
80105cce:	c3                   	ret    
80105ccf:	90                   	nop

80105cd0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	57                   	push   %edi
80105cd4:	56                   	push   %esi
80105cd5:	53                   	push   %ebx
80105cd6:	89 c7                	mov    %eax,%edi
80105cd8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cdd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ce2:	83 ec 0c             	sub    $0xc,%esp
80105ce5:	eb 1b                	jmp    80105d02 <uartputc.part.0+0x32>
80105ce7:	89 f6                	mov    %esi,%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	6a 0a                	push   $0xa
80105cf5:	e8 56 cb ff ff       	call   80102850 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cfa:	83 c4 10             	add    $0x10,%esp
80105cfd:	83 eb 01             	sub    $0x1,%ebx
80105d00:	74 07                	je     80105d09 <uartputc.part.0+0x39>
80105d02:	89 f2                	mov    %esi,%edx
80105d04:	ec                   	in     (%dx),%al
80105d05:	a8 20                	test   $0x20,%al
80105d07:	74 e7                	je     80105cf0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d09:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d0e:	89 f8                	mov    %edi,%eax
80105d10:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d14:	5b                   	pop    %ebx
80105d15:	5e                   	pop    %esi
80105d16:	5f                   	pop    %edi
80105d17:	5d                   	pop    %ebp
80105d18:	c3                   	ret    
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d20 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d20:	55                   	push   %ebp
80105d21:	31 c9                	xor    %ecx,%ecx
80105d23:	89 c8                	mov    %ecx,%eax
80105d25:	89 e5                	mov    %esp,%ebp
80105d27:	57                   	push   %edi
80105d28:	56                   	push   %esi
80105d29:	53                   	push   %ebx
80105d2a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d2f:	89 da                	mov    %ebx,%edx
80105d31:	83 ec 0c             	sub    $0xc,%esp
80105d34:	ee                   	out    %al,(%dx)
80105d35:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d3a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d3f:	89 fa                	mov    %edi,%edx
80105d41:	ee                   	out    %al,(%dx)
80105d42:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d4c:	ee                   	out    %al,(%dx)
80105d4d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d52:	89 c8                	mov    %ecx,%eax
80105d54:	89 f2                	mov    %esi,%edx
80105d56:	ee                   	out    %al,(%dx)
80105d57:	b8 03 00 00 00       	mov    $0x3,%eax
80105d5c:	89 fa                	mov    %edi,%edx
80105d5e:	ee                   	out    %al,(%dx)
80105d5f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d64:	89 c8                	mov    %ecx,%eax
80105d66:	ee                   	out    %al,(%dx)
80105d67:	b8 01 00 00 00       	mov    $0x1,%eax
80105d6c:	89 f2                	mov    %esi,%edx
80105d6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d6f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d74:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d75:	3c ff                	cmp    $0xff,%al
80105d77:	74 5a                	je     80105dd3 <uartinit+0xb3>
    return;
  uart = 1;
80105d79:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80105d80:	00 00 00 
80105d83:	89 da                	mov    %ebx,%edx
80105d85:	ec                   	in     (%dx),%al
80105d86:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d8b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105d8c:	83 ec 08             	sub    $0x8,%esp
80105d8f:	bb 58 7e 10 80       	mov    $0x80107e58,%ebx
80105d94:	6a 00                	push   $0x0
80105d96:	6a 04                	push   $0x4
80105d98:	e8 03 c5 ff ff       	call   801022a0 <ioapicenable>
80105d9d:	83 c4 10             	add    $0x10,%esp
80105da0:	b8 78 00 00 00       	mov    $0x78,%eax
80105da5:	eb 13                	jmp    80105dba <uartinit+0x9a>
80105da7:	89 f6                	mov    %esi,%esi
80105da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105db0:	83 c3 01             	add    $0x1,%ebx
80105db3:	0f be 03             	movsbl (%ebx),%eax
80105db6:	84 c0                	test   %al,%al
80105db8:	74 19                	je     80105dd3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105dba:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80105dc0:	85 d2                	test   %edx,%edx
80105dc2:	74 ec                	je     80105db0 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105dc4:	83 c3 01             	add    $0x1,%ebx
80105dc7:	e8 04 ff ff ff       	call   80105cd0 <uartputc.part.0>
80105dcc:	0f be 03             	movsbl (%ebx),%eax
80105dcf:	84 c0                	test   %al,%al
80105dd1:	75 e7                	jne    80105dba <uartinit+0x9a>
    uartputc(*p);
}
80105dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dd6:	5b                   	pop    %ebx
80105dd7:	5e                   	pop    %esi
80105dd8:	5f                   	pop    %edi
80105dd9:	5d                   	pop    %ebp
80105dda:	c3                   	ret    
80105ddb:	90                   	nop
80105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105de0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105de0:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105de6:	55                   	push   %ebp
80105de7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105de9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105deb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105dee:	74 10                	je     80105e00 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105df0:	5d                   	pop    %ebp
80105df1:	e9 da fe ff ff       	jmp    80105cd0 <uartputc.part.0>
80105df6:	8d 76 00             	lea    0x0(%esi),%esi
80105df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e00:	5d                   	pop    %ebp
80105e01:	c3                   	ret    
80105e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e10 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e16:	68 a0 5c 10 80       	push   $0x80105ca0
80105e1b:	e8 d0 a9 ff ff       	call   801007f0 <consoleintr>
}
80105e20:	83 c4 10             	add    $0x10,%esp
80105e23:	c9                   	leave  
80105e24:	c3                   	ret    

80105e25 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e25:	6a 00                	push   $0x0
  pushl $0
80105e27:	6a 00                	push   $0x0
  jmp alltraps
80105e29:	e9 1b fb ff ff       	jmp    80105949 <alltraps>

80105e2e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e2e:	6a 00                	push   $0x0
  pushl $1
80105e30:	6a 01                	push   $0x1
  jmp alltraps
80105e32:	e9 12 fb ff ff       	jmp    80105949 <alltraps>

80105e37 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e37:	6a 00                	push   $0x0
  pushl $2
80105e39:	6a 02                	push   $0x2
  jmp alltraps
80105e3b:	e9 09 fb ff ff       	jmp    80105949 <alltraps>

80105e40 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e40:	6a 00                	push   $0x0
  pushl $3
80105e42:	6a 03                	push   $0x3
  jmp alltraps
80105e44:	e9 00 fb ff ff       	jmp    80105949 <alltraps>

80105e49 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e49:	6a 00                	push   $0x0
  pushl $4
80105e4b:	6a 04                	push   $0x4
  jmp alltraps
80105e4d:	e9 f7 fa ff ff       	jmp    80105949 <alltraps>

80105e52 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e52:	6a 00                	push   $0x0
  pushl $5
80105e54:	6a 05                	push   $0x5
  jmp alltraps
80105e56:	e9 ee fa ff ff       	jmp    80105949 <alltraps>

80105e5b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e5b:	6a 00                	push   $0x0
  pushl $6
80105e5d:	6a 06                	push   $0x6
  jmp alltraps
80105e5f:	e9 e5 fa ff ff       	jmp    80105949 <alltraps>

80105e64 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e64:	6a 00                	push   $0x0
  pushl $7
80105e66:	6a 07                	push   $0x7
  jmp alltraps
80105e68:	e9 dc fa ff ff       	jmp    80105949 <alltraps>

80105e6d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e6d:	6a 08                	push   $0x8
  jmp alltraps
80105e6f:	e9 d5 fa ff ff       	jmp    80105949 <alltraps>

80105e74 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $9
80105e76:	6a 09                	push   $0x9
  jmp alltraps
80105e78:	e9 cc fa ff ff       	jmp    80105949 <alltraps>

80105e7d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e7d:	6a 0a                	push   $0xa
  jmp alltraps
80105e7f:	e9 c5 fa ff ff       	jmp    80105949 <alltraps>

80105e84 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e84:	6a 0b                	push   $0xb
  jmp alltraps
80105e86:	e9 be fa ff ff       	jmp    80105949 <alltraps>

80105e8b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e8b:	6a 0c                	push   $0xc
  jmp alltraps
80105e8d:	e9 b7 fa ff ff       	jmp    80105949 <alltraps>

80105e92 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e92:	6a 0d                	push   $0xd
  jmp alltraps
80105e94:	e9 b0 fa ff ff       	jmp    80105949 <alltraps>

80105e99 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e99:	6a 0e                	push   $0xe
  jmp alltraps
80105e9b:	e9 a9 fa ff ff       	jmp    80105949 <alltraps>

80105ea0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $15
80105ea2:	6a 0f                	push   $0xf
  jmp alltraps
80105ea4:	e9 a0 fa ff ff       	jmp    80105949 <alltraps>

80105ea9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $16
80105eab:	6a 10                	push   $0x10
  jmp alltraps
80105ead:	e9 97 fa ff ff       	jmp    80105949 <alltraps>

80105eb2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105eb2:	6a 11                	push   $0x11
  jmp alltraps
80105eb4:	e9 90 fa ff ff       	jmp    80105949 <alltraps>

80105eb9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105eb9:	6a 00                	push   $0x0
  pushl $18
80105ebb:	6a 12                	push   $0x12
  jmp alltraps
80105ebd:	e9 87 fa ff ff       	jmp    80105949 <alltraps>

80105ec2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ec2:	6a 00                	push   $0x0
  pushl $19
80105ec4:	6a 13                	push   $0x13
  jmp alltraps
80105ec6:	e9 7e fa ff ff       	jmp    80105949 <alltraps>

80105ecb <vector20>:
.globl vector20
vector20:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $20
80105ecd:	6a 14                	push   $0x14
  jmp alltraps
80105ecf:	e9 75 fa ff ff       	jmp    80105949 <alltraps>

80105ed4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $21
80105ed6:	6a 15                	push   $0x15
  jmp alltraps
80105ed8:	e9 6c fa ff ff       	jmp    80105949 <alltraps>

80105edd <vector22>:
.globl vector22
vector22:
  pushl $0
80105edd:	6a 00                	push   $0x0
  pushl $22
80105edf:	6a 16                	push   $0x16
  jmp alltraps
80105ee1:	e9 63 fa ff ff       	jmp    80105949 <alltraps>

80105ee6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ee6:	6a 00                	push   $0x0
  pushl $23
80105ee8:	6a 17                	push   $0x17
  jmp alltraps
80105eea:	e9 5a fa ff ff       	jmp    80105949 <alltraps>

80105eef <vector24>:
.globl vector24
vector24:
  pushl $0
80105eef:	6a 00                	push   $0x0
  pushl $24
80105ef1:	6a 18                	push   $0x18
  jmp alltraps
80105ef3:	e9 51 fa ff ff       	jmp    80105949 <alltraps>

80105ef8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ef8:	6a 00                	push   $0x0
  pushl $25
80105efa:	6a 19                	push   $0x19
  jmp alltraps
80105efc:	e9 48 fa ff ff       	jmp    80105949 <alltraps>

80105f01 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f01:	6a 00                	push   $0x0
  pushl $26
80105f03:	6a 1a                	push   $0x1a
  jmp alltraps
80105f05:	e9 3f fa ff ff       	jmp    80105949 <alltraps>

80105f0a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f0a:	6a 00                	push   $0x0
  pushl $27
80105f0c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f0e:	e9 36 fa ff ff       	jmp    80105949 <alltraps>

80105f13 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f13:	6a 00                	push   $0x0
  pushl $28
80105f15:	6a 1c                	push   $0x1c
  jmp alltraps
80105f17:	e9 2d fa ff ff       	jmp    80105949 <alltraps>

80105f1c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f1c:	6a 00                	push   $0x0
  pushl $29
80105f1e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f20:	e9 24 fa ff ff       	jmp    80105949 <alltraps>

80105f25 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f25:	6a 00                	push   $0x0
  pushl $30
80105f27:	6a 1e                	push   $0x1e
  jmp alltraps
80105f29:	e9 1b fa ff ff       	jmp    80105949 <alltraps>

80105f2e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f2e:	6a 00                	push   $0x0
  pushl $31
80105f30:	6a 1f                	push   $0x1f
  jmp alltraps
80105f32:	e9 12 fa ff ff       	jmp    80105949 <alltraps>

80105f37 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $32
80105f39:	6a 20                	push   $0x20
  jmp alltraps
80105f3b:	e9 09 fa ff ff       	jmp    80105949 <alltraps>

80105f40 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f40:	6a 00                	push   $0x0
  pushl $33
80105f42:	6a 21                	push   $0x21
  jmp alltraps
80105f44:	e9 00 fa ff ff       	jmp    80105949 <alltraps>

80105f49 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f49:	6a 00                	push   $0x0
  pushl $34
80105f4b:	6a 22                	push   $0x22
  jmp alltraps
80105f4d:	e9 f7 f9 ff ff       	jmp    80105949 <alltraps>

80105f52 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f52:	6a 00                	push   $0x0
  pushl $35
80105f54:	6a 23                	push   $0x23
  jmp alltraps
80105f56:	e9 ee f9 ff ff       	jmp    80105949 <alltraps>

80105f5b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $36
80105f5d:	6a 24                	push   $0x24
  jmp alltraps
80105f5f:	e9 e5 f9 ff ff       	jmp    80105949 <alltraps>

80105f64 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f64:	6a 00                	push   $0x0
  pushl $37
80105f66:	6a 25                	push   $0x25
  jmp alltraps
80105f68:	e9 dc f9 ff ff       	jmp    80105949 <alltraps>

80105f6d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f6d:	6a 00                	push   $0x0
  pushl $38
80105f6f:	6a 26                	push   $0x26
  jmp alltraps
80105f71:	e9 d3 f9 ff ff       	jmp    80105949 <alltraps>

80105f76 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f76:	6a 00                	push   $0x0
  pushl $39
80105f78:	6a 27                	push   $0x27
  jmp alltraps
80105f7a:	e9 ca f9 ff ff       	jmp    80105949 <alltraps>

80105f7f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f7f:	6a 00                	push   $0x0
  pushl $40
80105f81:	6a 28                	push   $0x28
  jmp alltraps
80105f83:	e9 c1 f9 ff ff       	jmp    80105949 <alltraps>

80105f88 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f88:	6a 00                	push   $0x0
  pushl $41
80105f8a:	6a 29                	push   $0x29
  jmp alltraps
80105f8c:	e9 b8 f9 ff ff       	jmp    80105949 <alltraps>

80105f91 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f91:	6a 00                	push   $0x0
  pushl $42
80105f93:	6a 2a                	push   $0x2a
  jmp alltraps
80105f95:	e9 af f9 ff ff       	jmp    80105949 <alltraps>

80105f9a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f9a:	6a 00                	push   $0x0
  pushl $43
80105f9c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f9e:	e9 a6 f9 ff ff       	jmp    80105949 <alltraps>

80105fa3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105fa3:	6a 00                	push   $0x0
  pushl $44
80105fa5:	6a 2c                	push   $0x2c
  jmp alltraps
80105fa7:	e9 9d f9 ff ff       	jmp    80105949 <alltraps>

80105fac <vector45>:
.globl vector45
vector45:
  pushl $0
80105fac:	6a 00                	push   $0x0
  pushl $45
80105fae:	6a 2d                	push   $0x2d
  jmp alltraps
80105fb0:	e9 94 f9 ff ff       	jmp    80105949 <alltraps>

80105fb5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105fb5:	6a 00                	push   $0x0
  pushl $46
80105fb7:	6a 2e                	push   $0x2e
  jmp alltraps
80105fb9:	e9 8b f9 ff ff       	jmp    80105949 <alltraps>

80105fbe <vector47>:
.globl vector47
vector47:
  pushl $0
80105fbe:	6a 00                	push   $0x0
  pushl $47
80105fc0:	6a 2f                	push   $0x2f
  jmp alltraps
80105fc2:	e9 82 f9 ff ff       	jmp    80105949 <alltraps>

80105fc7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fc7:	6a 00                	push   $0x0
  pushl $48
80105fc9:	6a 30                	push   $0x30
  jmp alltraps
80105fcb:	e9 79 f9 ff ff       	jmp    80105949 <alltraps>

80105fd0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fd0:	6a 00                	push   $0x0
  pushl $49
80105fd2:	6a 31                	push   $0x31
  jmp alltraps
80105fd4:	e9 70 f9 ff ff       	jmp    80105949 <alltraps>

80105fd9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fd9:	6a 00                	push   $0x0
  pushl $50
80105fdb:	6a 32                	push   $0x32
  jmp alltraps
80105fdd:	e9 67 f9 ff ff       	jmp    80105949 <alltraps>

80105fe2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fe2:	6a 00                	push   $0x0
  pushl $51
80105fe4:	6a 33                	push   $0x33
  jmp alltraps
80105fe6:	e9 5e f9 ff ff       	jmp    80105949 <alltraps>

80105feb <vector52>:
.globl vector52
vector52:
  pushl $0
80105feb:	6a 00                	push   $0x0
  pushl $52
80105fed:	6a 34                	push   $0x34
  jmp alltraps
80105fef:	e9 55 f9 ff ff       	jmp    80105949 <alltraps>

80105ff4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $53
80105ff6:	6a 35                	push   $0x35
  jmp alltraps
80105ff8:	e9 4c f9 ff ff       	jmp    80105949 <alltraps>

80105ffd <vector54>:
.globl vector54
vector54:
  pushl $0
80105ffd:	6a 00                	push   $0x0
  pushl $54
80105fff:	6a 36                	push   $0x36
  jmp alltraps
80106001:	e9 43 f9 ff ff       	jmp    80105949 <alltraps>

80106006 <vector55>:
.globl vector55
vector55:
  pushl $0
80106006:	6a 00                	push   $0x0
  pushl $55
80106008:	6a 37                	push   $0x37
  jmp alltraps
8010600a:	e9 3a f9 ff ff       	jmp    80105949 <alltraps>

8010600f <vector56>:
.globl vector56
vector56:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $56
80106011:	6a 38                	push   $0x38
  jmp alltraps
80106013:	e9 31 f9 ff ff       	jmp    80105949 <alltraps>

80106018 <vector57>:
.globl vector57
vector57:
  pushl $0
80106018:	6a 00                	push   $0x0
  pushl $57
8010601a:	6a 39                	push   $0x39
  jmp alltraps
8010601c:	e9 28 f9 ff ff       	jmp    80105949 <alltraps>

80106021 <vector58>:
.globl vector58
vector58:
  pushl $0
80106021:	6a 00                	push   $0x0
  pushl $58
80106023:	6a 3a                	push   $0x3a
  jmp alltraps
80106025:	e9 1f f9 ff ff       	jmp    80105949 <alltraps>

8010602a <vector59>:
.globl vector59
vector59:
  pushl $0
8010602a:	6a 00                	push   $0x0
  pushl $59
8010602c:	6a 3b                	push   $0x3b
  jmp alltraps
8010602e:	e9 16 f9 ff ff       	jmp    80105949 <alltraps>

80106033 <vector60>:
.globl vector60
vector60:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $60
80106035:	6a 3c                	push   $0x3c
  jmp alltraps
80106037:	e9 0d f9 ff ff       	jmp    80105949 <alltraps>

8010603c <vector61>:
.globl vector61
vector61:
  pushl $0
8010603c:	6a 00                	push   $0x0
  pushl $61
8010603e:	6a 3d                	push   $0x3d
  jmp alltraps
80106040:	e9 04 f9 ff ff       	jmp    80105949 <alltraps>

80106045 <vector62>:
.globl vector62
vector62:
  pushl $0
80106045:	6a 00                	push   $0x0
  pushl $62
80106047:	6a 3e                	push   $0x3e
  jmp alltraps
80106049:	e9 fb f8 ff ff       	jmp    80105949 <alltraps>

8010604e <vector63>:
.globl vector63
vector63:
  pushl $0
8010604e:	6a 00                	push   $0x0
  pushl $63
80106050:	6a 3f                	push   $0x3f
  jmp alltraps
80106052:	e9 f2 f8 ff ff       	jmp    80105949 <alltraps>

80106057 <vector64>:
.globl vector64
vector64:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $64
80106059:	6a 40                	push   $0x40
  jmp alltraps
8010605b:	e9 e9 f8 ff ff       	jmp    80105949 <alltraps>

80106060 <vector65>:
.globl vector65
vector65:
  pushl $0
80106060:	6a 00                	push   $0x0
  pushl $65
80106062:	6a 41                	push   $0x41
  jmp alltraps
80106064:	e9 e0 f8 ff ff       	jmp    80105949 <alltraps>

80106069 <vector66>:
.globl vector66
vector66:
  pushl $0
80106069:	6a 00                	push   $0x0
  pushl $66
8010606b:	6a 42                	push   $0x42
  jmp alltraps
8010606d:	e9 d7 f8 ff ff       	jmp    80105949 <alltraps>

80106072 <vector67>:
.globl vector67
vector67:
  pushl $0
80106072:	6a 00                	push   $0x0
  pushl $67
80106074:	6a 43                	push   $0x43
  jmp alltraps
80106076:	e9 ce f8 ff ff       	jmp    80105949 <alltraps>

8010607b <vector68>:
.globl vector68
vector68:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $68
8010607d:	6a 44                	push   $0x44
  jmp alltraps
8010607f:	e9 c5 f8 ff ff       	jmp    80105949 <alltraps>

80106084 <vector69>:
.globl vector69
vector69:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $69
80106086:	6a 45                	push   $0x45
  jmp alltraps
80106088:	e9 bc f8 ff ff       	jmp    80105949 <alltraps>

8010608d <vector70>:
.globl vector70
vector70:
  pushl $0
8010608d:	6a 00                	push   $0x0
  pushl $70
8010608f:	6a 46                	push   $0x46
  jmp alltraps
80106091:	e9 b3 f8 ff ff       	jmp    80105949 <alltraps>

80106096 <vector71>:
.globl vector71
vector71:
  pushl $0
80106096:	6a 00                	push   $0x0
  pushl $71
80106098:	6a 47                	push   $0x47
  jmp alltraps
8010609a:	e9 aa f8 ff ff       	jmp    80105949 <alltraps>

8010609f <vector72>:
.globl vector72
vector72:
  pushl $0
8010609f:	6a 00                	push   $0x0
  pushl $72
801060a1:	6a 48                	push   $0x48
  jmp alltraps
801060a3:	e9 a1 f8 ff ff       	jmp    80105949 <alltraps>

801060a8 <vector73>:
.globl vector73
vector73:
  pushl $0
801060a8:	6a 00                	push   $0x0
  pushl $73
801060aa:	6a 49                	push   $0x49
  jmp alltraps
801060ac:	e9 98 f8 ff ff       	jmp    80105949 <alltraps>

801060b1 <vector74>:
.globl vector74
vector74:
  pushl $0
801060b1:	6a 00                	push   $0x0
  pushl $74
801060b3:	6a 4a                	push   $0x4a
  jmp alltraps
801060b5:	e9 8f f8 ff ff       	jmp    80105949 <alltraps>

801060ba <vector75>:
.globl vector75
vector75:
  pushl $0
801060ba:	6a 00                	push   $0x0
  pushl $75
801060bc:	6a 4b                	push   $0x4b
  jmp alltraps
801060be:	e9 86 f8 ff ff       	jmp    80105949 <alltraps>

801060c3 <vector76>:
.globl vector76
vector76:
  pushl $0
801060c3:	6a 00                	push   $0x0
  pushl $76
801060c5:	6a 4c                	push   $0x4c
  jmp alltraps
801060c7:	e9 7d f8 ff ff       	jmp    80105949 <alltraps>

801060cc <vector77>:
.globl vector77
vector77:
  pushl $0
801060cc:	6a 00                	push   $0x0
  pushl $77
801060ce:	6a 4d                	push   $0x4d
  jmp alltraps
801060d0:	e9 74 f8 ff ff       	jmp    80105949 <alltraps>

801060d5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060d5:	6a 00                	push   $0x0
  pushl $78
801060d7:	6a 4e                	push   $0x4e
  jmp alltraps
801060d9:	e9 6b f8 ff ff       	jmp    80105949 <alltraps>

801060de <vector79>:
.globl vector79
vector79:
  pushl $0
801060de:	6a 00                	push   $0x0
  pushl $79
801060e0:	6a 4f                	push   $0x4f
  jmp alltraps
801060e2:	e9 62 f8 ff ff       	jmp    80105949 <alltraps>

801060e7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060e7:	6a 00                	push   $0x0
  pushl $80
801060e9:	6a 50                	push   $0x50
  jmp alltraps
801060eb:	e9 59 f8 ff ff       	jmp    80105949 <alltraps>

801060f0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060f0:	6a 00                	push   $0x0
  pushl $81
801060f2:	6a 51                	push   $0x51
  jmp alltraps
801060f4:	e9 50 f8 ff ff       	jmp    80105949 <alltraps>

801060f9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060f9:	6a 00                	push   $0x0
  pushl $82
801060fb:	6a 52                	push   $0x52
  jmp alltraps
801060fd:	e9 47 f8 ff ff       	jmp    80105949 <alltraps>

80106102 <vector83>:
.globl vector83
vector83:
  pushl $0
80106102:	6a 00                	push   $0x0
  pushl $83
80106104:	6a 53                	push   $0x53
  jmp alltraps
80106106:	e9 3e f8 ff ff       	jmp    80105949 <alltraps>

8010610b <vector84>:
.globl vector84
vector84:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $84
8010610d:	6a 54                	push   $0x54
  jmp alltraps
8010610f:	e9 35 f8 ff ff       	jmp    80105949 <alltraps>

80106114 <vector85>:
.globl vector85
vector85:
  pushl $0
80106114:	6a 00                	push   $0x0
  pushl $85
80106116:	6a 55                	push   $0x55
  jmp alltraps
80106118:	e9 2c f8 ff ff       	jmp    80105949 <alltraps>

8010611d <vector86>:
.globl vector86
vector86:
  pushl $0
8010611d:	6a 00                	push   $0x0
  pushl $86
8010611f:	6a 56                	push   $0x56
  jmp alltraps
80106121:	e9 23 f8 ff ff       	jmp    80105949 <alltraps>

80106126 <vector87>:
.globl vector87
vector87:
  pushl $0
80106126:	6a 00                	push   $0x0
  pushl $87
80106128:	6a 57                	push   $0x57
  jmp alltraps
8010612a:	e9 1a f8 ff ff       	jmp    80105949 <alltraps>

8010612f <vector88>:
.globl vector88
vector88:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $88
80106131:	6a 58                	push   $0x58
  jmp alltraps
80106133:	e9 11 f8 ff ff       	jmp    80105949 <alltraps>

80106138 <vector89>:
.globl vector89
vector89:
  pushl $0
80106138:	6a 00                	push   $0x0
  pushl $89
8010613a:	6a 59                	push   $0x59
  jmp alltraps
8010613c:	e9 08 f8 ff ff       	jmp    80105949 <alltraps>

80106141 <vector90>:
.globl vector90
vector90:
  pushl $0
80106141:	6a 00                	push   $0x0
  pushl $90
80106143:	6a 5a                	push   $0x5a
  jmp alltraps
80106145:	e9 ff f7 ff ff       	jmp    80105949 <alltraps>

8010614a <vector91>:
.globl vector91
vector91:
  pushl $0
8010614a:	6a 00                	push   $0x0
  pushl $91
8010614c:	6a 5b                	push   $0x5b
  jmp alltraps
8010614e:	e9 f6 f7 ff ff       	jmp    80105949 <alltraps>

80106153 <vector92>:
.globl vector92
vector92:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $92
80106155:	6a 5c                	push   $0x5c
  jmp alltraps
80106157:	e9 ed f7 ff ff       	jmp    80105949 <alltraps>

8010615c <vector93>:
.globl vector93
vector93:
  pushl $0
8010615c:	6a 00                	push   $0x0
  pushl $93
8010615e:	6a 5d                	push   $0x5d
  jmp alltraps
80106160:	e9 e4 f7 ff ff       	jmp    80105949 <alltraps>

80106165 <vector94>:
.globl vector94
vector94:
  pushl $0
80106165:	6a 00                	push   $0x0
  pushl $94
80106167:	6a 5e                	push   $0x5e
  jmp alltraps
80106169:	e9 db f7 ff ff       	jmp    80105949 <alltraps>

8010616e <vector95>:
.globl vector95
vector95:
  pushl $0
8010616e:	6a 00                	push   $0x0
  pushl $95
80106170:	6a 5f                	push   $0x5f
  jmp alltraps
80106172:	e9 d2 f7 ff ff       	jmp    80105949 <alltraps>

80106177 <vector96>:
.globl vector96
vector96:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $96
80106179:	6a 60                	push   $0x60
  jmp alltraps
8010617b:	e9 c9 f7 ff ff       	jmp    80105949 <alltraps>

80106180 <vector97>:
.globl vector97
vector97:
  pushl $0
80106180:	6a 00                	push   $0x0
  pushl $97
80106182:	6a 61                	push   $0x61
  jmp alltraps
80106184:	e9 c0 f7 ff ff       	jmp    80105949 <alltraps>

80106189 <vector98>:
.globl vector98
vector98:
  pushl $0
80106189:	6a 00                	push   $0x0
  pushl $98
8010618b:	6a 62                	push   $0x62
  jmp alltraps
8010618d:	e9 b7 f7 ff ff       	jmp    80105949 <alltraps>

80106192 <vector99>:
.globl vector99
vector99:
  pushl $0
80106192:	6a 00                	push   $0x0
  pushl $99
80106194:	6a 63                	push   $0x63
  jmp alltraps
80106196:	e9 ae f7 ff ff       	jmp    80105949 <alltraps>

8010619b <vector100>:
.globl vector100
vector100:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $100
8010619d:	6a 64                	push   $0x64
  jmp alltraps
8010619f:	e9 a5 f7 ff ff       	jmp    80105949 <alltraps>

801061a4 <vector101>:
.globl vector101
vector101:
  pushl $0
801061a4:	6a 00                	push   $0x0
  pushl $101
801061a6:	6a 65                	push   $0x65
  jmp alltraps
801061a8:	e9 9c f7 ff ff       	jmp    80105949 <alltraps>

801061ad <vector102>:
.globl vector102
vector102:
  pushl $0
801061ad:	6a 00                	push   $0x0
  pushl $102
801061af:	6a 66                	push   $0x66
  jmp alltraps
801061b1:	e9 93 f7 ff ff       	jmp    80105949 <alltraps>

801061b6 <vector103>:
.globl vector103
vector103:
  pushl $0
801061b6:	6a 00                	push   $0x0
  pushl $103
801061b8:	6a 67                	push   $0x67
  jmp alltraps
801061ba:	e9 8a f7 ff ff       	jmp    80105949 <alltraps>

801061bf <vector104>:
.globl vector104
vector104:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $104
801061c1:	6a 68                	push   $0x68
  jmp alltraps
801061c3:	e9 81 f7 ff ff       	jmp    80105949 <alltraps>

801061c8 <vector105>:
.globl vector105
vector105:
  pushl $0
801061c8:	6a 00                	push   $0x0
  pushl $105
801061ca:	6a 69                	push   $0x69
  jmp alltraps
801061cc:	e9 78 f7 ff ff       	jmp    80105949 <alltraps>

801061d1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061d1:	6a 00                	push   $0x0
  pushl $106
801061d3:	6a 6a                	push   $0x6a
  jmp alltraps
801061d5:	e9 6f f7 ff ff       	jmp    80105949 <alltraps>

801061da <vector107>:
.globl vector107
vector107:
  pushl $0
801061da:	6a 00                	push   $0x0
  pushl $107
801061dc:	6a 6b                	push   $0x6b
  jmp alltraps
801061de:	e9 66 f7 ff ff       	jmp    80105949 <alltraps>

801061e3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $108
801061e5:	6a 6c                	push   $0x6c
  jmp alltraps
801061e7:	e9 5d f7 ff ff       	jmp    80105949 <alltraps>

801061ec <vector109>:
.globl vector109
vector109:
  pushl $0
801061ec:	6a 00                	push   $0x0
  pushl $109
801061ee:	6a 6d                	push   $0x6d
  jmp alltraps
801061f0:	e9 54 f7 ff ff       	jmp    80105949 <alltraps>

801061f5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061f5:	6a 00                	push   $0x0
  pushl $110
801061f7:	6a 6e                	push   $0x6e
  jmp alltraps
801061f9:	e9 4b f7 ff ff       	jmp    80105949 <alltraps>

801061fe <vector111>:
.globl vector111
vector111:
  pushl $0
801061fe:	6a 00                	push   $0x0
  pushl $111
80106200:	6a 6f                	push   $0x6f
  jmp alltraps
80106202:	e9 42 f7 ff ff       	jmp    80105949 <alltraps>

80106207 <vector112>:
.globl vector112
vector112:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $112
80106209:	6a 70                	push   $0x70
  jmp alltraps
8010620b:	e9 39 f7 ff ff       	jmp    80105949 <alltraps>

80106210 <vector113>:
.globl vector113
vector113:
  pushl $0
80106210:	6a 00                	push   $0x0
  pushl $113
80106212:	6a 71                	push   $0x71
  jmp alltraps
80106214:	e9 30 f7 ff ff       	jmp    80105949 <alltraps>

80106219 <vector114>:
.globl vector114
vector114:
  pushl $0
80106219:	6a 00                	push   $0x0
  pushl $114
8010621b:	6a 72                	push   $0x72
  jmp alltraps
8010621d:	e9 27 f7 ff ff       	jmp    80105949 <alltraps>

80106222 <vector115>:
.globl vector115
vector115:
  pushl $0
80106222:	6a 00                	push   $0x0
  pushl $115
80106224:	6a 73                	push   $0x73
  jmp alltraps
80106226:	e9 1e f7 ff ff       	jmp    80105949 <alltraps>

8010622b <vector116>:
.globl vector116
vector116:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $116
8010622d:	6a 74                	push   $0x74
  jmp alltraps
8010622f:	e9 15 f7 ff ff       	jmp    80105949 <alltraps>

80106234 <vector117>:
.globl vector117
vector117:
  pushl $0
80106234:	6a 00                	push   $0x0
  pushl $117
80106236:	6a 75                	push   $0x75
  jmp alltraps
80106238:	e9 0c f7 ff ff       	jmp    80105949 <alltraps>

8010623d <vector118>:
.globl vector118
vector118:
  pushl $0
8010623d:	6a 00                	push   $0x0
  pushl $118
8010623f:	6a 76                	push   $0x76
  jmp alltraps
80106241:	e9 03 f7 ff ff       	jmp    80105949 <alltraps>

80106246 <vector119>:
.globl vector119
vector119:
  pushl $0
80106246:	6a 00                	push   $0x0
  pushl $119
80106248:	6a 77                	push   $0x77
  jmp alltraps
8010624a:	e9 fa f6 ff ff       	jmp    80105949 <alltraps>

8010624f <vector120>:
.globl vector120
vector120:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $120
80106251:	6a 78                	push   $0x78
  jmp alltraps
80106253:	e9 f1 f6 ff ff       	jmp    80105949 <alltraps>

80106258 <vector121>:
.globl vector121
vector121:
  pushl $0
80106258:	6a 00                	push   $0x0
  pushl $121
8010625a:	6a 79                	push   $0x79
  jmp alltraps
8010625c:	e9 e8 f6 ff ff       	jmp    80105949 <alltraps>

80106261 <vector122>:
.globl vector122
vector122:
  pushl $0
80106261:	6a 00                	push   $0x0
  pushl $122
80106263:	6a 7a                	push   $0x7a
  jmp alltraps
80106265:	e9 df f6 ff ff       	jmp    80105949 <alltraps>

8010626a <vector123>:
.globl vector123
vector123:
  pushl $0
8010626a:	6a 00                	push   $0x0
  pushl $123
8010626c:	6a 7b                	push   $0x7b
  jmp alltraps
8010626e:	e9 d6 f6 ff ff       	jmp    80105949 <alltraps>

80106273 <vector124>:
.globl vector124
vector124:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $124
80106275:	6a 7c                	push   $0x7c
  jmp alltraps
80106277:	e9 cd f6 ff ff       	jmp    80105949 <alltraps>

8010627c <vector125>:
.globl vector125
vector125:
  pushl $0
8010627c:	6a 00                	push   $0x0
  pushl $125
8010627e:	6a 7d                	push   $0x7d
  jmp alltraps
80106280:	e9 c4 f6 ff ff       	jmp    80105949 <alltraps>

80106285 <vector126>:
.globl vector126
vector126:
  pushl $0
80106285:	6a 00                	push   $0x0
  pushl $126
80106287:	6a 7e                	push   $0x7e
  jmp alltraps
80106289:	e9 bb f6 ff ff       	jmp    80105949 <alltraps>

8010628e <vector127>:
.globl vector127
vector127:
  pushl $0
8010628e:	6a 00                	push   $0x0
  pushl $127
80106290:	6a 7f                	push   $0x7f
  jmp alltraps
80106292:	e9 b2 f6 ff ff       	jmp    80105949 <alltraps>

80106297 <vector128>:
.globl vector128
vector128:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $128
80106299:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010629e:	e9 a6 f6 ff ff       	jmp    80105949 <alltraps>

801062a3 <vector129>:
.globl vector129
vector129:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $129
801062a5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801062aa:	e9 9a f6 ff ff       	jmp    80105949 <alltraps>

801062af <vector130>:
.globl vector130
vector130:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $130
801062b1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062b6:	e9 8e f6 ff ff       	jmp    80105949 <alltraps>

801062bb <vector131>:
.globl vector131
vector131:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $131
801062bd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062c2:	e9 82 f6 ff ff       	jmp    80105949 <alltraps>

801062c7 <vector132>:
.globl vector132
vector132:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $132
801062c9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062ce:	e9 76 f6 ff ff       	jmp    80105949 <alltraps>

801062d3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $133
801062d5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062da:	e9 6a f6 ff ff       	jmp    80105949 <alltraps>

801062df <vector134>:
.globl vector134
vector134:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $134
801062e1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062e6:	e9 5e f6 ff ff       	jmp    80105949 <alltraps>

801062eb <vector135>:
.globl vector135
vector135:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $135
801062ed:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062f2:	e9 52 f6 ff ff       	jmp    80105949 <alltraps>

801062f7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $136
801062f9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062fe:	e9 46 f6 ff ff       	jmp    80105949 <alltraps>

80106303 <vector137>:
.globl vector137
vector137:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $137
80106305:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010630a:	e9 3a f6 ff ff       	jmp    80105949 <alltraps>

8010630f <vector138>:
.globl vector138
vector138:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $138
80106311:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106316:	e9 2e f6 ff ff       	jmp    80105949 <alltraps>

8010631b <vector139>:
.globl vector139
vector139:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $139
8010631d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106322:	e9 22 f6 ff ff       	jmp    80105949 <alltraps>

80106327 <vector140>:
.globl vector140
vector140:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $140
80106329:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010632e:	e9 16 f6 ff ff       	jmp    80105949 <alltraps>

80106333 <vector141>:
.globl vector141
vector141:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $141
80106335:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010633a:	e9 0a f6 ff ff       	jmp    80105949 <alltraps>

8010633f <vector142>:
.globl vector142
vector142:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $142
80106341:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106346:	e9 fe f5 ff ff       	jmp    80105949 <alltraps>

8010634b <vector143>:
.globl vector143
vector143:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $143
8010634d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106352:	e9 f2 f5 ff ff       	jmp    80105949 <alltraps>

80106357 <vector144>:
.globl vector144
vector144:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $144
80106359:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010635e:	e9 e6 f5 ff ff       	jmp    80105949 <alltraps>

80106363 <vector145>:
.globl vector145
vector145:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $145
80106365:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010636a:	e9 da f5 ff ff       	jmp    80105949 <alltraps>

8010636f <vector146>:
.globl vector146
vector146:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $146
80106371:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106376:	e9 ce f5 ff ff       	jmp    80105949 <alltraps>

8010637b <vector147>:
.globl vector147
vector147:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $147
8010637d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106382:	e9 c2 f5 ff ff       	jmp    80105949 <alltraps>

80106387 <vector148>:
.globl vector148
vector148:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $148
80106389:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010638e:	e9 b6 f5 ff ff       	jmp    80105949 <alltraps>

80106393 <vector149>:
.globl vector149
vector149:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $149
80106395:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010639a:	e9 aa f5 ff ff       	jmp    80105949 <alltraps>

8010639f <vector150>:
.globl vector150
vector150:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $150
801063a1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801063a6:	e9 9e f5 ff ff       	jmp    80105949 <alltraps>

801063ab <vector151>:
.globl vector151
vector151:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $151
801063ad:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801063b2:	e9 92 f5 ff ff       	jmp    80105949 <alltraps>

801063b7 <vector152>:
.globl vector152
vector152:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $152
801063b9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063be:	e9 86 f5 ff ff       	jmp    80105949 <alltraps>

801063c3 <vector153>:
.globl vector153
vector153:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $153
801063c5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063ca:	e9 7a f5 ff ff       	jmp    80105949 <alltraps>

801063cf <vector154>:
.globl vector154
vector154:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $154
801063d1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063d6:	e9 6e f5 ff ff       	jmp    80105949 <alltraps>

801063db <vector155>:
.globl vector155
vector155:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $155
801063dd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063e2:	e9 62 f5 ff ff       	jmp    80105949 <alltraps>

801063e7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $156
801063e9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063ee:	e9 56 f5 ff ff       	jmp    80105949 <alltraps>

801063f3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $157
801063f5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063fa:	e9 4a f5 ff ff       	jmp    80105949 <alltraps>

801063ff <vector158>:
.globl vector158
vector158:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $158
80106401:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106406:	e9 3e f5 ff ff       	jmp    80105949 <alltraps>

8010640b <vector159>:
.globl vector159
vector159:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $159
8010640d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106412:	e9 32 f5 ff ff       	jmp    80105949 <alltraps>

80106417 <vector160>:
.globl vector160
vector160:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $160
80106419:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010641e:	e9 26 f5 ff ff       	jmp    80105949 <alltraps>

80106423 <vector161>:
.globl vector161
vector161:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $161
80106425:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010642a:	e9 1a f5 ff ff       	jmp    80105949 <alltraps>

8010642f <vector162>:
.globl vector162
vector162:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $162
80106431:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106436:	e9 0e f5 ff ff       	jmp    80105949 <alltraps>

8010643b <vector163>:
.globl vector163
vector163:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $163
8010643d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106442:	e9 02 f5 ff ff       	jmp    80105949 <alltraps>

80106447 <vector164>:
.globl vector164
vector164:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $164
80106449:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010644e:	e9 f6 f4 ff ff       	jmp    80105949 <alltraps>

80106453 <vector165>:
.globl vector165
vector165:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $165
80106455:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010645a:	e9 ea f4 ff ff       	jmp    80105949 <alltraps>

8010645f <vector166>:
.globl vector166
vector166:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $166
80106461:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106466:	e9 de f4 ff ff       	jmp    80105949 <alltraps>

8010646b <vector167>:
.globl vector167
vector167:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $167
8010646d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106472:	e9 d2 f4 ff ff       	jmp    80105949 <alltraps>

80106477 <vector168>:
.globl vector168
vector168:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $168
80106479:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010647e:	e9 c6 f4 ff ff       	jmp    80105949 <alltraps>

80106483 <vector169>:
.globl vector169
vector169:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $169
80106485:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010648a:	e9 ba f4 ff ff       	jmp    80105949 <alltraps>

8010648f <vector170>:
.globl vector170
vector170:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $170
80106491:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106496:	e9 ae f4 ff ff       	jmp    80105949 <alltraps>

8010649b <vector171>:
.globl vector171
vector171:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $171
8010649d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801064a2:	e9 a2 f4 ff ff       	jmp    80105949 <alltraps>

801064a7 <vector172>:
.globl vector172
vector172:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $172
801064a9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801064ae:	e9 96 f4 ff ff       	jmp    80105949 <alltraps>

801064b3 <vector173>:
.globl vector173
vector173:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $173
801064b5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064ba:	e9 8a f4 ff ff       	jmp    80105949 <alltraps>

801064bf <vector174>:
.globl vector174
vector174:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $174
801064c1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064c6:	e9 7e f4 ff ff       	jmp    80105949 <alltraps>

801064cb <vector175>:
.globl vector175
vector175:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $175
801064cd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064d2:	e9 72 f4 ff ff       	jmp    80105949 <alltraps>

801064d7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $176
801064d9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064de:	e9 66 f4 ff ff       	jmp    80105949 <alltraps>

801064e3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $177
801064e5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ea:	e9 5a f4 ff ff       	jmp    80105949 <alltraps>

801064ef <vector178>:
.globl vector178
vector178:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $178
801064f1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064f6:	e9 4e f4 ff ff       	jmp    80105949 <alltraps>

801064fb <vector179>:
.globl vector179
vector179:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $179
801064fd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106502:	e9 42 f4 ff ff       	jmp    80105949 <alltraps>

80106507 <vector180>:
.globl vector180
vector180:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $180
80106509:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010650e:	e9 36 f4 ff ff       	jmp    80105949 <alltraps>

80106513 <vector181>:
.globl vector181
vector181:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $181
80106515:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010651a:	e9 2a f4 ff ff       	jmp    80105949 <alltraps>

8010651f <vector182>:
.globl vector182
vector182:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $182
80106521:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106526:	e9 1e f4 ff ff       	jmp    80105949 <alltraps>

8010652b <vector183>:
.globl vector183
vector183:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $183
8010652d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106532:	e9 12 f4 ff ff       	jmp    80105949 <alltraps>

80106537 <vector184>:
.globl vector184
vector184:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $184
80106539:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010653e:	e9 06 f4 ff ff       	jmp    80105949 <alltraps>

80106543 <vector185>:
.globl vector185
vector185:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $185
80106545:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010654a:	e9 fa f3 ff ff       	jmp    80105949 <alltraps>

8010654f <vector186>:
.globl vector186
vector186:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $186
80106551:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106556:	e9 ee f3 ff ff       	jmp    80105949 <alltraps>

8010655b <vector187>:
.globl vector187
vector187:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $187
8010655d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106562:	e9 e2 f3 ff ff       	jmp    80105949 <alltraps>

80106567 <vector188>:
.globl vector188
vector188:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $188
80106569:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010656e:	e9 d6 f3 ff ff       	jmp    80105949 <alltraps>

80106573 <vector189>:
.globl vector189
vector189:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $189
80106575:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010657a:	e9 ca f3 ff ff       	jmp    80105949 <alltraps>

8010657f <vector190>:
.globl vector190
vector190:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $190
80106581:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106586:	e9 be f3 ff ff       	jmp    80105949 <alltraps>

8010658b <vector191>:
.globl vector191
vector191:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $191
8010658d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106592:	e9 b2 f3 ff ff       	jmp    80105949 <alltraps>

80106597 <vector192>:
.globl vector192
vector192:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $192
80106599:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010659e:	e9 a6 f3 ff ff       	jmp    80105949 <alltraps>

801065a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $193
801065a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801065aa:	e9 9a f3 ff ff       	jmp    80105949 <alltraps>

801065af <vector194>:
.globl vector194
vector194:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $194
801065b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065b6:	e9 8e f3 ff ff       	jmp    80105949 <alltraps>

801065bb <vector195>:
.globl vector195
vector195:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $195
801065bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065c2:	e9 82 f3 ff ff       	jmp    80105949 <alltraps>

801065c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $196
801065c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065ce:	e9 76 f3 ff ff       	jmp    80105949 <alltraps>

801065d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $197
801065d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065da:	e9 6a f3 ff ff       	jmp    80105949 <alltraps>

801065df <vector198>:
.globl vector198
vector198:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $198
801065e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065e6:	e9 5e f3 ff ff       	jmp    80105949 <alltraps>

801065eb <vector199>:
.globl vector199
vector199:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $199
801065ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065f2:	e9 52 f3 ff ff       	jmp    80105949 <alltraps>

801065f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $200
801065f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065fe:	e9 46 f3 ff ff       	jmp    80105949 <alltraps>

80106603 <vector201>:
.globl vector201
vector201:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $201
80106605:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010660a:	e9 3a f3 ff ff       	jmp    80105949 <alltraps>

8010660f <vector202>:
.globl vector202
vector202:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $202
80106611:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106616:	e9 2e f3 ff ff       	jmp    80105949 <alltraps>

8010661b <vector203>:
.globl vector203
vector203:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $203
8010661d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106622:	e9 22 f3 ff ff       	jmp    80105949 <alltraps>

80106627 <vector204>:
.globl vector204
vector204:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $204
80106629:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010662e:	e9 16 f3 ff ff       	jmp    80105949 <alltraps>

80106633 <vector205>:
.globl vector205
vector205:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $205
80106635:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010663a:	e9 0a f3 ff ff       	jmp    80105949 <alltraps>

8010663f <vector206>:
.globl vector206
vector206:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $206
80106641:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106646:	e9 fe f2 ff ff       	jmp    80105949 <alltraps>

8010664b <vector207>:
.globl vector207
vector207:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $207
8010664d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106652:	e9 f2 f2 ff ff       	jmp    80105949 <alltraps>

80106657 <vector208>:
.globl vector208
vector208:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $208
80106659:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010665e:	e9 e6 f2 ff ff       	jmp    80105949 <alltraps>

80106663 <vector209>:
.globl vector209
vector209:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $209
80106665:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010666a:	e9 da f2 ff ff       	jmp    80105949 <alltraps>

8010666f <vector210>:
.globl vector210
vector210:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $210
80106671:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106676:	e9 ce f2 ff ff       	jmp    80105949 <alltraps>

8010667b <vector211>:
.globl vector211
vector211:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $211
8010667d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106682:	e9 c2 f2 ff ff       	jmp    80105949 <alltraps>

80106687 <vector212>:
.globl vector212
vector212:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $212
80106689:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010668e:	e9 b6 f2 ff ff       	jmp    80105949 <alltraps>

80106693 <vector213>:
.globl vector213
vector213:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $213
80106695:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010669a:	e9 aa f2 ff ff       	jmp    80105949 <alltraps>

8010669f <vector214>:
.globl vector214
vector214:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $214
801066a1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801066a6:	e9 9e f2 ff ff       	jmp    80105949 <alltraps>

801066ab <vector215>:
.globl vector215
vector215:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $215
801066ad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801066b2:	e9 92 f2 ff ff       	jmp    80105949 <alltraps>

801066b7 <vector216>:
.globl vector216
vector216:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $216
801066b9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066be:	e9 86 f2 ff ff       	jmp    80105949 <alltraps>

801066c3 <vector217>:
.globl vector217
vector217:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $217
801066c5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066ca:	e9 7a f2 ff ff       	jmp    80105949 <alltraps>

801066cf <vector218>:
.globl vector218
vector218:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $218
801066d1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066d6:	e9 6e f2 ff ff       	jmp    80105949 <alltraps>

801066db <vector219>:
.globl vector219
vector219:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $219
801066dd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066e2:	e9 62 f2 ff ff       	jmp    80105949 <alltraps>

801066e7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $220
801066e9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066ee:	e9 56 f2 ff ff       	jmp    80105949 <alltraps>

801066f3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $221
801066f5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066fa:	e9 4a f2 ff ff       	jmp    80105949 <alltraps>

801066ff <vector222>:
.globl vector222
vector222:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $222
80106701:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106706:	e9 3e f2 ff ff       	jmp    80105949 <alltraps>

8010670b <vector223>:
.globl vector223
vector223:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $223
8010670d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106712:	e9 32 f2 ff ff       	jmp    80105949 <alltraps>

80106717 <vector224>:
.globl vector224
vector224:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $224
80106719:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010671e:	e9 26 f2 ff ff       	jmp    80105949 <alltraps>

80106723 <vector225>:
.globl vector225
vector225:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $225
80106725:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010672a:	e9 1a f2 ff ff       	jmp    80105949 <alltraps>

8010672f <vector226>:
.globl vector226
vector226:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $226
80106731:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106736:	e9 0e f2 ff ff       	jmp    80105949 <alltraps>

8010673b <vector227>:
.globl vector227
vector227:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $227
8010673d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106742:	e9 02 f2 ff ff       	jmp    80105949 <alltraps>

80106747 <vector228>:
.globl vector228
vector228:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $228
80106749:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010674e:	e9 f6 f1 ff ff       	jmp    80105949 <alltraps>

80106753 <vector229>:
.globl vector229
vector229:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $229
80106755:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010675a:	e9 ea f1 ff ff       	jmp    80105949 <alltraps>

8010675f <vector230>:
.globl vector230
vector230:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $230
80106761:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106766:	e9 de f1 ff ff       	jmp    80105949 <alltraps>

8010676b <vector231>:
.globl vector231
vector231:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $231
8010676d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106772:	e9 d2 f1 ff ff       	jmp    80105949 <alltraps>

80106777 <vector232>:
.globl vector232
vector232:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $232
80106779:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010677e:	e9 c6 f1 ff ff       	jmp    80105949 <alltraps>

80106783 <vector233>:
.globl vector233
vector233:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $233
80106785:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010678a:	e9 ba f1 ff ff       	jmp    80105949 <alltraps>

8010678f <vector234>:
.globl vector234
vector234:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $234
80106791:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106796:	e9 ae f1 ff ff       	jmp    80105949 <alltraps>

8010679b <vector235>:
.globl vector235
vector235:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $235
8010679d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801067a2:	e9 a2 f1 ff ff       	jmp    80105949 <alltraps>

801067a7 <vector236>:
.globl vector236
vector236:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $236
801067a9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801067ae:	e9 96 f1 ff ff       	jmp    80105949 <alltraps>

801067b3 <vector237>:
.globl vector237
vector237:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $237
801067b5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067ba:	e9 8a f1 ff ff       	jmp    80105949 <alltraps>

801067bf <vector238>:
.globl vector238
vector238:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $238
801067c1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067c6:	e9 7e f1 ff ff       	jmp    80105949 <alltraps>

801067cb <vector239>:
.globl vector239
vector239:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $239
801067cd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067d2:	e9 72 f1 ff ff       	jmp    80105949 <alltraps>

801067d7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $240
801067d9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067de:	e9 66 f1 ff ff       	jmp    80105949 <alltraps>

801067e3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $241
801067e5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ea:	e9 5a f1 ff ff       	jmp    80105949 <alltraps>

801067ef <vector242>:
.globl vector242
vector242:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $242
801067f1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067f6:	e9 4e f1 ff ff       	jmp    80105949 <alltraps>

801067fb <vector243>:
.globl vector243
vector243:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $243
801067fd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106802:	e9 42 f1 ff ff       	jmp    80105949 <alltraps>

80106807 <vector244>:
.globl vector244
vector244:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $244
80106809:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010680e:	e9 36 f1 ff ff       	jmp    80105949 <alltraps>

80106813 <vector245>:
.globl vector245
vector245:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $245
80106815:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010681a:	e9 2a f1 ff ff       	jmp    80105949 <alltraps>

8010681f <vector246>:
.globl vector246
vector246:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $246
80106821:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106826:	e9 1e f1 ff ff       	jmp    80105949 <alltraps>

8010682b <vector247>:
.globl vector247
vector247:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $247
8010682d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106832:	e9 12 f1 ff ff       	jmp    80105949 <alltraps>

80106837 <vector248>:
.globl vector248
vector248:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $248
80106839:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010683e:	e9 06 f1 ff ff       	jmp    80105949 <alltraps>

80106843 <vector249>:
.globl vector249
vector249:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $249
80106845:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010684a:	e9 fa f0 ff ff       	jmp    80105949 <alltraps>

8010684f <vector250>:
.globl vector250
vector250:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $250
80106851:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106856:	e9 ee f0 ff ff       	jmp    80105949 <alltraps>

8010685b <vector251>:
.globl vector251
vector251:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $251
8010685d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106862:	e9 e2 f0 ff ff       	jmp    80105949 <alltraps>

80106867 <vector252>:
.globl vector252
vector252:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $252
80106869:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010686e:	e9 d6 f0 ff ff       	jmp    80105949 <alltraps>

80106873 <vector253>:
.globl vector253
vector253:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $253
80106875:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010687a:	e9 ca f0 ff ff       	jmp    80105949 <alltraps>

8010687f <vector254>:
.globl vector254
vector254:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $254
80106881:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106886:	e9 be f0 ff ff       	jmp    80105949 <alltraps>

8010688b <vector255>:
.globl vector255
vector255:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $255
8010688d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106892:	e9 b2 f0 ff ff       	jmp    80105949 <alltraps>
80106897:	66 90                	xchg   %ax,%ax
80106899:	66 90                	xchg   %ax,%ax
8010689b:	66 90                	xchg   %ax,%ax
8010689d:	66 90                	xchg   %ax,%ax
8010689f:	90                   	nop

801068a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
801068a6:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068a8:	c1 ea 16             	shr    $0x16,%edx
801068ab:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068ae:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801068b1:	8b 07                	mov    (%edi),%eax
801068b3:	a8 01                	test   $0x1,%al
801068b5:	74 29                	je     801068e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068b7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068bc:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801068c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068c5:	c1 eb 0a             	shr    $0xa,%ebx
801068c8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801068ce:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801068d1:	5b                   	pop    %ebx
801068d2:	5e                   	pop    %esi
801068d3:	5f                   	pop    %edi
801068d4:	5d                   	pop    %ebp
801068d5:	c3                   	ret    
801068d6:	8d 76 00             	lea    0x0(%esi),%esi
801068d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068e0:	85 c9                	test   %ecx,%ecx
801068e2:	74 2c                	je     80106910 <walkpgdir+0x70>
801068e4:	e8 a7 bb ff ff       	call   80102490 <kalloc>
801068e9:	85 c0                	test   %eax,%eax
801068eb:	89 c6                	mov    %eax,%esi
801068ed:	74 21                	je     80106910 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801068ef:	83 ec 04             	sub    $0x4,%esp
801068f2:	68 00 10 00 00       	push   $0x1000
801068f7:	6a 00                	push   $0x0
801068f9:	50                   	push   %eax
801068fa:	e8 a1 dd ff ff       	call   801046a0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068ff:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106905:	83 c4 10             	add    $0x10,%esp
80106908:	83 c8 07             	or     $0x7,%eax
8010690b:	89 07                	mov    %eax,(%edi)
8010690d:	eb b3                	jmp    801068c2 <walkpgdir+0x22>
8010690f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106910:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106913:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106915:	5b                   	pop    %ebx
80106916:	5e                   	pop    %esi
80106917:	5f                   	pop    %edi
80106918:	5d                   	pop    %ebp
80106919:	c3                   	ret    
8010691a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106920 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	57                   	push   %edi
80106924:	56                   	push   %esi
80106925:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106926:	89 d3                	mov    %edx,%ebx
80106928:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010692e:	83 ec 1c             	sub    $0x1c,%esp
80106931:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106934:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106938:	8b 7d 08             	mov    0x8(%ebp),%edi
8010693b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106940:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106943:	8b 45 0c             	mov    0xc(%ebp),%eax
80106946:	29 df                	sub    %ebx,%edi
80106948:	83 c8 01             	or     $0x1,%eax
8010694b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010694e:	eb 15                	jmp    80106965 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106950:	f6 00 01             	testb  $0x1,(%eax)
80106953:	75 45                	jne    8010699a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106955:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106958:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010695b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010695d:	74 31                	je     80106990 <mappages+0x70>
      break;
    a += PGSIZE;
8010695f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106965:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106968:	b9 01 00 00 00       	mov    $0x1,%ecx
8010696d:	89 da                	mov    %ebx,%edx
8010696f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106972:	e8 29 ff ff ff       	call   801068a0 <walkpgdir>
80106977:	85 c0                	test   %eax,%eax
80106979:	75 d5                	jne    80106950 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010697b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010697e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106983:	5b                   	pop    %ebx
80106984:	5e                   	pop    %esi
80106985:	5f                   	pop    %edi
80106986:	5d                   	pop    %ebp
80106987:	c3                   	ret    
80106988:	90                   	nop
80106989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106990:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106993:	31 c0                	xor    %eax,%eax
}
80106995:	5b                   	pop    %ebx
80106996:	5e                   	pop    %esi
80106997:	5f                   	pop    %edi
80106998:	5d                   	pop    %ebp
80106999:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010699a:	83 ec 0c             	sub    $0xc,%esp
8010699d:	68 60 7e 10 80       	push   $0x80107e60
801069a2:	e8 c9 99 ff ff       	call   80100370 <panic>
801069a7:	89 f6                	mov    %esi,%esi
801069a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
801069b4:	56                   	push   %esi
801069b5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069b6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069bc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069be:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069c4:	83 ec 1c             	sub    $0x1c,%esp
801069c7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069ca:	39 d3                	cmp    %edx,%ebx
801069cc:	73 66                	jae    80106a34 <deallocuvm.part.0+0x84>
801069ce:	89 d6                	mov    %edx,%esi
801069d0:	eb 3d                	jmp    80106a0f <deallocuvm.part.0+0x5f>
801069d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801069d8:	8b 10                	mov    (%eax),%edx
801069da:	f6 c2 01             	test   $0x1,%dl
801069dd:	74 26                	je     80106a05 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069e5:	74 58                	je     80106a3f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069e7:	83 ec 0c             	sub    $0xc,%esp
801069ea:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069f3:	52                   	push   %edx
801069f4:	e8 e7 b8 ff ff       	call   801022e0 <kfree>
      *pte = 0;
801069f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069fc:	83 c4 10             	add    $0x10,%esp
801069ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a05:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a0b:	39 f3                	cmp    %esi,%ebx
80106a0d:	73 25                	jae    80106a34 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a0f:	31 c9                	xor    %ecx,%ecx
80106a11:	89 da                	mov    %ebx,%edx
80106a13:	89 f8                	mov    %edi,%eax
80106a15:	e8 86 fe ff ff       	call   801068a0 <walkpgdir>
    if(!pte)
80106a1a:	85 c0                	test   %eax,%eax
80106a1c:	75 ba                	jne    801069d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a1e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a24:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a2a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a30:	39 f3                	cmp    %esi,%ebx
80106a32:	72 db                	jb     80106a0f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a34:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a3a:	5b                   	pop    %ebx
80106a3b:	5e                   	pop    %esi
80106a3c:	5f                   	pop    %edi
80106a3d:	5d                   	pop    %ebp
80106a3e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a3f:	83 ec 0c             	sub    $0xc,%esp
80106a42:	68 06 77 10 80       	push   $0x80107706
80106a47:	e8 24 99 ff ff       	call   80100370 <panic>
80106a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a50 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106a56:	e8 25 ce ff ff       	call   80103880 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a5b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a61:	31 c9                	xor    %ecx,%ecx
80106a63:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a68:	66 89 90 f8 b7 14 80 	mov    %dx,-0x7feb4808(%eax)
80106a6f:	66 89 88 fa b7 14 80 	mov    %cx,-0x7feb4806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a76:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a7b:	31 c9                	xor    %ecx,%ecx
80106a7d:	66 89 90 00 b8 14 80 	mov    %dx,-0x7feb4800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a84:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a89:	66 89 88 02 b8 14 80 	mov    %cx,-0x7feb47fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a90:	31 c9                	xor    %ecx,%ecx
80106a92:	66 89 90 08 b8 14 80 	mov    %dx,-0x7feb47f8(%eax)
80106a99:	66 89 88 0a b8 14 80 	mov    %cx,-0x7feb47f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106aa0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106aa5:	31 c9                	xor    %ecx,%ecx
80106aa7:	66 89 90 10 b8 14 80 	mov    %dx,-0x7feb47f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106aae:	c6 80 fc b7 14 80 00 	movb   $0x0,-0x7feb4804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106ab5:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106aba:	c6 80 fd b7 14 80 9a 	movb   $0x9a,-0x7feb4803(%eax)
80106ac1:	c6 80 fe b7 14 80 cf 	movb   $0xcf,-0x7feb4802(%eax)
80106ac8:	c6 80 ff b7 14 80 00 	movb   $0x0,-0x7feb4801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106acf:	c6 80 04 b8 14 80 00 	movb   $0x0,-0x7feb47fc(%eax)
80106ad6:	c6 80 05 b8 14 80 92 	movb   $0x92,-0x7feb47fb(%eax)
80106add:	c6 80 06 b8 14 80 cf 	movb   $0xcf,-0x7feb47fa(%eax)
80106ae4:	c6 80 07 b8 14 80 00 	movb   $0x0,-0x7feb47f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106aeb:	c6 80 0c b8 14 80 00 	movb   $0x0,-0x7feb47f4(%eax)
80106af2:	c6 80 0d b8 14 80 fa 	movb   $0xfa,-0x7feb47f3(%eax)
80106af9:	c6 80 0e b8 14 80 cf 	movb   $0xcf,-0x7feb47f2(%eax)
80106b00:	c6 80 0f b8 14 80 00 	movb   $0x0,-0x7feb47f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b07:	66 89 88 12 b8 14 80 	mov    %cx,-0x7feb47ee(%eax)
80106b0e:	c6 80 14 b8 14 80 00 	movb   $0x0,-0x7feb47ec(%eax)
80106b15:	c6 80 15 b8 14 80 f2 	movb   $0xf2,-0x7feb47eb(%eax)
80106b1c:	c6 80 16 b8 14 80 cf 	movb   $0xcf,-0x7feb47ea(%eax)
80106b23:	c6 80 17 b8 14 80 00 	movb   $0x0,-0x7feb47e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b2a:	05 f0 b7 14 80       	add    $0x8014b7f0,%eax
80106b2f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b33:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b37:	c1 e8 10             	shr    $0x10,%eax
80106b3a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b3e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b41:	0f 01 10             	lgdtl  (%eax)
}
80106b44:	c9                   	leave  
80106b45:	c3                   	ret    
80106b46:	8d 76 00             	lea    0x0(%esi),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b50:	a1 a4 e4 14 80       	mov    0x8014e4a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b55:	55                   	push   %ebp
80106b56:	89 e5                	mov    %esp,%ebp
80106b58:	05 00 00 00 80       	add    $0x80000000,%eax
80106b5d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106b60:	5d                   	pop    %ebp
80106b61:	c3                   	ret    
80106b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b70 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 1c             	sub    $0x1c,%esp
80106b79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b7c:	85 f6                	test   %esi,%esi
80106b7e:	0f 84 cd 00 00 00    	je     80106c51 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106b84:	8b 46 08             	mov    0x8(%esi),%eax
80106b87:	85 c0                	test   %eax,%eax
80106b89:	0f 84 dc 00 00 00    	je     80106c6b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106b8f:	8b 7e 04             	mov    0x4(%esi),%edi
80106b92:	85 ff                	test   %edi,%edi
80106b94:	0f 84 c4 00 00 00    	je     80106c5e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b9a:	e8 51 d9 ff ff       	call   801044f0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b9f:	e8 5c cc ff ff       	call   80103800 <mycpu>
80106ba4:	89 c3                	mov    %eax,%ebx
80106ba6:	e8 55 cc ff ff       	call   80103800 <mycpu>
80106bab:	89 c7                	mov    %eax,%edi
80106bad:	e8 4e cc ff ff       	call   80103800 <mycpu>
80106bb2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bb5:	83 c7 08             	add    $0x8,%edi
80106bb8:	e8 43 cc ff ff       	call   80103800 <mycpu>
80106bbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106bc0:	83 c0 08             	add    $0x8,%eax
80106bc3:	ba 67 00 00 00       	mov    $0x67,%edx
80106bc8:	c1 e8 18             	shr    $0x18,%eax
80106bcb:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106bd2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106bd9:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106be0:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106be7:	83 c1 08             	add    $0x8,%ecx
80106bea:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106bf0:	c1 e9 10             	shr    $0x10,%ecx
80106bf3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bf9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106bfe:	e8 fd cb ff ff       	call   80103800 <mycpu>
80106c03:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c0a:	e8 f1 cb ff ff       	call   80103800 <mycpu>
80106c0f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c14:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c18:	e8 e3 cb ff ff       	call   80103800 <mycpu>
80106c1d:	8b 56 08             	mov    0x8(%esi),%edx
80106c20:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c26:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c29:	e8 d2 cb ff ff       	call   80103800 <mycpu>
80106c2e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c32:	b8 28 00 00 00       	mov    $0x28,%eax
80106c37:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c3a:	8b 46 04             	mov    0x4(%esi),%eax
80106c3d:	05 00 00 00 80       	add    $0x80000000,%eax
80106c42:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106c45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c48:	5b                   	pop    %ebx
80106c49:	5e                   	pop    %esi
80106c4a:	5f                   	pop    %edi
80106c4b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c4c:	e9 8f d9 ff ff       	jmp    801045e0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c51:	83 ec 0c             	sub    $0xc,%esp
80106c54:	68 66 7e 10 80       	push   $0x80107e66
80106c59:	e8 12 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c5e:	83 ec 0c             	sub    $0xc,%esp
80106c61:	68 91 7e 10 80       	push   $0x80107e91
80106c66:	e8 05 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c6b:	83 ec 0c             	sub    $0xc,%esp
80106c6e:	68 7c 7e 10 80       	push   $0x80107e7c
80106c73:	e8 f8 96 ff ff       	call   80100370 <panic>
80106c78:	90                   	nop
80106c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c80 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 1c             	sub    $0x1c,%esp
80106c89:	8b 75 10             	mov    0x10(%ebp),%esi
80106c8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c8f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c92:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c98:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c9b:	77 49                	ja     80106ce6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c9d:	e8 ee b7 ff ff       	call   80102490 <kalloc>
  memset(mem, 0, PGSIZE);
80106ca2:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106ca5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ca7:	68 00 10 00 00       	push   $0x1000
80106cac:	6a 00                	push   $0x0
80106cae:	50                   	push   %eax
80106caf:	e8 ec d9 ff ff       	call   801046a0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106cb4:	58                   	pop    %eax
80106cb5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106cbb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cc0:	5a                   	pop    %edx
80106cc1:	6a 06                	push   $0x6
80106cc3:	50                   	push   %eax
80106cc4:	31 d2                	xor    %edx,%edx
80106cc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106cc9:	e8 52 fc ff ff       	call   80106920 <mappages>
  memmove(mem, init, sz);
80106cce:	89 75 10             	mov    %esi,0x10(%ebp)
80106cd1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106cd4:	83 c4 10             	add    $0x10,%esp
80106cd7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cdd:	5b                   	pop    %ebx
80106cde:	5e                   	pop    %esi
80106cdf:	5f                   	pop    %edi
80106ce0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106ce1:	e9 6a da ff ff       	jmp    80104750 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106ce6:	83 ec 0c             	sub    $0xc,%esp
80106ce9:	68 a5 7e 10 80       	push   $0x80107ea5
80106cee:	e8 7d 96 ff ff       	call   80100370 <panic>
80106cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d09:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d10:	0f 85 91 00 00 00    	jne    80106da7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d16:	8b 75 18             	mov    0x18(%ebp),%esi
80106d19:	31 db                	xor    %ebx,%ebx
80106d1b:	85 f6                	test   %esi,%esi
80106d1d:	75 1a                	jne    80106d39 <loaduvm+0x39>
80106d1f:	eb 6f                	jmp    80106d90 <loaduvm+0x90>
80106d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d28:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d2e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d34:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d37:	76 57                	jbe    80106d90 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d39:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d3c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d3f:	31 c9                	xor    %ecx,%ecx
80106d41:	01 da                	add    %ebx,%edx
80106d43:	e8 58 fb ff ff       	call   801068a0 <walkpgdir>
80106d48:	85 c0                	test   %eax,%eax
80106d4a:	74 4e                	je     80106d9a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d4c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d4e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d51:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d56:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d5b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d61:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d64:	01 d9                	add    %ebx,%ecx
80106d66:	05 00 00 00 80       	add    $0x80000000,%eax
80106d6b:	57                   	push   %edi
80106d6c:	51                   	push   %ecx
80106d6d:	50                   	push   %eax
80106d6e:	ff 75 10             	pushl  0x10(%ebp)
80106d71:	e8 da ab ff ff       	call   80101950 <readi>
80106d76:	83 c4 10             	add    $0x10,%esp
80106d79:	39 c7                	cmp    %eax,%edi
80106d7b:	74 ab                	je     80106d28 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d85:	5b                   	pop    %ebx
80106d86:	5e                   	pop    %esi
80106d87:	5f                   	pop    %edi
80106d88:	5d                   	pop    %ebp
80106d89:	c3                   	ret    
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d93:	31 c0                	xor    %eax,%eax
}
80106d95:	5b                   	pop    %ebx
80106d96:	5e                   	pop    %esi
80106d97:	5f                   	pop    %edi
80106d98:	5d                   	pop    %ebp
80106d99:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d9a:	83 ec 0c             	sub    $0xc,%esp
80106d9d:	68 bf 7e 10 80       	push   $0x80107ebf
80106da2:	e8 c9 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106da7:	83 ec 0c             	sub    $0xc,%esp
80106daa:	68 cc 7f 10 80       	push   $0x80107fcc
80106daf:	e8 bc 95 ff ff       	call   80100370 <panic>
80106db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106dc0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	57                   	push   %edi
80106dc4:	56                   	push   %esi
80106dc5:	53                   	push   %ebx
80106dc6:	83 ec 0c             	sub    $0xc,%esp
80106dc9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106dcc:	85 ff                	test   %edi,%edi
80106dce:	0f 88 ca 00 00 00    	js     80106e9e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106dd4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106dda:	0f 82 82 00 00 00    	jb     80106e62 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106de0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106de6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dec:	39 df                	cmp    %ebx,%edi
80106dee:	77 43                	ja     80106e33 <allocuvm+0x73>
80106df0:	e9 bb 00 00 00       	jmp    80106eb0 <allocuvm+0xf0>
80106df5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106df8:	83 ec 04             	sub    $0x4,%esp
80106dfb:	68 00 10 00 00       	push   $0x1000
80106e00:	6a 00                	push   $0x0
80106e02:	50                   	push   %eax
80106e03:	e8 98 d8 ff ff       	call   801046a0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e08:	58                   	pop    %eax
80106e09:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e0f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e14:	5a                   	pop    %edx
80106e15:	6a 06                	push   $0x6
80106e17:	50                   	push   %eax
80106e18:	89 da                	mov    %ebx,%edx
80106e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e1d:	e8 fe fa ff ff       	call   80106920 <mappages>
80106e22:	83 c4 10             	add    $0x10,%esp
80106e25:	85 c0                	test   %eax,%eax
80106e27:	78 47                	js     80106e70 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e2f:	39 df                	cmp    %ebx,%edi
80106e31:	76 7d                	jbe    80106eb0 <allocuvm+0xf0>
    mem = kalloc();
80106e33:	e8 58 b6 ff ff       	call   80102490 <kalloc>
    if(mem == 0){
80106e38:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e3a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e3c:	75 ba                	jne    80106df8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e3e:	83 ec 0c             	sub    $0xc,%esp
80106e41:	68 dd 7e 10 80       	push   $0x80107edd
80106e46:	e8 15 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e4b:	83 c4 10             	add    $0x10,%esp
80106e4e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e51:	76 4b                	jbe    80106e9e <allocuvm+0xde>
80106e53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e56:	8b 45 08             	mov    0x8(%ebp),%eax
80106e59:	89 fa                	mov    %edi,%edx
80106e5b:	e8 50 fb ff ff       	call   801069b0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106e60:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e65:	5b                   	pop    %ebx
80106e66:	5e                   	pop    %esi
80106e67:	5f                   	pop    %edi
80106e68:	5d                   	pop    %ebp
80106e69:	c3                   	ret    
80106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e70:	83 ec 0c             	sub    $0xc,%esp
80106e73:	68 f5 7e 10 80       	push   $0x80107ef5
80106e78:	e8 e3 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e7d:	83 c4 10             	add    $0x10,%esp
80106e80:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e83:	76 0d                	jbe    80106e92 <allocuvm+0xd2>
80106e85:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e88:	8b 45 08             	mov    0x8(%ebp),%eax
80106e8b:	89 fa                	mov    %edi,%edx
80106e8d:	e8 1e fb ff ff       	call   801069b0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e92:	83 ec 0c             	sub    $0xc,%esp
80106e95:	56                   	push   %esi
80106e96:	e8 45 b4 ff ff       	call   801022e0 <kfree>
      return 0;
80106e9b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106ea1:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106ea3:	5b                   	pop    %ebx
80106ea4:	5e                   	pop    %esi
80106ea5:	5f                   	pop    %edi
80106ea6:	5d                   	pop    %ebp
80106ea7:	c3                   	ret    
80106ea8:	90                   	nop
80106ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106eb3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106eb5:	5b                   	pop    %ebx
80106eb6:	5e                   	pop    %esi
80106eb7:	5f                   	pop    %edi
80106eb8:	5d                   	pop    %ebp
80106eb9:	c3                   	ret    
80106eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ec0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ec6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ecc:	39 d1                	cmp    %edx,%ecx
80106ece:	73 10                	jae    80106ee0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ed0:	5d                   	pop    %ebp
80106ed1:	e9 da fa ff ff       	jmp    801069b0 <deallocuvm.part.0>
80106ed6:	8d 76 00             	lea    0x0(%esi),%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ee0:	89 d0                	mov    %edx,%eax
80106ee2:	5d                   	pop    %ebp
80106ee3:	c3                   	ret    
80106ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ef0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
80106ef6:	83 ec 0c             	sub    $0xc,%esp
80106ef9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106efc:	85 f6                	test   %esi,%esi
80106efe:	74 59                	je     80106f59 <freevm+0x69>
80106f00:	31 c9                	xor    %ecx,%ecx
80106f02:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f07:	89 f0                	mov    %esi,%eax
80106f09:	e8 a2 fa ff ff       	call   801069b0 <deallocuvm.part.0>
80106f0e:	89 f3                	mov    %esi,%ebx
80106f10:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f16:	eb 0f                	jmp    80106f27 <freevm+0x37>
80106f18:	90                   	nop
80106f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f20:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f23:	39 fb                	cmp    %edi,%ebx
80106f25:	74 23                	je     80106f4a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f27:	8b 03                	mov    (%ebx),%eax
80106f29:	a8 01                	test   $0x1,%al
80106f2b:	74 f3                	je     80106f20 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f32:	83 ec 0c             	sub    $0xc,%esp
80106f35:	83 c3 04             	add    $0x4,%ebx
80106f38:	05 00 00 00 80       	add    $0x80000000,%eax
80106f3d:	50                   	push   %eax
80106f3e:	e8 9d b3 ff ff       	call   801022e0 <kfree>
80106f43:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f46:	39 fb                	cmp    %edi,%ebx
80106f48:	75 dd                	jne    80106f27 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f4a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f50:	5b                   	pop    %ebx
80106f51:	5e                   	pop    %esi
80106f52:	5f                   	pop    %edi
80106f53:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f54:	e9 87 b3 ff ff       	jmp    801022e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f59:	83 ec 0c             	sub    $0xc,%esp
80106f5c:	68 11 7f 10 80       	push   $0x80107f11
80106f61:	e8 0a 94 ff ff       	call   80100370 <panic>
80106f66:	8d 76 00             	lea    0x0(%esi),%esi
80106f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f70 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	56                   	push   %esi
80106f74:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106f75:	e8 16 b5 ff ff       	call   80102490 <kalloc>
80106f7a:	85 c0                	test   %eax,%eax
80106f7c:	74 6a                	je     80106fe8 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f7e:	83 ec 04             	sub    $0x4,%esp
80106f81:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f83:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f88:	68 00 10 00 00       	push   $0x1000
80106f8d:	6a 00                	push   $0x0
80106f8f:	50                   	push   %eax
80106f90:	e8 0b d7 ff ff       	call   801046a0 <memset>
80106f95:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f98:	8b 43 04             	mov    0x4(%ebx),%eax
80106f9b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f9e:	83 ec 08             	sub    $0x8,%esp
80106fa1:	8b 13                	mov    (%ebx),%edx
80106fa3:	ff 73 0c             	pushl  0xc(%ebx)
80106fa6:	50                   	push   %eax
80106fa7:	29 c1                	sub    %eax,%ecx
80106fa9:	89 f0                	mov    %esi,%eax
80106fab:	e8 70 f9 ff ff       	call   80106920 <mappages>
80106fb0:	83 c4 10             	add    $0x10,%esp
80106fb3:	85 c0                	test   %eax,%eax
80106fb5:	78 19                	js     80106fd0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fb7:	83 c3 10             	add    $0x10,%ebx
80106fba:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80106fc0:	75 d6                	jne    80106f98 <setupkvm+0x28>
80106fc2:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106fc4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fc7:	5b                   	pop    %ebx
80106fc8:	5e                   	pop    %esi
80106fc9:	5d                   	pop    %ebp
80106fca:	c3                   	ret    
80106fcb:	90                   	nop
80106fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106fd0:	83 ec 0c             	sub    $0xc,%esp
80106fd3:	56                   	push   %esi
80106fd4:	e8 17 ff ff ff       	call   80106ef0 <freevm>
      return 0;
80106fd9:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106fdc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80106fdf:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80106fe1:	5b                   	pop    %ebx
80106fe2:	5e                   	pop    %esi
80106fe3:	5d                   	pop    %ebp
80106fe4:	c3                   	ret    
80106fe5:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106fe8:	31 c0                	xor    %eax,%eax
80106fea:	eb d8                	jmp    80106fc4 <setupkvm+0x54>
80106fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ff0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106ff6:	e8 75 ff ff ff       	call   80106f70 <setupkvm>
80106ffb:	a3 a4 e4 14 80       	mov    %eax,0x8014e4a4
80107000:	05 00 00 00 80       	add    $0x80000000,%eax
80107005:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107008:	c9                   	leave  
80107009:	c3                   	ret    
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107010 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107010:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107011:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107013:	89 e5                	mov    %esp,%ebp
80107015:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107018:	8b 55 0c             	mov    0xc(%ebp),%edx
8010701b:	8b 45 08             	mov    0x8(%ebp),%eax
8010701e:	e8 7d f8 ff ff       	call   801068a0 <walkpgdir>
  if(pte == 0)
80107023:	85 c0                	test   %eax,%eax
80107025:	74 05                	je     8010702c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107027:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010702a:	c9                   	leave  
8010702b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010702c:	83 ec 0c             	sub    $0xc,%esp
8010702f:	68 22 7f 10 80       	push   $0x80107f22
80107034:	e8 37 93 ff ff       	call   80100370 <panic>
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107040 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	56                   	push   %esi
80107045:	53                   	push   %ebx
80107046:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107049:	e8 22 ff ff ff       	call   80106f70 <setupkvm>
8010704e:	85 c0                	test   %eax,%eax
80107050:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107053:	0f 84 b2 00 00 00    	je     8010710b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107059:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010705c:	85 c9                	test   %ecx,%ecx
8010705e:	0f 84 9c 00 00 00    	je     80107100 <copyuvm+0xc0>
80107064:	31 f6                	xor    %esi,%esi
80107066:	eb 4a                	jmp    801070b2 <copyuvm+0x72>
80107068:	90                   	nop
80107069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107070:	83 ec 04             	sub    $0x4,%esp
80107073:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107079:	68 00 10 00 00       	push   $0x1000
8010707e:	57                   	push   %edi
8010707f:	50                   	push   %eax
80107080:	e8 cb d6 ff ff       	call   80104750 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107085:	58                   	pop    %eax
80107086:	5a                   	pop    %edx
80107087:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010708d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107090:	ff 75 e4             	pushl  -0x1c(%ebp)
80107093:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107098:	52                   	push   %edx
80107099:	89 f2                	mov    %esi,%edx
8010709b:	e8 80 f8 ff ff       	call   80106920 <mappages>
801070a0:	83 c4 10             	add    $0x10,%esp
801070a3:	85 c0                	test   %eax,%eax
801070a5:	78 3e                	js     801070e5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070ad:	39 75 0c             	cmp    %esi,0xc(%ebp)
801070b0:	76 4e                	jbe    80107100 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070b2:	8b 45 08             	mov    0x8(%ebp),%eax
801070b5:	31 c9                	xor    %ecx,%ecx
801070b7:	89 f2                	mov    %esi,%edx
801070b9:	e8 e2 f7 ff ff       	call   801068a0 <walkpgdir>
801070be:	85 c0                	test   %eax,%eax
801070c0:	74 5a                	je     8010711c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801070c2:	8b 18                	mov    (%eax),%ebx
801070c4:	f6 c3 01             	test   $0x1,%bl
801070c7:	74 46                	je     8010710f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070c9:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801070cb:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801070d1:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070d4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801070da:	e8 b1 b3 ff ff       	call   80102490 <kalloc>
801070df:	85 c0                	test   %eax,%eax
801070e1:	89 c3                	mov    %eax,%ebx
801070e3:	75 8b                	jne    80107070 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801070e5:	83 ec 0c             	sub    $0xc,%esp
801070e8:	ff 75 e0             	pushl  -0x20(%ebp)
801070eb:	e8 00 fe ff ff       	call   80106ef0 <freevm>
  return 0;
801070f0:	83 c4 10             	add    $0x10,%esp
801070f3:	31 c0                	xor    %eax,%eax
}
801070f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070f8:	5b                   	pop    %ebx
801070f9:	5e                   	pop    %esi
801070fa:	5f                   	pop    %edi
801070fb:	5d                   	pop    %ebp
801070fc:	c3                   	ret    
801070fd:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107100:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107103:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107106:	5b                   	pop    %ebx
80107107:	5e                   	pop    %esi
80107108:	5f                   	pop    %edi
80107109:	5d                   	pop    %ebp
8010710a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010710b:	31 c0                	xor    %eax,%eax
8010710d:	eb e6                	jmp    801070f5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010710f:	83 ec 0c             	sub    $0xc,%esp
80107112:	68 46 7f 10 80       	push   $0x80107f46
80107117:	e8 54 92 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010711c:	83 ec 0c             	sub    $0xc,%esp
8010711f:	68 2c 7f 10 80       	push   $0x80107f2c
80107124:	e8 47 92 ff ff       	call   80100370 <panic>
80107129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107130 <copyuvmcow>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvmcow(pde_t *pgdir, uint sz)
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	57                   	push   %edi
80107134:	56                   	push   %esi
80107135:	53                   	push   %ebx
80107136:	83 ec 18             	sub    $0x18,%esp
  cprintf("entrou no copyuvmcow\n");
80107139:	68 60 7f 10 80       	push   $0x80107f60
8010713e:	e8 1d 95 ff ff       	call   80100660 <cprintf>
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
80107143:	e8 28 fe ff ff       	call   80106f70 <setupkvm>
80107148:	83 c4 10             	add    $0x10,%esp
8010714b:	85 c0                	test   %eax,%eax
8010714d:	0f 84 c2 00 00 00    	je     80107215 <copyuvmcow+0xe5>
80107153:	89 c7                	mov    %eax,%edi
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107155:	8b 45 0c             	mov    0xc(%ebp),%eax
80107158:	31 db                	xor    %ebx,%ebx
8010715a:	85 c0                	test   %eax,%eax
8010715c:	75 25                	jne    80107183 <copyuvmcow+0x53>
8010715e:	e9 9d 00 00 00       	jmp    80107200 <copyuvmcow+0xd0>
80107163:	90                   	nop
80107164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *pte &= ~PTE_W;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    addRefCount(pa);
80107168:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010716b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    *pte &= ~PTE_W;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    addRefCount(pa);
80107171:	56                   	push   %esi
80107172:	e8 89 b3 ff ff       	call   80102500 <addRefCount>
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107177:	83 c4 10             	add    $0x10,%esp
8010717a:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010717d:	0f 86 7d 00 00 00    	jbe    80107200 <copyuvmcow+0xd0>
    cprintf("for \n");
80107183:	83 ec 0c             	sub    $0xc,%esp
80107186:	68 76 7f 10 80       	push   $0x80107f76
8010718b:	e8 d0 94 ff ff       	call   80100660 <cprintf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107190:	8b 45 08             	mov    0x8(%ebp),%eax
80107193:	31 c9                	xor    %ecx,%ecx
80107195:	89 da                	mov    %ebx,%edx
80107197:	e8 04 f7 ff ff       	call   801068a0 <walkpgdir>
8010719c:	83 c4 10             	add    $0x10,%esp
8010719f:	85 c0                	test   %eax,%eax
801071a1:	0f 84 7f 00 00 00    	je     80107226 <copyuvmcow+0xf6>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801071a7:	8b 10                	mov    (%eax),%edx
801071a9:	f6 c2 01             	test   $0x1,%dl
801071ac:	74 6b                	je     80107219 <copyuvmcow+0xe9>
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
801071ae:	89 d1                	mov    %edx,%ecx
    pa = PTE_ADDR(*pte);
801071b0:	89 d6                	mov    %edx,%esi
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
801071b2:	83 ec 08             	sub    $0x8,%esp
    cprintf("for \n");
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
801071b5:	83 e1 fd             	and    $0xfffffffd,%ecx
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
801071b8:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    pa = PTE_ADDR(*pte);
801071be:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    cprintf("for \n");
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
801071c4:	89 08                	mov    %ecx,(%eax)
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
801071c6:	52                   	push   %edx
801071c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071cc:	56                   	push   %esi
801071cd:	89 da                	mov    %ebx,%edx
801071cf:	89 f8                	mov    %edi,%eax
801071d1:	e8 4a f7 ff ff       	call   80106920 <mappages>
801071d6:	83 c4 10             	add    $0x10,%esp
801071d9:	85 c0                	test   %eax,%eax
801071db:	79 8b                	jns    80107168 <copyuvmcow+0x38>
  lcr3(V2P(pgdir));
  return d;

bad:
  //cprintf("deu ruim\n");
  freevm(d);
801071dd:	83 ec 0c             	sub    $0xc,%esp
801071e0:	57                   	push   %edi
801071e1:	e8 0a fd ff ff       	call   80106ef0 <freevm>
801071e6:	8b 45 08             	mov    0x8(%ebp),%eax
801071e9:	05 00 00 00 80       	add    $0x80000000,%eax
801071ee:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(pgdir));
  return 0;
801071f1:	31 c0                	xor    %eax,%eax
801071f3:	83 c4 10             	add    $0x10,%esp
}
801071f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071f9:	5b                   	pop    %ebx
801071fa:	5e                   	pop    %esi
801071fb:	5f                   	pop    %edi
801071fc:	5d                   	pop    %ebp
801071fd:	c3                   	ret    
801071fe:	66 90                	xchg   %ax,%ax
80107200:	8b 45 08             	mov    0x8(%ebp),%eax
80107203:	05 00 00 00 80       	add    $0x80000000,%eax
80107208:	0f 22 d8             	mov    %eax,%cr3
8010720b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      goto bad;
    addRefCount(pa);
  }
  //cprintf("chamou flush da TLB\n");
  lcr3(V2P(pgdir));
  return d;
8010720e:	89 f8                	mov    %edi,%eax
bad:
  //cprintf("deu ruim\n");
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107210:	5b                   	pop    %ebx
80107211:	5e                   	pop    %esi
80107212:	5f                   	pop    %edi
80107213:	5d                   	pop    %ebp
80107214:	c3                   	ret    
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 

  if((d = setupkvm()) == 0)
    return 0;
80107215:	31 c0                	xor    %eax,%eax
80107217:	eb dd                	jmp    801071f6 <copyuvmcow+0xc6>
  for(i = 0; i < sz; i += PGSIZE){
    cprintf("for \n");
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107219:	83 ec 0c             	sub    $0xc,%esp
8010721c:	68 46 7f 10 80       	push   $0x80107f46
80107221:	e8 4a 91 ff ff       	call   80100370 <panic>
  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    cprintf("for \n");
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107226:	83 ec 0c             	sub    $0xc,%esp
80107229:	68 2c 7f 10 80       	push   $0x80107f2c
8010722e:	e8 3d 91 ff ff       	call   80100370 <panic>
80107233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107240 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107240:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107241:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107243:	89 e5                	mov    %esp,%ebp
80107245:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107248:	8b 55 0c             	mov    0xc(%ebp),%edx
8010724b:	8b 45 08             	mov    0x8(%ebp),%eax
8010724e:	e8 4d f6 ff ff       	call   801068a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107253:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107255:	89 c2                	mov    %eax,%edx
80107257:	83 e2 05             	and    $0x5,%edx
8010725a:	83 fa 05             	cmp    $0x5,%edx
8010725d:	75 11                	jne    80107270 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010725f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107264:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107265:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010726a:	c3                   	ret    
8010726b:	90                   	nop
8010726c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107270:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107272:	c9                   	leave  
80107273:	c3                   	ret    
80107274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010727a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107280 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	56                   	push   %esi
80107285:	53                   	push   %ebx
80107286:	83 ec 1c             	sub    $0x1c,%esp
80107289:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010728c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010728f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107292:	85 db                	test   %ebx,%ebx
80107294:	75 40                	jne    801072d6 <copyout+0x56>
80107296:	eb 70                	jmp    80107308 <copyout+0x88>
80107298:	90                   	nop
80107299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072a3:	89 f1                	mov    %esi,%ecx
801072a5:	29 d1                	sub    %edx,%ecx
801072a7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801072ad:	39 d9                	cmp    %ebx,%ecx
801072af:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072b2:	29 f2                	sub    %esi,%edx
801072b4:	83 ec 04             	sub    $0x4,%esp
801072b7:	01 d0                	add    %edx,%eax
801072b9:	51                   	push   %ecx
801072ba:	57                   	push   %edi
801072bb:	50                   	push   %eax
801072bc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801072bf:	e8 8c d4 ff ff       	call   80104750 <memmove>
    len -= n;
    buf += n;
801072c4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072c7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801072ca:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801072d0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072d2:	29 cb                	sub    %ecx,%ebx
801072d4:	74 32                	je     80107308 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801072d6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072d8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801072db:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801072de:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072e4:	56                   	push   %esi
801072e5:	ff 75 08             	pushl  0x8(%ebp)
801072e8:	e8 53 ff ff ff       	call   80107240 <uva2ka>
    if(pa0 == 0)
801072ed:	83 c4 10             	add    $0x10,%esp
801072f0:	85 c0                	test   %eax,%eax
801072f2:	75 ac                	jne    801072a0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801072f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072fc:	5b                   	pop    %ebx
801072fd:	5e                   	pop    %esi
801072fe:	5f                   	pop    %edi
801072ff:	5d                   	pop    %ebp
80107300:	c3                   	ret    
80107301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107308:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010730b:	31 c0                	xor    %eax,%eax
}
8010730d:	5b                   	pop    %ebx
8010730e:	5e                   	pop    %esi
8010730f:	5f                   	pop    %edi
80107310:	5d                   	pop    %ebp
80107311:	c3                   	ret    
80107312:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107320 <pagefault>:
//PAGEBREAK!
// Blank page.

void 
pagefault(uint error)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	57                   	push   %edi
80107324:	56                   	push   %esi
80107325:	53                   	push   %ebx
80107326:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *cur = myproc();
80107329:	e8 72 c5 ff ff       	call   801038a0 <myproc>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010732e:	0f 20 d6             	mov    %cr2,%esi
  uint va = rcr2();
  pte_t *pte;

  if(cur ==0)
80107331:	85 c0                	test   %eax,%eax
80107333:	0f 84 23 01 00 00    	je     8010745c <pagefault+0x13c>
  {
    cprintf( "Page fault occured but it was not the user process\n");
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)va, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U) )
80107339:	85 f6                	test   %esi,%esi
8010733b:	89 c3                	mov    %eax,%ebx
8010733d:	78 1e                	js     8010735d <pagefault+0x3d>
8010733f:	8b 40 04             	mov    0x4(%eax),%eax
80107342:	31 c9                	xor    %ecx,%ecx
80107344:	89 f2                	mov    %esi,%edx
80107346:	e8 55 f5 ff ff       	call   801068a0 <walkpgdir>
8010734b:	85 c0                	test   %eax,%eax
8010734d:	89 c7                	mov    %eax,%edi
8010734f:	74 0c                	je     8010735d <pagefault+0x3d>
80107351:	8b 00                	mov    (%eax),%eax
80107353:	89 c2                	mov    %eax,%edx
80107355:	83 e2 05             	and    $0x5,%edx
80107358:	83 fa 05             	cmp    $0x5,%edx
8010735b:	74 2b                	je     80107388 <pagefault+0x68>
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
     va, cur->name, cur->pid);
8010735d:	8d 43 6c             	lea    0x6c(%ebx),%eax
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)va, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U) )
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
80107360:	ff 73 10             	pushl  0x10(%ebx)
80107363:	50                   	push   %eax
80107364:	56                   	push   %esi
80107365:	68 24 80 10 80       	push   $0x80108024
8010736a:	e8 f1 92 ff ff       	call   80100660 <cprintf>
     va, cur->name, cur->pid);
    cur->killed = 1;
8010736f:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
    return;
80107376:	83 c4 10             	add    $0x10,%esp
  {
    panic("Referências incorretas\n");
  }

  lcr3(V2P(cur->pgdir));
80107379:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010737c:	5b                   	pop    %ebx
8010737d:	5e                   	pop    %esi
8010737e:	5f                   	pop    %edi
8010737f:	5d                   	pop    %ebp
80107380:	c3                   	ret    
80107381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     va, cur->name, cur->pid);
    cur->killed = 1;
    return;
  }

  if(*pte &PTE_W){
80107388:	a8 02                	test   $0x2,%al
8010738a:	0f 85 e5 00 00 00    	jne    80107475 <pagefault+0x155>
    cprintf("error code :%x", error);
    panic("Page fault em pagina marcada com PTE_W");
  }

  uint physicalAdress = PTE_ADDR(*pte);
  uint refCount = getRefCount(physicalAdress);
80107390:	83 ec 0c             	sub    $0xc,%esp
  if(*pte &PTE_W){
    cprintf("error code :%x", error);
    panic("Page fault em pagina marcada com PTE_W");
  }

  uint physicalAdress = PTE_ADDR(*pte);
80107393:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint refCount = getRefCount(physicalAdress);
80107398:	50                   	push   %eax
  if(*pte &PTE_W){
    cprintf("error code :%x", error);
    panic("Page fault em pagina marcada com PTE_W");
  }

  uint physicalAdress = PTE_ADDR(*pte);
80107399:	89 c6                	mov    %eax,%esi
  uint refCount = getRefCount(physicalAdress);
8010739b:	e8 20 b2 ff ff       	call   801025c0 <getRefCount>
  cprintf("ref count :%x\n", refCount);
801073a0:	5a                   	pop    %edx
801073a1:	59                   	pop    %ecx
801073a2:	50                   	push   %eax
801073a3:	68 95 7f 10 80       	push   $0x80107f95
801073a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073ab:	e8 b0 92 ff ff       	call   80100660 <cprintf>
  char* mem;

  if(refCount > 1)
801073b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073b3:	83 c4 10             	add    $0x10,%esp
801073b6:	83 f8 01             	cmp    $0x1,%eax
801073b9:	76 7d                	jbe    80107438 <pagefault+0x118>
  {

      if((mem = kalloc()) == 0)
801073bb:	e8 d0 b0 ff ff       	call   80102490 <kalloc>
801073c0:	85 c0                	test   %eax,%eax
801073c2:	89 c2                	mov    %eax,%edx
801073c4:	74 7a                	je     80107440 <pagefault+0x120>
      {
        cprintf("Page fault sem memória, terminando o processo");
        cur->killed=1;
        return;
      }
      memmove(mem, (char*)P2V(physicalAdress), PGSIZE);
801073c6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801073cc:	83 ec 04             	sub    $0x4,%esp
801073cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801073d2:	68 00 10 00 00       	push   $0x1000
801073d7:	50                   	push   %eax
801073d8:	52                   	push   %edx
801073d9:	e8 72 d3 ff ff       	call   80104750 <memmove>

      *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;
801073de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801073e1:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801073e7:	83 ca 07             	or     $0x7,%edx
801073ea:	89 17                	mov    %edx,(%edi)
      uint refTest = getRefCount(physicalAdress);
801073ec:	89 34 24             	mov    %esi,(%esp)
801073ef:	e8 cc b1 ff ff       	call   801025c0 <getRefCount>
      cprintf("ref test :%x\n", refTest);
801073f4:	5a                   	pop    %edx
801073f5:	59                   	pop    %ecx
801073f6:	50                   	push   %eax
801073f7:	68 a4 7f 10 80       	push   $0x80107fa4
801073fc:	e8 5f 92 ff ff       	call   80100660 <cprintf>
      minusRefCount(physicalAdress);
80107401:	89 34 24             	mov    %esi,(%esp)
80107404:	e8 57 b1 ff ff       	call   80102560 <minusRefCount>
      refTest = getRefCount(physicalAdress);
80107409:	89 34 24             	mov    %esi,(%esp)
8010740c:	e8 af b1 ff ff       	call   801025c0 <getRefCount>
      cprintf("ref test :%x\n", refTest);
80107411:	5e                   	pop    %esi
80107412:	5f                   	pop    %edi
80107413:	50                   	push   %eax
80107414:	68 a4 7f 10 80       	push   $0x80107fa4
80107419:	e8 42 92 ff ff       	call   80100660 <cprintf>
8010741e:	83 c4 10             	add    $0x10,%esp
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107421:	8b 43 04             	mov    0x4(%ebx),%eax
80107424:	05 00 00 00 80       	add    $0x80000000,%eax
80107429:	0f 22 d8             	mov    %eax,%cr3
  {
    panic("Referências incorretas\n");
  }

  lcr3(V2P(cur->pgdir));
8010742c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010742f:	5b                   	pop    %ebx
80107430:	5e                   	pop    %esi
80107431:	5f                   	pop    %edi
80107432:	5d                   	pop    %ebp
80107433:	c3                   	ret    
80107434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      refTest = getRefCount(physicalAdress);
      cprintf("ref test :%x\n", refTest);

  }

  else if(refCount == 1)
80107438:	75 56                	jne    80107490 <pagefault+0x170>
  {
    *pte |= PTE_W;
8010743a:	83 0f 02             	orl    $0x2,(%edi)
8010743d:	eb e2                	jmp    80107421 <pagefault+0x101>
8010743f:	90                   	nop
  if(refCount > 1)
  {

      if((mem = kalloc()) == 0)
      {
        cprintf("Page fault sem memória, terminando o processo");
80107440:	83 ec 0c             	sub    $0xc,%esp
80107443:	68 a0 80 10 80       	push   $0x801080a0
80107448:	e8 13 92 ff ff       	call   80100660 <cprintf>
        cur->killed=1;
8010744d:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
        return;
80107454:	83 c4 10             	add    $0x10,%esp
80107457:	e9 1d ff ff ff       	jmp    80107379 <pagefault+0x59>
  uint va = rcr2();
  pte_t *pte;

  if(cur ==0)
  {
    cprintf( "Page fault occured but it was not the user process\n");
8010745c:	83 ec 0c             	sub    $0xc,%esp
8010745f:	68 f0 7f 10 80       	push   $0x80107ff0
80107464:	e8 f7 91 ff ff       	call   80100660 <cprintf>
    panic("pagefault");
80107469:	c7 04 24 7c 7f 10 80 	movl   $0x80107f7c,(%esp)
80107470:	e8 fb 8e ff ff       	call   80100370 <panic>
    cur->killed = 1;
    return;
  }

  if(*pte &PTE_W){
    cprintf("error code :%x", error);
80107475:	53                   	push   %ebx
80107476:	53                   	push   %ebx
80107477:	ff 75 08             	pushl  0x8(%ebp)
8010747a:	68 86 7f 10 80       	push   $0x80107f86
8010747f:	e8 dc 91 ff ff       	call   80100660 <cprintf>
    panic("Page fault em pagina marcada com PTE_W");
80107484:	c7 04 24 78 80 10 80 	movl   $0x80108078,(%esp)
8010748b:	e8 e0 8e ff ff       	call   80100370 <panic>
  {
    *pte |= PTE_W;
  }
  else
  {
    panic("Referências incorretas\n");
80107490:	83 ec 0c             	sub    $0xc,%esp
80107493:	68 b2 7f 10 80       	push   $0x80107fb2
80107498:	e8 d3 8e ff ff       	call   80100370 <panic>
