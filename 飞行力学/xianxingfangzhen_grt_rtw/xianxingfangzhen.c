/*
 * xianxingfangzhen.c
 *
 * Code generation for model "xianxingfangzhen".
 *
 * Model version              : 1.3
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Sat Jun 24 20:05:59 2023
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "xianxingfangzhen.h"
#include "xianxingfangzhen_private.h"

/* Block signals (default storage) */
B_xianxingfangzhen_T xianxingfangzhen_B;

/* Continuous states */
X_xianxingfangzhen_T xianxingfangzhen_X;

/* Block states (default storage) */
DW_xianxingfangzhen_T xianxingfangzhen_DW;

/* Real-time model */
RT_MODEL_xianxingfangzhen_T xianxingfangzhen_M_;
RT_MODEL_xianxingfangzhen_T *const xianxingfangzhen_M = &xianxingfangzhen_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 8;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  xianxingfangzhen_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  xianxingfangzhen_step();
  xianxingfangzhen_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  xianxingfangzhen_step();
  xianxingfangzhen_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void xianxingfangzhen_step(void)
{
  int_T iy;
  real_T currentTime;
  real_T currentTime_tmp;
  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* set solver stop time */
    if (!(xianxingfangzhen_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&xianxingfangzhen_M->solverInfo,
                            ((xianxingfangzhen_M->Timing.clockTickH0 + 1) *
        xianxingfangzhen_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&xianxingfangzhen_M->solverInfo,
                            ((xianxingfangzhen_M->Timing.clockTick0 + 1) *
        xianxingfangzhen_M->Timing.stepSize0 +
        xianxingfangzhen_M->Timing.clockTickH0 *
        xianxingfangzhen_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(xianxingfangzhen_M)) {
    xianxingfangzhen_M->Timing.t[0] = rtsiGetT(&xianxingfangzhen_M->solverInfo);
  }

  /* StateSpace: '<Root>/LON' */
  for (iy = 0; iy < 4; iy++) {
    xianxingfangzhen_B.LON[iy] = 0.0;
    xianxingfangzhen_B.LON[iy] += xianxingfangzhen_P.C[iy] *
      xianxingfangzhen_X.LON_CSTATE[0];
    xianxingfangzhen_B.LON[iy] += xianxingfangzhen_P.C[4 + iy] *
      xianxingfangzhen_X.LON_CSTATE[1];
    xianxingfangzhen_B.LON[iy] += xianxingfangzhen_P.C[8 + iy] *
      xianxingfangzhen_X.LON_CSTATE[2];
    xianxingfangzhen_B.LON[iy] += xianxingfangzhen_P.C[12 + iy] *
      xianxingfangzhen_X.LON_CSTATE[3];
  }

  /* End of StateSpace: '<Root>/LON' */
  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* ToWorkspace: '<Root>/To Workspace1' */
    if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (xianxingfangzhen_DW.ToWorkspace1_PWORK.LoggedData),
                      &xianxingfangzhen_B.LON[0], 0);
    }
  }

  /* Step: '<Root>/de' incorporates:
   *  Step: '<Root>/da'
   *  Step: '<Root>/dp'
   *  Step: '<Root>/dr'
   */
  currentTime_tmp = xianxingfangzhen_M->Timing.t[0];
  if (currentTime_tmp < xianxingfangzhen_P.de_Time) {
    currentTime = xianxingfangzhen_P.de_Y0;
  } else {
    currentTime = xianxingfangzhen_P.de_YFinal;
  }

  /* End of Step: '<Root>/de' */

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLONInport1' incorporates:
   *  Gain: '<Root>/Gain'
   */
  xianxingfangzhen_B.TmpSignalConversionAtLONInport1[0] =
    xianxingfangzhen_P.Gain_Gain * currentTime;

  /* Step: '<Root>/dp' */
  if (currentTime_tmp < xianxingfangzhen_P.dp_Time) {
    currentTime = xianxingfangzhen_P.dp_Y0;
  } else {
    currentTime = xianxingfangzhen_P.dp_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLONInport1' incorporates:
   *  Gain: '<Root>/Gain1'
   */
  xianxingfangzhen_B.TmpSignalConversionAtLONInport1[1] =
    xianxingfangzhen_P.Gain1_Gain * currentTime;

  /* StateSpace: '<Root>/LAT' */
  for (iy = 0; iy < 4; iy++) {
    xianxingfangzhen_B.LAT[iy] = 0.0;
    xianxingfangzhen_B.LAT[iy] += xianxingfangzhen_P.C[iy] *
      xianxingfangzhen_X.LAT_CSTATE[0];
    xianxingfangzhen_B.LAT[iy] += xianxingfangzhen_P.C[4 + iy] *
      xianxingfangzhen_X.LAT_CSTATE[1];
    xianxingfangzhen_B.LAT[iy] += xianxingfangzhen_P.C[8 + iy] *
      xianxingfangzhen_X.LAT_CSTATE[2];
    xianxingfangzhen_B.LAT[iy] += xianxingfangzhen_P.C[12 + iy] *
      xianxingfangzhen_X.LAT_CSTATE[3];
  }

  /* End of StateSpace: '<Root>/LAT' */
  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* ToWorkspace: '<Root>/To Workspace2' */
    if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (xianxingfangzhen_DW.ToWorkspace2_PWORK.LoggedData),
                      &xianxingfangzhen_B.LAT[0], 0);
    }
  }

  /* Step: '<Root>/da' */
  if (currentTime_tmp < xianxingfangzhen_P.da_Time) {
    currentTime = xianxingfangzhen_P.da_Y0;
  } else {
    currentTime = xianxingfangzhen_P.da_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLATInport1' incorporates:
   *  Gain: '<Root>/Gain2'
   */
  xianxingfangzhen_B.TmpSignalConversionAtLATInport1[0] =
    xianxingfangzhen_P.Gain2_Gain * currentTime;

  /* Step: '<Root>/dr' */
  if (currentTime_tmp < xianxingfangzhen_P.dr_Time) {
    currentTime = xianxingfangzhen_P.dr_Y0;
  } else {
    currentTime = xianxingfangzhen_P.dr_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLATInport1' incorporates:
   *  Gain: '<Root>/Gain3'
   */
  xianxingfangzhen_B.TmpSignalConversionAtLATInport1[1] =
    xianxingfangzhen_P.Gain3_Gain * currentTime;

  /* Clock: '<Root>/Clock' */
  xianxingfangzhen_B.Clock = xianxingfangzhen_M->Timing.t[0];
  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* ToWorkspace: '<Root>/To Workspace' */
    if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (xianxingfangzhen_DW.ToWorkspace_PWORK.LoggedData),
                      &xianxingfangzhen_B.Clock, 0);
    }
  }

  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(xianxingfangzhen_M->rtwLogInfo,
                        (xianxingfangzhen_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(xianxingfangzhen_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(xianxingfangzhen_M)!=-1) &&
          !((rtmGetTFinal(xianxingfangzhen_M)-
             (((xianxingfangzhen_M->Timing.clockTick1+
                xianxingfangzhen_M->Timing.clockTickH1* 4294967296.0)) * 0.01)) >
            (((xianxingfangzhen_M->Timing.clockTick1+
               xianxingfangzhen_M->Timing.clockTickH1* 4294967296.0)) * 0.01) *
            (DBL_EPSILON))) {
        rtmSetErrorStatus(xianxingfangzhen_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&xianxingfangzhen_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++xianxingfangzhen_M->Timing.clockTick0)) {
      ++xianxingfangzhen_M->Timing.clockTickH0;
    }

    xianxingfangzhen_M->Timing.t[0] = rtsiGetSolverStopTime
      (&xianxingfangzhen_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.01s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.01, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      xianxingfangzhen_M->Timing.clockTick1++;
      if (!xianxingfangzhen_M->Timing.clockTick1) {
        xianxingfangzhen_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void xianxingfangzhen_derivatives(void)
{
  int_T is;
  XDot_xianxingfangzhen_T *_rtXdot;
  _rtXdot = ((XDot_xianxingfangzhen_T *) xianxingfangzhen_M->derivs);
  for (is = 0; is < 4; is++) {
    /* Derivatives for StateSpace: '<Root>/LON' */
    _rtXdot->LON_CSTATE[is] = 0.0;
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.A_LON[is] *
      xianxingfangzhen_X.LON_CSTATE[0];
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.A_LON[4 + is] *
      xianxingfangzhen_X.LON_CSTATE[1];
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.A_LON[8 + is] *
      xianxingfangzhen_X.LON_CSTATE[2];
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.A_LON[12 + is] *
      xianxingfangzhen_X.LON_CSTATE[3];
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.B_LON[is] *
      xianxingfangzhen_B.TmpSignalConversionAtLONInport1[0];
    _rtXdot->LON_CSTATE[is] += xianxingfangzhen_P.B_LON[4 + is] *
      xianxingfangzhen_B.TmpSignalConversionAtLONInport1[1];

    /* Derivatives for StateSpace: '<Root>/LAT' */
    _rtXdot->LAT_CSTATE[is] = 0.0;
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.A_LAT[is] *
      xianxingfangzhen_X.LAT_CSTATE[0];
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.A_LAT[4 + is] *
      xianxingfangzhen_X.LAT_CSTATE[1];
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.A_LAT[8 + is] *
      xianxingfangzhen_X.LAT_CSTATE[2];
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.A_LAT[12 + is] *
      xianxingfangzhen_X.LAT_CSTATE[3];
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.B_LAT[is] *
      xianxingfangzhen_B.TmpSignalConversionAtLATInport1[0];
    _rtXdot->LAT_CSTATE[is] += xianxingfangzhen_P.B_LAT[4 + is] *
      xianxingfangzhen_B.TmpSignalConversionAtLATInport1[1];
  }
}

/* Model initialize function */
void xianxingfangzhen_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)xianxingfangzhen_M, 0,
                sizeof(RT_MODEL_xianxingfangzhen_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&xianxingfangzhen_M->solverInfo,
                          &xianxingfangzhen_M->Timing.simTimeStep);
    rtsiSetTPtr(&xianxingfangzhen_M->solverInfo, &rtmGetTPtr(xianxingfangzhen_M));
    rtsiSetStepSizePtr(&xianxingfangzhen_M->solverInfo,
                       &xianxingfangzhen_M->Timing.stepSize0);
    rtsiSetdXPtr(&xianxingfangzhen_M->solverInfo, &xianxingfangzhen_M->derivs);
    rtsiSetContStatesPtr(&xianxingfangzhen_M->solverInfo, (real_T **)
                         &xianxingfangzhen_M->contStates);
    rtsiSetNumContStatesPtr(&xianxingfangzhen_M->solverInfo,
      &xianxingfangzhen_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&xianxingfangzhen_M->solverInfo,
      &xianxingfangzhen_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&xianxingfangzhen_M->solverInfo,
      &xianxingfangzhen_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&xianxingfangzhen_M->solverInfo,
      &xianxingfangzhen_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&xianxingfangzhen_M->solverInfo, (&rtmGetErrorStatus
      (xianxingfangzhen_M)));
    rtsiSetRTModelPtr(&xianxingfangzhen_M->solverInfo, xianxingfangzhen_M);
  }

  rtsiSetSimTimeStep(&xianxingfangzhen_M->solverInfo, MAJOR_TIME_STEP);
  xianxingfangzhen_M->intgData.y = xianxingfangzhen_M->odeY;
  xianxingfangzhen_M->intgData.f[0] = xianxingfangzhen_M->odeF[0];
  xianxingfangzhen_M->intgData.f[1] = xianxingfangzhen_M->odeF[1];
  xianxingfangzhen_M->intgData.f[2] = xianxingfangzhen_M->odeF[2];
  xianxingfangzhen_M->contStates = ((X_xianxingfangzhen_T *) &xianxingfangzhen_X);
  rtsiSetSolverData(&xianxingfangzhen_M->solverInfo, (void *)
                    &xianxingfangzhen_M->intgData);
  rtsiSetSolverName(&xianxingfangzhen_M->solverInfo,"ode3");
  rtmSetTPtr(xianxingfangzhen_M, &xianxingfangzhen_M->Timing.tArray[0]);
  rtmSetTFinal(xianxingfangzhen_M, 200.0);
  xianxingfangzhen_M->Timing.stepSize0 = 0.01;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    xianxingfangzhen_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(xianxingfangzhen_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(xianxingfangzhen_M->rtwLogInfo, (NULL));
    rtliSetLogT(xianxingfangzhen_M->rtwLogInfo, "tout");
    rtliSetLogX(xianxingfangzhen_M->rtwLogInfo, "");
    rtliSetLogXFinal(xianxingfangzhen_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(xianxingfangzhen_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(xianxingfangzhen_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(xianxingfangzhen_M->rtwLogInfo, 0);
    rtliSetLogDecimation(xianxingfangzhen_M->rtwLogInfo, 1);
    rtliSetLogY(xianxingfangzhen_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(xianxingfangzhen_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(xianxingfangzhen_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &xianxingfangzhen_B), 0,
                sizeof(B_xianxingfangzhen_T));

  /* states (continuous) */
  {
    (void) memset((void *)&xianxingfangzhen_X, 0,
                  sizeof(X_xianxingfangzhen_T));
  }

  /* states (dwork) */
  (void) memset((void *)&xianxingfangzhen_DW, 0,
                sizeof(DW_xianxingfangzhen_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(xianxingfangzhen_M->rtwLogInfo, 0.0,
    rtmGetTFinal(xianxingfangzhen_M), xianxingfangzhen_M->Timing.stepSize0,
    (&rtmGetErrorStatus(xianxingfangzhen_M)));

  /* Start for ToWorkspace: '<Root>/To Workspace1' */
  {
    int_T dimensions[1] = { 4 };

    xianxingfangzhen_DW.ToWorkspace1_PWORK.LoggedData = rt_CreateLogVar(
      xianxingfangzhen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(xianxingfangzhen_M),
      xianxingfangzhen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(xianxingfangzhen_M)),
      "data_LON",
      SS_DOUBLE,
      0,
      0,
      0,
      4,
      1,
      dimensions,
      NO_LOGVALDIMS,
      (NULL),
      (NULL),
      0,
      1,
      0.01,
      1);
    if (xianxingfangzhen_DW.ToWorkspace1_PWORK.LoggedData == (NULL))
      return;
  }

  /* Start for ToWorkspace: '<Root>/To Workspace2' */
  {
    int_T dimensions[1] = { 4 };

    xianxingfangzhen_DW.ToWorkspace2_PWORK.LoggedData = rt_CreateLogVar(
      xianxingfangzhen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(xianxingfangzhen_M),
      xianxingfangzhen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(xianxingfangzhen_M)),
      "data_LAT",
      SS_DOUBLE,
      0,
      0,
      0,
      4,
      1,
      dimensions,
      NO_LOGVALDIMS,
      (NULL),
      (NULL),
      0,
      1,
      0.01,
      1);
    if (xianxingfangzhen_DW.ToWorkspace2_PWORK.LoggedData == (NULL))
      return;
  }

  /* Start for ToWorkspace: '<Root>/To Workspace' */
  {
    int_T dimensions[1] = { 1 };

    xianxingfangzhen_DW.ToWorkspace_PWORK.LoggedData = rt_CreateLogVar(
      xianxingfangzhen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(xianxingfangzhen_M),
      xianxingfangzhen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(xianxingfangzhen_M)),
      "time",
      SS_DOUBLE,
      0,
      0,
      0,
      1,
      1,
      dimensions,
      NO_LOGVALDIMS,
      (NULL),
      (NULL),
      0,
      1,
      0.01,
      1);
    if (xianxingfangzhen_DW.ToWorkspace_PWORK.LoggedData == (NULL))
      return;
  }

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  xianxingfangzhen_X.LON_CSTATE[0] = xianxingfangzhen_P.ini_state_LON[0];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  xianxingfangzhen_X.LAT_CSTATE[0] = xianxingfangzhen_P.ini_state_LON[0];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  xianxingfangzhen_X.LON_CSTATE[1] = xianxingfangzhen_P.ini_state_LON[1];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  xianxingfangzhen_X.LAT_CSTATE[1] = xianxingfangzhen_P.ini_state_LON[1];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  xianxingfangzhen_X.LON_CSTATE[2] = xianxingfangzhen_P.ini_state_LON[2];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  xianxingfangzhen_X.LAT_CSTATE[2] = xianxingfangzhen_P.ini_state_LON[2];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  xianxingfangzhen_X.LON_CSTATE[3] = xianxingfangzhen_P.ini_state_LON[3];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  xianxingfangzhen_X.LAT_CSTATE[3] = xianxingfangzhen_P.ini_state_LON[3];
}

/* Model terminate function */
void xianxingfangzhen_terminate(void)
{
  /* (no terminate code required) */
}
