void pidSig{
	while(1){
		int pid, sig;
		scanf("%d %d", pid, sig);
		if(sig==1)
			kill(pid, sig);
	}
}