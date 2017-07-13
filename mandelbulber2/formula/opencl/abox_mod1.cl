/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * aBoxMod1, a variation of Mandelbox fractal known as AmazingBox or ABox,
 * invented by Tom Lowe in 2010, the variation by DarkBeam
 *
 * This formula has a different box fold to the standard Tglad fold
 * This formula has a c.x c.y SWAP (in compute_fractals.cpp)
 * In V2.11 minimum radius is MinimumR2, for settings made in
 * older versions, you need to use the square root of the old parameter.
 *
 * based on DarkBeam's Mandelbulb3D code
 *
 * @reference
 * http://www.fractalforums.com/ifs-iterated-function-systems/amazing-fractal/msg12467/#msg12467
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 AboxMod1Iteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;

	z.x = fractal->mandelbox.foldingValue
				- fabs(fabs(z.x + fractal->transformCommon.additionConstant000.x)
							 - fractal->mandelbox.foldingValue)
				- fabs(fractal->transformCommon.additionConstant000.x);
	z.y = fractal->mandelbox.foldingValue
				- fabs(fabs(z.y + fractal->transformCommon.additionConstant000.y)
							 - fractal->mandelbox.foldingValue)
				- fabs(fractal->transformCommon.additionConstant000.y);

	if (fractal->transformCommon.functionEnabledz)
	{
		z.z = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1
					- fabs(mad(-fractal->mandelbox.foldingValue, fractal->transformCommon.scale1,
							fabs(z.z + fractal->transformCommon.additionConstant000.z)))
					- fabs(fractal->transformCommon.additionConstant000.z);
	}

	float rr = (z.x * z.x + z.y * z.y + z.z * z.z);
	if (fractal->transformCommon.functionEnabledFalse)
	{
		rr = native_powr(rr, fractal->mandelboxVary4D.rPower);
	}

	if (rr < fractal->transformCommon.minR0)
	{
		float tglad_factor1 =
			native_divide(fractal->transformCommon.maxR2d1, fractal->transformCommon.minR0);
		z *= tglad_factor1;
		aux->DE *= tglad_factor1;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		float tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}

	z *= aux->actualScale;
	aux->DE = mad(aux->DE, fabs(aux->actualScale), 1.0f);

	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0f), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		float4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (float4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (float4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (float4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (float4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (float4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (float4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (float4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (float4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (float4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (float4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (float4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (float4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}

	if (fractal->transformCommon.rotationEnabled
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	return z;
}
#else
double4 AboxMod1Iteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;


	z.x = fractal->mandelbox.foldingValue
				- fabs(fabs(z.x + fractal->transformCommon.additionConstant000.x)
							 - fractal->mandelbox.foldingValue)
				- fabs(fractal->transformCommon.additionConstant000.x);
	z.y = fractal->mandelbox.foldingValue
				- fabs(fabs(z.y + fractal->transformCommon.additionConstant000.y)
							 - fractal->mandelbox.foldingValue)
				- fabs(fractal->transformCommon.additionConstant000.y);

	if (fractal->transformCommon.functionEnabledz)
	{
		z.z = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1
					- fabs(mad(-fractal->mandelbox.foldingValue, fractal->transformCommon.scale1,
							fabs(z.z + fractal->transformCommon.additionConstant000.z)))
					- fabs(fractal->transformCommon.additionConstant000.z);
	}

	double rr = (z.x * z.x + z.y * z.y + z.z * z.z);
	if (fractal->transformCommon.functionEnabledFalse)
	{
		rr = native_powr(rr, fractal->mandelboxVary4D.rPower);
	}

	if (rr < fractal->transformCommon.minR0)
	{
		double tglad_factor1 =
			native_divide(fractal->transformCommon.maxR2d1, fractal->transformCommon.minR0);
		z *= tglad_factor1;
		aux->DE *= tglad_factor1;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		double tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}

	z *= aux->actualScale;
	aux->DE = aux->DE * fabs(aux->actualScale) + 1.0;

	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		double4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (double4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (double4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (double4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (double4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (double4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (double4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (double4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (double4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (double4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (double4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (double4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (double4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}

	if (fractal->transformCommon.rotationEnabled
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	return z;
}
#endif
