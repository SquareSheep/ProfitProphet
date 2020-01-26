void addEvents() {
	events.add(new SetTunnelPv(0, tel, 0,0));
	for (int i = 0 ; i < 10 ; i ++) {
		events.add(new SpawnTunnelObject(2+i*4,tel, new RectVAvSource(0,0, 100,100, 5,0, 
	 		1600,300, new float[]{-2,-2, 2,2}, new boolean[]{true,true},0,3)));
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
		setTime(0,0);
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