/*
Rings
Straight Lines
Diagonal lines
Sine wave lines
Random
Checkered
Striped

Tunnel position
Tunnel rotation
Tunnel GMode

Random tunnel object appear/disappear
Random tunnel object sca.x,w.p.z,etc



*/
void spawnRectVRing(float time, float z, float w, float h, float vx, float vy, int lifeSpan, int num){
	for (float i = 0 ; i < num ; i ++) {
		events.add(new SpawnTunnelObject(time, new RectV((i/num-0.5)*tel.W*2,(z)*tel.H, w*tel.w,h*tel.w, vx*tel.w,vy*tel.w, lifeSpan)));
	}
}

void spawnRectVLine(float time, float x, float w, float h, float vx, float vy, int lifeSpan, int num){
	spawnRectVLine(time, x,0, w,h, vx,vy, lifeSpan,num);
}

void spawnRectVLine(float time, float x, float dx, float w, float h, float vx, float vy, int lifeSpan, int num){
	for (float i = 0 ; i < num ; i ++) {
		events.add(new SpawnTunnelObject(time, new RectV((x+dx*i)*tel.W,(i/num-0.5)*tel.H*2, w*tel.w,h*tel.w, vx*tel.w,vy*tel.w, lifeSpan)));
	}
}

void spawnRectVAvSourceRing(float time, float z, float w, float h, float vx, float vy, 
	int lifeSpan, int spawnLifeSpan, float[] spawnDir, boolean[] spawnFlip, float index, float threshold, int num){
	for (float i = 0 ; i < num ; i ++) {
		events.add(new SpawnTunnelObject(time, new RectVAvSource((i/num-0.5)*tel.W*2,(z)*tel.H, w*tel.w,h*tel.w, vx*tel.w,vy*tel.w, 
		 		lifeSpan,spawnLifeSpan, spawnDir, spawnFlip,(index+i)%binCount,threshold)));
	}
}

void spawnRectVAvSourceLine(float time, float x, float w, float h, float vx, float vy, 
	int lifeSpan, int spawnLifeSpan, float[] spawnDir, boolean[] spawnFlip, float index, float threshold, int num){
	spawnRectVAvSourceLine(time,x,0, w,h, vx,vy, lifeSpan,spawnLifeSpan, spawnDir,spawnFlip, index,threshold,num);
}

void spawnRectVAvSourceLine(float time, float x, float dx, float w, float h, float vx, float vy, 
	int lifeSpan, int spawnLifeSpan, float[] spawnDir, boolean[] spawnFlip, float index, float threshold, int num){
	for (float i = 0 ; i < num ; i ++) {
		events.add(new SpawnTunnelObject(time, new RectVAvSource((x+dx*i)*tel.W,(i/num-0.5)*tel.H*2, w*tel.w,h*tel.w, vx*tel.w,vy*tel.w, 
		 		lifeSpan,spawnLifeSpan, spawnDir, spawnFlip,(index+i)%binCount,threshold)));
	}
}


class ClearTunnelInstant extends Event {
	
	ClearTunnelInstant(float time) {
		super(time, time+1);
	}

	void spawn() {
		for (int i = 0 ; i < tel.ar.size() ; i ++) {
			tel.ar.get(i).finished = true;
		}
	}
}

class ClearTunnel extends Event {

	ClearTunnel(float time) {
		super(time, time+1);
	}

	void spawn() {
		for (int i = 0 ; i < tel.ar.size() ; i ++) {
			tel.ar.get(i).alive = false;
			tel.ar.get(i).sca.X = 0;
		}
	}
}

class SetTunnelGMode extends Event {
	int mode;
	SetTunnelGMode(float time, int mode) {
		super(time, time+1);
		this.mode = mode;
	}

	void spawn() {
		tel.gMode = mode;
	}
}

class SetTunnelAv extends Event {
	float x,y,z;

	SetTunnelAv(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		tel.av.P.set(x,y,z);
	}
}

class SetTunnelPv extends Event {
	float x,y;

	SetTunnelPv(float time, float x, float y) {
		super(time, time+1);
		this.x = x; this.y = y;
	}

	void spawn() {
		tel.pv.P.set(x,y,0);
	}
}

class SpawnTunnelObject extends Event {
	TunnelEntity mob;

	SpawnTunnelObject(float time, TunnelEntity mob) {
		super(time, time+1);
		this.mob = mob;
	}

	void spawn() {
		tel.add(mob);
	}
}

class SetTunnelObjectP extends SetTunnelObjectXYZ {
	SetTunnelObjectP(float time, TunnelEntity mob, float x, float y) {
		super(time,mob,x,y);
	}

	void spawn() {
		mob.p.reset(x,y,mob.p.P.z);
	}
}

class SetTunnelObjectScaX extends SetTunnelObjectXYZ {
	SetTunnelObjectScaX(float time, TunnelEntity mob, float x) {
		super(time,mob,x);
	}

	void spawn() {
		mob.sca.X = x;
	}
}

class SetTunnelObjectScax extends SetTunnelObjectXYZ {
	SetTunnelObjectScax(float time, TunnelEntity mob, float x) {
		super(time,mob,x);
	}

	void spawn() {
		mob.sca.x = x;
	}
}

abstract class SetTunnelObjectXYZ extends Event {
	TunnelEntity mob;
	float x,y,z;

	SetTunnelObjectXYZ(float time, TunnelEntity mob, float x, float y, float z) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y; this.z = z;
	}

	SetTunnelObjectXYZ(float time, TunnelEntity mob, float x, float y) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y;
	}

	SetTunnelObjectXYZ(float time, TunnelEntity mob, float x) {
		super(time,time+1);
		this.mob = mob;
		this.x = x;
	}
}

class FillStyleSetC extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetC(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setC(r,g,b,a);
	}
}

class FillStyleSetM extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetM(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setM(r,g,b,a);
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