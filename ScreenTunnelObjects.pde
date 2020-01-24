class TunnelRect extends TunnelEntity {
	float vx; float vy;

	TunnelRect(float x, float y, float w, float h, float vx, float vy) {
		this.p = new Point(x,y,0);
		this.w = new Point(w,h,0);
		this.w.index = (int)random(binCount);
		this.w.pm.z = sqrt(w*h)*0.03;
		this.vx = vx;
		this.vy = vy;
		fillStyle = new IColor(random(25,100),random(25,100),random(25,100),255, random(10),random(10),random(10),0, (int)random(binCount));
	}

	TunnelRect(float x, float y, float w, float h) {
		this(x,y, w,h, 0,0);
	}

	void update() {
		p.P.x += vx;
		p.P.y += vy;
		p.update();
		w.update();
		fillStyle.update();
	}

	void render() {
		fillStyle.fillStyle();
		if (w.p.z > 1) {
			translate(0,0,-w.p.z/2);
			box(w.p.x, w.p.y, w.p.z);
		} else {
			rect(0,0,w.p.x,w.p.y);
		}
	}
}

class SpreadRect extends TunnelRect {
	int spawnLifeSpan;
	int tick;

	SpreadRect(float x, float y, float w, float h, float vx, float vy, int lifeSpan, int spawnLifeSpan) {
		super(x,y,w,h,vx,vy);
		this.lifeSpan = lifeSpan;
		this.spawnLifeSpan = spawnLifeSpan;
		tick = (int)(w*h/max(vx,1)/max(vy,1)/60)+1;
		println(tick);
	}

	SpreadRect(float x, float y, float w, float h, float vx, float vy, int lifeSpan) {
		this(x,y,w,h,vx,vy,lifeSpan,lifeSpan);
	}

	SpreadRect(float x, float y, float w, float h, float vx, float vy) {
		this(x,y,w,h,vx,vy,-1,(int)fpb*12);
	}

	void update() {
		super.update();
		if (frameCount % tick == 0) spawn();
	}

	void spawn() {
		parent.add(new TunnelRect(p.p.x,p.p.y,w.p.x,w.p.y,vy,vx));
		parent.getLast().lifeSpan = spawnLifeSpan;
		parent.add(new TunnelRect(p.p.x,p.p.y,w.p.x,w.p.y,-vy,-vx));
		parent.getLast().lifeSpan = spawnLifeSpan;
	}
}

int SplitSquareMaxLevel = 2;
class SplitSquare extends TunnelEntity {
	float splitChance = random(0.05,0.1);
	float childChance = 0.5;
	int tick = 1;
	SpringValue w;
	float W;
	int level;
	boolean alive = true;

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
			if (random(1) < childChance) parent.add(new SplitSquare(p.p.x-dw,p.p.y-dw,nw,level+1));
			if (random(1) < childChance) parent.add(new SplitSquare(p.p.x+dw,p.p.y-dw,nw,level+1));
			if (random(1) < childChance) parent.add(new SplitSquare(p.p.x+dw,p.p.y+dw,nw,level+1));
			if (random(1) < childChance) parent.add(new SplitSquare(p.p.x-dw,p.p.y+dw,nw,level+1));
		}
	}
}