class RectVAvSource extends RectVSource {
	int index; float threshold;

	RectVAvSource(float x, float y, float w, float h, float vx, float vy, 
		int lifeSpan, int spawnLifeSpan, float[] spawnDir, boolean[] spawnFlip, float index, float threshold) {
		super(x,y,w,h,vx,vy,lifeSpan,spawnLifeSpan,spawnDir,spawnFlip);
		this.index = (int)index; this.threshold = threshold;
	}

	RectVAvSource(float x, float y, float w, float h, float vx, float vy, int lifeSpan, int spawnLifeSpan, float index, float threshold) {
		super(x,y,w,h,vx,vy,lifeSpan,spawnLifeSpan);
		this.index = (int)index; this.threshold = threshold;
	}

	RectVAvSource(float x, float y, float w, float h, float vx, float vy, float index, float threshold) {
		super(x,y,w,h,vx,vy);
		this.index = (int)index; this.threshold = threshold;
	}

	void spawnCheck() {
		if (av[index] > threshold) spawn();
	}
}

class RectVSource extends RectV {
	int spawnLifeSpan;
	int tick;
	float[] spawnDir;
	boolean[] spawnFlip;

	RectVSource(float x, float y, float w, float h, float vx, float vy, 
		int lifeSpan, int spawnLifeSpan, float[] spawnDir, boolean[] spawnFlip) {
		super(x,y,w,h,vx,vy);
		this.lifeSpan = lifeSpan;
		this.spawnLifeSpan = spawnLifeSpan;
		tick = (int)(w*h/max(vx,1)/max(vy,1)/60)*2+1;
		this.spawnDir = new float[spawnDir.length];
		this.spawnFlip = new boolean[spawnFlip.length];
		for (int i = 0 ; i < spawnFlip.length ; i ++) {
			this.spawnFlip[i] = spawnFlip[i];
			this.spawnDir[i*2] = spawnDir[i*2];
			this.spawnDir[i*2+1] = spawnDir[i*2+1];
		}
	}

	RectVSource(float x, float y, float w, float h, float vx, float vy, int lifeSpan, int spawnLifeSpan) {
		this(x,y,w,h,vx,vy,lifeSpan,lifeSpan, new float[]{-1,-1}, new boolean[]{true});
	}

	RectVSource(float x, float y, float w, float h, float vx, float vy) {
		this(x,y,w,h,vx,vy,-1,(int)fpb*12);
	}

	void update() {
		super.update();
		spawnCheck();
	}

	void spawnCheck() {
		if (frameCount % tick == 0) spawn();
	}

	void spawn() {
		for (int i = 0 ; i < spawnFlip.length ; i ++) {
			if (spawnFlip[i]) {
				parent.add(new RectV(p.p.x,p.p.y,w.p.x,w.p.y, pv.p.y*spawnDir[i*2],pv.p.x*spawnDir[i*2+1], spawnLifeSpan));
			} else {
				parent.add(new RectV(p.p.x,p.p.y,w.p.x,w.p.y, pv.p.x*spawnDir[i*2],pv.p.y*spawnDir[i*2+1], spawnLifeSpan));
			}
		}
	}
}

class RectV extends TunnelEntity {
	Point pv;

	RectV(float x, float y, float w, float h, float vx, float vy, int lifeSpan) {
		this.p = new Point(x,y,0);
		this.w = new Point(w,h,0);
		this.w.p.set(0,0,0);
		this.w.index = (int)random(binCount);
		this.w.pm.z = sqrt(w*h)*0.1;
		this.pv = new Point(vx,vy,0);
		fillStyle = new IColor(random(25,100),random(25,100),random(25,100),255, random(10),random(10),random(10),0, (int)random(binCount));
		this.lifeSpan = lifeSpan;
	}

	RectV(float x, float y, float w, float h, float vx, float vy) {
		this(x,y,w,h,vx,vy,-1);
	}

	RectV(float x, float y, float w, float h) {
		this(x,y, w,h, 0,0);
	}

	void update() {
		p.P.add(pv.p);
		p.update();
		pv.update();
		w.update();
		fillStyle.update();
	}
}

int SplitSquareMaxLevel = 2;
class SplitSquare extends TunnelEntity {
	float splitChance = random(0.05,0.1);
	float childChance = 0.5;
	int tick = 1;
	float W;
	int level;
	boolean alive = true;

	SplitSquare(float x, float y, float w, int level) {
		this.p = new Point(x,y,0);
		this.W = w;
		this.w = new Point(w,w,0);
		this.w.index = (int)(noise(x/100,y/100)*binCount)%binCount;
		this.w.pm.z = w*0.01;
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
			if (w.P.x != 0) w.P.set(0,0,0);
			if (w.p.x <= 10) finished = true;
		}
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