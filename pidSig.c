void pidSig{
	while(1){
		int pid, sig;
		scanf("%d %d", pid, sig);
		kill(pid, sig);
	}
}
