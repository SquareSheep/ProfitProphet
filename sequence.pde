void addEvents() {
	events.add(new SetTunnelPv(0, tel, 10,0));
	float row = 15;
	for (int i = 0 ; i < 50 ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			events.add(new SpawnTunnelObject(110+i*1,tel, new RectVAvSource(0,((float)k/row-0.5)*tel.H*2, 100,100, 25,0, 
		 		180,15, new float[]{-2,-2, 2,2}, new boolean[]{true,true},(int)random(binCount),1)));
		}
	}
	for (int i = 0 ; i < 25 ; i ++) {
		events.add(new SetTunnelGMode(110+i*2,tel,i%2));
	}
	
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