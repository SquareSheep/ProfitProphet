class ScreenTunnel extends Entity {
	Point p;
	Point ang;
	float w; // w is only 1/4th of the total width wrapped around
	float h;
	ArrayList<EntityX> ar = new ArrayList<EntityX>();

	ScreenTunnel(PVector p, PVector ang, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w; this.h = h;
	}

	void update() {
		p.update();
		ang.update();
		for (int i = 0 ; i < ar.size() ; i ++) {
			EntityX mob = ar.get(i);
			if (mob.p.p.x < -w*2) {
				mob.p.p.x = w*2;
				mob.p.P.x = w*2;
			} else if (mob.p.p.x > w*2) {
				mob.p.p.x = -w*2;
				mob.p.P.x = -w*2;
			}
			mob.update();
		}
		for (int i = 0 ;  i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
	}

	void renderRect(float minW, float maxW) {
		translate(0,0,w/2);
		stroke(255);
		for (EntityX mob : ar) {
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
		renderRect(-w*2,-w);
		rotateY(PI/2);
		renderRect(-w,0);
		rotateY(PI/2);
		renderRect(0,w);
		rotateY(PI/2);
		renderRect(w,w*2);
		pop();
	}

	void add(EntityX mob) {
		ar.add(mob);
	}
}

abstract class EntityX extends Entity {
  Point p;
}