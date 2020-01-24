void addEvents() {
	events.add(new SetTunnelPv(0, tel, 0,5));
	for (int i = 10 ; i < 20 ; i +=2) {
		events.add(new SpawnTunnelObject(i,tel,new SpreadRect(0,0, 100,100, 25,0, 300)));
	}
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(0,0);
		break;
		case '2':
		setTime(0,0);
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