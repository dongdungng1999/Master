function T_i_1_i = MTCDDN(DH_hang)

    a = DH_hang(1);
	anp = DH_hang(2);
	d = DH_hang(3)
	the = DH_hang(4);
    T_i_1_i = [	cos(the)			-sin(the)			0			a;...
				sin(the)*cos(anp)	cos(the)*cos(anp)	-sin(anp)	-sin(anp)*d;...
				sin(the)*sin(anp)	cos(the)*sin(anp)	cos(anp)	cos(anp)*d;...
				0					0					0			1];