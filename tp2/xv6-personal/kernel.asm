
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
8010002d:	b8 20 30 10 80       	mov    $0x80103020,%eax
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
8010004c:	68 a0 75 10 80       	push   $0x801075a0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 25 44 00 00       	call   80104480 <initlock>

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
80100092:	68 a7 75 10 80       	push   $0x801075a7
80100097:	50                   	push   %eax
80100098:	e8 d3 42 00 00       	call   80104370 <initsleeplock>
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
801000e4:	e8 97 44 00 00       	call   80104580 <acquire>

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
80100162:	e8 39 45 00 00       	call   801046a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 3e 42 00 00       	call   801043b0 <acquiresleep>
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
80100193:	68 ae 75 10 80       	push   $0x801075ae
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
801001ae:	e8 9d 42 00 00       	call   80104450 <holdingsleep>
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
801001cc:	68 bf 75 10 80       	push   $0x801075bf
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
801001ef:	e8 5c 42 00 00       	call   80104450 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 0c 42 00 00       	call   80104410 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 70 43 00 00       	call   80104580 <acquire>
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
8010025c:	e9 3f 44 00 00       	jmp    801046a0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 75 10 80       	push   $0x801075c6
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
8010028c:	e8 ef 42 00 00       	call   80104580 <acquire>
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
801002bd:	e8 4e 3d 00 00       	call   80104010 <sleep>
801002c2:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
801002d2:	e8 69 36 00 00       	call   80103940 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 b5 10 80       	push   $0x8010b520
801002e6:	e8 b5 43 00 00       	call   801046a0 <release>
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
80100346:	e8 55 43 00 00       	call   801046a0 <release>
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
80100389:	e8 22 25 00 00       	call   801028b0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 cd 75 10 80       	push   $0x801075cd
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
801003a5:	c7 04 24 ed 7f 10 80 	movl   $0x80107fed,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 e3 40 00 00       	call   801044a0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 75 10 80       	push   $0x801075e1
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
80100514:	e8 87 42 00 00       	call   801047a0 <memmove>
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 c2 41 00 00       	call   801046f0 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 e5 75 10 80       	push   $0x801075e5
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
801005b1:	0f b6 92 10 76 10 80 	movzbl -0x7fef89f0(%edx),%edx
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
8010061b:	e8 60 3f 00 00       	call   80104580 <acquire>
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
80100647:	e8 54 40 00 00       	call   801046a0 <release>
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
8010070d:	e8 8e 3f 00 00       	call   801046a0 <release>
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
80100788:	b8 f8 75 10 80       	mov    $0x801075f8,%eax
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
801007c8:	e8 b3 3d 00 00       	call   80104580 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 ff 75 10 80       	push   $0x801075ff
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
80100803:	e8 78 3d 00 00       	call   80104580 <acquire>
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
80100868:	e8 33 3e 00 00       	call   801046a0 <release>
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
801008f6:	e8 c5 38 00 00       	call   801041c0 <wakeup>
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
80100977:	e9 34 39 00 00       	jmp    801042b0 <procdump>
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
801009a6:	68 08 76 10 80       	push   $0x80107608
801009ab:	68 20 b5 10 80       	push   $0x8010b520
801009b0:	e8 cb 3a 00 00       	call   80104480 <initlock>
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
801009fc:	e8 3f 2f 00 00       	call   80103940 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a07:	e8 04 23 00 00       	call   80102d10 <begin_op>
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
80100a4f:	e8 2c 23 00 00       	call   80102d80 <end_op>
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
80100b6f:	e8 0c 22 00 00       	call   80102d80 <end_op>
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
80100bbe:	e8 bd 21 00 00       	call   80102d80 <end_op>
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 21 76 10 80       	push   $0x80107621
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
80100c2d:	e8 fe 3c 00 00       	call   80104930 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 eb 3c 00 00       	call   80104930 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 ca 66 00 00       	call   80107320 <copyout>
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
80100cbb:	e8 60 66 00 00       	call   80107320 <copyout>
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
80100d00:	e8 eb 3b 00 00       	call   801048f0 <safestrcpy>
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
80100d56:	68 2d 76 10 80       	push   $0x8010762d
80100d5b:	68 c0 0f 11 80       	push   $0x80110fc0
80100d60:	e8 1b 37 00 00       	call   80104480 <initlock>
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
80100d81:	e8 fa 37 00 00       	call   80104580 <acquire>
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
80100db1:	e8 ea 38 00 00       	call   801046a0 <release>
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
80100dc8:	e8 d3 38 00 00       	call   801046a0 <release>
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
80100def:	e8 8c 37 00 00       	call   80104580 <acquire>
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
80100e0c:	e8 8f 38 00 00       	call   801046a0 <release>
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
80100e1b:	68 34 76 10 80       	push   $0x80107634
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
80100e41:	e8 3a 37 00 00       	call   80104580 <acquire>
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
80100e6c:	e9 2f 38 00 00       	jmp    801046a0 <release>
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
80100e98:	e8 03 38 00 00       	call   801046a0 <release>

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
80100ec1:	e8 ea 25 00 00       	call   801034b0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 3b 1e 00 00       	call   80102d10 <begin_op>
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
80100eea:	e9 91 1e 00 00       	jmp    80102d80 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 3c 76 10 80       	push   $0x8010763c
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
80100fbd:	e9 8e 26 00 00       	jmp    80103650 <piperead>
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
80100fd2:	68 46 76 10 80       	push   $0x80107646
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
80101039:	e8 42 1d 00 00       	call   80102d80 <end_op>
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
80101066:	e8 a5 1c 00 00       	call   80102d10 <begin_op>
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
8010109d:	e8 de 1c 00 00       	call   80102d80 <end_op>

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
801010dc:	e9 6f 24 00 00       	jmp    80103550 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 4f 76 10 80       	push   $0x8010764f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 55 76 10 80       	push   $0x80107655
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
801011a2:	68 5f 76 10 80       	push   $0x8010765f
801011a7:	e8 c4 f1 ff ff       	call   80100370 <panic>
801011ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011b0:	09 fa                	or     %edi,%edx
801011b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801011b5:	83 ec 0c             	sub    $0xc,%esp
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801011bc:	57                   	push   %edi
801011bd:	e8 2e 1d 00 00       	call   80102ef0 <log_write>
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
801011e5:	e8 06 35 00 00       	call   801046f0 <memset>
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 fe 1c 00 00       	call   80102ef0 <log_write>
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
8010122a:	e8 51 33 00 00       	call   80104580 <acquire>
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
80101272:	e8 29 34 00 00       	call   801046a0 <release>
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
801012bf:	e8 dc 33 00 00       	call   801046a0 <release>
801012c4:	83 c4 10             	add    $0x10,%esp
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 75 76 10 80       	push   $0x80107675
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
8010134d:	e8 9e 1b 00 00       	call   80102ef0 <log_write>
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
8010139a:	68 85 76 10 80       	push   $0x80107685
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
801013d1:	e8 ca 33 00 00       	call   801047a0 <memmove>
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
8010144c:	e8 9f 1a 00 00       	call   80102ef0 <log_write>
80101451:	89 34 24             	mov    %esi,(%esp)
80101454:	e8 87 ed ff ff       	call   801001e0 <brelse>
80101459:	83 c4 10             	add    $0x10,%esp
8010145c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret    
80101463:	83 ec 0c             	sub    $0xc,%esp
80101466:	68 98 76 10 80       	push   $0x80107698
8010146b:	e8 00 ef ff ff       	call   80100370 <panic>

80101470 <iinit>:
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 ab 76 10 80       	push   $0x801076ab
80101481:	68 e0 19 11 80       	push   $0x801119e0
80101486:	e8 f5 2f 00 00       	call   80104480 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 b2 76 10 80       	push   $0x801076b2
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 cc 2e 00 00       	call   80104370 <initsleeplock>
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
801014e9:	68 18 77 10 80       	push   $0x80107718
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
8010157e:	e8 6d 31 00 00       	call   801046f0 <memset>
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 5b 19 00 00       	call   80102ef0 <log_write>
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
801015b3:	68 b8 76 10 80       	push   $0x801076b8
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
80101621:	e8 7a 31 00 00       	call   801047a0 <memmove>
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 c2 18 00 00       	call   80102ef0 <log_write>
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
8010164f:	e8 2c 2f 00 00       	call   80104580 <acquire>
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101658:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010165f:	e8 3c 30 00 00       	call   801046a0 <release>
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
80101692:	e8 19 2d 00 00       	call   801043b0 <acquiresleep>
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
80101708:	e8 93 30 00 00       	call   801047a0 <memmove>
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010171d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101724:	0f 85 77 ff ff ff    	jne    801016a1 <ilock+0x31>
8010172a:	83 ec 0c             	sub    $0xc,%esp
8010172d:	68 d0 76 10 80       	push   $0x801076d0
80101732:	e8 39 ec ff ff       	call   80100370 <panic>
80101737:	83 ec 0c             	sub    $0xc,%esp
8010173a:	68 ca 76 10 80       	push   $0x801076ca
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
80101763:	e8 e8 2c 00 00       	call   80104450 <holdingsleep>
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
8010177f:	e9 8c 2c 00 00       	jmp    80104410 <releasesleep>
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 df 76 10 80       	push   $0x801076df
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
801017b0:	e8 fb 2b 00 00       	call   801043b0 <acquiresleep>
801017b5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 d2                	test   %edx,%edx
801017bd:	74 07                	je     801017c6 <iput+0x26>
801017bf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017c4:	74 32                	je     801017f8 <iput+0x58>
801017c6:	83 ec 0c             	sub    $0xc,%esp
801017c9:	57                   	push   %edi
801017ca:	e8 41 2c 00 00       	call   80104410 <releasesleep>
801017cf:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801017d6:	e8 a5 2d 00 00       	call   80104580 <acquire>
801017db:	83 6e 08 01          	subl   $0x1,0x8(%esi)
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
801017e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ec:	5b                   	pop    %ebx
801017ed:	5e                   	pop    %esi
801017ee:	5f                   	pop    %edi
801017ef:	5d                   	pop    %ebp
801017f0:	e9 ab 2e 00 00       	jmp    801046a0 <release>
801017f5:	8d 76 00             	lea    0x0(%esi),%esi
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	68 e0 19 11 80       	push   $0x801119e0
80101800:	e8 7b 2d 00 00       	call   80104580 <acquire>
80101805:	8b 5e 08             	mov    0x8(%esi),%ebx
80101808:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010180f:	e8 8c 2e 00 00       	call   801046a0 <release>
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
801019f8:	e8 a3 2d 00 00       	call   801047a0 <memmove>
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
80101af4:	e8 a7 2c 00 00       	call   801047a0 <memmove>
80101af9:	89 3c 24             	mov    %edi,(%esp)
80101afc:	e8 ef 13 00 00       	call   80102ef0 <log_write>
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
80101b8e:	e8 8d 2c 00 00       	call   80104820 <strncmp>
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
80101bf5:	e8 26 2c 00 00       	call   80104820 <strncmp>
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
80101c2d:	68 f9 76 10 80       	push   $0x801076f9
80101c32:	e8 39 e7 ff ff       	call   80100370 <panic>
80101c37:	83 ec 0c             	sub    $0xc,%esp
80101c3a:	68 e7 76 10 80       	push   $0x801076e7
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
80101c69:	e8 d2 1c 00 00       	call   80103940 <myproc>
80101c6e:	83 ec 0c             	sub    $0xc,%esp
80101c71:	8b 70 68             	mov    0x68(%eax),%esi
80101c74:	68 e0 19 11 80       	push   $0x801119e0
80101c79:	e8 02 29 00 00       	call   80104580 <acquire>
80101c7e:	83 46 08 01          	addl   $0x1,0x8(%esi)
80101c82:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101c89:	e8 12 2a 00 00       	call   801046a0 <release>
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
80101ce5:	e8 b6 2a 00 00       	call   801047a0 <memmove>
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
80101d74:	e8 27 2a 00 00       	call   801047a0 <memmove>
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
80101e5d:	e8 2e 2a 00 00       	call   80104890 <strncpy>
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
80101e9b:	68 08 77 10 80       	push   $0x80107708
80101ea0:	e8 cb e4 ff ff       	call   80100370 <panic>
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 2e 7d 10 80       	push   $0x80107d2e
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
80101fb0:	68 74 77 10 80       	push   $0x80107774
80101fb5:	e8 b6 e3 ff ff       	call   80100370 <panic>
80101fba:	83 ec 0c             	sub    $0xc,%esp
80101fbd:	68 6b 77 10 80       	push   $0x8010776b
80101fc2:	e8 a9 e3 ff ff       	call   80100370 <panic>
80101fc7:	89 f6                	mov    %esi,%esi
80101fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fd0 <ideinit>:
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	83 ec 10             	sub    $0x10,%esp
80101fd6:	68 86 77 10 80       	push   $0x80107786
80101fdb:	68 80 b5 10 80       	push   $0x8010b580
80101fe0:	e8 9b 24 00 00       	call   80104480 <initlock>
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
8010205e:	e8 1d 25 00 00       	call   80104580 <acquire>
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
8010208e:	e8 2d 21 00 00       	call   801041c0 <wakeup>
80102093:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102098:	83 c4 10             	add    $0x10,%esp
8010209b:	85 c0                	test   %eax,%eax
8010209d:	74 05                	je     801020a4 <ideintr+0x54>
8010209f:	e8 5c fe ff ff       	call   80101f00 <idestart>
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	68 80 b5 10 80       	push   $0x8010b580
801020ac:	e8 ef 25 00 00       	call   801046a0 <release>
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
801020fe:	e8 4d 23 00 00       	call   80104450 <holdingsleep>
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
80102138:	e8 43 24 00 00       	call   80104580 <acquire>
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
80102189:	e8 82 1e 00 00       	call   80104010 <sleep>
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 c4 10             	add    $0x10,%esp
80102193:	83 e0 06             	and    $0x6,%eax
80102196:	83 f8 02             	cmp    $0x2,%eax
80102199:	75 e5                	jne    80102180 <iderw+0x90>
8010219b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
801021a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021a5:	c9                   	leave  
801021a6:	e9 f5 24 00 00       	jmp    801046a0 <release>
801021ab:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801021b0:	eb b2                	jmp    80102164 <iderw+0x74>
801021b2:	89 d8                	mov    %ebx,%eax
801021b4:	e8 47 fd ff ff       	call   80101f00 <idestart>
801021b9:	eb b3                	jmp    8010216e <iderw+0x7e>
801021bb:	83 ec 0c             	sub    $0xc,%esp
801021be:	68 8a 77 10 80       	push   $0x8010778a
801021c3:	e8 a8 e1 ff ff       	call   80100370 <panic>
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 b5 77 10 80       	push   $0x801077b5
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 a0 77 10 80       	push   $0x801077a0
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
8010223a:	68 d4 77 10 80       	push   $0x801077d4
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
801022ee:	0f 85 ae 00 00 00    	jne    801023a2 <kfree+0xc2>
801022f4:	81 fe a8 e4 14 80    	cmp    $0x8014e4a8,%esi
801022fa:	0f 82 a2 00 00 00    	jb     801023a2 <kfree+0xc2>
80102300:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80102306:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010230b:	0f 87 91 00 00 00    	ja     801023a2 <kfree+0xc2>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  
  if(kmem.pageRefCount[V2P(v)>>PGSHIFT] <=0)
80102311:	c1 e8 0c             	shr    $0xc,%eax
80102314:	8d 58 0c             	lea    0xc(%eax),%ebx
80102317:	8b 04 9d 4c 36 11 80 	mov    -0x7feec9b4(,%ebx,4),%eax
8010231e:	85 c0                	test   %eax,%eax
80102320:	74 16                	je     80102338 <kfree+0x58>
      if(kmem.use_lock)
        release(&kmem.lock);
  }
  else
  {
    kmem.pageRefCount[V2P(v)>>PGSHIFT]--;
80102322:	83 e8 01             	sub    $0x1,%eax
80102325:	89 04 9d 4c 36 11 80 	mov    %eax,-0x7feec9b4(,%ebx,4)
  }


}
8010232c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010232f:	5b                   	pop    %ebx
80102330:	5e                   	pop    %esi
80102331:	5d                   	pop    %ebp
80102332:	c3                   	ret    
80102333:	90                   	nop
80102334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  
  if(kmem.pageRefCount[V2P(v)>>PGSHIFT] <=0)
  {
     memset(v, 1, PGSIZE);
80102338:	83 ec 04             	sub    $0x4,%esp
8010233b:	68 00 10 00 00       	push   $0x1000
80102340:	6a 01                	push   $0x1
80102342:	56                   	push   %esi
80102343:	e8 a8 23 00 00       	call   801046f0 <memset>
     if(kmem.use_lock)
80102348:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010234e:	83 c4 10             	add    $0x10,%esp
80102351:	85 d2                	test   %edx,%edx
80102353:	75 3b                	jne    80102390 <kfree+0xb0>
        acquire(&kmem.lock);
      r = (struct run*)v;
      r->next = kmem.freelist;
80102355:	a1 78 36 11 80       	mov    0x80113678,%eax
8010235a:	89 06                	mov    %eax,(%esi)
      kmem.pageRefCount[V2P(v)>>PGSHIFT] = 0;
      kmem.freelist = r;
      if(kmem.use_lock)
8010235c:	a1 74 36 11 80       	mov    0x80113674,%eax
     memset(v, 1, PGSIZE);
     if(kmem.use_lock)
        acquire(&kmem.lock);
      r = (struct run*)v;
      r->next = kmem.freelist;
      kmem.pageRefCount[V2P(v)>>PGSHIFT] = 0;
80102361:	c7 04 9d 4c 36 11 80 	movl   $0x0,-0x7feec9b4(,%ebx,4)
80102368:	00 00 00 00 
      kmem.freelist = r;
8010236c:	89 35 78 36 11 80    	mov    %esi,0x80113678
      if(kmem.use_lock)
80102372:	85 c0                	test   %eax,%eax
80102374:	74 b6                	je     8010232c <kfree+0x4c>
        release(&kmem.lock);
80102376:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
  {
    kmem.pageRefCount[V2P(v)>>PGSHIFT]--;
  }


}
8010237d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102380:	5b                   	pop    %ebx
80102381:	5e                   	pop    %esi
80102382:	5d                   	pop    %ebp
      r = (struct run*)v;
      r->next = kmem.freelist;
      kmem.pageRefCount[V2P(v)>>PGSHIFT] = 0;
      kmem.freelist = r;
      if(kmem.use_lock)
        release(&kmem.lock);
80102383:	e9 18 23 00 00       	jmp    801046a0 <release>
80102388:	90                   	nop
80102389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  if(kmem.pageRefCount[V2P(v)>>PGSHIFT] <=0)
  {
     memset(v, 1, PGSIZE);
     if(kmem.use_lock)
        acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 40 36 11 80       	push   $0x80113640
80102398:	e8 e3 21 00 00       	call   80104580 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb b3                	jmp    80102355 <kfree+0x75>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 06 78 10 80       	push   $0x80107806
801023aa:	e8 c1 df ff ff       	call   80100370 <panic>
801023af:	90                   	nop

801023b0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801023c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023cd:	39 de                	cmp    %ebx,%esi
801023cf:	72 37                	jb     80102408 <freerange+0x58>
801023d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801023d8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801023de:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801023e1:	c1 e8 0c             	shr    $0xc,%eax
801023e4:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
801023eb:	00 00 00 00 
    kfree(p);
801023ef:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801023f5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
801023fb:	50                   	push   %eax
801023fc:	e8 df fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102401:	83 c4 10             	add    $0x10,%esp
80102404:	39 f3                	cmp    %esi,%ebx
80102406:	76 d0                	jbe    801023d8 <freerange+0x28>
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
    
  }
}
80102408:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010240b:	5b                   	pop    %ebx
8010240c:	5e                   	pop    %esi
8010240d:	5d                   	pop    %ebp
8010240e:	c3                   	ret    
8010240f:	90                   	nop

80102410 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 0c 78 10 80       	push   $0x8010780c
80102420:	68 40 36 11 80       	push   $0x80113640
80102425:	e8 56 20 00 00       	call   80104480 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010242d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102430:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102437:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 30                	jb     80102480 <kinit1+0x70>
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
80102450:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
80102456:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
80102459:	c1 e8 0c             	shr    $0xc,%eax
8010245c:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
80102463:	00 00 00 00 
    kfree(p);
80102467:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010246d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
80102473:	50                   	push   %eax
80102474:	e8 67 fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102479:	83 c4 10             	add    $0x10,%esp
8010247c:	39 de                	cmp    %ebx,%esi
8010247e:	73 d0                	jae    80102450 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
80102480:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102483:	5b                   	pop    %ebx
80102484:	5e                   	pop    %esi
80102485:	5d                   	pop    %ebp
80102486:	c3                   	ret    
80102487:	89 f6                	mov    %esi,%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 37                	jb     801024e8 <kinit2+0x58>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801024b8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
    kfree(p);
801024be:	83 ec 0c             	sub    $0xc,%esp
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
801024c1:	c1 e8 0c             	shr    $0xc,%eax
801024c4:	c7 04 85 7c 36 11 80 	movl   $0x0,-0x7feec984(,%eax,4)
801024cb:	00 00 00 00 
    kfree(p);
801024cf:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024d5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kmem.pageRefCount[V2P(p)>>PGSHIFT] = 0;
    kfree(p);
801024db:	50                   	push   %eax
801024dc:	e8 ff fd ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801024e1:	83 c4 10             	add    $0x10,%esp
801024e4:	39 de                	cmp    %ebx,%esi
801024e6:	73 d0                	jae    801024b8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024e8:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
801024ef:	00 00 00 
}
801024f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024f5:	5b                   	pop    %ebx
801024f6:	5e                   	pop    %esi
801024f7:	5d                   	pop    %ebp
801024f8:	c3                   	ret    
801024f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102500 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102500:	8b 15 74 36 11 80    	mov    0x80113674,%edx
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102506:	55                   	push   %ebp
80102507:	89 e5                	mov    %esp,%ebp
80102509:	56                   	push   %esi
8010250a:	53                   	push   %ebx
  struct run *r;

  if(kmem.use_lock)
8010250b:	85 d2                	test   %edx,%edx
8010250d:	75 71                	jne    80102580 <kalloc+0x80>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010250f:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r){
80102515:	85 db                	test   %ebx,%ebx
80102517:	74 35                	je     8010254e <kalloc+0x4e>
    cprintf("aehhoooo vai ter copa em %d\n",V2P((char *)r)>>PGSHIFT );
80102519:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
8010251f:	83 ec 08             	sub    $0x8,%esp
80102522:	c1 ee 0c             	shr    $0xc,%esi
80102525:	56                   	push   %esi
80102526:	68 11 78 10 80       	push   $0x80107811
8010252b:	e8 30 e1 ff ff       	call   80100660 <cprintf>
    kmem.pageRefCount[V2P((char*)r)>>PGSHIFT] = 1; 
80102530:	c7 04 b5 7c 36 11 80 	movl   $0x1,-0x7feec984(,%esi,4)
80102537:	01 00 00 00 
    kmem.freelist = r->next;
8010253b:	8b 03                	mov    (%ebx),%eax
8010253d:	83 c4 10             	add    $0x10,%esp
80102540:	a3 78 36 11 80       	mov    %eax,0x80113678
    }
  if(kmem.use_lock)
80102545:	a1 74 36 11 80       	mov    0x80113674,%eax
8010254a:	85 c0                	test   %eax,%eax
8010254c:	75 12                	jne    80102560 <kalloc+0x60>
    release(&kmem.lock);
  return (char*)r;
}
8010254e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102551:	89 d8                	mov    %ebx,%eax
80102553:	5b                   	pop    %ebx
80102554:	5e                   	pop    %esi
80102555:	5d                   	pop    %ebp
80102556:	c3                   	ret    
80102557:	89 f6                	mov    %esi,%esi
80102559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("aehhoooo vai ter copa em %d\n",V2P((char *)r)>>PGSHIFT );
    kmem.pageRefCount[V2P((char*)r)>>PGSHIFT] = 1; 
    kmem.freelist = r->next;
    }
  if(kmem.use_lock)
    release(&kmem.lock);
80102560:	83 ec 0c             	sub    $0xc,%esp
80102563:	68 40 36 11 80       	push   $0x80113640
80102568:	e8 33 21 00 00       	call   801046a0 <release>
8010256d:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102570:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102573:	89 d8                	mov    %ebx,%eax
80102575:	5b                   	pop    %ebx
80102576:	5e                   	pop    %esi
80102577:	5d                   	pop    %ebp
80102578:	c3                   	ret    
80102579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102580:	83 ec 0c             	sub    $0xc,%esp
80102583:	68 40 36 11 80       	push   $0x80113640
80102588:	e8 f3 1f 00 00       	call   80104580 <acquire>
  r = kmem.freelist;
8010258d:	8b 1d 78 36 11 80    	mov    0x80113678,%ebx
  if(r){
80102593:	83 c4 10             	add    $0x10,%esp
80102596:	85 db                	test   %ebx,%ebx
80102598:	0f 85 7b ff ff ff    	jne    80102519 <kalloc+0x19>
8010259e:	eb a5                	jmp    80102545 <kalloc+0x45>

801025a0 <addRefCount>:
  return (char*)r;
}

void
addRefCount(uint value)
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	53                   	push   %ebx
801025a4:	83 ec 04             	sub    $0x4,%esp
801025a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
801025aa:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
801025b0:	72 33                	jb     801025e5 <addRefCount+0x45>
801025b2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
801025b8:	77 2b                	ja     801025e5 <addRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
801025ba:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])++;
801025bd:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
801025c0:	68 40 36 11 80       	push   $0x80113640
801025c5:	e8 b6 1f 00 00       	call   80104580 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])++;
801025ca:	83 04 9d 7c 36 11 80 	addl   $0x1,-0x7feec984(,%ebx,4)
801025d1:	01 
  release(&kmem.lock);   
801025d2:	83 c4 10             	add    $0x10,%esp
801025d5:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
801025dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025df:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])++;
  release(&kmem.lock);   
801025e0:	e9 bb 20 00 00       	jmp    801046a0 <release>
void
addRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
801025e5:	83 ec 0c             	sub    $0xc,%esp
801025e8:	68 2e 78 10 80       	push   $0x8010782e
801025ed:	e8 7e dd ff ff       	call   80100370 <panic>
801025f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102600 <minusRefCount>:

}

void
minusRefCount(uint value)
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	53                   	push   %ebx
80102604:	83 ec 04             	sub    $0x4,%esp
80102607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010260a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
80102610:	72 33                	jb     80102645 <minusRefCount+0x45>
80102612:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102618:	77 2b                	ja     80102645 <minusRefCount+0x45>
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
8010261a:	83 ec 0c             	sub    $0xc,%esp
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010261d:	c1 eb 0c             	shr    $0xc,%ebx
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
80102620:	68 40 36 11 80       	push   $0x80113640
80102625:	e8 56 1f 00 00       	call   80104580 <acquire>
  (kmem.pageRefCount[value>>PGSHIFT])--;
8010262a:	83 2c 9d 7c 36 11 80 	subl   $0x1,-0x7feec984(,%ebx,4)
80102631:	01 
  release(&kmem.lock);   
80102632:	83 c4 10             	add    $0x10,%esp
80102635:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
8010263c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010263f:	c9                   	leave  
  {
    panic("Acesso invalido");
  }
  acquire(&kmem.lock);
  (kmem.pageRefCount[value>>PGSHIFT])--;
  release(&kmem.lock);   
80102640:	e9 5b 20 00 00       	jmp    801046a0 <release>
void
minusRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
80102645:	83 ec 0c             	sub    $0xc,%esp
80102648:	68 2e 78 10 80       	push   $0x8010782e
8010264d:	e8 1e dd ff ff       	call   80100370 <panic>
80102652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102660 <getRefCount>:

}

uint
getRefCount(uint value)
{
80102660:	55                   	push   %ebp
80102661:	89 e5                	mov    %esp,%ebp
80102663:	53                   	push   %ebx
80102664:	83 ec 04             	sub    $0x4,%esp
80102667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
8010266a:	81 fb a8 e4 14 00    	cmp    $0x14e4a8,%ebx
80102670:	72 32                	jb     801026a4 <getRefCount+0x44>
80102672:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102678:	77 2a                	ja     801026a4 <getRefCount+0x44>
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
8010267a:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pageRefCount[value>>PGSHIFT];  
8010267d:	c1 eb 0c             	shr    $0xc,%ebx
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
  }
  uint count;
  acquire(&kmem.lock);
80102680:	68 40 36 11 80       	push   $0x80113640
80102685:	e8 f6 1e 00 00       	call   80104580 <acquire>
  count = kmem.pageRefCount[value>>PGSHIFT];  
8010268a:	8b 1c 9d 7c 36 11 80 	mov    -0x7feec984(,%ebx,4),%ebx
  release(&kmem.lock);
80102691:	c7 04 24 40 36 11 80 	movl   $0x80113640,(%esp)
80102698:	e8 03 20 00 00       	call   801046a0 <release>
     
  return count;
}
8010269d:	89 d8                	mov    %ebx,%eax
8010269f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026a2:	c9                   	leave  
801026a3:	c3                   	ret    
uint
getRefCount(uint value)
{
  if((value < (uint)(V2P(end))) || (value >= PHYSTOP))
  {
    panic("Acesso invalido");
801026a4:	83 ec 0c             	sub    $0xc,%esp
801026a7:	68 2e 78 10 80       	push   $0x8010782e
801026ac:	e8 bf dc ff ff       	call   80100370 <panic>
801026b1:	66 90                	xchg   %ax,%ax
801026b3:	66 90                	xchg   %ax,%ax
801026b5:	66 90                	xchg   %ax,%ax
801026b7:	66 90                	xchg   %ax,%ax
801026b9:	66 90                	xchg   %ax,%ax
801026bb:	66 90                	xchg   %ax,%ax
801026bd:	66 90                	xchg   %ax,%ax
801026bf:	90                   	nop

801026c0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026c0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026c1:	ba 64 00 00 00       	mov    $0x64,%edx
801026c6:	89 e5                	mov    %esp,%ebp
801026c8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026c9:	a8 01                	test   $0x1,%al
801026cb:	0f 84 af 00 00 00    	je     80102780 <kbdgetc+0xc0>
801026d1:	ba 60 00 00 00       	mov    $0x60,%edx
801026d6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026d7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801026da:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026e0:	74 7e                	je     80102760 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026e2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026e4:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026ea:	79 24                	jns    80102710 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026ec:	f6 c1 40             	test   $0x40,%cl
801026ef:	75 05                	jne    801026f6 <kbdgetc+0x36>
801026f1:	89 c2                	mov    %eax,%edx
801026f3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801026f6:	0f b6 82 60 79 10 80 	movzbl -0x7fef86a0(%edx),%eax
801026fd:	83 c8 40             	or     $0x40,%eax
80102700:	0f b6 c0             	movzbl %al,%eax
80102703:	f7 d0                	not    %eax
80102705:	21 c8                	and    %ecx,%eax
80102707:	a3 b4 b5 10 80       	mov    %eax,0x8010b5b4
    return 0;
8010270c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010270e:	5d                   	pop    %ebp
8010270f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102710:	f6 c1 40             	test   $0x40,%cl
80102713:	74 09                	je     8010271e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102715:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102718:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010271b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010271e:	0f b6 82 60 79 10 80 	movzbl -0x7fef86a0(%edx),%eax
80102725:	09 c1                	or     %eax,%ecx
80102727:	0f b6 82 60 78 10 80 	movzbl -0x7fef87a0(%edx),%eax
8010272e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102730:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102732:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102738:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010273b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010273e:	8b 04 85 40 78 10 80 	mov    -0x7fef87c0(,%eax,4),%eax
80102745:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102749:	74 c3                	je     8010270e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010274b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010274e:	83 fa 19             	cmp    $0x19,%edx
80102751:	77 1d                	ja     80102770 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102753:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102756:	5d                   	pop    %ebp
80102757:	c3                   	ret    
80102758:	90                   	nop
80102759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102760:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102762:	83 0d b4 b5 10 80 40 	orl    $0x40,0x8010b5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102770:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102773:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102776:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102777:	83 f9 19             	cmp    $0x19,%ecx
8010277a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010277d:	c3                   	ret    
8010277e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102785:	5d                   	pop    %ebp
80102786:	c3                   	ret    
80102787:	89 f6                	mov    %esi,%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <kbdintr>:

void
kbdintr(void)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102796:	68 c0 26 10 80       	push   $0x801026c0
8010279b:	e8 50 e0 ff ff       	call   801007f0 <consoleintr>
}
801027a0:	83 c4 10             	add    $0x10,%esp
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	66 90                	xchg   %ax,%ax
801027a7:	66 90                	xchg   %ax,%ax
801027a9:	66 90                	xchg   %ax,%ax
801027ab:	66 90                	xchg   %ax,%ax
801027ad:	66 90                	xchg   %ax,%ax
801027af:	90                   	nop

801027b0 <lapicinit>:
801027b0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801027b5:	55                   	push   %ebp
801027b6:	89 e5                	mov    %esp,%ebp
801027b8:	85 c0                	test   %eax,%eax
801027ba:	0f 84 c8 00 00 00    	je     80102888 <lapicinit+0xd8>
801027c0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027c7:	01 00 00 
801027ca:	8b 50 20             	mov    0x20(%eax),%edx
801027cd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027d4:	00 00 00 
801027d7:	8b 50 20             	mov    0x20(%eax),%edx
801027da:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027e1:	00 02 00 
801027e4:	8b 50 20             	mov    0x20(%eax),%edx
801027e7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027ee:	96 98 00 
801027f1:	8b 50 20             	mov    0x20(%eax),%edx
801027f4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027fb:	00 01 00 
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
80102801:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102808:	00 01 00 
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
8010280e:	8b 50 30             	mov    0x30(%eax),%edx
80102811:	c1 ea 10             	shr    $0x10,%edx
80102814:	80 fa 03             	cmp    $0x3,%dl
80102817:	77 77                	ja     80102890 <lapicinit+0xe0>
80102819:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102820:	00 00 00 
80102823:	8b 50 20             	mov    0x20(%eax),%edx
80102826:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282d:	00 00 00 
80102830:	8b 50 20             	mov    0x20(%eax),%edx
80102833:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283a:	00 00 00 
8010283d:	8b 50 20             	mov    0x20(%eax),%edx
80102840:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102847:	00 00 00 
8010284a:	8b 50 20             	mov    0x20(%eax),%edx
8010284d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102854:	00 00 00 
80102857:	8b 50 20             	mov    0x20(%eax),%edx
8010285a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102861:	85 08 00 
80102864:	8b 50 20             	mov    0x20(%eax),%edx
80102867:	89 f6                	mov    %esi,%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102870:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102876:	80 e6 10             	and    $0x10,%dh
80102879:	75 f5                	jne    80102870 <lapicinit+0xc0>
8010287b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102882:	00 00 00 
80102885:	8b 40 20             	mov    0x20(%eax),%eax
80102888:	5d                   	pop    %ebp
80102889:	c3                   	ret    
8010288a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102890:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102897:	00 01 00 
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
8010289d:	e9 77 ff ff ff       	jmp    80102819 <lapicinit+0x69>
801028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028b0 <lapicid>:
801028b0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801028b5:	55                   	push   %ebp
801028b6:	89 e5                	mov    %esp,%ebp
801028b8:	85 c0                	test   %eax,%eax
801028ba:	74 0c                	je     801028c8 <lapicid+0x18>
801028bc:	8b 40 20             	mov    0x20(%eax),%eax
801028bf:	5d                   	pop    %ebp
801028c0:	c1 e8 18             	shr    $0x18,%eax
801028c3:	c3                   	ret    
801028c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028c8:	31 c0                	xor    %eax,%eax
801028ca:	5d                   	pop    %ebp
801028cb:	c3                   	ret    
801028cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028d0 <lapiceoi>:
801028d0:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
801028d5:	55                   	push   %ebp
801028d6:	89 e5                	mov    %esp,%ebp
801028d8:	85 c0                	test   %eax,%eax
801028da:	74 0d                	je     801028e9 <lapiceoi+0x19>
801028dc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028e3:	00 00 00 
801028e6:	8b 40 20             	mov    0x20(%eax),%eax
801028e9:	5d                   	pop    %ebp
801028ea:	c3                   	ret    
801028eb:	90                   	nop
801028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028f0 <microdelay>:
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	5d                   	pop    %ebp
801028f4:	c3                   	ret    
801028f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102900 <lapicstartap>:
80102900:	55                   	push   %ebp
80102901:	ba 70 00 00 00       	mov    $0x70,%edx
80102906:	b8 0f 00 00 00       	mov    $0xf,%eax
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	53                   	push   %ebx
8010290e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102911:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102914:	ee                   	out    %al,(%dx)
80102915:	ba 71 00 00 00       	mov    $0x71,%edx
8010291a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010291f:	ee                   	out    %al,(%dx)
80102920:	31 c0                	xor    %eax,%eax
80102922:	c1 e3 18             	shl    $0x18,%ebx
80102925:	66 a3 67 04 00 80    	mov    %ax,0x80000467
8010292b:	89 c8                	mov    %ecx,%eax
8010292d:	c1 e9 0c             	shr    $0xc,%ecx
80102930:	c1 e8 04             	shr    $0x4,%eax
80102933:	89 da                	mov    %ebx,%edx
80102935:	80 cd 06             	or     $0x6,%ch
80102938:	66 a3 69 04 00 80    	mov    %ax,0x80000469
8010293e:	a1 7c b6 14 80       	mov    0x8014b67c,%eax
80102943:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102949:	8b 58 20             	mov    0x20(%eax),%ebx
8010294c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102953:	c5 00 00 
80102956:	8b 58 20             	mov    0x20(%eax),%ebx
80102959:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102960:	85 00 00 
80102963:	8b 58 20             	mov    0x20(%eax),%ebx
80102966:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010296c:	8b 58 20             	mov    0x20(%eax),%ebx
8010296f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102975:	8b 58 20             	mov    0x20(%eax),%ebx
80102978:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010297e:	8b 50 20             	mov    0x20(%eax),%edx
80102981:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102987:	8b 40 20             	mov    0x20(%eax),%eax
8010298a:	5b                   	pop    %ebx
8010298b:	5d                   	pop    %ebp
8010298c:	c3                   	ret    
8010298d:	8d 76 00             	lea    0x0(%esi),%esi

80102990 <cmostime>:
80102990:	55                   	push   %ebp
80102991:	ba 70 00 00 00       	mov    $0x70,%edx
80102996:	b8 0b 00 00 00       	mov    $0xb,%eax
8010299b:	89 e5                	mov    %esp,%ebp
8010299d:	57                   	push   %edi
8010299e:	56                   	push   %esi
8010299f:	53                   	push   %ebx
801029a0:	83 ec 4c             	sub    $0x4c,%esp
801029a3:	ee                   	out    %al,(%dx)
801029a4:	ba 71 00 00 00       	mov    $0x71,%edx
801029a9:	ec                   	in     (%dx),%al
801029aa:	83 e0 04             	and    $0x4,%eax
801029ad:	8d 75 d0             	lea    -0x30(%ebp),%esi
801029b0:	31 db                	xor    %ebx,%ebx
801029b2:	88 45 b7             	mov    %al,-0x49(%ebp)
801029b5:	bf 70 00 00 00       	mov    $0x70,%edi
801029ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029c0:	89 d8                	mov    %ebx,%eax
801029c2:	89 fa                	mov    %edi,%edx
801029c4:	ee                   	out    %al,(%dx)
801029c5:	b9 71 00 00 00       	mov    $0x71,%ecx
801029ca:	89 ca                	mov    %ecx,%edx
801029cc:	ec                   	in     (%dx),%al
801029cd:	0f b6 c0             	movzbl %al,%eax
801029d0:	89 fa                	mov    %edi,%edx
801029d2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029d5:	b8 02 00 00 00       	mov    $0x2,%eax
801029da:	ee                   	out    %al,(%dx)
801029db:	89 ca                	mov    %ecx,%edx
801029dd:	ec                   	in     (%dx),%al
801029de:	0f b6 c0             	movzbl %al,%eax
801029e1:	89 fa                	mov    %edi,%edx
801029e3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029e6:	b8 04 00 00 00       	mov    $0x4,%eax
801029eb:	ee                   	out    %al,(%dx)
801029ec:	89 ca                	mov    %ecx,%edx
801029ee:	ec                   	in     (%dx),%al
801029ef:	0f b6 c0             	movzbl %al,%eax
801029f2:	89 fa                	mov    %edi,%edx
801029f4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029f7:	b8 07 00 00 00       	mov    $0x7,%eax
801029fc:	ee                   	out    %al,(%dx)
801029fd:	89 ca                	mov    %ecx,%edx
801029ff:	ec                   	in     (%dx),%al
80102a00:	0f b6 c0             	movzbl %al,%eax
80102a03:	89 fa                	mov    %edi,%edx
80102a05:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a08:	b8 08 00 00 00       	mov    $0x8,%eax
80102a0d:	ee                   	out    %al,(%dx)
80102a0e:	89 ca                	mov    %ecx,%edx
80102a10:	ec                   	in     (%dx),%al
80102a11:	0f b6 c0             	movzbl %al,%eax
80102a14:	89 fa                	mov    %edi,%edx
80102a16:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102a19:	b8 09 00 00 00       	mov    $0x9,%eax
80102a1e:	ee                   	out    %al,(%dx)
80102a1f:	89 ca                	mov    %ecx,%edx
80102a21:	ec                   	in     (%dx),%al
80102a22:	0f b6 c0             	movzbl %al,%eax
80102a25:	89 fa                	mov    %edi,%edx
80102a27:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102a2a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a2f:	ee                   	out    %al,(%dx)
80102a30:	89 ca                	mov    %ecx,%edx
80102a32:	ec                   	in     (%dx),%al
80102a33:	84 c0                	test   %al,%al
80102a35:	78 89                	js     801029c0 <cmostime+0x30>
80102a37:	89 d8                	mov    %ebx,%eax
80102a39:	89 fa                	mov    %edi,%edx
80102a3b:	ee                   	out    %al,(%dx)
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al
80102a3f:	0f b6 c0             	movzbl %al,%eax
80102a42:	89 fa                	mov    %edi,%edx
80102a44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a47:	b8 02 00 00 00       	mov    $0x2,%eax
80102a4c:	ee                   	out    %al,(%dx)
80102a4d:	89 ca                	mov    %ecx,%edx
80102a4f:	ec                   	in     (%dx),%al
80102a50:	0f b6 c0             	movzbl %al,%eax
80102a53:	89 fa                	mov    %edi,%edx
80102a55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a58:	b8 04 00 00 00       	mov    $0x4,%eax
80102a5d:	ee                   	out    %al,(%dx)
80102a5e:	89 ca                	mov    %ecx,%edx
80102a60:	ec                   	in     (%dx),%al
80102a61:	0f b6 c0             	movzbl %al,%eax
80102a64:	89 fa                	mov    %edi,%edx
80102a66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a69:	b8 07 00 00 00       	mov    $0x7,%eax
80102a6e:	ee                   	out    %al,(%dx)
80102a6f:	89 ca                	mov    %ecx,%edx
80102a71:	ec                   	in     (%dx),%al
80102a72:	0f b6 c0             	movzbl %al,%eax
80102a75:	89 fa                	mov    %edi,%edx
80102a77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a7f:	ee                   	out    %al,(%dx)
80102a80:	89 ca                	mov    %ecx,%edx
80102a82:	ec                   	in     (%dx),%al
80102a83:	0f b6 c0             	movzbl %al,%eax
80102a86:	89 fa                	mov    %edi,%edx
80102a88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a90:	ee                   	out    %al,(%dx)
80102a91:	89 ca                	mov    %ecx,%edx
80102a93:	ec                   	in     (%dx),%al
80102a94:	0f b6 c0             	movzbl %al,%eax
80102a97:	83 ec 04             	sub    $0x4,%esp
80102a9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102a9d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102aa0:	6a 18                	push   $0x18
80102aa2:	56                   	push   %esi
80102aa3:	50                   	push   %eax
80102aa4:	e8 97 1c 00 00       	call   80104740 <memcmp>
80102aa9:	83 c4 10             	add    $0x10,%esp
80102aac:	85 c0                	test   %eax,%eax
80102aae:	0f 85 0c ff ff ff    	jne    801029c0 <cmostime+0x30>
80102ab4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102ab8:	75 78                	jne    80102b32 <cmostime+0x1a2>
80102aba:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102abd:	89 c2                	mov    %eax,%edx
80102abf:	83 e0 0f             	and    $0xf,%eax
80102ac2:	c1 ea 04             	shr    $0x4,%edx
80102ac5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ac8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102acb:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ace:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ad1:	89 c2                	mov    %eax,%edx
80102ad3:	83 e0 0f             	and    $0xf,%eax
80102ad6:	c1 ea 04             	shr    $0x4,%edx
80102ad9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102adc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102adf:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ae2:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ae5:	89 c2                	mov    %eax,%edx
80102ae7:	83 e0 0f             	and    $0xf,%eax
80102aea:	c1 ea 04             	shr    $0x4,%edx
80102aed:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af0:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af3:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102af6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102af9:	89 c2                	mov    %eax,%edx
80102afb:	83 e0 0f             	and    $0xf,%eax
80102afe:	c1 ea 04             	shr    $0x4,%edx
80102b01:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b04:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b07:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b0a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b0d:	89 c2                	mov    %eax,%edx
80102b0f:	83 e0 0f             	and    $0xf,%eax
80102b12:	c1 ea 04             	shr    $0x4,%edx
80102b15:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b18:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1b:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b1e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b21:	89 c2                	mov    %eax,%edx
80102b23:	83 e0 0f             	and    $0xf,%eax
80102b26:	c1 ea 04             	shr    $0x4,%edx
80102b29:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2f:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102b32:	8b 75 08             	mov    0x8(%ebp),%esi
80102b35:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b38:	89 06                	mov    %eax,(%esi)
80102b3a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b3d:	89 46 04             	mov    %eax,0x4(%esi)
80102b40:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b43:	89 46 08             	mov    %eax,0x8(%esi)
80102b46:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b49:	89 46 0c             	mov    %eax,0xc(%esi)
80102b4c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b4f:	89 46 10             	mov    %eax,0x10(%esi)
80102b52:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b55:	89 46 14             	mov    %eax,0x14(%esi)
80102b58:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
80102b5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b62:	5b                   	pop    %ebx
80102b63:	5e                   	pop    %esi
80102b64:	5f                   	pop    %edi
80102b65:	5d                   	pop    %ebp
80102b66:	c3                   	ret    
80102b67:	66 90                	xchg   %ax,%ax
80102b69:	66 90                	xchg   %ax,%ax
80102b6b:	66 90                	xchg   %ax,%ax
80102b6d:	66 90                	xchg   %ax,%ax
80102b6f:	90                   	nop

80102b70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b70:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
80102b76:	85 c9                	test   %ecx,%ecx
80102b78:	0f 8e 85 00 00 00    	jle    80102c03 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102b7e:	55                   	push   %ebp
80102b7f:	89 e5                	mov    %esp,%ebp
80102b81:	57                   	push   %edi
80102b82:	56                   	push   %esi
80102b83:	53                   	push   %ebx
80102b84:	31 db                	xor    %ebx,%ebx
80102b86:	83 ec 0c             	sub    $0xc,%esp
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b90:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102b95:	83 ec 08             	sub    $0x8,%esp
80102b98:	01 d8                	add    %ebx,%eax
80102b9a:	83 c0 01             	add    $0x1,%eax
80102b9d:	50                   	push   %eax
80102b9e:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102ba4:	e8 27 d5 ff ff       	call   801000d0 <bread>
80102ba9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bab:	58                   	pop    %eax
80102bac:	5a                   	pop    %edx
80102bad:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102bb4:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bba:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbd:	e8 0e d5 ff ff       	call   801000d0 <bread>
80102bc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bc7:	83 c4 0c             	add    $0xc,%esp
80102bca:	68 00 02 00 00       	push   $0x200
80102bcf:	50                   	push   %eax
80102bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bd3:	50                   	push   %eax
80102bd4:	e8 c7 1b 00 00       	call   801047a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 bf d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102be1:	89 3c 24             	mov    %edi,(%esp)
80102be4:	e8 f7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102be9:	89 34 24             	mov    %esi,(%esp)
80102bec:	e8 ef d5 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bf1:	83 c4 10             	add    $0x10,%esp
80102bf4:	39 1d c8 b6 14 80    	cmp    %ebx,0x8014b6c8
80102bfa:	7f 94                	jg     80102b90 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bff:	5b                   	pop    %ebx
80102c00:	5e                   	pop    %esi
80102c01:	5f                   	pop    %edi
80102c02:	5d                   	pop    %ebp
80102c03:	f3 c3                	repz ret 
80102c05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	53                   	push   %ebx
80102c14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c17:	ff 35 b4 b6 14 80    	pushl  0x8014b6b4
80102c1d:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102c23:	e8 a8 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c28:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c2e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c31:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c33:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c35:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c38:	7e 1f                	jle    80102c59 <write_head+0x49>
80102c3a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102c41:	31 d2                	xor    %edx,%edx
80102c43:	90                   	nop
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c48:	8b 8a cc b6 14 80    	mov    -0x7feb4934(%edx),%ecx
80102c4e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102c52:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c55:	39 c2                	cmp    %eax,%edx
80102c57:	75 ef                	jne    80102c48 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102c59:	83 ec 0c             	sub    $0xc,%esp
80102c5c:	53                   	push   %ebx
80102c5d:	e8 3e d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c62:	89 1c 24             	mov    %ebx,(%esp)
80102c65:	e8 76 d5 ff ff       	call   801001e0 <brelse>
}
80102c6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c6d:	c9                   	leave  
80102c6e:	c3                   	ret    
80102c6f:	90                   	nop

80102c70 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	53                   	push   %ebx
80102c74:	83 ec 2c             	sub    $0x2c,%esp
80102c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102c7a:	68 60 7a 10 80       	push   $0x80107a60
80102c7f:	68 80 b6 14 80       	push   $0x8014b680
80102c84:	e8 f7 17 00 00       	call   80104480 <initlock>
  readsb(dev, &sb);
80102c89:	58                   	pop    %eax
80102c8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c8d:	5a                   	pop    %edx
80102c8e:	50                   	push   %eax
80102c8f:	53                   	push   %ebx
80102c90:	e8 1b e7 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c95:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c98:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c9b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102c9c:	89 1d c4 b6 14 80    	mov    %ebx,0x8014b6c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ca2:	89 15 b8 b6 14 80    	mov    %edx,0x8014b6b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ca8:	a3 b4 b6 14 80       	mov    %eax,0x8014b6b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 1b d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cb5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102cb8:	83 c4 10             	add    $0x10,%esp
80102cbb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102cbd:	89 0d c8 b6 14 80    	mov    %ecx,0x8014b6c8
  for (i = 0; i < log.lh.n; i++) {
80102cc3:	7e 1c                	jle    80102ce1 <initlog+0x71>
80102cc5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102ccc:	31 d2                	xor    %edx,%edx
80102cce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102cd0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cd4:	83 c2 04             	add    $0x4,%edx
80102cd7:	89 8a c8 b6 14 80    	mov    %ecx,-0x7feb4938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102cdd:	39 da                	cmp    %ebx,%edx
80102cdf:	75 ef                	jne    80102cd0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102ce1:	83 ec 0c             	sub    $0xc,%esp
80102ce4:	50                   	push   %eax
80102ce5:	e8 f6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cea:	e8 81 fe ff ff       	call   80102b70 <install_trans>
  log.lh.n = 0;
80102cef:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
80102cf6:	00 00 00 
  write_head(); // clear the log
80102cf9:	e8 12 ff ff ff       	call   80102c10 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102cfe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d01:	c9                   	leave  
80102d02:	c3                   	ret    
80102d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d16:	68 80 b6 14 80       	push   $0x8014b680
80102d1b:	e8 60 18 00 00       	call   80104580 <acquire>
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	eb 18                	jmp    80102d3d <begin_op+0x2d>
80102d25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d28:	83 ec 08             	sub    $0x8,%esp
80102d2b:	68 80 b6 14 80       	push   $0x8014b680
80102d30:	68 80 b6 14 80       	push   $0x8014b680
80102d35:	e8 d6 12 00 00       	call   80104010 <sleep>
80102d3a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102d3d:	a1 c0 b6 14 80       	mov    0x8014b6c0,%eax
80102d42:	85 c0                	test   %eax,%eax
80102d44:	75 e2                	jne    80102d28 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d46:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102d4b:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
80102d51:	83 c0 01             	add    $0x1,%eax
80102d54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d5a:	83 fa 1e             	cmp    $0x1e,%edx
80102d5d:	7f c9                	jg     80102d28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d5f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102d62:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
      release(&log.lock);
80102d67:	68 80 b6 14 80       	push   $0x8014b680
80102d6c:	e8 2f 19 00 00       	call   801046a0 <release>
      break;
    }
  }
}
80102d71:	83 c4 10             	add    $0x10,%esp
80102d74:	c9                   	leave  
80102d75:	c3                   	ret    
80102d76:	8d 76 00             	lea    0x0(%esi),%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	57                   	push   %edi
80102d84:	56                   	push   %esi
80102d85:	53                   	push   %ebx
80102d86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d89:	68 80 b6 14 80       	push   $0x8014b680
80102d8e:	e8 ed 17 00 00       	call   80104580 <acquire>
  log.outstanding -= 1;
80102d93:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
  if(log.committing)
80102d98:	8b 1d c0 b6 14 80    	mov    0x8014b6c0,%ebx
80102d9e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102da1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102da4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102da6:	a3 bc b6 14 80       	mov    %eax,0x8014b6bc
  if(log.committing)
80102dab:	0f 85 23 01 00 00    	jne    80102ed4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102db1:	85 c0                	test   %eax,%eax
80102db3:	0f 85 f7 00 00 00    	jne    80102eb0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102db9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102dbc:	c7 05 c0 b6 14 80 01 	movl   $0x1,0x8014b6c0
80102dc3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dc6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dc8:	68 80 b6 14 80       	push   $0x8014b680
80102dcd:	e8 ce 18 00 00       	call   801046a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dd2:	8b 0d c8 b6 14 80    	mov    0x8014b6c8,%ecx
80102dd8:	83 c4 10             	add    $0x10,%esp
80102ddb:	85 c9                	test   %ecx,%ecx
80102ddd:	0f 8e 8a 00 00 00    	jle    80102e6d <end_op+0xed>
80102de3:	90                   	nop
80102de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102de8:	a1 b4 b6 14 80       	mov    0x8014b6b4,%eax
80102ded:	83 ec 08             	sub    $0x8,%esp
80102df0:	01 d8                	add    %ebx,%eax
80102df2:	83 c0 01             	add    $0x1,%eax
80102df5:	50                   	push   %eax
80102df6:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
80102dfc:	e8 cf d2 ff ff       	call   801000d0 <bread>
80102e01:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e03:	58                   	pop    %eax
80102e04:	5a                   	pop    %edx
80102e05:	ff 34 9d cc b6 14 80 	pushl  -0x7feb4934(,%ebx,4)
80102e0c:	ff 35 c4 b6 14 80    	pushl  0x8014b6c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e12:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e15:	e8 b6 d2 ff ff       	call   801000d0 <bread>
80102e1a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e1c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e1f:	83 c4 0c             	add    $0xc,%esp
80102e22:	68 00 02 00 00       	push   $0x200
80102e27:	50                   	push   %eax
80102e28:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e2b:	50                   	push   %eax
80102e2c:	e8 6f 19 00 00       	call   801047a0 <memmove>
    bwrite(to);  // write the log
80102e31:	89 34 24             	mov    %esi,(%esp)
80102e34:	e8 67 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e39:	89 3c 24             	mov    %edi,(%esp)
80102e3c:	e8 9f d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e41:	89 34 24             	mov    %esi,(%esp)
80102e44:	e8 97 d3 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e49:	83 c4 10             	add    $0x10,%esp
80102e4c:	3b 1d c8 b6 14 80    	cmp    0x8014b6c8,%ebx
80102e52:	7c 94                	jl     80102de8 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e54:	e8 b7 fd ff ff       	call   80102c10 <write_head>
    install_trans(); // Now install writes to home locations
80102e59:	e8 12 fd ff ff       	call   80102b70 <install_trans>
    log.lh.n = 0;
80102e5e:	c7 05 c8 b6 14 80 00 	movl   $0x0,0x8014b6c8
80102e65:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e68:	e8 a3 fd ff ff       	call   80102c10 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102e6d:	83 ec 0c             	sub    $0xc,%esp
80102e70:	68 80 b6 14 80       	push   $0x8014b680
80102e75:	e8 06 17 00 00       	call   80104580 <acquire>
    log.committing = 0;
    wakeup(&log);
80102e7a:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102e81:	c7 05 c0 b6 14 80 00 	movl   $0x0,0x8014b6c0
80102e88:	00 00 00 
    wakeup(&log);
80102e8b:	e8 30 13 00 00       	call   801041c0 <wakeup>
    release(&log.lock);
80102e90:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102e97:	e8 04 18 00 00       	call   801046a0 <release>
80102e9c:	83 c4 10             	add    $0x10,%esp
  }
}
80102e9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ea2:	5b                   	pop    %ebx
80102ea3:	5e                   	pop    %esi
80102ea4:	5f                   	pop    %edi
80102ea5:	5d                   	pop    %ebp
80102ea6:	c3                   	ret    
80102ea7:	89 f6                	mov    %esi,%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102eb0:	83 ec 0c             	sub    $0xc,%esp
80102eb3:	68 80 b6 14 80       	push   $0x8014b680
80102eb8:	e8 03 13 00 00       	call   801041c0 <wakeup>
  }
  release(&log.lock);
80102ebd:	c7 04 24 80 b6 14 80 	movl   $0x8014b680,(%esp)
80102ec4:	e8 d7 17 00 00       	call   801046a0 <release>
80102ec9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ecf:	5b                   	pop    %ebx
80102ed0:	5e                   	pop    %esi
80102ed1:	5f                   	pop    %edi
80102ed2:	5d                   	pop    %ebp
80102ed3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102ed4:	83 ec 0c             	sub    $0xc,%esp
80102ed7:	68 64 7a 10 80       	push   $0x80107a64
80102edc:	e8 8f d4 ff ff       	call   80100370 <panic>
80102ee1:	eb 0d                	jmp    80102ef0 <log_write>
80102ee3:	90                   	nop
80102ee4:	90                   	nop
80102ee5:	90                   	nop
80102ee6:	90                   	nop
80102ee7:	90                   	nop
80102ee8:	90                   	nop
80102ee9:	90                   	nop
80102eea:	90                   	nop
80102eeb:	90                   	nop
80102eec:	90                   	nop
80102eed:	90                   	nop
80102eee:	90                   	nop
80102eef:	90                   	nop

80102ef0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	53                   	push   %ebx
80102ef4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ef7:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102efd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f00:	83 fa 1d             	cmp    $0x1d,%edx
80102f03:	0f 8f 97 00 00 00    	jg     80102fa0 <log_write+0xb0>
80102f09:	a1 b8 b6 14 80       	mov    0x8014b6b8,%eax
80102f0e:	83 e8 01             	sub    $0x1,%eax
80102f11:	39 c2                	cmp    %eax,%edx
80102f13:	0f 8d 87 00 00 00    	jge    80102fa0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f19:	a1 bc b6 14 80       	mov    0x8014b6bc,%eax
80102f1e:	85 c0                	test   %eax,%eax
80102f20:	0f 8e 87 00 00 00    	jle    80102fad <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f26:	83 ec 0c             	sub    $0xc,%esp
80102f29:	68 80 b6 14 80       	push   $0x8014b680
80102f2e:	e8 4d 16 00 00       	call   80104580 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f33:	8b 15 c8 b6 14 80    	mov    0x8014b6c8,%edx
80102f39:	83 c4 10             	add    $0x10,%esp
80102f3c:	83 fa 00             	cmp    $0x0,%edx
80102f3f:	7e 50                	jle    80102f91 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f41:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f44:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f46:	3b 0d cc b6 14 80    	cmp    0x8014b6cc,%ecx
80102f4c:	75 0b                	jne    80102f59 <log_write+0x69>
80102f4e:	eb 38                	jmp    80102f88 <log_write+0x98>
80102f50:	39 0c 85 cc b6 14 80 	cmp    %ecx,-0x7feb4934(,%eax,4)
80102f57:	74 2f                	je     80102f88 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102f59:	83 c0 01             	add    $0x1,%eax
80102f5c:	39 d0                	cmp    %edx,%eax
80102f5e:	75 f0                	jne    80102f50 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f60:	89 0c 95 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f67:	83 c2 01             	add    $0x1,%edx
80102f6a:	89 15 c8 b6 14 80    	mov    %edx,0x8014b6c8
  b->flags |= B_DIRTY; // prevent eviction
80102f70:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f73:	c7 45 08 80 b6 14 80 	movl   $0x8014b680,0x8(%ebp)
}
80102f7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f7d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102f7e:	e9 1d 17 00 00       	jmp    801046a0 <release>
80102f83:	90                   	nop
80102f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102f88:	89 0c 85 cc b6 14 80 	mov    %ecx,-0x7feb4934(,%eax,4)
80102f8f:	eb df                	jmp    80102f70 <log_write+0x80>
80102f91:	8b 43 08             	mov    0x8(%ebx),%eax
80102f94:	a3 cc b6 14 80       	mov    %eax,0x8014b6cc
  if (i == log.lh.n)
80102f99:	75 d5                	jne    80102f70 <log_write+0x80>
80102f9b:	eb ca                	jmp    80102f67 <log_write+0x77>
80102f9d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102fa0:	83 ec 0c             	sub    $0xc,%esp
80102fa3:	68 73 7a 10 80       	push   $0x80107a73
80102fa8:	e8 c3 d3 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102fad:	83 ec 0c             	sub    $0xc,%esp
80102fb0:	68 89 7a 10 80       	push   $0x80107a89
80102fb5:	e8 b6 d3 ff ff       	call   80100370 <panic>
80102fba:	66 90                	xchg   %ax,%ax
80102fbc:	66 90                	xchg   %ax,%ax
80102fbe:	66 90                	xchg   %ax,%ax

80102fc0 <mpmain>:
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	53                   	push   %ebx
80102fc4:	83 ec 04             	sub    $0x4,%esp
80102fc7:	e8 54 09 00 00       	call   80103920 <cpuid>
80102fcc:	89 c3                	mov    %eax,%ebx
80102fce:	e8 4d 09 00 00       	call   80103920 <cpuid>
80102fd3:	83 ec 04             	sub    $0x4,%esp
80102fd6:	53                   	push   %ebx
80102fd7:	50                   	push   %eax
80102fd8:	68 a4 7a 10 80       	push   $0x80107aa4
80102fdd:	e8 7e d6 ff ff       	call   80100660 <cprintf>
80102fe2:	e8 89 2a 00 00       	call   80105a70 <idtinit>
80102fe7:	e8 b4 08 00 00       	call   801038a0 <mycpu>
80102fec:	89 c2                	mov    %eax,%edx
80102fee:	b8 01 00 00 00       	mov    $0x1,%eax
80102ff3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
80102ffa:	e8 21 0d 00 00       	call   80103d20 <scheduler>
80102fff:	90                   	nop

80103000 <mpenter>:
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	83 ec 08             	sub    $0x8,%esp
80103006:	e8 a5 3b 00 00       	call   80106bb0 <switchkvm>
8010300b:	e8 a0 3a 00 00       	call   80106ab0 <seginit>
80103010:	e8 9b f7 ff ff       	call   801027b0 <lapicinit>
80103015:	e8 a6 ff ff ff       	call   80102fc0 <mpmain>
8010301a:	66 90                	xchg   %ax,%ax
8010301c:	66 90                	xchg   %ax,%ax
8010301e:	66 90                	xchg   %ax,%ax

80103020 <main>:
80103020:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103024:	83 e4 f0             	and    $0xfffffff0,%esp
80103027:	ff 71 fc             	pushl  -0x4(%ecx)
8010302a:	55                   	push   %ebp
8010302b:	89 e5                	mov    %esp,%ebp
8010302d:	53                   	push   %ebx
8010302e:	51                   	push   %ecx
8010302f:	bb 80 b7 14 80       	mov    $0x8014b780,%ebx
80103034:	83 ec 08             	sub    $0x8,%esp
80103037:	68 00 00 40 80       	push   $0x80400000
8010303c:	68 a8 e4 14 80       	push   $0x8014e4a8
80103041:	e8 ca f3 ff ff       	call   80102410 <kinit1>
80103046:	e8 05 40 00 00       	call   80107050 <kvmalloc>
8010304b:	e8 70 01 00 00       	call   801031c0 <mpinit>
80103050:	e8 5b f7 ff ff       	call   801027b0 <lapicinit>
80103055:	e8 56 3a 00 00       	call   80106ab0 <seginit>
8010305a:	e8 31 03 00 00       	call   80103390 <picinit>
8010305f:	e8 8c f1 ff ff       	call   801021f0 <ioapicinit>
80103064:	e8 37 d9 ff ff       	call   801009a0 <consoleinit>
80103069:	e8 12 2d 00 00       	call   80105d80 <uartinit>
8010306e:	e8 0d 08 00 00       	call   80103880 <pinit>
80103073:	e8 58 29 00 00       	call   801059d0 <tvinit>
80103078:	e8 c3 cf ff ff       	call   80100040 <binit>
8010307d:	e8 ce dc ff ff       	call   80100d50 <fileinit>
80103082:	e8 49 ef ff ff       	call   80101fd0 <ideinit>
80103087:	83 c4 0c             	add    $0xc,%esp
8010308a:	68 8a 00 00 00       	push   $0x8a
8010308f:	68 8c b4 10 80       	push   $0x8010b48c
80103094:	68 00 70 00 80       	push   $0x80007000
80103099:	e8 02 17 00 00       	call   801047a0 <memmove>
8010309e:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
801030a5:	00 00 00 
801030a8:	83 c4 10             	add    $0x10,%esp
801030ab:	05 80 b7 14 80       	add    $0x8014b780,%eax
801030b0:	39 d8                	cmp    %ebx,%eax
801030b2:	76 6f                	jbe    80103123 <main+0x103>
801030b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030b8:	e8 e3 07 00 00       	call   801038a0 <mycpu>
801030bd:	39 d8                	cmp    %ebx,%eax
801030bf:	74 49                	je     8010310a <main+0xea>
801030c1:	e8 3a f4 ff ff       	call   80102500 <kalloc>
801030c6:	05 00 10 00 00       	add    $0x1000,%eax
801030cb:	c7 05 f8 6f 00 80 00 	movl   $0x80103000,0x80006ff8
801030d2:	30 10 80 
801030d5:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801030dc:	a0 10 00 
801030df:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
801030e4:	0f b6 03             	movzbl (%ebx),%eax
801030e7:	83 ec 08             	sub    $0x8,%esp
801030ea:	68 00 70 00 00       	push   $0x7000
801030ef:	50                   	push   %eax
801030f0:	e8 0b f8 ff ff       	call   80102900 <lapicstartap>
801030f5:	83 c4 10             	add    $0x10,%esp
801030f8:	90                   	nop
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103106:	85 c0                	test   %eax,%eax
80103108:	74 f6                	je     80103100 <main+0xe0>
8010310a:	69 05 00 bd 14 80 b0 	imul   $0xb0,0x8014bd00,%eax
80103111:	00 00 00 
80103114:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010311a:	05 80 b7 14 80       	add    $0x8014b780,%eax
8010311f:	39 c3                	cmp    %eax,%ebx
80103121:	72 95                	jb     801030b8 <main+0x98>
80103123:	83 ec 08             	sub    $0x8,%esp
80103126:	68 00 00 00 8e       	push   $0x8e000000
8010312b:	68 00 00 40 80       	push   $0x80400000
80103130:	e8 5b f3 ff ff       	call   80102490 <kinit2>
80103135:	e8 36 08 00 00       	call   80103970 <userinit>
8010313a:	e8 81 fe ff ff       	call   80102fc0 <mpmain>
8010313f:	90                   	nop

80103140 <mpsearch1>:
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010314b:	53                   	push   %ebx
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010314f:	83 ec 0c             	sub    $0xc,%esp
80103152:	39 de                	cmp    %ebx,%esi
80103154:	73 48                	jae    8010319e <mpsearch1+0x5e>
80103156:	8d 76 00             	lea    0x0(%esi),%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103160:	83 ec 04             	sub    $0x4,%esp
80103163:	8d 7e 10             	lea    0x10(%esi),%edi
80103166:	6a 04                	push   $0x4
80103168:	68 b8 7a 10 80       	push   $0x80107ab8
8010316d:	56                   	push   %esi
8010316e:	e8 cd 15 00 00       	call   80104740 <memcmp>
80103173:	83 c4 10             	add    $0x10,%esp
80103176:	85 c0                	test   %eax,%eax
80103178:	75 1e                	jne    80103198 <mpsearch1+0x58>
8010317a:	8d 7e 10             	lea    0x10(%esi),%edi
8010317d:	89 f2                	mov    %esi,%edx
8010317f:	31 c9                	xor    %ecx,%ecx
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103188:	0f b6 02             	movzbl (%edx),%eax
8010318b:	83 c2 01             	add    $0x1,%edx
8010318e:	01 c1                	add    %eax,%ecx
80103190:	39 fa                	cmp    %edi,%edx
80103192:	75 f4                	jne    80103188 <mpsearch1+0x48>
80103194:	84 c9                	test   %cl,%cl
80103196:	74 10                	je     801031a8 <mpsearch1+0x68>
80103198:	39 fb                	cmp    %edi,%ebx
8010319a:	89 fe                	mov    %edi,%esi
8010319c:	77 c2                	ja     80103160 <mpsearch1+0x20>
8010319e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a1:	31 c0                	xor    %eax,%eax
801031a3:	5b                   	pop    %ebx
801031a4:	5e                   	pop    %esi
801031a5:	5f                   	pop    %edi
801031a6:	5d                   	pop    %ebp
801031a7:	c3                   	ret    
801031a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031ab:	89 f0                	mov    %esi,%eax
801031ad:	5b                   	pop    %ebx
801031ae:	5e                   	pop    %esi
801031af:	5f                   	pop    %edi
801031b0:	5d                   	pop    %ebp
801031b1:	c3                   	ret    
801031b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031c0 <mpinit>:
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 1c             	sub    $0x1c,%esp
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	85 c0                	test   %eax,%eax
801031e1:	75 1b                	jne    801031fe <mpinit+0x3e>
801031e3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031ea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031f1:	c1 e0 08             	shl    $0x8,%eax
801031f4:	09 d0                	or     %edx,%eax
801031f6:	c1 e0 0a             	shl    $0xa,%eax
801031f9:	2d 00 04 00 00       	sub    $0x400,%eax
801031fe:	ba 00 04 00 00       	mov    $0x400,%edx
80103203:	e8 38 ff ff ff       	call   80103140 <mpsearch1>
80103208:	85 c0                	test   %eax,%eax
8010320a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010320d:	0f 84 37 01 00 00    	je     8010334a <mpinit+0x18a>
80103213:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103216:	8b 58 04             	mov    0x4(%eax),%ebx
80103219:	85 db                	test   %ebx,%ebx
8010321b:	0f 84 43 01 00 00    	je     80103364 <mpinit+0x1a4>
80103221:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
80103227:	83 ec 04             	sub    $0x4,%esp
8010322a:	6a 04                	push   $0x4
8010322c:	68 bd 7a 10 80       	push   $0x80107abd
80103231:	56                   	push   %esi
80103232:	e8 09 15 00 00       	call   80104740 <memcmp>
80103237:	83 c4 10             	add    $0x10,%esp
8010323a:	85 c0                	test   %eax,%eax
8010323c:	0f 85 22 01 00 00    	jne    80103364 <mpinit+0x1a4>
80103242:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103249:	3c 01                	cmp    $0x1,%al
8010324b:	74 08                	je     80103255 <mpinit+0x95>
8010324d:	3c 04                	cmp    $0x4,%al
8010324f:	0f 85 0f 01 00 00    	jne    80103364 <mpinit+0x1a4>
80103255:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
8010325c:	85 ff                	test   %edi,%edi
8010325e:	74 21                	je     80103281 <mpinit+0xc1>
80103260:	31 d2                	xor    %edx,%edx
80103262:	31 c0                	xor    %eax,%eax
80103264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103268:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010326f:	80 
80103270:	83 c0 01             	add    $0x1,%eax
80103273:	01 ca                	add    %ecx,%edx
80103275:	39 c7                	cmp    %eax,%edi
80103277:	75 ef                	jne    80103268 <mpinit+0xa8>
80103279:	84 d2                	test   %dl,%dl
8010327b:	0f 85 e3 00 00 00    	jne    80103364 <mpinit+0x1a4>
80103281:	85 f6                	test   %esi,%esi
80103283:	0f 84 db 00 00 00    	je     80103364 <mpinit+0x1a4>
80103289:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010328f:	a3 7c b6 14 80       	mov    %eax,0x8014b67c
80103294:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010329b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801032a1:	bb 01 00 00 00       	mov    $0x1,%ebx
801032a6:	01 d6                	add    %edx,%esi
801032a8:	90                   	nop
801032a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b0:	39 c6                	cmp    %eax,%esi
801032b2:	76 23                	jbe    801032d7 <mpinit+0x117>
801032b4:	0f b6 10             	movzbl (%eax),%edx
801032b7:	80 fa 04             	cmp    $0x4,%dl
801032ba:	0f 87 c0 00 00 00    	ja     80103380 <mpinit+0x1c0>
801032c0:	ff 24 95 fc 7a 10 80 	jmp    *-0x7fef8504(,%edx,4)
801032c7:	89 f6                	mov    %esi,%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801032d0:	83 c0 08             	add    $0x8,%eax
801032d3:	39 c6                	cmp    %eax,%esi
801032d5:	77 dd                	ja     801032b4 <mpinit+0xf4>
801032d7:	85 db                	test   %ebx,%ebx
801032d9:	0f 84 92 00 00 00    	je     80103371 <mpinit+0x1b1>
801032df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032e2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032e6:	74 15                	je     801032fd <mpinit+0x13d>
801032e8:	ba 22 00 00 00       	mov    $0x22,%edx
801032ed:	b8 70 00 00 00       	mov    $0x70,%eax
801032f2:	ee                   	out    %al,(%dx)
801032f3:	ba 23 00 00 00       	mov    $0x23,%edx
801032f8:	ec                   	in     (%dx),%al
801032f9:	83 c8 01             	or     $0x1,%eax
801032fc:	ee                   	out    %al,(%dx)
801032fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103300:	5b                   	pop    %ebx
80103301:	5e                   	pop    %esi
80103302:	5f                   	pop    %edi
80103303:	5d                   	pop    %ebp
80103304:	c3                   	ret    
80103305:	8d 76 00             	lea    0x0(%esi),%esi
80103308:	8b 0d 00 bd 14 80    	mov    0x8014bd00,%ecx
8010330e:	83 f9 07             	cmp    $0x7,%ecx
80103311:	7f 19                	jg     8010332c <mpinit+0x16c>
80103313:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103317:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
8010331d:	83 c1 01             	add    $0x1,%ecx
80103320:	89 0d 00 bd 14 80    	mov    %ecx,0x8014bd00
80103326:	88 97 80 b7 14 80    	mov    %dl,-0x7feb4880(%edi)
8010332c:	83 c0 14             	add    $0x14,%eax
8010332f:	e9 7c ff ff ff       	jmp    801032b0 <mpinit+0xf0>
80103334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103338:	0f b6 50 01          	movzbl 0x1(%eax),%edx
8010333c:	83 c0 08             	add    $0x8,%eax
8010333f:	88 15 60 b7 14 80    	mov    %dl,0x8014b760
80103345:	e9 66 ff ff ff       	jmp    801032b0 <mpinit+0xf0>
8010334a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010334f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103354:	e8 e7 fd ff ff       	call   80103140 <mpsearch1>
80103359:	85 c0                	test   %eax,%eax
8010335b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010335e:	0f 85 af fe ff ff    	jne    80103213 <mpinit+0x53>
80103364:	83 ec 0c             	sub    $0xc,%esp
80103367:	68 c2 7a 10 80       	push   $0x80107ac2
8010336c:	e8 ff cf ff ff       	call   80100370 <panic>
80103371:	83 ec 0c             	sub    $0xc,%esp
80103374:	68 dc 7a 10 80       	push   $0x80107adc
80103379:	e8 f2 cf ff ff       	call   80100370 <panic>
8010337e:	66 90                	xchg   %ax,%ax
80103380:	31 db                	xor    %ebx,%ebx
80103382:	e9 30 ff ff ff       	jmp    801032b7 <mpinit+0xf7>
80103387:	66 90                	xchg   %ax,%ax
80103389:	66 90                	xchg   %ax,%ax
8010338b:	66 90                	xchg   %ax,%ax
8010338d:	66 90                	xchg   %ax,%ax
8010338f:	90                   	nop

80103390 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103390:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103391:	ba 21 00 00 00       	mov    $0x21,%edx
80103396:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010339b:	89 e5                	mov    %esp,%ebp
8010339d:	ee                   	out    %al,(%dx)
8010339e:	ba a1 00 00 00       	mov    $0xa1,%edx
801033a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033a4:	5d                   	pop    %ebp
801033a5:	c3                   	ret    
801033a6:	66 90                	xchg   %ax,%ax
801033a8:	66 90                	xchg   %ax,%ax
801033aa:	66 90                	xchg   %ax,%ax
801033ac:	66 90                	xchg   %ax,%ax
801033ae:	66 90                	xchg   %ax,%ax

801033b0 <pipealloc>:
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	8b 75 08             	mov    0x8(%ebp),%esi
801033bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801033bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033c5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033cb:	e8 a0 d9 ff ff       	call   80100d70 <filealloc>
801033d0:	85 c0                	test   %eax,%eax
801033d2:	89 06                	mov    %eax,(%esi)
801033d4:	0f 84 a8 00 00 00    	je     80103482 <pipealloc+0xd2>
801033da:	e8 91 d9 ff ff       	call   80100d70 <filealloc>
801033df:	85 c0                	test   %eax,%eax
801033e1:	89 03                	mov    %eax,(%ebx)
801033e3:	0f 84 87 00 00 00    	je     80103470 <pipealloc+0xc0>
801033e9:	e8 12 f1 ff ff       	call   80102500 <kalloc>
801033ee:	85 c0                	test   %eax,%eax
801033f0:	89 c7                	mov    %eax,%edi
801033f2:	0f 84 b0 00 00 00    	je     801034a8 <pipealloc+0xf8>
801033f8:	83 ec 08             	sub    $0x8,%esp
801033fb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103402:	00 00 00 
80103405:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010340c:	00 00 00 
8010340f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103416:	00 00 00 
80103419:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103420:	00 00 00 
80103423:	68 10 7b 10 80       	push   $0x80107b10
80103428:	50                   	push   %eax
80103429:	e8 52 10 00 00       	call   80104480 <initlock>
8010342e:	8b 06                	mov    (%esi),%eax
80103430:	83 c4 10             	add    $0x10,%esp
80103433:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103439:	8b 06                	mov    (%esi),%eax
8010343b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
8010343f:	8b 06                	mov    (%esi),%eax
80103441:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103445:	8b 06                	mov    (%esi),%eax
80103447:	89 78 0c             	mov    %edi,0xc(%eax)
8010344a:	8b 03                	mov    (%ebx),%eax
8010344c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103452:	8b 03                	mov    (%ebx),%eax
80103454:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103458:	8b 03                	mov    (%ebx),%eax
8010345a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
8010345e:	8b 03                	mov    (%ebx),%eax
80103460:	89 78 0c             	mov    %edi,0xc(%eax)
80103463:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103466:	31 c0                	xor    %eax,%eax
80103468:	5b                   	pop    %ebx
80103469:	5e                   	pop    %esi
8010346a:	5f                   	pop    %edi
8010346b:	5d                   	pop    %ebp
8010346c:	c3                   	ret    
8010346d:	8d 76 00             	lea    0x0(%esi),%esi
80103470:	8b 06                	mov    (%esi),%eax
80103472:	85 c0                	test   %eax,%eax
80103474:	74 1e                	je     80103494 <pipealloc+0xe4>
80103476:	83 ec 0c             	sub    $0xc,%esp
80103479:	50                   	push   %eax
8010347a:	e8 b1 d9 ff ff       	call   80100e30 <fileclose>
8010347f:	83 c4 10             	add    $0x10,%esp
80103482:	8b 03                	mov    (%ebx),%eax
80103484:	85 c0                	test   %eax,%eax
80103486:	74 0c                	je     80103494 <pipealloc+0xe4>
80103488:	83 ec 0c             	sub    $0xc,%esp
8010348b:	50                   	push   %eax
8010348c:	e8 9f d9 ff ff       	call   80100e30 <fileclose>
80103491:	83 c4 10             	add    $0x10,%esp
80103494:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103497:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010349c:	5b                   	pop    %ebx
8010349d:	5e                   	pop    %esi
8010349e:	5f                   	pop    %edi
8010349f:	5d                   	pop    %ebp
801034a0:	c3                   	ret    
801034a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034a8:	8b 06                	mov    (%esi),%eax
801034aa:	85 c0                	test   %eax,%eax
801034ac:	75 c8                	jne    80103476 <pipealloc+0xc6>
801034ae:	eb d2                	jmp    80103482 <pipealloc+0xd2>

801034b0 <pipeclose>:
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	56                   	push   %esi
801034b4:	53                   	push   %ebx
801034b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034b8:	8b 75 0c             	mov    0xc(%ebp),%esi
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	53                   	push   %ebx
801034bf:	e8 bc 10 00 00       	call   80104580 <acquire>
801034c4:	83 c4 10             	add    $0x10,%esp
801034c7:	85 f6                	test   %esi,%esi
801034c9:	74 45                	je     80103510 <pipeclose+0x60>
801034cb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034d1:	83 ec 0c             	sub    $0xc,%esp
801034d4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034db:	00 00 00 
801034de:	50                   	push   %eax
801034df:	e8 dc 0c 00 00       	call   801041c0 <wakeup>
801034e4:	83 c4 10             	add    $0x10,%esp
801034e7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034ed:	85 d2                	test   %edx,%edx
801034ef:	75 0a                	jne    801034fb <pipeclose+0x4b>
801034f1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034f7:	85 c0                	test   %eax,%eax
801034f9:	74 35                	je     80103530 <pipeclose+0x80>
801034fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103501:	5b                   	pop    %ebx
80103502:	5e                   	pop    %esi
80103503:	5d                   	pop    %ebp
80103504:	e9 97 11 00 00       	jmp    801046a0 <release>
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103510:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103516:	83 ec 0c             	sub    $0xc,%esp
80103519:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103520:	00 00 00 
80103523:	50                   	push   %eax
80103524:	e8 97 0c 00 00       	call   801041c0 <wakeup>
80103529:	83 c4 10             	add    $0x10,%esp
8010352c:	eb b9                	jmp    801034e7 <pipeclose+0x37>
8010352e:	66 90                	xchg   %ax,%ax
80103530:	83 ec 0c             	sub    $0xc,%esp
80103533:	53                   	push   %ebx
80103534:	e8 67 11 00 00       	call   801046a0 <release>
80103539:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010353c:	83 c4 10             	add    $0x10,%esp
8010353f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103542:	5b                   	pop    %ebx
80103543:	5e                   	pop    %esi
80103544:	5d                   	pop    %ebp
80103545:	e9 96 ed ff ff       	jmp    801022e0 <kfree>
8010354a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103550 <pipewrite>:
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
80103555:	53                   	push   %ebx
80103556:	83 ec 28             	sub    $0x28,%esp
80103559:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010355c:	53                   	push   %ebx
8010355d:	e8 1e 10 00 00       	call   80104580 <acquire>
80103562:	8b 45 10             	mov    0x10(%ebp),%eax
80103565:	83 c4 10             	add    $0x10,%esp
80103568:	85 c0                	test   %eax,%eax
8010356a:	0f 8e b9 00 00 00    	jle    80103629 <pipewrite+0xd9>
80103570:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103573:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103579:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010357f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103585:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103588:	03 4d 10             	add    0x10(%ebp),%ecx
8010358b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010358e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103594:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010359a:	39 d0                	cmp    %edx,%eax
8010359c:	74 38                	je     801035d6 <pipewrite+0x86>
8010359e:	eb 59                	jmp    801035f9 <pipewrite+0xa9>
801035a0:	e8 9b 03 00 00       	call   80103940 <myproc>
801035a5:	8b 48 24             	mov    0x24(%eax),%ecx
801035a8:	85 c9                	test   %ecx,%ecx
801035aa:	75 34                	jne    801035e0 <pipewrite+0x90>
801035ac:	83 ec 0c             	sub    $0xc,%esp
801035af:	57                   	push   %edi
801035b0:	e8 0b 0c 00 00       	call   801041c0 <wakeup>
801035b5:	58                   	pop    %eax
801035b6:	5a                   	pop    %edx
801035b7:	53                   	push   %ebx
801035b8:	56                   	push   %esi
801035b9:	e8 52 0a 00 00       	call   80104010 <sleep>
801035be:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035c4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035ca:	83 c4 10             	add    $0x10,%esp
801035cd:	05 00 02 00 00       	add    $0x200,%eax
801035d2:	39 c2                	cmp    %eax,%edx
801035d4:	75 2a                	jne    80103600 <pipewrite+0xb0>
801035d6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035dc:	85 c0                	test   %eax,%eax
801035de:	75 c0                	jne    801035a0 <pipewrite+0x50>
801035e0:	83 ec 0c             	sub    $0xc,%esp
801035e3:	53                   	push   %ebx
801035e4:	e8 b7 10 00 00       	call   801046a0 <release>
801035e9:	83 c4 10             	add    $0x10,%esp
801035ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035f4:	5b                   	pop    %ebx
801035f5:	5e                   	pop    %esi
801035f6:	5f                   	pop    %edi
801035f7:	5d                   	pop    %ebp
801035f8:	c3                   	ret    
801035f9:	89 c2                	mov    %eax,%edx
801035fb:	90                   	nop
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103600:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103603:	8d 42 01             	lea    0x1(%edx),%eax
80103606:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010360a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103610:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103616:	0f b6 09             	movzbl (%ecx),%ecx
80103619:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010361d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103620:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103623:	0f 85 65 ff ff ff    	jne    8010358e <pipewrite+0x3e>
80103629:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010362f:	83 ec 0c             	sub    $0xc,%esp
80103632:	50                   	push   %eax
80103633:	e8 88 0b 00 00       	call   801041c0 <wakeup>
80103638:	89 1c 24             	mov    %ebx,(%esp)
8010363b:	e8 60 10 00 00       	call   801046a0 <release>
80103640:	83 c4 10             	add    $0x10,%esp
80103643:	8b 45 10             	mov    0x10(%ebp),%eax
80103646:	eb a9                	jmp    801035f1 <pipewrite+0xa1>
80103648:	90                   	nop
80103649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103650 <piperead>:
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 18             	sub    $0x18,%esp
80103659:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010365c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010365f:	53                   	push   %ebx
80103660:	e8 1b 0f 00 00       	call   80104580 <acquire>
80103665:	83 c4 10             	add    $0x10,%esp
80103668:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010366e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103674:	75 6a                	jne    801036e0 <piperead+0x90>
80103676:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010367c:	85 f6                	test   %esi,%esi
8010367e:	0f 84 cc 00 00 00    	je     80103750 <piperead+0x100>
80103684:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010368a:	eb 2d                	jmp    801036b9 <piperead+0x69>
8010368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103690:	83 ec 08             	sub    $0x8,%esp
80103693:	53                   	push   %ebx
80103694:	56                   	push   %esi
80103695:	e8 76 09 00 00       	call   80104010 <sleep>
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036a3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036a9:	75 35                	jne    801036e0 <piperead+0x90>
801036ab:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801036b1:	85 d2                	test   %edx,%edx
801036b3:	0f 84 97 00 00 00    	je     80103750 <piperead+0x100>
801036b9:	e8 82 02 00 00       	call   80103940 <myproc>
801036be:	8b 48 24             	mov    0x24(%eax),%ecx
801036c1:	85 c9                	test   %ecx,%ecx
801036c3:	74 cb                	je     80103690 <piperead+0x40>
801036c5:	83 ec 0c             	sub    $0xc,%esp
801036c8:	53                   	push   %ebx
801036c9:	e8 d2 0f 00 00       	call   801046a0 <release>
801036ce:	83 c4 10             	add    $0x10,%esp
801036d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036d9:	5b                   	pop    %ebx
801036da:	5e                   	pop    %esi
801036db:	5f                   	pop    %edi
801036dc:	5d                   	pop    %ebp
801036dd:	c3                   	ret    
801036de:	66 90                	xchg   %ax,%ax
801036e0:	8b 45 10             	mov    0x10(%ebp),%eax
801036e3:	85 c0                	test   %eax,%eax
801036e5:	7e 69                	jle    80103750 <piperead+0x100>
801036e7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036ed:	31 c9                	xor    %ecx,%ecx
801036ef:	eb 15                	jmp    80103706 <piperead+0xb6>
801036f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036fe:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103704:	74 5a                	je     80103760 <piperead+0x110>
80103706:	8d 70 01             	lea    0x1(%eax),%esi
80103709:	25 ff 01 00 00       	and    $0x1ff,%eax
8010370e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103714:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103719:	88 04 0f             	mov    %al,(%edi,%ecx,1)
8010371c:	83 c1 01             	add    $0x1,%ecx
8010371f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103722:	75 d4                	jne    801036f8 <piperead+0xa8>
80103724:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010372a:	83 ec 0c             	sub    $0xc,%esp
8010372d:	50                   	push   %eax
8010372e:	e8 8d 0a 00 00       	call   801041c0 <wakeup>
80103733:	89 1c 24             	mov    %ebx,(%esp)
80103736:	e8 65 0f 00 00       	call   801046a0 <release>
8010373b:	8b 45 10             	mov    0x10(%ebp),%eax
8010373e:	83 c4 10             	add    $0x10,%esp
80103741:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103744:	5b                   	pop    %ebx
80103745:	5e                   	pop    %esi
80103746:	5f                   	pop    %edi
80103747:	5d                   	pop    %ebp
80103748:	c3                   	ret    
80103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103750:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103757:	eb cb                	jmp    80103724 <piperead+0xd4>
80103759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103760:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103763:	eb bf                	jmp    80103724 <piperead+0xd4>
80103765:	66 90                	xchg   %ax,%ax
80103767:	66 90                	xchg   %ax,%ax
80103769:	66 90                	xchg   %ax,%ax
8010376b:	66 90                	xchg   %ax,%ax
8010376d:	66 90                	xchg   %ax,%ax
8010376f:	90                   	nop

80103770 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103774:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103779:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010377c:	68 20 bd 14 80       	push   $0x8014bd20
80103781:	e8 fa 0d 00 00       	call   80104580 <acquire>
80103786:	83 c4 10             	add    $0x10,%esp
80103789:	eb 10                	jmp    8010379b <allocproc+0x2b>
8010378b:	90                   	nop
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	83 c3 7c             	add    $0x7c,%ebx
80103793:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80103799:	74 75                	je     80103810 <allocproc+0xa0>
    if(p->state == UNUSED)
8010379b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010379e:	85 c0                	test   %eax,%eax
801037a0:	75 ee                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801037a7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801037aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801037b1:	68 20 bd 14 80       	push   $0x8014bd20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037b6:	8d 50 01             	lea    0x1(%eax),%edx
801037b9:	89 43 10             	mov    %eax,0x10(%ebx)
801037bc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
801037c2:	e8 d9 0e 00 00       	call   801046a0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037c7:	e8 34 ed ff ff       	call   80102500 <kalloc>
801037cc:	83 c4 10             	add    $0x10,%esp
801037cf:	85 c0                	test   %eax,%eax
801037d1:	89 43 08             	mov    %eax,0x8(%ebx)
801037d4:	74 51                	je     80103827 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037dc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801037df:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037e4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801037e7:	c7 40 14 c1 59 10 80 	movl   $0x801059c1,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037ee:	6a 14                	push   $0x14
801037f0:	6a 00                	push   $0x0
801037f2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801037f3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f6:	e8 f5 0e 00 00       	call   801046f0 <memset>
  p->context->eip = (uint)forkret;
801037fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037fe:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103801:	c7 40 10 30 38 10 80 	movl   $0x80103830,0x10(%eax)

  return p;
80103808:	89 d8                	mov    %ebx,%eax
}
8010380a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010380d:	c9                   	leave  
8010380e:	c3                   	ret    
8010380f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103810:	83 ec 0c             	sub    $0xc,%esp
80103813:	68 20 bd 14 80       	push   $0x8014bd20
80103818:	e8 83 0e 00 00       	call   801046a0 <release>
  return 0;
8010381d:	83 c4 10             	add    $0x10,%esp
80103820:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103825:	c9                   	leave  
80103826:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103827:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010382e:	eb da                	jmp    8010380a <allocproc+0x9a>

80103830 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103836:	68 20 bd 14 80       	push   $0x8014bd20
8010383b:	e8 60 0e 00 00       	call   801046a0 <release>

  if (first) {
80103840:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	85 c0                	test   %eax,%eax
8010384a:	75 04                	jne    80103850 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010384c:	c9                   	leave  
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103850:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103853:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010385a:	00 00 00 
    iinit(ROOTDEV);
8010385d:	6a 01                	push   $0x1
8010385f:	e8 0c dc ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
80103864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010386b:	e8 00 f4 ff ff       	call   80102c70 <initlog>
80103870:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103873:	c9                   	leave  
80103874:	c3                   	ret    
80103875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103886:	68 15 7b 10 80       	push   $0x80107b15
8010388b:	68 20 bd 14 80       	push   $0x8014bd20
80103890:	e8 eb 0b 00 00       	call   80104480 <initlock>
}
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	c9                   	leave  
80103899:	c3                   	ret    
8010389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038a0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	56                   	push   %esi
801038a4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038a5:	9c                   	pushf  
801038a6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801038a7:	f6 c4 02             	test   $0x2,%ah
801038aa:	75 5b                	jne    80103907 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801038ac:	e8 ff ef ff ff       	call   801028b0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038b1:	8b 35 00 bd 14 80    	mov    0x8014bd00,%esi
801038b7:	85 f6                	test   %esi,%esi
801038b9:	7e 3f                	jle    801038fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038bb:	0f b6 15 80 b7 14 80 	movzbl 0x8014b780,%edx
801038c2:	39 d0                	cmp    %edx,%eax
801038c4:	74 30                	je     801038f6 <mycpu+0x56>
801038c6:	b9 30 b8 14 80       	mov    $0x8014b830,%ecx
801038cb:	31 d2                	xor    %edx,%edx
801038cd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038d0:	83 c2 01             	add    $0x1,%edx
801038d3:	39 f2                	cmp    %esi,%edx
801038d5:	74 23                	je     801038fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801038d7:	0f b6 19             	movzbl (%ecx),%ebx
801038da:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801038e0:	39 d8                	cmp    %ebx,%eax
801038e2:	75 ec                	jne    801038d0 <mycpu+0x30>
      return &cpus[i];
801038e4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
801038ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038ed:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801038ee:	05 80 b7 14 80       	add    $0x8014b780,%eax
  }
  panic("unknown apicid\n");
}
801038f3:	5e                   	pop    %esi
801038f4:	5d                   	pop    %ebp
801038f5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801038f6:	31 d2                	xor    %edx,%edx
801038f8:	eb ea                	jmp    801038e4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
801038fa:	83 ec 0c             	sub    $0xc,%esp
801038fd:	68 1c 7b 10 80       	push   $0x80107b1c
80103902:	e8 69 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103907:	83 ec 0c             	sub    $0xc,%esp
8010390a:	68 f8 7b 10 80       	push   $0x80107bf8
8010390f:	e8 5c ca ff ff       	call   80100370 <panic>
80103914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010391a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103920 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103926:	e8 75 ff ff ff       	call   801038a0 <mycpu>
8010392b:	2d 80 b7 14 80       	sub    $0x8014b780,%eax
}
80103930:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80103931:	c1 f8 04             	sar    $0x4,%eax
80103934:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010393a:	c3                   	ret    
8010393b:	90                   	nop
8010393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103940 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	53                   	push   %ebx
80103944:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103947:	e8 f4 0b 00 00       	call   80104540 <pushcli>
  c = mycpu();
8010394c:	e8 4f ff ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103951:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103957:	e8 d4 0c 00 00       	call   80104630 <popcli>
  return p;
}
8010395c:	83 c4 04             	add    $0x4,%esp
8010395f:	89 d8                	mov    %ebx,%eax
80103961:	5b                   	pop    %ebx
80103962:	5d                   	pop    %ebp
80103963:	c3                   	ret    
80103964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010396a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103970 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	53                   	push   %ebx
80103974:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103977:	e8 f4 fd ff ff       	call   80103770 <allocproc>
8010397c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010397e:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103983:	e8 48 36 00 00       	call   80106fd0 <setupkvm>
80103988:	85 c0                	test   %eax,%eax
8010398a:	89 43 04             	mov    %eax,0x4(%ebx)
8010398d:	0f 84 bd 00 00 00    	je     80103a50 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103993:	83 ec 04             	sub    $0x4,%esp
80103996:	68 2c 00 00 00       	push   $0x2c
8010399b:	68 60 b4 10 80       	push   $0x8010b460
801039a0:	50                   	push   %eax
801039a1:	e8 3a 33 00 00       	call   80106ce0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801039a6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801039a9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039af:	6a 4c                	push   $0x4c
801039b1:	6a 00                	push   $0x0
801039b3:	ff 73 18             	pushl  0x18(%ebx)
801039b6:	e8 35 0d 00 00       	call   801046f0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039bb:	8b 43 18             	mov    0x18(%ebx),%eax
801039be:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039c3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039c8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039cb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039cf:	8b 43 18             	mov    0x18(%ebx),%eax
801039d2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039d6:	8b 43 18             	mov    0x18(%ebx),%eax
801039d9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039dd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039e1:	8b 43 18             	mov    0x18(%ebx),%eax
801039e4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039e8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039ec:	8b 43 18             	mov    0x18(%ebx),%eax
801039ef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801039f6:	8b 43 18             	mov    0x18(%ebx),%eax
801039f9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a00:	8b 43 18             	mov    0x18(%ebx),%eax
80103a03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a0d:	6a 10                	push   $0x10
80103a0f:	68 45 7b 10 80       	push   $0x80107b45
80103a14:	50                   	push   %eax
80103a15:	e8 d6 0e 00 00       	call   801048f0 <safestrcpy>
  p->cwd = namei("/");
80103a1a:	c7 04 24 4e 7b 10 80 	movl   $0x80107b4e,(%esp)
80103a21:	e8 9a e4 ff ff       	call   80101ec0 <namei>
80103a26:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103a29:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103a30:	e8 4b 0b 00 00       	call   80104580 <acquire>

  p->state = RUNNABLE;
80103a35:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a3c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103a43:	e8 58 0c 00 00       	call   801046a0 <release>
}
80103a48:	83 c4 10             	add    $0x10,%esp
80103a4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a4e:	c9                   	leave  
80103a4f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103a50:	83 ec 0c             	sub    $0xc,%esp
80103a53:	68 2c 7b 10 80       	push   $0x80107b2c
80103a58:	e8 13 c9 ff ff       	call   80100370 <panic>
80103a5d:	8d 76 00             	lea    0x0(%esi),%esi

80103a60 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	56                   	push   %esi
80103a64:	53                   	push   %ebx
80103a65:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a68:	e8 d3 0a 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103a6d:	e8 2e fe ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103a72:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a78:	e8 b3 0b 00 00       	call   80104630 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103a7d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103a80:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a82:	7e 34                	jle    80103ab8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a84:	83 ec 04             	sub    $0x4,%esp
80103a87:	01 c6                	add    %eax,%esi
80103a89:	56                   	push   %esi
80103a8a:	50                   	push   %eax
80103a8b:	ff 73 04             	pushl  0x4(%ebx)
80103a8e:	e8 8d 33 00 00       	call   80106e20 <allocuvm>
80103a93:	83 c4 10             	add    $0x10,%esp
80103a96:	85 c0                	test   %eax,%eax
80103a98:	74 36                	je     80103ad0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103a9a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103a9d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a9f:	53                   	push   %ebx
80103aa0:	e8 2b 31 00 00       	call   80106bd0 <switchuvm>
  return 0;
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	31 c0                	xor    %eax,%eax
}
80103aaa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aad:	5b                   	pop    %ebx
80103aae:	5e                   	pop    %esi
80103aaf:	5d                   	pop    %ebp
80103ab0:	c3                   	ret    
80103ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103ab8:	74 e0                	je     80103a9a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103aba:	83 ec 04             	sub    $0x4,%esp
80103abd:	01 c6                	add    %eax,%esi
80103abf:	56                   	push   %esi
80103ac0:	50                   	push   %eax
80103ac1:	ff 73 04             	pushl  0x4(%ebx)
80103ac4:	e8 57 34 00 00       	call   80106f20 <deallocuvm>
80103ac9:	83 c4 10             	add    $0x10,%esp
80103acc:	85 c0                	test   %eax,%eax
80103ace:	75 ca                	jne    80103a9a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ad5:	eb d3                	jmp    80103aaa <growproc+0x4a>
80103ad7:	89 f6                	mov    %esi,%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ae0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	57                   	push   %edi
80103ae4:	56                   	push   %esi
80103ae5:	53                   	push   %ebx
80103ae6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ae9:	e8 52 0a 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103aee:	e8 ad fd ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103af3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af9:	e8 32 0b 00 00       	call   80104630 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103afe:	e8 6d fc ff ff       	call   80103770 <allocproc>
80103b03:	85 c0                	test   %eax,%eax
80103b05:	89 c7                	mov    %eax,%edi
80103b07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b0a:	0f 84 b5 00 00 00    	je     80103bc5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b10:	83 ec 08             	sub    $0x8,%esp
80103b13:	ff 33                	pushl  (%ebx)
80103b15:	ff 73 04             	pushl  0x4(%ebx)
80103b18:	e8 83 35 00 00       	call   801070a0 <copyuvm>
80103b1d:	83 c4 10             	add    $0x10,%esp
80103b20:	85 c0                	test   %eax,%eax
80103b22:	89 47 04             	mov    %eax,0x4(%edi)
80103b25:	0f 84 a1 00 00 00    	je     80103bcc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103b2b:	8b 03                	mov    (%ebx),%eax
80103b2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b30:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b32:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b35:	89 c8                	mov    %ecx,%eax
80103b37:	8b 79 18             	mov    0x18(%ecx),%edi
80103b3a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b3d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b42:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b44:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103b46:	8b 40 18             	mov    0x18(%eax),%eax
80103b49:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b50:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b54:	85 c0                	test   %eax,%eax
80103b56:	74 13                	je     80103b6b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b58:	83 ec 0c             	sub    $0xc,%esp
80103b5b:	50                   	push   %eax
80103b5c:	e8 7f d2 ff ff       	call   80100de0 <filedup>
80103b61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b64:	83 c4 10             	add    $0x10,%esp
80103b67:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b6b:	83 c6 01             	add    $0x1,%esi
80103b6e:	83 fe 10             	cmp    $0x10,%esi
80103b71:	75 dd                	jne    80103b50 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b73:	83 ec 0c             	sub    $0xc,%esp
80103b76:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b79:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b7c:	e8 bf da ff ff       	call   80101640 <idup>
80103b81:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b84:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b87:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b8a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b8d:	6a 10                	push   $0x10
80103b8f:	53                   	push   %ebx
80103b90:	50                   	push   %eax
80103b91:	e8 5a 0d 00 00       	call   801048f0 <safestrcpy>

  pid = np->pid;
80103b96:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103b99:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103ba0:	e8 db 09 00 00       	call   80104580 <acquire>

  np->state = RUNNABLE;
80103ba5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103bac:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103bb3:	e8 e8 0a 00 00       	call   801046a0 <release>

  return pid;
80103bb8:	83 c4 10             	add    $0x10,%esp
80103bbb:	89 d8                	mov    %ebx,%eax
}
80103bbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bc0:	5b                   	pop    %ebx
80103bc1:	5e                   	pop    %esi
80103bc2:	5f                   	pop    %edi
80103bc3:	5d                   	pop    %ebp
80103bc4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103bc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bca:	eb f1                	jmp    80103bbd <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103bcc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bcf:	83 ec 0c             	sub    $0xc,%esp
80103bd2:	ff 77 08             	pushl  0x8(%edi)
80103bd5:	e8 06 e7 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103bda:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103be1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103be8:	83 c4 10             	add    $0x10,%esp
80103beb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bf0:	eb cb                	jmp    80103bbd <fork+0xdd>
80103bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <forkcow>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
forkcow(void)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c09:	e8 32 09 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103c0e:	e8 8d fc ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103c13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c19:	e8 12 0a 00 00       	call   80104630 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103c1e:	e8 4d fb ff ff       	call   80103770 <allocproc>
80103c23:	85 c0                	test   %eax,%eax
80103c25:	89 c7                	mov    %eax,%edi
80103c27:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c2a:	0f 84 b5 00 00 00    	je     80103ce5 <forkcow+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
80103c30:	83 ec 08             	sub    $0x8,%esp
80103c33:	ff 33                	pushl  (%ebx)
80103c35:	ff 73 04             	pushl  0x4(%ebx)
80103c38:	e8 53 35 00 00       	call   80107190 <copyuvmcow>
80103c3d:	83 c4 10             	add    $0x10,%esp
80103c40:	85 c0                	test   %eax,%eax
80103c42:	89 47 04             	mov    %eax,0x4(%edi)
80103c45:	0f 84 a1 00 00 00    	je     80103cec <forkcow+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103c4b:	8b 03                	mov    (%ebx),%eax
80103c4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c50:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103c52:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c55:	89 c8                	mov    %ecx,%eax
80103c57:	8b 79 18             	mov    0x18(%ecx),%edi
80103c5a:	8b 73 18             	mov    0x18(%ebx),%esi
80103c5d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c62:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c64:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103c66:	8b 40 18             	mov    0x18(%eax),%eax
80103c69:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103c70:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c74:	85 c0                	test   %eax,%eax
80103c76:	74 13                	je     80103c8b <forkcow+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c78:	83 ec 0c             	sub    $0xc,%esp
80103c7b:	50                   	push   %eax
80103c7c:	e8 5f d1 ff ff       	call   80100de0 <filedup>
80103c81:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c84:	83 c4 10             	add    $0x10,%esp
80103c87:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c8b:	83 c6 01             	add    $0x1,%esi
80103c8e:	83 fe 10             	cmp    $0x10,%esi
80103c91:	75 dd                	jne    80103c70 <forkcow+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c93:	83 ec 0c             	sub    $0xc,%esp
80103c96:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c99:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103c9c:	e8 9f d9 ff ff       	call   80101640 <idup>
80103ca1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ca4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ca7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103caa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103cad:	6a 10                	push   $0x10
80103caf:	53                   	push   %ebx
80103cb0:	50                   	push   %eax
80103cb1:	e8 3a 0c 00 00       	call   801048f0 <safestrcpy>

  pid = np->pid;
80103cb6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103cb9:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103cc0:	e8 bb 08 00 00       	call   80104580 <acquire>

  np->state = RUNNABLE;
80103cc5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103ccc:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103cd3:	e8 c8 09 00 00       	call   801046a0 <release>

  return pid;
80103cd8:	83 c4 10             	add    $0x10,%esp
80103cdb:	89 d8                	mov    %ebx,%eax
}
80103cdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ce0:	5b                   	pop    %ebx
80103ce1:	5e                   	pop    %esi
80103ce2:	5f                   	pop    %edi
80103ce3:	5d                   	pop    %ebp
80103ce4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103ce5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cea:	eb f1                	jmp    80103cdd <forkcow+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvmcow(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103cec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103cef:	83 ec 0c             	sub    $0xc,%esp
80103cf2:	ff 77 08             	pushl  0x8(%edi)
80103cf5:	e8 e6 e5 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103cfa:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103d01:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103d08:	83 c4 10             	add    $0x10,%esp
80103d0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d10:	eb cb                	jmp    80103cdd <forkcow+0xdd>
80103d12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d20 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	57                   	push   %edi
80103d24:	56                   	push   %esi
80103d25:	53                   	push   %ebx
80103d26:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103d29:	e8 72 fb ff ff       	call   801038a0 <mycpu>
80103d2e:	8d 78 04             	lea    0x4(%eax),%edi
80103d31:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d33:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d3a:	00 00 00 
80103d3d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103d40:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103d41:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d44:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103d49:	68 20 bd 14 80       	push   $0x8014bd20
80103d4e:	e8 2d 08 00 00       	call   80104580 <acquire>
80103d53:	83 c4 10             	add    $0x10,%esp
80103d56:	eb 13                	jmp    80103d6b <scheduler+0x4b>
80103d58:	90                   	nop
80103d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d60:	83 c3 7c             	add    $0x7c,%ebx
80103d63:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80103d69:	74 45                	je     80103db0 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103d6b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d6f:	75 ef                	jne    80103d60 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d71:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103d74:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d7a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d7b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103d7e:	e8 4d 2e 00 00       	call   80106bd0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103d83:	58                   	pop    %eax
80103d84:	5a                   	pop    %edx
80103d85:	ff 73 a0             	pushl  -0x60(%ebx)
80103d88:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103d89:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103d90:	e8 b6 0b 00 00       	call   8010494b <swtch>
      switchkvm();
80103d95:	e8 16 2e 00 00       	call   80106bb0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103d9a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d9d:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103da3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103daa:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dad:	75 bc                	jne    80103d6b <scheduler+0x4b>
80103daf:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103db0:	83 ec 0c             	sub    $0xc,%esp
80103db3:	68 20 bd 14 80       	push   $0x8014bd20
80103db8:	e8 e3 08 00 00       	call   801046a0 <release>

  }
80103dbd:	83 c4 10             	add    $0x10,%esp
80103dc0:	e9 7b ff ff ff       	jmp    80103d40 <scheduler+0x20>
80103dc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dd0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	56                   	push   %esi
80103dd4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103dd5:	e8 66 07 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103dda:	e8 c1 fa ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103ddf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103de5:	e8 46 08 00 00       	call   80104630 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103dea:	83 ec 0c             	sub    $0xc,%esp
80103ded:	68 20 bd 14 80       	push   $0x8014bd20
80103df2:	e8 09 07 00 00       	call   80104500 <holding>
80103df7:	83 c4 10             	add    $0x10,%esp
80103dfa:	85 c0                	test   %eax,%eax
80103dfc:	74 4f                	je     80103e4d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103dfe:	e8 9d fa ff ff       	call   801038a0 <mycpu>
80103e03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e0a:	75 68                	jne    80103e74 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103e0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e10:	74 55                	je     80103e67 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e12:	9c                   	pushf  
80103e13:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103e14:	f6 c4 02             	test   $0x2,%ah
80103e17:	75 41                	jne    80103e5a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e19:	e8 82 fa ff ff       	call   801038a0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e1e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e27:	e8 74 fa ff ff       	call   801038a0 <mycpu>
80103e2c:	83 ec 08             	sub    $0x8,%esp
80103e2f:	ff 70 04             	pushl  0x4(%eax)
80103e32:	53                   	push   %ebx
80103e33:	e8 13 0b 00 00       	call   8010494b <swtch>
  mycpu()->intena = intena;
80103e38:	e8 63 fa ff ff       	call   801038a0 <mycpu>
}
80103e3d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103e40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e49:	5b                   	pop    %ebx
80103e4a:	5e                   	pop    %esi
80103e4b:	5d                   	pop    %ebp
80103e4c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	68 50 7b 10 80       	push   $0x80107b50
80103e55:	e8 16 c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 7c 7b 10 80       	push   $0x80107b7c
80103e62:	e8 09 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103e67:	83 ec 0c             	sub    $0xc,%esp
80103e6a:	68 6e 7b 10 80       	push   $0x80107b6e
80103e6f:	e8 fc c4 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103e74:	83 ec 0c             	sub    $0xc,%esp
80103e77:	68 62 7b 10 80       	push   $0x80107b62
80103e7c:	e8 ef c4 ff ff       	call   80100370 <panic>
80103e81:	eb 0d                	jmp    80103e90 <exit>
80103e83:	90                   	nop
80103e84:	90                   	nop
80103e85:	90                   	nop
80103e86:	90                   	nop
80103e87:	90                   	nop
80103e88:	90                   	nop
80103e89:	90                   	nop
80103e8a:	90                   	nop
80103e8b:	90                   	nop
80103e8c:	90                   	nop
80103e8d:	90                   	nop
80103e8e:	90                   	nop
80103e8f:	90                   	nop

80103e90 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
80103e95:	53                   	push   %ebx
80103e96:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e99:	e8 a2 06 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103e9e:	e8 fd f9 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103ea3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ea9:	e8 82 07 00 00       	call   80104630 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103eae:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103eb4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103eb7:	8d 7e 68             	lea    0x68(%esi),%edi
80103eba:	0f 84 e7 00 00 00    	je     80103fa7 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103ec0:	8b 03                	mov    (%ebx),%eax
80103ec2:	85 c0                	test   %eax,%eax
80103ec4:	74 12                	je     80103ed8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103ec6:	83 ec 0c             	sub    $0xc,%esp
80103ec9:	50                   	push   %eax
80103eca:	e8 61 cf ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103ecf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103ed5:	83 c4 10             	add    $0x10,%esp
80103ed8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103edb:	39 df                	cmp    %ebx,%edi
80103edd:	75 e1                	jne    80103ec0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103edf:	e8 2c ee ff ff       	call   80102d10 <begin_op>
  iput(curproc->cwd);
80103ee4:	83 ec 0c             	sub    $0xc,%esp
80103ee7:	ff 76 68             	pushl  0x68(%esi)
80103eea:	e8 b1 d8 ff ff       	call   801017a0 <iput>
  end_op();
80103eef:	e8 8c ee ff ff       	call   80102d80 <end_op>
  curproc->cwd = 0;
80103ef4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103efb:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103f02:	e8 79 06 00 00       	call   80104580 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103f07:	8b 56 14             	mov    0x14(%esi),%edx
80103f0a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f0d:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103f12:	eb 0e                	jmp    80103f22 <exit+0x92>
80103f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f18:	83 c0 7c             	add    $0x7c,%eax
80103f1b:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f20:	74 1c                	je     80103f3e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103f22:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f26:	75 f0                	jne    80103f18 <exit+0x88>
80103f28:	3b 50 20             	cmp    0x20(%eax),%edx
80103f2b:	75 eb                	jne    80103f18 <exit+0x88>
      p->state = RUNNABLE;
80103f2d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f34:	83 c0 7c             	add    $0x7c,%eax
80103f37:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f3c:	75 e4                	jne    80103f22 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f3e:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
80103f44:	ba 54 bd 14 80       	mov    $0x8014bd54,%edx
80103f49:	eb 10                	jmp    80103f5b <exit+0xcb>
80103f4b:	90                   	nop
80103f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f50:	83 c2 7c             	add    $0x7c,%edx
80103f53:	81 fa 54 dc 14 80    	cmp    $0x8014dc54,%edx
80103f59:	74 33                	je     80103f8e <exit+0xfe>
    if(p->parent == curproc){
80103f5b:	39 72 14             	cmp    %esi,0x14(%edx)
80103f5e:	75 f0                	jne    80103f50 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103f60:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f64:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f67:	75 e7                	jne    80103f50 <exit+0xc0>
80103f69:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
80103f6e:	eb 0a                	jmp    80103f7a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f70:	83 c0 7c             	add    $0x7c,%eax
80103f73:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80103f78:	74 d6                	je     80103f50 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f7e:	75 f0                	jne    80103f70 <exit+0xe0>
80103f80:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f83:	75 eb                	jne    80103f70 <exit+0xe0>
      p->state = RUNNABLE;
80103f85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f8c:	eb e2                	jmp    80103f70 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f8e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f95:	e8 36 fe ff ff       	call   80103dd0 <sched>
  panic("zombie exit");
80103f9a:	83 ec 0c             	sub    $0xc,%esp
80103f9d:	68 9d 7b 10 80       	push   $0x80107b9d
80103fa2:	e8 c9 c3 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103fa7:	83 ec 0c             	sub    $0xc,%esp
80103faa:	68 90 7b 10 80       	push   $0x80107b90
80103faf:	e8 bc c3 ff ff       	call   80100370 <panic>
80103fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103fc0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	53                   	push   %ebx
80103fc4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fc7:	68 20 bd 14 80       	push   $0x8014bd20
80103fcc:	e8 af 05 00 00       	call   80104580 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fd1:	e8 6a 05 00 00       	call   80104540 <pushcli>
  c = mycpu();
80103fd6:	e8 c5 f8 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80103fdb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fe1:	e8 4a 06 00 00       	call   80104630 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103fe6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103fed:	e8 de fd ff ff       	call   80103dd0 <sched>
  release(&ptable.lock);
80103ff2:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80103ff9:	e8 a2 06 00 00       	call   801046a0 <release>
}
80103ffe:	83 c4 10             	add    $0x10,%esp
80104001:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104004:	c9                   	leave  
80104005:	c3                   	ret    
80104006:	8d 76 00             	lea    0x0(%esi),%esi
80104009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104010 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	57                   	push   %edi
80104014:	56                   	push   %esi
80104015:	53                   	push   %ebx
80104016:	83 ec 0c             	sub    $0xc,%esp
80104019:	8b 7d 08             	mov    0x8(%ebp),%edi
8010401c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010401f:	e8 1c 05 00 00       	call   80104540 <pushcli>
  c = mycpu();
80104024:	e8 77 f8 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
80104029:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010402f:	e8 fc 05 00 00       	call   80104630 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104034:	85 db                	test   %ebx,%ebx
80104036:	0f 84 87 00 00 00    	je     801040c3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010403c:	85 f6                	test   %esi,%esi
8010403e:	74 76                	je     801040b6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104040:	81 fe 20 bd 14 80    	cmp    $0x8014bd20,%esi
80104046:	74 50                	je     80104098 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104048:	83 ec 0c             	sub    $0xc,%esp
8010404b:	68 20 bd 14 80       	push   $0x8014bd20
80104050:	e8 2b 05 00 00       	call   80104580 <acquire>
    release(lk);
80104055:	89 34 24             	mov    %esi,(%esp)
80104058:	e8 43 06 00 00       	call   801046a0 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010405d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104060:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104067:	e8 64 fd ff ff       	call   80103dd0 <sched>

  // Tidy up.
  p->chan = 0;
8010406c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104073:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
8010407a:	e8 21 06 00 00       	call   801046a0 <release>
    acquire(lk);
8010407f:	89 75 08             	mov    %esi,0x8(%ebp)
80104082:	83 c4 10             	add    $0x10,%esp
  }
}
80104085:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104088:	5b                   	pop    %ebx
80104089:	5e                   	pop    %esi
8010408a:	5f                   	pop    %edi
8010408b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010408c:	e9 ef 04 00 00       	jmp    80104580 <acquire>
80104091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104098:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010409b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801040a2:	e8 29 fd ff ff       	call   80103dd0 <sched>

  // Tidy up.
  p->chan = 0;
801040a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
801040ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040b1:	5b                   	pop    %ebx
801040b2:	5e                   	pop    %esi
801040b3:	5f                   	pop    %edi
801040b4:	5d                   	pop    %ebp
801040b5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801040b6:	83 ec 0c             	sub    $0xc,%esp
801040b9:	68 af 7b 10 80       	push   $0x80107baf
801040be:	e8 ad c2 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801040c3:	83 ec 0c             	sub    $0xc,%esp
801040c6:	68 a9 7b 10 80       	push   $0x80107ba9
801040cb:	e8 a0 c2 ff ff       	call   80100370 <panic>

801040d0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	56                   	push   %esi
801040d4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801040d5:	e8 66 04 00 00       	call   80104540 <pushcli>
  c = mycpu();
801040da:	e8 c1 f7 ff ff       	call   801038a0 <mycpu>
  p = c->proc;
801040df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040e5:	e8 46 05 00 00       	call   80104630 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
801040ea:	83 ec 0c             	sub    $0xc,%esp
801040ed:	68 20 bd 14 80       	push   $0x8014bd20
801040f2:	e8 89 04 00 00       	call   80104580 <acquire>
801040f7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801040fa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040fc:	bb 54 bd 14 80       	mov    $0x8014bd54,%ebx
80104101:	eb 10                	jmp    80104113 <wait+0x43>
80104103:	90                   	nop
80104104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104108:	83 c3 7c             	add    $0x7c,%ebx
8010410b:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
80104111:	74 1d                	je     80104130 <wait+0x60>
      if(p->parent != curproc)
80104113:	39 73 14             	cmp    %esi,0x14(%ebx)
80104116:	75 f0                	jne    80104108 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104118:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010411c:	74 30                	je     8010414e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010411e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104121:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104126:	81 fb 54 dc 14 80    	cmp    $0x8014dc54,%ebx
8010412c:	75 e5                	jne    80104113 <wait+0x43>
8010412e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104130:	85 c0                	test   %eax,%eax
80104132:	74 70                	je     801041a4 <wait+0xd4>
80104134:	8b 46 24             	mov    0x24(%esi),%eax
80104137:	85 c0                	test   %eax,%eax
80104139:	75 69                	jne    801041a4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010413b:	83 ec 08             	sub    $0x8,%esp
8010413e:	68 20 bd 14 80       	push   $0x8014bd20
80104143:	56                   	push   %esi
80104144:	e8 c7 fe ff ff       	call   80104010 <sleep>
  }
80104149:	83 c4 10             	add    $0x10,%esp
8010414c:	eb ac                	jmp    801040fa <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
8010414e:	83 ec 0c             	sub    $0xc,%esp
80104151:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104154:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104157:	e8 84 e1 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
8010415c:	5a                   	pop    %edx
8010415d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104160:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104167:	e8 e4 2d 00 00       	call   80106f50 <freevm>
        p->pid = 0;
8010416c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104173:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010417a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010417e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104185:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010418c:	c7 04 24 20 bd 14 80 	movl   $0x8014bd20,(%esp)
80104193:	e8 08 05 00 00       	call   801046a0 <release>
        return pid;
80104198:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010419b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010419e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041a0:	5b                   	pop    %ebx
801041a1:	5e                   	pop    %esi
801041a2:	5d                   	pop    %ebp
801041a3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	68 20 bd 14 80       	push   $0x8014bd20
801041ac:	e8 ef 04 00 00       	call   801046a0 <release>
      return -1;
801041b1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801041b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041bc:	5b                   	pop    %ebx
801041bd:	5e                   	pop    %esi
801041be:	5d                   	pop    %ebp
801041bf:	c3                   	ret    

801041c0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	53                   	push   %ebx
801041c4:	83 ec 10             	sub    $0x10,%esp
801041c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ca:	68 20 bd 14 80       	push   $0x8014bd20
801041cf:	e8 ac 03 00 00       	call   80104580 <acquire>
801041d4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041d7:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
801041dc:	eb 0c                	jmp    801041ea <wakeup+0x2a>
801041de:	66 90                	xchg   %ax,%ax
801041e0:	83 c0 7c             	add    $0x7c,%eax
801041e3:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
801041e8:	74 1c                	je     80104206 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801041ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041ee:	75 f0                	jne    801041e0 <wakeup+0x20>
801041f0:	3b 58 20             	cmp    0x20(%eax),%ebx
801041f3:	75 eb                	jne    801041e0 <wakeup+0x20>
      p->state = RUNNABLE;
801041f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041fc:	83 c0 7c             	add    $0x7c,%eax
801041ff:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80104204:	75 e4                	jne    801041ea <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104206:	c7 45 08 20 bd 14 80 	movl   $0x8014bd20,0x8(%ebp)
}
8010420d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104210:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104211:	e9 8a 04 00 00       	jmp    801046a0 <release>
80104216:	8d 76 00             	lea    0x0(%esi),%esi
80104219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104220 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 10             	sub    $0x10,%esp
80104227:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010422a:	68 20 bd 14 80       	push   $0x8014bd20
8010422f:	e8 4c 03 00 00       	call   80104580 <acquire>
80104234:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104237:	b8 54 bd 14 80       	mov    $0x8014bd54,%eax
8010423c:	eb 0c                	jmp    8010424a <kill+0x2a>
8010423e:	66 90                	xchg   %ax,%ax
80104240:	83 c0 7c             	add    $0x7c,%eax
80104243:	3d 54 dc 14 80       	cmp    $0x8014dc54,%eax
80104248:	74 3e                	je     80104288 <kill+0x68>
    if(p->pid == pid){
8010424a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010424d:	75 f1                	jne    80104240 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010424f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104253:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010425a:	74 1c                	je     80104278 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010425c:	83 ec 0c             	sub    $0xc,%esp
8010425f:	68 20 bd 14 80       	push   $0x8014bd20
80104264:	e8 37 04 00 00       	call   801046a0 <release>
      return 0;
80104269:	83 c4 10             	add    $0x10,%esp
8010426c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010426e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104271:	c9                   	leave  
80104272:	c3                   	ret    
80104273:	90                   	nop
80104274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104278:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010427f:	eb db                	jmp    8010425c <kill+0x3c>
80104281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	68 20 bd 14 80       	push   $0x8014bd20
80104290:	e8 0b 04 00 00       	call   801046a0 <release>
  return -1;
80104295:	83 c4 10             	add    $0x10,%esp
80104298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010429d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042a0:	c9                   	leave  
801042a1:	c3                   	ret    
801042a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	57                   	push   %edi
801042b4:	56                   	push   %esi
801042b5:	53                   	push   %ebx
801042b6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801042b9:	bb c0 bd 14 80       	mov    $0x8014bdc0,%ebx
801042be:	83 ec 3c             	sub    $0x3c,%esp
801042c1:	eb 24                	jmp    801042e7 <procdump+0x37>
801042c3:	90                   	nop
801042c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	68 ed 7f 10 80       	push   $0x80107fed
801042d0:	e8 8b c3 ff ff       	call   80100660 <cprintf>
801042d5:	83 c4 10             	add    $0x10,%esp
801042d8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042db:	81 fb c0 dc 14 80    	cmp    $0x8014dcc0,%ebx
801042e1:	0f 84 81 00 00 00    	je     80104368 <procdump+0xb8>
    if(p->state == UNUSED)
801042e7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042ea:	85 c0                	test   %eax,%eax
801042ec:	74 ea                	je     801042d8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042ee:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801042f1:	ba c0 7b 10 80       	mov    $0x80107bc0,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042f6:	77 11                	ja     80104309 <procdump+0x59>
801042f8:	8b 14 85 20 7c 10 80 	mov    -0x7fef83e0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801042ff:	b8 c0 7b 10 80       	mov    $0x80107bc0,%eax
80104304:	85 d2                	test   %edx,%edx
80104306:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104309:	53                   	push   %ebx
8010430a:	52                   	push   %edx
8010430b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010430e:	68 c4 7b 10 80       	push   $0x80107bc4
80104313:	e8 48 c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104318:	83 c4 10             	add    $0x10,%esp
8010431b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010431f:	75 a7                	jne    801042c8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104321:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104324:	83 ec 08             	sub    $0x8,%esp
80104327:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010432a:	50                   	push   %eax
8010432b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010432e:	8b 40 0c             	mov    0xc(%eax),%eax
80104331:	83 c0 08             	add    $0x8,%eax
80104334:	50                   	push   %eax
80104335:	e8 66 01 00 00       	call   801044a0 <getcallerpcs>
8010433a:	83 c4 10             	add    $0x10,%esp
8010433d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104340:	8b 17                	mov    (%edi),%edx
80104342:	85 d2                	test   %edx,%edx
80104344:	74 82                	je     801042c8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104346:	83 ec 08             	sub    $0x8,%esp
80104349:	83 c7 04             	add    $0x4,%edi
8010434c:	52                   	push   %edx
8010434d:	68 e1 75 10 80       	push   $0x801075e1
80104352:	e8 09 c3 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104357:	83 c4 10             	add    $0x10,%esp
8010435a:	39 f7                	cmp    %esi,%edi
8010435c:	75 e2                	jne    80104340 <procdump+0x90>
8010435e:	e9 65 ff ff ff       	jmp    801042c8 <procdump+0x18>
80104363:	90                   	nop
80104364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104368:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010436b:	5b                   	pop    %ebx
8010436c:	5e                   	pop    %esi
8010436d:	5f                   	pop    %edi
8010436e:	5d                   	pop    %ebp
8010436f:	c3                   	ret    

80104370 <initsleeplock>:
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 0c             	sub    $0xc,%esp
80104377:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010437a:	68 38 7c 10 80       	push   $0x80107c38
8010437f:	8d 43 04             	lea    0x4(%ebx),%eax
80104382:	50                   	push   %eax
80104383:	e8 f8 00 00 00       	call   80104480 <initlock>
80104388:	8b 45 0c             	mov    0xc(%ebp),%eax
8010438b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104391:	83 c4 10             	add    $0x10,%esp
80104394:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010439b:	89 43 38             	mov    %eax,0x38(%ebx)
8010439e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043a1:	c9                   	leave  
801043a2:	c3                   	ret    
801043a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043b0 <acquiresleep>:
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	56                   	push   %esi
801043b4:	53                   	push   %ebx
801043b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043b8:	83 ec 0c             	sub    $0xc,%esp
801043bb:	8d 73 04             	lea    0x4(%ebx),%esi
801043be:	56                   	push   %esi
801043bf:	e8 bc 01 00 00       	call   80104580 <acquire>
801043c4:	8b 13                	mov    (%ebx),%edx
801043c6:	83 c4 10             	add    $0x10,%esp
801043c9:	85 d2                	test   %edx,%edx
801043cb:	74 16                	je     801043e3 <acquiresleep+0x33>
801043cd:	8d 76 00             	lea    0x0(%esi),%esi
801043d0:	83 ec 08             	sub    $0x8,%esp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	e8 36 fc ff ff       	call   80104010 <sleep>
801043da:	8b 03                	mov    (%ebx),%eax
801043dc:	83 c4 10             	add    $0x10,%esp
801043df:	85 c0                	test   %eax,%eax
801043e1:	75 ed                	jne    801043d0 <acquiresleep+0x20>
801043e3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801043e9:	e8 52 f5 ff ff       	call   80103940 <myproc>
801043ee:	8b 40 10             	mov    0x10(%eax),%eax
801043f1:	89 43 3c             	mov    %eax,0x3c(%ebx)
801043f4:	89 75 08             	mov    %esi,0x8(%ebp)
801043f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043fa:	5b                   	pop    %ebx
801043fb:	5e                   	pop    %esi
801043fc:	5d                   	pop    %ebp
801043fd:	e9 9e 02 00 00       	jmp    801046a0 <release>
80104402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104410 <releasesleep>:
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	56                   	push   %esi
80104414:	53                   	push   %ebx
80104415:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104418:	83 ec 0c             	sub    $0xc,%esp
8010441b:	8d 73 04             	lea    0x4(%ebx),%esi
8010441e:	56                   	push   %esi
8010441f:	e8 5c 01 00 00       	call   80104580 <acquire>
80104424:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010442a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104431:	89 1c 24             	mov    %ebx,(%esp)
80104434:	e8 87 fd ff ff       	call   801041c0 <wakeup>
80104439:	89 75 08             	mov    %esi,0x8(%ebp)
8010443c:	83 c4 10             	add    $0x10,%esp
8010443f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104442:	5b                   	pop    %ebx
80104443:	5e                   	pop    %esi
80104444:	5d                   	pop    %ebp
80104445:	e9 56 02 00 00       	jmp    801046a0 <release>
8010444a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104450 <holdingsleep>:
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	56                   	push   %esi
80104454:	53                   	push   %ebx
80104455:	8b 75 08             	mov    0x8(%ebp),%esi
80104458:	83 ec 0c             	sub    $0xc,%esp
8010445b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010445e:	53                   	push   %ebx
8010445f:	e8 1c 01 00 00       	call   80104580 <acquire>
80104464:	8b 36                	mov    (%esi),%esi
80104466:	89 1c 24             	mov    %ebx,(%esp)
80104469:	e8 32 02 00 00       	call   801046a0 <release>
8010446e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104471:	89 f0                	mov    %esi,%eax
80104473:	5b                   	pop    %ebx
80104474:	5e                   	pop    %esi
80104475:	5d                   	pop    %ebp
80104476:	c3                   	ret    
80104477:	66 90                	xchg   %ax,%ax
80104479:	66 90                	xchg   %ax,%ax
8010447b:	66 90                	xchg   %ax,%ax
8010447d:	66 90                	xchg   %ax,%ax
8010447f:	90                   	nop

80104480 <initlock>:
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	8b 45 08             	mov    0x8(%ebp),%eax
80104486:	8b 55 0c             	mov    0xc(%ebp),%edx
80104489:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010448f:	89 50 04             	mov    %edx,0x4(%eax)
80104492:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104499:	5d                   	pop    %ebp
8010449a:	c3                   	ret    
8010449b:	90                   	nop
8010449c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044a0 <getcallerpcs>:
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
801044a4:	8b 45 08             	mov    0x8(%ebp),%eax
801044a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801044aa:	8d 50 f8             	lea    -0x8(%eax),%edx
801044ad:	31 c0                	xor    %eax,%eax
801044af:	90                   	nop
801044b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044bc:	77 1a                	ja     801044d8 <getcallerpcs+0x38>
801044be:	8b 5a 04             	mov    0x4(%edx),%ebx
801044c1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
801044c4:	83 c0 01             	add    $0x1,%eax
801044c7:	8b 12                	mov    (%edx),%edx
801044c9:	83 f8 0a             	cmp    $0xa,%eax
801044cc:	75 e2                	jne    801044b0 <getcallerpcs+0x10>
801044ce:	5b                   	pop    %ebx
801044cf:	5d                   	pop    %ebp
801044d0:	c3                   	ret    
801044d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044d8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044df:	83 c0 01             	add    $0x1,%eax
801044e2:	83 f8 0a             	cmp    $0xa,%eax
801044e5:	74 e7                	je     801044ce <getcallerpcs+0x2e>
801044e7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801044ee:	83 c0 01             	add    $0x1,%eax
801044f1:	83 f8 0a             	cmp    $0xa,%eax
801044f4:	75 e2                	jne    801044d8 <getcallerpcs+0x38>
801044f6:	eb d6                	jmp    801044ce <getcallerpcs+0x2e>
801044f8:	90                   	nop
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104500 <holding>:
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 04             	sub    $0x4,%esp
80104507:	8b 55 08             	mov    0x8(%ebp),%edx
8010450a:	8b 02                	mov    (%edx),%eax
8010450c:	85 c0                	test   %eax,%eax
8010450e:	75 10                	jne    80104520 <holding+0x20>
80104510:	83 c4 04             	add    $0x4,%esp
80104513:	31 c0                	xor    %eax,%eax
80104515:	5b                   	pop    %ebx
80104516:	5d                   	pop    %ebp
80104517:	c3                   	ret    
80104518:	90                   	nop
80104519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104520:	8b 5a 08             	mov    0x8(%edx),%ebx
80104523:	e8 78 f3 ff ff       	call   801038a0 <mycpu>
80104528:	39 c3                	cmp    %eax,%ebx
8010452a:	0f 94 c0             	sete   %al
8010452d:	83 c4 04             	add    $0x4,%esp
80104530:	0f b6 c0             	movzbl %al,%eax
80104533:	5b                   	pop    %ebx
80104534:	5d                   	pop    %ebp
80104535:	c3                   	ret    
80104536:	8d 76 00             	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <pushcli>:
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 04             	sub    $0x4,%esp
80104547:	9c                   	pushf  
80104548:	5b                   	pop    %ebx
80104549:	fa                   	cli    
8010454a:	e8 51 f3 ff ff       	call   801038a0 <mycpu>
8010454f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104555:	85 c0                	test   %eax,%eax
80104557:	75 11                	jne    8010456a <pushcli+0x2a>
80104559:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010455f:	e8 3c f3 ff ff       	call   801038a0 <mycpu>
80104564:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
8010456a:	e8 31 f3 ff ff       	call   801038a0 <mycpu>
8010456f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104576:	83 c4 04             	add    $0x4,%esp
80104579:	5b                   	pop    %ebx
8010457a:	5d                   	pop    %ebp
8010457b:	c3                   	ret    
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <acquire>:
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	56                   	push   %esi
80104584:	53                   	push   %ebx
80104585:	e8 b6 ff ff ff       	call   80104540 <pushcli>
8010458a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010458d:	8b 03                	mov    (%ebx),%eax
8010458f:	85 c0                	test   %eax,%eax
80104591:	75 7d                	jne    80104610 <acquire+0x90>
80104593:	ba 01 00 00 00       	mov    $0x1,%edx
80104598:	eb 09                	jmp    801045a3 <acquire+0x23>
8010459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045a3:	89 d0                	mov    %edx,%eax
801045a5:	f0 87 03             	lock xchg %eax,(%ebx)
801045a8:	85 c0                	test   %eax,%eax
801045aa:	75 f4                	jne    801045a0 <acquire+0x20>
801045ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801045b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045b4:	e8 e7 f2 ff ff       	call   801038a0 <mycpu>
801045b9:	89 ea                	mov    %ebp,%edx
801045bb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
801045be:	89 43 08             	mov    %eax,0x8(%ebx)
801045c1:	31 c0                	xor    %eax,%eax
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045c8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045ce:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045d4:	77 1a                	ja     801045f0 <acquire+0x70>
801045d6:	8b 5a 04             	mov    0x4(%edx),%ebx
801045d9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
801045dc:	83 c0 01             	add    $0x1,%eax
801045df:	8b 12                	mov    (%edx),%edx
801045e1:	83 f8 0a             	cmp    $0xa,%eax
801045e4:	75 e2                	jne    801045c8 <acquire+0x48>
801045e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045e9:	5b                   	pop    %ebx
801045ea:	5e                   	pop    %esi
801045eb:	5d                   	pop    %ebp
801045ec:	c3                   	ret    
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
801045f0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801045f7:	83 c0 01             	add    $0x1,%eax
801045fa:	83 f8 0a             	cmp    $0xa,%eax
801045fd:	74 e7                	je     801045e6 <acquire+0x66>
801045ff:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
80104606:	83 c0 01             	add    $0x1,%eax
80104609:	83 f8 0a             	cmp    $0xa,%eax
8010460c:	75 e2                	jne    801045f0 <acquire+0x70>
8010460e:	eb d6                	jmp    801045e6 <acquire+0x66>
80104610:	8b 73 08             	mov    0x8(%ebx),%esi
80104613:	e8 88 f2 ff ff       	call   801038a0 <mycpu>
80104618:	39 c6                	cmp    %eax,%esi
8010461a:	0f 85 73 ff ff ff    	jne    80104593 <acquire+0x13>
80104620:	83 ec 0c             	sub    $0xc,%esp
80104623:	68 43 7c 10 80       	push   $0x80107c43
80104628:	e8 43 bd ff ff       	call   80100370 <panic>
8010462d:	8d 76 00             	lea    0x0(%esi),%esi

80104630 <popcli>:
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	83 ec 08             	sub    $0x8,%esp
80104636:	9c                   	pushf  
80104637:	58                   	pop    %eax
80104638:	f6 c4 02             	test   $0x2,%ah
8010463b:	75 52                	jne    8010468f <popcli+0x5f>
8010463d:	e8 5e f2 ff ff       	call   801038a0 <mycpu>
80104642:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104648:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010464b:	85 d2                	test   %edx,%edx
8010464d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104653:	78 2d                	js     80104682 <popcli+0x52>
80104655:	e8 46 f2 ff ff       	call   801038a0 <mycpu>
8010465a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104660:	85 d2                	test   %edx,%edx
80104662:	74 0c                	je     80104670 <popcli+0x40>
80104664:	c9                   	leave  
80104665:	c3                   	ret    
80104666:	8d 76 00             	lea    0x0(%esi),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104670:	e8 2b f2 ff ff       	call   801038a0 <mycpu>
80104675:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010467b:	85 c0                	test   %eax,%eax
8010467d:	74 e5                	je     80104664 <popcli+0x34>
8010467f:	fb                   	sti    
80104680:	c9                   	leave  
80104681:	c3                   	ret    
80104682:	83 ec 0c             	sub    $0xc,%esp
80104685:	68 62 7c 10 80       	push   $0x80107c62
8010468a:	e8 e1 bc ff ff       	call   80100370 <panic>
8010468f:	83 ec 0c             	sub    $0xc,%esp
80104692:	68 4b 7c 10 80       	push   $0x80107c4b
80104697:	e8 d4 bc ff ff       	call   80100370 <panic>
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <release>:
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	53                   	push   %ebx
801046a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046a8:	8b 03                	mov    (%ebx),%eax
801046aa:	85 c0                	test   %eax,%eax
801046ac:	75 12                	jne    801046c0 <release+0x20>
801046ae:	83 ec 0c             	sub    $0xc,%esp
801046b1:	68 69 7c 10 80       	push   $0x80107c69
801046b6:	e8 b5 bc ff ff       	call   80100370 <panic>
801046bb:	90                   	nop
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c0:	8b 73 08             	mov    0x8(%ebx),%esi
801046c3:	e8 d8 f1 ff ff       	call   801038a0 <mycpu>
801046c8:	39 c6                	cmp    %eax,%esi
801046ca:	75 e2                	jne    801046ae <release+0xe>
801046cc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801046d3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801046da:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801046df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046e8:	5b                   	pop    %ebx
801046e9:	5e                   	pop    %esi
801046ea:	5d                   	pop    %ebp
801046eb:	e9 40 ff ff ff       	jmp    80104630 <popcli>

801046f0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	57                   	push   %edi
801046f4:	53                   	push   %ebx
801046f5:	8b 55 08             	mov    0x8(%ebp),%edx
801046f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046fb:	f6 c2 03             	test   $0x3,%dl
801046fe:	75 05                	jne    80104705 <memset+0x15>
80104700:	f6 c1 03             	test   $0x3,%cl
80104703:	74 13                	je     80104718 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104705:	89 d7                	mov    %edx,%edi
80104707:	8b 45 0c             	mov    0xc(%ebp),%eax
8010470a:	fc                   	cld    
8010470b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010470d:	5b                   	pop    %ebx
8010470e:	89 d0                	mov    %edx,%eax
80104710:	5f                   	pop    %edi
80104711:	5d                   	pop    %ebp
80104712:	c3                   	ret    
80104713:	90                   	nop
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104718:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010471c:	c1 e9 02             	shr    $0x2,%ecx
8010471f:	89 fb                	mov    %edi,%ebx
80104721:	89 f8                	mov    %edi,%eax
80104723:	c1 e3 18             	shl    $0x18,%ebx
80104726:	c1 e0 10             	shl    $0x10,%eax
80104729:	09 d8                	or     %ebx,%eax
8010472b:	09 f8                	or     %edi,%eax
8010472d:	c1 e7 08             	shl    $0x8,%edi
80104730:	09 f8                	or     %edi,%eax
80104732:	89 d7                	mov    %edx,%edi
80104734:	fc                   	cld    
80104735:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104737:	5b                   	pop    %ebx
80104738:	89 d0                	mov    %edx,%eax
8010473a:	5f                   	pop    %edi
8010473b:	5d                   	pop    %ebp
8010473c:	c3                   	ret    
8010473d:	8d 76 00             	lea    0x0(%esi),%esi

80104740 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	8b 45 10             	mov    0x10(%ebp),%eax
80104748:	53                   	push   %ebx
80104749:	8b 75 0c             	mov    0xc(%ebp),%esi
8010474c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010474f:	85 c0                	test   %eax,%eax
80104751:	74 29                	je     8010477c <memcmp+0x3c>
    if(*s1 != *s2)
80104753:	0f b6 13             	movzbl (%ebx),%edx
80104756:	0f b6 0e             	movzbl (%esi),%ecx
80104759:	38 d1                	cmp    %dl,%cl
8010475b:	75 2b                	jne    80104788 <memcmp+0x48>
8010475d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104760:	31 c0                	xor    %eax,%eax
80104762:	eb 14                	jmp    80104778 <memcmp+0x38>
80104764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104768:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010476d:	83 c0 01             	add    $0x1,%eax
80104770:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104774:	38 ca                	cmp    %cl,%dl
80104776:	75 10                	jne    80104788 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104778:	39 f8                	cmp    %edi,%eax
8010477a:	75 ec                	jne    80104768 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010477c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010477d:	31 c0                	xor    %eax,%eax
}
8010477f:	5e                   	pop    %esi
80104780:	5f                   	pop    %edi
80104781:	5d                   	pop    %ebp
80104782:	c3                   	ret    
80104783:	90                   	nop
80104784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104788:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010478b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010478c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010478e:	5e                   	pop    %esi
8010478f:	5f                   	pop    %edi
80104790:	5d                   	pop    %ebp
80104791:	c3                   	ret    
80104792:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	8b 45 08             	mov    0x8(%ebp),%eax
801047a8:	8b 75 0c             	mov    0xc(%ebp),%esi
801047ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ae:	39 c6                	cmp    %eax,%esi
801047b0:	73 2e                	jae    801047e0 <memmove+0x40>
801047b2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801047b5:	39 c8                	cmp    %ecx,%eax
801047b7:	73 27                	jae    801047e0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801047b9:	85 db                	test   %ebx,%ebx
801047bb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801047be:	74 17                	je     801047d7 <memmove+0x37>
      *--d = *--s;
801047c0:	29 d9                	sub    %ebx,%ecx
801047c2:	89 cb                	mov    %ecx,%ebx
801047c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047c8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801047cf:	83 ea 01             	sub    $0x1,%edx
801047d2:	83 fa ff             	cmp    $0xffffffff,%edx
801047d5:	75 f1                	jne    801047c8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801047d7:	5b                   	pop    %ebx
801047d8:	5e                   	pop    %esi
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret    
801047db:	90                   	nop
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047e0:	31 d2                	xor    %edx,%edx
801047e2:	85 db                	test   %ebx,%ebx
801047e4:	74 f1                	je     801047d7 <memmove+0x37>
801047e6:	8d 76 00             	lea    0x0(%esi),%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801047f0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047f7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047fa:	39 d3                	cmp    %edx,%ebx
801047fc:	75 f2                	jne    801047f0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801047fe:	5b                   	pop    %ebx
801047ff:	5e                   	pop    %esi
80104800:	5d                   	pop    %ebp
80104801:	c3                   	ret    
80104802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104813:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104814:	eb 8a                	jmp    801047a0 <memmove>
80104816:	8d 76 00             	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	57                   	push   %edi
80104824:	56                   	push   %esi
80104825:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104828:	53                   	push   %ebx
80104829:	8b 7d 08             	mov    0x8(%ebp),%edi
8010482c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010482f:	85 c9                	test   %ecx,%ecx
80104831:	74 37                	je     8010486a <strncmp+0x4a>
80104833:	0f b6 17             	movzbl (%edi),%edx
80104836:	0f b6 1e             	movzbl (%esi),%ebx
80104839:	84 d2                	test   %dl,%dl
8010483b:	74 3f                	je     8010487c <strncmp+0x5c>
8010483d:	38 d3                	cmp    %dl,%bl
8010483f:	75 3b                	jne    8010487c <strncmp+0x5c>
80104841:	8d 47 01             	lea    0x1(%edi),%eax
80104844:	01 cf                	add    %ecx,%edi
80104846:	eb 1b                	jmp    80104863 <strncmp+0x43>
80104848:	90                   	nop
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104850:	0f b6 10             	movzbl (%eax),%edx
80104853:	84 d2                	test   %dl,%dl
80104855:	74 21                	je     80104878 <strncmp+0x58>
80104857:	0f b6 19             	movzbl (%ecx),%ebx
8010485a:	83 c0 01             	add    $0x1,%eax
8010485d:	89 ce                	mov    %ecx,%esi
8010485f:	38 da                	cmp    %bl,%dl
80104861:	75 19                	jne    8010487c <strncmp+0x5c>
80104863:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104865:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104868:	75 e6                	jne    80104850 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010486a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010486b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010486d:	5e                   	pop    %esi
8010486e:	5f                   	pop    %edi
8010486f:	5d                   	pop    %ebp
80104870:	c3                   	ret    
80104871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104878:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010487c:	0f b6 c2             	movzbl %dl,%eax
8010487f:	29 d8                	sub    %ebx,%eax
}
80104881:	5b                   	pop    %ebx
80104882:	5e                   	pop    %esi
80104883:	5f                   	pop    %edi
80104884:	5d                   	pop    %ebp
80104885:	c3                   	ret    
80104886:	8d 76 00             	lea    0x0(%esi),%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
80104895:	8b 45 08             	mov    0x8(%ebp),%eax
80104898:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010489b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010489e:	89 c2                	mov    %eax,%edx
801048a0:	eb 19                	jmp    801048bb <strncpy+0x2b>
801048a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048a8:	83 c3 01             	add    $0x1,%ebx
801048ab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801048af:	83 c2 01             	add    $0x1,%edx
801048b2:	84 c9                	test   %cl,%cl
801048b4:	88 4a ff             	mov    %cl,-0x1(%edx)
801048b7:	74 09                	je     801048c2 <strncpy+0x32>
801048b9:	89 f1                	mov    %esi,%ecx
801048bb:	85 c9                	test   %ecx,%ecx
801048bd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801048c0:	7f e6                	jg     801048a8 <strncpy+0x18>
    ;
  while(n-- > 0)
801048c2:	31 c9                	xor    %ecx,%ecx
801048c4:	85 f6                	test   %esi,%esi
801048c6:	7e 17                	jle    801048df <strncpy+0x4f>
801048c8:	90                   	nop
801048c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801048d0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801048d4:	89 f3                	mov    %esi,%ebx
801048d6:	83 c1 01             	add    $0x1,%ecx
801048d9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801048db:	85 db                	test   %ebx,%ebx
801048dd:	7f f1                	jg     801048d0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801048df:	5b                   	pop    %ebx
801048e0:	5e                   	pop    %esi
801048e1:	5d                   	pop    %ebp
801048e2:	c3                   	ret    
801048e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048f0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	56                   	push   %esi
801048f4:	53                   	push   %ebx
801048f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048f8:	8b 45 08             	mov    0x8(%ebp),%eax
801048fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048fe:	85 c9                	test   %ecx,%ecx
80104900:	7e 26                	jle    80104928 <safestrcpy+0x38>
80104902:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104906:	89 c1                	mov    %eax,%ecx
80104908:	eb 17                	jmp    80104921 <safestrcpy+0x31>
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104910:	83 c2 01             	add    $0x1,%edx
80104913:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104917:	83 c1 01             	add    $0x1,%ecx
8010491a:	84 db                	test   %bl,%bl
8010491c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010491f:	74 04                	je     80104925 <safestrcpy+0x35>
80104921:	39 f2                	cmp    %esi,%edx
80104923:	75 eb                	jne    80104910 <safestrcpy+0x20>
    ;
  *s = 0;
80104925:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104928:	5b                   	pop    %ebx
80104929:	5e                   	pop    %esi
8010492a:	5d                   	pop    %ebp
8010492b:	c3                   	ret    
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104930 <strlen>:

int
strlen(const char *s)
{
80104930:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104931:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104933:	89 e5                	mov    %esp,%ebp
80104935:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104938:	80 3a 00             	cmpb   $0x0,(%edx)
8010493b:	74 0c                	je     80104949 <strlen+0x19>
8010493d:	8d 76 00             	lea    0x0(%esi),%esi
80104940:	83 c0 01             	add    $0x1,%eax
80104943:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104947:	75 f7                	jne    80104940 <strlen+0x10>
    ;
  return n;
}
80104949:	5d                   	pop    %ebp
8010494a:	c3                   	ret    

8010494b <swtch>:
8010494b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010494f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104953:	55                   	push   %ebp
80104954:	53                   	push   %ebx
80104955:	56                   	push   %esi
80104956:	57                   	push   %edi
80104957:	89 20                	mov    %esp,(%eax)
80104959:	89 d4                	mov    %edx,%esp
8010495b:	5f                   	pop    %edi
8010495c:	5e                   	pop    %esi
8010495d:	5b                   	pop    %ebx
8010495e:	5d                   	pop    %ebp
8010495f:	c3                   	ret    

80104960 <fetchint>:
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	53                   	push   %ebx
80104964:	83 ec 04             	sub    $0x4,%esp
80104967:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010496a:	e8 d1 ef ff ff       	call   80103940 <myproc>
8010496f:	8b 00                	mov    (%eax),%eax
80104971:	39 d8                	cmp    %ebx,%eax
80104973:	76 1b                	jbe    80104990 <fetchint+0x30>
80104975:	8d 53 04             	lea    0x4(%ebx),%edx
80104978:	39 d0                	cmp    %edx,%eax
8010497a:	72 14                	jb     80104990 <fetchint+0x30>
8010497c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010497f:	8b 13                	mov    (%ebx),%edx
80104981:	89 10                	mov    %edx,(%eax)
80104983:	31 c0                	xor    %eax,%eax
80104985:	83 c4 04             	add    $0x4,%esp
80104988:	5b                   	pop    %ebx
80104989:	5d                   	pop    %ebp
8010498a:	c3                   	ret    
8010498b:	90                   	nop
8010498c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104995:	eb ee                	jmp    80104985 <fetchint+0x25>
80104997:	89 f6                	mov    %esi,%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049a0 <fetchstr>:
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	53                   	push   %ebx
801049a4:	83 ec 04             	sub    $0x4,%esp
801049a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049aa:	e8 91 ef ff ff       	call   80103940 <myproc>
801049af:	39 18                	cmp    %ebx,(%eax)
801049b1:	76 29                	jbe    801049dc <fetchstr+0x3c>
801049b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801049b6:	89 da                	mov    %ebx,%edx
801049b8:	89 19                	mov    %ebx,(%ecx)
801049ba:	8b 00                	mov    (%eax),%eax
801049bc:	39 c3                	cmp    %eax,%ebx
801049be:	73 1c                	jae    801049dc <fetchstr+0x3c>
801049c0:	80 3b 00             	cmpb   $0x0,(%ebx)
801049c3:	75 10                	jne    801049d5 <fetchstr+0x35>
801049c5:	eb 29                	jmp    801049f0 <fetchstr+0x50>
801049c7:	89 f6                	mov    %esi,%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049d0:	80 3a 00             	cmpb   $0x0,(%edx)
801049d3:	74 1b                	je     801049f0 <fetchstr+0x50>
801049d5:	83 c2 01             	add    $0x1,%edx
801049d8:	39 d0                	cmp    %edx,%eax
801049da:	77 f4                	ja     801049d0 <fetchstr+0x30>
801049dc:	83 c4 04             	add    $0x4,%esp
801049df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049e4:	5b                   	pop    %ebx
801049e5:	5d                   	pop    %ebp
801049e6:	c3                   	ret    
801049e7:	89 f6                	mov    %esi,%esi
801049e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049f0:	83 c4 04             	add    $0x4,%esp
801049f3:	89 d0                	mov    %edx,%eax
801049f5:	29 d8                	sub    %ebx,%eax
801049f7:	5b                   	pop    %ebx
801049f8:	5d                   	pop    %ebp
801049f9:	c3                   	ret    
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <argint>:
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	e8 36 ef ff ff       	call   80103940 <myproc>
80104a0a:	8b 40 18             	mov    0x18(%eax),%eax
80104a0d:	8b 55 08             	mov    0x8(%ebp),%edx
80104a10:	8b 40 44             	mov    0x44(%eax),%eax
80104a13:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104a16:	e8 25 ef ff ff       	call   80103940 <myproc>
80104a1b:	8b 00                	mov    (%eax),%eax
80104a1d:	8d 73 04             	lea    0x4(%ebx),%esi
80104a20:	39 c6                	cmp    %eax,%esi
80104a22:	73 1c                	jae    80104a40 <argint+0x40>
80104a24:	8d 53 08             	lea    0x8(%ebx),%edx
80104a27:	39 d0                	cmp    %edx,%eax
80104a29:	72 15                	jb     80104a40 <argint+0x40>
80104a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a2e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a31:	89 10                	mov    %edx,(%eax)
80104a33:	31 c0                	xor    %eax,%eax
80104a35:	5b                   	pop    %ebx
80104a36:	5e                   	pop    %esi
80104a37:	5d                   	pop    %ebp
80104a38:	c3                   	ret    
80104a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a45:	eb ee                	jmp    80104a35 <argint+0x35>
80104a47:	89 f6                	mov    %esi,%esi
80104a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a50 <argptr>:
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	56                   	push   %esi
80104a54:	53                   	push   %ebx
80104a55:	83 ec 10             	sub    $0x10,%esp
80104a58:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a5b:	e8 e0 ee ff ff       	call   80103940 <myproc>
80104a60:	89 c6                	mov    %eax,%esi
80104a62:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a65:	83 ec 08             	sub    $0x8,%esp
80104a68:	50                   	push   %eax
80104a69:	ff 75 08             	pushl  0x8(%ebp)
80104a6c:	e8 8f ff ff ff       	call   80104a00 <argint>
80104a71:	c1 e8 1f             	shr    $0x1f,%eax
80104a74:	83 c4 10             	add    $0x10,%esp
80104a77:	84 c0                	test   %al,%al
80104a79:	75 2d                	jne    80104aa8 <argptr+0x58>
80104a7b:	89 d8                	mov    %ebx,%eax
80104a7d:	c1 e8 1f             	shr    $0x1f,%eax
80104a80:	84 c0                	test   %al,%al
80104a82:	75 24                	jne    80104aa8 <argptr+0x58>
80104a84:	8b 16                	mov    (%esi),%edx
80104a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a89:	39 c2                	cmp    %eax,%edx
80104a8b:	76 1b                	jbe    80104aa8 <argptr+0x58>
80104a8d:	01 c3                	add    %eax,%ebx
80104a8f:	39 da                	cmp    %ebx,%edx
80104a91:	72 15                	jb     80104aa8 <argptr+0x58>
80104a93:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a96:	89 02                	mov    %eax,(%edx)
80104a98:	31 c0                	xor    %eax,%eax
80104a9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a9d:	5b                   	pop    %ebx
80104a9e:	5e                   	pop    %esi
80104a9f:	5d                   	pop    %ebp
80104aa0:	c3                   	ret    
80104aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aad:	eb eb                	jmp    80104a9a <argptr+0x4a>
80104aaf:	90                   	nop

80104ab0 <argstr>:
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	83 ec 20             	sub    $0x20,%esp
80104ab6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ab9:	50                   	push   %eax
80104aba:	ff 75 08             	pushl  0x8(%ebp)
80104abd:	e8 3e ff ff ff       	call   80104a00 <argint>
80104ac2:	83 c4 10             	add    $0x10,%esp
80104ac5:	85 c0                	test   %eax,%eax
80104ac7:	78 17                	js     80104ae0 <argstr+0x30>
80104ac9:	83 ec 08             	sub    $0x8,%esp
80104acc:	ff 75 0c             	pushl  0xc(%ebp)
80104acf:	ff 75 f4             	pushl  -0xc(%ebp)
80104ad2:	e8 c9 fe ff ff       	call   801049a0 <fetchstr>
80104ad7:	83 c4 10             	add    $0x10,%esp
80104ada:	c9                   	leave  
80104adb:	c3                   	ret    
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ae5:	c9                   	leave  
80104ae6:	c3                   	ret    
80104ae7:	89 f6                	mov    %esi,%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <syscall>:
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	56                   	push   %esi
80104af4:	53                   	push   %ebx
80104af5:	e8 46 ee ff ff       	call   80103940 <myproc>
80104afa:	8b 70 18             	mov    0x18(%eax),%esi
80104afd:	89 c3                	mov    %eax,%ebx
80104aff:	8b 46 1c             	mov    0x1c(%esi),%eax
80104b02:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b05:	83 fa 18             	cmp    $0x18,%edx
80104b08:	77 1e                	ja     80104b28 <syscall+0x38>
80104b0a:	8b 14 85 a0 7c 10 80 	mov    -0x7fef8360(,%eax,4),%edx
80104b11:	85 d2                	test   %edx,%edx
80104b13:	74 13                	je     80104b28 <syscall+0x38>
80104b15:	ff d2                	call   *%edx
80104b17:	89 46 1c             	mov    %eax,0x1c(%esi)
80104b1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b1d:	5b                   	pop    %ebx
80104b1e:	5e                   	pop    %esi
80104b1f:	5d                   	pop    %ebp
80104b20:	c3                   	ret    
80104b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b28:	50                   	push   %eax
80104b29:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104b2c:	50                   	push   %eax
80104b2d:	ff 73 10             	pushl  0x10(%ebx)
80104b30:	68 71 7c 10 80       	push   $0x80107c71
80104b35:	e8 26 bb ff ff       	call   80100660 <cprintf>
80104b3a:	8b 43 18             	mov    0x18(%ebx),%eax
80104b3d:	83 c4 10             	add    $0x10,%esp
80104b40:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104b47:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b4a:	5b                   	pop    %ebx
80104b4b:	5e                   	pop    %esi
80104b4c:	5d                   	pop    %ebp
80104b4d:	c3                   	ret    
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <create>:
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	57                   	push   %edi
80104b54:	56                   	push   %esi
80104b55:	53                   	push   %ebx
80104b56:	8d 75 da             	lea    -0x26(%ebp),%esi
80104b59:	83 ec 44             	sub    $0x44,%esp
80104b5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b62:	56                   	push   %esi
80104b63:	50                   	push   %eax
80104b64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
80104b6a:	e8 71 d3 ff ff       	call   80101ee0 <nameiparent>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	0f 84 f6 00 00 00    	je     80104c70 <create+0x120>
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	89 c7                	mov    %eax,%edi
80104b7f:	50                   	push   %eax
80104b80:	e8 eb ca ff ff       	call   80101670 <ilock>
80104b85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b88:	83 c4 0c             	add    $0xc,%esp
80104b8b:	50                   	push   %eax
80104b8c:	56                   	push   %esi
80104b8d:	57                   	push   %edi
80104b8e:	e8 0d d0 ff ff       	call   80101ba0 <dirlookup>
80104b93:	83 c4 10             	add    $0x10,%esp
80104b96:	85 c0                	test   %eax,%eax
80104b98:	89 c3                	mov    %eax,%ebx
80104b9a:	74 54                	je     80104bf0 <create+0xa0>
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	57                   	push   %edi
80104ba0:	e8 5b cd ff ff       	call   80101900 <iunlockput>
80104ba5:	89 1c 24             	mov    %ebx,(%esp)
80104ba8:	e8 c3 ca ff ff       	call   80101670 <ilock>
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104bb5:	75 19                	jne    80104bd0 <create+0x80>
80104bb7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104bbc:	89 d8                	mov    %ebx,%eax
80104bbe:	75 10                	jne    80104bd0 <create+0x80>
80104bc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc3:	5b                   	pop    %ebx
80104bc4:	5e                   	pop    %esi
80104bc5:	5f                   	pop    %edi
80104bc6:	5d                   	pop    %ebp
80104bc7:	c3                   	ret    
80104bc8:	90                   	nop
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bd0:	83 ec 0c             	sub    $0xc,%esp
80104bd3:	53                   	push   %ebx
80104bd4:	e8 27 cd ff ff       	call   80101900 <iunlockput>
80104bd9:	83 c4 10             	add    $0x10,%esp
80104bdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bdf:	31 c0                	xor    %eax,%eax
80104be1:	5b                   	pop    %ebx
80104be2:	5e                   	pop    %esi
80104be3:	5f                   	pop    %edi
80104be4:	5d                   	pop    %ebp
80104be5:	c3                   	ret    
80104be6:	8d 76 00             	lea    0x0(%esi),%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104bf0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104bf4:	83 ec 08             	sub    $0x8,%esp
80104bf7:	50                   	push   %eax
80104bf8:	ff 37                	pushl  (%edi)
80104bfa:	e8 01 c9 ff ff       	call   80101500 <ialloc>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	89 c3                	mov    %eax,%ebx
80104c06:	0f 84 cc 00 00 00    	je     80104cd8 <create+0x188>
80104c0c:	83 ec 0c             	sub    $0xc,%esp
80104c0f:	50                   	push   %eax
80104c10:	e8 5b ca ff ff       	call   80101670 <ilock>
80104c15:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c19:	66 89 43 52          	mov    %ax,0x52(%ebx)
80104c1d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c21:	66 89 43 54          	mov    %ax,0x54(%ebx)
80104c25:	b8 01 00 00 00       	mov    $0x1,%eax
80104c2a:	66 89 43 56          	mov    %ax,0x56(%ebx)
80104c2e:	89 1c 24             	mov    %ebx,(%esp)
80104c31:	e8 8a c9 ff ff       	call   801015c0 <iupdate>
80104c36:	83 c4 10             	add    $0x10,%esp
80104c39:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c3e:	74 40                	je     80104c80 <create+0x130>
80104c40:	83 ec 04             	sub    $0x4,%esp
80104c43:	ff 73 04             	pushl  0x4(%ebx)
80104c46:	56                   	push   %esi
80104c47:	57                   	push   %edi
80104c48:	e8 b3 d1 ff ff       	call   80101e00 <dirlink>
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	85 c0                	test   %eax,%eax
80104c52:	78 77                	js     80104ccb <create+0x17b>
80104c54:	83 ec 0c             	sub    $0xc,%esp
80104c57:	57                   	push   %edi
80104c58:	e8 a3 cc ff ff       	call   80101900 <iunlockput>
80104c5d:	83 c4 10             	add    $0x10,%esp
80104c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c63:	89 d8                	mov    %ebx,%eax
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5f                   	pop    %edi
80104c68:	5d                   	pop    %ebp
80104c69:	c3                   	ret    
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c70:	31 c0                	xor    %eax,%eax
80104c72:	e9 49 ff ff ff       	jmp    80104bc0 <create+0x70>
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c80:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
80104c85:	83 ec 0c             	sub    $0xc,%esp
80104c88:	57                   	push   %edi
80104c89:	e8 32 c9 ff ff       	call   801015c0 <iupdate>
80104c8e:	83 c4 0c             	add    $0xc,%esp
80104c91:	ff 73 04             	pushl  0x4(%ebx)
80104c94:	68 24 7d 10 80       	push   $0x80107d24
80104c99:	53                   	push   %ebx
80104c9a:	e8 61 d1 ff ff       	call   80101e00 <dirlink>
80104c9f:	83 c4 10             	add    $0x10,%esp
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	78 18                	js     80104cbe <create+0x16e>
80104ca6:	83 ec 04             	sub    $0x4,%esp
80104ca9:	ff 77 04             	pushl  0x4(%edi)
80104cac:	68 23 7d 10 80       	push   $0x80107d23
80104cb1:	53                   	push   %ebx
80104cb2:	e8 49 d1 ff ff       	call   80101e00 <dirlink>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	79 82                	jns    80104c40 <create+0xf0>
80104cbe:	83 ec 0c             	sub    $0xc,%esp
80104cc1:	68 17 7d 10 80       	push   $0x80107d17
80104cc6:	e8 a5 b6 ff ff       	call   80100370 <panic>
80104ccb:	83 ec 0c             	sub    $0xc,%esp
80104cce:	68 26 7d 10 80       	push   $0x80107d26
80104cd3:	e8 98 b6 ff ff       	call   80100370 <panic>
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	68 08 7d 10 80       	push   $0x80107d08
80104ce0:	e8 8b b6 ff ff       	call   80100370 <panic>
80104ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cf0 <argfd.constprop.0>:
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
80104cf5:	89 c6                	mov    %eax,%esi
80104cf7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cfa:	89 d3                	mov    %edx,%ebx
80104cfc:	83 ec 18             	sub    $0x18,%esp
80104cff:	50                   	push   %eax
80104d00:	6a 00                	push   $0x0
80104d02:	e8 f9 fc ff ff       	call   80104a00 <argint>
80104d07:	83 c4 10             	add    $0x10,%esp
80104d0a:	85 c0                	test   %eax,%eax
80104d0c:	78 32                	js     80104d40 <argfd.constprop.0+0x50>
80104d0e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d12:	77 2c                	ja     80104d40 <argfd.constprop.0+0x50>
80104d14:	e8 27 ec ff ff       	call   80103940 <myproc>
80104d19:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d1c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104d20:	85 c0                	test   %eax,%eax
80104d22:	74 1c                	je     80104d40 <argfd.constprop.0+0x50>
80104d24:	85 f6                	test   %esi,%esi
80104d26:	74 02                	je     80104d2a <argfd.constprop.0+0x3a>
80104d28:	89 16                	mov    %edx,(%esi)
80104d2a:	85 db                	test   %ebx,%ebx
80104d2c:	74 22                	je     80104d50 <argfd.constprop.0+0x60>
80104d2e:	89 03                	mov    %eax,(%ebx)
80104d30:	31 c0                	xor    %eax,%eax
80104d32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d35:	5b                   	pop    %ebx
80104d36:	5e                   	pop    %esi
80104d37:	5d                   	pop    %ebp
80104d38:	c3                   	ret    
80104d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d48:	5b                   	pop    %ebx
80104d49:	5e                   	pop    %esi
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
80104d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d50:	31 c0                	xor    %eax,%eax
80104d52:	eb de                	jmp    80104d32 <argfd.constprop.0+0x42>
80104d54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d60 <sys_dup>:
80104d60:	55                   	push   %ebp
80104d61:	31 c0                	xor    %eax,%eax
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	56                   	push   %esi
80104d66:	53                   	push   %ebx
80104d67:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d6a:	83 ec 10             	sub    $0x10,%esp
80104d6d:	e8 7e ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104d72:	85 c0                	test   %eax,%eax
80104d74:	78 1a                	js     80104d90 <sys_dup+0x30>
80104d76:	31 db                	xor    %ebx,%ebx
80104d78:	8b 75 f4             	mov    -0xc(%ebp),%esi
80104d7b:	e8 c0 eb ff ff       	call   80103940 <myproc>
80104d80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d84:	85 d2                	test   %edx,%edx
80104d86:	74 18                	je     80104da0 <sys_dup+0x40>
80104d88:	83 c3 01             	add    $0x1,%ebx
80104d8b:	83 fb 10             	cmp    $0x10,%ebx
80104d8e:	75 f0                	jne    80104d80 <sys_dup+0x20>
80104d90:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d98:	5b                   	pop    %ebx
80104d99:	5e                   	pop    %esi
80104d9a:	5d                   	pop    %ebp
80104d9b:	c3                   	ret    
80104d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80104da4:	83 ec 0c             	sub    $0xc,%esp
80104da7:	ff 75 f4             	pushl  -0xc(%ebp)
80104daa:	e8 31 c0 ff ff       	call   80100de0 <filedup>
80104daf:	83 c4 10             	add    $0x10,%esp
80104db2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104db5:	89 d8                	mov    %ebx,%eax
80104db7:	5b                   	pop    %ebx
80104db8:	5e                   	pop    %esi
80104db9:	5d                   	pop    %ebp
80104dba:	c3                   	ret    
80104dbb:	90                   	nop
80104dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104dc0 <sys_read>:
80104dc0:	55                   	push   %ebp
80104dc1:	31 c0                	xor    %eax,%eax
80104dc3:	89 e5                	mov    %esp,%ebp
80104dc5:	83 ec 18             	sub    $0x18,%esp
80104dc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104dcb:	e8 20 ff ff ff       	call   80104cf0 <argfd.constprop.0>
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	78 4c                	js     80104e20 <sys_read+0x60>
80104dd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dd7:	83 ec 08             	sub    $0x8,%esp
80104dda:	50                   	push   %eax
80104ddb:	6a 02                	push   $0x2
80104ddd:	e8 1e fc ff ff       	call   80104a00 <argint>
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	85 c0                	test   %eax,%eax
80104de7:	78 37                	js     80104e20 <sys_read+0x60>
80104de9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dec:	83 ec 04             	sub    $0x4,%esp
80104def:	ff 75 f0             	pushl  -0x10(%ebp)
80104df2:	50                   	push   %eax
80104df3:	6a 01                	push   $0x1
80104df5:	e8 56 fc ff ff       	call   80104a50 <argptr>
80104dfa:	83 c4 10             	add    $0x10,%esp
80104dfd:	85 c0                	test   %eax,%eax
80104dff:	78 1f                	js     80104e20 <sys_read+0x60>
80104e01:	83 ec 04             	sub    $0x4,%esp
80104e04:	ff 75 f0             	pushl  -0x10(%ebp)
80104e07:	ff 75 f4             	pushl  -0xc(%ebp)
80104e0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e0d:	e8 3e c1 ff ff       	call   80100f50 <fileread>
80104e12:	83 c4 10             	add    $0x10,%esp
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    
80104e27:	89 f6                	mov    %esi,%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <sys_write>:
80104e30:	55                   	push   %ebp
80104e31:	31 c0                	xor    %eax,%eax
80104e33:	89 e5                	mov    %esp,%ebp
80104e35:	83 ec 18             	sub    $0x18,%esp
80104e38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e3b:	e8 b0 fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104e40:	85 c0                	test   %eax,%eax
80104e42:	78 4c                	js     80104e90 <sys_write+0x60>
80104e44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e47:	83 ec 08             	sub    $0x8,%esp
80104e4a:	50                   	push   %eax
80104e4b:	6a 02                	push   $0x2
80104e4d:	e8 ae fb ff ff       	call   80104a00 <argint>
80104e52:	83 c4 10             	add    $0x10,%esp
80104e55:	85 c0                	test   %eax,%eax
80104e57:	78 37                	js     80104e90 <sys_write+0x60>
80104e59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e5c:	83 ec 04             	sub    $0x4,%esp
80104e5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e62:	50                   	push   %eax
80104e63:	6a 01                	push   $0x1
80104e65:	e8 e6 fb ff ff       	call   80104a50 <argptr>
80104e6a:	83 c4 10             	add    $0x10,%esp
80104e6d:	85 c0                	test   %eax,%eax
80104e6f:	78 1f                	js     80104e90 <sys_write+0x60>
80104e71:	83 ec 04             	sub    $0x4,%esp
80104e74:	ff 75 f0             	pushl  -0x10(%ebp)
80104e77:	ff 75 f4             	pushl  -0xc(%ebp)
80104e7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e7d:	e8 5e c1 ff ff       	call   80100fe0 <filewrite>
80104e82:	83 c4 10             	add    $0x10,%esp
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <sys_close>:
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	83 ec 18             	sub    $0x18,%esp
80104ea6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ea9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104eac:	e8 3f fe ff ff       	call   80104cf0 <argfd.constprop.0>
80104eb1:	85 c0                	test   %eax,%eax
80104eb3:	78 2b                	js     80104ee0 <sys_close+0x40>
80104eb5:	e8 86 ea ff ff       	call   80103940 <myproc>
80104eba:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104ebd:	83 ec 0c             	sub    $0xc,%esp
80104ec0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ec7:	00 
80104ec8:	ff 75 f4             	pushl  -0xc(%ebp)
80104ecb:	e8 60 bf ff ff       	call   80100e30 <fileclose>
80104ed0:	83 c4 10             	add    $0x10,%esp
80104ed3:	31 c0                	xor    %eax,%eax
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ee5:	c9                   	leave  
80104ee6:	c3                   	ret    
80104ee7:	89 f6                	mov    %esi,%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <sys_fstat>:
80104ef0:	55                   	push   %ebp
80104ef1:	31 c0                	xor    %eax,%eax
80104ef3:	89 e5                	mov    %esp,%ebp
80104ef5:	83 ec 18             	sub    $0x18,%esp
80104ef8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104efb:	e8 f0 fd ff ff       	call   80104cf0 <argfd.constprop.0>
80104f00:	85 c0                	test   %eax,%eax
80104f02:	78 2c                	js     80104f30 <sys_fstat+0x40>
80104f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f07:	83 ec 04             	sub    $0x4,%esp
80104f0a:	6a 14                	push   $0x14
80104f0c:	50                   	push   %eax
80104f0d:	6a 01                	push   $0x1
80104f0f:	e8 3c fb ff ff       	call   80104a50 <argptr>
80104f14:	83 c4 10             	add    $0x10,%esp
80104f17:	85 c0                	test   %eax,%eax
80104f19:	78 15                	js     80104f30 <sys_fstat+0x40>
80104f1b:	83 ec 08             	sub    $0x8,%esp
80104f1e:	ff 75 f4             	pushl  -0xc(%ebp)
80104f21:	ff 75 f0             	pushl  -0x10(%ebp)
80104f24:	e8 d7 bf ff ff       	call   80100f00 <filestat>
80104f29:	83 c4 10             	add    $0x10,%esp
80104f2c:	c9                   	leave  
80104f2d:	c3                   	ret    
80104f2e:	66 90                	xchg   %ax,%ax
80104f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f35:	c9                   	leave  
80104f36:	c3                   	ret    
80104f37:	89 f6                	mov    %esi,%esi
80104f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f40 <sys_link>:
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
80104f46:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104f49:	83 ec 34             	sub    $0x34,%esp
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 5c fb ff ff       	call   80104ab0 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 fb 00 00 00    	js     8010505a <sys_link+0x11a>
80104f5f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f62:	83 ec 08             	sub    $0x8,%esp
80104f65:	50                   	push   %eax
80104f66:	6a 01                	push   $0x1
80104f68:	e8 43 fb ff ff       	call   80104ab0 <argstr>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	0f 88 e2 00 00 00    	js     8010505a <sys_link+0x11a>
80104f78:	e8 93 dd ff ff       	call   80102d10 <begin_op>
80104f7d:	83 ec 0c             	sub    $0xc,%esp
80104f80:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f83:	e8 38 cf ff ff       	call   80101ec0 <namei>
80104f88:	83 c4 10             	add    $0x10,%esp
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	89 c3                	mov    %eax,%ebx
80104f8f:	0f 84 f3 00 00 00    	je     80105088 <sys_link+0x148>
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	50                   	push   %eax
80104f99:	e8 d2 c6 ff ff       	call   80101670 <ilock>
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fa6:	0f 84 c4 00 00 00    	je     80105070 <sys_link+0x130>
80104fac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104fb1:	83 ec 0c             	sub    $0xc,%esp
80104fb4:	8d 7d da             	lea    -0x26(%ebp),%edi
80104fb7:	53                   	push   %ebx
80104fb8:	e8 03 c6 ff ff       	call   801015c0 <iupdate>
80104fbd:	89 1c 24             	mov    %ebx,(%esp)
80104fc0:	e8 8b c7 ff ff       	call   80101750 <iunlock>
80104fc5:	58                   	pop    %eax
80104fc6:	5a                   	pop    %edx
80104fc7:	57                   	push   %edi
80104fc8:	ff 75 d0             	pushl  -0x30(%ebp)
80104fcb:	e8 10 cf ff ff       	call   80101ee0 <nameiparent>
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	85 c0                	test   %eax,%eax
80104fd5:	89 c6                	mov    %eax,%esi
80104fd7:	74 5b                	je     80105034 <sys_link+0xf4>
80104fd9:	83 ec 0c             	sub    $0xc,%esp
80104fdc:	50                   	push   %eax
80104fdd:	e8 8e c6 ff ff       	call   80101670 <ilock>
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	8b 03                	mov    (%ebx),%eax
80104fe7:	39 06                	cmp    %eax,(%esi)
80104fe9:	75 3d                	jne    80105028 <sys_link+0xe8>
80104feb:	83 ec 04             	sub    $0x4,%esp
80104fee:	ff 73 04             	pushl  0x4(%ebx)
80104ff1:	57                   	push   %edi
80104ff2:	56                   	push   %esi
80104ff3:	e8 08 ce ff ff       	call   80101e00 <dirlink>
80104ff8:	83 c4 10             	add    $0x10,%esp
80104ffb:	85 c0                	test   %eax,%eax
80104ffd:	78 29                	js     80105028 <sys_link+0xe8>
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	56                   	push   %esi
80105003:	e8 f8 c8 ff ff       	call   80101900 <iunlockput>
80105008:	89 1c 24             	mov    %ebx,(%esp)
8010500b:	e8 90 c7 ff ff       	call   801017a0 <iput>
80105010:	e8 6b dd ff ff       	call   80102d80 <end_op>
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	31 c0                	xor    %eax,%eax
8010501a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5f                   	pop    %edi
80105020:	5d                   	pop    %ebp
80105021:	c3                   	ret    
80105022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105028:	83 ec 0c             	sub    $0xc,%esp
8010502b:	56                   	push   %esi
8010502c:	e8 cf c8 ff ff       	call   80101900 <iunlockput>
80105031:	83 c4 10             	add    $0x10,%esp
80105034:	83 ec 0c             	sub    $0xc,%esp
80105037:	53                   	push   %ebx
80105038:	e8 33 c6 ff ff       	call   80101670 <ilock>
8010503d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105042:	89 1c 24             	mov    %ebx,(%esp)
80105045:	e8 76 c5 ff ff       	call   801015c0 <iupdate>
8010504a:	89 1c 24             	mov    %ebx,(%esp)
8010504d:	e8 ae c8 ff ff       	call   80101900 <iunlockput>
80105052:	e8 29 dd ff ff       	call   80102d80 <end_op>
80105057:	83 c4 10             	add    $0x10,%esp
8010505a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010505d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105062:	5b                   	pop    %ebx
80105063:	5e                   	pop    %esi
80105064:	5f                   	pop    %edi
80105065:	5d                   	pop    %ebp
80105066:	c3                   	ret    
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105070:	83 ec 0c             	sub    $0xc,%esp
80105073:	53                   	push   %ebx
80105074:	e8 87 c8 ff ff       	call   80101900 <iunlockput>
80105079:	e8 02 dd ff ff       	call   80102d80 <end_op>
8010507e:	83 c4 10             	add    $0x10,%esp
80105081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105086:	eb 92                	jmp    8010501a <sys_link+0xda>
80105088:	e8 f3 dc ff ff       	call   80102d80 <end_op>
8010508d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105092:	eb 86                	jmp    8010501a <sys_link+0xda>
80105094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010509a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050a0 <sys_unlink>:
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	56                   	push   %esi
801050a5:	53                   	push   %ebx
801050a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
801050a9:	83 ec 54             	sub    $0x54,%esp
801050ac:	50                   	push   %eax
801050ad:	6a 00                	push   $0x0
801050af:	e8 fc f9 ff ff       	call   80104ab0 <argstr>
801050b4:	83 c4 10             	add    $0x10,%esp
801050b7:	85 c0                	test   %eax,%eax
801050b9:	0f 88 82 01 00 00    	js     80105241 <sys_unlink+0x1a1>
801050bf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801050c2:	e8 49 dc ff ff       	call   80102d10 <begin_op>
801050c7:	83 ec 08             	sub    $0x8,%esp
801050ca:	53                   	push   %ebx
801050cb:	ff 75 c0             	pushl  -0x40(%ebp)
801050ce:	e8 0d ce ff ff       	call   80101ee0 <nameiparent>
801050d3:	83 c4 10             	add    $0x10,%esp
801050d6:	85 c0                	test   %eax,%eax
801050d8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050db:	0f 84 6a 01 00 00    	je     8010524b <sys_unlink+0x1ab>
801050e1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	56                   	push   %esi
801050e8:	e8 83 c5 ff ff       	call   80101670 <ilock>
801050ed:	58                   	pop    %eax
801050ee:	5a                   	pop    %edx
801050ef:	68 24 7d 10 80       	push   $0x80107d24
801050f4:	53                   	push   %ebx
801050f5:	e8 86 ca ff ff       	call   80101b80 <namecmp>
801050fa:	83 c4 10             	add    $0x10,%esp
801050fd:	85 c0                	test   %eax,%eax
801050ff:	0f 84 fc 00 00 00    	je     80105201 <sys_unlink+0x161>
80105105:	83 ec 08             	sub    $0x8,%esp
80105108:	68 23 7d 10 80       	push   $0x80107d23
8010510d:	53                   	push   %ebx
8010510e:	e8 6d ca ff ff       	call   80101b80 <namecmp>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	0f 84 e3 00 00 00    	je     80105201 <sys_unlink+0x161>
8010511e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105121:	83 ec 04             	sub    $0x4,%esp
80105124:	50                   	push   %eax
80105125:	53                   	push   %ebx
80105126:	56                   	push   %esi
80105127:	e8 74 ca ff ff       	call   80101ba0 <dirlookup>
8010512c:	83 c4 10             	add    $0x10,%esp
8010512f:	85 c0                	test   %eax,%eax
80105131:	89 c3                	mov    %eax,%ebx
80105133:	0f 84 c8 00 00 00    	je     80105201 <sys_unlink+0x161>
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	50                   	push   %eax
8010513d:	e8 2e c5 ff ff       	call   80101670 <ilock>
80105142:	83 c4 10             	add    $0x10,%esp
80105145:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010514a:	0f 8e 24 01 00 00    	jle    80105274 <sys_unlink+0x1d4>
80105150:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105155:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105158:	74 66                	je     801051c0 <sys_unlink+0x120>
8010515a:	83 ec 04             	sub    $0x4,%esp
8010515d:	6a 10                	push   $0x10
8010515f:	6a 00                	push   $0x0
80105161:	56                   	push   %esi
80105162:	e8 89 f5 ff ff       	call   801046f0 <memset>
80105167:	6a 10                	push   $0x10
80105169:	ff 75 c4             	pushl  -0x3c(%ebp)
8010516c:	56                   	push   %esi
8010516d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105170:	e8 db c8 ff ff       	call   80101a50 <writei>
80105175:	83 c4 20             	add    $0x20,%esp
80105178:	83 f8 10             	cmp    $0x10,%eax
8010517b:	0f 85 e6 00 00 00    	jne    80105267 <sys_unlink+0x1c7>
80105181:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105186:	0f 84 9c 00 00 00    	je     80105228 <sys_unlink+0x188>
8010518c:	83 ec 0c             	sub    $0xc,%esp
8010518f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105192:	e8 69 c7 ff ff       	call   80101900 <iunlockput>
80105197:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010519c:	89 1c 24             	mov    %ebx,(%esp)
8010519f:	e8 1c c4 ff ff       	call   801015c0 <iupdate>
801051a4:	89 1c 24             	mov    %ebx,(%esp)
801051a7:	e8 54 c7 ff ff       	call   80101900 <iunlockput>
801051ac:	e8 cf db ff ff       	call   80102d80 <end_op>
801051b1:	83 c4 10             	add    $0x10,%esp
801051b4:	31 c0                	xor    %eax,%eax
801051b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b9:	5b                   	pop    %ebx
801051ba:	5e                   	pop    %esi
801051bb:	5f                   	pop    %edi
801051bc:	5d                   	pop    %ebp
801051bd:	c3                   	ret    
801051be:	66 90                	xchg   %ax,%ax
801051c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051c4:	76 94                	jbe    8010515a <sys_unlink+0xba>
801051c6:	bf 20 00 00 00       	mov    $0x20,%edi
801051cb:	eb 0f                	jmp    801051dc <sys_unlink+0x13c>
801051cd:	8d 76 00             	lea    0x0(%esi),%esi
801051d0:	83 c7 10             	add    $0x10,%edi
801051d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051d6:	0f 83 7e ff ff ff    	jae    8010515a <sys_unlink+0xba>
801051dc:	6a 10                	push   $0x10
801051de:	57                   	push   %edi
801051df:	56                   	push   %esi
801051e0:	53                   	push   %ebx
801051e1:	e8 6a c7 ff ff       	call   80101950 <readi>
801051e6:	83 c4 10             	add    $0x10,%esp
801051e9:	83 f8 10             	cmp    $0x10,%eax
801051ec:	75 6c                	jne    8010525a <sys_unlink+0x1ba>
801051ee:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051f3:	74 db                	je     801051d0 <sys_unlink+0x130>
801051f5:	83 ec 0c             	sub    $0xc,%esp
801051f8:	53                   	push   %ebx
801051f9:	e8 02 c7 ff ff       	call   80101900 <iunlockput>
801051fe:	83 c4 10             	add    $0x10,%esp
80105201:	83 ec 0c             	sub    $0xc,%esp
80105204:	ff 75 b4             	pushl  -0x4c(%ebp)
80105207:	e8 f4 c6 ff ff       	call   80101900 <iunlockput>
8010520c:	e8 6f db ff ff       	call   80102d80 <end_op>
80105211:	83 c4 10             	add    $0x10,%esp
80105214:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105217:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010521c:	5b                   	pop    %ebx
8010521d:	5e                   	pop    %esi
8010521e:	5f                   	pop    %edi
8010521f:	5d                   	pop    %ebp
80105220:	c3                   	ret    
80105221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105228:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010522b:	83 ec 0c             	sub    $0xc,%esp
8010522e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105233:	50                   	push   %eax
80105234:	e8 87 c3 ff ff       	call   801015c0 <iupdate>
80105239:	83 c4 10             	add    $0x10,%esp
8010523c:	e9 4b ff ff ff       	jmp    8010518c <sys_unlink+0xec>
80105241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105246:	e9 6b ff ff ff       	jmp    801051b6 <sys_unlink+0x116>
8010524b:	e8 30 db ff ff       	call   80102d80 <end_op>
80105250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105255:	e9 5c ff ff ff       	jmp    801051b6 <sys_unlink+0x116>
8010525a:	83 ec 0c             	sub    $0xc,%esp
8010525d:	68 48 7d 10 80       	push   $0x80107d48
80105262:	e8 09 b1 ff ff       	call   80100370 <panic>
80105267:	83 ec 0c             	sub    $0xc,%esp
8010526a:	68 5a 7d 10 80       	push   $0x80107d5a
8010526f:	e8 fc b0 ff ff       	call   80100370 <panic>
80105274:	83 ec 0c             	sub    $0xc,%esp
80105277:	68 36 7d 10 80       	push   $0x80107d36
8010527c:	e8 ef b0 ff ff       	call   80100370 <panic>
80105281:	eb 0d                	jmp    80105290 <sys_open>
80105283:	90                   	nop
80105284:	90                   	nop
80105285:	90                   	nop
80105286:	90                   	nop
80105287:	90                   	nop
80105288:	90                   	nop
80105289:	90                   	nop
8010528a:	90                   	nop
8010528b:	90                   	nop
8010528c:	90                   	nop
8010528d:	90                   	nop
8010528e:	90                   	nop
8010528f:	90                   	nop

80105290 <sys_open>:
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
80105295:	53                   	push   %ebx
80105296:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105299:	83 ec 24             	sub    $0x24,%esp
8010529c:	50                   	push   %eax
8010529d:	6a 00                	push   $0x0
8010529f:	e8 0c f8 ff ff       	call   80104ab0 <argstr>
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
801052a9:	0f 88 9e 00 00 00    	js     8010534d <sys_open+0xbd>
801052af:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052b2:	83 ec 08             	sub    $0x8,%esp
801052b5:	50                   	push   %eax
801052b6:	6a 01                	push   $0x1
801052b8:	e8 43 f7 ff ff       	call   80104a00 <argint>
801052bd:	83 c4 10             	add    $0x10,%esp
801052c0:	85 c0                	test   %eax,%eax
801052c2:	0f 88 85 00 00 00    	js     8010534d <sys_open+0xbd>
801052c8:	e8 43 da ff ff       	call   80102d10 <begin_op>
801052cd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052d1:	0f 85 89 00 00 00    	jne    80105360 <sys_open+0xd0>
801052d7:	83 ec 0c             	sub    $0xc,%esp
801052da:	ff 75 e0             	pushl  -0x20(%ebp)
801052dd:	e8 de cb ff ff       	call   80101ec0 <namei>
801052e2:	83 c4 10             	add    $0x10,%esp
801052e5:	85 c0                	test   %eax,%eax
801052e7:	89 c6                	mov    %eax,%esi
801052e9:	0f 84 8e 00 00 00    	je     8010537d <sys_open+0xed>
801052ef:	83 ec 0c             	sub    $0xc,%esp
801052f2:	50                   	push   %eax
801052f3:	e8 78 c3 ff ff       	call   80101670 <ilock>
801052f8:	83 c4 10             	add    $0x10,%esp
801052fb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105300:	0f 84 d2 00 00 00    	je     801053d8 <sys_open+0x148>
80105306:	e8 65 ba ff ff       	call   80100d70 <filealloc>
8010530b:	85 c0                	test   %eax,%eax
8010530d:	89 c7                	mov    %eax,%edi
8010530f:	74 2b                	je     8010533c <sys_open+0xac>
80105311:	31 db                	xor    %ebx,%ebx
80105313:	e8 28 e6 ff ff       	call   80103940 <myproc>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105320:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105324:	85 d2                	test   %edx,%edx
80105326:	74 68                	je     80105390 <sys_open+0x100>
80105328:	83 c3 01             	add    $0x1,%ebx
8010532b:	83 fb 10             	cmp    $0x10,%ebx
8010532e:	75 f0                	jne    80105320 <sys_open+0x90>
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	57                   	push   %edi
80105334:	e8 f7 ba ff ff       	call   80100e30 <fileclose>
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	83 ec 0c             	sub    $0xc,%esp
8010533f:	56                   	push   %esi
80105340:	e8 bb c5 ff ff       	call   80101900 <iunlockput>
80105345:	e8 36 da ff ff       	call   80102d80 <end_op>
8010534a:	83 c4 10             	add    $0x10,%esp
8010534d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105355:	5b                   	pop    %ebx
80105356:	5e                   	pop    %esi
80105357:	5f                   	pop    %edi
80105358:	5d                   	pop    %ebp
80105359:	c3                   	ret    
8010535a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105360:	83 ec 0c             	sub    $0xc,%esp
80105363:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105366:	31 c9                	xor    %ecx,%ecx
80105368:	6a 00                	push   $0x0
8010536a:	ba 02 00 00 00       	mov    $0x2,%edx
8010536f:	e8 dc f7 ff ff       	call   80104b50 <create>
80105374:	83 c4 10             	add    $0x10,%esp
80105377:	85 c0                	test   %eax,%eax
80105379:	89 c6                	mov    %eax,%esi
8010537b:	75 89                	jne    80105306 <sys_open+0x76>
8010537d:	e8 fe d9 ff ff       	call   80102d80 <end_op>
80105382:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105387:	eb 43                	jmp    801053cc <sys_open+0x13c>
80105389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105390:	83 ec 0c             	sub    $0xc,%esp
80105393:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105397:	56                   	push   %esi
80105398:	e8 b3 c3 ff ff       	call   80101750 <iunlock>
8010539d:	e8 de d9 ff ff       	call   80102d80 <end_op>
801053a2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
801053a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801053ab:	83 c4 10             	add    $0x10,%esp
801053ae:	89 77 10             	mov    %esi,0x10(%edi)
801053b1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
801053b8:	89 d0                	mov    %edx,%eax
801053ba:	83 e0 01             	and    $0x1,%eax
801053bd:	83 f0 01             	xor    $0x1,%eax
801053c0:	83 e2 03             	and    $0x3,%edx
801053c3:	88 47 08             	mov    %al,0x8(%edi)
801053c6:	0f 95 47 09          	setne  0x9(%edi)
801053ca:	89 d8                	mov    %ebx,%eax
801053cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053cf:	5b                   	pop    %ebx
801053d0:	5e                   	pop    %esi
801053d1:	5f                   	pop    %edi
801053d2:	5d                   	pop    %ebp
801053d3:	c3                   	ret    
801053d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053db:	85 c9                	test   %ecx,%ecx
801053dd:	0f 84 23 ff ff ff    	je     80105306 <sys_open+0x76>
801053e3:	e9 54 ff ff ff       	jmp    8010533c <sys_open+0xac>
801053e8:	90                   	nop
801053e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053f0 <sys_mkdir>:
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
801053f6:	e8 15 d9 ff ff       	call   80102d10 <begin_op>
801053fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053fe:	83 ec 08             	sub    $0x8,%esp
80105401:	50                   	push   %eax
80105402:	6a 00                	push   $0x0
80105404:	e8 a7 f6 ff ff       	call   80104ab0 <argstr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	78 30                	js     80105440 <sys_mkdir+0x50>
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105416:	31 c9                	xor    %ecx,%ecx
80105418:	6a 00                	push   $0x0
8010541a:	ba 01 00 00 00       	mov    $0x1,%edx
8010541f:	e8 2c f7 ff ff       	call   80104b50 <create>
80105424:	83 c4 10             	add    $0x10,%esp
80105427:	85 c0                	test   %eax,%eax
80105429:	74 15                	je     80105440 <sys_mkdir+0x50>
8010542b:	83 ec 0c             	sub    $0xc,%esp
8010542e:	50                   	push   %eax
8010542f:	e8 cc c4 ff ff       	call   80101900 <iunlockput>
80105434:	e8 47 d9 ff ff       	call   80102d80 <end_op>
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	31 c0                	xor    %eax,%eax
8010543e:	c9                   	leave  
8010543f:	c3                   	ret    
80105440:	e8 3b d9 ff ff       	call   80102d80 <end_op>
80105445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544a:	c9                   	leave  
8010544b:	c3                   	ret    
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <sys_mknod>:
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	83 ec 18             	sub    $0x18,%esp
80105456:	e8 b5 d8 ff ff       	call   80102d10 <begin_op>
8010545b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010545e:	83 ec 08             	sub    $0x8,%esp
80105461:	50                   	push   %eax
80105462:	6a 00                	push   $0x0
80105464:	e8 47 f6 ff ff       	call   80104ab0 <argstr>
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	85 c0                	test   %eax,%eax
8010546e:	78 60                	js     801054d0 <sys_mknod+0x80>
80105470:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105473:	83 ec 08             	sub    $0x8,%esp
80105476:	50                   	push   %eax
80105477:	6a 01                	push   $0x1
80105479:	e8 82 f5 ff ff       	call   80104a00 <argint>
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	85 c0                	test   %eax,%eax
80105483:	78 4b                	js     801054d0 <sys_mknod+0x80>
80105485:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105488:	83 ec 08             	sub    $0x8,%esp
8010548b:	50                   	push   %eax
8010548c:	6a 02                	push   $0x2
8010548e:	e8 6d f5 ff ff       	call   80104a00 <argint>
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 36                	js     801054d0 <sys_mknod+0x80>
8010549a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010549e:	83 ec 0c             	sub    $0xc,%esp
801054a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801054a5:	ba 03 00 00 00       	mov    $0x3,%edx
801054aa:	50                   	push   %eax
801054ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801054ae:	e8 9d f6 ff ff       	call   80104b50 <create>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	74 16                	je     801054d0 <sys_mknod+0x80>
801054ba:	83 ec 0c             	sub    $0xc,%esp
801054bd:	50                   	push   %eax
801054be:	e8 3d c4 ff ff       	call   80101900 <iunlockput>
801054c3:	e8 b8 d8 ff ff       	call   80102d80 <end_op>
801054c8:	83 c4 10             	add    $0x10,%esp
801054cb:	31 c0                	xor    %eax,%eax
801054cd:	c9                   	leave  
801054ce:	c3                   	ret    
801054cf:	90                   	nop
801054d0:	e8 ab d8 ff ff       	call   80102d80 <end_op>
801054d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054da:	c9                   	leave  
801054db:	c3                   	ret    
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_chdir>:
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
801054e5:	83 ec 10             	sub    $0x10,%esp
801054e8:	e8 53 e4 ff ff       	call   80103940 <myproc>
801054ed:	89 c6                	mov    %eax,%esi
801054ef:	e8 1c d8 ff ff       	call   80102d10 <begin_op>
801054f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054f7:	83 ec 08             	sub    $0x8,%esp
801054fa:	50                   	push   %eax
801054fb:	6a 00                	push   $0x0
801054fd:	e8 ae f5 ff ff       	call   80104ab0 <argstr>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	85 c0                	test   %eax,%eax
80105507:	78 77                	js     80105580 <sys_chdir+0xa0>
80105509:	83 ec 0c             	sub    $0xc,%esp
8010550c:	ff 75 f4             	pushl  -0xc(%ebp)
8010550f:	e8 ac c9 ff ff       	call   80101ec0 <namei>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	89 c3                	mov    %eax,%ebx
8010551b:	74 63                	je     80105580 <sys_chdir+0xa0>
8010551d:	83 ec 0c             	sub    $0xc,%esp
80105520:	50                   	push   %eax
80105521:	e8 4a c1 ff ff       	call   80101670 <ilock>
80105526:	83 c4 10             	add    $0x10,%esp
80105529:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010552e:	75 30                	jne    80105560 <sys_chdir+0x80>
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 17 c2 ff ff       	call   80101750 <iunlock>
80105539:	58                   	pop    %eax
8010553a:	ff 76 68             	pushl  0x68(%esi)
8010553d:	e8 5e c2 ff ff       	call   801017a0 <iput>
80105542:	e8 39 d8 ff ff       	call   80102d80 <end_op>
80105547:	89 5e 68             	mov    %ebx,0x68(%esi)
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	31 c0                	xor    %eax,%eax
8010554f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105552:	5b                   	pop    %ebx
80105553:	5e                   	pop    %esi
80105554:	5d                   	pop    %ebp
80105555:	c3                   	ret    
80105556:	8d 76 00             	lea    0x0(%esi),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 97 c3 ff ff       	call   80101900 <iunlockput>
80105569:	e8 12 d8 ff ff       	call   80102d80 <end_op>
8010556e:	83 c4 10             	add    $0x10,%esp
80105571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105576:	eb d7                	jmp    8010554f <sys_chdir+0x6f>
80105578:	90                   	nop
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105580:	e8 fb d7 ff ff       	call   80102d80 <end_op>
80105585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558a:	eb c3                	jmp    8010554f <sys_chdir+0x6f>
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_exec>:
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
80105595:	53                   	push   %ebx
80105596:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010559c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
801055a2:	50                   	push   %eax
801055a3:	6a 00                	push   $0x0
801055a5:	e8 06 f5 ff ff       	call   80104ab0 <argstr>
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	85 c0                	test   %eax,%eax
801055af:	78 7f                	js     80105630 <sys_exec+0xa0>
801055b1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055b7:	83 ec 08             	sub    $0x8,%esp
801055ba:	50                   	push   %eax
801055bb:	6a 01                	push   $0x1
801055bd:	e8 3e f4 ff ff       	call   80104a00 <argint>
801055c2:	83 c4 10             	add    $0x10,%esp
801055c5:	85 c0                	test   %eax,%eax
801055c7:	78 67                	js     80105630 <sys_exec+0xa0>
801055c9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055cf:	83 ec 04             	sub    $0x4,%esp
801055d2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055d8:	68 80 00 00 00       	push   $0x80
801055dd:	6a 00                	push   $0x0
801055df:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055e5:	50                   	push   %eax
801055e6:	31 db                	xor    %ebx,%ebx
801055e8:	e8 03 f1 ff ff       	call   801046f0 <memset>
801055ed:	83 c4 10             	add    $0x10,%esp
801055f0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055f6:	83 ec 08             	sub    $0x8,%esp
801055f9:	57                   	push   %edi
801055fa:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055fd:	50                   	push   %eax
801055fe:	e8 5d f3 ff ff       	call   80104960 <fetchint>
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	78 26                	js     80105630 <sys_exec+0xa0>
8010560a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105610:	85 c0                	test   %eax,%eax
80105612:	74 2c                	je     80105640 <sys_exec+0xb0>
80105614:	83 ec 08             	sub    $0x8,%esp
80105617:	56                   	push   %esi
80105618:	50                   	push   %eax
80105619:	e8 82 f3 ff ff       	call   801049a0 <fetchstr>
8010561e:	83 c4 10             	add    $0x10,%esp
80105621:	85 c0                	test   %eax,%eax
80105623:	78 0b                	js     80105630 <sys_exec+0xa0>
80105625:	83 c3 01             	add    $0x1,%ebx
80105628:	83 c6 04             	add    $0x4,%esi
8010562b:	83 fb 20             	cmp    $0x20,%ebx
8010562e:	75 c0                	jne    801055f0 <sys_exec+0x60>
80105630:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105638:	5b                   	pop    %ebx
80105639:	5e                   	pop    %esi
8010563a:	5f                   	pop    %edi
8010563b:	5d                   	pop    %ebp
8010563c:	c3                   	ret    
8010563d:	8d 76 00             	lea    0x0(%esi),%esi
80105640:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105646:	83 ec 08             	sub    $0x8,%esp
80105649:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105650:	00 00 00 00 
80105654:	50                   	push   %eax
80105655:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010565b:	e8 90 b3 ff ff       	call   801009f0 <exec>
80105660:	83 c4 10             	add    $0x10,%esp
80105663:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105666:	5b                   	pop    %ebx
80105667:	5e                   	pop    %esi
80105668:	5f                   	pop    %edi
80105669:	5d                   	pop    %ebp
8010566a:	c3                   	ret    
8010566b:	90                   	nop
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_pipe>:
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	57                   	push   %edi
80105674:	56                   	push   %esi
80105675:	53                   	push   %ebx
80105676:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105679:	83 ec 20             	sub    $0x20,%esp
8010567c:	6a 08                	push   $0x8
8010567e:	50                   	push   %eax
8010567f:	6a 00                	push   $0x0
80105681:	e8 ca f3 ff ff       	call   80104a50 <argptr>
80105686:	83 c4 10             	add    $0x10,%esp
80105689:	85 c0                	test   %eax,%eax
8010568b:	78 4a                	js     801056d7 <sys_pipe+0x67>
8010568d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105690:	83 ec 08             	sub    $0x8,%esp
80105693:	50                   	push   %eax
80105694:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105697:	50                   	push   %eax
80105698:	e8 13 dd ff ff       	call   801033b0 <pipealloc>
8010569d:	83 c4 10             	add    $0x10,%esp
801056a0:	85 c0                	test   %eax,%eax
801056a2:	78 33                	js     801056d7 <sys_pipe+0x67>
801056a4:	31 db                	xor    %ebx,%ebx
801056a6:	8b 7d e0             	mov    -0x20(%ebp),%edi
801056a9:	e8 92 e2 ff ff       	call   80103940 <myproc>
801056ae:	66 90                	xchg   %ax,%ax
801056b0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056b4:	85 f6                	test   %esi,%esi
801056b6:	74 30                	je     801056e8 <sys_pipe+0x78>
801056b8:	83 c3 01             	add    $0x1,%ebx
801056bb:	83 fb 10             	cmp    $0x10,%ebx
801056be:	75 f0                	jne    801056b0 <sys_pipe+0x40>
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	ff 75 e0             	pushl  -0x20(%ebp)
801056c6:	e8 65 b7 ff ff       	call   80100e30 <fileclose>
801056cb:	58                   	pop    %eax
801056cc:	ff 75 e4             	pushl  -0x1c(%ebp)
801056cf:	e8 5c b7 ff ff       	call   80100e30 <fileclose>
801056d4:	83 c4 10             	add    $0x10,%esp
801056d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056df:	5b                   	pop    %ebx
801056e0:	5e                   	pop    %esi
801056e1:	5f                   	pop    %edi
801056e2:	5d                   	pop    %ebp
801056e3:	c3                   	ret    
801056e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056e8:	8d 73 08             	lea    0x8(%ebx),%esi
801056eb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
801056ef:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801056f2:	e8 49 e2 ff ff       	call   80103940 <myproc>
801056f7:	31 d2                	xor    %edx,%edx
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105700:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105704:	85 c9                	test   %ecx,%ecx
80105706:	74 18                	je     80105720 <sys_pipe+0xb0>
80105708:	83 c2 01             	add    $0x1,%edx
8010570b:	83 fa 10             	cmp    $0x10,%edx
8010570e:	75 f0                	jne    80105700 <sys_pipe+0x90>
80105710:	e8 2b e2 ff ff       	call   80103940 <myproc>
80105715:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010571c:	00 
8010571d:	eb a1                	jmp    801056c0 <sys_pipe+0x50>
8010571f:	90                   	nop
80105720:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105724:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105727:	89 18                	mov    %ebx,(%eax)
80105729:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010572c:	89 50 04             	mov    %edx,0x4(%eax)
8010572f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105732:	31 c0                	xor    %eax,%eax
80105734:	5b                   	pop    %ebx
80105735:	5e                   	pop    %esi
80105736:	5f                   	pop    %edi
80105737:	5d                   	pop    %ebp
80105738:	c3                   	ret    
80105739:	66 90                	xchg   %ax,%ax
8010573b:	66 90                	xchg   %ax,%ax
8010573d:	66 90                	xchg   %ax,%ax
8010573f:	90                   	nop

80105740 <sys_fork>:
#include "mmu.h"
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105743:	5d                   	pop    %ebp
#include "proc.h"
#include <stdio.h>
int
sys_fork(void)
{
  return fork();
80105744:	e9 97 e3 ff ff       	jmp    80103ae0 <fork>
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_exit>:
}


int
sys_exit(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
  exit();
80105756:	e8 35 e7 ff ff       	call   80103e90 <exit>
  return 0;  // not reached
}
8010575b:	31 c0                	xor    %eax,%eax
8010575d:	c9                   	leave  
8010575e:	c3                   	ret    
8010575f:	90                   	nop

80105760 <sys_wait>:

int
sys_wait(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105763:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105764:	e9 67 e9 ff ff       	jmp    801040d0 <wait>
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_kill>:
}

int
sys_kill(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105776:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105779:	50                   	push   %eax
8010577a:	6a 00                	push   $0x0
8010577c:	e8 7f f2 ff ff       	call   80104a00 <argint>
80105781:	83 c4 10             	add    $0x10,%esp
80105784:	85 c0                	test   %eax,%eax
80105786:	78 18                	js     801057a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105788:	83 ec 0c             	sub    $0xc,%esp
8010578b:	ff 75 f4             	pushl  -0xc(%ebp)
8010578e:	e8 8d ea ff ff       	call   80104220 <kill>
80105793:	83 c4 10             	add    $0x10,%esp
}
80105796:	c9                   	leave  
80105797:	c3                   	ret    
80105798:	90                   	nop
80105799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801057a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801057a5:	c9                   	leave  
801057a6:	c3                   	ret    
801057a7:	89 f6                	mov    %esi,%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <sys_getpid>:

int
sys_getpid(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801057b6:	e8 85 e1 ff ff       	call   80103940 <myproc>
801057bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801057be:	c9                   	leave  
801057bf:	c3                   	ret    

801057c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801057c7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 2e f2 ff ff       	call   80104a00 <argint>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	78 27                	js     80105800 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057d9:	e8 62 e1 ff ff       	call   80103940 <myproc>
  if(growproc(n) < 0)
801057de:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801057e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057e3:	ff 75 f4             	pushl  -0xc(%ebp)
801057e6:	e8 75 e2 ff ff       	call   80103a60 <growproc>
801057eb:	83 c4 10             	add    $0x10,%esp
801057ee:	85 c0                	test   %eax,%eax
801057f0:	78 0e                	js     80105800 <sys_sbrk+0x40>
    return -1;
  return addr;
801057f2:	89 d8                	mov    %ebx,%eax
}
801057f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f7:	c9                   	leave  
801057f8:	c3                   	ret    
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105805:	eb ed                	jmp    801057f4 <sys_sbrk+0x34>
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105814:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105817:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010581a:	50                   	push   %eax
8010581b:	6a 00                	push   $0x0
8010581d:	e8 de f1 ff ff       	call   80104a00 <argint>
80105822:	83 c4 10             	add    $0x10,%esp
80105825:	85 c0                	test   %eax,%eax
80105827:	0f 88 8a 00 00 00    	js     801058b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010582d:	83 ec 0c             	sub    $0xc,%esp
80105830:	68 60 dc 14 80       	push   $0x8014dc60
80105835:	e8 46 ed ff ff       	call   80104580 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010583a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010583d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105840:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  while(ticks - ticks0 < n){
80105846:	85 d2                	test   %edx,%edx
80105848:	75 27                	jne    80105871 <sys_sleep+0x61>
8010584a:	eb 54                	jmp    801058a0 <sys_sleep+0x90>
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105850:	83 ec 08             	sub    $0x8,%esp
80105853:	68 60 dc 14 80       	push   $0x8014dc60
80105858:	68 a0 e4 14 80       	push   $0x8014e4a0
8010585d:	e8 ae e7 ff ff       	call   80104010 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105862:	a1 a0 e4 14 80       	mov    0x8014e4a0,%eax
80105867:	83 c4 10             	add    $0x10,%esp
8010586a:	29 d8                	sub    %ebx,%eax
8010586c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010586f:	73 2f                	jae    801058a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105871:	e8 ca e0 ff ff       	call   80103940 <myproc>
80105876:	8b 40 24             	mov    0x24(%eax),%eax
80105879:	85 c0                	test   %eax,%eax
8010587b:	74 d3                	je     80105850 <sys_sleep+0x40>
      release(&tickslock);
8010587d:	83 ec 0c             	sub    $0xc,%esp
80105880:	68 60 dc 14 80       	push   $0x8014dc60
80105885:	e8 16 ee ff ff       	call   801046a0 <release>
      return -1;
8010588a:	83 c4 10             	add    $0x10,%esp
8010588d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105892:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105895:	c9                   	leave  
80105896:	c3                   	ret    
80105897:	89 f6                	mov    %esi,%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	68 60 dc 14 80       	push   $0x8014dc60
801058a8:	e8 f3 ed ff ff       	call   801046a0 <release>
  return 0;
801058ad:	83 c4 10             	add    $0x10,%esp
801058b0:	31 c0                	xor    %eax,%eax
}
801058b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801058b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058bc:	eb d4                	jmp    80105892 <sys_sleep+0x82>
801058be:	66 90                	xchg   %ax,%ax

801058c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	53                   	push   %ebx
801058c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058c7:	68 60 dc 14 80       	push   $0x8014dc60
801058cc:	e8 af ec ff ff       	call   80104580 <acquire>
  xticks = ticks;
801058d1:	8b 1d a0 e4 14 80    	mov    0x8014e4a0,%ebx
  release(&tickslock);
801058d7:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
801058de:	e8 bd ed ff ff       	call   801046a0 <release>
  return xticks;
}
801058e3:	89 d8                	mov    %ebx,%eax
801058e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058e8:	c9                   	leave  
801058e9:	c3                   	ret    
801058ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058f0 <sys_date>:

int
sys_date(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 1c             	sub    $0x1c,%esp
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
801058f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058f9:	6a 04                	push   $0x4
801058fb:	50                   	push   %eax
801058fc:	6a 00                	push   $0x0
801058fe:	e8 4d f1 ff ff       	call   80104a50 <argptr>
80105903:	83 c4 10             	add    $0x10,%esp
80105906:	85 c0                	test   %eax,%eax
80105908:	78 16                	js     80105920 <sys_date+0x30>
   {
    return -1;
   }
  cmostime((struct rtcdate *)ptr);
8010590a:	83 ec 0c             	sub    $0xc,%esp
8010590d:	ff 75 f4             	pushl  -0xc(%ebp)
80105910:	e8 7b d0 ff ff       	call   80102990 <cmostime>
  return 0;
80105915:	83 c4 10             	add    $0x10,%esp
80105918:	31 c0                	xor    %eax,%eax

}
8010591a:	c9                   	leave  
8010591b:	c3                   	ret    
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_date(void)
{
  char *ptr;
  if(argptr(0, &ptr, sizeof(struct rtcdate*)) < 0 )
   {
    return -1;
80105920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   }
  cmostime((struct rtcdate *)ptr);
  return 0;

}
80105925:	c9                   	leave  
80105926:	c3                   	ret    
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <sys_virt2real>:

int
sys_virt2real(char *va)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	53                   	push   %ebx
80105934:	83 ec 04             	sub    $0x4,%esp
80105937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010593a:	e8 01 e0 ff ff       	call   80103940 <myproc>
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010593f:	8b 40 04             	mov    0x4(%eax),%eax
80105942:	89 da                	mov    %ebx,%edx
80105944:	c1 ea 16             	shr    $0x16,%edx
80105947:	8b 14 90             	mov    (%eax,%edx,4),%edx
  pgtab = &pgtab[PTX(va)];
  return (int)(P2V(PTE_ADDR(pgtab) + PTE_FLAGS(va)));
8010594a:	89 d8                	mov    %ebx,%eax

}
8010594c:	83 c4 04             	add    $0x4,%esp
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  pgtab = &pgtab[PTX(va)];
  return (int)(P2V(PTE_ADDR(pgtab) + PTE_FLAGS(va)));
8010594f:	c1 e8 0a             	shr    $0xa,%eax
80105952:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80105958:	25 fc 0f 00 00       	and    $0xffc,%eax
{
  struct proc *curproc = myproc();
  pde_t *pde;
  pte_t *pgtab;
  pde = &(curproc->pgdir)[PDX(va)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010595d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  pgtab = &pgtab[PTX(va)];
  return (int)(P2V(PTE_ADDR(pgtab) + PTE_FLAGS(va)));
80105963:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
8010596a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010596f:	8d 84 18 00 00 00 80 	lea    -0x80000000(%eax,%ebx,1),%eax

}
80105976:	5b                   	pop    %ebx
80105977:	5d                   	pop    %ebp
80105978:	c3                   	ret    
80105979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_num_pages>:

int
sys_num_pages(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105986:	e8 b5 df ff ff       	call   80103940 <myproc>
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
801059a4:	e9 57 e2 ff ff       	jmp    80103c00 <forkcow>

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
80105a29:	68 69 7d 10 80       	push   $0x80107d69
80105a2e:	68 60 dc 14 80       	push   $0x8014dc60
80105a33:	66 89 15 a2 de 14 80 	mov    %dx,0x8014dea2
80105a3a:	c6 05 a4 de 14 80 00 	movb   $0x0,0x8014dea4
80105a41:	66 a3 a0 de 14 80    	mov    %ax,0x8014dea0
80105a47:	c1 e8 10             	shr    $0x10,%eax
80105a4a:	c6 05 a5 de 14 80 ef 	movb   $0xef,0x8014dea5
80105a51:	66 a3 a6 de 14 80    	mov    %ax,0x8014dea6
80105a57:	e8 24 ea ff ff       	call   80104480 <initlock>
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
80105ac0:	ff 24 85 10 7e 10 80 	jmp    *-0x7fef81f0(,%eax,4)
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ad0:	e8 6b de ff ff       	call   80103940 <myproc>
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	0f 84 f7 01 00 00    	je     80105cd4 <trap+0x234>
80105add:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105ae1:	0f 84 ed 01 00 00    	je     80105cd4 <trap+0x234>
80105ae7:	0f 20 d1             	mov    %cr2,%ecx
80105aea:	8b 57 38             	mov    0x38(%edi),%edx
80105aed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105af0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105af3:	e8 28 de ff ff       	call   80103920 <cpuid>
80105af8:	8b 77 34             	mov    0x34(%edi),%esi
80105afb:	8b 5f 30             	mov    0x30(%edi),%ebx
80105afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105b01:	e8 3a de ff ff       	call   80103940 <myproc>
80105b06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b09:	e8 32 de ff ff       	call   80103940 <myproc>
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
80105b25:	68 cc 7d 10 80       	push   $0x80107dcc
80105b2a:	e8 31 ab ff ff       	call   80100660 <cprintf>
80105b2f:	83 c4 20             	add    $0x20,%esp
80105b32:	e8 09 de ff ff       	call   80103940 <myproc>
80105b37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105b3e:	66 90                	xchg   %ax,%ax
80105b40:	e8 fb dd ff ff       	call   80103940 <myproc>
80105b45:	85 c0                	test   %eax,%eax
80105b47:	74 0c                	je     80105b55 <trap+0xb5>
80105b49:	e8 f2 dd ff ff       	call   80103940 <myproc>
80105b4e:	8b 50 24             	mov    0x24(%eax),%edx
80105b51:	85 d2                	test   %edx,%edx
80105b53:	75 4b                	jne    80105ba0 <trap+0x100>
80105b55:	e8 e6 dd ff ff       	call   80103940 <myproc>
80105b5a:	85 c0                	test   %eax,%eax
80105b5c:	74 0b                	je     80105b69 <trap+0xc9>
80105b5e:	e8 dd dd ff ff       	call   80103940 <myproc>
80105b63:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b67:	74 4f                	je     80105bb8 <trap+0x118>
80105b69:	e8 d2 dd ff ff       	call   80103940 <myproc>
80105b6e:	85 c0                	test   %eax,%eax
80105b70:	74 1d                	je     80105b8f <trap+0xef>
80105b72:	e8 c9 dd ff ff       	call   80103940 <myproc>
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
80105bad:	e8 de e2 ff ff       	call   80103e90 <exit>
80105bb2:	eb a1                	jmp    80105b55 <trap+0xb5>
80105bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bb8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105bbc:	75 ab                	jne    80105b69 <trap+0xc9>
80105bbe:	e8 fd e3 ff ff       	call   80103fc0 <yield>
80105bc3:	eb a4                	jmp    80105b69 <trap+0xc9>
80105bc5:	8d 76 00             	lea    0x0(%esi),%esi
80105bc8:	83 ec 0c             	sub    $0xc,%esp
80105bcb:	ff 77 34             	pushl  0x34(%edi)
80105bce:	e8 ed 17 00 00       	call   801073c0 <pagefault>
80105bd3:	83 c4 10             	add    $0x10,%esp
80105bd6:	e9 65 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bdb:	90                   	nop
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105be0:	e8 3b dd ff ff       	call   80103920 <cpuid>
80105be5:	85 c0                	test   %eax,%eax
80105be7:	0f 84 b3 00 00 00    	je     80105ca0 <trap+0x200>
80105bed:	e8 de cc ff ff       	call   801028d0 <lapiceoi>
80105bf2:	e9 49 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c00:	e8 8b cb ff ff       	call   80102790 <kbdintr>
80105c05:	e8 c6 cc ff ff       	call   801028d0 <lapiceoi>
80105c0a:	e9 31 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105c0f:	90                   	nop
80105c10:	e8 5b 02 00 00       	call   80105e70 <uartintr>
80105c15:	e8 b6 cc ff ff       	call   801028d0 <lapiceoi>
80105c1a:	e9 21 ff ff ff       	jmp    80105b40 <trap+0xa0>
80105c1f:	90                   	nop
80105c20:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c24:	8b 77 38             	mov    0x38(%edi),%esi
80105c27:	e8 f4 dc ff ff       	call   80103920 <cpuid>
80105c2c:	56                   	push   %esi
80105c2d:	53                   	push   %ebx
80105c2e:	50                   	push   %eax
80105c2f:	68 74 7d 10 80       	push   $0x80107d74
80105c34:	e8 27 aa ff ff       	call   80100660 <cprintf>
80105c39:	e8 92 cc ff ff       	call   801028d0 <lapiceoi>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	e9 fa fe ff ff       	jmp    80105b40 <trap+0xa0>
80105c46:	8d 76 00             	lea    0x0(%esi),%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c50:	e8 fb c3 ff ff       	call   80102050 <ideintr>
80105c55:	eb 96                	jmp    80105bed <trap+0x14d>
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c60:	e8 db dc ff ff       	call   80103940 <myproc>
80105c65:	8b 58 24             	mov    0x24(%eax),%ebx
80105c68:	85 db                	test   %ebx,%ebx
80105c6a:	75 2c                	jne    80105c98 <trap+0x1f8>
80105c6c:	e8 cf dc ff ff       	call   80103940 <myproc>
80105c71:	89 78 18             	mov    %edi,0x18(%eax)
80105c74:	e8 77 ee ff ff       	call   80104af0 <syscall>
80105c79:	e8 c2 dc ff ff       	call   80103940 <myproc>
80105c7e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c81:	85 c9                	test   %ecx,%ecx
80105c83:	0f 84 06 ff ff ff    	je     80105b8f <trap+0xef>
80105c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c8c:	5b                   	pop    %ebx
80105c8d:	5e                   	pop    %esi
80105c8e:	5f                   	pop    %edi
80105c8f:	5d                   	pop    %ebp
80105c90:	e9 fb e1 ff ff       	jmp    80103e90 <exit>
80105c95:	8d 76 00             	lea    0x0(%esi),%esi
80105c98:	e8 f3 e1 ff ff       	call   80103e90 <exit>
80105c9d:	eb cd                	jmp    80105c6c <trap+0x1cc>
80105c9f:	90                   	nop
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	68 60 dc 14 80       	push   $0x8014dc60
80105ca8:	e8 d3 e8 ff ff       	call   80104580 <acquire>
80105cad:	c7 04 24 a0 e4 14 80 	movl   $0x8014e4a0,(%esp)
80105cb4:	83 05 a0 e4 14 80 01 	addl   $0x1,0x8014e4a0
80105cbb:	e8 00 e5 ff ff       	call   801041c0 <wakeup>
80105cc0:	c7 04 24 60 dc 14 80 	movl   $0x8014dc60,(%esp)
80105cc7:	e8 d4 e9 ff ff       	call   801046a0 <release>
80105ccc:	83 c4 10             	add    $0x10,%esp
80105ccf:	e9 19 ff ff ff       	jmp    80105bed <trap+0x14d>
80105cd4:	0f 20 d6             	mov    %cr2,%esi
80105cd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105cda:	e8 41 dc ff ff       	call   80103920 <cpuid>
80105cdf:	83 ec 0c             	sub    $0xc,%esp
80105ce2:	56                   	push   %esi
80105ce3:	53                   	push   %ebx
80105ce4:	50                   	push   %eax
80105ce5:	ff 77 30             	pushl  0x30(%edi)
80105ce8:	68 98 7d 10 80       	push   $0x80107d98
80105ced:	e8 6e a9 ff ff       	call   80100660 <cprintf>
80105cf2:	83 c4 14             	add    $0x14,%esp
80105cf5:	68 6e 7d 10 80       	push   $0x80107d6e
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
80105d55:	e8 96 cb ff ff       	call   801028f0 <microdelay>
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
80105def:	bb d8 7e 10 80       	mov    $0x80107ed8,%ebx
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
  //cprintf("walkpgdir in\n");
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
  //cprintf("walkpgdir in\n");
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
  //cprintf("walkpgdir in\n");
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106940:	85 c9                	test   %ecx,%ecx
80106942:	74 2c                	je     80106970 <walkpgdir+0x70>
80106944:	e8 b7 bb ff ff       	call   80102500 <kalloc>
80106949:	85 c0                	test   %eax,%eax
8010694b:	89 c6                	mov    %eax,%esi
8010694d:	74 21                	je     80106970 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    //cprintf("memset in\n");
    memset(pgtab, 0, PGSIZE);
8010694f:	83 ec 04             	sub    $0x4,%esp
80106952:	68 00 10 00 00       	push   $0x1000
80106957:	6a 00                	push   $0x0
80106959:	50                   	push   %eax
8010695a:	e8 91 dd ff ff       	call   801046f0 <memset>
    //cprintf("memset out\n");
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
801069fd:	68 e0 7e 10 80       	push   $0x80107ee0
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
80106aa2:	68 06 78 10 80       	push   $0x80107806
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
80106ab6:	e8 65 ce ff ff       	call   80103920 <cpuid>
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
80106bfa:	e8 41 d9 ff ff       	call   80104540 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bff:	e8 9c cc ff ff       	call   801038a0 <mycpu>
80106c04:	89 c3                	mov    %eax,%ebx
80106c06:	e8 95 cc ff ff       	call   801038a0 <mycpu>
80106c0b:	89 c7                	mov    %eax,%edi
80106c0d:	e8 8e cc ff ff       	call   801038a0 <mycpu>
80106c12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c15:	83 c7 08             	add    $0x8,%edi
80106c18:	e8 83 cc ff ff       	call   801038a0 <mycpu>
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
80106c5e:	e8 3d cc ff ff       	call   801038a0 <mycpu>
80106c63:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c6a:	e8 31 cc ff ff       	call   801038a0 <mycpu>
80106c6f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c74:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c78:	e8 23 cc ff ff       	call   801038a0 <mycpu>
80106c7d:	8b 56 08             	mov    0x8(%esi),%edx
80106c80:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c86:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c89:	e8 12 cc ff ff       	call   801038a0 <mycpu>
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
80106cac:	e9 7f d9 ff ff       	jmp    80104630 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106cb1:	83 ec 0c             	sub    $0xc,%esp
80106cb4:	68 e6 7e 10 80       	push   $0x80107ee6
80106cb9:	e8 b2 96 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106cbe:	83 ec 0c             	sub    $0xc,%esp
80106cc1:	68 11 7f 10 80       	push   $0x80107f11
80106cc6:	e8 a5 96 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106ccb:	83 ec 0c             	sub    $0xc,%esp
80106cce:	68 fc 7e 10 80       	push   $0x80107efc
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
80106cfd:	e8 fe b7 ff ff       	call   80102500 <kalloc>
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
80106d0f:	e8 dc d9 ff ff       	call   801046f0 <memset>
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
80106d41:	e9 5a da ff ff       	jmp    801047a0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106d46:	83 ec 0c             	sub    $0xc,%esp
80106d49:	68 25 7f 10 80       	push   $0x80107f25
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
80106dfd:	68 3f 7f 10 80       	push   $0x80107f3f
80106e02:	e8 69 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106e07:	83 ec 0c             	sub    $0xc,%esp
80106e0a:	68 80 80 10 80       	push   $0x80108080
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
80106e63:	e8 88 d8 ff ff       	call   801046f0 <memset>
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
80106e93:	e8 68 b6 ff ff       	call   80102500 <kalloc>
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
80106ea1:	68 5d 7f 10 80       	push   $0x80107f5d
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
80106ed3:	68 75 7f 10 80       	push   $0x80107f75
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
80106fbc:	68 91 7f 10 80       	push   $0x80107f91
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
80106fd5:	e8 26 b5 ff ff       	call   80102500 <kalloc>
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
80106ff0:	e8 fb d6 ff ff       	call   801046f0 <memset>
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
8010708f:	68 a2 7f 10 80       	push   $0x80107fa2
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
801070e0:	e8 bb d6 ff ff       	call   801047a0 <memmove>
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
8010713a:	e8 c1 b3 ff ff       	call   80102500 <kalloc>
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
80107172:	68 c6 7f 10 80       	push   $0x80107fc6
80107177:	e8 f4 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010717c:	83 ec 0c             	sub    $0xc,%esp
8010717f:	68 ac 7f 10 80       	push   $0x80107fac
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
80107196:	83 ec 14             	sub    $0x14,%esp
  //cprintf("entrou no copyuvmcow\n");
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags; 
  cprintf("sz = %d\n", sz);
80107199:	ff 75 0c             	pushl  0xc(%ebp)
8010719c:	68 e0 7f 10 80       	push   $0x80107fe0
801071a1:	e8 ba 94 ff ff       	call   80100660 <cprintf>

  if((d = setupkvm()) == 0)
801071a6:	e8 25 fe ff ff       	call   80106fd0 <setupkvm>
801071ab:	83 c4 10             	add    $0x10,%esp
801071ae:	85 c0                	test   %eax,%eax
801071b0:	0f 84 ff 00 00 00    	je     801072b5 <copyuvmcow+0x125>
801071b6:	89 c7                	mov    %eax,%edi
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801071bb:	31 f6                	xor    %esi,%esi
801071bd:	85 c0                	test   %eax,%eax
801071bf:	75 58                	jne    80107219 <copyuvmcow+0x89>
801071c1:	e9 da 00 00 00       	jmp    801072a0 <copyuvmcow+0x110>
801071c6:	8d 76 00             	lea    0x0(%esi),%esi
801071c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *pte |= PTE_COW;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    cprintf("Copyuvmcow: antes %d para %d\n", pa, getRefCount(pa));
801071d0:	83 ec 0c             	sub    $0xc,%esp
  uint pa, i, flags; 
  cprintf("sz = %d\n", sz);

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071d3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    *pte |= PTE_COW;
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
      goto bad;
    cprintf("Copyuvmcow: antes %d para %d\n", pa, getRefCount(pa));
801071d9:	53                   	push   %ebx
801071da:	e8 81 b4 ff ff       	call   80102660 <getRefCount>
801071df:	83 c4 0c             	add    $0xc,%esp
801071e2:	50                   	push   %eax
801071e3:	53                   	push   %ebx
801071e4:	68 00 80 10 80       	push   $0x80108000
801071e9:	e8 72 94 ff ff       	call   80100660 <cprintf>
    addRefCount(pa);
801071ee:	89 1c 24             	mov    %ebx,(%esp)
801071f1:	e8 aa b3 ff ff       	call   801025a0 <addRefCount>
    cprintf("Copyuvmcow: depois %d para %d\n", pa, getRefCount(pa));
801071f6:	89 1c 24             	mov    %ebx,(%esp)
801071f9:	e8 62 b4 ff ff       	call   80102660 <getRefCount>
801071fe:	83 c4 0c             	add    $0xc,%esp
80107201:	50                   	push   %eax
80107202:	53                   	push   %ebx
80107203:	68 a4 80 10 80       	push   $0x801080a4
80107208:	e8 53 94 ff ff       	call   80100660 <cprintf>
  uint pa, i, flags; 
  cprintf("sz = %d\n", sz);

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010720d:	83 c4 10             	add    $0x10,%esp
80107210:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107213:	0f 86 87 00 00 00    	jbe    801072a0 <copyuvmcow+0x110>
    cprintf("for \n");
80107219:	83 ec 0c             	sub    $0xc,%esp
8010721c:	68 e9 7f 10 80       	push   $0x80107fe9
80107221:	e8 3a 94 ff ff       	call   80100660 <cprintf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107226:	8b 45 08             	mov    0x8(%ebp),%eax
80107229:	31 c9                	xor    %ecx,%ecx
8010722b:	89 f2                	mov    %esi,%edx
8010722d:	e8 ce f6 ff ff       	call   80106900 <walkpgdir>
80107232:	83 c4 10             	add    $0x10,%esp
80107235:	85 c0                	test   %eax,%eax
80107237:	0f 84 89 00 00 00    	je     801072c6 <copyuvmcow+0x136>
    {
      cprintf("walkpgdir error\n");
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
8010723d:	8b 10                	mov    (%eax),%edx
8010723f:	f6 c2 01             	test   $0x1,%dl
80107242:	74 75                	je     801072b9 <copyuvmcow+0x129>
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
80107244:	89 d1                	mov    %edx,%ecx
80107246:	89 d3                	mov    %edx,%ebx
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107248:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
8010724e:	83 e1 fd             	and    $0xfffffffd,%ecx
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107251:	83 ec 08             	sub    $0x8,%esp
80107254:	80 ce 02             	or     $0x2,%dh
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    *pte &= ~PTE_W;
    *pte |= PTE_COW;
80107257:	80 cd 02             	or     $0x2,%ch
8010725a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107260:	89 08                	mov    %ecx,(%eax)
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0)
80107262:	52                   	push   %edx
80107263:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107268:	53                   	push   %ebx
80107269:	89 f2                	mov    %esi,%edx
8010726b:	89 f8                	mov    %edi,%eax
8010726d:	e8 0e f7 ff ff       	call   80106980 <mappages>
80107272:	83 c4 10             	add    $0x10,%esp
80107275:	85 c0                	test   %eax,%eax
80107277:	0f 89 53 ff ff ff    	jns    801071d0 <copyuvmcow+0x40>
  lcr3(V2P(pgdir));
  return d;

bad:
  //cprintf("deu ruim\n");
  freevm(d);
8010727d:	83 ec 0c             	sub    $0xc,%esp
80107280:	57                   	push   %edi
80107281:	e8 ca fc ff ff       	call   80106f50 <freevm>
80107286:	8b 45 08             	mov    0x8(%ebp),%eax
80107289:	05 00 00 00 80       	add    $0x80000000,%eax
8010728e:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(pgdir));
  return 0;
80107291:	31 c0                	xor    %eax,%eax
80107293:	83 c4 10             	add    $0x10,%esp
}
80107296:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107299:	5b                   	pop    %ebx
8010729a:	5e                   	pop    %esi
8010729b:	5f                   	pop    %edi
8010729c:	5d                   	pop    %ebp
8010729d:	c3                   	ret    
8010729e:	66 90                	xchg   %ax,%ax
801072a0:	8b 45 08             	mov    0x8(%ebp),%eax
801072a3:	05 00 00 00 80       	add    $0x80000000,%eax
801072a8:	0f 22 d8             	mov    %eax,%cr3
801072ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
    addRefCount(pa);
    cprintf("Copyuvmcow: depois %d para %d\n", pa, getRefCount(pa));
  }
  //cprintf("chamou flush da TLB\n");
  lcr3(V2P(pgdir));
  return d;
801072ae:	89 f8                	mov    %edi,%eax
bad:
  //cprintf("deu ruim\n");
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
801072b0:	5b                   	pop    %ebx
801072b1:	5e                   	pop    %esi
801072b2:	5f                   	pop    %edi
801072b3:	5d                   	pop    %ebp
801072b4:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags; 
  cprintf("sz = %d\n", sz);

  if((d = setupkvm()) == 0)
    return 0;
801072b5:	31 c0                	xor    %eax,%eax
801072b7:	eb dd                	jmp    80107296 <copyuvmcow+0x106>
    {
      cprintf("walkpgdir error\n");
      panic("copyuvm: pte should exist");
    }
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801072b9:	83 ec 0c             	sub    $0xc,%esp
801072bc:	68 c6 7f 10 80       	push   $0x80107fc6
801072c1:	e8 aa 90 ff ff       	call   80100370 <panic>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    cprintf("for \n");
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
    {
      cprintf("walkpgdir error\n");
801072c6:	83 ec 0c             	sub    $0xc,%esp
801072c9:	68 ef 7f 10 80       	push   $0x80107fef
801072ce:	e8 8d 93 ff ff       	call   80100660 <cprintf>
      panic("copyuvm: pte should exist");
801072d3:	c7 04 24 ac 7f 10 80 	movl   $0x80107fac,(%esp)
801072da:	e8 91 90 ff ff       	call   80100370 <panic>
801072df:	90                   	nop

801072e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801072e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801072e1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801072e3:	89 e5                	mov    %esp,%ebp
801072e5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801072e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801072eb:	8b 45 08             	mov    0x8(%ebp),%eax
801072ee:	e8 0d f6 ff ff       	call   80106900 <walkpgdir>
  if((*pte & PTE_P) == 0)
801072f3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801072f5:	89 c2                	mov    %eax,%edx
801072f7:	83 e2 05             	and    $0x5,%edx
801072fa:	83 fa 05             	cmp    $0x5,%edx
801072fd:	75 11                	jne    80107310 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801072ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107304:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107305:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010730a:	c3                   	ret    
8010730b:	90                   	nop
8010730c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107310:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107312:	c9                   	leave  
80107313:	c3                   	ret    
80107314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010731a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107320 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	57                   	push   %edi
80107324:	56                   	push   %esi
80107325:	53                   	push   %ebx
80107326:	83 ec 1c             	sub    $0x1c,%esp
80107329:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010732c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010732f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107332:	85 db                	test   %ebx,%ebx
80107334:	75 40                	jne    80107376 <copyout+0x56>
80107336:	eb 70                	jmp    801073a8 <copyout+0x88>
80107338:	90                   	nop
80107339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107340:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107343:	89 f1                	mov    %esi,%ecx
80107345:	29 d1                	sub    %edx,%ecx
80107347:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010734d:	39 d9                	cmp    %ebx,%ecx
8010734f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107352:	29 f2                	sub    %esi,%edx
80107354:	83 ec 04             	sub    $0x4,%esp
80107357:	01 d0                	add    %edx,%eax
80107359:	51                   	push   %ecx
8010735a:	57                   	push   %edi
8010735b:	50                   	push   %eax
8010735c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010735f:	e8 3c d4 ff ff       	call   801047a0 <memmove>
    len -= n;
    buf += n;
80107364:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107367:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010736a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107370:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107372:	29 cb                	sub    %ecx,%ebx
80107374:	74 32                	je     801073a8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107376:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107378:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010737b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010737e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107384:	56                   	push   %esi
80107385:	ff 75 08             	pushl  0x8(%ebp)
80107388:	e8 53 ff ff ff       	call   801072e0 <uva2ka>
    if(pa0 == 0)
8010738d:	83 c4 10             	add    $0x10,%esp
80107390:	85 c0                	test   %eax,%eax
80107392:	75 ac                	jne    80107340 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107394:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107397:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010739c:	5b                   	pop    %ebx
8010739d:	5e                   	pop    %esi
8010739e:	5f                   	pop    %edi
8010739f:	5d                   	pop    %ebp
801073a0:	c3                   	ret    
801073a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801073ab:	31 c0                	xor    %eax,%eax
}
801073ad:	5b                   	pop    %ebx
801073ae:	5e                   	pop    %esi
801073af:	5f                   	pop    %edi
801073b0:	5d                   	pop    %ebp
801073b1:	c3                   	ret    
801073b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073c0 <pagefault>:
//PAGEBREAK!
// Blank page.

void 
pagefault(uint error)
{
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
801073c6:	83 ec 1c             	sub    $0x1c,%esp
801073c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct proc *cur = myproc();
801073cc:	e8 6f c5 ff ff       	call   80103940 <myproc>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801073d1:	0f 20 d6             	mov    %cr2,%esi
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
    if(!(error & 0x02)){cprintf("Nao e erro de escrita.");return;}
801073d4:	83 e7 02             	and    $0x2,%edi
801073d7:	74 6f                	je     80107448 <pagefault+0x88>
  if(cur ==0)
801073d9:	85 c0                	test   %eax,%eax
801073db:	89 c3                	mov    %eax,%ebx
801073dd:	0f 84 85 01 00 00    	je     80107568 <pagefault+0x1a8>
  {
    cprintf( "Page fault occured but it was not the user process\n");
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)a, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U))
801073e3:	85 f6                	test   %esi,%esi
801073e5:	78 24                	js     8010740b <pagefault+0x4b>
801073e7:	8b 40 04             	mov    0x4(%eax),%eax
801073ea:	89 f2                	mov    %esi,%edx
801073ec:	31 c9                	xor    %ecx,%ecx
801073ee:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801073f4:	e8 07 f5 ff ff       	call   80106900 <walkpgdir>
801073f9:	85 c0                	test   %eax,%eax
801073fb:	89 c7                	mov    %eax,%edi
801073fd:	74 0c                	je     8010740b <pagefault+0x4b>
801073ff:	8b 00                	mov    (%eax),%eax
80107401:	89 c2                	mov    %eax,%edx
80107403:	83 e2 05             	and    $0x5,%edx
80107406:	83 fa 05             	cmp    $0x5,%edx
80107409:	74 25                	je     80107430 <pagefault+0x70>
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
     va, cur->name, cur->pid);
8010740b:	8d 43 6c             	lea    0x6c(%ebx),%eax
    panic("pagefault");
  }

  if(va >= KERNBASE || (pte = walkpgdir(cur->pgdir, (void*)a, 0)) == 0  || !(*pte & PTE_P) || !(*pte & PTE_U))
  {
    cprintf("Acesso ao endereço virtual restrito no endereço 0x%x, kill processo %s de pid %d\n",
8010740e:	ff 73 10             	pushl  0x10(%ebx)
80107411:	50                   	push   %eax
80107412:	56                   	push   %esi
80107413:	68 f8 80 10 80       	push   $0x801080f8
80107418:	e8 43 92 ff ff       	call   80100660 <cprintf>
     va, cur->name, cur->pid);
    cur->killed = 1;
8010741d:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
    return;
80107424:	83 c4 10             	add    $0x10,%esp
  }
  else
  {
    cur->killed = 1; return;
  }
}
80107427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010742a:	5b                   	pop    %ebx
8010742b:	5e                   	pop    %esi
8010742c:	5f                   	pop    %edi
8010742d:	5d                   	pop    %ebp
8010742e:	c3                   	ret    
8010742f:	90                   	nop
     va, cur->name, cur->pid);
    cur->killed = 1;
    return;
  }
  
  if(*pte & PTE_COW)
80107430:	f6 c4 02             	test   $0x2,%ah
80107433:	75 2b                	jne    80107460 <pagefault+0xa0>

      lcr3(V2P(cur->pgdir));
  }
  else
  {
    cur->killed = 1; return;
80107435:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
  }
}
8010743c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010743f:	5b                   	pop    %ebx
80107440:	5e                   	pop    %esi
80107441:	5f                   	pop    %edi
80107442:	5d                   	pop    %ebp
80107443:	c3                   	ret    
80107444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct proc *cur = myproc();
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
    if(!(error & 0x02)){cprintf("Nao e erro de escrita.");return;}
80107448:	c7 45 08 1e 80 10 80 	movl   $0x8010801e,0x8(%ebp)
  }
  else
  {
    cur->killed = 1; return;
  }
}
8010744f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107452:	5b                   	pop    %ebx
80107453:	5e                   	pop    %esi
80107454:	5f                   	pop    %edi
80107455:	5d                   	pop    %ebp
{
  struct proc *cur = myproc();
  uint va = rcr2();
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
    if(!(error & 0x02)){cprintf("Nao e erro de escrita.");return;}
80107456:	e9 05 92 ff ff       	jmp    80100660 <cprintf>
8010745b:	90                   	nop
8010745c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  
  if(*pte & PTE_COW)
    {
      uint physicalAdress = PTE_ADDR(*pte);
      cprintf("pa %d do proc %d\n", physicalAdress, cur->pid);
80107460:	83 ec 04             	sub    $0x4,%esp
    return;
  }
  
  if(*pte & PTE_COW)
    {
      uint physicalAdress = PTE_ADDR(*pte);
80107463:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      cprintf("pa %d do proc %d\n", physicalAdress, cur->pid);
80107468:	ff 73 10             	pushl  0x10(%ebx)
8010746b:	50                   	push   %eax
8010746c:	68 3f 80 10 80       	push   $0x8010803f
    return;
  }
  
  if(*pte & PTE_COW)
    {
      uint physicalAdress = PTE_ADDR(*pte);
80107471:	89 c6                	mov    %eax,%esi
      cprintf("pa %d do proc %d\n", physicalAdress, cur->pid);
80107473:	e8 e8 91 ff ff       	call   80100660 <cprintf>
      uint refCount = getRefCount(physicalAdress);
80107478:	89 34 24             	mov    %esi,(%esp)
8010747b:	e8 e0 b1 ff ff       	call   80102660 <getRefCount>
      cprintf("ref count :%x\n", refCount);
80107480:	5a                   	pop    %edx
80107481:	59                   	pop    %ecx
80107482:	50                   	push   %eax
80107483:	68 51 80 10 80       	push   $0x80108051
80107488:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010748b:	e8 d0 91 ff ff       	call   80100660 <cprintf>
      char* mem;

      if(refCount > 1)
80107490:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107493:	83 c4 10             	add    $0x10,%esp
80107496:	83 f8 01             	cmp    $0x1,%eax
80107499:	0f 86 91 00 00 00    	jbe    80107530 <pagefault+0x170>
      {

          if((mem = kalloc()) == 0)
8010749f:	e8 5c b0 ff ff       	call   80102500 <kalloc>
801074a4:	85 c0                	test   %eax,%eax
801074a6:	89 c2                	mov    %eax,%edx
801074a8:	0f 84 9e 00 00 00    	je     8010754c <pagefault+0x18c>
          {
            cprintf("Page fault sem memória, terminando o processo");
            cur->killed=1;
            return;
          }
          memmove(mem, (char*)P2V(physicalAdress), PGSIZE);
801074ae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801074b4:	83 ec 04             	sub    $0x4,%esp
801074b7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801074ba:	68 00 10 00 00       	push   $0x1000
801074bf:	50                   	push   %eax
801074c0:	52                   	push   %edx
801074c1:	e8 da d2 ff ff       	call   801047a0 <memmove>

          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W | PTE_FLAGS(*pte);
          *pte &= ~PTE_COW;
801074c6:	8b 07                	mov    (%edi),%eax
801074c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074cb:	25 ff 0f 00 00       	and    $0xfff,%eax
801074d0:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801074d6:	09 c2                	or     %eax,%edx
801074d8:	80 e6 fd             	and    $0xfd,%dh
801074db:	83 ca 07             	or     $0x7,%edx
801074de:	89 17                	mov    %edx,(%edi)
          uint refTest = getRefCount(physicalAdress);
801074e0:	89 34 24             	mov    %esi,(%esp)
801074e3:	e8 78 b1 ff ff       	call   80102660 <getRefCount>
          cprintf("PGfault: ref test de %d para %x\n", physicalAdress, refTest);
801074e8:	83 c4 0c             	add    $0xc,%esp
801074eb:	50                   	push   %eax
801074ec:	56                   	push   %esi
801074ed:	68 7c 81 10 80       	push   $0x8010817c
801074f2:	e8 69 91 ff ff       	call   80100660 <cprintf>
          minusRefCount(physicalAdress);
801074f7:	89 34 24             	mov    %esi,(%esp)
801074fa:	e8 01 b1 ff ff       	call   80102600 <minusRefCount>
          refTest = getRefCount(physicalAdress);
801074ff:	89 34 24             	mov    %esi,(%esp)
80107502:	e8 59 b1 ff ff       	call   80102660 <getRefCount>
          cprintf("PGfault: ref test de %d para %x\n", physicalAdress, refTest);
80107507:	83 c4 0c             	add    $0xc,%esp
8010750a:	50                   	push   %eax
8010750b:	56                   	push   %esi
8010750c:	68 7c 81 10 80       	push   $0x8010817c
80107511:	e8 4a 91 ff ff       	call   80100660 <cprintf>
80107516:	83 c4 10             	add    $0x10,%esp
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107519:	8b 43 04             	mov    0x4(%ebx),%eax
8010751c:	05 00 00 00 80       	add    $0x80000000,%eax
80107521:	0f 22 d8             	mov    %eax,%cr3
80107524:	e9 fe fe ff ff       	jmp    80107427 <pagefault+0x67>
80107529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        panic("Referências incorretas\n");
        return;
      }
      else
      {
        cprintf("eu n sei o que estou fazendo\n");
80107530:	83 ec 0c             	sub    $0xc,%esp
80107533:	68 60 80 10 80       	push   $0x80108060
80107538:	e8 23 91 ff ff       	call   80100660 <cprintf>
        *pte &= ~PTE_COW;
        *pte |= PTE_W;
8010753d:	8b 07                	mov    (%edi),%eax
8010753f:	83 c4 10             	add    $0x10,%esp
80107542:	80 e4 fd             	and    $0xfd,%ah
80107545:	83 c8 02             	or     $0x2,%eax
80107548:	89 07                	mov    %eax,(%edi)
8010754a:	eb cd                	jmp    80107519 <pagefault+0x159>
      if(refCount > 1)
      {

          if((mem = kalloc()) == 0)
          {
            cprintf("Page fault sem memória, terminando o processo");
8010754c:	83 ec 0c             	sub    $0xc,%esp
8010754f:	68 4c 81 10 80       	push   $0x8010814c
80107554:	e8 07 91 ff ff       	call   80100660 <cprintf>
            cur->killed=1;
80107559:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
            return;
80107560:	83 c4 10             	add    $0x10,%esp
80107563:	e9 bf fe ff ff       	jmp    80107427 <pagefault+0x67>
  char *a = (char *)PGROUNDDOWN(va);
  pte_t *pte;
    if(!(error & 0x02)){cprintf("Nao e erro de escrita.");return;}
  if(cur ==0)
  {
    cprintf( "Page fault occured but it was not the user process\n");
80107568:	83 ec 0c             	sub    $0xc,%esp
8010756b:	68 c4 80 10 80       	push   $0x801080c4
80107570:	e8 eb 90 ff ff       	call   80100660 <cprintf>
    panic("pagefault");
80107575:	c7 04 24 35 80 10 80 	movl   $0x80108035,(%esp)
8010757c:	e8 ef 8d ff ff       	call   80100370 <panic>
