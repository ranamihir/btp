import math

def circle(x,y,r):
	for th in xrange(0, 2*math.pi, math.pi/50):
		xunit = r * math.cos(th) + x
		yunit = r * math.sin(th) + y
		plot(xunit, yunit)
		# patch(xunit, yunit,'r','EdgeColor',[1 1 1])

circle(1,2,4)