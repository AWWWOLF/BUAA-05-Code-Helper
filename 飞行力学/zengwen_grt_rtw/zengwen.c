/*
 * zengwen.c
 *
 * Code generation for model "zengwen".
 *
 * Model version              : 1.4
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Sat Jun 24 20:26:28 2023
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "zengwen.h"
#include "zengwen_private.h"

/* Block signals (default storage) */
B_zengwen_T zengwen_B;

/* Continuous states */
X_zengwen_T zengwen_X;

/* Block states (default storage) */
DW_zengwen_T zengwen_DW;

/* Real-time model */
RT_MODEL_zengwen_T zengwen_M_;
RT_MODEL_zengwen_T *const zengwen_M = &zengwen_M_;

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
  zengwen_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  zengwen_step();
  zengwen_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  zengwen_step();
  zengwen_derivatives();

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
void zengwen_step(void)
{
  int_T iy;
  real_T currentTime;
  real_T currentTime_tmp;
  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* set solver stop time */
    if (!(zengwen_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&zengwen_M->solverInfo,
                            ((zengwen_M->Timing.clockTickH0 + 1) *
        zengwen_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&zengwen_M->solverInfo,
                            ((zengwen_M->Timing.clockTick0 + 1) *
        zengwen_M->Timing.stepSize0 + zengwen_M->Timing.clockTickH0 *
        zengwen_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(zengwen_M)) {
    zengwen_M->Timing.t[0] = rtsiGetT(&zengwen_M->solverInfo);
  }

  /* StateSpace: '<Root>/LON' */
  for (iy = 0; iy < 4; iy++) {
    zengwen_B.LON[iy] = 0.0;
    zengwen_B.LON[iy] += zengwen_P.C[iy] * zengwen_X.LON_CSTATE[0];
    zengwen_B.LON[iy] += zengwen_P.C[4 + iy] * zengwen_X.LON_CSTATE[1];
    zengwen_B.LON[iy] += zengwen_P.C[8 + iy] * zengwen_X.LON_CSTATE[2];
    zengwen_B.LON[iy] += zengwen_P.C[12 + iy] * zengwen_X.LON_CSTATE[3];
  }

  /* End of StateSpace: '<Root>/LON' */
  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* ToWorkspace: '<Root>/To Workspace1' */
    if (rtmIsMajorTimeStep(zengwen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (zengwen_DW.ToWorkspace1_PWORK.LoggedData),
                      &zengwen_B.LON[0], 0);
    }
  }

  /* Step: '<Root>/de' incorporates:
   *  Step: '<Root>/da'
   *  Step: '<Root>/dp'
   *  Step: '<Root>/dr'
   */
  currentTime_tmp = zengwen_M->Timing.t[0];
  if (currentTime_tmp < zengwen_P.de_Time) {
    currentTime = zengwen_P.de_Y0;
  } else {
    currentTime = zengwen_P.de_YFinal;
  }

  /* End of Step: '<Root>/de' */

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLONInport1' incorporates:
   *  Gain: '<Root>/Gain'
   *  Gain: '<Root>/k_alpha'
   *  Sum: '<Root>/Add'
   */
  zengwen_B.TmpSignalConversionAtLONInport1[0] = zengwen_P.k_alpha_Gain *
    zengwen_B.LON[1] + zengwen_P.Gain_Gain * currentTime;

  /* Step: '<Root>/dp' */
  if (currentTime_tmp < zengwen_P.dp_Time) {
    currentTime = zengwen_P.dp_Y0;
  } else {
    currentTime = zengwen_P.dp_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLONInport1' incorporates:
   *  Gain: '<Root>/Gain1'
   */
  zengwen_B.TmpSignalConversionAtLONInport1[1] = zengwen_P.Gain1_Gain *
    currentTime;

  /* StateSpace: '<Root>/LAT' */
  for (iy = 0; iy < 4; iy++) {
    zengwen_B.LAT[iy] = 0.0;
    zengwen_B.LAT[iy] += zengwen_P.C[iy] * zengwen_X.LAT_CSTATE[0];
    zengwen_B.LAT[iy] += zengwen_P.C[4 + iy] * zengwen_X.LAT_CSTATE[1];
    zengwen_B.LAT[iy] += zengwen_P.C[8 + iy] * zengwen_X.LAT_CSTATE[2];
    zengwen_B.LAT[iy] += zengwen_P.C[12 + iy] * zengwen_X.LAT_CSTATE[3];
  }

  /* End of StateSpace: '<Root>/LAT' */
  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* ToWorkspace: '<Root>/To Workspace2' */
    if (rtmIsMajorTimeStep(zengwen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (zengwen_DW.ToWorkspace2_PWORK.LoggedData),
                      &zengwen_B.LAT[0], 0);
    }
  }

  /* Step: '<Root>/da' */
  if (currentTime_tmp < zengwen_P.da_Time) {
    currentTime = zengwen_P.da_Y0;
  } else {
    currentTime = zengwen_P.da_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLATInport1' incorporates:
   *  Gain: '<Root>/Gain2'
   */
  zengwen_B.TmpSignalConversionAtLATInport1[0] = zengwen_P.Gain2_Gain *
    currentTime;

  /* Step: '<Root>/dr' */
  if (currentTime_tmp < zengwen_P.dr_Time) {
    currentTime = zengwen_P.dr_Y0;
  } else {
    currentTime = zengwen_P.dr_YFinal;
  }

  /* SignalConversion: '<Root>/TmpSignal ConversionAtLATInport1' incorporates:
   *  Gain: '<Root>/Gain3'
   */
  zengwen_B.TmpSignalConversionAtLATInport1[1] = zengwen_P.Gain3_Gain *
    currentTime;

  /* Clock: '<Root>/Clock' */
  zengwen_B.Clock = zengwen_M->Timing.t[0];
  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* ToWorkspace: '<Root>/To Workspace' */
    if (rtmIsMajorTimeStep(zengwen_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (zengwen_DW.ToWorkspace_PWORK.LoggedData),
                      &zengwen_B.Clock, 0);
    }
  }

  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(zengwen_M->rtwLogInfo, (zengwen_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(zengwen_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(zengwen_M)!=-1) &&
          !((rtmGetTFinal(zengwen_M)-(((zengwen_M->Timing.clockTick1+
               zengwen_M->Timing.clockTickH1* 4294967296.0)) * 0.01)) >
            (((zengwen_M->Timing.clockTick1+zengwen_M->Timing.clockTickH1*
               4294967296.0)) * 0.01) * (DBL_EPSILON))) {
        rtmSetErrorStatus(zengwen_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&zengwen_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++zengwen_M->Timing.clockTick0)) {
      ++zengwen_M->Timing.clockTickH0;
    }

    zengwen_M->Timing.t[0] = rtsiGetSolverStopTime(&zengwen_M->solverInfo);

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
      zengwen_M->Timing.clockTick1++;
      if (!zengwen_M->Timing.clockTick1) {
        zengwen_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void zengwen_derivatives(void)
{
  int_T is;
  XDot_zengwen_T *_rtXdot;
  _rtXdot = ((XDot_zengwen_T *) zengwen_M->derivs);
  for (is = 0; is < 4; is++) {
    /* Derivatives for StateSpace: '<Root>/LON' */
    _rtXdot->LON_CSTATE[is] = 0.0;
    _rtXdot->LON_CSTATE[is] += zengwen_P.A_LON[is] * zengwen_X.LON_CSTATE[0];
    _rtXdot->LON_CSTATE[is] += zengwen_P.A_LON[4 + is] * zengwen_X.LON_CSTATE[1];
    _rtXdot->LON_CSTATE[is] += zengwen_P.A_LON[8 + is] * zengwen_X.LON_CSTATE[2];
    _rtXdot->LON_CSTATE[is] += zengwen_P.A_LON[12 + is] * zengwen_X.LON_CSTATE[3];
    _rtXdot->LON_CSTATE[is] += zengwen_P.B_LON[is] *
      zengwen_B.TmpSignalConversionAtLONInport1[0];
    _rtXdot->LON_CSTATE[is] += zengwen_P.B_LON[4 + is] *
      zengwen_B.TmpSignalConversionAtLONInport1[1];

    /* Derivatives for StateSpace: '<Root>/LAT' */
    _rtXdot->LAT_CSTATE[is] = 0.0;
    _rtXdot->LAT_CSTATE[is] += zengwen_P.A_LAT[is] * zengwen_X.LAT_CSTATE[0];
    _rtXdot->LAT_CSTATE[is] += zengwen_P.A_LAT[4 + is] * zengwen_X.LAT_CSTATE[1];
    _rtXdot->LAT_CSTATE[is] += zengwen_P.A_LAT[8 + is] * zengwen_X.LAT_CSTATE[2];
    _rtXdot->LAT_CSTATE[is] += zengwen_P.A_LAT[12 + is] * zengwen_X.LAT_CSTATE[3];
    _rtXdot->LAT_CSTATE[is] += zengwen_P.B_LAT[is] *
      zengwen_B.TmpSignalConversionAtLATInport1[0];
    _rtXdot->LAT_CSTATE[is] += zengwen_P.B_LAT[4 + is] *
      zengwen_B.TmpSignalConversionAtLATInport1[1];
  }
}

/* Model initialize function */
void zengwen_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)zengwen_M, 0,
                sizeof(RT_MODEL_zengwen_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&zengwen_M->solverInfo, &zengwen_M->Timing.simTimeStep);
    rtsiSetTPtr(&zengwen_M->solverInfo, &rtmGetTPtr(zengwen_M));
    rtsiSetStepSizePtr(&zengwen_M->solverInfo, &zengwen_M->Timing.stepSize0);
    rtsiSetdXPtr(&zengwen_M->solverInfo, &zengwen_M->derivs);
    rtsiSetContStatesPtr(&zengwen_M->solverInfo, (real_T **)
                         &zengwen_M->contStates);
    rtsiSetNumContStatesPtr(&zengwen_M->solverInfo,
      &zengwen_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&zengwen_M->solverInfo,
      &zengwen_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&zengwen_M->solverInfo,
      &zengwen_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&zengwen_M->solverInfo,
      &zengwen_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&zengwen_M->solverInfo, (&rtmGetErrorStatus(zengwen_M)));
    rtsiSetRTModelPtr(&zengwen_M->solverInfo, zengwen_M);
  }

  rtsiSetSimTimeStep(&zengwen_M->solverInfo, MAJOR_TIME_STEP);
  zengwen_M->intgData.y = zengwen_M->odeY;
  zengwen_M->intgData.f[0] = zengwen_M->odeF[0];
  zengwen_M->intgData.f[1] = zengwen_M->odeF[1];
  zengwen_M->intgData.f[2] = zengwen_M->odeF[2];
  zengwen_M->contStates = ((X_zengwen_T *) &zengwen_X);
  rtsiSetSolverData(&zengwen_M->solverInfo, (void *)&zengwen_M->intgData);
  rtsiSetSolverName(&zengwen_M->solverInfo,"ode3");
  rtmSetTPtr(zengwen_M, &zengwen_M->Timing.tArray[0]);
  rtmSetTFinal(zengwen_M, 500.0);
  zengwen_M->Timing.stepSize0 = 0.01;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    zengwen_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(zengwen_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(zengwen_M->rtwLogInfo, (NULL));
    rtliSetLogT(zengwen_M->rtwLogInfo, "tout");
    rtliSetLogX(zengwen_M->rtwLogInfo, "");
    rtliSetLogXFinal(zengwen_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(zengwen_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(zengwen_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(zengwen_M->rtwLogInfo, 0);
    rtliSetLogDecimation(zengwen_M->rtwLogInfo, 1);
    rtliSetLogY(zengwen_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(zengwen_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(zengwen_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &zengwen_B), 0,
                sizeof(B_zengwen_T));

  /* states (continuous) */
  {
    (void) memset((void *)&zengwen_X, 0,
                  sizeof(X_zengwen_T));
  }

  /* states (dwork) */
  (void) memset((void *)&zengwen_DW, 0,
                sizeof(DW_zengwen_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(zengwen_M->rtwLogInfo, 0.0, rtmGetTFinal
    (zengwen_M), zengwen_M->Timing.stepSize0, (&rtmGetErrorStatus(zengwen_M)));

  /* Start for ToWorkspace: '<Root>/To Workspace1' */
  {
    int_T dimensions[1] = { 4 };

    zengwen_DW.ToWorkspace1_PWORK.LoggedData = rt_CreateLogVar(
      zengwen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(zengwen_M),
      zengwen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(zengwen_M)),
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
    if (zengwen_DW.ToWorkspace1_PWORK.LoggedData == (NULL))
      return;
  }

  /* Start for ToWorkspace: '<Root>/To Workspace2' */
  {
    int_T dimensions[1] = { 4 };

    zengwen_DW.ToWorkspace2_PWORK.LoggedData = rt_CreateLogVar(
      zengwen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(zengwen_M),
      zengwen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(zengwen_M)),
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
    if (zengwen_DW.ToWorkspace2_PWORK.LoggedData == (NULL))
      return;
  }

  /* Start for ToWorkspace: '<Root>/To Workspace' */
  {
    int_T dimensions[1] = { 1 };

    zengwen_DW.ToWorkspace_PWORK.LoggedData = rt_CreateLogVar(
      zengwen_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(zengwen_M),
      zengwen_M->Timing.stepSize0,
      (&rtmGetErrorStatus(zengwen_M)),
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
    if (zengwen_DW.ToWorkspace_PWORK.LoggedData == (NULL))
      return;
  }

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  zengwen_X.LON_CSTATE[0] = zengwen_P.ini_state_LON[0];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  zengwen_X.LAT_CSTATE[0] = zengwen_P.ini_state_LON[0];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  zengwen_X.LON_CSTATE[1] = zengwen_P.ini_state_LON[1];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  zengwen_X.LAT_CSTATE[1] = zengwen_P.ini_state_LON[1];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  zengwen_X.LON_CSTATE[2] = zengwen_P.ini_state_LON[2];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  zengwen_X.LAT_CSTATE[2] = zengwen_P.ini_state_LON[2];

  /* InitializeConditions for StateSpace: '<Root>/LON' */
  zengwen_X.LON_CSTATE[3] = zengwen_P.ini_state_LON[3];

  /* InitializeConditions for StateSpace: '<Root>/LAT' */
  zengwen_X.LAT_CSTATE[3] = zengwen_P.ini_state_LON[3];
}

/* Model terminate function */
void zengwen_terminate(void)
{
  /* (no terminate code required) */
}
