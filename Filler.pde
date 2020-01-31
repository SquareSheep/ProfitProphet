class Filler extends Entity {
	Point ang;
	Point av;
	SpringValue d;
	Filler child;
	IColor fillStyle = new IColor();

	Filler(Filler child, float d, float ax, float ay, float az, float avx, float avy, float avz) {
		this.d = new SpringValue(d);
		this.ang = new Point(ax,ay,az);
		this.av = new Point(avx,avy,avz);
		this.child = child;
	}

	Filler(float d, float ax, float ay, float az, float avx, float avy, float avz) {
		this(null,d,ax,ay,az,avx,avy,avz);
	}

	void update() {
		ang.P.add(av.p);
		ang.P.z += 0.01;
		ang.update();
		av.update();
		fillStyle.update();
		if (child != null) child.update();
	}

	void render() {
		push();
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		translate(0,d.x,0);
		fillStyle.fillStyle();
		circle(0,0,d.x);
		if (child != null) child.render();
		pop();
	}
}