class TunnelRect extends EntityX {
	Point w;
	IColor fillStyle;

	TunnelRect(float x, float y, float w, float h) {
		this.p = new Point(x,y,0);
		this.w = new Point(w,h,0);
		fillStyle = new IColor(random(125,255),random(125,255),random(125,255),255);
	}

	void update() {
		p.P.x += 5;
		p.update();
		w.update();
		fillStyle.update();
	}

	void render() {
		fillStyle.fillStyle();
		if (w.p.z <= 1) {
			translate(0,0,w.p.z/2);
			box(w.p.x, w.p.y, w.p.z);
		} else {
			rect(0,0,w.p.x,w.p.y);
		}
	}
}

int SplitSquareMaxLevel = 2;
class SplitSquare extends EntityX {
	float splitChance = random(0.05,0.1);
	float childChance = 0.5;
	int tick = 1;
	SpringValue w;
	float W;
	int level;
	boolean alive = true;
	IColor fillStyle;

	SplitSquare(float x, float y, float w, int level) {
		this.p = new Point(x,y,0);
		this.W = w;
		this.w = new SpringValue(0,w);
		this.w.index = (int)(noise(x/100,y/100)*binCount)%binCount;
		this.w.xm = w*0.01;
		this.level = level;
		float famp = 2;
		fillStyle = new IColor(
			noise(frameCount/1000,de*2+x/de)*255,noise(frameCount/1000,y/de)*255, 
			noise(frameCount/1000,(x+y)/100)*255,255, 
			noise(frameCount/100)*famp,noise(frameCount/300)*famp,noise(frameCount/200)*famp,0,this.w.index);
	}

	SplitSquare(float x, float y, float w) {
		this(x,y,w, 0);
	}

	void update() {
		p.update();
		w.update();
		fillStyle.update();
		if (alive && frameCount % tick == 0) {
			if (random(1) < splitChance) split();
		}
		if (!alive) {
			if (w.X != 0) w.X = 0;
			if (w.x <= 10) finished = true;
		}
	}

	void render() {
		//translate(0,0,-w.x/2);
		fillStyle.fillStyle();
		box(w.x);
	}

	void split() {
		alive = false;
		if (level < SplitSquareMaxLevel) {
			float nw = W/1.6;
			float dw = W/3;
			if (random(1) < childChance) ((ScreenTunnel)mobs.get(0)).add(new SplitSquare(p.p.x-dw,p.p.y-dw,nw,level+1));
			if (random(1) < childChance) ((ScreenTunnel)mobs.get(0)).add(new SplitSquare(p.p.x+dw,p.p.y-dw,nw,level+1));
			if (random(1) < childChance) ((ScreenTunnel)mobs.get(0)).add(new SplitSquare(p.p.x+dw,p.p.y+dw,nw,level+1));
			if (random(1) < childChance) ((ScreenTunnel)mobs.get(0)).add(new SplitSquare(p.p.x-dw,p.p.y+dw,nw,level+1));
		}
	}
}