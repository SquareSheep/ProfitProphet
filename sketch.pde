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

ScreenTunnel tel;

void render() {
	//if (timer.beat) println(song.position + " " + currBeat)
	if (frameCount % 5 == 0) {
		int row = 10;
		for (float i = 0 ; i < row ; i ++) {
			for (float k = 0 ; k < row ; k ++) {
				if (random(1) > 0.98) {
					tel.add(new SplitSquare(i/row*tel.w*4-tel.w*2,k/row*tel.h-tel.h/2,tel.h/row));
				}
			}
		}
	}
}

void setSketch() {
	stroke(255);
	tel = new ScreenTunnel(new PVector(0,0,0), new PVector(PI/2,0,0), de*1.2,de*2.2);
	mobs.add(tel);
	for (int i = 0 ; i < 100 ; i ++) {
		tel.add(new TunnelRect(random(-tel.w*2,tel.w*2),random(-tel.h,tel.h),random(25,100),random(50,125)));
	}
}