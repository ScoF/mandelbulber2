/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * knotv1
 * Based on DarkBeam formula from this thread:
 * http://www.fractalforums.com/new-theories-and-research/not-fractal-but-funny-trefoil-knot-routine

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_testing_transform.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingTransformIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL a = fractal->transformCommon.intA1;
	REAL b = fractal->transformCommon.intB1;
	REAL polyfoldOrder = fractal->transformCommon.int2;

	if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
	if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
	if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	z += fractal->transformCommon.offset000;
	// z *= fractal->transformCommon.scale1;
	// z += fractal->transformCommon.offset000;

	// aux->DE *= fractal->transformCommon.scale1;

	REAL4 zc = z;

	zc.z *= fractal->transformCommon.scaleA1;
	REAL mobius = REAL(a + native_divide(b, polyfoldOrder)) * atan2(zc.y, zc.x);

	zc.x = native_sqrt(mad(zc.x, zc.x, zc.y * zc.y)) - fractal->transformCommon.offsetA2;
	REAL temp = zc.x;
	REAL c = native_cos(mobius);
	REAL s = native_sin(mobius);
	zc.x = mad(c, zc.x, s * zc.z);
	zc.z = mad(-s, temp, c * zc.z);

	REAL m = native_divide(float(polyfoldOrder), M_PI_2x_F);
	REAL angle1 = floor(mad(m, (M_PI_2 - atan2(zc.x, zc.z)), 0.5f)) / m;

	temp = zc.y;
	c = native_cos(fractal->transformCommon.offset0);
	s = native_sin(fractal->transformCommon.offset0);
	zc.y = mad(c, zc.y, s * zc.z);
	zc.z = mad(-s, temp, c * zc.z);

	temp = zc.x;
	c = native_cos(angle1);
	s = native_sin(angle1);
	zc.x = mad(c, zc.x, s * zc.z);
	zc.z = mad(-s, temp, c * zc.z);

	zc.x -= fractal->transformCommon.offsetR1;

	REAL len = native_sqrt(mad(zc.x, zc.x, zc.z * zc.z));

	if (fractal->transformCommon.functionEnabledCFalse) len = min(len, max(abs(zc.x), abs(zc.z)));

	if (fractal->transformCommon.functionEnabledEFalse) z = zc;
	if (!fractal->transformCommon.functionEnabledDFalse)
		aux->DE0 = len - fractal->transformCommon.offset05;
	else
		aux->DE0 = min(aux->dist, len - fractal->transformCommon.offset05);
	aux->dist = native_divide(aux->DE0, aux->DE);

	if (!fractal->transformCommon.functionEnabledJFalse)
		aux->dist = len - fractal->transformCommon.offset05;
	else
		aux->dist = min(aux->dist, len - fractal->transformCommon.offset05);
	aux->dist = native_divide(aux->dist, aux->DE);
	return z;
}