void addEvents() {
	events.add(new SetTunnelPv(0, tel, 0,0));
	float row = 6;
	for (int i = 0 ; i < 50 ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			events.add(new SpawnTunnelObject(1+i*2,tel, new RectVAvSource(0,((float)k/row-0.5)*tel.H*2, 100,100, 25,0, 
		 		180,15, new float[]{-2,-2, 2,2}, new boolean[]{true,true},(int)random(binCount),1)));
		}
	}
	events.add(new SetTunnelPv(10,tel,0,30));
	// Long bursts: 63, 59,61, 9799103105,111,-159, staccoty 161-183 muted 183-197
	// Snare taps: 73-187, then muted for 187-207
	// Continuous snare taps: 207-
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(0,0);
		break;
		case '2':
		setTime(24055,49);
		break;
		case '3':
		setTime(54590,110);
		break;
		case '4':
		setTime(0,0);
		break;
		case '5':
		setTime(0,0);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}