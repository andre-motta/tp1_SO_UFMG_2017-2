
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp
8010002d:	b8 10 30 10 80       	mov    $0x80103010,%eax
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
8010004c:	68 e0 74 10 80       	push   $0x801074e0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 15 44 00 00       	call   80104470 <initlock>

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
80100092:	68 e7 74 10 80       	push   $0x801074e7
80100097:	50                   	push   %eax
80100098:	e8 c3 42 00 00       	call   80104360 <initsleeplock>
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
801000e4:	e8 87 44 00 00       	call   80104570 <acquire>

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
80100162:	e8 29 45 00 00       	call   80104690 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 42 00 00       	call   801043a0 <acquiresleep>
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
80100193:	68 ee 74 10 80       	push   $0x801074ee
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
801001ae:	e8 8d 42 00 00       	call   80104440 <holdingsleep>
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
801001cc:	68 ff 74 10 80       	push   $0x801074ff
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
801001ef:	e8 4c 42 00 00       	call   80104440 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 41 00 00       	call   80104400 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 60 43 00 00       	call   80104570 <acquire>
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
8010025c:	e9 2f 44 00 00       	jmp    80104690 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 75 10 80       	push   $0x80107506
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010027f:	57                   	push   %edi
80100280:	e8 cb 14 00 00       	call   80101750 <iunlock>
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 df 42 00 00       	call   80104570 <acquire>
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
801002a1:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002a6:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 b5 10 80       	push   $0x8010b520
801002b8:	68 a0 0f 11 80       	push   $0x80110fa0
801002bd:	e8 3e 3d 00 00       	call   80104000 <sleep>
801002c2:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
801002d2:	e8 59 36 00 00       	call   80103930 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 b5 10 80       	push   $0x8010b520
801002e6:	e8 a5 43 00 00       	call   80104690 <release>
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 13 00 00       	call   80101670 <ilock>
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 0f 11 80 	movsbl -0x7feef0e0(%edx),%edx
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
80100322:	83 c6 01             	add    $0x1,%esi
80100325:	83 eb 01             	sub    $0x1,%ebx
80100328:	83 fa 0a             	cmp    $0xa,%edx
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 b5 10 80       	push   $0x8010b520
80100346:	e8 45 43 00 00       	call   80104690 <release>
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 13 00 00       	call   80101670 <ilock>
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
80100360:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
80100378:	fa                   	cli    
80100379:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
80100380:	00 00 00 
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100389:	e8 12 25 00 00       	call   801028a0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 0d 75 10 80       	push   $0x8010750d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
801003a5:	c7 04 24 cf 7e 10 80 	movl   $0x80107ecf,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 d3 40 00 00       	call   80104490 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 21 75 10 80       	push   $0x80107521
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
801003d9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
801003f0:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 21 5a 00 00       	call   80105e40 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
80100437:	0f b6 c0             	movzbl %al,%eax
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
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
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 68 59 00 00       	call   80105e40 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 5c 59 00 00       	call   80105e40 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 50 59 00 00       	call   80105e40 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>
801004f8:	83 ec 04             	sub    $0x4,%esp
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
80100514:	e8 77 42 00 00       	call   80104790 <memmove>
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 b2 41 00 00       	call   801046e0 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 25 75 10 80       	push   $0x80107525
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
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
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
8010058b:	85 c9                	test   %ecx,%ecx
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 50 75 10 80 	movzbl -0x7fef8ab0(%edx),%edx
801005b8:	85 c0                	test   %eax,%eax
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	ff 75 08             	pushl  0x8(%ebp)
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
8010060f:	e8 3c 11 00 00       	call   80101750 <iunlock>
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 50 3f 00 00       	call   80104570 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 44 40 00 00       	call   80104690 <release>
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 1b 10 00 00       	call   80101670 <ilock>
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
8010066e:	85 c0                	test   %eax,%eax
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 b5 10 80       	push   $0x8010b520
8010070d:	e8 7e 3f 00 00       	call   80104690 <release>
80100712:	83 c4 10             	add    $0x10,%esp
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100788:	b8 38 75 10 80       	mov    $0x80107538,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 b5 10 80       	push   $0x8010b520
801007c8:	e8 a3 3d 00 00       	call   80104570 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 3f 75 10 80       	push   $0x8010753f
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
801007f6:	31 f6                	xor    %esi,%esi
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801007fe:	68 20 b5 10 80       	push   $0x8010b520
80100803:	e8 68 3d 00 00       	call   80104570 <acquire>
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
80100831:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100836:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 b5 10 80       	push   $0x8010b520
80100868:	e8 23 3e 00 00       	call   80104690 <release>
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
801008a5:	83 ff 0d             	cmp    $0xd,%edi
801008a8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
801008e9:	83 ec 0c             	sub    $0xc,%esp
801008ec:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
801008f1:	68 a0 0f 11 80       	push   $0x80110fa0
801008f6:	e8 b5 38 00 00       	call   801041b0 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100908:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010090d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100920:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
8010092f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100934:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
80100948:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
80100977:	e9 24 39 00 00       	jmp    801042a0 <procdump>
8010097c:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
801009a6:	68 48 75 10 80       	push   $0x80107548
801009ab:	68 20 b5 10 80       	push   $0x8010b520
801009b0:	e8 bb 3a 00 00       	call   80104470 <initlock>
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
801009bb:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009c2:	06 10 80 
801009c5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009cc:	02 10 80 
801009cf:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009d6:	00 00 00 
801009d9:	e8 c2 18 00 00       	call   801022a0 <ioapicenable>
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
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
801009fc:	e8 2f 2f 00 00       	call   80103930 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a07:	e8 f4 22 00 00       	call   80102d00 <begin_op>
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 a9 14 00 00       	call   80101ec0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 43 0c 00 00       	call   80101670 <ilock>
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 12 0f 00 00       	call   80101950 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 b1 0e 00 00       	call   80101900 <iunlockput>
80100a4f:	e8 1c 23 00 00       	call   80102d70 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
80100a74:	e8 57 65 00 00       	call   80106fd0 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
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
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 83 0e 00 00       	call   80101950 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 17 63 00 00       	call   80106e20 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 21 62 00 00       	call   80106d60 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 f2 63 00 00       	call   80106f50 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 91 0d 00 00       	call   80101900 <iunlockput>
80100b6f:	e8 fc 21 00 00       	call   80102d70 <end_op>
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b7a:	83 c4 0c             	add    $0xc,%esp
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 86 62 00 00       	call   80106e20 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 9f 63 00 00       	call   80106f50 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
80100bbe:	e8 ad 21 00 00       	call   80102d70 <end_op>
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 61 75 10 80       	push   $0x80107561
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 7a 64 00 00       	call   80107070 <clearpteu>
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
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 ee 3c 00 00       	call   80104920 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 db 3c 00 00       	call   80104920 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 7a 66 00 00       	call   801072d0 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
80100c6b:	83 c7 01             	add    $0x1,%edi
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
80100ca5:	29 c1                	sub    %eax,%ecx
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
80100cbb:	e8 10 66 00 00       	call   801072d0 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
80100cde:	0f b6 10             	movzbl (%eax),%edx
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 db 3b 00 00       	call   801048e0 <safestrcpy>
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
80100d10:	89 30                	mov    %esi,(%eax)
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 9f 5e 00 00       	call   80106bd0 <switchuvm>
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 17 62 00 00       	call   80106f50 <freevm>
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
80100d56:	68 6d 75 10 80       	push   $0x8010756d
80100d5b:	68 c0 0f 11 80       	push   $0x80110fc0
80100d60:	e8 0b 37 00 00       	call   80104470 <initlock>
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
80100d81:	e8 ea 37 00 00       	call   80104570 <acquire>
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
80100db1:	e8 da 38 00 00       	call   80104690 <release>
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
80100dc8:	e8 c3 38 00 00       	call   80104690 <release>
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
80100def:	e8 7c 37 00 00       	call   80104570 <acquire>
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
80100e0c:	e8 7f 38 00 00       	call   80104690 <release>
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
80100e1b:	68 74 75 10 80       	push   $0x80107574
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
80100e41:	e8 2a 37 00 00       	call   80104570 <acquire>
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
80100e6c:	e9 1f 38 00 00       	jmp    80104690 <release>
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
80100e98:	e8 f3 37 00 00       	call   80104690 <release>

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
80100ec1:	e8 da 25 00 00       	call   801034a0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 2b 1e 00 00       	call   80102d00 <begin_op>
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
80100eea:	e9 81 1e 00 00       	jmp    80102d70 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 7c 75 10 80       	push   $0x8010757c
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
80100fbd:	e9 7e 26 00 00       	jmp    80103640 <piperead>
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
80100fd2:	68 86 75 10 80       	push   $0x80107586
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
80101039:	e8 32 1d 00 00       	call   80102d70 <end_op>
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
80101066:	e8 95 1c 00 00       	call   80102d00 <begin_op>
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
8010109d:	e8 ce 1c 00 00       	call   80102d70 <end_op>

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
801010dc:	e9 5f 24 00 00       	jmp    80103540 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 8f 75 10 80       	push   $0x8010758f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 95 75 10 80       	push   $0x80107595
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
80101109:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 85 00 00 00    	je     8010119f <balloc+0x9f>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
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
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2d                	jmp    8010117a <balloc+0x7a>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
80101150:	89 c1                	mov    %eax,%ecx
80101152:	ba 01 00 00 00       	mov    $0x1,%edx
80101157:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e2                	shl    %cl,%edx
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101169:	85 d7                	test   %edx,%edi
8010116b:	74 43                	je     801011b0 <balloc+0xb0>
8010116d:	83 c0 01             	add    $0x1,%eax
80101170:	83 c6 01             	add    $0x1,%esi
80101173:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101178:	74 05                	je     8010117f <balloc+0x7f>
8010117a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117d:	72 d1                	jb     80101150 <balloc+0x50>
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	ff 75 e4             	pushl  -0x1c(%ebp)
80101185:	e8 56 f0 ff ff       	call   801001e0 <brelse>
8010118a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101191:	83 c4 10             	add    $0x10,%esp
80101194:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101197:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010119d:	77 82                	ja     80101121 <balloc+0x21>
8010119f:	83 ec 0c             	sub    $0xc,%esp
801011a2:	68 9f 75 10 80       	push   $0x8010759f
801011a7:	e8 c4 f1 ff ff       	call   80100370 <panic>
801011ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011b0:	09 fa                	or     %edi,%edx
801011b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801011b5:	83 ec 0c             	sub    $0xc,%esp
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801011bc:	57                   	push   %edi
801011bd:	e8 1e 1d 00 00       	call   80102ee0 <log_write>
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 f6 34 00 00       	call   801046e0 <memset>
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 ee 1c 00 00       	call   80102ee0 <log_write>
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
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
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
80101218:	31 f6                	xor    %esi,%esi
8010121a:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101225:	68 e0 19 11 80       	push   $0x801119e0
8010122a:	e8 41 33 00 00       	call   80104570 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
80101250:	74 4e                	je     801012a0 <iget+0x90>
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
80101262:	83 ec 0c             	sub    $0xc,%esp
80101265:	83 c1 01             	add    $0x1,%ecx
80101268:	89 de                	mov    %ebx,%esi
8010126a:	68 e0 19 11 80       	push   $0x801119e0
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
80101272:	e8 19 34 00 00       	call   80104690 <release>
80101277:	83 c4 10             	add    $0x10,%esp
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
80101299:	75 b7                	jne    80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
801012a4:	83 ec 0c             	sub    $0xc,%esp
801012a7:	89 3e                	mov    %edi,(%esi)
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801012ba:	68 e0 19 11 80       	push   $0x801119e0
801012bf:	e8 cc 33 00 00       	call   80104690 <release>
801012c4:	83 c4 10             	add    $0x10,%esp
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 b5 75 10 80       	push   $0x801075b5
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801012f3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012f6:	85 c0                	test   %eax,%eax
801012f8:	74 76                	je     80101370 <bmap+0x90>
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	5b                   	pop    %ebx
801012fe:	5e                   	pop    %esi
801012ff:	5f                   	pop    %edi
80101300:	5d                   	pop    %ebp
80101301:	c3                   	ret    
80101302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 83 00 00 00    	ja     80101397 <bmap+0xb7>
80101314:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131a:	85 c0                	test   %eax,%eax
8010131c:	74 6a                	je     80101388 <bmap+0xa8>
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	50                   	push   %eax
80101322:	ff 36                	pushl  (%esi)
80101324:	e8 a7 ed ff ff       	call   801000d0 <bread>
80101329:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132d:	83 c4 10             	add    $0x10,%esp
80101330:	89 c7                	mov    %eax,%edi
80101332:	8b 1a                	mov    (%edx),%ebx
80101334:	85 db                	test   %ebx,%ebx
80101336:	75 1d                	jne    80101355 <bmap+0x75>
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133d:	e8 be fd ff ff       	call   80101100 <balloc>
80101342:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101345:	83 ec 0c             	sub    $0xc,%esp
80101348:	89 c3                	mov    %eax,%ebx
8010134a:	89 02                	mov    %eax,(%edx)
8010134c:	57                   	push   %edi
8010134d:	e8 8e 1b 00 00       	call   80102ee0 <log_write>
80101352:	83 c4 10             	add    $0x10,%esp
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	57                   	push   %edi
80101359:	e8 82 ee ff ff       	call   801001e0 <brelse>
8010135e:	83 c4 10             	add    $0x10,%esp
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101364:	89 d8                	mov    %ebx,%eax
80101366:	5b                   	pop    %ebx
80101367:	5e                   	pop    %esi
80101368:	5f                   	pop    %edi
80101369:	5d                   	pop    %ebp
8010136a:	c3                   	ret    
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101370:	8b 06                	mov    (%esi),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 43 5c             	mov    %eax,0x5c(%ebx)
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101388:	8b 06                	mov    (%esi),%eax
8010138a:	e8 71 fd ff ff       	call   80101100 <balloc>
8010138f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101395:	eb 87                	jmp    8010131e <bmap+0x3e>
80101397:	83 ec 0c             	sub    $0xc,%esp
8010139a:	68 c5 75 10 80       	push   $0x801075c5
8010139f:	e8 cc ef ff ff       	call   80100370 <panic>
801013a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013b0 <readsb>:
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	8b 75 0c             	mov    0xc(%ebp),%esi
801013b8:	83 ec 08             	sub    $0x8,%esp
801013bb:	6a 01                	push   $0x1
801013bd:	ff 75 08             	pushl  0x8(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	6a 1c                	push   $0x1c
801013cf:	50                   	push   %eax
801013d0:	56                   	push   %esi
801013d1:	e8 ba 33 00 00       	call   80104790 <memmove>
801013d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013d9:	83 c4 10             	add    $0x10,%esp
801013dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5d                   	pop    %ebp
801013e2:	e9 f9 ed ff ff       	jmp    801001e0 <brelse>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013f0 <bfree>:
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	89 d3                	mov    %edx,%ebx
801013f7:	89 c6                	mov    %eax,%esi
801013f9:	83 ec 08             	sub    $0x8,%esp
801013fc:	68 c0 19 11 80       	push   $0x801119c0
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 d8 19 11 80    	add    0x801119d8,%edx
80101414:	52                   	push   %edx
80101415:	56                   	push   %esi
80101416:	e8 b5 ec ff ff       	call   801000d0 <bread>
8010141b:	89 d9                	mov    %ebx,%ecx
8010141d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80101423:	ba 01 00 00 00       	mov    $0x1,%edx
80101428:	83 e1 07             	and    $0x7,%ecx
8010142b:	c1 fb 03             	sar    $0x3,%ebx
8010142e:	83 c4 10             	add    $0x10,%esp
80101431:	d3 e2                	shl    %cl,%edx
80101433:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101438:	85 d1                	test   %edx,%ecx
8010143a:	74 27                	je     80101463 <bfree+0x73>
8010143c:	89 c6                	mov    %eax,%esi
8010143e:	f7 d2                	not    %edx
80101440:	89 c8                	mov    %ecx,%eax
80101442:	83 ec 0c             	sub    $0xc,%esp
80101445:	21 d0                	and    %edx,%eax
80101447:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
8010144b:	56                   	push   %esi
8010144c:	e8 8f 1a 00 00       	call   80102ee0 <log_write>
80101451:	89 34 24             	mov    %esi,(%esp)
80101454:	e8 87 ed ff ff       	call   801001e0 <brelse>
80101459:	83 c4 10             	add    $0x10,%esp
8010145c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret    
80101463:	83 ec 0c             	sub    $0xc,%esp
80101466:	68 d8 75 10 80       	push   $0x801075d8
8010146b:	e8 00 ef ff ff       	call   80100370 <panic>

80101470 <iinit>:
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 eb 75 10 80       	push   $0x801075eb
80101481:	68 e0 19 11 80       	push   $0x801119e0
80101486:	e8 e5 2f 00 00       	call   80104470 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 f2 75 10 80       	push   $0x801075f2
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 bc 2e 00 00       	call   80104360 <initsleeplock>
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 c0 19 11 80       	push   $0x801119c0
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
801014bf:	ff 35 d8 19 11 80    	pushl  0x801119d8
801014c5:	ff 35 d4 19 11 80    	pushl  0x801119d4
801014cb:	ff 35 d0 19 11 80    	pushl  0x801119d0
801014d1:	ff 35 cc 19 11 80    	pushl  0x801119cc
801014d7:	ff 35 c8 19 11 80    	pushl  0x801119c8
801014dd:	ff 35 c4 19 11 80    	pushl  0x801119c4
801014e3:	ff 35 c0 19 11 80    	pushl  0x801119c0
801014e9:	68 58 76 10 80       	push   $0x80107658
801014ee:	e8 6d f1 ff ff       	call   80100660 <cprintf>
801014f3:	83 c4 30             	add    $0x30,%esp
801014f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014f9:	c9                   	leave  
801014fa:	c3                   	ret    
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101500 <ialloc>:
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 1c             	sub    $0x1c,%esp
80101509:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
80101510:	8b 45 0c             	mov    0xc(%ebp),%eax
80101513:	8b 75 08             	mov    0x8(%ebp),%esi
80101516:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101519:	0f 86 91 00 00 00    	jbe    801015b0 <ialloc+0xb0>
8010151f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101524:	eb 21                	jmp    80101547 <ialloc+0x47>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101530:	83 ec 0c             	sub    $0xc,%esp
80101533:	83 c3 01             	add    $0x1,%ebx
80101536:	57                   	push   %edi
80101537:	e8 a4 ec ff ff       	call   801001e0 <brelse>
8010153c:	83 c4 10             	add    $0x10,%esp
8010153f:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 d4 19 11 80    	add    0x801119d4,%eax
80101555:	50                   	push   %eax
80101556:	56                   	push   %esi
80101557:	e8 74 eb ff ff       	call   801000d0 <bread>
8010155c:	89 c7                	mov    %eax,%edi
8010155e:	89 d8                	mov    %ebx,%eax
80101560:	83 c4 10             	add    $0x10,%esp
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
80101573:	83 ec 04             	sub    $0x4,%esp
80101576:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101579:	6a 40                	push   $0x40
8010157b:	6a 00                	push   $0x0
8010157d:	51                   	push   %ecx
8010157e:	e8 5d 31 00 00       	call   801046e0 <memset>
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 4b 19 00 00       	call   80102ee0 <log_write>
80101595:	89 3c 24             	mov    %edi,(%esp)
80101598:	e8 43 ec ff ff       	call   801001e0 <brelse>
8010159d:	83 c4 10             	add    $0x10,%esp
801015a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015a3:	89 da                	mov    %ebx,%edx
801015a5:	89 f0                	mov    %esi,%eax
801015a7:	5b                   	pop    %ebx
801015a8:	5e                   	pop    %esi
801015a9:	5f                   	pop    %edi
801015aa:	5d                   	pop    %ebp
801015ab:	e9 60 fc ff ff       	jmp    80101210 <iget>
801015b0:	83 ec 0c             	sub    $0xc,%esp
801015b3:	68 f8 75 10 80       	push   $0x801075f8
801015b8:	e8 b3 ed ff ff       	call   80100370 <panic>
801015bd:	8d 76 00             	lea    0x0(%esi),%esi

801015c0 <iupdate>:
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801015c8:	83 ec 08             	sub    $0x8,%esp
801015cb:	8b 43 04             	mov    0x4(%ebx),%eax
801015ce:	83 c3 5c             	add    $0x5c,%ebx
801015d1:	c1 e8 03             	shr    $0x3,%eax
801015d4:	03 05 d4 19 11 80    	add    0x801119d4,%eax
801015da:	50                   	push   %eax
801015db:	ff 73 a4             	pushl  -0x5c(%ebx)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
801015e3:	89 c6                	mov    %eax,%esi
801015e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
801015e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
801015ec:	83 c4 0c             	add    $0xc,%esp
801015ef:	83 e0 07             	and    $0x7,%eax
801015f2:	c1 e0 06             	shl    $0x6,%eax
801015f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801015f9:	66 89 10             	mov    %dx,(%eax)
801015fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101600:	83 c0 0c             	add    $0xc,%eax
80101603:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101607:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010160b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
8010160f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101613:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101617:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010161a:	89 50 fc             	mov    %edx,-0x4(%eax)
8010161d:	6a 34                	push   $0x34
8010161f:	53                   	push   %ebx
80101620:	50                   	push   %eax
80101621:	e8 6a 31 00 00       	call   80104790 <memmove>
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 b2 18 00 00       	call   80102ee0 <log_write>
8010162e:	89 75 08             	mov    %esi,0x8(%ebp)
80101631:	83 c4 10             	add    $0x10,%esp
80101634:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5d                   	pop    %ebp
8010163a:	e9 a1 eb ff ff       	jmp    801001e0 <brelse>
8010163f:	90                   	nop

80101640 <idup>:
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	83 ec 10             	sub    $0x10,%esp
80101647:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010164a:	68 e0 19 11 80       	push   $0x801119e0
8010164f:	e8 1c 2f 00 00       	call   80104570 <acquire>
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101658:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010165f:	e8 2c 30 00 00       	call   80104690 <release>
80101664:	89 d8                	mov    %ebx,%eax
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ilock>:
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101678:	85 db                	test   %ebx,%ebx
8010167a:	0f 84 b7 00 00 00    	je     80101737 <ilock+0xc7>
80101680:	8b 53 08             	mov    0x8(%ebx),%edx
80101683:	85 d2                	test   %edx,%edx
80101685:	0f 8e ac 00 00 00    	jle    80101737 <ilock+0xc7>
8010168b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010168e:	83 ec 0c             	sub    $0xc,%esp
80101691:	50                   	push   %eax
80101692:	e8 09 2d 00 00       	call   801043a0 <acquiresleep>
80101697:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010169a:	83 c4 10             	add    $0x10,%esp
8010169d:	85 c0                	test   %eax,%eax
8010169f:	74 0f                	je     801016b0 <ilock+0x40>
801016a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016a4:	5b                   	pop    %ebx
801016a5:	5e                   	pop    %esi
801016a6:	5d                   	pop    %ebp
801016a7:	c3                   	ret    
801016a8:	90                   	nop
801016a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016b0:	8b 43 04             	mov    0x4(%ebx),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	c1 e8 03             	shr    $0x3,%eax
801016b9:	03 05 d4 19 11 80    	add    0x801119d4,%eax
801016bf:	50                   	push   %eax
801016c0:	ff 33                	pushl  (%ebx)
801016c2:	e8 09 ea ff ff       	call   801000d0 <bread>
801016c7:	89 c6                	mov    %eax,%esi
801016c9:	8b 43 04             	mov    0x4(%ebx),%eax
801016cc:	83 c4 0c             	add    $0xc,%esp
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801016d9:	0f b7 10             	movzwl (%eax),%edx
801016dc:	83 c0 0c             	add    $0xc,%eax
801016df:	66 89 53 50          	mov    %dx,0x50(%ebx)
801016e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
801016eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
801016f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
801016fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016fe:	89 53 58             	mov    %edx,0x58(%ebx)
80101701:	6a 34                	push   $0x34
80101703:	50                   	push   %eax
80101704:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101707:	50                   	push   %eax
80101708:	e8 83 30 00 00       	call   80104790 <memmove>
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010171d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101724:	0f 85 77 ff ff ff    	jne    801016a1 <ilock+0x31>
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	68 10 76 10 80       	push   $0x80107610
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 0a 76 10 80       	push   $0x8010760a
8010173f:	e8 2c ec ff ff       	call   80100370 <panic>
80101744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010174a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101750 <iunlock>:
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101758:	85 db                	test   %ebx,%ebx
8010175a:	74 28                	je     80101784 <iunlock+0x34>
8010175c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	56                   	push   %esi
80101763:	e8 d8 2c 00 00       	call   80104440 <holdingsleep>
80101768:	83 c4 10             	add    $0x10,%esp
8010176b:	85 c0                	test   %eax,%eax
8010176d:	74 15                	je     80101784 <iunlock+0x34>
8010176f:	8b 43 08             	mov    0x8(%ebx),%eax
80101772:	85 c0                	test   %eax,%eax
80101774:	7e 0e                	jle    80101784 <iunlock+0x34>
80101776:	89 75 08             	mov    %esi,0x8(%ebp)
80101779:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5d                   	pop    %ebp
8010177f:	e9 7c 2c 00 00       	jmp    80104400 <releasesleep>
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 1f 76 10 80       	push   $0x8010761f
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
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 28             	sub    $0x28,%esp
801017a9:	8b 75 08             	mov    0x8(%ebp),%esi
801017ac:	8d 7e 0c             	lea    0xc(%esi),%edi
801017af:	57                   	push   %edi
801017b0:	e8 eb 2b 00 00       	call   801043a0 <acquiresleep>
801017b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 d2                	test   %edx,%edx
801017bd:	74 07                	je     801017c6 <iput+0x26>
801017bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017c4:	74 32                	je     801017f8 <iput+0x58>
801017c6:	83 ec 0c             	sub    $0xc,%esp
801017c9:	57                   	push   %edi
801017ca:	e8 31 2c 00 00       	call   80104400 <releasesleep>
801017cf:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801017d6:	e8 95 2d 00 00       	call   80104570 <acquire>
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
801017e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ec:	5b                   	pop    %ebx
801017ed:	5e                   	pop    %esi
801017ee:	5f                   	pop    %edi
801017ef:	5d                   	pop    %ebp
801017f0:	e9 9b 2e 00 00       	jmp    80104690 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 e0 19 11 80       	push   $0x801119e0
80101800:	e8 6b 2d 00 00       	call   80104570 <acquire>
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
80101808:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010180f:	e8 7c 2e 00 00       	call   80104690 <release>
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
80101833:	39 fb                	cmp    %edi,%ebx
80101835:	74 19                	je     80101850 <iput+0xb0>
80101837:	8b 13                	mov    (%ebx),%edx
80101839:	85 d2                	test   %edx,%edx
8010183b:	74 f3                	je     80101830 <iput+0x90>
8010183d:	8b 06                	mov    (%esi),%eax
8010183f:	e8 ac fb ff ff       	call   801013f0 <bfree>
80101844:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010184a:	eb e4                	jmp    80101830 <iput+0x90>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101856:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101859:	85 c0                	test   %eax,%eax
8010185b:	75 33                	jne    80101890 <iput+0xf0>
8010185d:	83 ec 0c             	sub    $0xc,%esp
80101860:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
80101867:	56                   	push   %esi
80101868:	e8 53 fd ff ff       	call   801015c0 <iupdate>
8010186d:	31 c0                	xor    %eax,%eax
8010186f:	66 89 46 50          	mov    %ax,0x50(%esi)
80101873:	89 34 24             	mov    %esi,(%esp)
80101876:	e8 45 fd ff ff       	call   801015c0 <iupdate>
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101882:	83 c4 10             	add    $0x10,%esp
80101885:	e9 3c ff ff ff       	jmp    801017c6 <iput+0x26>
8010188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101890:	83 ec 08             	sub    $0x8,%esp
80101893:	50                   	push   %eax
80101894:	ff 36                	pushl  (%esi)
80101896:	e8 35 e8 ff ff       	call   801000d0 <bread>
8010189b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018a1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801018a7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018aa:	83 c4 10             	add    $0x10,%esp
801018ad:	89 cf                	mov    %ecx,%edi
801018af:	eb 0e                	jmp    801018bf <iput+0x11f>
801018b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018b8:	83 c3 04             	add    $0x4,%ebx
801018bb:	39 fb                	cmp    %edi,%ebx
801018bd:	74 0f                	je     801018ce <iput+0x12e>
801018bf:	8b 13                	mov    (%ebx),%edx
801018c1:	85 d2                	test   %edx,%edx
801018c3:	74 f3                	je     801018b8 <iput+0x118>
801018c5:	8b 06                	mov    (%esi),%eax
801018c7:	e8 24 fb ff ff       	call   801013f0 <bfree>
801018cc:	eb ea                	jmp    801018b8 <iput+0x118>
801018ce:	83 ec 0c             	sub    $0xc,%esp
801018d1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018d7:	e8 04 e9 ff ff       	call   801001e0 <brelse>
801018dc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018e2:	8b 06                	mov    (%esi),%eax
801018e4:	e8 07 fb ff ff       	call   801013f0 <bfree>
801018e9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018f0:	00 00 00 
801018f3:	83 c4 10             	add    $0x10,%esp
801018f6:	e9 62 ff ff ff       	jmp    8010185d <iput+0xbd>
801018fb:	90                   	nop
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101900 <iunlockput>:
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	53                   	push   %ebx
80101904:	83 ec 10             	sub    $0x10,%esp
80101907:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010190a:	53                   	push   %ebx
8010190b:	e8 40 fe ff ff       	call   80101750 <iunlock>
80101910:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101919:	c9                   	leave  
8010191a:	e9 81 fe ff ff       	jmp    801017a0 <iput>
8010191f:	90                   	nop

80101920 <stati>:
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	8b 55 08             	mov    0x8(%ebp),%edx
80101926:	8b 45 0c             	mov    0xc(%ebp),%eax
80101929:	8b 0a                	mov    (%edx),%ecx
8010192b:	89 48 04             	mov    %ecx,0x4(%eax)
8010192e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101931:	89 48 08             	mov    %ecx,0x8(%eax)
80101934:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101938:	66 89 08             	mov    %cx,(%eax)
8010193b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010193f:	66 89 48 0c          	mov    %cx,0xc(%eax)
80101943:	8b 52 58             	mov    0x58(%edx),%edx
80101946:	89 50 10             	mov    %edx,0x10(%eax)
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <readi>:
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	57                   	push   %edi
80101954:	56                   	push   %esi
80101955:	53                   	push   %ebx
80101956:	83 ec 1c             	sub    $0x1c,%esp
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010195f:	8b 75 10             	mov    0x10(%ebp),%esi
80101962:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101967:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010196a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010196d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101970:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101973:	0f 84 a7 00 00 00    	je     80101a20 <readi+0xd0>
80101979:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010197c:	8b 40 58             	mov    0x58(%eax),%eax
8010197f:	39 f0                	cmp    %esi,%eax
80101981:	0f 82 c1 00 00 00    	jb     80101a48 <readi+0xf8>
80101987:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010198a:	89 fa                	mov    %edi,%edx
8010198c:	01 f2                	add    %esi,%edx
8010198e:	0f 82 b4 00 00 00    	jb     80101a48 <readi+0xf8>
80101994:	89 c1                	mov    %eax,%ecx
80101996:	29 f1                	sub    %esi,%ecx
80101998:	39 d0                	cmp    %edx,%eax
8010199a:	0f 43 cf             	cmovae %edi,%ecx
8010199d:	31 ff                	xor    %edi,%edi
8010199f:	85 c9                	test   %ecx,%ecx
801019a1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801019a4:	74 6d                	je     80101a13 <readi+0xc3>
801019a6:	8d 76 00             	lea    0x0(%esi),%esi
801019a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801019b0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019b3:	89 f2                	mov    %esi,%edx
801019b5:	c1 ea 09             	shr    $0x9,%edx
801019b8:	89 d8                	mov    %ebx,%eax
801019ba:	e8 21 f9 ff ff       	call   801012e0 <bmap>
801019bf:	83 ec 08             	sub    $0x8,%esp
801019c2:	50                   	push   %eax
801019c3:	ff 33                	pushl  (%ebx)
801019c5:	bb 00 02 00 00       	mov    $0x200,%ebx
801019ca:	e8 01 e7 ff ff       	call   801000d0 <bread>
801019cf:	89 c2                	mov    %eax,%edx
801019d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019d4:	89 f1                	mov    %esi,%ecx
801019d6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019dc:	83 c4 0c             	add    $0xc,%esp
801019df:	89 55 dc             	mov    %edx,-0x24(%ebp)
801019e2:	29 cb                	sub    %ecx,%ebx
801019e4:	29 f8                	sub    %edi,%eax
801019e6:	39 c3                	cmp    %eax,%ebx
801019e8:	0f 47 d8             	cmova  %eax,%ebx
801019eb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019ef:	53                   	push   %ebx
801019f0:	01 df                	add    %ebx,%edi
801019f2:	01 de                	add    %ebx,%esi
801019f4:	50                   	push   %eax
801019f5:	ff 75 e0             	pushl  -0x20(%ebp)
801019f8:	e8 93 2d 00 00       	call   80104790 <memmove>
801019fd:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a00:	89 14 24             	mov    %edx,(%esp)
80101a03:	e8 d8 e7 ff ff       	call   801001e0 <brelse>
80101a08:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a11:	77 9d                	ja     801019b0 <readi+0x60>
80101a13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a19:	5b                   	pop    %ebx
80101a1a:	5e                   	pop    %esi
80101a1b:	5f                   	pop    %edi
80101a1c:	5d                   	pop    %ebp
80101a1d:	c3                   	ret    
80101a1e:	66 90                	xchg   %ax,%ax
80101a20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a24:	66 83 f8 09          	cmp    $0x9,%ax
80101a28:	77 1e                	ja     80101a48 <readi+0xf8>
80101a2a:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
80101a31:	85 c0                	test   %eax,%eax
80101a33:	74 13                	je     80101a48 <readi+0xf8>
80101a35:	89 7d 10             	mov    %edi,0x10(%ebp)
80101a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a3b:	5b                   	pop    %ebx
80101a3c:	5e                   	pop    %esi
80101a3d:	5f                   	pop    %edi
80101a3e:	5d                   	pop    %ebp
80101a3f:	ff e0                	jmp    *%eax
80101a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a4d:	eb c7                	jmp    80101a16 <readi+0xc6>
80101a4f:	90                   	nop

80101a50 <writei>:
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 1c             	sub    $0x1c,%esp
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a5f:	8b 7d 14             	mov    0x14(%ebp),%edi
80101a62:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101a67:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a6d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a70:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a73:	0f 84 b7 00 00 00    	je     80101b30 <writei+0xe0>
80101a79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a7c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a7f:	0f 82 eb 00 00 00    	jb     80101b70 <writei+0x120>
80101a85:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a88:	89 f8                	mov    %edi,%eax
80101a8a:	01 f0                	add    %esi,%eax
80101a8c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a91:	0f 87 d9 00 00 00    	ja     80101b70 <writei+0x120>
80101a97:	39 c6                	cmp    %eax,%esi
80101a99:	0f 87 d1 00 00 00    	ja     80101b70 <writei+0x120>
80101a9f:	85 ff                	test   %edi,%edi
80101aa1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101aa8:	74 78                	je     80101b22 <writei+0xd2>
80101aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ab0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ab3:	89 f2                	mov    %esi,%edx
80101ab5:	bb 00 02 00 00       	mov    $0x200,%ebx
80101aba:	c1 ea 09             	shr    $0x9,%edx
80101abd:	89 f8                	mov    %edi,%eax
80101abf:	e8 1c f8 ff ff       	call   801012e0 <bmap>
80101ac4:	83 ec 08             	sub    $0x8,%esp
80101ac7:	50                   	push   %eax
80101ac8:	ff 37                	pushl  (%edi)
80101aca:	e8 01 e6 ff ff       	call   801000d0 <bread>
80101acf:	89 c7                	mov    %eax,%edi
80101ad1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ad4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ad7:	89 f1                	mov    %esi,%ecx
80101ad9:	83 c4 0c             	add    $0xc,%esp
80101adc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ae2:	29 cb                	sub    %ecx,%ebx
80101ae4:	39 c3                	cmp    %eax,%ebx
80101ae6:	0f 47 d8             	cmova  %eax,%ebx
80101ae9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101aed:	53                   	push   %ebx
80101aee:	ff 75 dc             	pushl  -0x24(%ebp)
80101af1:	01 de                	add    %ebx,%esi
80101af3:	50                   	push   %eax
80101af4:	e8 97 2c 00 00       	call   80104790 <memmove>
80101af9:	89 3c 24             	mov    %edi,(%esp)
80101afc:	e8 df 13 00 00       	call   80102ee0 <log_write>
80101b01:	89 3c 24             	mov    %edi,(%esp)
80101b04:	e8 d7 e6 ff ff       	call   801001e0 <brelse>
80101b09:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b0c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b0f:	83 c4 10             	add    $0x10,%esp
80101b12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b15:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b18:	77 96                	ja     80101ab0 <writei+0x60>
80101b1a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b1d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b20:	77 36                	ja     80101b58 <writei+0x108>
80101b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b28:	5b                   	pop    %ebx
80101b29:	5e                   	pop    %esi
80101b2a:	5f                   	pop    %edi
80101b2b:	5d                   	pop    %ebp
80101b2c:	c3                   	ret    
80101b2d:	8d 76 00             	lea    0x0(%esi),%esi
80101b30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b34:	66 83 f8 09          	cmp    $0x9,%ax
80101b38:	77 36                	ja     80101b70 <writei+0x120>
80101b3a:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
80101b41:	85 c0                	test   %eax,%eax
80101b43:	74 2b                	je     80101b70 <writei+0x120>
80101b45:	89 7d 10             	mov    %edi,0x10(%ebp)
80101b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b4b:	5b                   	pop    %ebx
80101b4c:	5e                   	pop    %esi
80101b4d:	5f                   	pop    %edi
80101b4e:	5d                   	pop    %ebp
80101b4f:	ff e0                	jmp    *%eax
80101b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5b:	83 ec 0c             	sub    $0xc,%esp
80101b5e:	89 70 58             	mov    %esi,0x58(%eax)
80101b61:	50                   	push   %eax
80101b62:	e8 59 fa ff ff       	call   801015c0 <iupdate>
80101b67:	83 c4 10             	add    $0x10,%esp
80101b6a:	eb b6                	jmp    80101b22 <writei+0xd2>
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b75:	eb ae                	jmp    80101b25 <writei+0xd5>
80101b77:	89 f6                	mov    %esi,%esi
80101b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b80 <namecmp>:
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	83 ec 0c             	sub    $0xc,%esp
80101b86:	6a 0e                	push   $0xe
80101b88:	ff 75 0c             	pushl  0xc(%ebp)
80101b8b:	ff 75 08             	pushl  0x8(%ebp)
80101b8e:	e8 7d 2c 00 00       	call   80104810 <strncmp>
80101b93:	c9                   	leave  
80101b94:	c3                   	ret    
80101b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <dirlookup>:
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bb1:	0f 85 80 00 00 00    	jne    80101c37 <dirlookup+0x97>
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
80101bd0:	6a 10                	push   $0x10
80101bd2:	57                   	push   %edi
80101bd3:	56                   	push   %esi
80101bd4:	53                   	push   %ebx
80101bd5:	e8 76 fd ff ff       	call   80101950 <readi>
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	83 f8 10             	cmp    $0x10,%eax
80101be0:	75 48                	jne    80101c2a <dirlookup+0x8a>
80101be2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101be7:	74 df                	je     80101bc8 <dirlookup+0x28>
80101be9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bec:	83 ec 04             	sub    $0x4,%esp
80101bef:	6a 0e                	push   $0xe
80101bf1:	50                   	push   %eax
80101bf2:	ff 75 0c             	pushl  0xc(%ebp)
80101bf5:	e8 16 2c 00 00       	call   80104810 <strncmp>
80101bfa:	83 c4 10             	add    $0x10,%esp
80101bfd:	85 c0                	test   %eax,%eax
80101bff:	75 c7                	jne    80101bc8 <dirlookup+0x28>
80101c01:	8b 45 10             	mov    0x10(%ebp),%eax
80101c04:	85 c0                	test   %eax,%eax
80101c06:	74 05                	je     80101c0d <dirlookup+0x6d>
80101c08:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0b:	89 38                	mov    %edi,(%eax)
80101c0d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c11:	8b 03                	mov    (%ebx),%eax
80101c13:	e8 f8 f5 ff ff       	call   80101210 <iget>
80101c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1b:	5b                   	pop    %ebx
80101c1c:	5e                   	pop    %esi
80101c1d:	5f                   	pop    %edi
80101c1e:	5d                   	pop    %ebp
80101c1f:	c3                   	ret    
80101c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c23:	31 c0                	xor    %eax,%eax
80101c25:	5b                   	pop    %ebx
80101c26:	5e                   	pop    %esi
80101c27:	5f                   	pop    %edi
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    
80101c2a:	83 ec 0c             	sub    $0xc,%esp
80101c2d:	68 39 76 10 80       	push   $0x80107639
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 27 76 10 80       	push   $0x80107627
80101c3f:	e8 2c e7 ff ff       	call   80100370 <panic>
80101c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c50 <namex>:
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	89 cf                	mov    %ecx,%edi
80101c58:	89 c3                	mov    %eax,%ebx
80101c5a:	83 ec 1c             	sub    $0x1c,%esp
80101c5d:	80 38 2f             	cmpb   $0x2f,(%eax)
80101c60:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101c63:	0f 84 53 01 00 00    	je     80101dbc <namex+0x16c>
80101c69:	e8 c2 1c 00 00       	call   80103930 <myproc>
80101c6e:	83 ec 0c             	sub    $0xc,%esp
80101c71:	8b 70 68             	mov    0x68(%eax),%esi
80101c74:	68 e0 19 11 80       	push   $0x801119e0
80101c79:	e8 f2 28 00 00       	call   80104570 <acquire>
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
80101c82:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101c89:	e8 02 2a 00 00       	call   80104690 <release>
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	eb 08                	jmp    80101c9b <namex+0x4b>
80101c93:	90                   	nop
80101c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c98:	83 c3 01             	add    $0x1,%ebx
80101c9b:	0f b6 03             	movzbl (%ebx),%eax
80101c9e:	3c 2f                	cmp    $0x2f,%al
80101ca0:	74 f6                	je     80101c98 <namex+0x48>
80101ca2:	84 c0                	test   %al,%al
80101ca4:	0f 84 e3 00 00 00    	je     80101d8d <namex+0x13d>
80101caa:	0f b6 03             	movzbl (%ebx),%eax
80101cad:	89 da                	mov    %ebx,%edx
80101caf:	84 c0                	test   %al,%al
80101cb1:	0f 84 ac 00 00 00    	je     80101d63 <namex+0x113>
80101cb7:	3c 2f                	cmp    $0x2f,%al
80101cb9:	75 09                	jne    80101cc4 <namex+0x74>
80101cbb:	e9 a3 00 00 00       	jmp    80101d63 <namex+0x113>
80101cc0:	84 c0                	test   %al,%al
80101cc2:	74 0a                	je     80101cce <namex+0x7e>
80101cc4:	83 c2 01             	add    $0x1,%edx
80101cc7:	0f b6 02             	movzbl (%edx),%eax
80101cca:	3c 2f                	cmp    $0x2f,%al
80101ccc:	75 f2                	jne    80101cc0 <namex+0x70>
80101cce:	89 d1                	mov    %edx,%ecx
80101cd0:	29 d9                	sub    %ebx,%ecx
80101cd2:	83 f9 0d             	cmp    $0xd,%ecx
80101cd5:	0f 8e 8d 00 00 00    	jle    80101d68 <namex+0x118>
80101cdb:	83 ec 04             	sub    $0x4,%esp
80101cde:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ce1:	6a 0e                	push   $0xe
80101ce3:	53                   	push   %ebx
80101ce4:	57                   	push   %edi
80101ce5:	e8 a6 2a 00 00       	call   80104790 <memmove>
80101cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ced:	83 c4 10             	add    $0x10,%esp
80101cf0:	89 d3                	mov    %edx,%ebx
80101cf2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cf5:	75 11                	jne    80101d08 <namex+0xb8>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101d00:	83 c3 01             	add    $0x1,%ebx
80101d03:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d06:	74 f8                	je     80101d00 <namex+0xb0>
80101d08:	83 ec 0c             	sub    $0xc,%esp
80101d0b:	56                   	push   %esi
80101d0c:	e8 5f f9 ff ff       	call   80101670 <ilock>
80101d11:	83 c4 10             	add    $0x10,%esp
80101d14:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d19:	0f 85 7f 00 00 00    	jne    80101d9e <namex+0x14e>
80101d1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d22:	85 d2                	test   %edx,%edx
80101d24:	74 09                	je     80101d2f <namex+0xdf>
80101d26:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d29:	0f 84 a3 00 00 00    	je     80101dd2 <namex+0x182>
80101d2f:	83 ec 04             	sub    $0x4,%esp
80101d32:	6a 00                	push   $0x0
80101d34:	57                   	push   %edi
80101d35:	56                   	push   %esi
80101d36:	e8 65 fe ff ff       	call   80101ba0 <dirlookup>
80101d3b:	83 c4 10             	add    $0x10,%esp
80101d3e:	85 c0                	test   %eax,%eax
80101d40:	74 5c                	je     80101d9e <namex+0x14e>
80101d42:	83 ec 0c             	sub    $0xc,%esp
80101d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d48:	56                   	push   %esi
80101d49:	e8 02 fa ff ff       	call   80101750 <iunlock>
80101d4e:	89 34 24             	mov    %esi,(%esp)
80101d51:	e8 4a fa ff ff       	call   801017a0 <iput>
80101d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d59:	83 c4 10             	add    $0x10,%esp
80101d5c:	89 c6                	mov    %eax,%esi
80101d5e:	e9 38 ff ff ff       	jmp    80101c9b <namex+0x4b>
80101d63:	31 c9                	xor    %ecx,%ecx
80101d65:	8d 76 00             	lea    0x0(%esi),%esi
80101d68:	83 ec 04             	sub    $0x4,%esp
80101d6b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d6e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d71:	51                   	push   %ecx
80101d72:	53                   	push   %ebx
80101d73:	57                   	push   %edi
80101d74:	e8 17 2a 00 00       	call   80104790 <memmove>
80101d79:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d7f:	83 c4 10             	add    $0x10,%esp
80101d82:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d86:	89 d3                	mov    %edx,%ebx
80101d88:	e9 65 ff ff ff       	jmp    80101cf2 <namex+0xa2>
80101d8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d90:	85 c0                	test   %eax,%eax
80101d92:	75 54                	jne    80101de8 <namex+0x198>
80101d94:	89 f0                	mov    %esi,%eax
80101d96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d99:	5b                   	pop    %ebx
80101d9a:	5e                   	pop    %esi
80101d9b:	5f                   	pop    %edi
80101d9c:	5d                   	pop    %ebp
80101d9d:	c3                   	ret    
80101d9e:	83 ec 0c             	sub    $0xc,%esp
80101da1:	56                   	push   %esi
80101da2:	e8 a9 f9 ff ff       	call   80101750 <iunlock>
80101da7:	89 34 24             	mov    %esi,(%esp)
80101daa:	e8 f1 f9 ff ff       	call   801017a0 <iput>
80101daf:	83 c4 10             	add    $0x10,%esp
80101db2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db5:	31 c0                	xor    %eax,%eax
80101db7:	5b                   	pop    %ebx
80101db8:	5e                   	pop    %esi
80101db9:	5f                   	pop    %edi
80101dba:	5d                   	pop    %ebp
80101dbb:	c3                   	ret    
80101dbc:	ba 01 00 00 00       	mov    $0x1,%edx
80101dc1:	b8 01 00 00 00       	mov    $0x1,%eax
80101dc6:	e8 45 f4 ff ff       	call   80101210 <iget>
80101dcb:	89 c6                	mov    %eax,%esi
80101dcd:	e9 c9 fe ff ff       	jmp    80101c9b <namex+0x4b>
80101dd2:	83 ec 0c             	sub    $0xc,%esp
80101dd5:	56                   	push   %esi
80101dd6:	e8 75 f9 ff ff       	call   80101750 <iunlock>
80101ddb:	83 c4 10             	add    $0x10,%esp
80101dde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de1:	89 f0                	mov    %esi,%eax
80101de3:	5b                   	pop    %ebx
80101de4:	5e                   	pop    %esi
80101de5:	5f                   	pop    %edi
80101de6:	5d                   	pop    %ebp
80101de7:	c3                   	ret    
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	56                   	push   %esi
80101dec:	e8 af f9 ff ff       	call   801017a0 <iput>
80101df1:	83 c4 10             	add    $0x10,%esp
80101df4:	31 c0                	xor    %eax,%eax
80101df6:	eb 9e                	jmp    80101d96 <namex+0x146>
80101df8:	90                   	nop
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <dirlink>:
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 20             	sub    $0x20,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101e0c:	6a 00                	push   $0x0
80101e0e:	ff 75 0c             	pushl  0xc(%ebp)
80101e11:	53                   	push   %ebx
80101e12:	e8 89 fd ff ff       	call   80101ba0 <dirlookup>
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	85 c0                	test   %eax,%eax
80101e1c:	75 67                	jne    80101e85 <dirlink+0x85>
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
80101e38:	6a 10                	push   $0x10
80101e3a:	57                   	push   %edi
80101e3b:	56                   	push   %esi
80101e3c:	53                   	push   %ebx
80101e3d:	e8 0e fb ff ff       	call   80101950 <readi>
80101e42:	83 c4 10             	add    $0x10,%esp
80101e45:	83 f8 10             	cmp    $0x10,%eax
80101e48:	75 4e                	jne    80101e98 <dirlink+0x98>
80101e4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e4f:	75 df                	jne    80101e30 <dirlink+0x30>
80101e51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e54:	83 ec 04             	sub    $0x4,%esp
80101e57:	6a 0e                	push   $0xe
80101e59:	ff 75 0c             	pushl  0xc(%ebp)
80101e5c:	50                   	push   %eax
80101e5d:	e8 1e 2a 00 00       	call   80104880 <strncpy>
80101e62:	8b 45 10             	mov    0x10(%ebp),%eax
80101e65:	6a 10                	push   $0x10
80101e67:	57                   	push   %edi
80101e68:	56                   	push   %esi
80101e69:	53                   	push   %ebx
80101e6a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
80101e6e:	e8 dd fb ff ff       	call   80101a50 <writei>
80101e73:	83 c4 20             	add    $0x20,%esp
80101e76:	83 f8 10             	cmp    $0x10,%eax
80101e79:	75 2a                	jne    80101ea5 <dirlink+0xa5>
80101e7b:	31 c0                	xor    %eax,%eax
80101e7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e80:	5b                   	pop    %ebx
80101e81:	5e                   	pop    %esi
80101e82:	5f                   	pop    %edi
80101e83:	5d                   	pop    %ebp
80101e84:	c3                   	ret    
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	50                   	push   %eax
80101e89:	e8 12 f9 ff ff       	call   801017a0 <iput>
80101e8e:	83 c4 10             	add    $0x10,%esp
80101e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e96:	eb e5                	jmp    80101e7d <dirlink+0x7d>
80101e98:	83 ec 0c             	sub    $0xc,%esp
80101e9b:	68 48 76 10 80       	push   $0x80107648
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 6e 7c 10 80       	push   $0x80107c6e
80101ead:	e8 be e4 ff ff       	call   80100370 <panic>
80101eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <namei>:
80101ec0:	55                   	push   %ebp
80101ec1:	31 d2                	xor    %edx,%edx
80101ec3:	89 e5                	mov    %esp,%ebp
80101ec5:	83 ec 18             	sub    $0x18,%esp
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ece:	e8 7d fd ff ff       	call   80101c50 <namex>
80101ed3:	c9                   	leave  
80101ed4:	c3                   	ret    
80101ed5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <nameiparent>:
80101ee0:	55                   	push   %ebp
80101ee1:	ba 01 00 00 00       	mov    $0x1,%edx
80101ee6:	89 e5                	mov    %esp,%ebp
80101ee8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
80101eee:	5d                   	pop    %ebp
80101eef:	e9 5c fd ff ff       	jmp    80101c50 <namex>
80101ef4:	66 90                	xchg   %ax,%ax
80101ef6:	66 90                	xchg   %ax,%ax
80101ef8:	66 90                	xchg   %ax,%ax
80101efa:	66 90                	xchg   %ax,%ax
80101efc:	66 90                	xchg   %ax,%ax
80101efe:	66 90                	xchg   %ax,%ax

80101f00 <idestart>:
80101f00:	55                   	push   %ebp
80101f01:	85 c0                	test   %eax,%eax
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	56                   	push   %esi
80101f06:	53                   	push   %ebx
80101f07:	0f 84 ad 00 00 00    	je     80101fba <idestart+0xba>
80101f0d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f10:	89 c1                	mov    %eax,%ecx
80101f12:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f18:	0f 87 8f 00 00 00    	ja     80101fad <idestart+0xad>
80101f1e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f23:	90                   	nop
80101f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f28:	ec                   	in     (%dx),%al
80101f29:	83 e0 c0             	and    $0xffffffc0,%eax
80101f2c:	3c 40                	cmp    $0x40,%al
80101f2e:	75 f8                	jne    80101f28 <idestart+0x28>
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
80101f73:	f6 01 04             	testb  $0x4,(%ecx)
80101f76:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f7b:	75 13                	jne    80101f90 <idestart+0x90>
80101f7d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f82:	ee                   	out    %al,(%dx)
80101f83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f86:	5b                   	pop    %ebx
80101f87:	5e                   	pop    %esi
80101f88:	5d                   	pop    %ebp
80101f89:	c3                   	ret    
80101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f90:	b8 30 00 00 00       	mov    $0x30,%eax
80101f95:	ee                   	out    %al,(%dx)
80101f96:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101f9b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f9e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fa3:	fc                   	cld    
80101fa4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80101fa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fa9:	5b                   	pop    %ebx
80101faa:	5e                   	pop    %esi
80101fab:	5d                   	pop    %ebp
80101fac:	c3                   	ret    
80101fad:	83 ec 0c             	sub    $0xc,%esp
80101fb0:	68 b4 76 10 80       	push   $0x801076b4
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 ab 76 10 80       	push   $0x801076ab
80101fc2:	e8 a9 e3 ff ff       	call   80100370 <panic>
80101fc7:	89 f6                	mov    %esi,%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <ideinit>:
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 10             	sub    $0x10,%esp
80101fd6:	68 c6 76 10 80       	push   $0x801076c6
80101fdb:	68 80 b5 10 80       	push   $0x8010b580
80101fe0:	e8 8b 24 00 00       	call   80104470 <initlock>
80101fe5:	58                   	pop    %eax
80101fe6:	a1 00 bd 14 80       	mov    0x8014bd00,%eax
80101feb:	5a                   	pop    %edx
80101fec:	83 e8 01             	sub    $0x1,%eax
80101fef:	50                   	push   %eax
80101ff0:	6a 0e                	push   $0xe
80101ff2:	e8 a9 02 00 00       	call   801022a0 <ioapicenable>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fff:	90                   	nop
80102000:	ec                   	in     (%dx),%al
80102001:	83 e0 c0             	and    $0xffffffc0,%eax
80102004:	3c 40                	cmp    $0x40,%al
80102006:	75 f8                	jne    80102000 <ideinit+0x30>
80102008:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010200d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102012:	ee                   	out    %al,(%dx)
80102013:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102018:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201d:	eb 06                	jmp    80102025 <ideinit+0x55>
8010201f:	90                   	nop
80102020:	83 e9 01             	sub    $0x1,%ecx
80102023:	74 0f                	je     80102034 <ideinit+0x64>
80102025:	ec                   	in     (%dx),%al
80102026:	84 c0                	test   %al,%al
80102028:	74 f6                	je     80102020 <ideinit+0x50>
8010202a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102031:	00 00 00 
80102034:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102039:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010203e:	ee                   	out    %al,(%dx)
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
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 18             	sub    $0x18,%esp
80102059:	68 80 b5 10 80       	push   $0x8010b580
8010205e:	e8 0d 25 00 00       	call   80104570 <acquire>
80102063:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102069:	83 c4 10             	add    $0x10,%esp
8010206c:	85 db                	test   %ebx,%ebx
8010206e:	74 34                	je     801020a4 <ideintr+0x54>
80102070:	8b 43 58             	mov    0x58(%ebx),%eax
80102073:	a3 64 b5 10 80       	mov    %eax,0x8010b564
80102078:	8b 33                	mov    (%ebx),%esi
8010207a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102080:	74 3e                	je     801020c0 <ideintr+0x70>
80102082:	83 e6 fb             	and    $0xfffffffb,%esi
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	83 ce 02             	or     $0x2,%esi
8010208b:	89 33                	mov    %esi,(%ebx)
8010208d:	53                   	push   %ebx
8010208e:	e8 1d 21 00 00       	call   801041b0 <wakeup>
80102093:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 c0                	test   %eax,%eax
8010209d:	74 05                	je     801020a4 <ideintr+0x54>
8010209f:	e8 5c fe ff ff       	call   80101f00 <idestart>
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	68 80 b5 10 80       	push   $0x8010b580
801020ac:	e8 df 25 00 00       	call   80104690 <release>
801020b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b4:	5b                   	pop    %ebx
801020b5:	5e                   	pop    %esi
801020b6:	5f                   	pop    %edi
801020b7:	5d                   	pop    %ebp
801020b8:	c3                   	ret    
801020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c5:	8d 76 00             	lea    0x0(%esi),%esi
801020c8:	ec                   	in     (%dx),%al
801020c9:	89 c1                	mov    %eax,%ecx
801020cb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ce:	80 f9 40             	cmp    $0x40,%cl
801020d1:	75 f5                	jne    801020c8 <ideintr+0x78>
801020d3:	a8 21                	test   $0x21,%al
801020d5:	75 ab                	jne    80102082 <ideintr+0x32>
801020d7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801020da:	b9 80 00 00 00       	mov    $0x80,%ecx
801020df:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020e4:	fc                   	cld    
801020e5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e7:	8b 33                	mov    (%ebx),%esi
801020e9:	eb 97                	jmp    80102082 <ideintr+0x32>
801020eb:	90                   	nop
801020ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020f0 <iderw>:
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	53                   	push   %ebx
801020f4:	83 ec 10             	sub    $0x10,%esp
801020f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801020fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801020fd:	50                   	push   %eax
801020fe:	e8 3d 23 00 00       	call   80104440 <holdingsleep>
80102103:	83 c4 10             	add    $0x10,%esp
80102106:	85 c0                	test   %eax,%eax
80102108:	0f 84 ad 00 00 00    	je     801021bb <iderw+0xcb>
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	0f 84 b9 00 00 00    	je     801021d5 <iderw+0xe5>
8010211c:	8b 53 04             	mov    0x4(%ebx),%edx
8010211f:	85 d2                	test   %edx,%edx
80102121:	74 0d                	je     80102130 <iderw+0x40>
80102123:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102128:	85 c0                	test   %eax,%eax
8010212a:	0f 84 98 00 00 00    	je     801021c8 <iderw+0xd8>
80102130:	83 ec 0c             	sub    $0xc,%esp
80102133:	68 80 b5 10 80       	push   $0x8010b580
80102138:	e8 33 24 00 00       	call   80104570 <acquire>
8010213d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102143:	83 c4 10             	add    $0x10,%esp
80102146:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
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
80102164:	89 1a                	mov    %ebx,(%edx)
80102166:	3b 1d 64 b5 10 80    	cmp    0x8010b564,%ebx
8010216c:	74 44                	je     801021b2 <iderw+0xc2>
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 e0 06             	and    $0x6,%eax
80102173:	83 f8 02             	cmp    $0x2,%eax
80102176:	74 23                	je     8010219b <iderw+0xab>
80102178:	90                   	nop
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102180:	83 ec 08             	sub    $0x8,%esp
80102183:	68 80 b5 10 80       	push   $0x8010b580
80102188:	53                   	push   %ebx
80102189:	e8 72 1e 00 00       	call   80104000 <sleep>
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 c4 10             	add    $0x10,%esp
80102193:	83 e0 06             	and    $0x6,%eax
80102196:	83 f8 02             	cmp    $0x2,%eax
80102199:	75 e5                	jne    80102180 <iderw+0x90>
8010219b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
801021a6:	e9 e5 24 00 00       	jmp    80104690 <release>
801021ab:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801021b0:	eb b2                	jmp    80102164 <iderw+0x74>
801021b2:	89 d8                	mov    %ebx,%eax
801021b4:	e8 47 fd ff ff       	call   80101f00 <idestart>
801021b9:	eb b3                	jmp    8010216e <iderw+0x7e>
801021bb:	83 ec 0c             	sub    $0xc,%esp
801021be:	68 ca 76 10 80       	push   $0x801076ca
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 f5 76 10 80       	push   $0x801076f5
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 e0 76 10 80       	push   $0x801076e0
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
8010223a:	68 14 77 10 80       	push   $0x80107714
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
801022e3:	56                   	push   %esi
801022e4:	53                   	push   %ebx
801022e5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022e8:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
801022ee:	0f 85 b9 00 00 00    	jne    801023ad <kfree+0xcd>
801022f4:	81 fe a8 e4 14 80    	cmp    $0x8014e4a8,%esi
801022fa:	0f 82 ad 00 00 00    	jb     801023ad <kfree+0xcd>
80102300:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102306:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010230c:	0f 87 9b 00 00 00    	ja     801023ad <kfree+0xcd>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  if(kmem.use_lock)
80102312:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102318:	85 d2                	test   %edx,%edx
8010231a:	75 7c                	jne    80102398 <kfree+0xb8>
    acquire(&kmem.lock);
  if(kmem.pageRefCount[V2P(v)>>PGSHIFT] <=0)
8010231c:	c1 eb 0c             	shr    $0xc,%ebx
8010231f:	83 c3 0c             	add    $0xc,%ebx
80102322:	8b 04 9d 4c 36 11 80 	mov    -0x7feec9b4(,%ebx,4),%eax
80102329:	85 c0                	test   %eax,%eax
8010232b:	74 3b                	je     80102368 <kfree+0x88>
     kmem.pageRefCount[V2P(v)>>PGSHIFT] = 0;
     kmem.freelist = r;
  }
  else
  {
    kmem.pageRefCount[V2P(v)>>PGSHIFT]--;
8010232d:	83 e8 01             	sub    $0x1,%eax
80102330:	89 04 9d 4c 36 11 80 	mov    %eax,-0x7feec9b4(,%ebx,4)
  }
  if(kmem.use_lock)
80102337:	a1 74 36 11 80       	mov    0x80113674,%eax
8010233c:	85 c0                	test   %eax,%eax
8010233e:	75 10                	jne    80102350 <kfree+0x70>
    release(&kmem.lock);


}
80102340:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102343:	5b                   	pop    %ebx
80102344:	5e                   	pop    %esi
80102345:	5d                   	pop    %ebp
80102346:	c3                   	ret    
80102347:	89 f6                	mov    %esi,%esi
80102349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  else
  {
    kmem.pageRefCount[V2P(v)>>PGSHIFT]--;
  }
  if(kmem.use_lock)
    release(&kmem.lock);
80102350:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)


}
80102357:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010235a:	5b                   	pop    %ebx
8010235b:	5e                   	pop    %esi
8010235c:	5d                   	pop    %ebp
  else
  {
    kmem.pageRefCount[V2P(v)>>PGSHIFT]--;
  }
  if(kmem.use_lock)
    release(&kmem.lock);
8010235d:	e9 2e 23 00 00       	jmp    80104690 <release>
80102362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  // Fill with junk to catch dangling refs.
  if(kmem.use_lock)
    acquire(&kmem.lock);
  if(kmem.pageRefCount[V2P(v)>>PGSHIFT] <=0)
  {
     memset(v, 1, PGSIZE);
80102368:	83 ec 04             	sub    $0x4,%esp
8010236b:	68 00 10 00 00       	push   $0x1000
80102370:	6a 01                	push   $0x1
80102372:	56                   	push   %esi
80102373:	e8 68 23 00 00       	call   801046e0 <memset>
     r = (struct run*)v;
     r->next = kmem.freelist;
80102378:	a1 78 36 11 80       	mov    0x80113678,%eax
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	89 06                	mov    %eax,(%esi)
     kmem.pageRefCount[V2P(v)>>PGSHIFT] = 0;
80102382:	c7 04 9d 4c 36 11 80 	movl   $0x0,-0x7feec9b4(,%ebx,4)
80102389:	00 00 00 00 
     kmem.freelist = r;
8010238d:	89 35 78 36 11 80    	mov    %esi,0x80113678
80102393:	eb a2                	jmp    80102337 <kfree+0x57>
80102395:	8d 76 00             	lea    0x0(%esi),%esi
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  if(kmem.use_lock)
    acquire(&kmem.lock);
80102398:	83 ec 0c             	sub    $0xc,%esp
8010239b:	68 40 36 11 80       	push   $0x80113640
801023a0:	e8 cb 21 00 00       	call   80104570 <acquire>
801023a5:	83 c4 10             	add    $0x10,%esp
801023a8:	e9 6f ff ff ff       	jmp    8010231c <kfree+0x3c>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023ad:	83 ec 0c             	sub    $0xc,%esp
801023b0:	68 46 77 10 80       	push   $0x80107746
801023b5:	e8 b6 df ff ff       	call   80100370 <panic>
801023ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023c0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 37                	jb     80102418 <freerange+0x58>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801023e8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801023ee:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801023f1:	c1 e8 0c             	shr    $0xc,%eax
801023f4:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
801023fb:	00 00 00 00 
    kfree(p);
801023ff:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102405:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
8010240b:	50                   	push   %eax
8010240c:	e8 cf fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102411:	83 c4 10             	add    $0x10,%esp
80102414:	39 f3                	cmp    %esi,%ebx
80102416:	76 d0                	jbe    801023e8 <freerange+0x28>
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
    
  }
}
80102418:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010241b:	5b                   	pop    %ebx
8010241c:	5e                   	pop    %esi
8010241d:	5d                   	pop    %ebp
8010241e:	c3                   	ret    
8010241f:	90                   	nop

80102420 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 4c 77 10 80       	push   $0x8010774c
80102430:	68 40 36 11 80       	push   $0x80113640
80102435:	e8 36 20 00 00       	call   80104470 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010243d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102440:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102447:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 30                	jb     80102490 <kinit1+0x70>
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
80102460:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
80102466:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
80102469:	c1 e8 0c             	shr    $0xc,%eax
8010246c:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
80102473:	00 00 00 00 
    kfree(p);
80102477:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010247d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
80102483:	50                   	push   %eax
80102484:	e8 57 fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102489:	83 c4 10             	add    $0x10,%esp
8010248c:	39 de                	cmp    %ebx,%esi
8010248e:	73 d0                	jae    80102460 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
80102490:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102493:	5b                   	pop    %ebx
80102494:	5e                   	pop    %esi
80102495:	5d                   	pop    %ebp
80102496:	c3                   	ret    
80102497:	89 f6                	mov    %esi,%esi
80102499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024a0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024a5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801024a8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024bd:	39 de                	cmp    %ebx,%esi
801024bf:	72 37                	jb     801024f8 <kinit2+0x58>
801024c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801024c8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801024ce:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801024d1:	c1 e8 0c             	shr    $0xc,%eax
801024d4:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
801024db:	00 00 00 00 
    kfree(p);
801024df:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024e5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
801024eb:	50                   	push   %eax
801024ec:	e8 ef fd ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024f1:	83 c4 10             	add    $0x10,%esp
801024f4:	39 de                	cmp    %ebx,%esi
801024f6:	73 d0                	jae    801024c8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024f8:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
801024ff:	00 00 00 
}
80102502:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102505:	5b                   	pop    %ebx
80102506:	5e                   	pop    %esi
80102507:	5d                   	pop    %ebp
80102508:	c3                   	ret    
80102509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102510 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	53                   	push   %ebx
80102514:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102517:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010251d:	85 d2                	test   %edx,%edx
8010251f:	75 47                	jne    80102568 <kalloc+0x58>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102521:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r){
80102527:	85 db                	test   %ebx,%ebx
80102529:	74 2f                	je     8010255a <kalloc+0x4a>
    kmem.pageRefCount[V2P((char*)r)>>PGSHIFT] = 1; 
8010252b:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102531:	c1 e8 0c             	shr    $0xc,%eax
80102534:	c7 04 85 7c 36 11 80 	movl   $0x1,-0x7feec984(,%eax,4)
8010253b:	01 00 00 00 
    kmem.freelist = r->next;
8010253f:	8b 03                	mov    (%ebx),%eax
80102541:	a3 78 36 11 80       	mov    %eax,0x80113678
    }
  if(kmem.use_lock)
80102546:	85 d2                	test   %edx,%edx
80102548:	74 10                	je     8010255a <kalloc+0x4a>
    release(&kmem.lock);
8010254a:	83 ec 0c             	sub    $0xc,%esp
8010254d:	68 40 36 11 80       	push   $0x80113640
80102552:	e8 39 21 00 00       	call   80104690 <release>
80102557:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
8010255a:	89 d8                	mov    %ebx,%eax
8010255c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010255f:	c9                   	leave  
80102560:	c3                   	ret    
80102561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102568:	83 ec 0c             	sub    $0xc,%esp
8010256b:	68 40 36 11 80       	push   $0x80113640
80102570:	e8 fb 1f 00 00       	call   80104570 <acquire>
  r = kmem.freelist;
80102575:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r){
8010257b:	83 c4 10             	add    $0x10,%esp
8010257e:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102584:	85 db                	test   %ebx,%ebx
80102586:	75 a3                	jne    8010252b <kalloc+0x1b>
80102588:	eb bc                	jmp    80102546 <kalloc+0x36>
8010258a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102590 <addRefCount>:
  return (char*)r;
}

void
addRefCount(uint value)
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	53                   	push   %ebx
80102594:	83 ec 04             	sub    $0x4,%esp
80102597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010259a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
801025a0:	72 33                	jb     801025d5 <addRefCount+0x45>
801025a2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
801025a8:	77 2b                	ja     801025d5 <addRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
801025aa:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])++;
801025ad:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
801025b0:	68 40 36 11 80       	push   $0x80113640
801025b5:	e8 b6 1f 00 00       	call   80104570 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])++;
801025ba:	83 04 9d 7c 36 11 80 	addl   $0x1,-0x7feec984(,%ebx,4)
801025c1:	01 
  release(&kmem.lock);   
801025c2:	83 c4 10             	add    $0x10,%esp
801025c5:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
801025cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025cf:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])++;
  release(&kmem.lock);   
801025d0:	e9 bb 20 00 00       	jmp    80104690 <release>
void
addRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
801025d5:	83 ec 0c             	sub    $0xc,%esp
801025d8:	68 51 77 10 80       	push   $0x80107751
801025dd:	e8 8e dd ff ff       	call   80100370 <panic>
801025e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025f0 <minusRefCount>:

}

void
minusRefCount(uint value)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	53                   	push   %ebx
801025f4:	83 ec 04             	sub    $0x4,%esp
801025f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
801025fa:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
80102600:	72 33                	jb     80102635 <minusRefCount+0x45>
80102602:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102608:	77 2b                	ja     80102635 <minusRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
8010260a:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010260d:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
80102610:	68 40 36 11 80       	push   $0x80113640
80102615:	e8 56 1f 00 00       	call   80104570 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010261a:	83 2c 9d 7c 36 11 80 	subl   $0x1,-0x7feec984(,%ebx,4)
80102621:	01 
  release(&kmem.lock);   
80102622:	83 c4 10             	add    $0x10,%esp
80102625:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
8010262c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010262f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])--;
  release(&kmem.lock);   
80102630:	e9 5b 20 00 00       	jmp    80104690 <release>
void
minusRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102635:	83 ec 0c             	sub    $0xc,%esp
80102638:	68 51 77 10 80       	push   $0x80107751
8010263d:	e8 2e dd ff ff       	call   80100370 <panic>
80102642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102650 <getRefCount>:

}

uint
getRefCount(uint value)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	53                   	push   %ebx
80102654:	83 ec 04             	sub    $0x4,%esp
80102657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010265a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
80102660:	72 32                	jb     80102694 <getRefCount+0x44>
80102662:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102668:	77 2a                	ja     80102694 <getRefCount+0x44>
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
8010266a:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pageRefCount[value>>PGSHIFT];  
8010266d:	c1 eb 0c             	shr    $0xc,%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
80102670:	68 40 36 11 80       	push   $0x80113640
80102675:	e8 f6 1e 00 00       	call   80104570 <acquire>
  count = kmem.pageRefCount[value>>PGSHIFT];  
8010267a:	8b 1c 9d 7c 36 11 80 	mov    -0x7feec984(,%ebx,4),%ebx
  release(&kmem.lock);
80102681:	c7 04 24 40 36 11 80 	movl   $0x80113640,(%esp)
80102688:	e8 03 20 00 00       	call   80104690 <release>
     
  return count;
}
8010268d:	89 d8                	mov    %ebx,%eax
8010268f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102692:	c9                   	leave  
80102693:	c3                   	ret    
uint
getRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102694:	83 ec 0c             	sub    $0xc,%esp
80102697:	68 51 77 10 80       	push   $0x80107751
8010269c:	e8 cf dc ff ff       	call   80100370 <panic>
801026a1:	66 90                	xchg   %ax,%ax
801026a3:	66 90                	xchg   %ax,%ax
801026a5:	66 90                	xchg   %ax,%ax
801026a7:	66 90                	xchg   %ax,%ax
801026a9:	66 90                	xchg   %ax,%ax
801026ab:	66 90                	xchg   %ax,%ax
801026ad:	66 90                	xchg   %ax,%ax
801026af:	90                   	nop

801026b0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026b0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026b1:	ba 64 00 00 00       	mov    $0x64,%edx
801026b6:	89 e5                	mov    %esp,%ebp
801026b8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026b9:	a8 01                	test   $0x1,%al
801026bb:	0f 84 af 00 00 00    	je     80102770 <kbdgetc+0xc0>
801026c1:	ba 60 00 00 00       	mov    $0x60,%edx
801026c6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026c7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801026ca:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026d0:	74 7e                	je     80102750 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026d2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026d4:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026da:	79 24                	jns    80102700 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026dc:	f6 c1 40             	test   $0x40,%cl
801026df:	75 05                	jne    801026e6 <kbdgetc+0x36>
801026e1:	89 c2                	mov    %eax,%edx
801026e3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801026e6:	0f b6 82 a0 78 10 80 	movzbl -0x7fef8760(%edx),%eax
801026ed:	83 c8 40             	or     $0x40,%eax
801026f0:	0f b6 c0             	movzbl %al,%eax
801026f3:	f7 d0                	not    %eax
801026f5:	21 c8                	and    %ecx,%eax
801026f7:	a3 b4 b5 10 80       	mov    %eax,0x8010b5b4
    return 0;
801026fc:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026fe:	5d                   	pop    %ebp
801026ff:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102700:	f6 c1 40             	test   $0x40,%cl
80102703:	74 09                	je     8010270e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102705:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102708:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010270b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010270e:	0f b6 82 a0 78 10 80 	movzbl -0x7fef8760(%edx),%eax
80102715:	09 c1                	or     %eax,%ecx
80102717:	0f b6 82 a0 77 10 80 	movzbl -0x7fef8860(%edx),%eax
8010271e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102720:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102722:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102728:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010272b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010272e:	8b 04 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%eax
80102735:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102739:	74 c3                	je     801026fe <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010273b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010273e:	83 fa 19             	cmp    $0x19,%edx
80102741:	77 1d                	ja     80102760 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102743:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102746:	5d                   	pop    %ebp
80102747:	c3                   	ret    
80102748:	90                   	nop
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102750:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102752:	83 0d b4 b5 10 80 40 	orl    $0x40,0x8010b5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102759:	5d                   	pop    %ebp
8010275a:	c3                   	ret    
8010275b:	90                   	nop
8010275c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102760:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102763:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102766:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102767:	83 f9 19             	cmp    $0x19,%ecx
8010276a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010276d:	c3                   	ret    
8010276e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102775:	5d                   	pop    %ebp
80102776:	c3                   	ret    
80102777:	89 f6                	mov    %esi,%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <kbdintr>:

void
kbdintr(void)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102786:	68 b0 26 10 80       	push   $0x801026b0
8010278b:	e8 60 e0 ff ff       	call   801007f0 <consoleintr>
}
80102790:	83 c4 10             	add    $0x10,%esp
80102793:	c9                   	leave  
80102794:	c3                   	ret    
80102795:	66 90                	xchg   %ax,%ax
80102797:	66 90                	xchg   %ax,%ax
80102799:	66 90                	xchg   %ax,%ax
8010279b:	66 90                	xchg   %ax,%ax
8010279d:	66 90                	xchg   %ax,%ax
8010279f:	90                   	nop

801027a0 <lapicinit>:
801027a0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801027a5:	55                   	push   %ebp
801027a6:	89 e5                	mov    %esp,%ebp
801027a8:	85 c0                	test   %eax,%eax
801027aa:	0f 84 c8 00 00 00    	je     80102878 <lapicinit+0xd8>
801027b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027b7:	01 00 00 
801027ba:	8b 50 20             	mov    0x20(%eax),%edx
801027bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027c4:	00 00 00 
801027c7:	8b 50 20             	mov    0x20(%eax),%edx
801027ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027d1:	00 02 00 
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
801027d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027de:	96 98 00 
801027e1:	8b 50 20             	mov    0x20(%eax),%edx
801027e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027eb:	00 01 00 
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
801027f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801027f8:	00 01 00 
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
801027fe:	8b 50 30             	mov    0x30(%eax),%edx
80102801:	c1 ea 10             	shr    $0x10,%edx
80102804:	80 fa 03             	cmp    $0x3,%dl
80102807:	77 77                	ja     80102880 <lapicinit+0xe0>
80102809:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102810:	00 00 00 
80102813:	8b 50 20             	mov    0x20(%eax),%edx
80102816:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010281d:	00 00 00 
80102820:	8b 50 20             	mov    0x20(%eax),%edx
80102823:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282a:	00 00 00 
8010282d:	8b 50 20             	mov    0x20(%eax),%edx
80102830:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102837:	00 00 00 
8010283a:	8b 50 20             	mov    0x20(%eax),%edx
8010283d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102844:	00 00 00 
80102847:	8b 50 20             	mov    0x20(%eax),%edx
8010284a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102851:	85 08 00 
80102854:	8b 50 20             	mov    0x20(%eax),%edx
80102857:	89 f6                	mov    %esi,%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102860:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102866:	80 e6 10             	and    $0x10,%dh
80102869:	75 f5                	jne    80102860 <lapicinit+0xc0>
8010286b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102872:	00 00 00 
80102875:	8b 40 20             	mov    0x20(%eax),%eax
80102878:	5d                   	pop    %ebp
80102879:	c3                   	ret    
8010287a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102880:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102887:	00 01 00 
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
8010288d:	e9 77 ff ff ff       	jmp    80102809 <lapicinit+0x69>
80102892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028a0 <lapicid>:
801028a0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801028a5:	55                   	push   %ebp
801028a6:	89 e5                	mov    %esp,%ebp
801028a8:	85 c0                	test   %eax,%eax
801028aa:	74 0c                	je     801028b8 <lapicid+0x18>
801028ac:	8b 40 20             	mov    0x20(%eax),%eax
801028af:	5d                   	pop    %ebp
801028b0:	c1 e8 18             	shr    $0x18,%eax
801028b3:	c3                   	ret    
801028b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028b8:	31 c0                	xor    %eax,%eax
801028ba:	5d                   	pop    %ebp
801028bb:	c3                   	ret    
801028bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028c0 <lapiceoi>:
801028c0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801028c5:	55                   	push   %ebp
801028c6:	89 e5                	mov    %esp,%ebp
801028c8:	85 c0                	test   %eax,%eax
801028ca:	74 0d                	je     801028d9 <lapiceoi+0x19>
801028cc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028d3:	00 00 00 
801028d6:	8b 40 20             	mov    0x20(%eax),%eax
801028d9:	5d                   	pop    %ebp
801028da:	c3                   	ret    
801028db:	90                   	nop
801028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028e0 <microdelay>:
801028e0:	55                   	push   %ebp
801028e1:	89 e5                	mov    %esp,%ebp
801028e3:	5d                   	pop    %ebp
801028e4:	c3                   	ret    
801028e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028f0 <lapicstartap>:
801028f0:	55                   	push   %ebp
801028f1:	ba 70 00 00 00       	mov    $0x70,%edx
801028f6:	b8 0f 00 00 00       	mov    $0xf,%eax
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	53                   	push   %ebx
801028fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102901:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102904:	ee                   	out    %al,(%dx)
80102905:	ba 71 00 00 00       	mov    $0x71,%edx
8010290a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010290f:	ee                   	out    %al,(%dx)
80102910:	31 c0                	xor    %eax,%eax
80102912:	c1 e3 18             	shl    $0x18,%ebx
80102915:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010291b:	89 c8                	mov    %ecx,%eax
8010291d:	c1 e9 0c             	shr    $0xc,%ecx
80102920:	c1 e8 04             	shr    $0x4,%eax
80102923:	89 da                	mov    %ebx,%edx
80102925:	80 cd 06             	or     $0x6,%ch
80102928:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010292e:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
80102933:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102939:	8b 58 20             	mov    0x20(%eax),%ebx
8010293c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102943:	c5 00 00 
80102946:	8b 58 20             	mov    0x20(%eax),%ebx
80102949:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102950:	85 00 00 
80102953:	8b 58 20             	mov    0x20(%eax),%ebx
80102956:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010295c:	8b 58 20             	mov    0x20(%eax),%ebx
8010295f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102965:	8b 58 20             	mov    0x20(%eax),%ebx
80102968:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010296e:	8b 50 20             	mov    0x20(%eax),%edx
80102971:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102977:	8b 40 20             	mov    0x20(%eax),%eax
8010297a:	5b                   	pop    %ebx
8010297b:	5d                   	pop    %ebp
8010297c:	c3                   	ret    
8010297d:	8d 76 00             	lea    0x0(%esi),%esi

80102980 <cmostime>:
80102980:	55                   	push   %ebp
80102981:	ba 70 00 00 00       	mov    $0x70,%edx
80102986:	b8 0b 00 00 00       	mov    $0xb,%eax
8010298b:	89 e5                	mov    %esp,%ebp
8010298d:	57                   	push   %edi
8010298e:	56                   	push   %esi
8010298f:	53                   	push   %ebx
80102990:	83 ec 4c             	sub    $0x4c,%esp
80102993:	ee                   	out    %al,(%dx)
80102994:	ba 71 00 00 00       	mov    $0x71,%edx
80102999:	ec                   	in     (%dx),%al
8010299a:	83 e0 04             	and    $0x4,%eax
8010299d:	8d 75 d0             	lea    -0x30(%ebp),%esi
801029a0:	31 db                	xor    %ebx,%ebx
801029a2:	88 45 b7             	mov    %al,-0x49(%ebp)
801029a5:	bf 70 00 00 00       	mov    $0x70,%edi
801029aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029b0:	89 d8                	mov    %ebx,%eax
801029b2:	89 fa                	mov    %edi,%edx
801029b4:	ee                   	out    %al,(%dx)
801029b5:	b9 71 00 00 00       	mov    $0x71,%ecx
801029ba:	89 ca                	mov    %ecx,%edx
801029bc:	ec                   	in     (%dx),%al
801029bd:	0f b6 c0             	movzbl %al,%eax
801029c0:	89 fa                	mov    %edi,%edx
801029c2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029c5:	b8 02 00 00 00       	mov    $0x2,%eax
801029ca:	ee                   	out    %al,(%dx)
801029cb:	89 ca                	mov    %ecx,%edx
801029cd:	ec                   	in     (%dx),%al
801029ce:	0f b6 c0             	movzbl %al,%eax
801029d1:	89 fa                	mov    %edi,%edx
801029d3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029d6:	b8 04 00 00 00       	mov    $0x4,%eax
801029db:	ee                   	out    %al,(%dx)
801029dc:	89 ca                	mov    %ecx,%edx
801029de:	ec                   	in     (%dx),%al
801029df:	0f b6 c0             	movzbl %al,%eax
801029e2:	89 fa                	mov    %edi,%edx
801029e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029e7:	b8 07 00 00 00       	mov    $0x7,%eax
801029ec:	ee                   	out    %al,(%dx)
801029ed:	89 ca                	mov    %ecx,%edx
801029ef:	ec                   	in     (%dx),%al
801029f0:	0f b6 c0             	movzbl %al,%eax
801029f3:	89 fa                	mov    %edi,%edx
801029f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029f8:	b8 08 00 00 00       	mov    $0x8,%eax
801029fd:	ee                   	out    %al,(%dx)
801029fe:	89 ca                	mov    %ecx,%edx
80102a00:	ec                   	in     (%dx),%al
80102a01:	0f b6 c0             	movzbl %al,%eax
80102a04:	89 fa                	mov    %edi,%edx
80102a06:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102a09:	b8 09 00 00 00       	mov    $0x9,%eax
80102a0e:	ee                   	out    %al,(%dx)
80102a0f:	89 ca                	mov    %ecx,%edx
80102a11:	ec                   	in     (%dx),%al
80102a12:	0f b6 c0             	movzbl %al,%eax
80102a15:	89 fa                	mov    %edi,%edx
80102a17:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102a1a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a1f:	ee                   	out    %al,(%dx)
80102a20:	89 ca                	mov    %ecx,%edx
80102a22:	ec                   	in     (%dx),%al
80102a23:	84 c0                	test   %al,%al
80102a25:	78 89                	js     801029b0 <cmostime+0x30>
80102a27:	89 d8                	mov    %ebx,%eax
80102a29:	89 fa                	mov    %edi,%edx
80102a2b:	ee                   	out    %al,(%dx)
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
80102a2f:	0f b6 c0             	movzbl %al,%eax
80102a32:	89 fa                	mov    %edi,%edx
80102a34:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a37:	b8 02 00 00 00       	mov    $0x2,%eax
80102a3c:	ee                   	out    %al,(%dx)
80102a3d:	89 ca                	mov    %ecx,%edx
80102a3f:	ec                   	in     (%dx),%al
80102a40:	0f b6 c0             	movzbl %al,%eax
80102a43:	89 fa                	mov    %edi,%edx
80102a45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a48:	b8 04 00 00 00       	mov    $0x4,%eax
80102a4d:	ee                   	out    %al,(%dx)
80102a4e:	89 ca                	mov    %ecx,%edx
80102a50:	ec                   	in     (%dx),%al
80102a51:	0f b6 c0             	movzbl %al,%eax
80102a54:	89 fa                	mov    %edi,%edx
80102a56:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a59:	b8 07 00 00 00       	mov    $0x7,%eax
80102a5e:	ee                   	out    %al,(%dx)
80102a5f:	89 ca                	mov    %ecx,%edx
80102a61:	ec                   	in     (%dx),%al
80102a62:	0f b6 c0             	movzbl %al,%eax
80102a65:	89 fa                	mov    %edi,%edx
80102a67:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a6a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a6f:	ee                   	out    %al,(%dx)
80102a70:	89 ca                	mov    %ecx,%edx
80102a72:	ec                   	in     (%dx),%al
80102a73:	0f b6 c0             	movzbl %al,%eax
80102a76:	89 fa                	mov    %edi,%edx
80102a78:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a7b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a80:	ee                   	out    %al,(%dx)
80102a81:	89 ca                	mov    %ecx,%edx
80102a83:	ec                   	in     (%dx),%al
80102a84:	0f b6 c0             	movzbl %al,%eax
80102a87:	83 ec 04             	sub    $0x4,%esp
80102a8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102a8d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a90:	6a 18                	push   $0x18
80102a92:	56                   	push   %esi
80102a93:	50                   	push   %eax
80102a94:	e8 97 1c 00 00       	call   80104730 <memcmp>
80102a99:	83 c4 10             	add    $0x10,%esp
80102a9c:	85 c0                	test   %eax,%eax
80102a9e:	0f 85 0c ff ff ff    	jne    801029b0 <cmostime+0x30>
80102aa4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102aa8:	75 78                	jne    80102b22 <cmostime+0x1a2>
80102aaa:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aad:	89 c2                	mov    %eax,%edx
80102aaf:	83 e0 0f             	and    $0xf,%eax
80102ab2:	c1 ea 04             	shr    $0x4,%edx
80102ab5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ab8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102abb:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102abe:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ac1:	89 c2                	mov    %eax,%edx
80102ac3:	83 e0 0f             	and    $0xf,%eax
80102ac6:	c1 ea 04             	shr    $0x4,%edx
80102ac9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102acc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102acf:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ad2:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ad5:	89 c2                	mov    %eax,%edx
80102ad7:	83 e0 0f             	and    $0xf,%eax
80102ada:	c1 ea 04             	shr    $0x4,%edx
80102add:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ae0:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ae3:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ae6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ae9:	89 c2                	mov    %eax,%edx
80102aeb:	83 e0 0f             	and    $0xf,%eax
80102aee:	c1 ea 04             	shr    $0x4,%edx
80102af1:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af4:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102afa:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102afd:	89 c2                	mov    %eax,%edx
80102aff:	83 e0 0f             	and    $0xf,%eax
80102b02:	c1 ea 04             	shr    $0x4,%edx
80102b05:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b08:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b0b:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b0e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b11:	89 c2                	mov    %eax,%edx
80102b13:	83 e0 0f             	and    $0xf,%eax
80102b16:	c1 ea 04             	shr    $0x4,%edx
80102b19:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1f:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102b22:	8b 75 08             	mov    0x8(%ebp),%esi
80102b25:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b28:	89 06                	mov    %eax,(%esi)
80102b2a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b2d:	89 46 04             	mov    %eax,0x4(%esi)
80102b30:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b33:	89 46 08             	mov    %eax,0x8(%esi)
80102b36:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b39:	89 46 0c             	mov    %eax,0xc(%esi)
80102b3c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b3f:	89 46 10             	mov    %eax,0x10(%esi)
80102b42:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b45:	89 46 14             	mov    %eax,0x14(%esi)
80102b48:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
80102b4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b52:	5b                   	pop    %ebx
80102b53:	5e                   	pop    %esi
80102b54:	5f                   	pop    %edi
80102b55:	5d                   	pop    %ebp
80102b56:	c3                   	ret    
80102b57:	66 90                	xchg   %ax,%ax
80102b59:	66 90                	xchg   %ax,%ax
80102b5b:	66 90                	xchg   %ax,%ax
80102b5d:	66 90                	xchg   %ax,%ax
80102b5f:	90                   	nop

80102b60 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b60:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
80102b66:	85 c9                	test   %ecx,%ecx
80102b68:	0f 8e 85 00 00 00    	jle    80102bf3 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102b6e:	55                   	push   %ebp
80102b6f:	89 e5                	mov    %esp,%ebp
80102b71:	57                   	push   %edi
80102b72:	56                   	push   %esi
80102b73:	53                   	push   %ebx
80102b74:	31 db                	xor    %ebx,%ebx
80102b76:	83 ec 0c             	sub    $0xc,%esp
80102b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b80:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102b85:	83 ec 08             	sub    $0x8,%esp
80102b88:	01 d8                	add    %ebx,%eax
80102b8a:	83 c0 01             	add    $0x1,%eax
80102b8d:	50                   	push   %eax
80102b8e:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102b94:	e8 37 d5 ff ff       	call   801000d0 <bread>
80102b99:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b9b:	58                   	pop    %eax
80102b9c:	5a                   	pop    %edx
80102b9d:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102ba4:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102baa:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bad:	e8 1e d5 ff ff       	call   801000d0 <bread>
80102bb2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bb4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bb7:	83 c4 0c             	add    $0xc,%esp
80102bba:	68 00 02 00 00       	push   $0x200
80102bbf:	50                   	push   %eax
80102bc0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bc3:	50                   	push   %eax
80102bc4:	e8 c7 1b 00 00       	call   80104790 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bc9:	89 34 24             	mov    %esi,(%esp)
80102bcc:	e8 cf d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102bd1:	89 3c 24             	mov    %edi,(%esp)
80102bd4:	e8 07 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 ff d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102be1:	83 c4 10             	add    $0x10,%esp
80102be4:	39 1d c8 b6 14 80    	cmp    %ebx,0x8014b6c8
80102bea:	7f 94                	jg     80102b80 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bef:	5b                   	pop    %ebx
80102bf0:	5e                   	pop    %esi
80102bf1:	5f                   	pop    %edi
80102bf2:	5d                   	pop    %ebp
80102bf3:	f3 c3                	repz ret 
80102bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c00 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	53                   	push   %ebx
80102c04:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c07:	ff 35 b4 b6 14 80    	pushl  0x8014b6b4
80102c0d:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102c13:	e8 b8 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c18:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c1e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c21:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c23:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c25:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c28:	7e 1f                	jle    80102c49 <write_head+0x49>
80102c2a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102c31:	31 d2                	xor    %edx,%edx
80102c33:	90                   	nop
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c38:	8b 8a cc b6 14 80    	mov    -0x7feb4934(%edx),%ecx
80102c3e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102c42:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c45:	39 c2                	cmp    %eax,%edx
80102c47:	75 ef                	jne    80102c38 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c49:	83 ec 0c             	sub    $0xc,%esp
80102c4c:	53                   	push   %ebx
80102c4d:	e8 4e d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c52:	89 1c 24             	mov    %ebx,(%esp)
80102c55:	e8 86 d5 ff ff       	call   801001e0 <brelse>
}
80102c5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c5d:	c9                   	leave  
80102c5e:	c3                   	ret    
80102c5f:	90                   	nop

80102c60 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	53                   	push   %ebx
80102c64:	83 ec 2c             	sub    $0x2c,%esp
80102c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102c6a:	68 a0 79 10 80       	push   $0x801079a0
80102c6f:	68 80 b6 14 80       	push   $0x8014b680
80102c74:	e8 f7 17 00 00       	call   80104470 <initlock>
  readsb(dev, &sb);
80102c79:	58                   	pop    %eax
80102c7a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c7d:	5a                   	pop    %edx
80102c7e:	50                   	push   %eax
80102c7f:	53                   	push   %ebx
80102c80:	e8 2b e7 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c85:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c88:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c8b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102c8c:	89 1d c4 b6 14 80    	mov    %ebx,0x8014b6c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c92:	89 15 b8 b6 14 80    	mov    %edx,0x8014b6b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c98:	a3 b4 b6 14 80       	mov    %eax,0x8014b6b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c9d:	5a                   	pop    %edx
80102c9e:	50                   	push   %eax
80102c9f:	53                   	push   %ebx
80102ca0:	e8 2b d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ca5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ca8:	83 c4 10             	add    $0x10,%esp
80102cab:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cad:	89 0d c8 b6 14 80    	mov    %ecx,0x8014b6c8
  for (i = 0; i < log.lh.n; i++) {
80102cb3:	7e 1c                	jle    80102cd1 <initlog+0x71>
80102cb5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102cbc:	31 d2                	xor    %edx,%edx
80102cbe:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102cc0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cc4:	83 c2 04             	add    $0x4,%edx
80102cc7:	89 8a c8 b6 14 80    	mov    %ecx,-0x7feb4938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102ccd:	39 da                	cmp    %ebx,%edx
80102ccf:	75 ef                	jne    80102cc0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102cd1:	83 ec 0c             	sub    $0xc,%esp
80102cd4:	50                   	push   %eax
80102cd5:	e8 06 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cda:	e8 81 fe ff ff       	call   80102b60 <install_trans>
  log.lh.n = 0;
80102cdf:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
80102ce6:	00 00 00 
  write_head(); // clear the log
80102ce9:	e8 12 ff ff ff       	call   80102c00 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102cee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cf1:	c9                   	leave  
80102cf2:	c3                   	ret    
80102cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d00 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d06:	68 80 b6 14 80       	push   $0x8014b680
80102d0b:	e8 60 18 00 00       	call   80104570 <acquire>
80102d10:	83 c4 10             	add    $0x10,%esp
80102d13:	eb 18                	jmp    80102d2d <begin_op+0x2d>
80102d15:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d18:	83 ec 08             	sub    $0x8,%esp
80102d1b:	68 80 b6 14 80       	push   $0x8014b680
80102d20:	68 80 b6 14 80       	push   $0x8014b680
80102d25:	e8 d6 12 00 00       	call   80104000 <sleep>
80102d2a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102d2d:	a1 c0 b6 14 80       	mov    0x8014b6c0,%eax
80102d32:	85 c0                	test   %eax,%eax
80102d34:	75 e2                	jne    80102d18 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d36:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102d3b:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
80102d41:	83 c0 01             	add    $0x1,%eax
80102d44:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d47:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d4a:	83 fa 1e             	cmp    $0x1e,%edx
80102d4d:	7f c9                	jg     80102d18 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d4f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102d52:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
      release(&log.lock);
80102d57:	68 80 b6 14 80       	push   $0x8014b680
80102d5c:	e8 2f 19 00 00       	call   80104690 <release>
      break;
    }
  }
}
80102d61:	83 c4 10             	add    $0x10,%esp
80102d64:	c9                   	leave  
80102d65:	c3                   	ret    
80102d66:	8d 76 00             	lea    0x0(%esi),%esi
80102d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d70 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	57                   	push   %edi
80102d74:	56                   	push   %esi
80102d75:	53                   	push   %ebx
80102d76:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d79:	68 80 b6 14 80       	push   $0x8014b680
80102d7e:	e8 ed 17 00 00       	call   80104570 <acquire>
  log.outstanding -= 1;
80102d83:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
  if(log.committing)
80102d88:	8b 1d c0 b6 14 80    	mov    0x8014b6c0,%ebx
80102d8e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d91:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102d94:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d96:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
  if(log.committing)
80102d9b:	0f 85 23 01 00 00    	jne    80102ec4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102da1:	85 c0                	test   %eax,%eax
80102da3:	0f 85 f7 00 00 00    	jne    80102ea0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102da9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102dac:	c7 05 c0 b6 14 80 01 	movl   $0x1,0x8014b6c0
80102db3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102db6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102db8:	68 80 b6 14 80       	push   $0x8014b680
80102dbd:	e8 ce 18 00 00       	call   80104690 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dc2:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
80102dc8:	83 c4 10             	add    $0x10,%esp
80102dcb:	85 c9                	test   %ecx,%ecx
80102dcd:	0f 8e 8a 00 00 00    	jle    80102e5d <end_op+0xed>
80102dd3:	90                   	nop
80102dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102dd8:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102ddd:	83 ec 08             	sub    $0x8,%esp
80102de0:	01 d8                	add    %ebx,%eax
80102de2:	83 c0 01             	add    $0x1,%eax
80102de5:	50                   	push   %eax
80102de6:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102dec:	e8 df d2 ff ff       	call   801000d0 <bread>
80102df1:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102df3:	58                   	pop    %eax
80102df4:	5a                   	pop    %edx
80102df5:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102dfc:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e02:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e05:	e8 c6 d2 ff ff       	call   801000d0 <bread>
80102e0a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e0c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e0f:	83 c4 0c             	add    $0xc,%esp
80102e12:	68 00 02 00 00       	push   $0x200
80102e17:	50                   	push   %eax
80102e18:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e1b:	50                   	push   %eax
80102e1c:	e8 6f 19 00 00       	call   80104790 <memmove>
    bwrite(to);  // write the log
80102e21:	89 34 24             	mov    %esi,(%esp)
80102e24:	e8 77 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e29:	89 3c 24             	mov    %edi,(%esp)
80102e2c:	e8 af d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e31:	89 34 24             	mov    %esi,(%esp)
80102e34:	e8 a7 d3 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e39:	83 c4 10             	add    $0x10,%esp
80102e3c:	3b 1d c8 b6 14 80    	cmp    0x8014b6c8,%ebx
80102e42:	7c 94                	jl     80102dd8 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e44:	e8 b7 fd ff ff       	call   80102c00 <write_head>
    install_trans(); // Now install writes to home locations
80102e49:	e8 12 fd ff ff       	call   80102b60 <install_trans>
    log.lh.n = 0;
80102e4e:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
80102e55:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e58:	e8 a3 fd ff ff       	call   80102c00 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102e5d:	83 ec 0c             	sub    $0xc,%esp
80102e60:	68 80 b6 14 80       	push   $0x8014b680
80102e65:	e8 06 17 00 00       	call   80104570 <acquire>
    log.committing = 0;
    wakeup(&log);
80102e6a:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102e71:	c7 05 c0 b6 14 80 00 	movl   $0x0,0x8014b6c0
80102e78:	00 00 00 
    wakeup(&log);
80102e7b:	e8 30 13 00 00       	call   801041b0 <wakeup>
    release(&log.lock);
80102e80:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102e87:	e8 04 18 00 00       	call   80104690 <release>
80102e8c:	83 c4 10             	add    $0x10,%esp
  }
}
80102e8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e92:	5b                   	pop    %ebx
80102e93:	5e                   	pop    %esi
80102e94:	5f                   	pop    %edi
80102e95:	5d                   	pop    %ebp
80102e96:	c3                   	ret    
80102e97:	89 f6                	mov    %esi,%esi
80102e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102ea0:	83 ec 0c             	sub    $0xc,%esp
80102ea3:	68 80 b6 14 80       	push   $0x8014b680
80102ea8:	e8 03 13 00 00       	call   801041b0 <wakeup>
  }
  release(&log.lock);
80102ead:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102eb4:	e8 d7 17 00 00       	call   80104690 <release>
80102eb9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ebf:	5b                   	pop    %ebx
80102ec0:	5e                   	pop    %esi
80102ec1:	5f                   	pop    %edi
80102ec2:	5d                   	pop    %ebp
80102ec3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102ec4:	83 ec 0c             	sub    $0xc,%esp
80102ec7:	68 a4 79 10 80       	push   $0x801079a4
80102ecc:	e8 9f d4 ff ff       	call   80100370 <panic>
80102ed1:	eb 0d                	jmp    80102ee0 <log_write>
80102ed3:	90                   	nop
80102ed4:	90                   	nop
80102ed5:	90                   	nop
80102ed6:	90                   	nop
80102ed7:	90                   	nop
80102ed8:	90                   	nop
80102ed9:	90                   	nop
80102eda:	90                   	nop
80102edb:	90                   	nop
80102edc:	90                   	nop
80102edd:	90                   	nop
80102ede:	90                   	nop
80102edf:	90                   	nop

80102ee0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ee7:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102eed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ef0:	83 fa 1d             	cmp    $0x1d,%edx
80102ef3:	0f 8f 97 00 00 00    	jg     80102f90 <log_write+0xb0>
80102ef9:	a1 b8 b6 14 80       	mov    0x8014b6b8,%eax
80102efe:	83 e8 01             	sub    $0x1,%eax
80102f01:	39 c2                	cmp    %eax,%edx
80102f03:	0f 8d 87 00 00 00    	jge    80102f90 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f09:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102f0e:	85 c0                	test   %eax,%eax
80102f10:	0f 8e 87 00 00 00    	jle    80102f9d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f16:	83 ec 0c             	sub    $0xc,%esp
80102f19:	68 80 b6 14 80       	push   $0x8014b680
80102f1e:	e8 4d 16 00 00       	call   80104570 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f23:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
80102f29:	83 c4 10             	add    $0x10,%esp
80102f2c:	83 fa 00             	cmp    $0x0,%edx
80102f2f:	7e 50                	jle    80102f81 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f31:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f34:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f36:	3b 0d cc b6 14 80    	cmp    0x8014b6cc,%ecx
80102f3c:	75 0b                	jne    80102f49 <log_write+0x69>
80102f3e:	eb 38                	jmp    80102f78 <log_write+0x98>
80102f40:	39 0c 85 cc b6 14 80 	cmp    %ecx,-0x7feb4934(,%eax,4)
80102f47:	74 2f                	je     80102f78 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f49:	83 c0 01             	add    $0x1,%eax
80102f4c:	39 d0                	cmp    %edx,%eax
80102f4e:	75 f0                	jne    80102f40 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f50:	89 0c 95 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f57:	83 c2 01             	add    $0x1,%edx
80102f5a:	89 15 c8 b6 14 80    	mov    %edx,0x8014b6c8
  b->flags |= B_DIRTY; // prevent eviction
80102f60:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f63:	c7 45 08 80 b6 14 80 	movl   $0x8014b680,0x8(%ebp)
}
80102f6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f6d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102f6e:	e9 1d 17 00 00       	jmp    80104690 <release>
80102f73:	90                   	nop
80102f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f78:	89 0c 85 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%eax,4)
80102f7f:	eb df                	jmp    80102f60 <log_write+0x80>
80102f81:	8b 43 08             	mov    0x8(%ebx),%eax
80102f84:	a3 cc b6 14 80       	mov    %eax,0x8014b6cc
  if (i == log.lh.n)
80102f89:	75 d5                	jne    80102f60 <log_write+0x80>
80102f8b:	eb ca                	jmp    80102f57 <log_write+0x77>
80102f8d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102f90:	83 ec 0c             	sub    $0xc,%esp
80102f93:	68 b3 79 10 80       	push   $0x801079b3
80102f98:	e8 d3 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102f9d:	83 ec 0c             	sub    $0xc,%esp
80102fa0:	68 c9 79 10 80       	push   $0x801079c9
80102fa5:	e8 c6 d3 ff ff       	call   80100370 <panic>
80102faa:	66 90                	xchg   %ax,%ax
80102fac:	66 90                	xchg   %ax,%ax
80102fae:	66 90                	xchg   %ax,%ax

80102fb0 <mpmain>:
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 04             	sub    $0x4,%esp
80102fb7:	e8 54 09 00 00       	call   80103910 <cpuid>
80102fbc:	89 c3                	mov    %eax,%ebx
80102fbe:	e8 4d 09 00 00       	call   80103910 <cpuid>
80102fc3:	83 ec 04             	sub    $0x4,%esp
80102fc6:	53                   	push   %ebx
80102fc7:	50                   	push   %eax
80102fc8:	68 e4 79 10 80       	push   $0x801079e4
80102fcd:	e8 8e d6 ff ff       	call   80100660 <cprintf>
80102fd2:	e8 99 2a 00 00       	call   80105a70 <idtinit>
80102fd7:	e8 b4 08 00 00       	call   80103890 <mycpu>
80102fdc:	89 c2                	mov    %eax,%edx
80102fde:	b8 01 00 00 00       	mov    $0x1,%eax
80102fe3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80102fea:	e8 21 0d 00 00       	call   80103d10 <scheduler>
80102fef:	90                   	nop

80102ff0 <mpenter>:
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 08             	sub    $0x8,%esp
80102ff6:	e8 b5 3b 00 00       	call   80106bb0 <switchkvm>
80102ffb:	e8 b0 3a 00 00       	call   80106ab0 <seginit>
80103000:	e8 9b f7 ff ff       	call   801027a0 <lapicinit>
80103005:	e8 a6 ff ff ff       	call   80102fb0 <mpmain>
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <main>:
80103010:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103014:	83 e4 f0             	and    $0xfffffff0,%esp
80103017:	ff 71 fc             	pushl  -0x4(%ecx)
8010301a:	55                   	push   %ebp
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	51                   	push   %ecx
8010301f:	bb 80 b7 14 80       	mov    $0x8014b780,%ebx
80103024:	83 ec 08             	sub    $0x8,%esp
80103027:	68 00 00 40 80       	push   $0x80400000
8010302c:	68 a8 e4 14 80       	push   $0x8014e4a8
80103031:	e8 ea f3 ff ff       	call   80102420 <kinit1>
80103036:	e8 15 40 00 00       	call   80107050 <kvmalloc>
8010303b:	e8 70 01 00 00       	call   801031b0 <mpinit>
80103040:	e8 5b f7 ff ff       	call   801027a0 <lapicinit>
80103045:	e8 66 3a 00 00       	call   80106ab0 <seginit>
8010304a:	e8 31 03 00 00       	call   80103380 <picinit>
8010304f:	e8 9c f1 ff ff       	call   801021f0 <ioapicinit>
80103054:	e8 47 d9 ff ff       	call   801009a0 <consoleinit>
80103059:	e8 22 2d 00 00       	call   80105d80 <uartinit>
8010305e:	e8 0d 08 00 00       	call   80103870 <pinit>
80103063:	e8 68 29 00 00       	call   801059d0 <tvinit>
80103068:	e8 d3 cf ff ff       	call   80100040 <binit>
8010306d:	e8 de dc ff ff       	call   80100d50 <fileinit>
80103072:	e8 59 ef ff ff       	call   80101fd0 <ideinit>
80103077:	83 c4 0c             	add    $0xc,%esp
8010307a:	68 8a 00 00 00       	push   $0x8a
8010307f:	68 8c b4 10 80       	push   $0x8010b48c
80103084:	68 00 70 00 80       	push   $0x80007000
80103089:	e8 02 17 00 00       	call   80104790 <memmove>
8010308e:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
80103095:	00 00 00 
80103098:	83 c4 10             	add    $0x10,%esp
8010309b:	05 80 b7 14 80       	add    $0x8014b780,%eax
801030a0:	39 d8                	cmp    %ebx,%eax
801030a2:	76 6f                	jbe    80103113 <main+0x103>
801030a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030a8:	e8 e3 07 00 00       	call   80103890 <mycpu>
801030ad:	39 d8                	cmp    %ebx,%eax
801030af:	74 49                	je     801030fa <main+0xea>
801030b1:	e8 5a f4 ff ff       	call   80102510 <kalloc>
801030b6:	05 00 10 00 00       	add    $0x1000,%eax
801030bb:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ff0,0x80006ff8
801030c2:	2f 10 80 
801030c5:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801030cc:	a0 10 00 
801030cf:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
801030d4:	0f b6 03             	movzbl (%ebx),%eax
801030d7:	83 ec 08             	sub    $0x8,%esp
801030da:	68 00 70 00 00       	push   $0x7000
801030df:	50                   	push   %eax
801030e0:	e8 0b f8 ff ff       	call   801028f0 <lapicstartap>
801030e5:	83 c4 10             	add    $0x10,%esp
801030e8:	90                   	nop
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030f6:	85 c0                	test   %eax,%eax
801030f8:	74 f6                	je     801030f0 <main+0xe0>
801030fa:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
80103101:	00 00 00 
80103104:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010310a:	05 80 b7 14 80       	add    $0x8014b780,%eax
8010310f:	39 c3                	cmp    %eax,%ebx
80103111:	72 95                	jb     801030a8 <main+0x98>
80103113:	83 ec 08             	sub    $0x8,%esp
80103116:	68 00 00 00 8e       	push   $0x8e000000
8010311b:	68 00 00 40 80       	push   $0x80400000
80103120:	e8 7b f3 ff ff       	call   801024a0 <kinit2>
80103125:	e8 36 08 00 00       	call   80103960 <userinit>
8010312a:	e8 81 fe ff ff       	call   80102fb0 <mpmain>
8010312f:	90                   	nop

80103130 <mpsearch1>:
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	57                   	push   %edi
80103134:	56                   	push   %esi
80103135:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010313b:	53                   	push   %ebx
8010313c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010313f:	83 ec 0c             	sub    $0xc,%esp
80103142:	39 de                	cmp    %ebx,%esi
80103144:	73 48                	jae    8010318e <mpsearch1+0x5e>
80103146:	8d 76 00             	lea    0x0(%esi),%esi
80103149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103150:	83 ec 04             	sub    $0x4,%esp
80103153:	8d 7e 10             	lea    0x10(%esi),%edi
80103156:	6a 04                	push   $0x4
80103158:	68 f8 79 10 80       	push   $0x801079f8
8010315d:	56                   	push   %esi
8010315e:	e8 cd 15 00 00       	call   80104730 <memcmp>
80103163:	83 c4 10             	add    $0x10,%esp
80103166:	85 c0                	test   %eax,%eax
80103168:	75 1e                	jne    80103188 <mpsearch1+0x58>
8010316a:	8d 7e 10             	lea    0x10(%esi),%edi
8010316d:	89 f2                	mov    %esi,%edx
8010316f:	31 c9                	xor    %ecx,%ecx
80103171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103178:	0f b6 02             	movzbl (%edx),%eax
8010317b:	83 c2 01             	add    $0x1,%edx
8010317e:	01 c1                	add    %eax,%ecx
80103180:	39 fa                	cmp    %edi,%edx
80103182:	75 f4                	jne    80103178 <mpsearch1+0x48>
80103184:	84 c9                	test   %cl,%cl
80103186:	74 10                	je     80103198 <mpsearch1+0x68>
80103188:	39 fb                	cmp    %edi,%ebx
8010318a:	89 fe                	mov    %edi,%esi
8010318c:	77 c2                	ja     80103150 <mpsearch1+0x20>
8010318e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103191:	31 c0                	xor    %eax,%eax
80103193:	5b                   	pop    %ebx
80103194:	5e                   	pop    %esi
80103195:	5f                   	pop    %edi
80103196:	5d                   	pop    %ebp
80103197:	c3                   	ret    
80103198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010319b:	89 f0                	mov    %esi,%eax
8010319d:	5b                   	pop    %ebx
8010319e:	5e                   	pop    %esi
8010319f:	5f                   	pop    %edi
801031a0:	5d                   	pop    %ebp
801031a1:	c3                   	ret    
801031a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031b0 <mpinit>:
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	57                   	push   %edi
801031b4:	56                   	push   %esi
801031b5:	53                   	push   %ebx
801031b6:	83 ec 1c             	sub    $0x1c,%esp
801031b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031c7:	c1 e0 08             	shl    $0x8,%eax
801031ca:	09 d0                	or     %edx,%eax
801031cc:	c1 e0 04             	shl    $0x4,%eax
801031cf:	85 c0                	test   %eax,%eax
801031d1:	75 1b                	jne    801031ee <mpinit+0x3e>
801031d3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031da:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031e1:	c1 e0 08             	shl    $0x8,%eax
801031e4:	09 d0                	or     %edx,%eax
801031e6:	c1 e0 0a             	shl    $0xa,%eax
801031e9:	2d 00 04 00 00       	sub    $0x400,%eax
801031ee:	ba 00 04 00 00       	mov    $0x400,%edx
801031f3:	e8 38 ff ff ff       	call   80103130 <mpsearch1>
801031f8:	85 c0                	test   %eax,%eax
801031fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031fd:	0f 84 37 01 00 00    	je     8010333a <mpinit+0x18a>
80103203:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103206:	8b 58 04             	mov    0x4(%eax),%ebx
80103209:	85 db                	test   %ebx,%ebx
8010320b:	0f 84 43 01 00 00    	je     80103354 <mpinit+0x1a4>
80103211:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	6a 04                	push   $0x4
8010321c:	68 fd 79 10 80       	push   $0x801079fd
80103221:	56                   	push   %esi
80103222:	e8 09 15 00 00       	call   80104730 <memcmp>
80103227:	83 c4 10             	add    $0x10,%esp
8010322a:	85 c0                	test   %eax,%eax
8010322c:	0f 85 22 01 00 00    	jne    80103354 <mpinit+0x1a4>
80103232:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103239:	3c 01                	cmp    $0x1,%al
8010323b:	74 08                	je     80103245 <mpinit+0x95>
8010323d:	3c 04                	cmp    $0x4,%al
8010323f:	0f 85 0f 01 00 00    	jne    80103354 <mpinit+0x1a4>
80103245:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
8010324c:	85 ff                	test   %edi,%edi
8010324e:	74 21                	je     80103271 <mpinit+0xc1>
80103250:	31 d2                	xor    %edx,%edx
80103252:	31 c0                	xor    %eax,%eax
80103254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103258:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010325f:	80 
80103260:	83 c0 01             	add    $0x1,%eax
80103263:	01 ca                	add    %ecx,%edx
80103265:	39 c7                	cmp    %eax,%edi
80103267:	75 ef                	jne    80103258 <mpinit+0xa8>
80103269:	84 d2                	test   %dl,%dl
8010326b:	0f 85 e3 00 00 00    	jne    80103354 <mpinit+0x1a4>
80103271:	85 f6                	test   %esi,%esi
80103273:	0f 84 db 00 00 00    	je     80103354 <mpinit+0x1a4>
80103279:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010327f:	a3 7c b6 14 80       	mov    %eax,0x8014b67c
80103284:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010328b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103291:	bb 01 00 00 00       	mov    $0x1,%ebx
80103296:	01 d6                	add    %edx,%esi
80103298:	90                   	nop
80103299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032a0:	39 c6                	cmp    %eax,%esi
801032a2:	76 23                	jbe    801032c7 <mpinit+0x117>
801032a4:	0f b6 10             	movzbl (%eax),%edx
801032a7:	80 fa 04             	cmp    $0x4,%dl
801032aa:	0f 87 c0 00 00 00    	ja     80103370 <mpinit+0x1c0>
801032b0:	ff 24 95 3c 7a 10 80 	jmp    *-0x7fef85c4(,%edx,4)
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801032c0:	83 c0 08             	add    $0x8,%eax
801032c3:	39 c6                	cmp    %eax,%esi
801032c5:	77 dd                	ja     801032a4 <mpinit+0xf4>
801032c7:	85 db                	test   %ebx,%ebx
801032c9:	0f 84 92 00 00 00    	je     80103361 <mpinit+0x1b1>
801032cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032d6:	74 15                	je     801032ed <mpinit+0x13d>
801032d8:	ba 22 00 00 00       	mov    $0x22,%edx
801032dd:	b8 70 00 00 00       	mov    $0x70,%eax
801032e2:	ee                   	out    %al,(%dx)
801032e3:	ba 23 00 00 00       	mov    $0x23,%edx
801032e8:	ec                   	in     (%dx),%al
801032e9:	83 c8 01             	or     $0x1,%eax
801032ec:	ee                   	out    %al,(%dx)
801032ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032f0:	5b                   	pop    %ebx
801032f1:	5e                   	pop    %esi
801032f2:	5f                   	pop    %edi
801032f3:	5d                   	pop    %ebp
801032f4:	c3                   	ret    
801032f5:	8d 76 00             	lea    0x0(%esi),%esi
801032f8:	8b 0d 00 bd 14 80    	mov    0x8014bd00,%ecx
801032fe:	83 f9 07             	cmp    $0x7,%ecx
80103301:	7f 19                	jg     8010331c <mpinit+0x16c>
80103303:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103307:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
8010330d:	83 c1 01             	add    $0x1,%ecx
80103310:	89 0d 00 bd 14 80    	mov    %ecx,0x8014bd00
80103316:	88 97 80 b7 14 80    	mov    %dl,-0x7feb4880(%edi)
8010331c:	83 c0 14             	add    $0x14,%eax
8010331f:	e9 7c ff ff ff       	jmp    801032a0 <mpinit+0xf0>
80103324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103328:	0f b6 50 01          	movzbl 0x1(%eax),%edx
8010332c:	83 c0 08             	add    $0x8,%eax
8010332f:	88 15 60 b7 14 80    	mov    %dl,0x8014b760
80103335:	e9 66 ff ff ff       	jmp    801032a0 <mpinit+0xf0>
8010333a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010333f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103344:	e8 e7 fd ff ff       	call   80103130 <mpsearch1>
80103349:	85 c0                	test   %eax,%eax
8010334b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010334e:	0f 85 af fe ff ff    	jne    80103203 <mpinit+0x53>
80103354:	83 ec 0c             	sub    $0xc,%esp
80103357:	68 02 7a 10 80       	push   $0x80107a02
8010335c:	e8 0f d0 ff ff       	call   80100370 <panic>
80103361:	83 ec 0c             	sub    $0xc,%esp
80103364:	68 1c 7a 10 80       	push   $0x80107a1c
80103369:	e8 02 d0 ff ff       	call   80100370 <panic>
8010336e:	66 90                	xchg   %ax,%ax
80103370:	31 db                	xor    %ebx,%ebx
80103372:	e9 30 ff ff ff       	jmp    801032a7 <mpinit+0xf7>
80103377:	66 90                	xchg   %ax,%ax
80103379:	66 90                	xchg   %ax,%ax
8010337b:	66 90                	xchg   %ax,%ax
8010337d:	66 90                	xchg   %ax,%ax
8010337f:	90                   	nop

80103380 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103380:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103381:	ba 21 00 00 00       	mov    $0x21,%edx
80103386:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010338b:	89 e5                	mov    %esp,%ebp
8010338d:	ee                   	out    %al,(%dx)
8010338e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103393:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103394:	5d                   	pop    %ebp
80103395:	c3                   	ret    
80103396:	66 90                	xchg   %ax,%ax
80103398:	66 90                	xchg   %ax,%ax
8010339a:	66 90                	xchg   %ax,%ax
8010339c:	66 90                	xchg   %ax,%ax
8010339e:	66 90                	xchg   %ax,%ax

801033a0 <pipealloc>:
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	57                   	push   %edi
801033a4:	56                   	push   %esi
801033a5:	53                   	push   %ebx
801033a6:	83 ec 0c             	sub    $0xc,%esp
801033a9:	8b 75 08             	mov    0x8(%ebp),%esi
801033ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801033af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033b5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033bb:	e8 b0 d9 ff ff       	call   80100d70 <filealloc>
801033c0:	85 c0                	test   %eax,%eax
801033c2:	89 06                	mov    %eax,(%esi)
801033c4:	0f 84 a8 00 00 00    	je     80103472 <pipealloc+0xd2>
801033ca:	e8 a1 d9 ff ff       	call   80100d70 <filealloc>
801033cf:	85 c0                	test   %eax,%eax
801033d1:	89 03                	mov    %eax,(%ebx)
801033d3:	0f 84 87 00 00 00    	je     80103460 <pipealloc+0xc0>
801033d9:	e8 32 f1 ff ff       	call   80102510 <kalloc>
801033de:	85 c0                	test   %eax,%eax
801033e0:	89 c7                	mov    %eax,%edi
801033e2:	0f 84 b0 00 00 00    	je     80103498 <pipealloc+0xf8>
801033e8:	83 ec 08             	sub    $0x8,%esp
801033eb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033f2:	00 00 00 
801033f5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033fc:	00 00 00 
801033ff:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103406:	00 00 00 
80103409:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103410:	00 00 00 
80103413:	68 50 7a 10 80       	push   $0x80107a50
80103418:	50                   	push   %eax
80103419:	e8 52 10 00 00       	call   80104470 <initlock>
8010341e:	8b 06                	mov    (%esi),%eax
80103420:	83 c4 10             	add    $0x10,%esp
80103423:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103429:	8b 06                	mov    (%esi),%eax
8010342b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
8010342f:	8b 06                	mov    (%esi),%eax
80103431:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103435:	8b 06                	mov    (%esi),%eax
80103437:	89 78 0c             	mov    %edi,0xc(%eax)
8010343a:	8b 03                	mov    (%ebx),%eax
8010343c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103442:	8b 03                	mov    (%ebx),%eax
80103444:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103448:	8b 03                	mov    (%ebx),%eax
8010344a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
8010344e:	8b 03                	mov    (%ebx),%eax
80103450:	89 78 0c             	mov    %edi,0xc(%eax)
80103453:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103456:	31 c0                	xor    %eax,%eax
80103458:	5b                   	pop    %ebx
80103459:	5e                   	pop    %esi
8010345a:	5f                   	pop    %edi
8010345b:	5d                   	pop    %ebp
8010345c:	c3                   	ret    
8010345d:	8d 76 00             	lea    0x0(%esi),%esi
80103460:	8b 06                	mov    (%esi),%eax
80103462:	85 c0                	test   %eax,%eax
80103464:	74 1e                	je     80103484 <pipealloc+0xe4>
80103466:	83 ec 0c             	sub    $0xc,%esp
80103469:	50                   	push   %eax
8010346a:	e8 c1 d9 ff ff       	call   80100e30 <fileclose>
8010346f:	83 c4 10             	add    $0x10,%esp
80103472:	8b 03                	mov    (%ebx),%eax
80103474:	85 c0                	test   %eax,%eax
80103476:	74 0c                	je     80103484 <pipealloc+0xe4>
80103478:	83 ec 0c             	sub    $0xc,%esp
8010347b:	50                   	push   %eax
8010347c:	e8 af d9 ff ff       	call   80100e30 <fileclose>
80103481:	83 c4 10             	add    $0x10,%esp
80103484:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010348c:	5b                   	pop    %ebx
8010348d:	5e                   	pop    %esi
8010348e:	5f                   	pop    %edi
8010348f:	5d                   	pop    %ebp
80103490:	c3                   	ret    
80103491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103498:	8b 06                	mov    (%esi),%eax
8010349a:	85 c0                	test   %eax,%eax
8010349c:	75 c8                	jne    80103466 <pipealloc+0xc6>
8010349e:	eb d2                	jmp    80103472 <pipealloc+0xd2>

801034a0 <pipeclose>:
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	56                   	push   %esi
801034a4:	53                   	push   %ebx
801034a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034a8:	8b 75 0c             	mov    0xc(%ebp),%esi
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	53                   	push   %ebx
801034af:	e8 bc 10 00 00       	call   80104570 <acquire>
801034b4:	83 c4 10             	add    $0x10,%esp
801034b7:	85 f6                	test   %esi,%esi
801034b9:	74 45                	je     80103500 <pipeclose+0x60>
801034bb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034c1:	83 ec 0c             	sub    $0xc,%esp
801034c4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034cb:	00 00 00 
801034ce:	50                   	push   %eax
801034cf:	e8 dc 0c 00 00       	call   801041b0 <wakeup>
801034d4:	83 c4 10             	add    $0x10,%esp
801034d7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034dd:	85 d2                	test   %edx,%edx
801034df:	75 0a                	jne    801034eb <pipeclose+0x4b>
801034e1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034e7:	85 c0                	test   %eax,%eax
801034e9:	74 35                	je     80103520 <pipeclose+0x80>
801034eb:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034f1:	5b                   	pop    %ebx
801034f2:	5e                   	pop    %esi
801034f3:	5d                   	pop    %ebp
801034f4:	e9 97 11 00 00       	jmp    80104690 <release>
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103500:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103506:	83 ec 0c             	sub    $0xc,%esp
80103509:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103510:	00 00 00 
80103513:	50                   	push   %eax
80103514:	e8 97 0c 00 00       	call   801041b0 <wakeup>
80103519:	83 c4 10             	add    $0x10,%esp
8010351c:	eb b9                	jmp    801034d7 <pipeclose+0x37>
8010351e:	66 90                	xchg   %ax,%ax
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	53                   	push   %ebx
80103524:	e8 67 11 00 00       	call   80104690 <release>
80103529:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010352c:	83 c4 10             	add    $0x10,%esp
8010352f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103532:	5b                   	pop    %ebx
80103533:	5e                   	pop    %esi
80103534:	5d                   	pop    %ebp
80103535:	e9 a6 ed ff ff       	jmp    801022e0 <kfree>
8010353a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103540 <pipewrite>:
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	57                   	push   %edi
80103544:	56                   	push   %esi
80103545:	53                   	push   %ebx
80103546:	83 ec 28             	sub    $0x28,%esp
80103549:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010354c:	53                   	push   %ebx
8010354d:	e8 1e 10 00 00       	call   80104570 <acquire>
80103552:	8b 45 10             	mov    0x10(%ebp),%eax
80103555:	83 c4 10             	add    $0x10,%esp
80103558:	85 c0                	test   %eax,%eax
8010355a:	0f 8e b9 00 00 00    	jle    80103619 <pipewrite+0xd9>
80103560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103563:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103569:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010356f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103575:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103578:	03 4d 10             	add    0x10(%ebp),%ecx
8010357b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010357e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103584:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010358a:	39 d0                	cmp    %edx,%eax
8010358c:	74 38                	je     801035c6 <pipewrite+0x86>
8010358e:	eb 59                	jmp    801035e9 <pipewrite+0xa9>
80103590:	e8 9b 03 00 00       	call   80103930 <myproc>
80103595:	8b 48 24             	mov    0x24(%eax),%ecx
80103598:	85 c9                	test   %ecx,%ecx
8010359a:	75 34                	jne    801035d0 <pipewrite+0x90>
8010359c:	83 ec 0c             	sub    $0xc,%esp
8010359f:	57                   	push   %edi
801035a0:	e8 0b 0c 00 00       	call   801041b0 <wakeup>
801035a5:	58                   	pop    %eax
801035a6:	5a                   	pop    %edx
801035a7:	53                   	push   %ebx
801035a8:	56                   	push   %esi
801035a9:	e8 52 0a 00 00       	call   80104000 <sleep>
801035ae:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035b4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035ba:	83 c4 10             	add    $0x10,%esp
801035bd:	05 00 02 00 00       	add    $0x200,%eax
801035c2:	39 c2                	cmp    %eax,%edx
801035c4:	75 2a                	jne    801035f0 <pipewrite+0xb0>
801035c6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035cc:	85 c0                	test   %eax,%eax
801035ce:	75 c0                	jne    80103590 <pipewrite+0x50>
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	53                   	push   %ebx
801035d4:	e8 b7 10 00 00       	call   80104690 <release>
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035e4:	5b                   	pop    %ebx
801035e5:	5e                   	pop    %esi
801035e6:	5f                   	pop    %edi
801035e7:	5d                   	pop    %ebp
801035e8:	c3                   	ret    
801035e9:	89 c2                	mov    %eax,%edx
801035eb:	90                   	nop
801035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801035f3:	8d 42 01             	lea    0x1(%edx),%eax
801035f6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801035fa:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103600:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103606:	0f b6 09             	movzbl (%ecx),%ecx
80103609:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010360d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103610:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103613:	0f 85 65 ff ff ff    	jne    8010357e <pipewrite+0x3e>
80103619:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010361f:	83 ec 0c             	sub    $0xc,%esp
80103622:	50                   	push   %eax
80103623:	e8 88 0b 00 00       	call   801041b0 <wakeup>
80103628:	89 1c 24             	mov    %ebx,(%esp)
8010362b:	e8 60 10 00 00       	call   80104690 <release>
80103630:	83 c4 10             	add    $0x10,%esp
80103633:	8b 45 10             	mov    0x10(%ebp),%eax
80103636:	eb a9                	jmp    801035e1 <pipewrite+0xa1>
80103638:	90                   	nop
80103639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103640 <piperead>:
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	57                   	push   %edi
80103644:	56                   	push   %esi
80103645:	53                   	push   %ebx
80103646:	83 ec 18             	sub    $0x18,%esp
80103649:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010364c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010364f:	53                   	push   %ebx
80103650:	e8 1b 0f 00 00       	call   80104570 <acquire>
80103655:	83 c4 10             	add    $0x10,%esp
80103658:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103664:	75 6a                	jne    801036d0 <piperead+0x90>
80103666:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010366c:	85 f6                	test   %esi,%esi
8010366e:	0f 84 cc 00 00 00    	je     80103740 <piperead+0x100>
80103674:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010367a:	eb 2d                	jmp    801036a9 <piperead+0x69>
8010367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103680:	83 ec 08             	sub    $0x8,%esp
80103683:	53                   	push   %ebx
80103684:	56                   	push   %esi
80103685:	e8 76 09 00 00       	call   80104000 <sleep>
8010368a:	83 c4 10             	add    $0x10,%esp
8010368d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103693:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103699:	75 35                	jne    801036d0 <piperead+0x90>
8010369b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801036a1:	85 d2                	test   %edx,%edx
801036a3:	0f 84 97 00 00 00    	je     80103740 <piperead+0x100>
801036a9:	e8 82 02 00 00       	call   80103930 <myproc>
801036ae:	8b 48 24             	mov    0x24(%eax),%ecx
801036b1:	85 c9                	test   %ecx,%ecx
801036b3:	74 cb                	je     80103680 <piperead+0x40>
801036b5:	83 ec 0c             	sub    $0xc,%esp
801036b8:	53                   	push   %ebx
801036b9:	e8 d2 0f 00 00       	call   80104690 <release>
801036be:	83 c4 10             	add    $0x10,%esp
801036c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036c9:	5b                   	pop    %ebx
801036ca:	5e                   	pop    %esi
801036cb:	5f                   	pop    %edi
801036cc:	5d                   	pop    %ebp
801036cd:	c3                   	ret    
801036ce:	66 90                	xchg   %ax,%ax
801036d0:	8b 45 10             	mov    0x10(%ebp),%eax
801036d3:	85 c0                	test   %eax,%eax
801036d5:	7e 69                	jle    80103740 <piperead+0x100>
801036d7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036dd:	31 c9                	xor    %ecx,%ecx
801036df:	eb 15                	jmp    801036f6 <piperead+0xb6>
801036e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036e8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036ee:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
801036f4:	74 5a                	je     80103750 <piperead+0x110>
801036f6:	8d 70 01             	lea    0x1(%eax),%esi
801036f9:	25 ff 01 00 00       	and    $0x1ff,%eax
801036fe:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103704:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103709:	88 04 0f             	mov    %al,(%edi,%ecx,1)
8010370c:	83 c1 01             	add    $0x1,%ecx
8010370f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103712:	75 d4                	jne    801036e8 <piperead+0xa8>
80103714:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010371a:	83 ec 0c             	sub    $0xc,%esp
8010371d:	50                   	push   %eax
8010371e:	e8 8d 0a 00 00       	call   801041b0 <wakeup>
80103723:	89 1c 24             	mov    %ebx,(%esp)
80103726:	e8 65 0f 00 00       	call   80104690 <release>
8010372b:	8b 45 10             	mov    0x10(%ebp),%eax
8010372e:	83 c4 10             	add    $0x10,%esp
80103731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103734:	5b                   	pop    %ebx
80103735:	5e                   	pop    %esi
80103736:	5f                   	pop    %edi
80103737:	5d                   	pop    %ebp
80103738:	c3                   	ret    
80103739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103740:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103747:	eb cb                	jmp    80103714 <piperead+0xd4>
80103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103750:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103753:	eb bf                	jmp    80103714 <piperead+0xd4>
80103755:	66 90                	xchg   %ax,%ax
80103757:	66 90                	xchg   %ax,%ax
80103759:	66 90                	xchg   %ax,%ax
8010375b:	66 90                	xchg   %ax,%ax
8010375d:	66 90                	xchg   %ax,%ax
8010375f:	90                   	nop

80103760 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103764:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103769:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010376c:	68 20 bd 14 80       	push   $0x8014bd20
80103771:	e8 fa 0d 00 00       	call   80104570 <acquire>
80103776:	83 c4 10             	add    $0x10,%esp
80103779:	eb 10                	jmp    8010378b <allocproc+0x2b>
8010377b:	90                   	nop
8010377c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103780:	83 c3 7c             	add    $0x7c,%ebx
80103783:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80103789:	74 75                	je     80103800 <allocproc+0xa0>
    if(p->state == UNUSED)
8010378b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010378e:	85 c0                	test   %eax,%eax
80103790:	75 ee                	jne    80103780 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103792:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103797:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010379a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801037a1:	68 20 bd 14 80       	push   $0x8014bd20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a6:	8d 50 01             	lea    0x1(%eax),%edx
801037a9:	89 43 10             	mov    %eax,0x10(%ebx)
801037ac:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
801037b2:	e8 d9 0e 00 00       	call   80104690 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037b7:	e8 54 ed ff ff       	call   80102510 <kalloc>
801037bc:	83 c4 10             	add    $0x10,%esp
801037bf:	85 c0                	test   %eax,%eax
801037c1:	89 43 08             	mov    %eax,0x8(%ebx)
801037c4:	74 51                	je     80103817 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037c6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037cc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801037cf:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801037d7:	c7 40 14 c1 59 10 80 	movl   $0x801059c1,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037de:	6a 14                	push   $0x14
801037e0:	6a 00                	push   $0x0
801037e2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801037e3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037e6:	e8 f5 0e 00 00       	call   801046e0 <memset>
  p->context->eip = (uint)forkret;
801037eb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037ee:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
801037f1:	c7 40 10 20 38 10 80 	movl   $0x80103820,0x10(%eax)

  return p;
801037f8:	89 d8                	mov    %ebx,%eax
}
801037fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037fd:	c9                   	leave  
801037fe:	c3                   	ret    
801037ff:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	68 20 bd 14 80       	push   $0x8014bd20
80103808:	e8 83 0e 00 00       	call   80104690 <release>
  return 0;
8010380d:	83 c4 10             	add    $0x10,%esp
80103810:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103815:	c9                   	leave  
80103816:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103817:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010381e:	eb da                	jmp    801037fa <allocproc+0x9a>

80103820 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103826:	68 20 bd 14 80       	push   $0x8014bd20
8010382b:	e8 60 0e 00 00       	call   80104690 <release>

  if (first) {
80103830:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103835:	83 c4 10             	add    $0x10,%esp
80103838:	85 c0                	test   %eax,%eax
8010383a:	75 04                	jne    80103840 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010383c:	c9                   	leave  
8010383d:	c3                   	ret    
8010383e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103840:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103843:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010384a:	00 00 00 
    iinit(ROOTDEV);
8010384d:	6a 01                	push   $0x1
8010384f:	e8 1c dc ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
80103854:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010385b:	e8 00 f4 ff ff       	call   80102c60 <initlog>
80103860:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103863:	c9                   	leave  
80103864:	c3                   	ret    
80103865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103870 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103876:	68 55 7a 10 80       	push   $0x80107a55
8010387b:	68 20 bd 14 80       	push   $0x8014bd20
80103880:	e8 eb 0b 00 00       	call   80104470 <initlock>
}
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	c9                   	leave  
80103889:	c3                   	ret    
8010388a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103890 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	56                   	push   %esi
80103894:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103895:	9c                   	pushf  
80103896:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103897:	f6 c4 02             	test   $0x2,%ah
8010389a:	75 5b                	jne    801038f7 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010389c:	e8 ff ef ff ff       	call   801028a0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038a1:	8b 35 00 bd 14 80    	mov    0x8014bd00,%esi
801038a7:	85 f6                	test   %esi,%esi
801038a9:	7e 3f                	jle    801038ea <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038ab:	0f b6 15 80 b7 14 80 	movzbl 0x8014b780,%edx
801038b2:	39 d0                	cmp    %edx,%eax
801038b4:	74 30                	je     801038e6 <mycpu+0x56>
801038b6:	b9 30 b8 14 80       	mov    $0x8014b830,%ecx
801038bb:	31 d2                	xor    %edx,%edx
801038bd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038c0:	83 c2 01             	add    $0x1,%edx
801038c3:	39 f2                	cmp    %esi,%edx
801038c5:	74 23                	je     801038ea <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038c7:	0f b6 19             	movzbl (%ecx),%ebx
801038ca:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038d0:	39 d8                	cmp    %ebx,%eax
801038d2:	75 ec                	jne    801038c0 <mycpu+0x30>
      return &cpus[i];
801038d4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
801038da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038dd:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801038de:	05 80 b7 14 80       	add    $0x8014b780,%eax
  }
  panic("unknown apicid\n");
}
801038e3:	5e                   	pop    %esi
801038e4:	5d                   	pop    %ebp
801038e5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038e6:	31 d2                	xor    %edx,%edx
801038e8:	eb ea                	jmp    801038d4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
801038ea:	83 ec 0c             	sub    $0xc,%esp
801038ed:	68 5c 7a 10 80       	push   $0x80107a5c
801038f2:	e8 79 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
801038f7:	83 ec 0c             	sub    $0xc,%esp
801038fa:	68 38 7b 10 80       	push   $0x80107b38
801038ff:	e8 6c ca ff ff       	call   80100370 <panic>
80103904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010390a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103910 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103916:	e8 75 ff ff ff       	call   80103890 <mycpu>
8010391b:	2d 80 b7 14 80       	sub    $0x8014b780,%eax
}
80103920:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103921:	c1 f8 04             	sar    $0x4,%eax
80103924:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010392a:	c3                   	ret    
8010392b:	90                   	nop
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103930 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	53                   	push   %ebx
80103934:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103937:	e8 f4 0b 00 00       	call   80104530 <pushcli>
  c = mycpu();
8010393c:	e8 4f ff ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103941:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103947:	e8 d4 0c 00 00       	call   80104620 <popcli>
  return p;
}
8010394c:	83 c4 04             	add    $0x4,%esp
8010394f:	89 d8                	mov    %ebx,%eax
80103951:	5b                   	pop    %ebx
80103952:	5d                   	pop    %ebp
80103953:	c3                   	ret    
80103954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010395a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103960 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103967:	e8 f4 fd ff ff       	call   80103760 <allocproc>
8010396c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010396e:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103973:	e8 58 36 00 00       	call   80106fd0 <setupkvm>
80103978:	85 c0                	test   %eax,%eax
8010397a:	89 43 04             	mov    %eax,0x4(%ebx)
8010397d:	0f 84 bd 00 00 00    	je     80103a40 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103983:	83 ec 04             	sub    $0x4,%esp
80103986:	68 2c 00 00 00       	push   $0x2c
8010398b:	68 60 b4 10 80       	push   $0x8010b460
80103990:	50                   	push   %eax
80103991:	e8 4a 33 00 00       	call   80106ce0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103996:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103999:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010399f:	6a 4c                	push   $0x4c
801039a1:	6a 00                	push   $0x0
801039a3:	ff 73 18             	pushl  0x18(%ebx)
801039a6:	e8 35 0d 00 00       	call   801046e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039ab:	8b 43 18             	mov    0x18(%ebx),%eax
801039ae:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039b3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039b8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039bb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039bf:	8b 43 18             	mov    0x18(%ebx),%eax
801039c2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039c6:	8b 43 18             	mov    0x18(%ebx),%eax
801039c9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039cd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039d1:	8b 43 18             	mov    0x18(%ebx),%eax
801039d4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039d8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039dc:	8b 43 18             	mov    0x18(%ebx),%eax
801039df:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039e6:	8b 43 18             	mov    0x18(%ebx),%eax
801039e9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039f0:	8b 43 18             	mov    0x18(%ebx),%eax
801039f3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039fa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039fd:	6a 10                	push   $0x10
801039ff:	68 85 7a 10 80       	push   $0x80107a85
80103a04:	50                   	push   %eax
80103a05:	e8 d6 0e 00 00       	call   801048e0 <safestrcpy>
  p->cwd = namei("/");
80103a0a:	c7 04 24 8e 7a 10 80 	movl   $0x80107a8e,(%esp)
80103a11:	e8 aa e4 ff ff       	call   80101ec0 <namei>
80103a16:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103a19:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103a20:	e8 4b 0b 00 00       	call   80104570 <acquire>

  p->state = RUNNABLE;
80103a25:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a2c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103a33:	e8 58 0c 00 00       	call   80104690 <release>
}
80103a38:	83 c4 10             	add    $0x10,%esp
80103a3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a3e:	c9                   	leave  
80103a3f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	68 6c 7a 10 80       	push   $0x80107a6c
80103a48:	e8 23 c9 ff ff       	call   80100370 <panic>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi

80103a50 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	56                   	push   %esi
80103a54:	53                   	push   %ebx
80103a55:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a58:	e8 d3 0a 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103a5d:	e8 2e fe ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103a62:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a68:	e8 b3 0b 00 00       	call   80104620 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103a6d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103a70:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a72:	7e 34                	jle    80103aa8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a74:	83 ec 04             	sub    $0x4,%esp
80103a77:	01 c6                	add    %eax,%esi
80103a79:	56                   	push   %esi
80103a7a:	50                   	push   %eax
80103a7b:	ff 73 04             	pushl  0x4(%ebx)
80103a7e:	e8 9d 33 00 00       	call   80106e20 <allocuvm>
80103a83:	83 c4 10             	add    $0x10,%esp
80103a86:	85 c0                	test   %eax,%eax
80103a88:	74 36                	je     80103ac0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103a8a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103a8d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a8f:	53                   	push   %ebx
80103a90:	e8 3b 31 00 00       	call   80106bd0 <switchuvm>
  return 0;
80103a95:	83 c4 10             	add    $0x10,%esp
80103a98:	31 c0                	xor    %eax,%eax
}
80103a9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a9d:	5b                   	pop    %ebx
80103a9e:	5e                   	pop    %esi
80103a9f:	5d                   	pop    %ebp
80103aa0:	c3                   	ret    
80103aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103aa8:	74 e0                	je     80103a8a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103aaa:	83 ec 04             	sub    $0x4,%esp
80103aad:	01 c6                	add    %eax,%esi
80103aaf:	56                   	push   %esi
80103ab0:	50                   	push   %eax
80103ab1:	ff 73 04             	pushl  0x4(%ebx)
80103ab4:	e8 67 34 00 00       	call   80106f20 <deallocuvm>
80103ab9:	83 c4 10             	add    $0x10,%esp
80103abc:	85 c0                	test   %eax,%eax
80103abe:	75 ca                	jne    80103a8a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ac5:	eb d3                	jmp    80103a9a <growproc+0x4a>
80103ac7:	89 f6                	mov    %esi,%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ad0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ad9:	e8 52 0a 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103ade:	e8 ad fd ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103ae3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae9:	e8 32 0b 00 00       	call   80104620 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103aee:	e8 6d fc ff ff       	call   80103760 <allocproc>
80103af3:	85 c0                	test   %eax,%eax
80103af5:	89 c7                	mov    %eax,%edi
80103af7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103afa:	0f 84 b5 00 00 00    	je     80103bb5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b00:	83 ec 08             	sub    $0x8,%esp
80103b03:	ff 33                	pushl  (%ebx)
80103b05:	ff 73 04             	pushl  0x4(%ebx)
80103b08:	e8 93 35 00 00       	call   801070a0 <copyuvm>
80103b0d:	83 c4 10             	add    $0x10,%esp
80103b10:	85 c0                	test   %eax,%eax
80103b12:	89 47 04             	mov    %eax,0x4(%edi)
80103b15:	0f 84 a1 00 00 00    	je     80103bbc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103b1b:	8b 03                	mov    (%ebx),%eax
80103b1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b20:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b22:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b25:	89 c8                	mov    %ecx,%eax
80103b27:	8b 79 18             	mov    0x18(%ecx),%edi
80103b2a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b2d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b32:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b34:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103b36:	8b 40 18             	mov    0x18(%eax),%eax
80103b39:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b40:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b44:	85 c0                	test   %eax,%eax
80103b46:	74 13                	je     80103b5b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b48:	83 ec 0c             	sub    $0xc,%esp
80103b4b:	50                   	push   %eax
80103b4c:	e8 8f d2 ff ff       	call   80100de0 <filedup>
80103b51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b54:	83 c4 10             	add    $0x10,%esp
80103b57:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b5b:	83 c6 01             	add    $0x1,%esi
80103b5e:	83 fe 10             	cmp    $0x10,%esi
80103b61:	75 dd                	jne    80103b40 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b69:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b6c:	e8 cf da ff ff       	call   80101640 <idup>
80103b71:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b74:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b77:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b7a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b7d:	6a 10                	push   $0x10
80103b7f:	53                   	push   %ebx
80103b80:	50                   	push   %eax
80103b81:	e8 5a 0d 00 00       	call   801048e0 <safestrcpy>

  pid = np->pid;
80103b86:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103b89:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103b90:	e8 db 09 00 00       	call   80104570 <acquire>

  np->state = RUNNABLE;
80103b95:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b9c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103ba3:	e8 e8 0a 00 00       	call   80104690 <release>

  return pid;
80103ba8:	83 c4 10             	add    $0x10,%esp
80103bab:	89 d8                	mov    %ebx,%eax
}
80103bad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bb0:	5b                   	pop    %ebx
80103bb1:	5e                   	pop    %esi
80103bb2:	5f                   	pop    %edi
80103bb3:	5d                   	pop    %ebp
80103bb4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103bb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bba:	eb f1                	jmp    80103bad <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103bbc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bbf:	83 ec 0c             	sub    $0xc,%esp
80103bc2:	ff 77 08             	pushl  0x8(%edi)
80103bc5:	e8 16 e7 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103bca:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103bd1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103bd8:	83 c4 10             	add    $0x10,%esp
80103bdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103be0:	eb cb                	jmp    80103bad <fork+0xdd>
80103be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bf0 <forkcow>:
}


int
forkcow(void)
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
80103bf6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103bf9:	e8 32 09 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103bfe:	e8 8d fc ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103c03:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c09:	e8 12 0a 00 00       	call   80104620 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103c0e:	e8 4d fb ff ff       	call   80103760 <allocproc>
80103c13:	85 c0                	test   %eax,%eax
80103c15:	89 c7                	mov    %eax,%edi
80103c17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c1a:	0f 84 b5 00 00 00    	je     80103cd5 <forkcow+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
80103c20:	83 ec 08             	sub    $0x8,%esp
80103c23:	ff 33                	pushl  (%ebx)
80103c25:	ff 73 04             	pushl  0x4(%ebx)
80103c28:	e8 63 35 00 00       	call   80107190 <copyuvmcow>
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	85 c0                	test   %eax,%eax
80103c32:	89 47 04             	mov    %eax,0x4(%edi)
80103c35:	0f 84 a1 00 00 00    	je     80103cdc <forkcow+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103c3b:	8b 03                	mov    (%ebx),%eax
80103c3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c40:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103c42:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c45:	89 c8                	mov    %ecx,%eax
80103c47:	8b 79 18             	mov    0x18(%ecx),%edi
80103c4a:	8b 73 18             	mov    0x18(%ebx),%esi
80103c4d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c52:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c54:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103c56:	8b 40 18             	mov    0x18(%eax),%eax
80103c59:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103c60:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c64:	85 c0                	test   %eax,%eax
80103c66:	74 13                	je     80103c7b <forkcow+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c68:	83 ec 0c             	sub    $0xc,%esp
80103c6b:	50                   	push   %eax
80103c6c:	e8 6f d1 ff ff       	call   80100de0 <filedup>
80103c71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c74:	83 c4 10             	add    $0x10,%esp
80103c77:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c7b:	83 c6 01             	add    $0x1,%esi
80103c7e:	83 fe 10             	cmp    $0x10,%esi
80103c81:	75 dd                	jne    80103c60 <forkcow+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c83:	83 ec 0c             	sub    $0xc,%esp
80103c86:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c89:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c8c:	e8 af d9 ff ff       	call   80101640 <idup>
80103c91:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c94:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c97:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c9a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c9d:	6a 10                	push   $0x10
80103c9f:	53                   	push   %ebx
80103ca0:	50                   	push   %eax
80103ca1:	e8 3a 0c 00 00       	call   801048e0 <safestrcpy>

  pid = np->pid;
80103ca6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103ca9:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103cb0:	e8 bb 08 00 00       	call   80104570 <acquire>

  np->state = RUNNABLE;
80103cb5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103cbc:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103cc3:	e8 c8 09 00 00       	call   80104690 <release>

  return pid;
80103cc8:	83 c4 10             	add    $0x10,%esp
80103ccb:	89 d8                	mov    %ebx,%eax
}
80103ccd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cd0:	5b                   	pop    %ebx
80103cd1:	5e                   	pop    %esi
80103cd2:	5f                   	pop    %edi
80103cd3:	5d                   	pop    %ebp
80103cd4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103cd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cda:	eb f1                	jmp    80103ccd <forkcow+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103cdc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103cdf:	83 ec 0c             	sub    $0xc,%esp
80103ce2:	ff 77 08             	pushl  0x8(%edi)
80103ce5:	e8 f6 e5 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103cea:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103cf1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103cf8:	83 c4 10             	add    $0x10,%esp
80103cfb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d00:	eb cb                	jmp    80103ccd <forkcow+0xdd>
80103d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d10 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103d19:	e8 72 fb ff ff       	call   80103890 <mycpu>
80103d1e:	8d 78 04             	lea    0x4(%eax),%edi
80103d21:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d23:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d2a:	00 00 00 
80103d2d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103d30:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103d31:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d34:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103d39:	68 20 bd 14 80       	push   $0x8014bd20
80103d3e:	e8 2d 08 00 00       	call   80104570 <acquire>
80103d43:	83 c4 10             	add    $0x10,%esp
80103d46:	eb 13                	jmp    80103d5b <scheduler+0x4b>
80103d48:	90                   	nop
80103d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d50:	83 c3 7c             	add    $0x7c,%ebx
80103d53:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80103d59:	74 45                	je     80103da0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103d5b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d5f:	75 ef                	jne    80103d50 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d61:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103d64:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d6a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d6b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d6e:	e8 5d 2e 00 00       	call   80106bd0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103d73:	58                   	pop    %eax
80103d74:	5a                   	pop    %edx
80103d75:	ff 73 a0             	pushl  -0x60(%ebx)
80103d78:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103d79:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103d80:	e8 b6 0b 00 00       	call   8010493b <swtch>
      switchkvm();
80103d85:	e8 26 2e 00 00       	call   80106bb0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d8a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d8d:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d93:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d9a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d9d:	75 bc                	jne    80103d5b <scheduler+0x4b>
80103d9f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103da0:	83 ec 0c             	sub    $0xc,%esp
80103da3:	68 20 bd 14 80       	push   $0x8014bd20
80103da8:	e8 e3 08 00 00       	call   80104690 <release>

  }
80103dad:	83 c4 10             	add    $0x10,%esp
80103db0:	e9 7b ff ff ff       	jmp    80103d30 <scheduler+0x20>
80103db5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dc0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	56                   	push   %esi
80103dc4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103dc5:	e8 66 07 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103dca:	e8 c1 fa ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103dcf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd5:	e8 46 08 00 00       	call   80104620 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 20 bd 14 80       	push   $0x8014bd20
80103de2:	e8 09 07 00 00       	call   801044f0 <holding>
80103de7:	83 c4 10             	add    $0x10,%esp
80103dea:	85 c0                	test   %eax,%eax
80103dec:	74 4f                	je     80103e3d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103dee:	e8 9d fa ff ff       	call   80103890 <mycpu>
80103df3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dfa:	75 68                	jne    80103e64 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103dfc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e00:	74 55                	je     80103e57 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e02:	9c                   	pushf  
80103e03:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103e04:	f6 c4 02             	test   $0x2,%ah
80103e07:	75 41                	jne    80103e4a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e09:	e8 82 fa ff ff       	call   80103890 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e0e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e11:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e17:	e8 74 fa ff ff       	call   80103890 <mycpu>
80103e1c:	83 ec 08             	sub    $0x8,%esp
80103e1f:	ff 70 04             	pushl  0x4(%eax)
80103e22:	53                   	push   %ebx
80103e23:	e8 13 0b 00 00       	call   8010493b <swtch>
  mycpu()->intena = intena;
80103e28:	e8 63 fa ff ff       	call   80103890 <mycpu>
}
80103e2d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103e30:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e39:	5b                   	pop    %ebx
80103e3a:	5e                   	pop    %esi
80103e3b:	5d                   	pop    %ebp
80103e3c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103e3d:	83 ec 0c             	sub    $0xc,%esp
80103e40:	68 90 7a 10 80       	push   $0x80107a90
80103e45:	e8 26 c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103e4a:	83 ec 0c             	sub    $0xc,%esp
80103e4d:	68 bc 7a 10 80       	push   $0x80107abc
80103e52:	e8 19 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103e57:	83 ec 0c             	sub    $0xc,%esp
80103e5a:	68 ae 7a 10 80       	push   $0x80107aae
80103e5f:	e8 0c c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103e64:	83 ec 0c             	sub    $0xc,%esp
80103e67:	68 a2 7a 10 80       	push   $0x80107aa2
80103e6c:	e8 ff c4 ff ff       	call   80100370 <panic>
80103e71:	eb 0d                	jmp    80103e80 <exit>
80103e73:	90                   	nop
80103e74:	90                   	nop
80103e75:	90                   	nop
80103e76:	90                   	nop
80103e77:	90                   	nop
80103e78:	90                   	nop
80103e79:	90                   	nop
80103e7a:	90                   	nop
80103e7b:	90                   	nop
80103e7c:	90                   	nop
80103e7d:	90                   	nop
80103e7e:	90                   	nop
80103e7f:	90                   	nop

80103e80 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e89:	e8 a2 06 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103e8e:	e8 fd f9 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103e93:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e99:	e8 82 07 00 00       	call   80104620 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103e9e:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103ea4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ea7:	8d 7e 68             	lea    0x68(%esi),%edi
80103eaa:	0f 84 e7 00 00 00    	je     80103f97 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103eb0:	8b 03                	mov    (%ebx),%eax
80103eb2:	85 c0                	test   %eax,%eax
80103eb4:	74 12                	je     80103ec8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103eb6:	83 ec 0c             	sub    $0xc,%esp
80103eb9:	50                   	push   %eax
80103eba:	e8 71 cf ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103ebf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103ec5:	83 c4 10             	add    $0x10,%esp
80103ec8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103ecb:	39 df                	cmp    %ebx,%edi
80103ecd:	75 e1                	jne    80103eb0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103ecf:	e8 2c ee ff ff       	call   80102d00 <begin_op>
  iput(curproc->cwd);
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	ff 76 68             	pushl  0x68(%esi)
80103eda:	e8 c1 d8 ff ff       	call   801017a0 <iput>
  end_op();
80103edf:	e8 8c ee ff ff       	call   80102d70 <end_op>
  curproc->cwd = 0;
80103ee4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103eeb:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103ef2:	e8 79 06 00 00       	call   80104570 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103ef7:	8b 56 14             	mov    0x14(%esi),%edx
80103efa:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103efd:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103f02:	eb 0e                	jmp    80103f12 <exit+0x92>
80103f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f08:	83 c0 7c             	add    $0x7c,%eax
80103f0b:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f10:	74 1c                	je     80103f2e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103f12:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f16:	75 f0                	jne    80103f08 <exit+0x88>
80103f18:	3b 50 20             	cmp    0x20(%eax),%edx
80103f1b:	75 eb                	jne    80103f08 <exit+0x88>
      p->state = RUNNABLE;
80103f1d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f24:	83 c0 7c             	add    $0x7c,%eax
80103f27:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f2c:	75 e4                	jne    80103f12 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f2e:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
80103f34:	ba 54 bd 14 80       	mov    $0x8014bd54,%edx
80103f39:	eb 10                	jmp    80103f4b <exit+0xcb>
80103f3b:	90                   	nop
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f40:	83 c2 7c             	add    $0x7c,%edx
80103f43:	81 fa 54 dc 14 80    	cmp    $0x8014dc54,%edx
80103f49:	74 33                	je     80103f7e <exit+0xfe>
    if(p->parent == curproc){
80103f4b:	39 72 14             	cmp    %esi,0x14(%edx)
80103f4e:	75 f0                	jne    80103f40 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103f50:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f54:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f57:	75 e7                	jne    80103f40 <exit+0xc0>
80103f59:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103f5e:	eb 0a                	jmp    80103f6a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f60:	83 c0 7c             	add    $0x7c,%eax
80103f63:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f68:	74 d6                	je     80103f40 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f6a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f6e:	75 f0                	jne    80103f60 <exit+0xe0>
80103f70:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f73:	75 eb                	jne    80103f60 <exit+0xe0>
      p->state = RUNNABLE;
80103f75:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f7c:	eb e2                	jmp    80103f60 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f7e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f85:	e8 36 fe ff ff       	call   80103dc0 <sched>
  panic("zombie exit");
80103f8a:	83 ec 0c             	sub    $0xc,%esp
80103f8d:	68 dd 7a 10 80       	push   $0x80107add
80103f92:	e8 d9 c3 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103f97:	83 ec 0c             	sub    $0xc,%esp
80103f9a:	68 d0 7a 10 80       	push   $0x80107ad0
80103f9f:	e8 cc c3 ff ff       	call   80100370 <panic>
80103fa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103faa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103fb0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	53                   	push   %ebx
80103fb4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fb7:	68 20 bd 14 80       	push   $0x8014bd20
80103fbc:	e8 af 05 00 00       	call   80104570 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fc1:	e8 6a 05 00 00       	call   80104530 <pushcli>
  c = mycpu();
80103fc6:	e8 c5 f8 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80103fcb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fd1:	e8 4a 06 00 00       	call   80104620 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103fd6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103fdd:	e8 de fd ff ff       	call   80103dc0 <sched>
  release(&ptable.lock);
80103fe2:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103fe9:	e8 a2 06 00 00       	call   80104690 <release>
}
80103fee:	83 c4 10             	add    $0x10,%esp
80103ff1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ff4:	c9                   	leave  
80103ff5:	c3                   	ret    
80103ff6:	8d 76 00             	lea    0x0(%esi),%esi
80103ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104000 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	57                   	push   %edi
80104004:	56                   	push   %esi
80104005:	53                   	push   %ebx
80104006:	83 ec 0c             	sub    $0xc,%esp
80104009:	8b 7d 08             	mov    0x8(%ebp),%edi
8010400c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010400f:	e8 1c 05 00 00       	call   80104530 <pushcli>
  c = mycpu();
80104014:	e8 77 f8 ff ff       	call   80103890 <mycpu>
  p = c->proc;
80104019:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010401f:	e8 fc 05 00 00       	call   80104620 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104024:	85 db                	test   %ebx,%ebx
80104026:	0f 84 87 00 00 00    	je     801040b3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010402c:	85 f6                	test   %esi,%esi
8010402e:	74 76                	je     801040a6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104030:	81 fe 20 bd 14 80    	cmp    $0x8014bd20,%esi
80104036:	74 50                	je     80104088 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104038:	83 ec 0c             	sub    $0xc,%esp
8010403b:	68 20 bd 14 80       	push   $0x8014bd20
80104040:	e8 2b 05 00 00       	call   80104570 <acquire>
    release(lk);
80104045:	89 34 24             	mov    %esi,(%esp)
80104048:	e8 43 06 00 00       	call   80104690 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010404d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104050:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104057:	e8 64 fd ff ff       	call   80103dc0 <sched>

  // Tidy up.
  p->chan = 0;
8010405c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104063:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
8010406a:	e8 21 06 00 00       	call   80104690 <release>
    acquire(lk);
8010406f:	89 75 08             	mov    %esi,0x8(%ebp)
80104072:	83 c4 10             	add    $0x10,%esp
  }
}
80104075:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104078:	5b                   	pop    %ebx
80104079:	5e                   	pop    %esi
8010407a:	5f                   	pop    %edi
8010407b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010407c:	e9 ef 04 00 00       	jmp    80104570 <acquire>
80104081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104088:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010408b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104092:	e8 29 fd ff ff       	call   80103dc0 <sched>

  // Tidy up.
  p->chan = 0;
80104097:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010409e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040a1:	5b                   	pop    %ebx
801040a2:	5e                   	pop    %esi
801040a3:	5f                   	pop    %edi
801040a4:	5d                   	pop    %ebp
801040a5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801040a6:	83 ec 0c             	sub    $0xc,%esp
801040a9:	68 ef 7a 10 80       	push   $0x80107aef
801040ae:	e8 bd c2 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801040b3:	83 ec 0c             	sub    $0xc,%esp
801040b6:	68 e9 7a 10 80       	push   $0x80107ae9
801040bb:	e8 b0 c2 ff ff       	call   80100370 <panic>

801040c0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	56                   	push   %esi
801040c4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801040c5:	e8 66 04 00 00       	call   80104530 <pushcli>
  c = mycpu();
801040ca:	e8 c1 f7 ff ff       	call   80103890 <mycpu>
  p = c->proc;
801040cf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040d5:	e8 46 05 00 00       	call   80104620 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
801040da:	83 ec 0c             	sub    $0xc,%esp
801040dd:	68 20 bd 14 80       	push   $0x8014bd20
801040e2:	e8 89 04 00 00       	call   80104570 <acquire>
801040e7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801040ea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ec:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
801040f1:	eb 10                	jmp    80104103 <wait+0x43>
801040f3:	90                   	nop
801040f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040f8:	83 c3 7c             	add    $0x7c,%ebx
801040fb:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80104101:	74 1d                	je     80104120 <wait+0x60>
      if(p->parent != curproc)
80104103:	39 73 14             	cmp    %esi,0x14(%ebx)
80104106:	75 f0                	jne    801040f8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104108:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010410c:	74 30                	je     8010413e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010410e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104111:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104116:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
8010411c:	75 e5                	jne    80104103 <wait+0x43>
8010411e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104120:	85 c0                	test   %eax,%eax
80104122:	74 70                	je     80104194 <wait+0xd4>
80104124:	8b 46 24             	mov    0x24(%esi),%eax
80104127:	85 c0                	test   %eax,%eax
80104129:	75 69                	jne    80104194 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010412b:	83 ec 08             	sub    $0x8,%esp
8010412e:	68 20 bd 14 80       	push   $0x8014bd20
80104133:	56                   	push   %esi
80104134:	e8 c7 fe ff ff       	call   80104000 <sleep>
  }
80104139:	83 c4 10             	add    $0x10,%esp
8010413c:	eb ac                	jmp    801040ea <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010413e:	83 ec 0c             	sub    $0xc,%esp
80104141:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104144:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104147:	e8 94 e1 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010414c:	5a                   	pop    %edx
8010414d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104150:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104157:	e8 f4 2d 00 00       	call   80106f50 <freevm>
        p->pid = 0;
8010415c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104163:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010416a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010416e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104175:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010417c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80104183:	e8 08 05 00 00       	call   80104690 <release>
        return pid;
80104188:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010418b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010418e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104190:	5b                   	pop    %ebx
80104191:	5e                   	pop    %esi
80104192:	5d                   	pop    %ebp
80104193:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104194:	83 ec 0c             	sub    $0xc,%esp
80104197:	68 20 bd 14 80       	push   $0x8014bd20
8010419c:	e8 ef 04 00 00       	call   80104690 <release>
      return -1;
801041a1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801041a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041ac:	5b                   	pop    %ebx
801041ad:	5e                   	pop    %esi
801041ae:	5d                   	pop    %ebp
801041af:	c3                   	ret    

801041b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ba:	68 20 bd 14 80       	push   $0x8014bd20
801041bf:	e8 ac 03 00 00       	call   80104570 <acquire>
801041c4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041c7:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
801041cc:	eb 0c                	jmp    801041da <wakeup+0x2a>
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	83 c0 7c             	add    $0x7c,%eax
801041d3:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
801041d8:	74 1c                	je     801041f6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801041da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041de:	75 f0                	jne    801041d0 <wakeup+0x20>
801041e0:	3b 58 20             	cmp    0x20(%eax),%ebx
801041e3:	75 eb                	jne    801041d0 <wakeup+0x20>
      p->state = RUNNABLE;
801041e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041ec:	83 c0 7c             	add    $0x7c,%eax
801041ef:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
801041f4:	75 e4                	jne    801041da <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041f6:	c7 45 08 20 bd 14 80 	movl   $0x8014bd20,0x8(%ebp)
}
801041fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104200:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104201:	e9 8a 04 00 00       	jmp    80104690 <release>
80104206:	8d 76 00             	lea    0x0(%esi),%esi
80104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104210 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	53                   	push   %ebx
80104214:	83 ec 10             	sub    $0x10,%esp
80104217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010421a:	68 20 bd 14 80       	push   $0x8014bd20
8010421f:	e8 4c 03 00 00       	call   80104570 <acquire>
80104224:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104227:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
8010422c:	eb 0c                	jmp    8010423a <kill+0x2a>
8010422e:	66 90                	xchg   %ax,%ax
80104230:	83 c0 7c             	add    $0x7c,%eax
80104233:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80104238:	74 3e                	je     80104278 <kill+0x68>
    if(p->pid == pid){
8010423a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010423d:	75 f1                	jne    80104230 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010423f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104243:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010424a:	74 1c                	je     80104268 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010424c:	83 ec 0c             	sub    $0xc,%esp
8010424f:	68 20 bd 14 80       	push   $0x8014bd20
80104254:	e8 37 04 00 00       	call   80104690 <release>
      return 0;
80104259:	83 c4 10             	add    $0x10,%esp
8010425c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010425e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104261:	c9                   	leave  
80104262:	c3                   	ret    
80104263:	90                   	nop
80104264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104268:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010426f:	eb db                	jmp    8010424c <kill+0x3c>
80104271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	68 20 bd 14 80       	push   $0x8014bd20
80104280:	e8 0b 04 00 00       	call   80104690 <release>
  return -1;
80104285:	83 c4 10             	add    $0x10,%esp
80104288:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010428d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104290:	c9                   	leave  
80104291:	c3                   	ret    
80104292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042a9:	bb c0 bd 14 80       	mov    $0x8014bdc0,%ebx
801042ae:	83 ec 3c             	sub    $0x3c,%esp
801042b1:	eb 24                	jmp    801042d7 <procdump+0x37>
801042b3:	90                   	nop
801042b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042b8:	83 ec 0c             	sub    $0xc,%esp
801042bb:	68 cf 7e 10 80       	push   $0x80107ecf
801042c0:	e8 9b c3 ff ff       	call   80100660 <cprintf>
801042c5:	83 c4 10             	add    $0x10,%esp
801042c8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042cb:	81 fb c0 dc 14 80    	cmp    $0x8014dcc0,%ebx
801042d1:	0f 84 81 00 00 00    	je     80104358 <procdump+0xb8>
    if(p->state == UNUSED)
801042d7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042da:	85 c0                	test   %eax,%eax
801042dc:	74 ea                	je     801042c8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042de:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801042e1:	ba 00 7b 10 80       	mov    $0x80107b00,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042e6:	77 11                	ja     801042f9 <procdump+0x59>
801042e8:	8b 14 85 60 7b 10 80 	mov    -0x7fef84a0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801042ef:	b8 00 7b 10 80       	mov    $0x80107b00,%eax
801042f4:	85 d2                	test   %edx,%edx
801042f6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042f9:	53                   	push   %ebx
801042fa:	52                   	push   %edx
801042fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801042fe:	68 04 7b 10 80       	push   $0x80107b04
80104303:	e8 58 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104308:	83 c4 10             	add    $0x10,%esp
8010430b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010430f:	75 a7                	jne    801042b8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104311:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104314:	83 ec 08             	sub    $0x8,%esp
80104317:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010431a:	50                   	push   %eax
8010431b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010431e:	8b 40 0c             	mov    0xc(%eax),%eax
80104321:	83 c0 08             	add    $0x8,%eax
80104324:	50                   	push   %eax
80104325:	e8 66 01 00 00       	call   80104490 <getcallerpcs>
8010432a:	83 c4 10             	add    $0x10,%esp
8010432d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104330:	8b 17                	mov    (%edi),%edx
80104332:	85 d2                	test   %edx,%edx
80104334:	74 82                	je     801042b8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104336:	83 ec 08             	sub    $0x8,%esp
80104339:	83 c7 04             	add    $0x4,%edi
8010433c:	52                   	push   %edx
8010433d:	68 21 75 10 80       	push   $0x80107521
80104342:	e8 19 c3 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104347:	83 c4 10             	add    $0x10,%esp
8010434a:	39 f7                	cmp    %esi,%edi
8010434c:	75 e2                	jne    80104330 <procdump+0x90>
8010434e:	e9 65 ff ff ff       	jmp    801042b8 <procdump+0x18>
80104353:	90                   	nop
80104354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104358:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010435b:	5b                   	pop    %ebx
8010435c:	5e                   	pop    %esi
8010435d:	5f                   	pop    %edi
8010435e:	5d                   	pop    %ebp
8010435f:	c3                   	ret    

80104360 <initsleeplock>:
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 0c             	sub    $0xc,%esp
80104367:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010436a:	68 78 7b 10 80       	push   $0x80107b78
8010436f:	8d 43 04             	lea    0x4(%ebx),%eax
80104372:	50                   	push   %eax
80104373:	e8 f8 00 00 00       	call   80104470 <initlock>
80104378:	8b 45 0c             	mov    0xc(%ebp),%eax
8010437b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104381:	83 c4 10             	add    $0x10,%esp
80104384:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010438b:	89 43 38             	mov    %eax,0x38(%ebx)
8010438e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104391:	c9                   	leave  
80104392:	c3                   	ret    
80104393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043a0 <acquiresleep>:
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	56                   	push   %esi
801043a4:	53                   	push   %ebx
801043a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	8d 73 04             	lea    0x4(%ebx),%esi
801043ae:	56                   	push   %esi
801043af:	e8 bc 01 00 00       	call   80104570 <acquire>
801043b4:	8b 13                	mov    (%ebx),%edx
801043b6:	83 c4 10             	add    $0x10,%esp
801043b9:	85 d2                	test   %edx,%edx
801043bb:	74 16                	je     801043d3 <acquiresleep+0x33>
801043bd:	8d 76 00             	lea    0x0(%esi),%esi
801043c0:	83 ec 08             	sub    $0x8,%esp
801043c3:	56                   	push   %esi
801043c4:	53                   	push   %ebx
801043c5:	e8 36 fc ff ff       	call   80104000 <sleep>
801043ca:	8b 03                	mov    (%ebx),%eax
801043cc:	83 c4 10             	add    $0x10,%esp
801043cf:	85 c0                	test   %eax,%eax
801043d1:	75 ed                	jne    801043c0 <acquiresleep+0x20>
801043d3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801043d9:	e8 52 f5 ff ff       	call   80103930 <myproc>
801043de:	8b 40 10             	mov    0x10(%eax),%eax
801043e1:	89 43 3c             	mov    %eax,0x3c(%ebx)
801043e4:	89 75 08             	mov    %esi,0x8(%ebp)
801043e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043ea:	5b                   	pop    %ebx
801043eb:	5e                   	pop    %esi
801043ec:	5d                   	pop    %ebp
801043ed:	e9 9e 02 00 00       	jmp    80104690 <release>
801043f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104400 <releasesleep>:
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	8d 73 04             	lea    0x4(%ebx),%esi
8010440e:	56                   	push   %esi
8010440f:	e8 5c 01 00 00       	call   80104570 <acquire>
80104414:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010441a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104421:	89 1c 24             	mov    %ebx,(%esp)
80104424:	e8 87 fd ff ff       	call   801041b0 <wakeup>
80104429:	89 75 08             	mov    %esi,0x8(%ebp)
8010442c:	83 c4 10             	add    $0x10,%esp
8010442f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104432:	5b                   	pop    %ebx
80104433:	5e                   	pop    %esi
80104434:	5d                   	pop    %ebp
80104435:	e9 56 02 00 00       	jmp    80104690 <release>
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104440 <holdingsleep>:
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	8b 75 08             	mov    0x8(%ebp),%esi
80104448:	83 ec 0c             	sub    $0xc,%esp
8010444b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010444e:	53                   	push   %ebx
8010444f:	e8 1c 01 00 00       	call   80104570 <acquire>
80104454:	8b 36                	mov    (%esi),%esi
80104456:	89 1c 24             	mov    %ebx,(%esp)
80104459:	e8 32 02 00 00       	call   80104690 <release>
8010445e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104461:	89 f0                	mov    %esi,%eax
80104463:	5b                   	pop    %ebx
80104464:	5e                   	pop    %esi
80104465:	5d                   	pop    %ebp
80104466:	c3                   	ret    
80104467:	66 90                	xchg   %ax,%ax
80104469:	66 90                	xchg   %ax,%ax
8010446b:	66 90                	xchg   %ax,%ax
8010446d:	66 90                	xchg   %ax,%ax
8010446f:	90                   	nop

80104470 <initlock>:
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	8b 45 08             	mov    0x8(%ebp),%eax
80104476:	8b 55 0c             	mov    0xc(%ebp),%edx
80104479:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010447f:	89 50 04             	mov    %edx,0x4(%eax)
80104482:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104489:	5d                   	pop    %ebp
8010448a:	c3                   	ret    
8010448b:	90                   	nop
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104490 <getcallerpcs>:
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	8b 45 08             	mov    0x8(%ebp),%eax
80104497:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010449a:	8d 50 f8             	lea    -0x8(%eax),%edx
8010449d:	31 c0                	xor    %eax,%eax
8010449f:	90                   	nop
801044a0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044ac:	77 1a                	ja     801044c8 <getcallerpcs+0x38>
801044ae:	8b 5a 04             	mov    0x4(%edx),%ebx
801044b1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
801044b4:	83 c0 01             	add    $0x1,%eax
801044b7:	8b 12                	mov    (%edx),%edx
801044b9:	83 f8 0a             	cmp    $0xa,%eax
801044bc:	75 e2                	jne    801044a0 <getcallerpcs+0x10>
801044be:	5b                   	pop    %ebx
801044bf:	5d                   	pop    %ebp
801044c0:	c3                   	ret    
801044c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044c8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044cf:	83 c0 01             	add    $0x1,%eax
801044d2:	83 f8 0a             	cmp    $0xa,%eax
801044d5:	74 e7                	je     801044be <getcallerpcs+0x2e>
801044d7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044de:	83 c0 01             	add    $0x1,%eax
801044e1:	83 f8 0a             	cmp    $0xa,%eax
801044e4:	75 e2                	jne    801044c8 <getcallerpcs+0x38>
801044e6:	eb d6                	jmp    801044be <getcallerpcs+0x2e>
801044e8:	90                   	nop
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044f0 <holding>:
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 04             	sub    $0x4,%esp
801044f7:	8b 55 08             	mov    0x8(%ebp),%edx
801044fa:	8b 02                	mov    (%edx),%eax
801044fc:	85 c0                	test   %eax,%eax
801044fe:	75 10                	jne    80104510 <holding+0x20>
80104500:	83 c4 04             	add    $0x4,%esp
80104503:	31 c0                	xor    %eax,%eax
80104505:	5b                   	pop    %ebx
80104506:	5d                   	pop    %ebp
80104507:	c3                   	ret    
80104508:	90                   	nop
80104509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104510:	8b 5a 08             	mov    0x8(%edx),%ebx
80104513:	e8 78 f3 ff ff       	call   80103890 <mycpu>
80104518:	39 c3                	cmp    %eax,%ebx
8010451a:	0f 94 c0             	sete   %al
8010451d:	83 c4 04             	add    $0x4,%esp
80104520:	0f b6 c0             	movzbl %al,%eax
80104523:	5b                   	pop    %ebx
80104524:	5d                   	pop    %ebp
80104525:	c3                   	ret    
80104526:	8d 76 00             	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <pushcli>:
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 04             	sub    $0x4,%esp
80104537:	9c                   	pushf  
80104538:	5b                   	pop    %ebx
80104539:	fa                   	cli    
8010453a:	e8 51 f3 ff ff       	call   80103890 <mycpu>
8010453f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104545:	85 c0                	test   %eax,%eax
80104547:	75 11                	jne    8010455a <pushcli+0x2a>
80104549:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010454f:	e8 3c f3 ff ff       	call   80103890 <mycpu>
80104554:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
8010455a:	e8 31 f3 ff ff       	call   80103890 <mycpu>
8010455f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104566:	83 c4 04             	add    $0x4,%esp
80104569:	5b                   	pop    %ebx
8010456a:	5d                   	pop    %ebp
8010456b:	c3                   	ret    
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104570 <acquire>:
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	56                   	push   %esi
80104574:	53                   	push   %ebx
80104575:	e8 b6 ff ff ff       	call   80104530 <pushcli>
8010457a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010457d:	8b 03                	mov    (%ebx),%eax
8010457f:	85 c0                	test   %eax,%eax
80104581:	75 7d                	jne    80104600 <acquire+0x90>
80104583:	ba 01 00 00 00       	mov    $0x1,%edx
80104588:	eb 09                	jmp    80104593 <acquire+0x23>
8010458a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104590:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104593:	89 d0                	mov    %edx,%eax
80104595:	f0 87 03             	lock xchg %eax,(%ebx)
80104598:	85 c0                	test   %eax,%eax
8010459a:	75 f4                	jne    80104590 <acquire+0x20>
8010459c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801045a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045a4:	e8 e7 f2 ff ff       	call   80103890 <mycpu>
801045a9:	89 ea                	mov    %ebp,%edx
801045ab:	8d 4b 0c             	lea    0xc(%ebx),%ecx
801045ae:	89 43 08             	mov    %eax,0x8(%ebx)
801045b1:	31 c0                	xor    %eax,%eax
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045be:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045c4:	77 1a                	ja     801045e0 <acquire+0x70>
801045c6:	8b 5a 04             	mov    0x4(%edx),%ebx
801045c9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
801045cc:	83 c0 01             	add    $0x1,%eax
801045cf:	8b 12                	mov    (%edx),%edx
801045d1:	83 f8 0a             	cmp    $0xa,%eax
801045d4:	75 e2                	jne    801045b8 <acquire+0x48>
801045d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d9:	5b                   	pop    %ebx
801045da:	5e                   	pop    %esi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
801045e0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801045e7:	83 c0 01             	add    $0x1,%eax
801045ea:	83 f8 0a             	cmp    $0xa,%eax
801045ed:	74 e7                	je     801045d6 <acquire+0x66>
801045ef:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801045f6:	83 c0 01             	add    $0x1,%eax
801045f9:	83 f8 0a             	cmp    $0xa,%eax
801045fc:	75 e2                	jne    801045e0 <acquire+0x70>
801045fe:	eb d6                	jmp    801045d6 <acquire+0x66>
80104600:	8b 73 08             	mov    0x8(%ebx),%esi
80104603:	e8 88 f2 ff ff       	call   80103890 <mycpu>
80104608:	39 c6                	cmp    %eax,%esi
8010460a:	0f 85 73 ff ff ff    	jne    80104583 <acquire+0x13>
80104610:	83 ec 0c             	sub    $0xc,%esp
80104613:	68 83 7b 10 80       	push   $0x80107b83
80104618:	e8 53 bd ff ff       	call   80100370 <panic>
8010461d:	8d 76 00             	lea    0x0(%esi),%esi

80104620 <popcli>:
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	83 ec 08             	sub    $0x8,%esp
80104626:	9c                   	pushf  
80104627:	58                   	pop    %eax
80104628:	f6 c4 02             	test   $0x2,%ah
8010462b:	75 52                	jne    8010467f <popcli+0x5f>
8010462d:	e8 5e f2 ff ff       	call   80103890 <mycpu>
80104632:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104638:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010463b:	85 d2                	test   %edx,%edx
8010463d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104643:	78 2d                	js     80104672 <popcli+0x52>
80104645:	e8 46 f2 ff ff       	call   80103890 <mycpu>
8010464a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104650:	85 d2                	test   %edx,%edx
80104652:	74 0c                	je     80104660 <popcli+0x40>
80104654:	c9                   	leave  
80104655:	c3                   	ret    
80104656:	8d 76 00             	lea    0x0(%esi),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104660:	e8 2b f2 ff ff       	call   80103890 <mycpu>
80104665:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010466b:	85 c0                	test   %eax,%eax
8010466d:	74 e5                	je     80104654 <popcli+0x34>
8010466f:	fb                   	sti    
80104670:	c9                   	leave  
80104671:	c3                   	ret    
80104672:	83 ec 0c             	sub    $0xc,%esp
80104675:	68 a2 7b 10 80       	push   $0x80107ba2
8010467a:	e8 f1 bc ff ff       	call   80100370 <panic>
8010467f:	83 ec 0c             	sub    $0xc,%esp
80104682:	68 8b 7b 10 80       	push   $0x80107b8b
80104687:	e8 e4 bc ff ff       	call   80100370 <panic>
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <release>:
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104698:	8b 03                	mov    (%ebx),%eax
8010469a:	85 c0                	test   %eax,%eax
8010469c:	75 12                	jne    801046b0 <release+0x20>
8010469e:	83 ec 0c             	sub    $0xc,%esp
801046a1:	68 a9 7b 10 80       	push   $0x80107ba9
801046a6:	e8 c5 bc ff ff       	call   80100370 <panic>
801046ab:	90                   	nop
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046b0:	8b 73 08             	mov    0x8(%ebx),%esi
801046b3:	e8 d8 f1 ff ff       	call   80103890 <mycpu>
801046b8:	39 c6                	cmp    %eax,%esi
801046ba:	75 e2                	jne    8010469e <release+0xe>
801046bc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801046c3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801046ca:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801046cf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046d8:	5b                   	pop    %ebx
801046d9:	5e                   	pop    %esi
801046da:	5d                   	pop    %ebp
801046db:	e9 40 ff ff ff       	jmp    80104620 <popcli>

801046e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	53                   	push   %ebx
801046e5:	8b 55 08             	mov    0x8(%ebp),%edx
801046e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046eb:	f6 c2 03             	test   $0x3,%dl
801046ee:	75 05                	jne    801046f5 <memset+0x15>
801046f0:	f6 c1 03             	test   $0x3,%cl
801046f3:	74 13                	je     80104708 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801046f5:	89 d7                	mov    %edx,%edi
801046f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801046fa:	fc                   	cld    
801046fb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046fd:	5b                   	pop    %ebx
801046fe:	89 d0                	mov    %edx,%eax
80104700:	5f                   	pop    %edi
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	90                   	nop
80104704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104708:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010470c:	c1 e9 02             	shr    $0x2,%ecx
8010470f:	89 fb                	mov    %edi,%ebx
80104711:	89 f8                	mov    %edi,%eax
80104713:	c1 e3 18             	shl    $0x18,%ebx
80104716:	c1 e0 10             	shl    $0x10,%eax
80104719:	09 d8                	or     %ebx,%eax
8010471b:	09 f8                	or     %edi,%eax
8010471d:	c1 e7 08             	shl    $0x8,%edi
80104720:	09 f8                	or     %edi,%eax
80104722:	89 d7                	mov    %edx,%edi
80104724:	fc                   	cld    
80104725:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104727:	5b                   	pop    %ebx
80104728:	89 d0                	mov    %edx,%eax
8010472a:	5f                   	pop    %edi
8010472b:	5d                   	pop    %ebp
8010472c:	c3                   	ret    
8010472d:	8d 76 00             	lea    0x0(%esi),%esi

80104730 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	57                   	push   %edi
80104734:	56                   	push   %esi
80104735:	8b 45 10             	mov    0x10(%ebp),%eax
80104738:	53                   	push   %ebx
80104739:	8b 75 0c             	mov    0xc(%ebp),%esi
8010473c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010473f:	85 c0                	test   %eax,%eax
80104741:	74 29                	je     8010476c <memcmp+0x3c>
    if(*s1 != *s2)
80104743:	0f b6 13             	movzbl (%ebx),%edx
80104746:	0f b6 0e             	movzbl (%esi),%ecx
80104749:	38 d1                	cmp    %dl,%cl
8010474b:	75 2b                	jne    80104778 <memcmp+0x48>
8010474d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104750:	31 c0                	xor    %eax,%eax
80104752:	eb 14                	jmp    80104768 <memcmp+0x38>
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104758:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010475d:	83 c0 01             	add    $0x1,%eax
80104760:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104764:	38 ca                	cmp    %cl,%dl
80104766:	75 10                	jne    80104778 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104768:	39 f8                	cmp    %edi,%eax
8010476a:	75 ec                	jne    80104758 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010476c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010476d:	31 c0                	xor    %eax,%eax
}
8010476f:	5e                   	pop    %esi
80104770:	5f                   	pop    %edi
80104771:	5d                   	pop    %ebp
80104772:	c3                   	ret    
80104773:	90                   	nop
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104778:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010477b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010477c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010477e:	5e                   	pop    %esi
8010477f:	5f                   	pop    %edi
80104780:	5d                   	pop    %ebp
80104781:	c3                   	ret    
80104782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104790 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	56                   	push   %esi
80104794:	53                   	push   %ebx
80104795:	8b 45 08             	mov    0x8(%ebp),%eax
80104798:	8b 75 0c             	mov    0xc(%ebp),%esi
8010479b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010479e:	39 c6                	cmp    %eax,%esi
801047a0:	73 2e                	jae    801047d0 <memmove+0x40>
801047a2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801047a5:	39 c8                	cmp    %ecx,%eax
801047a7:	73 27                	jae    801047d0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801047a9:	85 db                	test   %ebx,%ebx
801047ab:	8d 53 ff             	lea    -0x1(%ebx),%edx
801047ae:	74 17                	je     801047c7 <memmove+0x37>
      *--d = *--s;
801047b0:	29 d9                	sub    %ebx,%ecx
801047b2:	89 cb                	mov    %ecx,%ebx
801047b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047b8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801047bf:	83 ea 01             	sub    $0x1,%edx
801047c2:	83 fa ff             	cmp    $0xffffffff,%edx
801047c5:	75 f1                	jne    801047b8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047c7:	5b                   	pop    %ebx
801047c8:	5e                   	pop    %esi
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    
801047cb:	90                   	nop
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047d0:	31 d2                	xor    %edx,%edx
801047d2:	85 db                	test   %ebx,%ebx
801047d4:	74 f1                	je     801047c7 <memmove+0x37>
801047d6:	8d 76 00             	lea    0x0(%esi),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801047e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047e7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047ea:	39 d3                	cmp    %edx,%ebx
801047ec:	75 f2                	jne    801047e0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801047ee:	5b                   	pop    %ebx
801047ef:	5e                   	pop    %esi
801047f0:	5d                   	pop    %ebp
801047f1:	c3                   	ret    
801047f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104800 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104803:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104804:	eb 8a                	jmp    80104790 <memmove>
80104806:	8d 76 00             	lea    0x0(%esi),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104818:	53                   	push   %ebx
80104819:	8b 7d 08             	mov    0x8(%ebp),%edi
8010481c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010481f:	85 c9                	test   %ecx,%ecx
80104821:	74 37                	je     8010485a <strncmp+0x4a>
80104823:	0f b6 17             	movzbl (%edi),%edx
80104826:	0f b6 1e             	movzbl (%esi),%ebx
80104829:	84 d2                	test   %dl,%dl
8010482b:	74 3f                	je     8010486c <strncmp+0x5c>
8010482d:	38 d3                	cmp    %dl,%bl
8010482f:	75 3b                	jne    8010486c <strncmp+0x5c>
80104831:	8d 47 01             	lea    0x1(%edi),%eax
80104834:	01 cf                	add    %ecx,%edi
80104836:	eb 1b                	jmp    80104853 <strncmp+0x43>
80104838:	90                   	nop
80104839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104840:	0f b6 10             	movzbl (%eax),%edx
80104843:	84 d2                	test   %dl,%dl
80104845:	74 21                	je     80104868 <strncmp+0x58>
80104847:	0f b6 19             	movzbl (%ecx),%ebx
8010484a:	83 c0 01             	add    $0x1,%eax
8010484d:	89 ce                	mov    %ecx,%esi
8010484f:	38 da                	cmp    %bl,%dl
80104851:	75 19                	jne    8010486c <strncmp+0x5c>
80104853:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104855:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104858:	75 e6                	jne    80104840 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010485a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010485b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010485d:	5e                   	pop    %esi
8010485e:	5f                   	pop    %edi
8010485f:	5d                   	pop    %ebp
80104860:	c3                   	ret    
80104861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104868:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010486c:	0f b6 c2             	movzbl %dl,%eax
8010486f:	29 d8                	sub    %ebx,%eax
}
80104871:	5b                   	pop    %ebx
80104872:	5e                   	pop    %esi
80104873:	5f                   	pop    %edi
80104874:	5d                   	pop    %ebp
80104875:	c3                   	ret    
80104876:	8d 76 00             	lea    0x0(%esi),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	8b 45 08             	mov    0x8(%ebp),%eax
80104888:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010488b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010488e:	89 c2                	mov    %eax,%edx
80104890:	eb 19                	jmp    801048ab <strncpy+0x2b>
80104892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104898:	83 c3 01             	add    $0x1,%ebx
8010489b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010489f:	83 c2 01             	add    $0x1,%edx
801048a2:	84 c9                	test   %cl,%cl
801048a4:	88 4a ff             	mov    %cl,-0x1(%edx)
801048a7:	74 09                	je     801048b2 <strncpy+0x32>
801048a9:	89 f1                	mov    %esi,%ecx
801048ab:	85 c9                	test   %ecx,%ecx
801048ad:	8d 71 ff             	lea    -0x1(%ecx),%esi
801048b0:	7f e6                	jg     80104898 <strncpy+0x18>
    ;
  while(n-- > 0)
801048b2:	31 c9                	xor    %ecx,%ecx
801048b4:	85 f6                	test   %esi,%esi
801048b6:	7e 17                	jle    801048cf <strncpy+0x4f>
801048b8:	90                   	nop
801048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801048c0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801048c4:	89 f3                	mov    %esi,%ebx
801048c6:	83 c1 01             	add    $0x1,%ecx
801048c9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801048cb:	85 db                	test   %ebx,%ebx
801048cd:	7f f1                	jg     801048c0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801048cf:	5b                   	pop    %ebx
801048d0:	5e                   	pop    %esi
801048d1:	5d                   	pop    %ebp
801048d2:	c3                   	ret    
801048d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
801048e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048e8:	8b 45 08             	mov    0x8(%ebp),%eax
801048eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048ee:	85 c9                	test   %ecx,%ecx
801048f0:	7e 26                	jle    80104918 <safestrcpy+0x38>
801048f2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048f6:	89 c1                	mov    %eax,%ecx
801048f8:	eb 17                	jmp    80104911 <safestrcpy+0x31>
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104900:	83 c2 01             	add    $0x1,%edx
80104903:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104907:	83 c1 01             	add    $0x1,%ecx
8010490a:	84 db                	test   %bl,%bl
8010490c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010490f:	74 04                	je     80104915 <safestrcpy+0x35>
80104911:	39 f2                	cmp    %esi,%edx
80104913:	75 eb                	jne    80104900 <safestrcpy+0x20>
    ;
  *s = 0;
80104915:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104918:	5b                   	pop    %ebx
80104919:	5e                   	pop    %esi
8010491a:	5d                   	pop    %ebp
8010491b:	c3                   	ret    
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104920 <strlen>:

int
strlen(const char *s)
{
80104920:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104921:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104923:	89 e5                	mov    %esp,%ebp
80104925:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104928:	80 3a 00             	cmpb   $0x0,(%edx)
8010492b:	74 0c                	je     80104939 <strlen+0x19>
8010492d:	8d 76 00             	lea    0x0(%esi),%esi
80104930:	83 c0 01             	add    $0x1,%eax
80104933:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104937:	75 f7                	jne    80104930 <strlen+0x10>
    ;
  return n;
}
80104939:	5d                   	pop    %ebp
8010493a:	c3                   	ret    

8010493b <swtch>:
8010493b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010493f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104943:	55                   	push   %ebp
80104944:	53                   	push   %ebx
80104945:	56                   	push   %esi
80104946:	57                   	push   %edi
80104947:	89 20                	mov    %esp,(%eax)
80104949:	89 d4                	mov    %edx,%esp
8010494b:	5f                   	pop    %edi
8010494c:	5e                   	pop    %esi
8010494d:	5b                   	pop    %ebx
8010494e:	5d                   	pop    %ebp
8010494f:	c3                   	ret    

80104950 <fetchint>:
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
80104957:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010495a:	e8 d1 ef ff ff       	call   80103930 <myproc>
8010495f:	8b 00                	mov    (%eax),%eax
80104961:	39 d8                	cmp    %ebx,%eax
80104963:	76 1b                	jbe    80104980 <fetchint+0x30>
80104965:	8d 53 04             	lea    0x4(%ebx),%edx
80104968:	39 d0                	cmp    %edx,%eax
8010496a:	72 14                	jb     80104980 <fetchint+0x30>
8010496c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010496f:	8b 13                	mov    (%ebx),%edx
80104971:	89 10                	mov    %edx,(%eax)
80104973:	31 c0                	xor    %eax,%eax
80104975:	83 c4 04             	add    $0x4,%esp
80104978:	5b                   	pop    %ebx
80104979:	5d                   	pop    %ebp
8010497a:	c3                   	ret    
8010497b:	90                   	nop
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104985:	eb ee                	jmp    80104975 <fetchint+0x25>
80104987:	89 f6                	mov    %esi,%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <fetchstr>:
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 04             	sub    $0x4,%esp
80104997:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010499a:	e8 91 ef ff ff       	call   80103930 <myproc>
8010499f:	39 18                	cmp    %ebx,(%eax)
801049a1:	76 29                	jbe    801049cc <fetchstr+0x3c>
801049a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801049a6:	89 da                	mov    %ebx,%edx
801049a8:	89 19                	mov    %ebx,(%ecx)
801049aa:	8b 00                	mov    (%eax),%eax
801049ac:	39 c3                	cmp    %eax,%ebx
801049ae:	73 1c                	jae    801049cc <fetchstr+0x3c>
801049b0:	80 3b 00             	cmpb   $0x0,(%ebx)
801049b3:	75 10                	jne    801049c5 <fetchstr+0x35>
801049b5:	eb 29                	jmp    801049e0 <fetchstr+0x50>
801049b7:	89 f6                	mov    %esi,%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049c0:	80 3a 00             	cmpb   $0x0,(%edx)
801049c3:	74 1b                	je     801049e0 <fetchstr+0x50>
801049c5:	83 c2 01             	add    $0x1,%edx
801049c8:	39 d0                	cmp    %edx,%eax
801049ca:	77 f4                	ja     801049c0 <fetchstr+0x30>
801049cc:	83 c4 04             	add    $0x4,%esp
801049cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049d4:	5b                   	pop    %ebx
801049d5:	5d                   	pop    %ebp
801049d6:	c3                   	ret    
801049d7:	89 f6                	mov    %esi,%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049e0:	83 c4 04             	add    $0x4,%esp
801049e3:	89 d0                	mov    %edx,%eax
801049e5:	29 d8                	sub    %ebx,%eax
801049e7:	5b                   	pop    %ebx
801049e8:	5d                   	pop    %ebp
801049e9:	c3                   	ret    
801049ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049f0 <argint>:
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
801049f5:	e8 36 ef ff ff       	call   80103930 <myproc>
801049fa:	8b 40 18             	mov    0x18(%eax),%eax
801049fd:	8b 55 08             	mov    0x8(%ebp),%edx
80104a00:	8b 40 44             	mov    0x44(%eax),%eax
80104a03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104a06:	e8 25 ef ff ff       	call   80103930 <myproc>
80104a0b:	8b 00                	mov    (%eax),%eax
80104a0d:	8d 73 04             	lea    0x4(%ebx),%esi
80104a10:	39 c6                	cmp    %eax,%esi
80104a12:	73 1c                	jae    80104a30 <argint+0x40>
80104a14:	8d 53 08             	lea    0x8(%ebx),%edx
80104a17:	39 d0                	cmp    %edx,%eax
80104a19:	72 15                	jb     80104a30 <argint+0x40>
80104a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a1e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a21:	89 10                	mov    %edx,(%eax)
80104a23:	31 c0                	xor    %eax,%eax
80104a25:	5b                   	pop    %ebx
80104a26:	5e                   	pop    %esi
80104a27:	5d                   	pop    %ebp
80104a28:	c3                   	ret    
80104a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a35:	eb ee                	jmp    80104a25 <argint+0x35>
80104a37:	89 f6                	mov    %esi,%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a40 <argptr>:
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
80104a45:	83 ec 10             	sub    $0x10,%esp
80104a48:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a4b:	e8 e0 ee ff ff       	call   80103930 <myproc>
80104a50:	89 c6                	mov    %eax,%esi
80104a52:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a55:	83 ec 08             	sub    $0x8,%esp
80104a58:	50                   	push   %eax
80104a59:	ff 75 08             	pushl  0x8(%ebp)
80104a5c:	e8 8f ff ff ff       	call   801049f0 <argint>
80104a61:	c1 e8 1f             	shr    $0x1f,%eax
80104a64:	83 c4 10             	add    $0x10,%esp
80104a67:	84 c0                	test   %al,%al
80104a69:	75 2d                	jne    80104a98 <argptr+0x58>
80104a6b:	89 d8                	mov    %ebx,%eax
80104a6d:	c1 e8 1f             	shr    $0x1f,%eax
80104a70:	84 c0                	test   %al,%al
80104a72:	75 24                	jne    80104a98 <argptr+0x58>
80104a74:	8b 16                	mov    (%esi),%edx
80104a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a79:	39 c2                	cmp    %eax,%edx
80104a7b:	76 1b                	jbe    80104a98 <argptr+0x58>
80104a7d:	01 c3                	add    %eax,%ebx
80104a7f:	39 da                	cmp    %ebx,%edx
80104a81:	72 15                	jb     80104a98 <argptr+0x58>
80104a83:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a86:	89 02                	mov    %eax,(%edx)
80104a88:	31 c0                	xor    %eax,%eax
80104a8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a8d:	5b                   	pop    %ebx
80104a8e:	5e                   	pop    %esi
80104a8f:	5d                   	pop    %ebp
80104a90:	c3                   	ret    
80104a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a9d:	eb eb                	jmp    80104a8a <argptr+0x4a>
80104a9f:	90                   	nop

80104aa0 <argstr>:
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	83 ec 20             	sub    $0x20,%esp
80104aa6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104aa9:	50                   	push   %eax
80104aaa:	ff 75 08             	pushl  0x8(%ebp)
80104aad:	e8 3e ff ff ff       	call   801049f0 <argint>
80104ab2:	83 c4 10             	add    $0x10,%esp
80104ab5:	85 c0                	test   %eax,%eax
80104ab7:	78 17                	js     80104ad0 <argstr+0x30>
80104ab9:	83 ec 08             	sub    $0x8,%esp
80104abc:	ff 75 0c             	pushl  0xc(%ebp)
80104abf:	ff 75 f4             	pushl  -0xc(%ebp)
80104ac2:	e8 c9 fe ff ff       	call   80104990 <fetchstr>
80104ac7:	83 c4 10             	add    $0x10,%esp
80104aca:	c9                   	leave  
80104acb:	c3                   	ret    
80104acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad5:	c9                   	leave  
80104ad6:	c3                   	ret    
80104ad7:	89 f6                	mov    %esi,%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ae0 <syscall>:
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
80104ae5:	e8 46 ee ff ff       	call   80103930 <myproc>
80104aea:	8b 70 18             	mov    0x18(%eax),%esi
80104aed:	89 c3                	mov    %eax,%ebx
80104aef:	8b 46 1c             	mov    0x1c(%esi),%eax
80104af2:	8d 50 ff             	lea    -0x1(%eax),%edx
80104af5:	83 fa 18             	cmp    $0x18,%edx
80104af8:	77 1e                	ja     80104b18 <syscall+0x38>
80104afa:	8b 14 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%edx
80104b01:	85 d2                	test   %edx,%edx
80104b03:	74 13                	je     80104b18 <syscall+0x38>
80104b05:	ff d2                	call   *%edx
80104b07:	89 46 1c             	mov    %eax,0x1c(%esi)
80104b0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b0d:	5b                   	pop    %ebx
80104b0e:	5e                   	pop    %esi
80104b0f:	5d                   	pop    %ebp
80104b10:	c3                   	ret    
80104b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b18:	50                   	push   %eax
80104b19:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104b1c:	50                   	push   %eax
80104b1d:	ff 73 10             	pushl  0x10(%ebx)
80104b20:	68 b1 7b 10 80       	push   $0x80107bb1
80104b25:	e8 36 bb ff ff       	call   80100660 <cprintf>
80104b2a:	8b 43 18             	mov    0x18(%ebx),%eax
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104b37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b3a:	5b                   	pop    %ebx
80104b3b:	5e                   	pop    %esi
80104b3c:	5d                   	pop    %ebp
80104b3d:	c3                   	ret    
80104b3e:	66 90                	xchg   %ax,%ax

80104b40 <create>:
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	57                   	push   %edi
80104b44:	56                   	push   %esi
80104b45:	53                   	push   %ebx
80104b46:	8d 75 da             	lea    -0x26(%ebp),%esi
80104b49:	83 ec 44             	sub    $0x44,%esp
80104b4c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b52:	56                   	push   %esi
80104b53:	50                   	push   %eax
80104b54:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b57:	89 4d bc             	mov    %ecx,-0x44(%ebp)
80104b5a:	e8 81 d3 ff ff       	call   80101ee0 <nameiparent>
80104b5f:	83 c4 10             	add    $0x10,%esp
80104b62:	85 c0                	test   %eax,%eax
80104b64:	0f 84 f6 00 00 00    	je     80104c60 <create+0x120>
80104b6a:	83 ec 0c             	sub    $0xc,%esp
80104b6d:	89 c7                	mov    %eax,%edi
80104b6f:	50                   	push   %eax
80104b70:	e8 fb ca ff ff       	call   80101670 <ilock>
80104b75:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b78:	83 c4 0c             	add    $0xc,%esp
80104b7b:	50                   	push   %eax
80104b7c:	56                   	push   %esi
80104b7d:	57                   	push   %edi
80104b7e:	e8 1d d0 ff ff       	call   80101ba0 <dirlookup>
80104b83:	83 c4 10             	add    $0x10,%esp
80104b86:	85 c0                	test   %eax,%eax
80104b88:	89 c3                	mov    %eax,%ebx
80104b8a:	74 54                	je     80104be0 <create+0xa0>
80104b8c:	83 ec 0c             	sub    $0xc,%esp
80104b8f:	57                   	push   %edi
80104b90:	e8 6b cd ff ff       	call   80101900 <iunlockput>
80104b95:	89 1c 24             	mov    %ebx,(%esp)
80104b98:	e8 d3 ca ff ff       	call   80101670 <ilock>
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ba5:	75 19                	jne    80104bc0 <create+0x80>
80104ba7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104bac:	89 d8                	mov    %ebx,%eax
80104bae:	75 10                	jne    80104bc0 <create+0x80>
80104bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb3:	5b                   	pop    %ebx
80104bb4:	5e                   	pop    %esi
80104bb5:	5f                   	pop    %edi
80104bb6:	5d                   	pop    %ebp
80104bb7:	c3                   	ret    
80104bb8:	90                   	nop
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	53                   	push   %ebx
80104bc4:	e8 37 cd ff ff       	call   80101900 <iunlockput>
80104bc9:	83 c4 10             	add    $0x10,%esp
80104bcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bcf:	31 c0                	xor    %eax,%eax
80104bd1:	5b                   	pop    %ebx
80104bd2:	5e                   	pop    %esi
80104bd3:	5f                   	pop    %edi
80104bd4:	5d                   	pop    %ebp
80104bd5:	c3                   	ret    
80104bd6:	8d 76 00             	lea    0x0(%esi),%esi
80104bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104be0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104be4:	83 ec 08             	sub    $0x8,%esp
80104be7:	50                   	push   %eax
80104be8:	ff 37                	pushl  (%edi)
80104bea:	e8 11 c9 ff ff       	call   80101500 <ialloc>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	85 c0                	test   %eax,%eax
80104bf4:	89 c3                	mov    %eax,%ebx
80104bf6:	0f 84 cc 00 00 00    	je     80104cc8 <create+0x188>
80104bfc:	83 ec 0c             	sub    $0xc,%esp
80104bff:	50                   	push   %eax
80104c00:	e8 6b ca ff ff       	call   80101670 <ilock>
80104c05:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c09:	66 89 43 52          	mov    %ax,0x52(%ebx)
80104c0d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c11:	66 89 43 54          	mov    %ax,0x54(%ebx)
80104c15:	b8 01 00 00 00       	mov    $0x1,%eax
80104c1a:	66 89 43 56          	mov    %ax,0x56(%ebx)
80104c1e:	89 1c 24             	mov    %ebx,(%esp)
80104c21:	e8 9a c9 ff ff       	call   801015c0 <iupdate>
80104c26:	83 c4 10             	add    $0x10,%esp
80104c29:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c2e:	74 40                	je     80104c70 <create+0x130>
80104c30:	83 ec 04             	sub    $0x4,%esp
80104c33:	ff 73 04             	pushl  0x4(%ebx)
80104c36:	56                   	push   %esi
80104c37:	57                   	push   %edi
80104c38:	e8 c3 d1 ff ff       	call   80101e00 <dirlink>
80104c3d:	83 c4 10             	add    $0x10,%esp
80104c40:	85 c0                	test   %eax,%eax
80104c42:	78 77                	js     80104cbb <create+0x17b>
80104c44:	83 ec 0c             	sub    $0xc,%esp
80104c47:	57                   	push   %edi
80104c48:	e8 b3 cc ff ff       	call   80101900 <iunlockput>
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c53:	89 d8                	mov    %ebx,%eax
80104c55:	5b                   	pop    %ebx
80104c56:	5e                   	pop    %esi
80104c57:	5f                   	pop    %edi
80104c58:	5d                   	pop    %ebp
80104c59:	c3                   	ret    
80104c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c60:	31 c0                	xor    %eax,%eax
80104c62:	e9 49 ff ff ff       	jmp    80104bb0 <create+0x70>
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c70:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
80104c75:	83 ec 0c             	sub    $0xc,%esp
80104c78:	57                   	push   %edi
80104c79:	e8 42 c9 ff ff       	call   801015c0 <iupdate>
80104c7e:	83 c4 0c             	add    $0xc,%esp
80104c81:	ff 73 04             	pushl  0x4(%ebx)
80104c84:	68 64 7c 10 80       	push   $0x80107c64
80104c89:	53                   	push   %ebx
80104c8a:	e8 71 d1 ff ff       	call   80101e00 <dirlink>
80104c8f:	83 c4 10             	add    $0x10,%esp
80104c92:	85 c0                	test   %eax,%eax
80104c94:	78 18                	js     80104cae <create+0x16e>
80104c96:	83 ec 04             	sub    $0x4,%esp
80104c99:	ff 77 04             	pushl  0x4(%edi)
80104c9c:	68 63 7c 10 80       	push   $0x80107c63
80104ca1:	53                   	push   %ebx
80104ca2:	e8 59 d1 ff ff       	call   80101e00 <dirlink>
80104ca7:	83 c4 10             	add    $0x10,%esp
80104caa:	85 c0                	test   %eax,%eax
80104cac:	79 82                	jns    80104c30 <create+0xf0>
80104cae:	83 ec 0c             	sub    $0xc,%esp
80104cb1:	68 57 7c 10 80       	push   $0x80107c57
80104cb6:	e8 b5 b6 ff ff       	call   80100370 <panic>
80104cbb:	83 ec 0c             	sub    $0xc,%esp
80104cbe:	68 66 7c 10 80       	push   $0x80107c66
80104cc3:	e8 a8 b6 ff ff       	call   80100370 <panic>
80104cc8:	83 ec 0c             	sub    $0xc,%esp
80104ccb:	68 48 7c 10 80       	push   $0x80107c48
80104cd0:	e8 9b b6 ff ff       	call   80100370 <panic>
80104cd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <argfd.constprop.0>:
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	56                   	push   %esi
80104ce4:	53                   	push   %ebx
80104ce5:	89 c6                	mov    %eax,%esi
80104ce7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cea:	89 d3                	mov    %edx,%ebx
80104cec:	83 ec 18             	sub    $0x18,%esp
80104cef:	50                   	push   %eax
80104cf0:	6a 00                	push   $0x0
80104cf2:	e8 f9 fc ff ff       	call   801049f0 <argint>
80104cf7:	83 c4 10             	add    $0x10,%esp
80104cfa:	85 c0                	test   %eax,%eax
80104cfc:	78 32                	js     80104d30 <argfd.constprop.0+0x50>
80104cfe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d02:	77 2c                	ja     80104d30 <argfd.constprop.0+0x50>
80104d04:	e8 27 ec ff ff       	call   80103930 <myproc>
80104d09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d0c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104d10:	85 c0                	test   %eax,%eax
80104d12:	74 1c                	je     80104d30 <argfd.constprop.0+0x50>
80104d14:	85 f6                	test   %esi,%esi
80104d16:	74 02                	je     80104d1a <argfd.constprop.0+0x3a>
80104d18:	89 16                	mov    %edx,(%esi)
80104d1a:	85 db                	test   %ebx,%ebx
80104d1c:	74 22                	je     80104d40 <argfd.constprop.0+0x60>
80104d1e:	89 03                	mov    %eax,(%ebx)
80104d20:	31 c0                	xor    %eax,%eax
80104d22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5d                   	pop    %ebp
80104d28:	c3                   	ret    
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d30:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d38:	5b                   	pop    %ebx
80104d39:	5e                   	pop    %esi
80104d3a:	5d                   	pop    %ebp
80104d3b:	c3                   	ret    
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d40:	31 c0                	xor    %eax,%eax
80104d42:	eb de                	jmp    80104d22 <argfd.constprop.0+0x42>
80104d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d50 <sys_dup>:
80104d50:	55                   	push   %ebp
80104d51:	31 c0                	xor    %eax,%eax
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	56                   	push   %esi
80104d56:	53                   	push   %ebx
80104d57:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d5a:	83 ec 10             	sub    $0x10,%esp
80104d5d:	e8 7e ff ff ff       	call   80104ce0 <argfd.constprop.0>
80104d62:	85 c0                	test   %eax,%eax
80104d64:	78 1a                	js     80104d80 <sys_dup+0x30>
80104d66:	31 db                	xor    %ebx,%ebx
80104d68:	8b 75 f4             	mov    -0xc(%ebp),%esi
80104d6b:	e8 c0 eb ff ff       	call   80103930 <myproc>
80104d70:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d74:	85 d2                	test   %edx,%edx
80104d76:	74 18                	je     80104d90 <sys_dup+0x40>
80104d78:	83 c3 01             	add    $0x1,%ebx
80104d7b:	83 fb 10             	cmp    $0x10,%ebx
80104d7e:	75 f0                	jne    80104d70 <sys_dup+0x20>
80104d80:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d88:	5b                   	pop    %ebx
80104d89:	5e                   	pop    %esi
80104d8a:	5d                   	pop    %ebp
80104d8b:	c3                   	ret    
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d90:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104d94:	83 ec 0c             	sub    $0xc,%esp
80104d97:	ff 75 f4             	pushl  -0xc(%ebp)
80104d9a:	e8 41 c0 ff ff       	call   80100de0 <filedup>
80104d9f:	83 c4 10             	add    $0x10,%esp
80104da2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104da5:	89 d8                	mov    %ebx,%eax
80104da7:	5b                   	pop    %ebx
80104da8:	5e                   	pop    %esi
80104da9:	5d                   	pop    %ebp
80104daa:	c3                   	ret    
80104dab:	90                   	nop
80104dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104db0 <sys_read>:
80104db0:	55                   	push   %ebp
80104db1:	31 c0                	xor    %eax,%eax
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	83 ec 18             	sub    $0x18,%esp
80104db8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dbb:	e8 20 ff ff ff       	call   80104ce0 <argfd.constprop.0>
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 4c                	js     80104e10 <sys_read+0x60>
80104dc4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dc7:	83 ec 08             	sub    $0x8,%esp
80104dca:	50                   	push   %eax
80104dcb:	6a 02                	push   $0x2
80104dcd:	e8 1e fc ff ff       	call   801049f0 <argint>
80104dd2:	83 c4 10             	add    $0x10,%esp
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	78 37                	js     80104e10 <sys_read+0x60>
80104dd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ddc:	83 ec 04             	sub    $0x4,%esp
80104ddf:	ff 75 f0             	pushl  -0x10(%ebp)
80104de2:	50                   	push   %eax
80104de3:	6a 01                	push   $0x1
80104de5:	e8 56 fc ff ff       	call   80104a40 <argptr>
80104dea:	83 c4 10             	add    $0x10,%esp
80104ded:	85 c0                	test   %eax,%eax
80104def:	78 1f                	js     80104e10 <sys_read+0x60>
80104df1:	83 ec 04             	sub    $0x4,%esp
80104df4:	ff 75 f0             	pushl  -0x10(%ebp)
80104df7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dfa:	ff 75 ec             	pushl  -0x14(%ebp)
80104dfd:	e8 4e c1 ff ff       	call   80100f50 <fileread>
80104e02:	83 c4 10             	add    $0x10,%esp
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_write>:
80104e20:	55                   	push   %ebp
80104e21:	31 c0                	xor    %eax,%eax
80104e23:	89 e5                	mov    %esp,%ebp
80104e25:	83 ec 18             	sub    $0x18,%esp
80104e28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e2b:	e8 b0 fe ff ff       	call   80104ce0 <argfd.constprop.0>
80104e30:	85 c0                	test   %eax,%eax
80104e32:	78 4c                	js     80104e80 <sys_write+0x60>
80104e34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e37:	83 ec 08             	sub    $0x8,%esp
80104e3a:	50                   	push   %eax
80104e3b:	6a 02                	push   $0x2
80104e3d:	e8 ae fb ff ff       	call   801049f0 <argint>
80104e42:	83 c4 10             	add    $0x10,%esp
80104e45:	85 c0                	test   %eax,%eax
80104e47:	78 37                	js     80104e80 <sys_write+0x60>
80104e49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e4c:	83 ec 04             	sub    $0x4,%esp
80104e4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e52:	50                   	push   %eax
80104e53:	6a 01                	push   $0x1
80104e55:	e8 e6 fb ff ff       	call   80104a40 <argptr>
80104e5a:	83 c4 10             	add    $0x10,%esp
80104e5d:	85 c0                	test   %eax,%eax
80104e5f:	78 1f                	js     80104e80 <sys_write+0x60>
80104e61:	83 ec 04             	sub    $0x4,%esp
80104e64:	ff 75 f0             	pushl  -0x10(%ebp)
80104e67:	ff 75 f4             	pushl  -0xc(%ebp)
80104e6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e6d:	e8 6e c1 ff ff       	call   80100fe0 <filewrite>
80104e72:	83 c4 10             	add    $0x10,%esp
80104e75:	c9                   	leave  
80104e76:	c3                   	ret    
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <sys_close>:
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	83 ec 18             	sub    $0x18,%esp
80104e96:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e99:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e9c:	e8 3f fe ff ff       	call   80104ce0 <argfd.constprop.0>
80104ea1:	85 c0                	test   %eax,%eax
80104ea3:	78 2b                	js     80104ed0 <sys_close+0x40>
80104ea5:	e8 86 ea ff ff       	call   80103930 <myproc>
80104eaa:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104ead:	83 ec 0c             	sub    $0xc,%esp
80104eb0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104eb7:	00 
80104eb8:	ff 75 f4             	pushl  -0xc(%ebp)
80104ebb:	e8 70 bf ff ff       	call   80100e30 <fileclose>
80104ec0:	83 c4 10             	add    $0x10,%esp
80104ec3:	31 c0                	xor    %eax,%eax
80104ec5:	c9                   	leave  
80104ec6:	c3                   	ret    
80104ec7:	89 f6                	mov    %esi,%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <sys_fstat>:
80104ee0:	55                   	push   %ebp
80104ee1:	31 c0                	xor    %eax,%eax
80104ee3:	89 e5                	mov    %esp,%ebp
80104ee5:	83 ec 18             	sub    $0x18,%esp
80104ee8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104eeb:	e8 f0 fd ff ff       	call   80104ce0 <argfd.constprop.0>
80104ef0:	85 c0                	test   %eax,%eax
80104ef2:	78 2c                	js     80104f20 <sys_fstat+0x40>
80104ef4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ef7:	83 ec 04             	sub    $0x4,%esp
80104efa:	6a 14                	push   $0x14
80104efc:	50                   	push   %eax
80104efd:	6a 01                	push   $0x1
80104eff:	e8 3c fb ff ff       	call   80104a40 <argptr>
80104f04:	83 c4 10             	add    $0x10,%esp
80104f07:	85 c0                	test   %eax,%eax
80104f09:	78 15                	js     80104f20 <sys_fstat+0x40>
80104f0b:	83 ec 08             	sub    $0x8,%esp
80104f0e:	ff 75 f4             	pushl  -0xc(%ebp)
80104f11:	ff 75 f0             	pushl  -0x10(%ebp)
80104f14:	e8 e7 bf ff ff       	call   80100f00 <filestat>
80104f19:	83 c4 10             	add    $0x10,%esp
80104f1c:	c9                   	leave  
80104f1d:	c3                   	ret    
80104f1e:	66 90                	xchg   %ax,%ax
80104f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <sys_link>:
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	56                   	push   %esi
80104f35:	53                   	push   %ebx
80104f36:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104f39:	83 ec 34             	sub    $0x34,%esp
80104f3c:	50                   	push   %eax
80104f3d:	6a 00                	push   $0x0
80104f3f:	e8 5c fb ff ff       	call   80104aa0 <argstr>
80104f44:	83 c4 10             	add    $0x10,%esp
80104f47:	85 c0                	test   %eax,%eax
80104f49:	0f 88 fb 00 00 00    	js     8010504a <sys_link+0x11a>
80104f4f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f52:	83 ec 08             	sub    $0x8,%esp
80104f55:	50                   	push   %eax
80104f56:	6a 01                	push   $0x1
80104f58:	e8 43 fb ff ff       	call   80104aa0 <argstr>
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	85 c0                	test   %eax,%eax
80104f62:	0f 88 e2 00 00 00    	js     8010504a <sys_link+0x11a>
80104f68:	e8 93 dd ff ff       	call   80102d00 <begin_op>
80104f6d:	83 ec 0c             	sub    $0xc,%esp
80104f70:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f73:	e8 48 cf ff ff       	call   80101ec0 <namei>
80104f78:	83 c4 10             	add    $0x10,%esp
80104f7b:	85 c0                	test   %eax,%eax
80104f7d:	89 c3                	mov    %eax,%ebx
80104f7f:	0f 84 f3 00 00 00    	je     80105078 <sys_link+0x148>
80104f85:	83 ec 0c             	sub    $0xc,%esp
80104f88:	50                   	push   %eax
80104f89:	e8 e2 c6 ff ff       	call   80101670 <ilock>
80104f8e:	83 c4 10             	add    $0x10,%esp
80104f91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f96:	0f 84 c4 00 00 00    	je     80105060 <sys_link+0x130>
80104f9c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104fa1:	83 ec 0c             	sub    $0xc,%esp
80104fa4:	8d 7d da             	lea    -0x26(%ebp),%edi
80104fa7:	53                   	push   %ebx
80104fa8:	e8 13 c6 ff ff       	call   801015c0 <iupdate>
80104fad:	89 1c 24             	mov    %ebx,(%esp)
80104fb0:	e8 9b c7 ff ff       	call   80101750 <iunlock>
80104fb5:	58                   	pop    %eax
80104fb6:	5a                   	pop    %edx
80104fb7:	57                   	push   %edi
80104fb8:	ff 75 d0             	pushl  -0x30(%ebp)
80104fbb:	e8 20 cf ff ff       	call   80101ee0 <nameiparent>
80104fc0:	83 c4 10             	add    $0x10,%esp
80104fc3:	85 c0                	test   %eax,%eax
80104fc5:	89 c6                	mov    %eax,%esi
80104fc7:	74 5b                	je     80105024 <sys_link+0xf4>
80104fc9:	83 ec 0c             	sub    $0xc,%esp
80104fcc:	50                   	push   %eax
80104fcd:	e8 9e c6 ff ff       	call   80101670 <ilock>
80104fd2:	83 c4 10             	add    $0x10,%esp
80104fd5:	8b 03                	mov    (%ebx),%eax
80104fd7:	39 06                	cmp    %eax,(%esi)
80104fd9:	75 3d                	jne    80105018 <sys_link+0xe8>
80104fdb:	83 ec 04             	sub    $0x4,%esp
80104fde:	ff 73 04             	pushl  0x4(%ebx)
80104fe1:	57                   	push   %edi
80104fe2:	56                   	push   %esi
80104fe3:	e8 18 ce ff ff       	call   80101e00 <dirlink>
80104fe8:	83 c4 10             	add    $0x10,%esp
80104feb:	85 c0                	test   %eax,%eax
80104fed:	78 29                	js     80105018 <sys_link+0xe8>
80104fef:	83 ec 0c             	sub    $0xc,%esp
80104ff2:	56                   	push   %esi
80104ff3:	e8 08 c9 ff ff       	call   80101900 <iunlockput>
80104ff8:	89 1c 24             	mov    %ebx,(%esp)
80104ffb:	e8 a0 c7 ff ff       	call   801017a0 <iput>
80105000:	e8 6b dd ff ff       	call   80102d70 <end_op>
80105005:	83 c4 10             	add    $0x10,%esp
80105008:	31 c0                	xor    %eax,%eax
8010500a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010500d:	5b                   	pop    %ebx
8010500e:	5e                   	pop    %esi
8010500f:	5f                   	pop    %edi
80105010:	5d                   	pop    %ebp
80105011:	c3                   	ret    
80105012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105018:	83 ec 0c             	sub    $0xc,%esp
8010501b:	56                   	push   %esi
8010501c:	e8 df c8 ff ff       	call   80101900 <iunlockput>
80105021:	83 c4 10             	add    $0x10,%esp
80105024:	83 ec 0c             	sub    $0xc,%esp
80105027:	53                   	push   %ebx
80105028:	e8 43 c6 ff ff       	call   80101670 <ilock>
8010502d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105032:	89 1c 24             	mov    %ebx,(%esp)
80105035:	e8 86 c5 ff ff       	call   801015c0 <iupdate>
8010503a:	89 1c 24             	mov    %ebx,(%esp)
8010503d:	e8 be c8 ff ff       	call   80101900 <iunlockput>
80105042:	e8 29 dd ff ff       	call   80102d70 <end_op>
80105047:	83 c4 10             	add    $0x10,%esp
8010504a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010504d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105052:	5b                   	pop    %ebx
80105053:	5e                   	pop    %esi
80105054:	5f                   	pop    %edi
80105055:	5d                   	pop    %ebp
80105056:	c3                   	ret    
80105057:	89 f6                	mov    %esi,%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105060:	83 ec 0c             	sub    $0xc,%esp
80105063:	53                   	push   %ebx
80105064:	e8 97 c8 ff ff       	call   80101900 <iunlockput>
80105069:	e8 02 dd ff ff       	call   80102d70 <end_op>
8010506e:	83 c4 10             	add    $0x10,%esp
80105071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105076:	eb 92                	jmp    8010500a <sys_link+0xda>
80105078:	e8 f3 dc ff ff       	call   80102d70 <end_op>
8010507d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105082:	eb 86                	jmp    8010500a <sys_link+0xda>
80105084:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010508a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105090 <sys_unlink>:
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
80105095:	53                   	push   %ebx
80105096:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105099:	83 ec 54             	sub    $0x54,%esp
8010509c:	50                   	push   %eax
8010509d:	6a 00                	push   $0x0
8010509f:	e8 fc f9 ff ff       	call   80104aa0 <argstr>
801050a4:	83 c4 10             	add    $0x10,%esp
801050a7:	85 c0                	test   %eax,%eax
801050a9:	0f 88 82 01 00 00    	js     80105231 <sys_unlink+0x1a1>
801050af:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801050b2:	e8 49 dc ff ff       	call   80102d00 <begin_op>
801050b7:	83 ec 08             	sub    $0x8,%esp
801050ba:	53                   	push   %ebx
801050bb:	ff 75 c0             	pushl  -0x40(%ebp)
801050be:	e8 1d ce ff ff       	call   80101ee0 <nameiparent>
801050c3:	83 c4 10             	add    $0x10,%esp
801050c6:	85 c0                	test   %eax,%eax
801050c8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050cb:	0f 84 6a 01 00 00    	je     8010523b <sys_unlink+0x1ab>
801050d1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801050d4:	83 ec 0c             	sub    $0xc,%esp
801050d7:	56                   	push   %esi
801050d8:	e8 93 c5 ff ff       	call   80101670 <ilock>
801050dd:	58                   	pop    %eax
801050de:	5a                   	pop    %edx
801050df:	68 64 7c 10 80       	push   $0x80107c64
801050e4:	53                   	push   %ebx
801050e5:	e8 96 ca ff ff       	call   80101b80 <namecmp>
801050ea:	83 c4 10             	add    $0x10,%esp
801050ed:	85 c0                	test   %eax,%eax
801050ef:	0f 84 fc 00 00 00    	je     801051f1 <sys_unlink+0x161>
801050f5:	83 ec 08             	sub    $0x8,%esp
801050f8:	68 63 7c 10 80       	push   $0x80107c63
801050fd:	53                   	push   %ebx
801050fe:	e8 7d ca ff ff       	call   80101b80 <namecmp>
80105103:	83 c4 10             	add    $0x10,%esp
80105106:	85 c0                	test   %eax,%eax
80105108:	0f 84 e3 00 00 00    	je     801051f1 <sys_unlink+0x161>
8010510e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105111:	83 ec 04             	sub    $0x4,%esp
80105114:	50                   	push   %eax
80105115:	53                   	push   %ebx
80105116:	56                   	push   %esi
80105117:	e8 84 ca ff ff       	call   80101ba0 <dirlookup>
8010511c:	83 c4 10             	add    $0x10,%esp
8010511f:	85 c0                	test   %eax,%eax
80105121:	89 c3                	mov    %eax,%ebx
80105123:	0f 84 c8 00 00 00    	je     801051f1 <sys_unlink+0x161>
80105129:	83 ec 0c             	sub    $0xc,%esp
8010512c:	50                   	push   %eax
8010512d:	e8 3e c5 ff ff       	call   80101670 <ilock>
80105132:	83 c4 10             	add    $0x10,%esp
80105135:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010513a:	0f 8e 24 01 00 00    	jle    80105264 <sys_unlink+0x1d4>
80105140:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105145:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105148:	74 66                	je     801051b0 <sys_unlink+0x120>
8010514a:	83 ec 04             	sub    $0x4,%esp
8010514d:	6a 10                	push   $0x10
8010514f:	6a 00                	push   $0x0
80105151:	56                   	push   %esi
80105152:	e8 89 f5 ff ff       	call   801046e0 <memset>
80105157:	6a 10                	push   $0x10
80105159:	ff 75 c4             	pushl  -0x3c(%ebp)
8010515c:	56                   	push   %esi
8010515d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105160:	e8 eb c8 ff ff       	call   80101a50 <writei>
80105165:	83 c4 20             	add    $0x20,%esp
80105168:	83 f8 10             	cmp    $0x10,%eax
8010516b:	0f 85 e6 00 00 00    	jne    80105257 <sys_unlink+0x1c7>
80105171:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105176:	0f 84 9c 00 00 00    	je     80105218 <sys_unlink+0x188>
8010517c:	83 ec 0c             	sub    $0xc,%esp
8010517f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105182:	e8 79 c7 ff ff       	call   80101900 <iunlockput>
80105187:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010518c:	89 1c 24             	mov    %ebx,(%esp)
8010518f:	e8 2c c4 ff ff       	call   801015c0 <iupdate>
80105194:	89 1c 24             	mov    %ebx,(%esp)
80105197:	e8 64 c7 ff ff       	call   80101900 <iunlockput>
8010519c:	e8 cf db ff ff       	call   80102d70 <end_op>
801051a1:	83 c4 10             	add    $0x10,%esp
801051a4:	31 c0                	xor    %eax,%eax
801051a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051a9:	5b                   	pop    %ebx
801051aa:	5e                   	pop    %esi
801051ab:	5f                   	pop    %edi
801051ac:	5d                   	pop    %ebp
801051ad:	c3                   	ret    
801051ae:	66 90                	xchg   %ax,%ax
801051b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051b4:	76 94                	jbe    8010514a <sys_unlink+0xba>
801051b6:	bf 20 00 00 00       	mov    $0x20,%edi
801051bb:	eb 0f                	jmp    801051cc <sys_unlink+0x13c>
801051bd:	8d 76 00             	lea    0x0(%esi),%esi
801051c0:	83 c7 10             	add    $0x10,%edi
801051c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051c6:	0f 83 7e ff ff ff    	jae    8010514a <sys_unlink+0xba>
801051cc:	6a 10                	push   $0x10
801051ce:	57                   	push   %edi
801051cf:	56                   	push   %esi
801051d0:	53                   	push   %ebx
801051d1:	e8 7a c7 ff ff       	call   80101950 <readi>
801051d6:	83 c4 10             	add    $0x10,%esp
801051d9:	83 f8 10             	cmp    $0x10,%eax
801051dc:	75 6c                	jne    8010524a <sys_unlink+0x1ba>
801051de:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051e3:	74 db                	je     801051c0 <sys_unlink+0x130>
801051e5:	83 ec 0c             	sub    $0xc,%esp
801051e8:	53                   	push   %ebx
801051e9:	e8 12 c7 ff ff       	call   80101900 <iunlockput>
801051ee:	83 c4 10             	add    $0x10,%esp
801051f1:	83 ec 0c             	sub    $0xc,%esp
801051f4:	ff 75 b4             	pushl  -0x4c(%ebp)
801051f7:	e8 04 c7 ff ff       	call   80101900 <iunlockput>
801051fc:	e8 6f db ff ff       	call   80102d70 <end_op>
80105201:	83 c4 10             	add    $0x10,%esp
80105204:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105207:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010520c:	5b                   	pop    %ebx
8010520d:	5e                   	pop    %esi
8010520e:	5f                   	pop    %edi
8010520f:	5d                   	pop    %ebp
80105210:	c3                   	ret    
80105211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105218:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010521b:	83 ec 0c             	sub    $0xc,%esp
8010521e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105223:	50                   	push   %eax
80105224:	e8 97 c3 ff ff       	call   801015c0 <iupdate>
80105229:	83 c4 10             	add    $0x10,%esp
8010522c:	e9 4b ff ff ff       	jmp    8010517c <sys_unlink+0xec>
80105231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105236:	e9 6b ff ff ff       	jmp    801051a6 <sys_unlink+0x116>
8010523b:	e8 30 db ff ff       	call   80102d70 <end_op>
80105240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105245:	e9 5c ff ff ff       	jmp    801051a6 <sys_unlink+0x116>
8010524a:	83 ec 0c             	sub    $0xc,%esp
8010524d:	68 88 7c 10 80       	push   $0x80107c88
80105252:	e8 19 b1 ff ff       	call   80100370 <panic>
80105257:	83 ec 0c             	sub    $0xc,%esp
8010525a:	68 9a 7c 10 80       	push   $0x80107c9a
8010525f:	e8 0c b1 ff ff       	call   80100370 <panic>
80105264:	83 ec 0c             	sub    $0xc,%esp
80105267:	68 76 7c 10 80       	push   $0x80107c76
8010526c:	e8 ff b0 ff ff       	call   80100370 <panic>
80105271:	eb 0d                	jmp    80105280 <sys_open>
80105273:	90                   	nop
80105274:	90                   	nop
80105275:	90                   	nop
80105276:	90                   	nop
80105277:	90                   	nop
80105278:	90                   	nop
80105279:	90                   	nop
8010527a:	90                   	nop
8010527b:	90                   	nop
8010527c:	90                   	nop
8010527d:	90                   	nop
8010527e:	90                   	nop
8010527f:	90                   	nop

80105280 <sys_open>:
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	57                   	push   %edi
80105284:	56                   	push   %esi
80105285:	53                   	push   %ebx
80105286:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105289:	83 ec 24             	sub    $0x24,%esp
8010528c:	50                   	push   %eax
8010528d:	6a 00                	push   $0x0
8010528f:	e8 0c f8 ff ff       	call   80104aa0 <argstr>
80105294:	83 c4 10             	add    $0x10,%esp
80105297:	85 c0                	test   %eax,%eax
80105299:	0f 88 9e 00 00 00    	js     8010533d <sys_open+0xbd>
8010529f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052a2:	83 ec 08             	sub    $0x8,%esp
801052a5:	50                   	push   %eax
801052a6:	6a 01                	push   $0x1
801052a8:	e8 43 f7 ff ff       	call   801049f0 <argint>
801052ad:	83 c4 10             	add    $0x10,%esp
801052b0:	85 c0                	test   %eax,%eax
801052b2:	0f 88 85 00 00 00    	js     8010533d <sys_open+0xbd>
801052b8:	e8 43 da ff ff       	call   80102d00 <begin_op>
801052bd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052c1:	0f 85 89 00 00 00    	jne    80105350 <sys_open+0xd0>
801052c7:	83 ec 0c             	sub    $0xc,%esp
801052ca:	ff 75 e0             	pushl  -0x20(%ebp)
801052cd:	e8 ee cb ff ff       	call   80101ec0 <namei>
801052d2:	83 c4 10             	add    $0x10,%esp
801052d5:	85 c0                	test   %eax,%eax
801052d7:	89 c6                	mov    %eax,%esi
801052d9:	0f 84 8e 00 00 00    	je     8010536d <sys_open+0xed>
801052df:	83 ec 0c             	sub    $0xc,%esp
801052e2:	50                   	push   %eax
801052e3:	e8 88 c3 ff ff       	call   80101670 <ilock>
801052e8:	83 c4 10             	add    $0x10,%esp
801052eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052f0:	0f 84 d2 00 00 00    	je     801053c8 <sys_open+0x148>
801052f6:	e8 75 ba ff ff       	call   80100d70 <filealloc>
801052fb:	85 c0                	test   %eax,%eax
801052fd:	89 c7                	mov    %eax,%edi
801052ff:	74 2b                	je     8010532c <sys_open+0xac>
80105301:	31 db                	xor    %ebx,%ebx
80105303:	e8 28 e6 ff ff       	call   80103930 <myproc>
80105308:	90                   	nop
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105310:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105314:	85 d2                	test   %edx,%edx
80105316:	74 68                	je     80105380 <sys_open+0x100>
80105318:	83 c3 01             	add    $0x1,%ebx
8010531b:	83 fb 10             	cmp    $0x10,%ebx
8010531e:	75 f0                	jne    80105310 <sys_open+0x90>
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	57                   	push   %edi
80105324:	e8 07 bb ff ff       	call   80100e30 <fileclose>
80105329:	83 c4 10             	add    $0x10,%esp
8010532c:	83 ec 0c             	sub    $0xc,%esp
8010532f:	56                   	push   %esi
80105330:	e8 cb c5 ff ff       	call   80101900 <iunlockput>
80105335:	e8 36 da ff ff       	call   80102d70 <end_op>
8010533a:	83 c4 10             	add    $0x10,%esp
8010533d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105345:	5b                   	pop    %ebx
80105346:	5e                   	pop    %esi
80105347:	5f                   	pop    %edi
80105348:	5d                   	pop    %ebp
80105349:	c3                   	ret    
8010534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105356:	31 c9                	xor    %ecx,%ecx
80105358:	6a 00                	push   $0x0
8010535a:	ba 02 00 00 00       	mov    $0x2,%edx
8010535f:	e8 dc f7 ff ff       	call   80104b40 <create>
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
80105369:	89 c6                	mov    %eax,%esi
8010536b:	75 89                	jne    801052f6 <sys_open+0x76>
8010536d:	e8 fe d9 ff ff       	call   80102d70 <end_op>
80105372:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105377:	eb 43                	jmp    801053bc <sys_open+0x13c>
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105380:	83 ec 0c             	sub    $0xc,%esp
80105383:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105387:	56                   	push   %esi
80105388:	e8 c3 c3 ff ff       	call   80101750 <iunlock>
8010538d:	e8 de d9 ff ff       	call   80102d70 <end_op>
80105392:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105398:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010539b:	83 c4 10             	add    $0x10,%esp
8010539e:	89 77 10             	mov    %esi,0x10(%edi)
801053a1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
801053a8:	89 d0                	mov    %edx,%eax
801053aa:	83 e0 01             	and    $0x1,%eax
801053ad:	83 f0 01             	xor    $0x1,%eax
801053b0:	83 e2 03             	and    $0x3,%edx
801053b3:	88 47 08             	mov    %al,0x8(%edi)
801053b6:	0f 95 47 09          	setne  0x9(%edi)
801053ba:	89 d8                	mov    %ebx,%eax
801053bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053bf:	5b                   	pop    %ebx
801053c0:	5e                   	pop    %esi
801053c1:	5f                   	pop    %edi
801053c2:	5d                   	pop    %ebp
801053c3:	c3                   	ret    
801053c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053cb:	85 c9                	test   %ecx,%ecx
801053cd:	0f 84 23 ff ff ff    	je     801052f6 <sys_open+0x76>
801053d3:	e9 54 ff ff ff       	jmp    8010532c <sys_open+0xac>
801053d8:	90                   	nop
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_mkdir>:
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 18             	sub    $0x18,%esp
801053e6:	e8 15 d9 ff ff       	call   80102d00 <begin_op>
801053eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ee:	83 ec 08             	sub    $0x8,%esp
801053f1:	50                   	push   %eax
801053f2:	6a 00                	push   $0x0
801053f4:	e8 a7 f6 ff ff       	call   80104aa0 <argstr>
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	85 c0                	test   %eax,%eax
801053fe:	78 30                	js     80105430 <sys_mkdir+0x50>
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105406:	31 c9                	xor    %ecx,%ecx
80105408:	6a 00                	push   $0x0
8010540a:	ba 01 00 00 00       	mov    $0x1,%edx
8010540f:	e8 2c f7 ff ff       	call   80104b40 <create>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	74 15                	je     80105430 <sys_mkdir+0x50>
8010541b:	83 ec 0c             	sub    $0xc,%esp
8010541e:	50                   	push   %eax
8010541f:	e8 dc c4 ff ff       	call   80101900 <iunlockput>
80105424:	e8 47 d9 ff ff       	call   80102d70 <end_op>
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	31 c0                	xor    %eax,%eax
8010542e:	c9                   	leave  
8010542f:	c3                   	ret    
80105430:	e8 3b d9 ff ff       	call   80102d70 <end_op>
80105435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010543a:	c9                   	leave  
8010543b:	c3                   	ret    
8010543c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105440 <sys_mknod>:
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	83 ec 18             	sub    $0x18,%esp
80105446:	e8 b5 d8 ff ff       	call   80102d00 <begin_op>
8010544b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010544e:	83 ec 08             	sub    $0x8,%esp
80105451:	50                   	push   %eax
80105452:	6a 00                	push   $0x0
80105454:	e8 47 f6 ff ff       	call   80104aa0 <argstr>
80105459:	83 c4 10             	add    $0x10,%esp
8010545c:	85 c0                	test   %eax,%eax
8010545e:	78 60                	js     801054c0 <sys_mknod+0x80>
80105460:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105463:	83 ec 08             	sub    $0x8,%esp
80105466:	50                   	push   %eax
80105467:	6a 01                	push   $0x1
80105469:	e8 82 f5 ff ff       	call   801049f0 <argint>
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	85 c0                	test   %eax,%eax
80105473:	78 4b                	js     801054c0 <sys_mknod+0x80>
80105475:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105478:	83 ec 08             	sub    $0x8,%esp
8010547b:	50                   	push   %eax
8010547c:	6a 02                	push   $0x2
8010547e:	e8 6d f5 ff ff       	call   801049f0 <argint>
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	78 36                	js     801054c0 <sys_mknod+0x80>
8010548a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010548e:	83 ec 0c             	sub    $0xc,%esp
80105491:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105495:	ba 03 00 00 00       	mov    $0x3,%edx
8010549a:	50                   	push   %eax
8010549b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010549e:	e8 9d f6 ff ff       	call   80104b40 <create>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	74 16                	je     801054c0 <sys_mknod+0x80>
801054aa:	83 ec 0c             	sub    $0xc,%esp
801054ad:	50                   	push   %eax
801054ae:	e8 4d c4 ff ff       	call   80101900 <iunlockput>
801054b3:	e8 b8 d8 ff ff       	call   80102d70 <end_op>
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	31 c0                	xor    %eax,%eax
801054bd:	c9                   	leave  
801054be:	c3                   	ret    
801054bf:	90                   	nop
801054c0:	e8 ab d8 ff ff       	call   80102d70 <end_op>
801054c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ca:	c9                   	leave  
801054cb:	c3                   	ret    
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054d0 <sys_chdir>:
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	56                   	push   %esi
801054d4:	53                   	push   %ebx
801054d5:	83 ec 10             	sub    $0x10,%esp
801054d8:	e8 53 e4 ff ff       	call   80103930 <myproc>
801054dd:	89 c6                	mov    %eax,%esi
801054df:	e8 1c d8 ff ff       	call   80102d00 <begin_op>
801054e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054e7:	83 ec 08             	sub    $0x8,%esp
801054ea:	50                   	push   %eax
801054eb:	6a 00                	push   $0x0
801054ed:	e8 ae f5 ff ff       	call   80104aa0 <argstr>
801054f2:	83 c4 10             	add    $0x10,%esp
801054f5:	85 c0                	test   %eax,%eax
801054f7:	78 77                	js     80105570 <sys_chdir+0xa0>
801054f9:	83 ec 0c             	sub    $0xc,%esp
801054fc:	ff 75 f4             	pushl  -0xc(%ebp)
801054ff:	e8 bc c9 ff ff       	call   80101ec0 <namei>
80105504:	83 c4 10             	add    $0x10,%esp
80105507:	85 c0                	test   %eax,%eax
80105509:	89 c3                	mov    %eax,%ebx
8010550b:	74 63                	je     80105570 <sys_chdir+0xa0>
8010550d:	83 ec 0c             	sub    $0xc,%esp
80105510:	50                   	push   %eax
80105511:	e8 5a c1 ff ff       	call   80101670 <ilock>
80105516:	83 c4 10             	add    $0x10,%esp
80105519:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010551e:	75 30                	jne    80105550 <sys_chdir+0x80>
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	53                   	push   %ebx
80105524:	e8 27 c2 ff ff       	call   80101750 <iunlock>
80105529:	58                   	pop    %eax
8010552a:	ff 76 68             	pushl  0x68(%esi)
8010552d:	e8 6e c2 ff ff       	call   801017a0 <iput>
80105532:	e8 39 d8 ff ff       	call   80102d70 <end_op>
80105537:	89 5e 68             	mov    %ebx,0x68(%esi)
8010553a:	83 c4 10             	add    $0x10,%esp
8010553d:	31 c0                	xor    %eax,%eax
8010553f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105542:	5b                   	pop    %ebx
80105543:	5e                   	pop    %esi
80105544:	5d                   	pop    %ebp
80105545:	c3                   	ret    
80105546:	8d 76 00             	lea    0x0(%esi),%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105550:	83 ec 0c             	sub    $0xc,%esp
80105553:	53                   	push   %ebx
80105554:	e8 a7 c3 ff ff       	call   80101900 <iunlockput>
80105559:	e8 12 d8 ff ff       	call   80102d70 <end_op>
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105566:	eb d7                	jmp    8010553f <sys_chdir+0x6f>
80105568:	90                   	nop
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105570:	e8 fb d7 ff ff       	call   80102d70 <end_op>
80105575:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557a:	eb c3                	jmp    8010553f <sys_chdir+0x6f>
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_exec>:
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
80105585:	53                   	push   %ebx
80105586:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010558c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105592:	50                   	push   %eax
80105593:	6a 00                	push   $0x0
80105595:	e8 06 f5 ff ff       	call   80104aa0 <argstr>
8010559a:	83 c4 10             	add    $0x10,%esp
8010559d:	85 c0                	test   %eax,%eax
8010559f:	78 7f                	js     80105620 <sys_exec+0xa0>
801055a1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055a7:	83 ec 08             	sub    $0x8,%esp
801055aa:	50                   	push   %eax
801055ab:	6a 01                	push   $0x1
801055ad:	e8 3e f4 ff ff       	call   801049f0 <argint>
801055b2:	83 c4 10             	add    $0x10,%esp
801055b5:	85 c0                	test   %eax,%eax
801055b7:	78 67                	js     80105620 <sys_exec+0xa0>
801055b9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055bf:	83 ec 04             	sub    $0x4,%esp
801055c2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055c8:	68 80 00 00 00       	push   $0x80
801055cd:	6a 00                	push   $0x0
801055cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055d5:	50                   	push   %eax
801055d6:	31 db                	xor    %ebx,%ebx
801055d8:	e8 03 f1 ff ff       	call   801046e0 <memset>
801055dd:	83 c4 10             	add    $0x10,%esp
801055e0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055e6:	83 ec 08             	sub    $0x8,%esp
801055e9:	57                   	push   %edi
801055ea:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055ed:	50                   	push   %eax
801055ee:	e8 5d f3 ff ff       	call   80104950 <fetchint>
801055f3:	83 c4 10             	add    $0x10,%esp
801055f6:	85 c0                	test   %eax,%eax
801055f8:	78 26                	js     80105620 <sys_exec+0xa0>
801055fa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105600:	85 c0                	test   %eax,%eax
80105602:	74 2c                	je     80105630 <sys_exec+0xb0>
80105604:	83 ec 08             	sub    $0x8,%esp
80105607:	56                   	push   %esi
80105608:	50                   	push   %eax
80105609:	e8 82 f3 ff ff       	call   80104990 <fetchstr>
8010560e:	83 c4 10             	add    $0x10,%esp
80105611:	85 c0                	test   %eax,%eax
80105613:	78 0b                	js     80105620 <sys_exec+0xa0>
80105615:	83 c3 01             	add    $0x1,%ebx
80105618:	83 c6 04             	add    $0x4,%esi
8010561b:	83 fb 20             	cmp    $0x20,%ebx
8010561e:	75 c0                	jne    801055e0 <sys_exec+0x60>
80105620:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105623:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105628:	5b                   	pop    %ebx
80105629:	5e                   	pop    %esi
8010562a:	5f                   	pop    %edi
8010562b:	5d                   	pop    %ebp
8010562c:	c3                   	ret    
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
80105630:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105636:	83 ec 08             	sub    $0x8,%esp
80105639:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105640:	00 00 00 00 
80105644:	50                   	push   %eax
80105645:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010564b:	e8 a0 b3 ff ff       	call   801009f0 <exec>
80105650:	83 c4 10             	add    $0x10,%esp
80105653:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105656:	5b                   	pop    %ebx
80105657:	5e                   	pop    %esi
80105658:	5f                   	pop    %edi
80105659:	5d                   	pop    %ebp
8010565a:	c3                   	ret    
8010565b:	90                   	nop
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105660 <sys_pipe>:
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
80105665:	53                   	push   %ebx
80105666:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105669:	83 ec 20             	sub    $0x20,%esp
8010566c:	6a 08                	push   $0x8
8010566e:	50                   	push   %eax
8010566f:	6a 00                	push   $0x0
80105671:	e8 ca f3 ff ff       	call   80104a40 <argptr>
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	85 c0                	test   %eax,%eax
8010567b:	78 4a                	js     801056c7 <sys_pipe+0x67>
8010567d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105680:	83 ec 08             	sub    $0x8,%esp
80105683:	50                   	push   %eax
80105684:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105687:	50                   	push   %eax
80105688:	e8 13 dd ff ff       	call   801033a0 <pipealloc>
8010568d:	83 c4 10             	add    $0x10,%esp
80105690:	85 c0                	test   %eax,%eax
80105692:	78 33                	js     801056c7 <sys_pipe+0x67>
80105694:	31 db                	xor    %ebx,%ebx
80105696:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105699:	e8 92 e2 ff ff       	call   80103930 <myproc>
8010569e:	66 90                	xchg   %ax,%ax
801056a0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056a4:	85 f6                	test   %esi,%esi
801056a6:	74 30                	je     801056d8 <sys_pipe+0x78>
801056a8:	83 c3 01             	add    $0x1,%ebx
801056ab:	83 fb 10             	cmp    $0x10,%ebx
801056ae:	75 f0                	jne    801056a0 <sys_pipe+0x40>
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	ff 75 e0             	pushl  -0x20(%ebp)
801056b6:	e8 75 b7 ff ff       	call   80100e30 <fileclose>
801056bb:	58                   	pop    %eax
801056bc:	ff 75 e4             	pushl  -0x1c(%ebp)
801056bf:	e8 6c b7 ff ff       	call   80100e30 <fileclose>
801056c4:	83 c4 10             	add    $0x10,%esp
801056c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056cf:	5b                   	pop    %ebx
801056d0:	5e                   	pop    %esi
801056d1:	5f                   	pop    %edi
801056d2:	5d                   	pop    %ebp
801056d3:	c3                   	ret    
801056d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056d8:	8d 73 08             	lea    0x8(%ebx),%esi
801056db:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
801056df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801056e2:	e8 49 e2 ff ff       	call   80103930 <myproc>
801056e7:	31 d2                	xor    %edx,%edx
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056f0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056f4:	85 c9                	test   %ecx,%ecx
801056f6:	74 18                	je     80105710 <sys_pipe+0xb0>
801056f8:	83 c2 01             	add    $0x1,%edx
801056fb:	83 fa 10             	cmp    $0x10,%edx
801056fe:	75 f0                	jne    801056f0 <sys_pipe+0x90>
80105700:	e8 2b e2 ff ff       	call   80103930 <myproc>
80105705:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010570c:	00 
8010570d:	eb a1                	jmp    801056b0 <sys_pipe+0x50>
8010570f:	90                   	nop
80105710:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105714:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105717:	89 18                	mov    %ebx,(%eax)
80105719:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010571c:	89 50 04             	mov    %edx,0x4(%eax)
8010571f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105722:	31 c0                	xor    %eax,%eax
80105724:	5b                   	pop    %ebx
80105725:	5e                   	pop    %esi
80105726:	5f                   	pop    %edi
80105727:	5d                   	pop    %ebp
80105728:	c3                   	ret    
80105729:	66 90                	xchg   %ax,%ax
8010572b:	66 90                	xchg   %ax,%ax
8010572d:	66 90                	xchg   %ax,%ax
8010572f:	90                   	nop

80105730 <sys_fork>:
#include "mmu.h"
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105733:	5d                   	pop    %ebp
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
  return fork();
80105734:	e9 97 e3 ff ff       	jmp    80103ad0 <fork>
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105740 <sys_exit>:
}


int
sys_exit(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 08             	sub    $0x8,%esp
  exit();
80105746:	e8 35 e7 ff ff       	call   80103e80 <exit>
  return 0;  // not reached
}
8010574b:	31 c0                	xor    %eax,%eax
8010574d:	c9                   	leave  
8010574e:	c3                   	ret    
8010574f:	90                   	nop

80105750 <sys_wait>:

int
sys_wait(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105753:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105754:	e9 67 e9 ff ff       	jmp    801040c0 <wait>
80105759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105760 <sys_kill>:
}

int
sys_kill(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105766:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105769:	50                   	push   %eax
8010576a:	6a 00                	push   $0x0
8010576c:	e8 7f f2 ff ff       	call   801049f0 <argint>
80105771:	83 c4 10             	add    $0x10,%esp
80105774:	85 c0                	test   %eax,%eax
80105776:	78 18                	js     80105790 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105778:	83 ec 0c             	sub    $0xc,%esp
8010577b:	ff 75 f4             	pushl  -0xc(%ebp)
8010577e:	e8 8d ea ff ff       	call   80104210 <kill>
80105783:	83 c4 10             	add    $0x10,%esp
}
80105786:	c9                   	leave  
80105787:	c3                   	ret    
80105788:	90                   	nop
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105795:	c9                   	leave  
80105796:	c3                   	ret    
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <sys_getpid>:

int
sys_getpid(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801057a6:	e8 85 e1 ff ff       	call   80103930 <myproc>
801057ab:	8b 40 10             	mov    0x10(%eax),%eax
}
801057ae:	c9                   	leave  
801057af:	c3                   	ret    

801057b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801057b7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057ba:	50                   	push   %eax
801057bb:	6a 00                	push   $0x0
801057bd:	e8 2e f2 ff ff       	call   801049f0 <argint>
801057c2:	83 c4 10             	add    $0x10,%esp
801057c5:	85 c0                	test   %eax,%eax
801057c7:	78 27                	js     801057f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057c9:	e8 62 e1 ff ff       	call   80103930 <myproc>
  if(growproc(n) < 0)
801057ce:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801057d1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057d3:	ff 75 f4             	pushl  -0xc(%ebp)
801057d6:	e8 75 e2 ff ff       	call   80103a50 <growproc>
801057db:	83 c4 10             	add    $0x10,%esp
801057de:	85 c0                	test   %eax,%eax
801057e0:	78 0e                	js     801057f0 <sys_sbrk+0x40>
    return -1;
  return addr;
801057e2:	89 d8                	mov    %ebx,%eax
}
801057e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e7:	c9                   	leave  
801057e8:	c3                   	ret    
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801057f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f5:	eb ed                	jmp    801057e4 <sys_sbrk+0x34>
801057f7:	89 f6                	mov    %esi,%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105800 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105804:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105807:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010580a:	50                   	push   %eax
8010580b:	6a 00                	push   $0x0
8010580d:	e8 de f1 ff ff       	call   801049f0 <argint>
80105812:	83 c4 10             	add    $0x10,%esp
80105815:	85 c0                	test   %eax,%eax
80105817:	0f 88 8a 00 00 00    	js     801058a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010581d:	83 ec 0c             	sub    $0xc,%esp
80105820:	68 60 dc 14 80       	push   $0x8014dc60
80105825:	e8 46 ed ff ff       	call   80104570 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010582a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010582d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105830:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  while(ticks - ticks0 < n){
80105836:	85 d2                	test   %edx,%edx
80105838:	75 27                	jne    80105861 <sys_sleep+0x61>
8010583a:	eb 54                	jmp    80105890 <sys_sleep+0x90>
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105840:	83 ec 08             	sub    $0x8,%esp
80105843:	68 60 dc 14 80       	push   $0x8014dc60
80105848:	68 a0 e4 14 80       	push   $0x8014e4a0
8010584d:	e8 ae e7 ff ff       	call   80104000 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105852:	a1 a0 e4 14 80       	mov    0x8014e4a0,%eax
80105857:	83 c4 10             	add    $0x10,%esp
8010585a:	29 d8                	sub    %ebx,%eax
8010585c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010585f:	73 2f                	jae    80105890 <sys_sleep+0x90>
    if(myproc()->killed){
80105861:	e8 ca e0 ff ff       	call   80103930 <myproc>
80105866:	8b 40 24             	mov    0x24(%eax),%eax
80105869:	85 c0                	test   %eax,%eax
8010586b:	74 d3                	je     80105840 <sys_sleep+0x40>
      release(&tickslock);
8010586d:	83 ec 0c             	sub    $0xc,%esp
80105870:	68 60 dc 14 80       	push   $0x8014dc60
80105875:	e8 16 ee ff ff       	call   80104690 <release>
      return -1;
8010587a:	83 c4 10             	add    $0x10,%esp
8010587d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105885:	c9                   	leave  
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105890:	83 ec 0c             	sub    $0xc,%esp
80105893:	68 60 dc 14 80       	push   $0x8014dc60
80105898:	e8 f3 ed ff ff       	call   80104690 <release>
  return 0;
8010589d:	83 c4 10             	add    $0x10,%esp
801058a0:	31 c0                	xor    %eax,%eax
}
801058a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058a5:	c9                   	leave  
801058a6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801058a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ac:	eb d4                	jmp    80105882 <sys_sleep+0x82>
801058ae:	66 90                	xchg   %ax,%ax

801058b0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	53                   	push   %ebx
801058b4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058b7:	68 60 dc 14 80       	push   $0x8014dc60
801058bc:	e8 af ec ff ff       	call   80104570 <acquire>
  xticks = ticks;
801058c1:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  release(&tickslock);
801058c7:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
801058ce:	e8 bd ed ff ff       	call   80104690 <release>
  return xticks;
}
801058d3:	89 d8                	mov    %ebx,%eax
801058d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058d8:	c9                   	leave  
801058d9:	c3                   	ret    
801058da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058e0 <sys_date>:

int
sys_date(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 1c             	sub    $0x1c,%esp
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
801058e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058e9:	6a 04                	push   $0x4
801058eb:	50                   	push   %eax
801058ec:	6a 00                	push   $0x0
801058ee:	e8 4d f1 ff ff       	call   80104a40 <argptr>
801058f3:	83 c4 10             	add    $0x10,%esp
801058f6:	85 c0                	test   %eax,%eax
801058f8:	78 16                	js     80105910 <sys_date+0x30>
   {
    return -1;
   }
  cmostime((struct rtcdate *)ptr);
801058fa:	83 ec 0c             	sub    $0xc,%esp
801058fd:	ff 75 f4             	pushl  -0xc(%ebp)
80105900:	e8 7b d0 ff ff       	call   80102980 <cmostime>
  return 0;
80105905:	83 c4 10             	add    $0x10,%esp
80105908:	31 c0                	xor    %eax,%eax

}
8010590a:	c9                   	leave  
8010590b:	c3                   	ret    
8010590c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_date(void)
{
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
   {
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   }
  cmostime((struct rtcdate *)ptr);
  return 0;

}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_virt2real>:

int
sys_virt2real(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 1c             	sub    $0x1c,%esp
  char *ptr;
  argptr(0, &ptr, sizeof(char*));
80105926:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105929:	6a 04                	push   $0x4
8010592b:	50                   	push   %eax
8010592c:	6a 00                	push   $0x0
8010592e:	e8 0d f1 ff ff       	call   80104a40 <argptr>
  struct proc *curproc = myproc();
80105933:	e8 f8 df ff ff       	call   80103930 <myproc>
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX((const void *)ptr)];
80105938:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010593b:	8b 40 04             	mov    0x4(%eax),%eax
8010593e:	89 ca                	mov    %ecx,%edx
80105940:	c1 ea 16             	shr    $0x16,%edx
80105943:	8b 04 90             	mov    (%eax,%edx,4),%eax
  pgtab = &pgtab[PTX((const void *)ptr)];
  return (int)(P2V(PTE_ADDR(*pgtab) + PTE_FLAGS(*ptr)));
80105946:	89 ca                	mov    %ecx,%edx
80105948:	c1 ea 0c             	shr    $0xc,%edx
8010594b:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  argptr(0, &ptr, sizeof(char*));
  struct proc *curproc = myproc();
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX((const void *)ptr)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105951:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  pgtab = &pgtab[PTX((const void *)ptr)];
  return (int)(P2V(PTE_ADDR(*pgtab) + PTE_FLAGS(*ptr)));
80105956:	8b 94 90 00 00 00 80 	mov    -0x80000000(%eax,%edx,4),%edx
8010595d:	0f be 01             	movsbl (%ecx),%eax

}
80105960:	c9                   	leave  
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX((const void *)ptr)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  pgtab = &pgtab[PTX((const void *)ptr)];
  return (int)(P2V(PTE_ADDR(*pgtab) + PTE_FLAGS(*ptr)));
80105961:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80105967:	25 ff 0f 00 00       	and    $0xfff,%eax
8010596c:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax

}
80105973:	c3                   	ret    
80105974:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010597a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105980 <sys_num_pages>:

int
sys_num_pages(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105986:	e8 a5 df ff ff       	call   80103930 <myproc>
  int temp = curproc->sz/PGSIZE;
8010598b:	8b 10                	mov    (%eax),%edx
    return temp;
  }
  else{
    return (temp+1);
  }
}
8010598d:	c9                   	leave  

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz/PGSIZE;
8010598e:	89 d0                	mov    %edx,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
80105990:	81 e2 ff 0f 00 00    	and    $0xfff,%edx

int
sys_num_pages(void)
{
  struct proc *curproc = myproc();
  int temp = curproc->sz/PGSIZE;
80105996:	c1 e8 0c             	shr    $0xc,%eax
  int temp2 = curproc->sz % PGSIZE;
  if(temp2 == 0){
    return temp;
  }
  else{
    return (temp+1);
80105999:	83 fa 01             	cmp    $0x1,%edx
8010599c:	83 d8 ff             	sbb    $0xffffffff,%eax
  }
}
8010599f:	c3                   	ret    

801059a0 <sys_forkcow>:

int
sys_forkcow(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
  return forkcow();
}
801059a3:	5d                   	pop    %ebp
}

int
sys_forkcow(void)
{
  return forkcow();
801059a4:	e9 47 e2 ff ff       	jmp    80103bf0 <forkcow>

801059a9 <alltraps>:
801059a9:	1e                   	push   %ds
801059aa:	06                   	push   %es
801059ab:	0f a0                	push   %fs
801059ad:	0f a8                	push   %gs
801059af:	60                   	pusha  
801059b0:	66 b8 10 00          	mov    $0x10,%ax
801059b4:	8e d8                	mov    %eax,%ds
801059b6:	8e c0                	mov    %eax,%es
801059b8:	54                   	push   %esp
801059b9:	e8 e2 00 00 00       	call   80105aa0 <trap>
801059be:	83 c4 04             	add    $0x4,%esp

801059c1 <trapret>:
801059c1:	61                   	popa   
801059c2:	0f a9                	pop    %gs
801059c4:	0f a1                	pop    %fs
801059c6:	07                   	pop    %es
801059c7:	1f                   	pop    %ds
801059c8:	83 c4 08             	add    $0x8,%esp
801059cb:	cf                   	iret   
801059cc:	66 90                	xchg   %ax,%ax
801059ce:	66 90                	xchg   %ax,%ax

801059d0 <tvinit>:
801059d0:	31 c0                	xor    %eax,%eax
801059d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059d8:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801059df:	b9 08 00 00 00       	mov    $0x8,%ecx
801059e4:	c6 04 c5 a4 dc 14 80 	movb   $0x0,-0x7feb235c(,%eax,8)
801059eb:	00 
801059ec:	66 89 0c c5 a2 dc 14 	mov    %cx,-0x7feb235e(,%eax,8)
801059f3:	80 
801059f4:	c6 04 c5 a5 dc 14 80 	movb   $0x8e,-0x7feb235b(,%eax,8)
801059fb:	8e 
801059fc:	66 89 14 c5 a0 dc 14 	mov    %dx,-0x7feb2360(,%eax,8)
80105a03:	80 
80105a04:	c1 ea 10             	shr    $0x10,%edx
80105a07:	66 89 14 c5 a6 dc 14 	mov    %dx,-0x7feb235a(,%eax,8)
80105a0e:	80 
80105a0f:	83 c0 01             	add    $0x1,%eax
80105a12:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a17:	75 bf                	jne    801059d8 <tvinit+0x8>
80105a19:	55                   	push   %ebp
80105a1a:	ba 08 00 00 00       	mov    $0x8,%edx
80105a1f:	89 e5                	mov    %esp,%ebp
80105a21:	83 ec 10             	sub    $0x10,%esp
80105a24:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105a29:	68 a9 7c 10 80       	push   $0x80107ca9
80105a2e:	68 60 dc 14 80       	push   $0x8014dc60
80105a33:	66 89 15 a2 de 14 80 	mov    %dx,0x8014dea2
80105a3a:	c6 05 a4 de 14 80 00 	movb   $0x0,0x8014dea4
80105a41:	66 a3 a0 de 14 80    	mov    %ax,0x8014dea0
80105a47:	c1 e8 10             	shr    $0x10,%eax
80105a4a:	c6 05 a5 de 14 80 ef 	movb   $0xef,0x8014dea5
80105a51:	66 a3 a6 de 14 80    	mov    %ax,0x8014dea6
80105a57:	e8 14 ea ff ff       	call   80104470 <initlock>
80105a5c:	83 c4 10             	add    $0x10,%esp
80105a5f:	c9                   	leave  
80105a60:	c3                   	ret    
80105a61:	eb 0d                	jmp    80105a70 <idtinit>
80105a63:	90                   	nop
80105a64:	90                   	nop
80105a65:	90                   	nop
80105a66:	90                   	nop
80105a67:	90                   	nop
80105a68:	90                   	nop
80105a69:	90                   	nop
80105a6a:	90                   	nop
80105a6b:	90                   	nop
80105a6c:	90                   	nop
80105a6d:	90                   	nop
80105a6e:	90                   	nop
80105a6f:	90                   	nop

80105a70 <idtinit>:
80105a70:	55                   	push   %ebp
80105a71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a76:	89 e5                	mov    %esp,%ebp
80105a78:	83 ec 10             	sub    $0x10,%esp
80105a7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80105a7f:	b8 a0 dc 14 80       	mov    $0x8014dca0,%eax
80105a84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80105a88:	c1 e8 10             	shr    $0x10,%eax
80105a8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80105a8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a92:	0f 01 18             	lidtl  (%eax)
80105a95:	c9                   	leave  
80105a96:	c3                   	ret    
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105aa0 <trap>:
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
80105aa5:	53                   	push   %ebx
80105aa6:	83 ec 1c             	sub    $0x1c,%esp
80105aa9:	8b 7d 08             	mov    0x8(%ebp),%edi
80105aac:	8b 47 30             	mov    0x30(%edi),%eax
80105aaf:	83 f8 40             	cmp    $0x40,%eax
80105ab2:	0f 84 a8 01 00 00    	je     80105c60 <trap+0x1c0>
80105ab8:	83 e8 0e             	sub    $0xe,%eax
80105abb:	83 f8 31             	cmp    $0x31,%eax
80105abe:	77 10                	ja     80105ad0 <trap+0x30>
80105ac0:	ff 24 85 50 7d 10 80 	jmp    *-0x7fef82b0(,%eax,4)
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ad0:	e8 5b de ff ff       	call   80103930 <myproc>
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	0f 84 f7 01 00 00    	je     80105cd4 <trap+0x234>
80105add:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105ae1:	0f 84 ed 01 00 00    	je     80105cd4 <trap+0x234>
80105ae7:	0f 20 d1             	mov    %cr2,%ecx
80105aea:	8b 57 38             	mov    0x38(%edi),%edx
80105aed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105af0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105af3:	e8 18 de ff ff       	call   80103910 <cpuid>
80105af8:	8b 77 34             	mov    0x34(%edi),%esi
80105afb:	8b 5f 30             	mov    0x30(%edi),%ebx
80105afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105b01:	e8 2a de ff ff       	call   80103930 <myproc>
80105b06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b09:	e8 22 de ff ff       	call   80103930 <myproc>
80105b0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b14:	51                   	push   %ecx
80105b15:	52                   	push   %edx
80105b16:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105b19:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b1c:	56                   	push   %esi
80105b1d:	53                   	push   %ebx
80105b1e:	83 c2 6c             	add    $0x6c,%edx
80105b21:	52                   	push   %edx
80105b22:	ff 70 10             	pushl  0x10(%eax)
80105b25:	68 0c 7d 10 80       	push   $0x80107d0c
80105b2a:	e8 31 ab ff ff       	call   80100660 <cprintf>
80105b2f:	83 c4 20             	add    $0x20,%esp
80105b32:	e8 f9 dd ff ff       	call   80103930 <myproc>
80105b37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105b3e:	66 90                	xchg   %ax,%ax
80105b40:	e8 eb dd ff ff       	call   80103930 <myproc>
80105b45:	85 c0                	test   %eax,%eax
80105b47:	74 0c                	je     80105b55 <trap+0xb5>
80105b49:	e8 e2 dd ff ff       	call   80103930 <myproc>
80105b4e:	8b 50 24             	mov    0x24(%eax),%edx
80105b51:	85 d2                	test   %edx,%edx
80105b53:	75 4b                	jne    80105ba0 <trap+0x100>
80105b55:	e8 d6 dd ff ff       	call   80103930 <myproc>
80105b5a:	85 c0                	test   %eax,%eax
80105b5c:	74 0b                	je     80105b69 <trap+0xc9>
80105b5e:	e8 cd dd ff ff       	call   80103930 <myproc>
80105b63:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b67:	74 4f                	je     80105bb8 <trap+0x118>
80105b69:	e8 c2 dd ff ff       	call   80103930 <myproc>
80105b6e:	85 c0                	test   %eax,%eax
80105b70:	74 1d                	je     80105b8f <trap+0xef>
80105b72:	e8 b9 dd ff ff       	call   80103930 <myproc>
80105b77:	8b 40 24             	mov    0x24(%eax),%eax
80105b7a:	85 c0                	test   %eax,%eax
80105b7c:	74 11                	je     80105b8f <trap+0xef>
80105b7e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b82:	83 e0 03             	and    $0x3,%eax
80105b85:	66 83 f8 03          	cmp    $0x3,%ax
80105b89:	0f 84 fa 00 00 00    	je     80105c89 <trap+0x1e9>
80105b8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b92:	5b                   	pop    %ebx
80105b93:	5e                   	pop    %esi
80105b94:	5f                   	pop    %edi
80105b95:	5d                   	pop    %ebp
80105b96:	c3                   	ret    
80105b97:	89 f6                	mov    %esi,%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ba0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ba4:	83 e0 03             	and    $0x3,%eax
80105ba7:	66 83 f8 03          	cmp    $0x3,%ax
80105bab:	75 a8                	jne    80105b55 <trap+0xb5>
80105bad:	e8 ce e2 ff ff       	call   80103e80 <exit>
80105bb2:	eb a1                	jmp    80105b55 <trap+0xb5>
80105bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bb8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105bbc:	75 ab                	jne    80105b69 <trap+0xc9>
80105bbe:	e8 ed e3 ff ff       	call   80103fb0 <yield>
80105bc3:	eb a4                	jmp    80105b69 <trap+0xc9>
80105bc5:	8d 76 00             	lea    0x0(%esi),%esi
80105bc8:	83 ec 0c             	sub    $0xc,%esp
80105bcb:	ff 77 34             	pushl  0x34(%edi)
80105bce:	e8 9d 17 00 00       	call   80107370 <pagefault>
80105bd3:	83 c4 10             	add    $0x10,%esp
80105bd6:	e9 65 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bdb:	90                   	nop
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105be0:	e8 2b dd ff ff       	call   80103910 <cpuid>
80105be5:	85 c0                	test   %eax,%eax
80105be7:	0f 84 b3 00 00 00    	je     80105ca0 <trap+0x200>
80105bed:	e8 ce cc ff ff       	call   801028c0 <lapiceoi>
80105bf2:	e9 49 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c00:	e8 7b cb ff ff       	call   80102780 <kbdintr>
80105c05:	e8 b6 cc ff ff       	call   801028c0 <lapiceoi>
80105c0a:	e9 31 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105c0f:	90                   	nop
80105c10:	e8 5b 02 00 00       	call   80105e70 <uartintr>
80105c15:	e8 a6 cc ff ff       	call   801028c0 <lapiceoi>
80105c1a:	e9 21 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105c1f:	90                   	nop
80105c20:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c24:	8b 77 38             	mov    0x38(%edi),%esi
80105c27:	e8 e4 dc ff ff       	call   80103910 <cpuid>
80105c2c:	56                   	push   %esi
80105c2d:	53                   	push   %ebx
80105c2e:	50                   	push   %eax
80105c2f:	68 b4 7c 10 80       	push   $0x80107cb4
80105c34:	e8 27 aa ff ff       	call   80100660 <cprintf>
80105c39:	e8 82 cc ff ff       	call   801028c0 <lapiceoi>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	e9 fa fe ff ff       	jmp    80105b40 <trap+0xa0>
80105c46:	8d 76 00             	lea    0x0(%esi),%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c50:	e8 fb c3 ff ff       	call   80102050 <ideintr>
80105c55:	eb 96                	jmp    80105bed <trap+0x14d>
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c60:	e8 cb dc ff ff       	call   80103930 <myproc>
80105c65:	8b 58 24             	mov    0x24(%eax),%ebx
80105c68:	85 db                	test   %ebx,%ebx
80105c6a:	75 2c                	jne    80105c98 <trap+0x1f8>
80105c6c:	e8 bf dc ff ff       	call   80103930 <myproc>
80105c71:	89 78 18             	mov    %edi,0x18(%eax)
80105c74:	e8 67 ee ff ff       	call   80104ae0 <syscall>
80105c79:	e8 b2 dc ff ff       	call   80103930 <myproc>
80105c7e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c81:	85 c9                	test   %ecx,%ecx
80105c83:	0f 84 06 ff ff ff    	je     80105b8f <trap+0xef>
80105c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c8c:	5b                   	pop    %ebx
80105c8d:	5e                   	pop    %esi
80105c8e:	5f                   	pop    %edi
80105c8f:	5d                   	pop    %ebp
80105c90:	e9 eb e1 ff ff       	jmp    80103e80 <exit>
80105c95:	8d 76 00             	lea    0x0(%esi),%esi
80105c98:	e8 e3 e1 ff ff       	call   80103e80 <exit>
80105c9d:	eb cd                	jmp    80105c6c <trap+0x1cc>
80105c9f:	90                   	nop
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	68 60 dc 14 80       	push   $0x8014dc60
80105ca8:	e8 c3 e8 ff ff       	call   80104570 <acquire>
80105cad:	c7 04 24 a0 e4 14 80 	movl   $0x8014e4a0,(%esp)
80105cb4:	83 05 a0 e4 14 80 01 	addl   $0x1,0x8014e4a0
80105cbb:	e8 f0 e4 ff ff       	call   801041b0 <wakeup>
80105cc0:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
80105cc7:	e8 c4 e9 ff ff       	call   80104690 <release>
80105ccc:	83 c4 10             	add    $0x10,%esp
80105ccf:	e9 19 ff ff ff       	jmp    80105bed <trap+0x14d>
80105cd4:	0f 20 d6             	mov    %cr2,%esi
80105cd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105cda:	e8 31 dc ff ff       	call   80103910 <cpuid>
80105cdf:	83 ec 0c             	sub    $0xc,%esp
80105ce2:	56                   	push   %esi
80105ce3:	53                   	push   %ebx
80105ce4:	50                   	push   %eax
80105ce5:	ff 77 30             	pushl  0x30(%edi)
80105ce8:	68 d8 7c 10 80       	push   $0x80107cd8
80105ced:	e8 6e a9 ff ff       	call   80100660 <cprintf>
80105cf2:	83 c4 14             	add    $0x14,%esp
80105cf5:	68 ae 7c 10 80       	push   $0x80107cae
80105cfa:	e8 71 a6 ff ff       	call   80100370 <panic>
80105cff:	90                   	nop

80105d00 <uartgetc>:
80105d00:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
80105d05:	55                   	push   %ebp
80105d06:	89 e5                	mov    %esp,%ebp
80105d08:	85 c0                	test   %eax,%eax
80105d0a:	74 1c                	je     80105d28 <uartgetc+0x28>
80105d0c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d11:	ec                   	in     (%dx),%al
80105d12:	a8 01                	test   $0x1,%al
80105d14:	74 12                	je     80105d28 <uartgetc+0x28>
80105d16:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d1b:	ec                   	in     (%dx),%al
80105d1c:	0f b6 c0             	movzbl %al,%eax
80105d1f:	5d                   	pop    %ebp
80105d20:	c3                   	ret    
80105d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d2d:	5d                   	pop    %ebp
80105d2e:	c3                   	ret    
80105d2f:	90                   	nop

80105d30 <uartputc.part.0>:
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	57                   	push   %edi
80105d34:	56                   	push   %esi
80105d35:	53                   	push   %ebx
80105d36:	89 c7                	mov    %eax,%edi
80105d38:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d3d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d42:	83 ec 0c             	sub    $0xc,%esp
80105d45:	eb 1b                	jmp    80105d62 <uartputc.part.0+0x32>
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d50:	83 ec 0c             	sub    $0xc,%esp
80105d53:	6a 0a                	push   $0xa
80105d55:	e8 86 cb ff ff       	call   801028e0 <microdelay>
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	83 eb 01             	sub    $0x1,%ebx
80105d60:	74 07                	je     80105d69 <uartputc.part.0+0x39>
80105d62:	89 f2                	mov    %esi,%edx
80105d64:	ec                   	in     (%dx),%al
80105d65:	a8 20                	test   $0x20,%al
80105d67:	74 e7                	je     80105d50 <uartputc.part.0+0x20>
80105d69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6e:	89 f8                	mov    %edi,%eax
80105d70:	ee                   	out    %al,(%dx)
80105d71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d74:	5b                   	pop    %ebx
80105d75:	5e                   	pop    %esi
80105d76:	5f                   	pop    %edi
80105d77:	5d                   	pop    %ebp
80105d78:	c3                   	ret    
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d80 <uartinit>:
80105d80:	55                   	push   %ebp
80105d81:	31 c9                	xor    %ecx,%ecx
80105d83:	89 c8                	mov    %ecx,%eax
80105d85:	89 e5                	mov    %esp,%ebp
80105d87:	57                   	push   %edi
80105d88:	56                   	push   %esi
80105d89:	53                   	push   %ebx
80105d8a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d8f:	89 da                	mov    %ebx,%edx
80105d91:	83 ec 0c             	sub    $0xc,%esp
80105d94:	ee                   	out    %al,(%dx)
80105d95:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d9f:	89 fa                	mov    %edi,%edx
80105da1:	ee                   	out    %al,(%dx)
80105da2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105da7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dac:	ee                   	out    %al,(%dx)
80105dad:	be f9 03 00 00       	mov    $0x3f9,%esi
80105db2:	89 c8                	mov    %ecx,%eax
80105db4:	89 f2                	mov    %esi,%edx
80105db6:	ee                   	out    %al,(%dx)
80105db7:	b8 03 00 00 00       	mov    $0x3,%eax
80105dbc:	89 fa                	mov    %edi,%edx
80105dbe:	ee                   	out    %al,(%dx)
80105dbf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105dc4:	89 c8                	mov    %ecx,%eax
80105dc6:	ee                   	out    %al,(%dx)
80105dc7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dcc:	89 f2                	mov    %esi,%edx
80105dce:	ee                   	out    %al,(%dx)
80105dcf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105dd4:	ec                   	in     (%dx),%al
80105dd5:	3c ff                	cmp    $0xff,%al
80105dd7:	74 5a                	je     80105e33 <uartinit+0xb3>
80105dd9:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80105de0:	00 00 00 
80105de3:	89 da                	mov    %ebx,%edx
80105de5:	ec                   	in     (%dx),%al
80105de6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105deb:	ec                   	in     (%dx),%al
80105dec:	83 ec 08             	sub    $0x8,%esp
80105def:	bb 18 7e 10 80       	mov    $0x80107e18,%ebx
80105df4:	6a 00                	push   $0x0
80105df6:	6a 04                	push   $0x4
80105df8:	e8 a3 c4 ff ff       	call   801022a0 <ioapicenable>
80105dfd:	83 c4 10             	add    $0x10,%esp
80105e00:	b8 78 00 00 00       	mov    $0x78,%eax
80105e05:	eb 13                	jmp    80105e1a <uartinit+0x9a>
80105e07:	89 f6                	mov    %esi,%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e10:	83 c3 01             	add    $0x1,%ebx
80105e13:	0f be 03             	movsbl (%ebx),%eax
80105e16:	84 c0                	test   %al,%al
80105e18:	74 19                	je     80105e33 <uartinit+0xb3>
80105e1a:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80105e20:	85 d2                	test   %edx,%edx
80105e22:	74 ec                	je     80105e10 <uartinit+0x90>
80105e24:	83 c3 01             	add    $0x1,%ebx
80105e27:	e8 04 ff ff ff       	call   80105d30 <uartputc.part.0>
80105e2c:	0f be 03             	movsbl (%ebx),%eax
80105e2f:	84 c0                	test   %al,%al
80105e31:	75 e7                	jne    80105e1a <uartinit+0x9a>
80105e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e36:	5b                   	pop    %ebx
80105e37:	5e                   	pop    %esi
80105e38:	5f                   	pop    %edi
80105e39:	5d                   	pop    %ebp
80105e3a:	c3                   	ret    
80105e3b:	90                   	nop
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e40 <uartputc>:
80105e40:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80105e46:	55                   	push   %ebp
80105e47:	89 e5                	mov    %esp,%ebp
80105e49:	85 d2                	test   %edx,%edx
80105e4b:	8b 45 08             	mov    0x8(%ebp),%eax
80105e4e:	74 10                	je     80105e60 <uartputc+0x20>
80105e50:	5d                   	pop    %ebp
80105e51:	e9 da fe ff ff       	jmp    80105d30 <uartputc.part.0>
80105e56:	8d 76 00             	lea    0x0(%esi),%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e60:	5d                   	pop    %ebp
80105e61:	c3                   	ret    
80105e62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e70 <uartintr>:
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	83 ec 14             	sub    $0x14,%esp
80105e76:	68 00 5d 10 80       	push   $0x80105d00
80105e7b:	e8 70 a9 ff ff       	call   801007f0 <consoleintr>
80105e80:	83 c4 10             	add    $0x10,%esp
80105e83:	c9                   	leave  
80105e84:	c3                   	ret    

80105e85 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $0
80105e87:	6a 00                	push   $0x0
  jmp alltraps
80105e89:	e9 1b fb ff ff       	jmp    801059a9 <alltraps>

80105e8e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $1
80105e90:	6a 01                	push   $0x1
  jmp alltraps
80105e92:	e9 12 fb ff ff       	jmp    801059a9 <alltraps>

80105e97 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $2
80105e99:	6a 02                	push   $0x2
  jmp alltraps
80105e9b:	e9 09 fb ff ff       	jmp    801059a9 <alltraps>

80105ea0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $3
80105ea2:	6a 03                	push   $0x3
  jmp alltraps
80105ea4:	e9 00 fb ff ff       	jmp    801059a9 <alltraps>

80105ea9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $4
80105eab:	6a 04                	push   $0x4
  jmp alltraps
80105ead:	e9 f7 fa ff ff       	jmp    801059a9 <alltraps>

80105eb2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $5
80105eb4:	6a 05                	push   $0x5
  jmp alltraps
80105eb6:	e9 ee fa ff ff       	jmp    801059a9 <alltraps>

80105ebb <vector6>:
.globl vector6
vector6:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $6
80105ebd:	6a 06                	push   $0x6
  jmp alltraps
80105ebf:	e9 e5 fa ff ff       	jmp    801059a9 <alltraps>

80105ec4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $7
80105ec6:	6a 07                	push   $0x7
  jmp alltraps
80105ec8:	e9 dc fa ff ff       	jmp    801059a9 <alltraps>

80105ecd <vector8>:
.globl vector8
vector8:
  pushl $8
80105ecd:	6a 08                	push   $0x8
  jmp alltraps
80105ecf:	e9 d5 fa ff ff       	jmp    801059a9 <alltraps>

80105ed4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $9
80105ed6:	6a 09                	push   $0x9
  jmp alltraps
80105ed8:	e9 cc fa ff ff       	jmp    801059a9 <alltraps>

80105edd <vector10>:
.globl vector10
vector10:
  pushl $10
80105edd:	6a 0a                	push   $0xa
  jmp alltraps
80105edf:	e9 c5 fa ff ff       	jmp    801059a9 <alltraps>

80105ee4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ee4:	6a 0b                	push   $0xb
  jmp alltraps
80105ee6:	e9 be fa ff ff       	jmp    801059a9 <alltraps>

80105eeb <vector12>:
.globl vector12
vector12:
  pushl $12
80105eeb:	6a 0c                	push   $0xc
  jmp alltraps
80105eed:	e9 b7 fa ff ff       	jmp    801059a9 <alltraps>

80105ef2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105ef2:	6a 0d                	push   $0xd
  jmp alltraps
80105ef4:	e9 b0 fa ff ff       	jmp    801059a9 <alltraps>

80105ef9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105ef9:	6a 0e                	push   $0xe
  jmp alltraps
80105efb:	e9 a9 fa ff ff       	jmp    801059a9 <alltraps>

80105f00 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $15
80105f02:	6a 0f                	push   $0xf
  jmp alltraps
80105f04:	e9 a0 fa ff ff       	jmp    801059a9 <alltraps>

80105f09 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $16
80105f0b:	6a 10                	push   $0x10
  jmp alltraps
80105f0d:	e9 97 fa ff ff       	jmp    801059a9 <alltraps>

80105f12 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f12:	6a 11                	push   $0x11
  jmp alltraps
80105f14:	e9 90 fa ff ff       	jmp    801059a9 <alltraps>

80105f19 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $18
80105f1b:	6a 12                	push   $0x12
  jmp alltraps
80105f1d:	e9 87 fa ff ff       	jmp    801059a9 <alltraps>

80105f22 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $19
80105f24:	6a 13                	push   $0x13
  jmp alltraps
80105f26:	e9 7e fa ff ff       	jmp    801059a9 <alltraps>

80105f2b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $20
80105f2d:	6a 14                	push   $0x14
  jmp alltraps
80105f2f:	e9 75 fa ff ff       	jmp    801059a9 <alltraps>

80105f34 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $21
80105f36:	6a 15                	push   $0x15
  jmp alltraps
80105f38:	e9 6c fa ff ff       	jmp    801059a9 <alltraps>

80105f3d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $22
80105f3f:	6a 16                	push   $0x16
  jmp alltraps
80105f41:	e9 63 fa ff ff       	jmp    801059a9 <alltraps>

80105f46 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $23
80105f48:	6a 17                	push   $0x17
  jmp alltraps
80105f4a:	e9 5a fa ff ff       	jmp    801059a9 <alltraps>

80105f4f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $24
80105f51:	6a 18                	push   $0x18
  jmp alltraps
80105f53:	e9 51 fa ff ff       	jmp    801059a9 <alltraps>

80105f58 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $25
80105f5a:	6a 19                	push   $0x19
  jmp alltraps
80105f5c:	e9 48 fa ff ff       	jmp    801059a9 <alltraps>

80105f61 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $26
80105f63:	6a 1a                	push   $0x1a
  jmp alltraps
80105f65:	e9 3f fa ff ff       	jmp    801059a9 <alltraps>

80105f6a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $27
80105f6c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f6e:	e9 36 fa ff ff       	jmp    801059a9 <alltraps>

80105f73 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $28
80105f75:	6a 1c                	push   $0x1c
  jmp alltraps
80105f77:	e9 2d fa ff ff       	jmp    801059a9 <alltraps>

80105f7c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $29
80105f7e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f80:	e9 24 fa ff ff       	jmp    801059a9 <alltraps>

80105f85 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $30
80105f87:	6a 1e                	push   $0x1e
  jmp alltraps
80105f89:	e9 1b fa ff ff       	jmp    801059a9 <alltraps>

80105f8e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $31
80105f90:	6a 1f                	push   $0x1f
  jmp alltraps
80105f92:	e9 12 fa ff ff       	jmp    801059a9 <alltraps>

80105f97 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $32
80105f99:	6a 20                	push   $0x20
  jmp alltraps
80105f9b:	e9 09 fa ff ff       	jmp    801059a9 <alltraps>

80105fa0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $33
80105fa2:	6a 21                	push   $0x21
  jmp alltraps
80105fa4:	e9 00 fa ff ff       	jmp    801059a9 <alltraps>

80105fa9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $34
80105fab:	6a 22                	push   $0x22
  jmp alltraps
80105fad:	e9 f7 f9 ff ff       	jmp    801059a9 <alltraps>

80105fb2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $35
80105fb4:	6a 23                	push   $0x23
  jmp alltraps
80105fb6:	e9 ee f9 ff ff       	jmp    801059a9 <alltraps>

80105fbb <vector36>:
.globl vector36
vector36:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $36
80105fbd:	6a 24                	push   $0x24
  jmp alltraps
80105fbf:	e9 e5 f9 ff ff       	jmp    801059a9 <alltraps>

80105fc4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $37
80105fc6:	6a 25                	push   $0x25
  jmp alltraps
80105fc8:	e9 dc f9 ff ff       	jmp    801059a9 <alltraps>

80105fcd <vector38>:
.globl vector38
vector38:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $38
80105fcf:	6a 26                	push   $0x26
  jmp alltraps
80105fd1:	e9 d3 f9 ff ff       	jmp    801059a9 <alltraps>

80105fd6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $39
80105fd8:	6a 27                	push   $0x27
  jmp alltraps
80105fda:	e9 ca f9 ff ff       	jmp    801059a9 <alltraps>

80105fdf <vector40>:
.globl vector40
vector40:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $40
80105fe1:	6a 28                	push   $0x28
  jmp alltraps
80105fe3:	e9 c1 f9 ff ff       	jmp    801059a9 <alltraps>

80105fe8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $41
80105fea:	6a 29                	push   $0x29
  jmp alltraps
80105fec:	e9 b8 f9 ff ff       	jmp    801059a9 <alltraps>

80105ff1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $42
80105ff3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ff5:	e9 af f9 ff ff       	jmp    801059a9 <alltraps>

80105ffa <vector43>:
.globl vector43
vector43:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $43
80105ffc:	6a 2b                	push   $0x2b
  jmp alltraps
80105ffe:	e9 a6 f9 ff ff       	jmp    801059a9 <alltraps>

80106003 <vector44>:
.globl vector44
vector44:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $44
80106005:	6a 2c                	push   $0x2c
  jmp alltraps
80106007:	e9 9d f9 ff ff       	jmp    801059a9 <alltraps>

8010600c <vector45>:
.globl vector45
vector45:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $45
8010600e:	6a 2d                	push   $0x2d
  jmp alltraps
80106010:	e9 94 f9 ff ff       	jmp    801059a9 <alltraps>

80106015 <vector46>:
.globl vector46
vector46:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $46
80106017:	6a 2e                	push   $0x2e
  jmp alltraps
80106019:	e9 8b f9 ff ff       	jmp    801059a9 <alltraps>

8010601e <vector47>:
.globl vector47
vector47:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $47
80106020:	6a 2f                	push   $0x2f
  jmp alltraps
80106022:	e9 82 f9 ff ff       	jmp    801059a9 <alltraps>

80106027 <vector48>:
.globl vector48
vector48:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $48
80106029:	6a 30                	push   $0x30
  jmp alltraps
8010602b:	e9 79 f9 ff ff       	jmp    801059a9 <alltraps>

80106030 <vector49>:
.globl vector49
vector49:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $49
80106032:	6a 31                	push   $0x31
  jmp alltraps
80106034:	e9 70 f9 ff ff       	jmp    801059a9 <alltraps>

80106039 <vector50>:
.globl vector50
vector50:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $50
8010603b:	6a 32                	push   $0x32
  jmp alltraps
8010603d:	e9 67 f9 ff ff       	jmp    801059a9 <alltraps>

80106042 <vector51>:
.globl vector51
vector51:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $51
80106044:	6a 33                	push   $0x33
  jmp alltraps
80106046:	e9 5e f9 ff ff       	jmp    801059a9 <alltraps>

8010604b <vector52>:
.globl vector52
vector52:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $52
8010604d:	6a 34                	push   $0x34
  jmp alltraps
8010604f:	e9 55 f9 ff ff       	jmp    801059a9 <alltraps>

80106054 <vector53>:
.globl vector53
vector53:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $53
80106056:	6a 35                	push   $0x35
  jmp alltraps
80106058:	e9 4c f9 ff ff       	jmp    801059a9 <alltraps>

8010605d <vector54>:
.globl vector54
vector54:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $54
8010605f:	6a 36                	push   $0x36
  jmp alltraps
80106061:	e9 43 f9 ff ff       	jmp    801059a9 <alltraps>

80106066 <vector55>:
.globl vector55
vector55:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $55
80106068:	6a 37                	push   $0x37
  jmp alltraps
8010606a:	e9 3a f9 ff ff       	jmp    801059a9 <alltraps>

8010606f <vector56>:
.globl vector56
vector56:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $56
80106071:	6a 38                	push   $0x38
  jmp alltraps
80106073:	e9 31 f9 ff ff       	jmp    801059a9 <alltraps>

80106078 <vector57>:
.globl vector57
vector57:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $57
8010607a:	6a 39                	push   $0x39
  jmp alltraps
8010607c:	e9 28 f9 ff ff       	jmp    801059a9 <alltraps>

80106081 <vector58>:
.globl vector58
vector58:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $58
80106083:	6a 3a                	push   $0x3a
  jmp alltraps
80106085:	e9 1f f9 ff ff       	jmp    801059a9 <alltraps>

8010608a <vector59>:
.globl vector59
vector59:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $59
8010608c:	6a 3b                	push   $0x3b
  jmp alltraps
8010608e:	e9 16 f9 ff ff       	jmp    801059a9 <alltraps>

80106093 <vector60>:
.globl vector60
vector60:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $60
80106095:	6a 3c                	push   $0x3c
  jmp alltraps
80106097:	e9 0d f9 ff ff       	jmp    801059a9 <alltraps>

8010609c <vector61>:
.globl vector61
vector61:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $61
8010609e:	6a 3d                	push   $0x3d
  jmp alltraps
801060a0:	e9 04 f9 ff ff       	jmp    801059a9 <alltraps>

801060a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $62
801060a7:	6a 3e                	push   $0x3e
  jmp alltraps
801060a9:	e9 fb f8 ff ff       	jmp    801059a9 <alltraps>

801060ae <vector63>:
.globl vector63
vector63:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $63
801060b0:	6a 3f                	push   $0x3f
  jmp alltraps
801060b2:	e9 f2 f8 ff ff       	jmp    801059a9 <alltraps>

801060b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $64
801060b9:	6a 40                	push   $0x40
  jmp alltraps
801060bb:	e9 e9 f8 ff ff       	jmp    801059a9 <alltraps>

801060c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $65
801060c2:	6a 41                	push   $0x41
  jmp alltraps
801060c4:	e9 e0 f8 ff ff       	jmp    801059a9 <alltraps>

801060c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $66
801060cb:	6a 42                	push   $0x42
  jmp alltraps
801060cd:	e9 d7 f8 ff ff       	jmp    801059a9 <alltraps>

801060d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $67
801060d4:	6a 43                	push   $0x43
  jmp alltraps
801060d6:	e9 ce f8 ff ff       	jmp    801059a9 <alltraps>

801060db <vector68>:
.globl vector68
vector68:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $68
801060dd:	6a 44                	push   $0x44
  jmp alltraps
801060df:	e9 c5 f8 ff ff       	jmp    801059a9 <alltraps>

801060e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $69
801060e6:	6a 45                	push   $0x45
  jmp alltraps
801060e8:	e9 bc f8 ff ff       	jmp    801059a9 <alltraps>

801060ed <vector70>:
.globl vector70
vector70:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $70
801060ef:	6a 46                	push   $0x46
  jmp alltraps
801060f1:	e9 b3 f8 ff ff       	jmp    801059a9 <alltraps>

801060f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $71
801060f8:	6a 47                	push   $0x47
  jmp alltraps
801060fa:	e9 aa f8 ff ff       	jmp    801059a9 <alltraps>

801060ff <vector72>:
.globl vector72
vector72:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $72
80106101:	6a 48                	push   $0x48
  jmp alltraps
80106103:	e9 a1 f8 ff ff       	jmp    801059a9 <alltraps>

80106108 <vector73>:
.globl vector73
vector73:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $73
8010610a:	6a 49                	push   $0x49
  jmp alltraps
8010610c:	e9 98 f8 ff ff       	jmp    801059a9 <alltraps>

80106111 <vector74>:
.globl vector74
vector74:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $74
80106113:	6a 4a                	push   $0x4a
  jmp alltraps
80106115:	e9 8f f8 ff ff       	jmp    801059a9 <alltraps>

8010611a <vector75>:
.globl vector75
vector75:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $75
8010611c:	6a 4b                	push   $0x4b
  jmp alltraps
8010611e:	e9 86 f8 ff ff       	jmp    801059a9 <alltraps>

80106123 <vector76>:
.globl vector76
vector76:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $76
80106125:	6a 4c                	push   $0x4c
  jmp alltraps
80106127:	e9 7d f8 ff ff       	jmp    801059a9 <alltraps>

8010612c <vector77>:
.globl vector77
vector77:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $77
8010612e:	6a 4d                	push   $0x4d
  jmp alltraps
80106130:	e9 74 f8 ff ff       	jmp    801059a9 <alltraps>

80106135 <vector78>:
.globl vector78
vector78:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $78
80106137:	6a 4e                	push   $0x4e
  jmp alltraps
80106139:	e9 6b f8 ff ff       	jmp    801059a9 <alltraps>

8010613e <vector79>:
.globl vector79
vector79:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $79
80106140:	6a 4f                	push   $0x4f
  jmp alltraps
80106142:	e9 62 f8 ff ff       	jmp    801059a9 <alltraps>

80106147 <vector80>:
.globl vector80
vector80:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $80
80106149:	6a 50                	push   $0x50
  jmp alltraps
8010614b:	e9 59 f8 ff ff       	jmp    801059a9 <alltraps>

80106150 <vector81>:
.globl vector81
vector81:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $81
80106152:	6a 51                	push   $0x51
  jmp alltraps
80106154:	e9 50 f8 ff ff       	jmp    801059a9 <alltraps>

80106159 <vector82>:
.globl vector82
vector82:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $82
8010615b:	6a 52                	push   $0x52
  jmp alltraps
8010615d:	e9 47 f8 ff ff       	jmp    801059a9 <alltraps>

80106162 <vector83>:
.globl vector83
vector83:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $83
80106164:	6a 53                	push   $0x53
  jmp alltraps
80106166:	e9 3e f8 ff ff       	jmp    801059a9 <alltraps>

8010616b <vector84>:
.globl vector84
vector84:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $84
8010616d:	6a 54                	push   $0x54
  jmp alltraps
8010616f:	e9 35 f8 ff ff       	jmp    801059a9 <alltraps>

80106174 <vector85>:
.globl vector85
vector85:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $85
80106176:	6a 55                	push   $0x55
  jmp alltraps
80106178:	e9 2c f8 ff ff       	jmp    801059a9 <alltraps>

8010617d <vector86>:
.globl vector86
vector86:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $86
8010617f:	6a 56                	push   $0x56
  jmp alltraps
80106181:	e9 23 f8 ff ff       	jmp    801059a9 <alltraps>

80106186 <vector87>:
.globl vector87
vector87:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $87
80106188:	6a 57                	push   $0x57
  jmp alltraps
8010618a:	e9 1a f8 ff ff       	jmp    801059a9 <alltraps>

8010618f <vector88>:
.globl vector88
vector88:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $88
80106191:	6a 58                	push   $0x58
  jmp alltraps
80106193:	e9 11 f8 ff ff       	jmp    801059a9 <alltraps>

80106198 <vector89>:
.globl vector89
vector89:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $89
8010619a:	6a 59                	push   $0x59
  jmp alltraps
8010619c:	e9 08 f8 ff ff       	jmp    801059a9 <alltraps>

801061a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $90
801061a3:	6a 5a                	push   $0x5a
  jmp alltraps
801061a5:	e9 ff f7 ff ff       	jmp    801059a9 <alltraps>

801061aa <vector91>:
.globl vector91
vector91:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $91
801061ac:	6a 5b                	push   $0x5b
  jmp alltraps
801061ae:	e9 f6 f7 ff ff       	jmp    801059a9 <alltraps>

801061b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $92
801061b5:	6a 5c                	push   $0x5c
  jmp alltraps
801061b7:	e9 ed f7 ff ff       	jmp    801059a9 <alltraps>

801061bc <vector93>:
.globl vector93
vector93:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $93
801061be:	6a 5d                	push   $0x5d
  jmp alltraps
801061c0:	e9 e4 f7 ff ff       	jmp    801059a9 <alltraps>

801061c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $94
801061c7:	6a 5e                	push   $0x5e
  jmp alltraps
801061c9:	e9 db f7 ff ff       	jmp    801059a9 <alltraps>

801061ce <vector95>:
.globl vector95
vector95:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $95
801061d0:	6a 5f                	push   $0x5f
  jmp alltraps
801061d2:	e9 d2 f7 ff ff       	jmp    801059a9 <alltraps>

801061d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $96
801061d9:	6a 60                	push   $0x60
  jmp alltraps
801061db:	e9 c9 f7 ff ff       	jmp    801059a9 <alltraps>

801061e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $97
801061e2:	6a 61                	push   $0x61
  jmp alltraps
801061e4:	e9 c0 f7 ff ff       	jmp    801059a9 <alltraps>

801061e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $98
801061eb:	6a 62                	push   $0x62
  jmp alltraps
801061ed:	e9 b7 f7 ff ff       	jmp    801059a9 <alltraps>

801061f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $99
801061f4:	6a 63                	push   $0x63
  jmp alltraps
801061f6:	e9 ae f7 ff ff       	jmp    801059a9 <alltraps>

801061fb <vector100>:
.globl vector100
vector100:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $100
801061fd:	6a 64                	push   $0x64
  jmp alltraps
801061ff:	e9 a5 f7 ff ff       	jmp    801059a9 <alltraps>

80106204 <vector101>:
.globl vector101
vector101:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $101
80106206:	6a 65                	push   $0x65
  jmp alltraps
80106208:	e9 9c f7 ff ff       	jmp    801059a9 <alltraps>

8010620d <vector102>:
.globl vector102
vector102:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $102
8010620f:	6a 66                	push   $0x66
  jmp alltraps
80106211:	e9 93 f7 ff ff       	jmp    801059a9 <alltraps>

80106216 <vector103>:
.globl vector103
vector103:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $103
80106218:	6a 67                	push   $0x67
  jmp alltraps
8010621a:	e9 8a f7 ff ff       	jmp    801059a9 <alltraps>

8010621f <vector104>:
.globl vector104
vector104:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $104
80106221:	6a 68                	push   $0x68
  jmp alltraps
80106223:	e9 81 f7 ff ff       	jmp    801059a9 <alltraps>

80106228 <vector105>:
.globl vector105
vector105:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $105
8010622a:	6a 69                	push   $0x69
  jmp alltraps
8010622c:	e9 78 f7 ff ff       	jmp    801059a9 <alltraps>

80106231 <vector106>:
.globl vector106
vector106:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $106
80106233:	6a 6a                	push   $0x6a
  jmp alltraps
80106235:	e9 6f f7 ff ff       	jmp    801059a9 <alltraps>

8010623a <vector107>:
.globl vector107
vector107:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $107
8010623c:	6a 6b                	push   $0x6b
  jmp alltraps
8010623e:	e9 66 f7 ff ff       	jmp    801059a9 <alltraps>

80106243 <vector108>:
.globl vector108
vector108:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $108
80106245:	6a 6c                	push   $0x6c
  jmp alltraps
80106247:	e9 5d f7 ff ff       	jmp    801059a9 <alltraps>

8010624c <vector109>:
.globl vector109
vector109:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $109
8010624e:	6a 6d                	push   $0x6d
  jmp alltraps
80106250:	e9 54 f7 ff ff       	jmp    801059a9 <alltraps>

80106255 <vector110>:
.globl vector110
vector110:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $110
80106257:	6a 6e                	push   $0x6e
  jmp alltraps
80106259:	e9 4b f7 ff ff       	jmp    801059a9 <alltraps>

8010625e <vector111>:
.globl vector111
vector111:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $111
80106260:	6a 6f                	push   $0x6f
  jmp alltraps
80106262:	e9 42 f7 ff ff       	jmp    801059a9 <alltraps>

80106267 <vector112>:
.globl vector112
vector112:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $112
80106269:	6a 70                	push   $0x70
  jmp alltraps
8010626b:	e9 39 f7 ff ff       	jmp    801059a9 <alltraps>

80106270 <vector113>:
.globl vector113
vector113:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $113
80106272:	6a 71                	push   $0x71
  jmp alltraps
80106274:	e9 30 f7 ff ff       	jmp    801059a9 <alltraps>

80106279 <vector114>:
.globl vector114
vector114:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $114
8010627b:	6a 72                	push   $0x72
  jmp alltraps
8010627d:	e9 27 f7 ff ff       	jmp    801059a9 <alltraps>

80106282 <vector115>:
.globl vector115
vector115:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $115
80106284:	6a 73                	push   $0x73
  jmp alltraps
80106286:	e9 1e f7 ff ff       	jmp    801059a9 <alltraps>

8010628b <vector116>:
.globl vector116
vector116:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $116
8010628d:	6a 74                	push   $0x74
  jmp alltraps
8010628f:	e9 15 f7 ff ff       	jmp    801059a9 <alltraps>

80106294 <vector117>:
.globl vector117
vector117:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $117
80106296:	6a 75                	push   $0x75
  jmp alltraps
80106298:	e9 0c f7 ff ff       	jmp    801059a9 <alltraps>

8010629d <vector118>:
.globl vector118
vector118:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $118
8010629f:	6a 76                	push   $0x76
  jmp alltraps
801062a1:	e9 03 f7 ff ff       	jmp    801059a9 <alltraps>

801062a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $119
801062a8:	6a 77                	push   $0x77
  jmp alltraps
801062aa:	e9 fa f6 ff ff       	jmp    801059a9 <alltraps>

801062af <vector120>:
.globl vector120
vector120:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $120
801062b1:	6a 78                	push   $0x78
  jmp alltraps
801062b3:	e9 f1 f6 ff ff       	jmp    801059a9 <alltraps>

801062b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $121
801062ba:	6a 79                	push   $0x79
  jmp alltraps
801062bc:	e9 e8 f6 ff ff       	jmp    801059a9 <alltraps>

801062c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $122
801062c3:	6a 7a                	push   $0x7a
  jmp alltraps
801062c5:	e9 df f6 ff ff       	jmp    801059a9 <alltraps>

801062ca <vector123>:
.globl vector123
vector123:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $123
801062cc:	6a 7b                	push   $0x7b
  jmp alltraps
801062ce:	e9 d6 f6 ff ff       	jmp    801059a9 <alltraps>

801062d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $124
801062d5:	6a 7c                	push   $0x7c
  jmp alltraps
801062d7:	e9 cd f6 ff ff       	jmp    801059a9 <alltraps>

801062dc <vector125>:
.globl vector125
vector125:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $125
801062de:	6a 7d                	push   $0x7d
  jmp alltraps
801062e0:	e9 c4 f6 ff ff       	jmp    801059a9 <alltraps>

801062e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $126
801062e7:	6a 7e                	push   $0x7e
  jmp alltraps
801062e9:	e9 bb f6 ff ff       	jmp    801059a9 <alltraps>

801062ee <vector127>:
.globl vector127
vector127:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $127
801062f0:	6a 7f                	push   $0x7f
  jmp alltraps
801062f2:	e9 b2 f6 ff ff       	jmp    801059a9 <alltraps>

801062f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $128
801062f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801062fe:	e9 a6 f6 ff ff       	jmp    801059a9 <alltraps>

80106303 <vector129>:
.globl vector129
vector129:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $129
80106305:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010630a:	e9 9a f6 ff ff       	jmp    801059a9 <alltraps>

8010630f <vector130>:
.globl vector130
vector130:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $130
80106311:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106316:	e9 8e f6 ff ff       	jmp    801059a9 <alltraps>

8010631b <vector131>:
.globl vector131
vector131:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $131
8010631d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106322:	e9 82 f6 ff ff       	jmp    801059a9 <alltraps>

80106327 <vector132>:
.globl vector132
vector132:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $132
80106329:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010632e:	e9 76 f6 ff ff       	jmp    801059a9 <alltraps>

80106333 <vector133>:
.globl vector133
vector133:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $133
80106335:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010633a:	e9 6a f6 ff ff       	jmp    801059a9 <alltraps>

8010633f <vector134>:
.globl vector134
vector134:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $134
80106341:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106346:	e9 5e f6 ff ff       	jmp    801059a9 <alltraps>

8010634b <vector135>:
.globl vector135
vector135:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $135
8010634d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106352:	e9 52 f6 ff ff       	jmp    801059a9 <alltraps>

80106357 <vector136>:
.globl vector136
vector136:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $136
80106359:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010635e:	e9 46 f6 ff ff       	jmp    801059a9 <alltraps>

80106363 <vector137>:
.globl vector137
vector137:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $137
80106365:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010636a:	e9 3a f6 ff ff       	jmp    801059a9 <alltraps>

8010636f <vector138>:
.globl vector138
vector138:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $138
80106371:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106376:	e9 2e f6 ff ff       	jmp    801059a9 <alltraps>

8010637b <vector139>:
.globl vector139
vector139:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $139
8010637d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106382:	e9 22 f6 ff ff       	jmp    801059a9 <alltraps>

80106387 <vector140>:
.globl vector140
vector140:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $140
80106389:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010638e:	e9 16 f6 ff ff       	jmp    801059a9 <alltraps>

80106393 <vector141>:
.globl vector141
vector141:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $141
80106395:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010639a:	e9 0a f6 ff ff       	jmp    801059a9 <alltraps>

8010639f <vector142>:
.globl vector142
vector142:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $142
801063a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801063a6:	e9 fe f5 ff ff       	jmp    801059a9 <alltraps>

801063ab <vector143>:
.globl vector143
vector143:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $143
801063ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801063b2:	e9 f2 f5 ff ff       	jmp    801059a9 <alltraps>

801063b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $144
801063b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801063be:	e9 e6 f5 ff ff       	jmp    801059a9 <alltraps>

801063c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $145
801063c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801063ca:	e9 da f5 ff ff       	jmp    801059a9 <alltraps>

801063cf <vector146>:
.globl vector146
vector146:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $146
801063d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801063d6:	e9 ce f5 ff ff       	jmp    801059a9 <alltraps>

801063db <vector147>:
.globl vector147
vector147:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $147
801063dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063e2:	e9 c2 f5 ff ff       	jmp    801059a9 <alltraps>

801063e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $148
801063e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063ee:	e9 b6 f5 ff ff       	jmp    801059a9 <alltraps>

801063f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $149
801063f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801063fa:	e9 aa f5 ff ff       	jmp    801059a9 <alltraps>

801063ff <vector150>:
.globl vector150
vector150:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $150
80106401:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106406:	e9 9e f5 ff ff       	jmp    801059a9 <alltraps>

8010640b <vector151>:
.globl vector151
vector151:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $151
8010640d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106412:	e9 92 f5 ff ff       	jmp    801059a9 <alltraps>

80106417 <vector152>:
.globl vector152
vector152:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $152
80106419:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010641e:	e9 86 f5 ff ff       	jmp    801059a9 <alltraps>

80106423 <vector153>:
.globl vector153
vector153:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $153
80106425:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010642a:	e9 7a f5 ff ff       	jmp    801059a9 <alltraps>

8010642f <vector154>:
.globl vector154
vector154:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $154
80106431:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106436:	e9 6e f5 ff ff       	jmp    801059a9 <alltraps>

8010643b <vector155>:
.globl vector155
vector155:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $155
8010643d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106442:	e9 62 f5 ff ff       	jmp    801059a9 <alltraps>

80106447 <vector156>:
.globl vector156
vector156:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $156
80106449:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010644e:	e9 56 f5 ff ff       	jmp    801059a9 <alltraps>

80106453 <vector157>:
.globl vector157
vector157:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $157
80106455:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010645a:	e9 4a f5 ff ff       	jmp    801059a9 <alltraps>

8010645f <vector158>:
.globl vector158
vector158:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $158
80106461:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106466:	e9 3e f5 ff ff       	jmp    801059a9 <alltraps>

8010646b <vector159>:
.globl vector159
vector159:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $159
8010646d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106472:	e9 32 f5 ff ff       	jmp    801059a9 <alltraps>

80106477 <vector160>:
.globl vector160
vector160:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $160
80106479:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010647e:	e9 26 f5 ff ff       	jmp    801059a9 <alltraps>

80106483 <vector161>:
.globl vector161
vector161:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $161
80106485:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010648a:	e9 1a f5 ff ff       	jmp    801059a9 <alltraps>

8010648f <vector162>:
.globl vector162
vector162:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $162
80106491:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106496:	e9 0e f5 ff ff       	jmp    801059a9 <alltraps>

8010649b <vector163>:
.globl vector163
vector163:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $163
8010649d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801064a2:	e9 02 f5 ff ff       	jmp    801059a9 <alltraps>

801064a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $164
801064a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801064ae:	e9 f6 f4 ff ff       	jmp    801059a9 <alltraps>

801064b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $165
801064b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801064ba:	e9 ea f4 ff ff       	jmp    801059a9 <alltraps>

801064bf <vector166>:
.globl vector166
vector166:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $166
801064c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801064c6:	e9 de f4 ff ff       	jmp    801059a9 <alltraps>

801064cb <vector167>:
.globl vector167
vector167:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $167
801064cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801064d2:	e9 d2 f4 ff ff       	jmp    801059a9 <alltraps>

801064d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $168
801064d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801064de:	e9 c6 f4 ff ff       	jmp    801059a9 <alltraps>

801064e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $169
801064e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064ea:	e9 ba f4 ff ff       	jmp    801059a9 <alltraps>

801064ef <vector170>:
.globl vector170
vector170:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $170
801064f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801064f6:	e9 ae f4 ff ff       	jmp    801059a9 <alltraps>

801064fb <vector171>:
.globl vector171
vector171:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $171
801064fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106502:	e9 a2 f4 ff ff       	jmp    801059a9 <alltraps>

80106507 <vector172>:
.globl vector172
vector172:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $172
80106509:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010650e:	e9 96 f4 ff ff       	jmp    801059a9 <alltraps>

80106513 <vector173>:
.globl vector173
vector173:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $173
80106515:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010651a:	e9 8a f4 ff ff       	jmp    801059a9 <alltraps>

8010651f <vector174>:
.globl vector174
vector174:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $174
80106521:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106526:	e9 7e f4 ff ff       	jmp    801059a9 <alltraps>

8010652b <vector175>:
.globl vector175
vector175:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $175
8010652d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106532:	e9 72 f4 ff ff       	jmp    801059a9 <alltraps>

80106537 <vector176>:
.globl vector176
vector176:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $176
80106539:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010653e:	e9 66 f4 ff ff       	jmp    801059a9 <alltraps>

80106543 <vector177>:
.globl vector177
vector177:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $177
80106545:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010654a:	e9 5a f4 ff ff       	jmp    801059a9 <alltraps>

8010654f <vector178>:
.globl vector178
vector178:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $178
80106551:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106556:	e9 4e f4 ff ff       	jmp    801059a9 <alltraps>

8010655b <vector179>:
.globl vector179
vector179:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $179
8010655d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106562:	e9 42 f4 ff ff       	jmp    801059a9 <alltraps>

80106567 <vector180>:
.globl vector180
vector180:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $180
80106569:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010656e:	e9 36 f4 ff ff       	jmp    801059a9 <alltraps>

80106573 <vector181>:
.globl vector181
vector181:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $181
80106575:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010657a:	e9 2a f4 ff ff       	jmp    801059a9 <alltraps>

8010657f <vector182>:
.globl vector182
vector182:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $182
80106581:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106586:	e9 1e f4 ff ff       	jmp    801059a9 <alltraps>

8010658b <vector183>:
.globl vector183
vector183:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $183
8010658d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106592:	e9 12 f4 ff ff       	jmp    801059a9 <alltraps>

80106597 <vector184>:
.globl vector184
vector184:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $184
80106599:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010659e:	e9 06 f4 ff ff       	jmp    801059a9 <alltraps>

801065a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $185
801065a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801065aa:	e9 fa f3 ff ff       	jmp    801059a9 <alltraps>

801065af <vector186>:
.globl vector186
vector186:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $186
801065b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801065b6:	e9 ee f3 ff ff       	jmp    801059a9 <alltraps>

801065bb <vector187>:
.globl vector187
vector187:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $187
801065bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801065c2:	e9 e2 f3 ff ff       	jmp    801059a9 <alltraps>

801065c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $188
801065c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801065ce:	e9 d6 f3 ff ff       	jmp    801059a9 <alltraps>

801065d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $189
801065d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801065da:	e9 ca f3 ff ff       	jmp    801059a9 <alltraps>

801065df <vector190>:
.globl vector190
vector190:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $190
801065e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065e6:	e9 be f3 ff ff       	jmp    801059a9 <alltraps>

801065eb <vector191>:
.globl vector191
vector191:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $191
801065ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801065f2:	e9 b2 f3 ff ff       	jmp    801059a9 <alltraps>

801065f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $192
801065f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801065fe:	e9 a6 f3 ff ff       	jmp    801059a9 <alltraps>

80106603 <vector193>:
.globl vector193
vector193:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $193
80106605:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010660a:	e9 9a f3 ff ff       	jmp    801059a9 <alltraps>

8010660f <vector194>:
.globl vector194
vector194:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $194
80106611:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106616:	e9 8e f3 ff ff       	jmp    801059a9 <alltraps>

8010661b <vector195>:
.globl vector195
vector195:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $195
8010661d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106622:	e9 82 f3 ff ff       	jmp    801059a9 <alltraps>

80106627 <vector196>:
.globl vector196
vector196:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $196
80106629:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010662e:	e9 76 f3 ff ff       	jmp    801059a9 <alltraps>

80106633 <vector197>:
.globl vector197
vector197:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $197
80106635:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010663a:	e9 6a f3 ff ff       	jmp    801059a9 <alltraps>

8010663f <vector198>:
.globl vector198
vector198:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $198
80106641:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106646:	e9 5e f3 ff ff       	jmp    801059a9 <alltraps>

8010664b <vector199>:
.globl vector199
vector199:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $199
8010664d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106652:	e9 52 f3 ff ff       	jmp    801059a9 <alltraps>

80106657 <vector200>:
.globl vector200
vector200:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $200
80106659:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010665e:	e9 46 f3 ff ff       	jmp    801059a9 <alltraps>

80106663 <vector201>:
.globl vector201
vector201:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $201
80106665:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010666a:	e9 3a f3 ff ff       	jmp    801059a9 <alltraps>

8010666f <vector202>:
.globl vector202
vector202:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $202
80106671:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106676:	e9 2e f3 ff ff       	jmp    801059a9 <alltraps>

8010667b <vector203>:
.globl vector203
vector203:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $203
8010667d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106682:	e9 22 f3 ff ff       	jmp    801059a9 <alltraps>

80106687 <vector204>:
.globl vector204
vector204:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $204
80106689:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010668e:	e9 16 f3 ff ff       	jmp    801059a9 <alltraps>

80106693 <vector205>:
.globl vector205
vector205:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $205
80106695:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010669a:	e9 0a f3 ff ff       	jmp    801059a9 <alltraps>

8010669f <vector206>:
.globl vector206
vector206:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $206
801066a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801066a6:	e9 fe f2 ff ff       	jmp    801059a9 <alltraps>

801066ab <vector207>:
.globl vector207
vector207:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $207
801066ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801066b2:	e9 f2 f2 ff ff       	jmp    801059a9 <alltraps>

801066b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $208
801066b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801066be:	e9 e6 f2 ff ff       	jmp    801059a9 <alltraps>

801066c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $209
801066c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801066ca:	e9 da f2 ff ff       	jmp    801059a9 <alltraps>

801066cf <vector210>:
.globl vector210
vector210:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $210
801066d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801066d6:	e9 ce f2 ff ff       	jmp    801059a9 <alltraps>

801066db <vector211>:
.globl vector211
vector211:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $211
801066dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066e2:	e9 c2 f2 ff ff       	jmp    801059a9 <alltraps>

801066e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $212
801066e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066ee:	e9 b6 f2 ff ff       	jmp    801059a9 <alltraps>

801066f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $213
801066f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801066fa:	e9 aa f2 ff ff       	jmp    801059a9 <alltraps>

801066ff <vector214>:
.globl vector214
vector214:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $214
80106701:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106706:	e9 9e f2 ff ff       	jmp    801059a9 <alltraps>

8010670b <vector215>:
.globl vector215
vector215:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $215
8010670d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106712:	e9 92 f2 ff ff       	jmp    801059a9 <alltraps>

80106717 <vector216>:
.globl vector216
vector216:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $216
80106719:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010671e:	e9 86 f2 ff ff       	jmp    801059a9 <alltraps>

80106723 <vector217>:
.globl vector217
vector217:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $217
80106725:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010672a:	e9 7a f2 ff ff       	jmp    801059a9 <alltraps>

8010672f <vector218>:
.globl vector218
vector218:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $218
80106731:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106736:	e9 6e f2 ff ff       	jmp    801059a9 <alltraps>

8010673b <vector219>:
.globl vector219
vector219:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $219
8010673d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106742:	e9 62 f2 ff ff       	jmp    801059a9 <alltraps>

80106747 <vector220>:
.globl vector220
vector220:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $220
80106749:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010674e:	e9 56 f2 ff ff       	jmp    801059a9 <alltraps>

80106753 <vector221>:
.globl vector221
vector221:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $221
80106755:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010675a:	e9 4a f2 ff ff       	jmp    801059a9 <alltraps>

8010675f <vector222>:
.globl vector222
vector222:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $222
80106761:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106766:	e9 3e f2 ff ff       	jmp    801059a9 <alltraps>

8010676b <vector223>:
.globl vector223
vector223:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $223
8010676d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106772:	e9 32 f2 ff ff       	jmp    801059a9 <alltraps>

80106777 <vector224>:
.globl vector224
vector224:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $224
80106779:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010677e:	e9 26 f2 ff ff       	jmp    801059a9 <alltraps>

80106783 <vector225>:
.globl vector225
vector225:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $225
80106785:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010678a:	e9 1a f2 ff ff       	jmp    801059a9 <alltraps>

8010678f <vector226>:
.globl vector226
vector226:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $226
80106791:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106796:	e9 0e f2 ff ff       	jmp    801059a9 <alltraps>

8010679b <vector227>:
.globl vector227
vector227:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $227
8010679d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801067a2:	e9 02 f2 ff ff       	jmp    801059a9 <alltraps>

801067a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $228
801067a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801067ae:	e9 f6 f1 ff ff       	jmp    801059a9 <alltraps>

801067b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $229
801067b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801067ba:	e9 ea f1 ff ff       	jmp    801059a9 <alltraps>

801067bf <vector230>:
.globl vector230
vector230:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $230
801067c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801067c6:	e9 de f1 ff ff       	jmp    801059a9 <alltraps>

801067cb <vector231>:
.globl vector231
vector231:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $231
801067cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801067d2:	e9 d2 f1 ff ff       	jmp    801059a9 <alltraps>

801067d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $232
801067d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801067de:	e9 c6 f1 ff ff       	jmp    801059a9 <alltraps>

801067e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $233
801067e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067ea:	e9 ba f1 ff ff       	jmp    801059a9 <alltraps>

801067ef <vector234>:
.globl vector234
vector234:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $234
801067f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801067f6:	e9 ae f1 ff ff       	jmp    801059a9 <alltraps>

801067fb <vector235>:
.globl vector235
vector235:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $235
801067fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106802:	e9 a2 f1 ff ff       	jmp    801059a9 <alltraps>

80106807 <vector236>:
.globl vector236
vector236:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $236
80106809:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010680e:	e9 96 f1 ff ff       	jmp    801059a9 <alltraps>

80106813 <vector237>:
.globl vector237
vector237:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $237
80106815:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010681a:	e9 8a f1 ff ff       	jmp    801059a9 <alltraps>

8010681f <vector238>:
.globl vector238
vector238:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $238
80106821:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106826:	e9 7e f1 ff ff       	jmp    801059a9 <alltraps>

8010682b <vector239>:
.globl vector239
vector239:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $239
8010682d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106832:	e9 72 f1 ff ff       	jmp    801059a9 <alltraps>

80106837 <vector240>:
.globl vector240
vector240:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $240
80106839:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010683e:	e9 66 f1 ff ff       	jmp    801059a9 <alltraps>

80106843 <vector241>:
.globl vector241
vector241:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $241
80106845:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010684a:	e9 5a f1 ff ff       	jmp    801059a9 <alltraps>

8010684f <vector242>:
.globl vector242
vector242:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $242
80106851:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106856:	e9 4e f1 ff ff       	jmp    801059a9 <alltraps>

8010685b <vector243>:
.globl vector243
vector243:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $243
8010685d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106862:	e9 42 f1 ff ff       	jmp    801059a9 <alltraps>

80106867 <vector244>:
.globl vector244
vector244:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $244
80106869:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010686e:	e9 36 f1 ff ff       	jmp    801059a9 <alltraps>

80106873 <vector245>:
.globl vector245
vector245:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $245
80106875:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010687a:	e9 2a f1 ff ff       	jmp    801059a9 <alltraps>

8010687f <vector246>:
.globl vector246
vector246:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $246
80106881:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106886:	e9 1e f1 ff ff       	jmp    801059a9 <alltraps>

8010688b <vector247>:
.globl vector247
vector247:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $247
8010688d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106892:	e9 12 f1 ff ff       	jmp    801059a9 <alltraps>

80106897 <vector248>:
.globl vector248
vector248:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $248
80106899:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010689e:	e9 06 f1 ff ff       	jmp    801059a9 <alltraps>

801068a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $249
801068a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801068aa:	e9 fa f0 ff ff       	jmp    801059a9 <alltraps>

801068af <vector250>:
.globl vector250
vector250:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $250
801068b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801068b6:	e9 ee f0 ff ff       	jmp    801059a9 <alltraps>

801068bb <vector251>:
.globl vector251
vector251:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $251
801068bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801068c2:	e9 e2 f0 ff ff       	jmp    801059a9 <alltraps>

801068c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $252
801068c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801068ce:	e9 d6 f0 ff ff       	jmp    801059a9 <alltraps>

801068d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $253
801068d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801068da:	e9 ca f0 ff ff       	jmp    801059a9 <alltraps>

801068df <vector254>:
.globl vector254
vector254:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $254
801068e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068e6:	e9 be f0 ff ff       	jmp    801059a9 <alltraps>

801068eb <vector255>:
.globl vector255
vector255:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $255
801068ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801068f2:	e9 b2 f0 ff ff       	jmp    801059a9 <alltraps>
801068f7:	66 90                	xchg   %ax,%ax
801068f9:	66 90                	xchg   %ax,%ax
801068fb:	66 90                	xchg   %ax,%ax
801068fd:	66 90                	xchg   %ax,%ax
801068ff:	90                   	nop

80106900 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
80106906:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;
  pde = &pgdir[PDX(va)];
80106908:	c1 ea 16             	shr    $0x16,%edx
8010690b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010690e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106911:	8b 07                	mov    (%edi),%eax
80106913:	a8 01                	test   $0x1,%al
80106915:	74 29                	je     80106940 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106917:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010691c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106922:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106925:	c1 eb 0a             	shr    $0xa,%ebx
80106928:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010692e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106931:	5b                   	pop    %ebx
80106932:	5e                   	pop    %esi
80106933:	5f                   	pop    %edi
80106934:	5d                   	pop    %ebp
80106935:	c3                   	ret    
80106936:	8d 76 00             	lea    0x0(%esi),%esi
80106939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pte_t *pgtab;
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106940:	85 c9                	test   %ecx,%ecx
80106942:	74 2c                	je     80106970 <walkpgdir+0x70>
80106944:	e8 c7 bb ff ff       	call   80102510 <kalloc>
80106949:	85 c0                	test   %eax,%eax
8010694b:	89 c6                	mov    %eax,%esi
8010694d:	74 21                	je     80106970 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero. 
    memset(pgtab, 0, PGSIZE);
8010694f:	83 ec 04             	sub    $0x4,%esp
80106952:	68 00 10 00 00       	push   $0x1000
80106957:	6a 00                	push   $0x0
80106959:	50                   	push   %eax
8010695a:	e8 81 dd ff ff       	call   801046e0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010695f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106965:	83 c4 10             	add    $0x10,%esp
80106968:	83 c8 07             	or     $0x7,%eax
8010696b:	89 07                	mov    %eax,(%edi)
8010696d:	eb b3                	jmp    80106922 <walkpgdir+0x22>
8010696f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106970:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106973:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106975:	5b                   	pop    %ebx
80106976:	5e                   	pop    %esi
80106977:	5f                   	pop    %edi
80106978:	5d                   	pop    %ebp
80106979:	c3                   	ret    
8010697a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106980 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106986:	89 d3                	mov    %edx,%ebx
80106988:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010698e:	83 ec 1c             	sub    $0x1c,%esp
80106991:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106994:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106998:	8b 7d 08             	mov    0x8(%ebp),%edi
8010699b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069a6:	29 df                	sub    %ebx,%edi
801069a8:	83 c8 01             	or     $0x1,%eax
801069ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069ae:	eb 15                	jmp    801069c5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801069b0:	f6 00 01             	testb  $0x1,(%eax)
801069b3:	75 45                	jne    801069fa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801069b5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801069b8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069bb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069bd:	74 31                	je     801069f0 <mappages+0x70>
      break;
    a += PGSIZE;
801069bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069c8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069cd:	89 da                	mov    %ebx,%edx
801069cf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069d2:	e8 29 ff ff ff       	call   80106900 <walkpgdir>
801069d7:	85 c0                	test   %eax,%eax
801069d9:	75 d5                	jne    801069b0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069db:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801069de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069e3:	5b                   	pop    %ebx
801069e4:	5e                   	pop    %esi
801069e5:	5f                   	pop    %edi
801069e6:	5d                   	pop    %ebp
801069e7:	c3                   	ret    
801069e8:	90                   	nop
801069e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801069f3:	31 c0                	xor    %eax,%eax
}
801069f5:	5b                   	pop    %ebx
801069f6:	5e                   	pop    %esi
801069f7:	5f                   	pop    %edi
801069f8:	5d                   	pop    %ebp
801069f9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801069fa:	83 ec 0c             	sub    $0xc,%esp
801069fd:	68 20 7e 10 80       	push   $0x80107e20
80106a02:	e8 69 99 ff ff       	call   80100370 <panic>
80106a07:	89 f6                	mov    %esi,%esi
80106a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a10 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a16:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a1c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a1e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a24:	83 ec 1c             	sub    $0x1c,%esp
80106a27:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a2a:	39 d3                	cmp    %edx,%ebx
80106a2c:	73 66                	jae    80106a94 <deallocuvm.part.0+0x84>
80106a2e:	89 d6                	mov    %edx,%esi
80106a30:	eb 3d                	jmp    80106a6f <deallocuvm.part.0+0x5f>
80106a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a38:	8b 10                	mov    (%eax),%edx
80106a3a:	f6 c2 01             	test   $0x1,%dl
80106a3d:	74 26                	je     80106a65 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a3f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a45:	74 58                	je     80106a9f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a47:	83 ec 0c             	sub    $0xc,%esp
80106a4a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a53:	52                   	push   %edx
80106a54:	e8 87 b8 ff ff       	call   801022e0 <kfree>
      *pte = 0;
80106a59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a5c:	83 c4 10             	add    $0x10,%esp
80106a5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a65:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a6b:	39 f3                	cmp    %esi,%ebx
80106a6d:	73 25                	jae    80106a94 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a6f:	31 c9                	xor    %ecx,%ecx
80106a71:	89 da                	mov    %ebx,%edx
80106a73:	89 f8                	mov    %edi,%eax
80106a75:	e8 86 fe ff ff       	call   80106900 <walkpgdir>
    if(!pte)
80106a7a:	85 c0                	test   %eax,%eax
80106a7c:	75 ba                	jne    80106a38 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a7e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a84:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a90:	39 f3                	cmp    %esi,%ebx
80106a92:	72 db                	jb     80106a6f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a9a:	5b                   	pop    %ebx
80106a9b:	5e                   	pop    %esi
80106a9c:	5f                   	pop    %edi
80106a9d:	5d                   	pop    %ebp
80106a9e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	68 46 77 10 80       	push   $0x80107746
80106aa7:	e8 c4 98 ff ff       	call   80100370 <panic>
80106aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ab0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106ab6:	e8 55 ce ff ff       	call   80103910 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106abb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106ac1:	31 c9                	xor    %ecx,%ecx
80106ac3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ac8:	66 89 90 f8 b7 14 80 	mov    %dx,-0x7feb4808(%eax)
80106acf:	66 89 88 fa b7 14 80 	mov    %cx,-0x7feb4806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ad6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106adb:	31 c9                	xor    %ecx,%ecx
80106add:	66 89 90 00 b8 14 80 	mov    %dx,-0x7feb4800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ae4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ae9:	66 89 88 02 b8 14 80 	mov    %cx,-0x7feb47fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106af0:	31 c9                	xor    %ecx,%ecx
80106af2:	66 89 90 08 b8 14 80 	mov    %dx,-0x7feb47f8(%eax)
80106af9:	66 89 88 0a b8 14 80 	mov    %cx,-0x7feb47f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b00:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b05:	31 c9                	xor    %ecx,%ecx
80106b07:	66 89 90 10 b8 14 80 	mov    %dx,-0x7feb47f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b0e:	c6 80 fc b7 14 80 00 	movb   $0x0,-0x7feb4804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106b15:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106b1a:	c6 80 fd b7 14 80 9a 	movb   $0x9a,-0x7feb4803(%eax)
80106b21:	c6 80 fe b7 14 80 cf 	movb   $0xcf,-0x7feb4802(%eax)
80106b28:	c6 80 ff b7 14 80 00 	movb   $0x0,-0x7feb4801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b2f:	c6 80 04 b8 14 80 00 	movb   $0x0,-0x7feb47fc(%eax)
80106b36:	c6 80 05 b8 14 80 92 	movb   $0x92,-0x7feb47fb(%eax)
80106b3d:	c6 80 06 b8 14 80 cf 	movb   $0xcf,-0x7feb47fa(%eax)
80106b44:	c6 80 07 b8 14 80 00 	movb   $0x0,-0x7feb47f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b4b:	c6 80 0c b8 14 80 00 	movb   $0x0,-0x7feb47f4(%eax)
80106b52:	c6 80 0d b8 14 80 fa 	movb   $0xfa,-0x7feb47f3(%eax)
80106b59:	c6 80 0e b8 14 80 cf 	movb   $0xcf,-0x7feb47f2(%eax)
80106b60:	c6 80 0f b8 14 80 00 	movb   $0x0,-0x7feb47f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b67:	66 89 88 12 b8 14 80 	mov    %cx,-0x7feb47ee(%eax)
80106b6e:	c6 80 14 b8 14 80 00 	movb   $0x0,-0x7feb47ec(%eax)
80106b75:	c6 80 15 b8 14 80 f2 	movb   $0xf2,-0x7feb47eb(%eax)
80106b7c:	c6 80 16 b8 14 80 cf 	movb   $0xcf,-0x7feb47ea(%eax)
80106b83:	c6 80 17 b8 14 80 00 	movb   $0x0,-0x7feb47e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b8a:	05 f0 b7 14 80       	add    $0x8014b7f0,%eax
80106b8f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b93:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b97:	c1 e8 10             	shr    $0x10,%eax
80106b9a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b9e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ba1:	0f 01 10             	lgdtl  (%eax)
}
80106ba4:	c9                   	leave  
80106ba5:	c3                   	ret    
80106ba6:	8d 76 00             	lea    0x0(%esi),%esi
80106ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bb0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106bb0:	a1 a4 e4 14 80       	mov    0x8014e4a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106bb5:	55                   	push   %ebp
80106bb6:	89 e5                	mov    %esp,%ebp
80106bb8:	05 00 00 00 80       	add    $0x80000000,%eax
80106bbd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106bc0:	5d                   	pop    %ebp
80106bc1:	c3                   	ret    
80106bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bd0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
80106bd9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bdc:	85 f6                	test   %esi,%esi
80106bde:	0f 84 cd 00 00 00    	je     80106cb1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106be4:	8b 46 08             	mov    0x8(%esi),%eax
80106be7:	85 c0                	test   %eax,%eax
80106be9:	0f 84 dc 00 00 00    	je     80106ccb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106bef:	8b 7e 04             	mov    0x4(%esi),%edi
80106bf2:	85 ff                	test   %edi,%edi
80106bf4:	0f 84 c4 00 00 00    	je     80106cbe <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106bfa:	e8 31 d9 ff ff       	call   80104530 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bff:	e8 8c cc ff ff       	call   80103890 <mycpu>
80106c04:	89 c3                	mov    %eax,%ebx
80106c06:	e8 85 cc ff ff       	call   80103890 <mycpu>
80106c0b:	89 c7                	mov    %eax,%edi
80106c0d:	e8 7e cc ff ff       	call   80103890 <mycpu>
80106c12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c15:	83 c7 08             	add    $0x8,%edi
80106c18:	e8 73 cc ff ff       	call   80103890 <mycpu>
80106c1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c20:	83 c0 08             	add    $0x8,%eax
80106c23:	ba 67 00 00 00       	mov    $0x67,%edx
80106c28:	c1 e8 18             	shr    $0x18,%eax
80106c2b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106c32:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c39:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106c40:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106c47:	83 c1 08             	add    $0x8,%ecx
80106c4a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c50:	c1 e9 10             	shr    $0x10,%ecx
80106c53:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c59:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106c5e:	e8 2d cc ff ff       	call   80103890 <mycpu>
80106c63:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c6a:	e8 21 cc ff ff       	call   80103890 <mycpu>
80106c6f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c74:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c78:	e8 13 cc ff ff       	call   80103890 <mycpu>
80106c7d:	8b 56 08             	mov    0x8(%esi),%edx
80106c80:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c86:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c89:	e8 02 cc ff ff       	call   80103890 <mycpu>
80106c8e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c92:	b8 28 00 00 00       	mov    $0x28,%eax
80106c97:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c9a:	8b 46 04             	mov    0x4(%esi),%eax
80106c9d:	05 00 00 00 80       	add    $0x80000000,%eax
80106ca2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106ca5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ca8:	5b                   	pop    %ebx
80106ca9:	5e                   	pop    %esi
80106caa:	5f                   	pop    %edi
80106cab:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106cac:	e9 6f d9 ff ff       	jmp    80104620 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106cb1:	83 ec 0c             	sub    $0xc,%esp
80106cb4:	68 26 7e 10 80       	push   $0x80107e26
80106cb9:	e8 b2 96 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106cbe:	83 ec 0c             	sub    $0xc,%esp
80106cc1:	68 51 7e 10 80       	push   $0x80107e51
80106cc6:	e8 a5 96 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106ccb:	83 ec 0c             	sub    $0xc,%esp
80106cce:	68 3c 7e 10 80       	push   $0x80107e3c
80106cd3:	e8 98 96 ff ff       	call   80100370 <panic>
80106cd8:	90                   	nop
80106cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ce0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 1c             	sub    $0x1c,%esp
80106ce9:	8b 75 10             	mov    0x10(%ebp),%esi
80106cec:	8b 45 08             	mov    0x8(%ebp),%eax
80106cef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106cf2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106cf8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106cfb:	77 49                	ja     80106d46 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106cfd:	e8 0e b8 ff ff       	call   80102510 <kalloc>
  memset(mem, 0, PGSIZE);
80106d02:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106d05:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d07:	68 00 10 00 00       	push   $0x1000
80106d0c:	6a 00                	push   $0x0
80106d0e:	50                   	push   %eax
80106d0f:	e8 cc d9 ff ff       	call   801046e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d14:	58                   	pop    %eax
80106d15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d1b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d20:	5a                   	pop    %edx
80106d21:	6a 06                	push   $0x6
80106d23:	50                   	push   %eax
80106d24:	31 d2                	xor    %edx,%edx
80106d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d29:	e8 52 fc ff ff       	call   80106980 <mappages>
  memmove(mem, init, sz);
80106d2e:	89 75 10             	mov    %esi,0x10(%ebp)
80106d31:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d34:	83 c4 10             	add    $0x10,%esp
80106d37:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d3d:	5b                   	pop    %ebx
80106d3e:	5e                   	pop    %esi
80106d3f:	5f                   	pop    %edi
80106d40:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106d41:	e9 4a da ff ff       	jmp    80104790 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106d46:	83 ec 0c             	sub    $0xc,%esp
80106d49:	68 65 7e 10 80       	push   $0x80107e65
80106d4e:	e8 1d 96 ff ff       	call   80100370 <panic>
80106d53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d60 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d69:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d70:	0f 85 91 00 00 00    	jne    80106e07 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d76:	8b 75 18             	mov    0x18(%ebp),%esi
80106d79:	31 db                	xor    %ebx,%ebx
80106d7b:	85 f6                	test   %esi,%esi
80106d7d:	75 1a                	jne    80106d99 <loaduvm+0x39>
80106d7f:	eb 6f                	jmp    80106df0 <loaduvm+0x90>
80106d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d88:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d8e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d94:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d97:	76 57                	jbe    80106df0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d99:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d9f:	31 c9                	xor    %ecx,%ecx
80106da1:	01 da                	add    %ebx,%edx
80106da3:	e8 58 fb ff ff       	call   80106900 <walkpgdir>
80106da8:	85 c0                	test   %eax,%eax
80106daa:	74 4e                	je     80106dfa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106dac:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106db1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106db6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106dbb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106dc1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dc4:	01 d9                	add    %ebx,%ecx
80106dc6:	05 00 00 00 80       	add    $0x80000000,%eax
80106dcb:	57                   	push   %edi
80106dcc:	51                   	push   %ecx
80106dcd:	50                   	push   %eax
80106dce:	ff 75 10             	pushl  0x10(%ebp)
80106dd1:	e8 7a ab ff ff       	call   80101950 <readi>
80106dd6:	83 c4 10             	add    $0x10,%esp
80106dd9:	39 c7                	cmp    %eax,%edi
80106ddb:	74 ab                	je     80106d88 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106ddd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106de5:	5b                   	pop    %ebx
80106de6:	5e                   	pop    %esi
80106de7:	5f                   	pop    %edi
80106de8:	5d                   	pop    %ebp
80106de9:	c3                   	ret    
80106dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106df3:	31 c0                	xor    %eax,%eax
}
80106df5:	5b                   	pop    %ebx
80106df6:	5e                   	pop    %esi
80106df7:	5f                   	pop    %edi
80106df8:	5d                   	pop    %ebp
80106df9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106dfa:	83 ec 0c             	sub    $0xc,%esp
80106dfd:	68 7f 7e 10 80       	push   $0x80107e7f
80106e02:	e8 69 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106e07:	83 ec 0c             	sub    $0xc,%esp
80106e0a:	68 54 7f 10 80       	push   $0x80107f54
80106e0f:	e8 5c 95 ff ff       	call   80100370 <panic>
80106e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e20 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
80106e25:	53                   	push   %ebx
80106e26:	83 ec 0c             	sub    $0xc,%esp
80106e29:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106e2c:	85 ff                	test   %edi,%edi
80106e2e:	0f 88 ca 00 00 00    	js     80106efe <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106e34:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106e3a:	0f 82 82 00 00 00    	jb     80106ec2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106e40:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e46:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e4c:	39 df                	cmp    %ebx,%edi
80106e4e:	77 43                	ja     80106e93 <allocuvm+0x73>
80106e50:	e9 bb 00 00 00       	jmp    80106f10 <allocuvm+0xf0>
80106e55:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e58:	83 ec 04             	sub    $0x4,%esp
80106e5b:	68 00 10 00 00       	push   $0x1000
80106e60:	6a 00                	push   $0x0
80106e62:	50                   	push   %eax
80106e63:	e8 78 d8 ff ff       	call   801046e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e68:	58                   	pop    %eax
80106e69:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e6f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e74:	5a                   	pop    %edx
80106e75:	6a 06                	push   $0x6
80106e77:	50                   	push   %eax
80106e78:	89 da                	mov    %ebx,%edx
80106e7a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7d:	e8 fe fa ff ff       	call   80106980 <mappages>
80106e82:	83 c4 10             	add    $0x10,%esp
80106e85:	85 c0                	test   %eax,%eax
80106e87:	78 47                	js     80106ed0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e89:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e8f:	39 df                	cmp    %ebx,%edi
80106e91:	76 7d                	jbe    80106f10 <allocuvm+0xf0>
    mem = kalloc();
80106e93:	e8 78 b6 ff ff       	call   80102510 <kalloc>
    if(mem == 0){
80106e98:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e9a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e9c:	75 ba                	jne    80106e58 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e9e:	83 ec 0c             	sub    $0xc,%esp
80106ea1:	68 9d 7e 10 80       	push   $0x80107e9d
80106ea6:	e8 b5 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106eab:	83 c4 10             	add    $0x10,%esp
80106eae:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106eb1:	76 4b                	jbe    80106efe <allocuvm+0xde>
80106eb3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106eb6:	8b 45 08             	mov    0x8(%ebp),%eax
80106eb9:	89 fa                	mov    %edi,%edx
80106ebb:	e8 50 fb ff ff       	call   80106a10 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106ec0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ec5:	5b                   	pop    %ebx
80106ec6:	5e                   	pop    %esi
80106ec7:	5f                   	pop    %edi
80106ec8:	5d                   	pop    %ebp
80106ec9:	c3                   	ret    
80106eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ed0:	83 ec 0c             	sub    $0xc,%esp
80106ed3:	68 b5 7e 10 80       	push   $0x80107eb5
80106ed8:	e8 83 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106edd:	83 c4 10             	add    $0x10,%esp
80106ee0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ee3:	76 0d                	jbe    80106ef2 <allocuvm+0xd2>
80106ee5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80106eeb:	89 fa                	mov    %edi,%edx
80106eed:	e8 1e fb ff ff       	call   80106a10 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106ef2:	83 ec 0c             	sub    $0xc,%esp
80106ef5:	56                   	push   %esi
80106ef6:	e8 e5 b3 ff ff       	call   801022e0 <kfree>
      return 0;
80106efb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106f01:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106f03:	5b                   	pop    %ebx
80106f04:	5e                   	pop    %esi
80106f05:	5f                   	pop    %edi
80106f06:	5d                   	pop    %ebp
80106f07:	c3                   	ret    
80106f08:	90                   	nop
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f10:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106f13:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106f15:	5b                   	pop    %ebx
80106f16:	5e                   	pop    %esi
80106f17:	5f                   	pop    %edi
80106f18:	5d                   	pop    %ebp
80106f19:	c3                   	ret    
80106f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f20 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f29:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f2c:	39 d1                	cmp    %edx,%ecx
80106f2e:	73 10                	jae    80106f40 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f30:	5d                   	pop    %ebp
80106f31:	e9 da fa ff ff       	jmp    80106a10 <deallocuvm.part.0>
80106f36:	8d 76 00             	lea    0x0(%esi),%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f40:	89 d0                	mov    %edx,%eax
80106f42:	5d                   	pop    %ebp
80106f43:	c3                   	ret    
80106f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	57                   	push   %edi
80106f54:	56                   	push   %esi
80106f55:	53                   	push   %ebx
80106f56:	83 ec 0c             	sub    $0xc,%esp
80106f59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f5c:	85 f6                	test   %esi,%esi
80106f5e:	74 59                	je     80106fb9 <freevm+0x69>
80106f60:	31 c9                	xor    %ecx,%ecx
80106f62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f67:	89 f0                	mov    %esi,%eax
80106f69:	e8 a2 fa ff ff       	call   80106a10 <deallocuvm.part.0>
80106f6e:	89 f3                	mov    %esi,%ebx
80106f70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f76:	eb 0f                	jmp    80106f87 <freevm+0x37>
80106f78:	90                   	nop
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f83:	39 fb                	cmp    %edi,%ebx
80106f85:	74 23                	je     80106faa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f87:	8b 03                	mov    (%ebx),%eax
80106f89:	a8 01                	test   $0x1,%al
80106f8b:	74 f3                	je     80106f80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f92:	83 ec 0c             	sub    $0xc,%esp
80106f95:	83 c3 04             	add    $0x4,%ebx
80106f98:	05 00 00 00 80       	add    $0x80000000,%eax
80106f9d:	50                   	push   %eax
80106f9e:	e8 3d b3 ff ff       	call   801022e0 <kfree>
80106fa3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fa6:	39 fb                	cmp    %edi,%ebx
80106fa8:	75 dd                	jne    80106f87 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106faa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fb0:	5b                   	pop    %ebx
80106fb1:	5e                   	pop    %esi
80106fb2:	5f                   	pop    %edi
80106fb3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106fb4:	e9 27 b3 ff ff       	jmp    801022e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106fb9:	83 ec 0c             	sub    $0xc,%esp
80106fbc:	68 d1 7e 10 80       	push   $0x80107ed1
80106fc1:	e8 aa 93 ff ff       	call   80100370 <panic>
80106fc6:	8d 76 00             	lea    0x0(%esi),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	56                   	push   %esi
80106fd4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106fd5:	e8 36 b5 ff ff       	call   80102510 <kalloc>
80106fda:	85 c0                	test   %eax,%eax
80106fdc:	74 6a                	je     80107048 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fde:	83 ec 04             	sub    $0x4,%esp
80106fe1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fe3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fe8:	68 00 10 00 00       	push   $0x1000
80106fed:	6a 00                	push   $0x0
80106fef:	50                   	push   %eax
80106ff0:	e8 eb d6 ff ff       	call   801046e0 <memset>
80106ff5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ff8:	8b 43 04             	mov    0x4(%ebx),%eax
80106ffb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ffe:	83 ec 08             	sub    $0x8,%esp
80107001:	8b 13                	mov    (%ebx),%edx
80107003:	ff 73 0c             	pushl  0xc(%ebx)
80107006:	50                   	push   %eax
80107007:	29 c1                	sub    %eax,%ecx
80107009:	89 f0                	mov    %esi,%eax
8010700b:	e8 70 f9 ff ff       	call   80106980 <mappages>
80107010:	83 c4 10             	add    $0x10,%esp
80107013:	85 c0                	test   %eax,%eax
80107015:	78 19                	js     80107030 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107017:	83 c3 10             	add    $0x10,%ebx
8010701a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107020:	75 d6                	jne    80106ff8 <setupkvm+0x28>
80107022:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107024:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107027:	5b                   	pop    %ebx
80107028:	5e                   	pop    %esi
80107029:	5d                   	pop    %ebp
8010702a:	c3                   	ret    
8010702b:	90                   	nop
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	56                   	push   %esi
80107034:	e8 17 ff ff ff       	call   80106f50 <freevm>
      return 0;
80107039:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010703c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010703f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107041:	5b                   	pop    %ebx
80107042:	5e                   	pop    %esi
80107043:	5d                   	pop    %ebp
80107044:	c3                   	ret    
80107045:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107048:	31 c0                	xor    %eax,%eax
8010704a:	eb d8                	jmp    80107024 <setupkvm+0x54>
8010704c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107050 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107056:	e8 75 ff ff ff       	call   80106fd0 <setupkvm>
8010705b:	a3 a4 e4 14 80       	mov    %eax,0x8014e4a4
80107060:	05 00 00 00 80       	add    $0x80000000,%eax
80107065:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107068:	c9                   	leave  
80107069:	c3                   	ret    
8010706a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107070 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107070:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107071:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107073:	89 e5                	mov    %esp,%ebp
80107075:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107078:	8b 55 0c             	mov    0xc(%ebp),%edx
8010707b:	8b 45 08             	mov    0x8(%ebp),%eax
8010707e:	e8 7d f8 ff ff       	call   80106900 <walkpgdir>
  if(pte == 0)
80107083:	85 c0                	test   %eax,%eax
80107085:	74 05                	je     8010708c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107087:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010708a:	c9                   	leave  
8010708b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010708c:	83 ec 0c             	sub    $0xc,%esp
8010708f:	68 e2 7e 10 80       	push   $0x80107ee2
80107094:	e8 d7 92 ff ff       	call   80100370 <panic>
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070a9:	e8 22 ff ff ff       	call   80106fd0 <setupkvm>
801070ae:	85 c0                	test   %eax,%eax
801070b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070b3:	0f 84 b2 00 00 00    	je     8010716b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801070bc:	85 c9                	test   %ecx,%ecx
801070be:	0f 84 9c 00 00 00    	je     80107160 <copyuvm+0xc0>
801070c4:	31 f6                	xor    %esi,%esi
801070c6:	eb 4a                	jmp    80107112 <copyuvm+0x72>
801070c8:	90                   	nop
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070d0:	83 ec 04             	sub    $0x4,%esp
801070d3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801070d9:	68 00 10 00 00       	push   $0x1000
801070de:	57                   	push   %edi
801070df:	50                   	push   %eax
801070e0:	e8 ab d6 ff ff       	call   80104790 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801070e5:	58                   	pop    %eax
801070e6:	5a                   	pop    %edx
801070e7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
801070ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070f0:	ff 75 e4             	pushl  -0x1c(%ebp)
801070f3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070f8:	52                   	push   %edx
801070f9:	89 f2                	mov    %esi,%edx
801070fb:	e8 80 f8 ff ff       	call   80106980 <mappages>
80107100:	83 c4 10             	add    $0x10,%esp
80107103:	85 c0                	test   %eax,%eax
80107105:	78 3e                	js     80107145 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107107:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010710d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107110:	76 4e                	jbe    80107160 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107112:	8b 45 08             	mov    0x8(%ebp),%eax
80107115:	31 c9                	xor    %ecx,%ecx
80107117:	89 f2                	mov    %esi,%edx
80107119:	e8 e2 f7 ff ff       	call   80106900 <walkpgdir>
8010711e:	85 c0                	test   %eax,%eax
80107120:	74 5a                	je     8010717c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107122:	8b 18                	mov    (%eax),%ebx
80107124:	f6 c3 01             	test   $0x1,%bl
80107127:	74 46                	je     8010716f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107129:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010712b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107131:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107134:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010713a:	e8 d1 b3 ff ff       	call   80102510 <kalloc>
8010713f:	85 c0                	test   %eax,%eax
80107141:	89 c3                	mov    %eax,%ebx
80107143:	75 8b                	jne    801070d0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107145:	83 ec 0c             	sub    $0xc,%esp
80107148:	ff 75 e0             	pushl  -0x20(%ebp)
8010714b:	e8 00 fe ff ff       	call   80106f50 <freevm>
  return 0;
80107150:	83 c4 10             	add    $0x10,%esp
80107153:	31 c0                	xor    %eax,%eax
}
80107155:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107158:	5b                   	pop    %ebx
80107159:	5e                   	pop    %esi
8010715a:	5f                   	pop    %edi
8010715b:	5d                   	pop    %ebp
8010715c:	c3                   	ret    
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107160:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107166:	5b                   	pop    %ebx
80107167:	5e                   	pop    %esi
80107168:	5f                   	pop    %edi
80107169:	5d                   	pop    %ebp
8010716a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010716b:	31 c0                	xor    %eax,%eax
8010716d:	eb e6                	jmp    80107155 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010716f:	83 ec 0c             	sub    $0xc,%esp
80107172:	68 06 7f 10 80       	push   $0x80107f06
80107177:	e8 f4 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010717c:	83 ec 0c             	sub    $0xc,%esp
8010717f:	68 ec 7e 10 80       	push   $0x80107eec
80107184:	e8 e7 91 ff ff       	call   80100370 <panic>
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107190 <copyuvmcow>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvmcow(pde_t *pgdir, uint sz)
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
80107196:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 
  
  if((d = setupkvm()) == 0)
80107199:	e8 32 fe ff ff       	call   80106fd0 <setupkvm>
8010719e:	85 c0                	test   %eax,%eax
801071a0:	0f 84 bf 00 00 00    	je     80107265 <copyuvmcow+0xd5>
801071a6:	89 c7                	mov    %eax,%edi
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801071ab:	31 db                	xor    %ebx,%ebx
801071ad:	85 c0                	test   %eax,%eax
801071af:	75 26                	jne    801071d7 <copyuvmcow+0x47>
801071b1:	e9 9a 00 00 00       	jmp    80107250 <copyuvmcow+0xc0>
801071b6:	8d 76 00             	lea    0x0(%esi),%esi
801071b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *pte |= PTE_COW;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad; 
    addRefCount(pa);
801071c0:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;
  uint pa, i, flags; 
  
  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    *pte |= PTE_COW;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad; 
    addRefCount(pa);
801071c9:	56                   	push   %esi
801071ca:	e8 c1 b3 ff ff       	call   80102590 <addRefCount>
  pte_t *pte;
  uint pa, i, flags; 
  
  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071cf:	83 c4 10             	add    $0x10,%esp
801071d2:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801071d5:	76 79                	jbe    80107250 <copyuvmcow+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071d7:	8b 45 08             	mov    0x8(%ebp),%eax
801071da:	31 c9                	xor    %ecx,%ecx
801071dc:	89 da                	mov    %ebx,%edx
801071de:	e8 1d f7 ff ff       	call   80106900 <walkpgdir>
801071e3:	85 c0                	test   %eax,%eax
801071e5:	0f 84 8b 00 00 00    	je     80107276 <copyuvmcow+0xe6>
    {
      cprintf("walkpgdir error\n");
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
801071eb:	8b 10                	mov    (%eax),%edx
801071ed:	f6 c2 01             	test   $0x1,%dl
801071f0:	74 77                	je     80107269 <copyuvmcow+0xd9>
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
801071f2:	89 d1                	mov    %edx,%ecx
801071f4:	89 d6                	mov    %edx,%esi
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
801071f6:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
801071fc:	83 e1 fd             	and    $0xfffffffd,%ecx
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
801071ff:	83 ec 08             	sub    $0x8,%esp
80107202:	80 ce 02             	or     $0x2,%dh
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
80107205:	80 cd 02             	or     $0x2,%ch
80107208:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
8010720e:	89 08                	mov    %ecx,(%eax)
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107210:	52                   	push   %edx
80107211:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107216:	56                   	push   %esi
80107217:	89 da                	mov    %ebx,%edx
80107219:	89 f8                	mov    %edi,%eax
8010721b:	e8 60 f7 ff ff       	call   80106980 <mappages>
80107220:	83 c4 10             	add    $0x10,%esp
80107223:	85 c0                	test   %eax,%eax
80107225:	79 99                	jns    801071c0 <copyuvmcow+0x30>
  }
  lcr3(V2P(pgdir));
  return d;

bad:
  freevm(d);
80107227:	83 ec 0c             	sub    $0xc,%esp
8010722a:	57                   	push   %edi
8010722b:	e8 20 fd ff ff       	call   80106f50 <freevm>
80107230:	8b 45 08             	mov    0x8(%ebp),%eax
80107233:	05 00 00 00 80       	add    $0x80000000,%eax
80107238:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(pgdir));
  return 0;
8010723b:	31 c0                	xor    %eax,%eax
8010723d:	83 c4 10             	add    $0x10,%esp
}
80107240:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107243:	5b                   	pop    %ebx
80107244:	5e                   	pop    %esi
80107245:	5f                   	pop    %edi
80107246:	5d                   	pop    %ebp
80107247:	c3                   	ret    
80107248:	90                   	nop
80107249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107250:	8b 45 08             	mov    0x8(%ebp),%eax
80107253:	05 00 00 00 80       	add    $0x80000000,%eax
80107258:	0f 22 d8             	mov    %eax,%cr3
8010725b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad; 
    addRefCount(pa);
  }
  lcr3(V2P(pgdir));
  return d;
8010725e:	89 f8                	mov    %edi,%eax

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107260:	5b                   	pop    %ebx
80107261:	5e                   	pop    %esi
80107262:	5f                   	pop    %edi
80107263:	5d                   	pop    %ebp
80107264:	c3                   	ret    
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 
  
  if((d = setupkvm()) == 0)
    return 0;
80107265:	31 c0                	xor    %eax,%eax
80107267:	eb d7                	jmp    80107240 <copyuvmcow+0xb0>
    {
      cprintf("walkpgdir error\n");
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107269:	83 ec 0c             	sub    $0xc,%esp
8010726c:	68 06 7f 10 80       	push   $0x80107f06
80107271:	e8 fa 90 ff ff       	call   80100370 <panic>
  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
    {
      cprintf("walkpgdir error\n");
80107276:	83 ec 0c             	sub    $0xc,%esp
80107279:	68 20 7f 10 80       	push   $0x80107f20
8010727e:	e8 dd 93 ff ff       	call   80100660 <cprintf>
      panic("copyuvm: pte should exist");
80107283:	c7 04 24 ec 7e 10 80 	movl   $0x80107eec,(%esp)
8010728a:	e8 e1 90 ff ff       	call   80100370 <panic>
8010728f:	90                   	nop

80107290 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107290:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107291:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107293:	89 e5                	mov    %esp,%ebp
80107295:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107298:	8b 55 0c             	mov    0xc(%ebp),%edx
8010729b:	8b 45 08             	mov    0x8(%ebp),%eax
8010729e:	e8 5d f6 ff ff       	call   80106900 <walkpgdir>
  if((*pte & PTE_P) == 0)
801072a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801072a5:	89 c2                	mov    %eax,%edx
801072a7:	83 e2 05             	and    $0x5,%edx
801072aa:	83 fa 05             	cmp    $0x5,%edx
801072ad:	75 11                	jne    801072c0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801072af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801072b4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801072b5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801072ba:	c3                   	ret    
801072bb:	90                   	nop
801072bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801072c0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801072c2:	c9                   	leave  
801072c3:	c3                   	ret    
801072c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801072d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072d0:	55                   	push   %ebp
801072d1:	89 e5                	mov    %esp,%ebp
801072d3:	57                   	push   %edi
801072d4:	56                   	push   %esi
801072d5:	53                   	push   %ebx
801072d6:	83 ec 1c             	sub    $0x1c,%esp
801072d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801072dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801072df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072e2:	85 db                	test   %ebx,%ebx
801072e4:	75 40                	jne    80107326 <copyout+0x56>
801072e6:	eb 70                	jmp    80107358 <copyout+0x88>
801072e8:	90                   	nop
801072e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072f3:	89 f1                	mov    %esi,%ecx
801072f5:	29 d1                	sub    %edx,%ecx
801072f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801072fd:	39 d9                	cmp    %ebx,%ecx
801072ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107302:	29 f2                	sub    %esi,%edx
80107304:	83 ec 04             	sub    $0x4,%esp
80107307:	01 d0                	add    %edx,%eax
80107309:	51                   	push   %ecx
8010730a:	57                   	push   %edi
8010730b:	50                   	push   %eax
8010730c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010730f:	e8 7c d4 ff ff       	call   80104790 <memmove>
    len -= n;
    buf += n;
80107314:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107317:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010731a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107320:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107322:	29 cb                	sub    %ecx,%ebx
80107324:	74 32                	je     80107358 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107326:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107328:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010732b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010732e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107334:	56                   	push   %esi
80107335:	ff 75 08             	pushl  0x8(%ebp)
80107338:	e8 53 ff ff ff       	call   80107290 <uva2ka>
    if(pa0 == 0)
8010733d:	83 c4 10             	add    $0x10,%esp
80107340:	85 c0                	test   %eax,%eax
80107342:	75 ac                	jne    801072f0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107344:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010734c:	5b                   	pop    %ebx
8010734d:	5e                   	pop    %esi
8010734e:	5f                   	pop    %edi
8010734f:	5d                   	pop    %ebp
80107350:	c3                   	ret    
80107351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107358:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010735b:	31 c0                	xor    %eax,%eax
}
8010735d:	5b                   	pop    %ebx
8010735e:	5e                   	pop    %esi
8010735f:	5f                   	pop    %edi
80107360:	5d                   	pop    %ebp
80107361:	c3                   	ret    
80107362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <pagefault>:
//PAGEBREAK!
// Blank page.

void 
pagefault(uint error)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
80107376:	83 ec 1c             	sub    $0x1c,%esp
80107379:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct proc *cur = myproc();
8010737c:	e8 af c5 ff ff       	call   80103930 <myproc>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107381:	0f 20 d6             	mov    %cr2,%esi
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
  if(!(error & 0x02))
80107384:	83 e7 02             	and    $0x2,%edi
80107387:	74 77                	je     80107400 <pagefault+0x90>
  {
    cprintf("Nao e erro de escrita.");
    return;
  }
 
  if(cur ==0)
80107389:	85 c0                	test   %eax,%eax
8010738b:	89 c3                	mov    %eax,%ebx
8010738d:	0f 84 15 01 00 00    	je     801074a8 <pagefault+0x138>
  {
    cprintf( "Page fault occured but it was not the user process\n");
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)a, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U))
80107393:	85 f6                	test   %esi,%esi
80107395:	78 24                	js     801073bb <pagefault+0x4b>
80107397:	8b 40 04             	mov    0x4(%eax),%eax
8010739a:	89 f2                	mov    %esi,%edx
8010739c:	31 c9                	xor    %ecx,%ecx
8010739e:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801073a4:	e8 57 f5 ff ff       	call   80106900 <walkpgdir>
801073a9:	85 c0                	test   %eax,%eax
801073ab:	89 c7                	mov    %eax,%edi
801073ad:	74 0c                	je     801073bb <pagefault+0x4b>
801073af:	8b 00                	mov    (%eax),%eax
801073b1:	89 c2                	mov    %eax,%edx
801073b3:	83 e2 05             	and    $0x5,%edx
801073b6:	83 fa 05             	cmp    $0x5,%edx
801073b9:	74 25                	je     801073e0 <pagefault+0x70>
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
     va, cur->name, cur->pid);
801073bb:	8d 43 6c             	lea    0x6c(%ebx),%eax
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)a, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U))
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
801073be:	ff 73 10             	pushl  0x10(%ebx)
801073c1:	50                   	push   %eax
801073c2:	56                   	push   %esi
801073c3:	68 ac 7f 10 80       	push   $0x80107fac
801073c8:	e8 93 92 ff ff       	call   80100660 <cprintf>
     va, cur->name, cur->pid);
    cur->killed = 1;
801073cd:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
    return;
801073d4:	83 c4 10             	add    $0x10,%esp
  else
  {
    cur->killed = 1;
    return;
  }
}
801073d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073da:	5b                   	pop    %ebx
801073db:	5e                   	pop    %esi
801073dc:	5f                   	pop    %edi
801073dd:	5d                   	pop    %ebp
801073de:	c3                   	ret    
801073df:	90                   	nop
     va, cur->name, cur->pid);
    cur->killed = 1;
    return;
  }

  if(*pte & PTE_W)
801073e0:	a8 02                	test   $0x2,%al
801073e2:	0f 85 d9 00 00 00    	jne    801074c1 <pagefault+0x151>
  {
    panic("Pagina ja tem permissao de escrita");
  }
 
  if(*pte & PTE_COW)
801073e8:	f6 c4 02             	test   $0x2,%ah
801073eb:	75 2b                	jne    80107418 <pagefault+0xa8>

      lcr3(V2P(cur->pgdir));
  }
  else
  {
    cur->killed = 1;
801073ed:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
    return;
  }
}
801073f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073f7:	5b                   	pop    %ebx
801073f8:	5e                   	pop    %esi
801073f9:	5f                   	pop    %edi
801073fa:	5d                   	pop    %ebp
801073fb:	c3                   	ret    
801073fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
  if(!(error & 0x02))
  {
    cprintf("Nao e erro de escrita.");
80107400:	c7 45 08 31 7f 10 80 	movl   $0x80107f31,0x8(%ebp)
  else
  {
    cur->killed = 1;
    return;
  }
}
80107407:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010740a:	5b                   	pop    %ebx
8010740b:	5e                   	pop    %esi
8010740c:	5f                   	pop    %edi
8010740d:	5d                   	pop    %ebp
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
  if(!(error & 0x02))
  {
    cprintf("Nao e erro de escrita.");
8010740e:	e9 4d 92 ff ff       	jmp    80100660 <cprintf>
80107413:	90                   	nop
80107414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Pagina ja tem permissao de escrita");
  }
 
  if(*pte & PTE_COW)
    {
      uint physicalAdress = PTE_ADDR(*pte);
80107418:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      uint refCount = getRefCount(physicalAdress);    
8010741d:	83 ec 0c             	sub    $0xc,%esp
80107420:	50                   	push   %eax
    panic("Pagina ja tem permissao de escrita");
  }
 
  if(*pte & PTE_COW)
    {
      uint physicalAdress = PTE_ADDR(*pte);
80107421:	89 c6                	mov    %eax,%esi
      uint refCount = getRefCount(physicalAdress);    
80107423:	e8 28 b2 ff ff       	call   80102650 <getRefCount>
      char* mem;

      if(refCount > 1)
80107428:	83 c4 10             	add    $0x10,%esp
8010742b:	83 f8 01             	cmp    $0x1,%eax
8010742e:	76 50                	jbe    80107480 <pagefault+0x110>
      {

          if((mem = kalloc()) == 0)
80107430:	e8 db b0 ff ff       	call   80102510 <kalloc>
80107435:	85 c0                	test   %eax,%eax
80107437:	89 c2                	mov    %eax,%edx
80107439:	74 51                	je     8010748c <pagefault+0x11c>
          {
            cprintf("Page fault sem memória, terminando o processo");
            cur->killed=1;
            return;
          }
          memmove(mem, (char*)P2V(physicalAdress), PGSIZE);
8010743b:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107441:	83 ec 04             	sub    $0x4,%esp
80107444:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107447:	68 00 10 00 00       	push   $0x1000
8010744c:	50                   	push   %eax
8010744d:	52                   	push   %edx
8010744e:	e8 3d d3 ff ff       	call   80104790 <memmove>

          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W /*| PTE_FLAGS(*pte)*/;
          *pte &= ~PTE_COW;
80107453:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107456:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010745c:	80 e6 fd             	and    $0xfd,%dh
8010745f:	83 ca 07             	or     $0x7,%edx
80107462:	89 17                	mov    %edx,(%edi)
          minusRefCount(physicalAdress);
80107464:	89 34 24             	mov    %esi,(%esp)
80107467:	e8 84 b1 ff ff       	call   801025f0 <minusRefCount>
8010746c:	83 c4 10             	add    $0x10,%esp
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010746f:	8b 43 04             	mov    0x4(%ebx),%eax
80107472:	05 00 00 00 80       	add    $0x80000000,%eax
80107477:	0f 22 d8             	mov    %eax,%cr3
8010747a:	e9 58 ff ff ff       	jmp    801073d7 <pagefault+0x67>
8010747f:	90                   	nop
        return;
      }
      else
      {
        *pte &= ~PTE_COW;
        *pte |= PTE_W;
80107480:	8b 07                	mov    (%edi),%eax
80107482:	80 e4 fd             	and    $0xfd,%ah
80107485:	83 c8 02             	or     $0x2,%eax
80107488:	89 07                	mov    %eax,(%edi)
8010748a:	eb e3                	jmp    8010746f <pagefault+0xff>
      if(refCount > 1)
      {

          if((mem = kalloc()) == 0)
          {
            cprintf("Page fault sem memória, terminando o processo");
8010748c:	83 ec 0c             	sub    $0xc,%esp
8010748f:	68 24 80 10 80       	push   $0x80108024
80107494:	e8 c7 91 ff ff       	call   80100660 <cprintf>
            cur->killed=1;
80107499:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
            return;
801074a0:	83 c4 10             	add    $0x10,%esp
801074a3:	e9 2f ff ff ff       	jmp    801073d7 <pagefault+0x67>
    return;
  }
 
  if(cur ==0)
  {
    cprintf( "Page fault occured but it was not the user process\n");
801074a8:	83 ec 0c             	sub    $0xc,%esp
801074ab:	68 78 7f 10 80       	push   $0x80107f78
801074b0:	e8 ab 91 ff ff       	call   80100660 <cprintf>
    panic("pagefault");
801074b5:	c7 04 24 48 7f 10 80 	movl   $0x80107f48,(%esp)
801074bc:	e8 af 8e ff ff       	call   80100370 <panic>
    return;
  }

  if(*pte & PTE_W)
  {
    panic("Pagina ja tem permissao de escrita");
801074c1:	83 ec 0c             	sub    $0xc,%esp
801074c4:	68 00 80 10 80       	push   $0x80108000
801074c9:	e8 a2 8e ff ff       	call   80100370 <panic>
