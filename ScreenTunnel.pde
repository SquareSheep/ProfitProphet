class ScreenTunnel extends Entity {
	Point p;
	Point ang;
	float w; // Boundaries: -w*2 to w*2, -h/2 to h/2
	float h;
	float W;
	float H;
	ArrayList<TunnelEntity> ar = new ArrayList<TunnelEntity>();
	Point pv = new Point(); // pv for ar objects

	ScreenTunnel(PVector p, PVector ang, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w; this.h = h;
		this.W = w*2; this.H = h/2;
	}

	void update() {
		p.update();
		ang.update();
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
			mob.update();
			if (mob.lifeSpan != -1) {
				mob.lifeSpan --;
				if (mob.lifeSpan == 0) mob.finished = true;
			}
		}
		for (int i = 0 ;  i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
	}

	void renderRect(float minW, float maxW) {
		translate(0,0,w/2);
		stroke(255);
		for (TunnelEntity mob : ar) {
			if (mob.draw && mob.p.p.x >= minW && mob.p.p.x < maxW) {
				push();
				translate(mob.p.p.x-minW-w/2,mob.p.p.y,mob.p.p.z);
				mob.render();
				pop();
			}
		}
		translate(0,0,1);
		noStroke();
		rect(0,0,w,h);
		translate(0,0,-w/2-1);
	}

	void render() {
		push();
		fill(0);
		noStroke();
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
  SpringValue sca = new SpringValue(1);
  int lifeSpan = -1;
  ScreenTunnel parent = tel;
  IColor fillStyle;

  TunnelEntity(ScreenTunnel parent) {
  	this.parent = parent;
  	this.w = new Point();
  }

  TunnelEntity() {
  	this.w = new Point();
  }
}