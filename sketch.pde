static float bpm = 120;
static float beatInc = 1;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 10;
static float fillVMult = 0.5;
static float fftThreshold = 2;
static float fftPow = 1.5;
static float fftAmp = 5;
static float volumeGain = -5;
static String songName = "../Music/profitprophet.wav";

IColor defaultFill = new IColor(0,0,0,255);
IColor defaultStroke = new IColor(0,0,0,0);

ScreenTunnel tel;

void render() {
	defaultFill.update();
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1.0));
	//drawPitches2D();
	cam.ang.P.set(sin((float)frameCount/120)*0.03,cos((float)frameCount/120)*0.03,-(float)frameCount/1200*PI);
}

void setSketch() {
	defaultFill.setM(5,5,5,0,0);
	stroke(255);
	noFill();
	tel = new ScreenTunnel(new PVector(0,0,-de*0.4), new PVector(PI/2,0,0), de*1.2,de*3.6);
	mobs.add(tel);
}