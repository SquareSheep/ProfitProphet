class ScreenTunnel extends Entity {
	Point p;
	Point ang;
	Point av = new Point();
	float w; // Boundaries: -w*2 to w*2, -h/2 to h/2
	float h;
	float W;
	float H;
	ArrayList<TunnelEntity> ar = new ArrayList<TunnelEntity>();
	Point pv = new Point(); // pv for ar objects

	int gMode = 0; float gx = 0; float gy = 0;
	float gr,gb,gg,ga,grm,gbm,ggm,gam;
	float t,temp,x1,y1,x2,y2;

	ScreenTunnel(PVector p, PVector ang, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w; this.h = h;
		this.W = w*2; this.H = h/2;
	}

	void update() {
		ang.P.add(av.p);
		p.update();
		ang.update();
		av.update();
		pv.update();
		for (int i = 0 ; i < ar.size() ; i ++) {
			TunnelEntity mob = ar.get(i);
			mob.p.P.add(pv.p);
			if (mob.p.p.x < -W) {
				mob.p.p.x = W;
				mob.p.P.x = W;
			} else if (mob.p.p.x > W) {
				mob.p.p.x = -W;
				mob.p.P.x = -W;
			}
			if (mob.p.p.y < -H) {
				mob.p.p.y = H;
				mob.p.P.y = H;
			} else if (mob.p.p.y > H) {
				mob.p.p.y = -H;
				mob.p.P.y = -H;
			}
			mob.sca.update();
			mob.update();
			if (mob.alive && mob.lifeSpan != -1) {
				mob.lifeSpan --;
				if (mob.lifeSpan == 0) {
					mob.alive = false;
					mob.sca.X = 0;
				}
			} else if (mob.sca.x < 0.1) {
				mob.finished = true;
			}
		}
		for (int i = 0 ;  i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
	}

	void renderRect(float minW, float maxW) {
		translate(0,0,w/2);
		for (TunnelEntity mob : ar) {
			if (mob.draw && mob.p.p.x >= minW && mob.p.p.x < maxW) {
				push();
				translate(mob.p.p.x-minW-w/2,mob.p.p.y,mob.p.p.z);
				scale(mob.sca.x);
				if (mob.gradient) {
					gradient(mob);
				} else {
					mob.fillStyle.fillStyle();
				}
				mob.render();
				pop();
			}
		}
		translate(0,0,3);
		push();
		noStroke();
		fill(0);
		rect(0,0,w,h);
		pop();
		translate(0,0,-w/2-3);
	}

	void gradient(TunnelEntity mob) {
		switch (gMode) {
			case 0:
			x1 = mob.p.p.x/1000+gx; y1 = mob.p.p.y/1000+gy;
			temp = (float)frameCount/50;
			fill(noise(x1,y1,10 + temp)*255,noise(x1,y1,55 + temp)*255,noise(y1,x1,-100 + temp)*255,255);
			break;
			case 1:
			x1 = mob.p.p.x/1000+gx; y1 = mob.p.p.y/1500+gy;
			fill(noise(y1,x1,-57)*255,noise(x1,y1,3)*255,noise(x1,x1,100)*255,255);
			break;
			case 2:
			x1 = noise(mob.p.p.x/1000,mob.p.p.y/500,(float)frameCount/100)*255;
			fill(x1,x1,x1,255);
			break;
		}
	}

	void render() {
		push();
		fill(0);
		stroke(255);
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		renderRect(-W,-W/2);
		rotateY(PI/2);
		renderRect(-W/2,0);
		rotateY(PI/2);
		renderRect(0,W/2);
		rotateY(PI/2);
		renderRect(W/2,W);
		pop();
	}

	void add(TunnelEntity mob) {
		ar.add(mob);
	}

	TunnelEntity getLast() {
		return ar.get(ar.size()-1);
	}
}

abstract class TunnelEntity extends Entity {
  Point p;
  Point w;
  SpringValue sca = new SpringValue(0,1);
  int lifeSpan = -1;
  ScreenTunnel parent = tel;
  IColor fillStyle;
  boolean gradient = true;
  boolean alive = true;

  TunnelEntity(ScreenTunnel parent) {
  	this.parent = parent;
  	this.w = new Point();
  }

  TunnelEntity() {
  	this.w = new Point();
  }

  void render() {
	if (w.p.z > 1) {
		//translate(0,0,-w.p.z/2);
		box(w.p.x, w.p.y, w.p.z);
	} else {
		rect(0,0,w.p.x,w.p.y);
	}
  }
}