/*********************************************************
 /                   MANDELBULBER
 / some functions for different calculations
 /
 /
 / author: Krzysztof Marczak
 / contact: buddhi1980@gmail.com
 / licence: GNU GPL v3.0
 /
 ********************************************************/

#ifndef COMMON_MATH_H_
#define COMMON_MATH_H_

#include "algebra.hpp"

#undef	MAX
#define MAX(a, b)  (((a) > (b)) ? (a) : (b))

#undef	MIN
#define MIN(a, b)  (((a) < (b)) ? (a) : (b))

struct sVectorsAround
{
	double alpha;
	double beta;
	CVector3 v;
	int R;
	int G;
	int B;
	bool notBlack;
};

struct sVector
{
	double x;
	double y;
	double z;
};

template <class TYPE>
struct sSortZ
{
	TYPE z;
	int i;
};

enum enumPerspectiveType
{
	threePoint = 0, fishEye = 1, equirectangular = 2, fishEyeCut = 3
};

//int abs(int v);
int Random(int max);
double dMax(double a, double b, double c);
double dMin(double a, double b, double c);
//void QuickSortZBuffer(sSortZ<float> *dane, int l, int p);

template <class T> void QuickSortZBuffer(sSortZ<T> *dane, int l, int p);
CVector3 Projection3D(CVector3 point, CVector3 vp, CRotationMatrix mRot, enumPerspectiveType perspectiveType, double fov, double zoom);
inline double SmoothConditionAGreaterB(double a, double b, double sharpness) {return 1.0 / (1.0 + exp(sharpness * (b - a)));}
inline double SmoothConditionALessB(double a, double b, double sharpness) {return 1.0 / (1.0 + exp(sharpness * (a - b)));}
CVector3 InvProjection3D(CVector3 point, CVector3 vp, CRotationMatrix mRotInv, enumPerspectiveType perspectiveType, double fov, double zoom, double imgWidth, double imgHeight);

#endif /* COMMON_MATH_H_ */
