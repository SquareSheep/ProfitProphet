/*
Lots of squares. Moving up and down
Cell automata would work pretty well here
Like in that Raven Kwok video for Max Cooper
Wireframe style, like on Gage's album cover

Moving down an infinite tunnel lined with square panels.
Tunnel complexity relates to current song complexity.


Four wall container objects.
Squares can be spawned in them, get displayed on the surface.



Long burst
Short burst
Wavy bursts

Drum rim hits

Background beat
Background 

Background bass notes
*/
class SetTunnelGMode extends Event {
	ScreenTunnel tunnel;
	int mode;
	SetTunnelGMode(float time, ScreenTunnel tunnel, int mode) {
		super(time, time+1);
		this.tunnel = tunnel;
		this.mode = mode;
	}

	void spawn() {
		tunnel.gMode = mode;
	}
}

class SetTunnelAv extends Event {
	ScreenTunnel tunnel;
	float x,y,z;

	SetTunnelAv(float time, ScreenTunnel tunnel, float x, float y, float z) {
		super(time, time+1);
		this.tunnel = tunnel;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		tunnel.av.P.set(x,y,z);
	}
}

class SetTunnelPv extends Event {
	ScreenTunnel tunnel;
	float vx, vy;

	SetTunnelPv(float time, ScreenTunnel tunnel, float vx, float vy) {
		super(time, time+1);
		this.tunnel = tunnel;
		this.vx = vx; this.vy = vy;
	}

	void spawn() {
		tunnel.pv.P.set(vx,vy,0);
	}
}

class SpawnTunnelObject extends Event {
	TunnelEntity mob;
	ScreenTunnel tunnel;
	float x,y,z; int lifeSpan;

	SpawnTunnelObject(float time, ScreenTunnel tunnel, TunnelEntity mob) {
		super(time, time+1);
		this.mob = mob;
		this.tunnel = tunnel;
		// x = mob.p.p.x;
		// y = mob.p.p.y;
		// z = mob.p.p.z;
		// lifeSpan = mob.lifeSpan;
	}

	void spawn() {
		// mob.p.reset(x,y,z);
		// mob.lifeSpan = lifeSpan;
		// mob.finished = false;
		// mob.draw = true;
		tunnel.add(mob);
	}
}

class SetTunnelObjectP extends Event {
	TunnelEntity mob;
	float x,y;
	SetTunnelObjectP(float time, TunnelEntity mob, float x, float y) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y;
	}

	void spawn() {
		mob.p.reset(x,y,mob.p.P.z);
	}
}

class SetTunnelObjectScaX extends Event {
	TunnelEntity mob;
	float x;
	SetTunnelObjectScaX(float time, TunnelEntity mob, float x) {
		super(time,time+1);
		this.mob = mob;
		this.x = x;
	}

	void spawn() {
		mob.sca.X = x;
	}
}

class SetTunnelObjectScax extends Event {
	TunnelEntity mob;
	float x;
	SetTunnelObjectScax(float time, TunnelEntity mob, float x) {
		super(time,time+1);
		this.mob = mob;
		this.x = x;
	}

	void spawn() {
		mob.sca.x = x;
	}
}

class TunnelObjectFillStyleSetC extends Event {
	TunnelEntity mob;
	float r,g,b,a;
	TunnelObjectFillStyleSetC(float time, TunnelEntity mob, float r, float g, float b, float a) {
		super(time,time+1);
		this.mob = mob;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		mob.fillStyle.setC(r,g,b,a);
	}
}

class TunnelObjectFillStyleSetM extends Event {
	TunnelEntity mob;
	float r,g,b,a,index;
	TunnelObjectFillStyleSetM(float time, TunnelEntity mob, float r, float g, float b, float a, float index) {
		super(time,time+1);
		this.mob = mob;
		this.r = r; this.g = g; this.b = b; this.a = a;
		this.index = index;
	}

	void spawn() {
		mob.fillStyle.setM(r,g,b,a, index);
	}
}

// CAMERA EVENTS
class CameraPAdd extends Event {
	float x; float y; float z;

	CameraPAdd(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.p.add(x,y,z);
		cam.ang.P.add(x,y,z);
	}
}

class CameraPSet extends Event {
	float x; float y; float z;

	CameraPSet(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.reset(x,y,z);
	}
}

class CameraAvSet extends Event {
	float x; float y; float z;

	CameraAvSet(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.av.reset(x,y,z);
	}
}