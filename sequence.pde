void addEvents() {
	events.add(new SetTunnelPv(0,0,0));
	
	float time = 1; int num = 20; float w = 0.3; float h = 0.2; float threshold = 3;
	for (int i = 0 ; i < 4 ; i ++) {
		for (float k = 0 ; k < 4 ; k ++) {
			spawnRectVLine(time+i*2,k/4, w,h, 0.01,0.01, 90,num);
		}
	}

	time = 9;
	events.add(new ClearTunnel(time));
	events.add(new SetTunnelPv(time,0,10));
	for (float i = 0 ; i < 5 ; i ++) {
		spawnRectVRing(time+i*2,0, w,h, 0.01,-0.03, 180,num);
		spawnRectVRing(time+i*2,0, w,h, 0.01,0.03, 180,num);
	}

	time = 17;
	events.add(new ClearTunnel(time));
	for (float i = 0 ; i < 8 ; i ++) {
		spawnRectVAvSourceLine(time+i*2, 0, w,h, -0.02,0, 180,30, 
			new float[]{-2,-2,2,2}, new boolean[]{true,true},i/num*binCount,threshold,num);
		spawnRectVAvSourceLine(time+i*2, 1, w,h, 0.02,0, 180,30, 
			new float[]{-2,-2,2,2}, new boolean[]{true,true},i/num*binCount,threshold,num);
	}
	for (int i = 0 ; i < 8 ; i ++) {
		spawnRectVAvSourceLine(time+i*2, 0.5,0, w,h, 0.03,0, 120,30, 
			new float[]{-2,-2}, new boolean[]{false},i/num*binCount,threshold,num);
	}

	time = 33;
	events.add(new ClearTunnel(time));
	events.add(new SetTunnelPv(time,0,-10));
	for (int i = 0 ; i < 8 ; i ++) {
		spawnRectVAvSourceLine(time+i*2, 0.5,0, w,h, -0.02,0, 120,30, 
			new float[]{-2,-2,2,2}, new boolean[]{true,true},i/num*binCount,threshold,num);
		spawnRectVAvSourceLine(time+i*2, -0.5,0, w,h, -0.02,0, 120,30, 
			new float[]{-2,-2,2,2}, new boolean[]{true,true},i/num*binCount,threshold,num);
	}

	time = 51; w = 0.15; h=0.1;
	for (int i = 0 ; i < 6 ; i ++) {
		for (int k = 0 ; k < 4 ; k ++) {
			spawnRectVAvSourceLine(time+i*2, k*0.5,0, w,h, -0.03,0, 120,30, 
				new float[]{-2,-2,2,2}, new boolean[]{true,true},i/num*binCount,threshold,num);
		}
	}

	/*
	time = 51; sAmp = 2.5; num = 9;
	events.add(new ClearTunnel(time));
	events.add(new SetTunnelPv(time,0,-15));
	for (int i = 0 ; i < 6 ; i ++) {
		for (int k = 0 ; k < num ; k ++) {
			for (int j = 0 ; j < 4 ; j ++) {
				events.add(new SpawnTunnelObject(time+i*2, new RectVAvSource(-k*w/2-tel.W+tel.W*0.5*j,((float)k/num-0.5)*tel.H*2, w,h, 15,0, 
			 		120,15, new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/num*binCount,threshold)));
			}
		}
	}

	events.add(new SetTunnelPv(time,10,-30));

	time = 63; num = 12;
	for (int k = 0 ; k < num ; k ++) {
		events.add(new SpawnTunnelObject(time, new RectVAvSource(((float)k/num-0.5)*tel.W*2,tel.H*0.5, w,h, 30,30, 
			30,30,new float[]{-sAmp,-sAmp,sAmp,sAmp}, new boolean[]{false,false},(float)k/num*binCount,threshold)));
	}

	time = 65; w = 200; h = 200;
	events.add(new SetTunnelPv(time,0,0));
	events.add(new SetTunnelGMode(63, 2));
	for (int i = 0 ; i < 8 ; i ++) {
		for (int k = 0 ; k < 100 ; k ++) {
			events.add(new SpawnTunnelObject(time+i*4, new RectV(random(-tel.W,tel.W), random(-tel.H,tel.H), w,h, random(-30,30),-30,30)));
		}
	}
	for (int i = 0 ; i < 8 ; i ++) {
		for (int k = 0 ; k < 100 ; k ++) {
			events.add(new SpawnTunnelObject(time+2+i*4, new RectV(random(-tel.W,tel.W), random(-tel.H,tel.H), w,h, random(-30,30),30,30)));
		}
	}
	*/

	time = 97;

	// Long bursts: 63, 59,61, 9799103105,111,-159, staccoty 161-183 muted 183-197
	// Snare taps: 75-187, then muted for 187-207
	// Continuous snare taps: 207-
	time = 187;
	events.add(new ClearTunnel(time));
	events.add(new SetTunnelPv(time,0,0));
	for (float i = 0 ; i < 32 ; i ++) {
		events.add(new SetTunnelGMode(time+i,(int)(i%2)));
		if (i % 2 == 0) {
			spawnRectVRing(time+i,-0.5, w,h, 0.02,-0.03, 60,num);
			spawnRectVRing(time+i,0.5, w,h, 0.02,0.03, 60,num);
		} else {
			if (i % 4 == 1) {	
				for (float k = 0 ; k < 4 ; k ++) {
					spawnRectVLine(time+i,k/4, w,h, 0.03,0.02, 60,num);
				}
			} else {
				for (float k = 0 ; k < 4 ; k ++) {
					spawnRectVLine(time+i,k/4, w,h, -0.03,-0.02, 60,num);
				}
			}
		}
	}
	for (int i = 0 ; i < 8 ; i ++) {
		for (float k = 0 ; k < 12 ; k ++) {
			spawnRectVRing(time+1+i*4,k/12, 0.1,0.1, 0.02,0.04, 60,12);
		}
	}
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(0,0);
		break;
		case '2':
		setTime(16091,32);
		break;
		case '3':
		setTime(24055,48);
		break;
		case '4':
		setTime(30557,61);
		break;
		case '5':
		setTime(93065,187);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}