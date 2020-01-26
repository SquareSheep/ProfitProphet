static float bpm = 120;
static float beatInc = 1;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 10;
static float fillVMult = 0.5;
static float fftThreshold = 1;
static float fftPow = 1.8;
static float fftAmp = 5;
static float volumeGain = -10;
static String songName = "../Music/profitprophet.wav";

IColor defaultFill = new IColor(222,125,222,255);
IColor defaultStroke = new IColor(0,0,0,0);

ScreenTunnel tel;

void render() {
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1.0));
}

void setSketch() {
	stroke(255);
	noFill();
	tel = new ScreenTunnel(new PVector(0,0,-de*0.5), new PVector(PI/2,0,0), de*1.2,de*3);
	mobs.add(tel);
}