void addEvents() {
	events.add(new SetTunnelPv(0, tel, 0,0));
	
	float time = 1; float row = 6; float w = 300; float h = 200;
	for (int i = 0 ; i < 4 ; i ++) {
		for (int j = 0 ; j < 4 ; j ++) {
			for (int k = 0 ; k < row ; k ++) {
				events.add(new SpawnTunnelObject(1+i*2,tel, new RectV((j-2)*tel.W/2,((float)k/row-0.5)*tel.H*2, w,h, 10,0, 90)));
			}
		}
	}

	time = 9; row = 12;
	events.add(new ClearTunnel(time,tel));
	events.add(new SetTunnelPv(time,tel,0,10));
	for (int i = 0 ; i < 5 ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			events.add(new SpawnTunnelObject(time+i*2,tel, new RectV(((float)k/row-0.5)*tel.W*2,tel.H, w,h, 15,10, 260)));
		}
	}

	time = 17; row = 16; float sAmp = 2;
	events.add(new ClearTunnel(time,tel));
	for (int i = 0 ; i < 7 ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			events.add(new SpawnTunnelObject(time+i*2,tel, new RectVAvSource(0,((float)k/row-0.5)*tel.H*2, w,h, 25,0, 
		 		180,15, new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/row*binCount,2)));
		}
	}

	time = 33; sAmp = 1.5; row = 10;
	events.add(new ClearTunnel(time,tel));
	events.add(new SetTunnelPv(time,tel,0,-10));
	for (int i = 0 ; i < 15 ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			events.add(new SpawnTunnelObject(time+i*2,tel, new RectVAvSource(-k*w/2,((float)k/row-0.5)*tel.H*2, w,h, 15,0, 
		 		120,15, new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/row*binCount,2)));
			events.add(new SpawnTunnelObject(time+i*2,tel, new RectVAvSource(-k*w/2+tel.W,((float)k/row-0.5)*tel.H*2, w,h, 15,0, 
		 		120,15, new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/row*binCount,2)));
		}
	}

	events.add(new SetTunnelPv(49,tel,10,-30));

	time = 63; row = 16;
	for (int k = 0 ; k < row ; k ++) {
		events.add(new SpawnTunnelObject(time,tel, new RectVAvSource(((float)k/row-0.5)*tel.W*2,tel.H*0.5, w,h, 30,30, 
			30,30,new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/row*binCount,2)));
	}
	
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
		setTime(16091,33);
		break;
		case '3':
		setTime(24055,49);
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