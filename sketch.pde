static float bpm = 170;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -350;
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

void render() {
	//if (timer.beat) println(song.position + " " + currBeat)

	fill(255);
	float w = width/av.length;
	for (int i = 0 ; i < av.length ; i ++) {
		rect((float)i/av.length*width,0, w, av[i]*10);
	}
}

void setSketch() {
	
}