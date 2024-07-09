/*
 * xianxingfangzhen.h
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

#ifndef RTW_HEADER_xianxingfangzhen_h_
#define RTW_HEADER_xianxingfangzhen_h_
#include <stddef.h>
#include <float.h>
#include <string.h>
#ifndef xianxingfangzhen_COMMON_INCLUDES_
# define xianxingfangzhen_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* xianxingfangzhen_COMMON_INCLUDES_ */

#include "xianxingfangzhen_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ((rtm)->intgData)
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ((rtm)->intgData = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ((rtm)->odeF)
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ((rtm)->odeF = (val))
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ((rtm)->odeY)
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ((rtm)->odeY = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
# define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
# define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
# define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
# define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->derivs = (val))
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T LON[4];                       /* '<Root>/LON' */
  real_T TmpSignalConversionAtLONInport1[2];
  real_T LAT[4];                       /* '<Root>/LAT' */
  real_T TmpSignalConversionAtLATInport1[2];
  real_T Clock;                        /* '<Root>/Clock' */
} B_xianxingfangzhen_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  struct {
    void *LoggedData[4];
  } Scope_PWORK;                       /* '<Root>/Scope' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK;                /* '<Root>/To Workspace1' */

  struct {
    void *LoggedData[4];
  } Scope1_PWORK;                      /* '<Root>/Scope1' */

  struct {
    void *LoggedData;
  } ToWorkspace2_PWORK;                /* '<Root>/To Workspace2' */

  struct {
    void *LoggedData;
  } ToWorkspace_PWORK;                 /* '<Root>/To Workspace' */
} DW_xianxingfangzhen_T;

/* Continuous states (default storage) */
typedef struct {
  real_T LON_CSTATE[4];                /* '<Root>/LON' */
  real_T LAT_CSTATE[4];                /* '<Root>/LAT' */
} X_xianxingfangzhen_T;

/* State derivatives (default storage) */
typedef struct {
  real_T LON_CSTATE[4];                /* '<Root>/LON' */
  real_T LAT_CSTATE[4];                /* '<Root>/LAT' */
} XDot_xianxingfangzhen_T;

/* State disabled  */
typedef struct {
  boolean_T LON_CSTATE[4];             /* '<Root>/LON' */
  boolean_T LAT_CSTATE[4];             /* '<Root>/LAT' */
} XDis_xianxingfangzhen_T;

#ifndef ODE3_INTG
#define ODE3_INTG

/* ODE3 Integration Data */
typedef struct {
  real_T *y;                           /* output */
  real_T *f[3];                        /* derivatives */
} ODE3_IntgData;

#endif

/* Parameters (default storage) */
struct P_xianxingfangzhen_T_ {
  real_T A_LAT[16];                    /* Variable: A_LAT
                                        * Referenced by: '<Root>/LAT'
                                        */
  real_T A_LON[16];                    /* Variable: A_LON
                                        * Referenced by: '<Root>/LON'
                                        */
  real_T B_LAT[8];                     /* Variable: B_LAT
                                        * Referenced by: '<Root>/LAT'
                                        */
  real_T B_LON[8];                     /* Variable: B_LON
                                        * Referenced by: '<Root>/LON'
                                        */
  real_T C[16];                        /* Variable: C
                                        * Referenced by:
                                        *   '<Root>/LAT'
                                        *   '<Root>/LON'
                                        */
  real_T ini_state_LON[4];             /* Variable: ini_state_LON
                                        * Referenced by:
                                        *   '<Root>/LAT'
                                        *   '<Root>/LON'
                                        */
  real_T de_Time;                      /* Expression: 0.01
                                        * Referenced by: '<Root>/de'
                                        */
  real_T de_Y0;                        /* Expression: 0
                                        * Referenced by: '<Root>/de'
                                        */
  real_T de_YFinal;                    /* Expression: 1
                                        * Referenced by: '<Root>/de'
                                        */
  real_T Gain_Gain;                    /* Expression: 1
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T dp_Time;                      /* Expression: 0.01
                                        * Referenced by: '<Root>/dp'
                                        */
  real_T dp_Y0;                        /* Expression: 0
                                        * Referenced by: '<Root>/dp'
                                        */
  real_T dp_YFinal;                    /* Expression: 1
                                        * Referenced by: '<Root>/dp'
                                        */
  real_T Gain1_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain1'
                                        */
  real_T da_Time;                      /* Expression: 0.01
                                        * Referenced by: '<Root>/da'
                                        */
  real_T da_Y0;                        /* Expression: 0
                                        * Referenced by: '<Root>/da'
                                        */
  real_T da_YFinal;                    /* Expression: 1
                                        * Referenced by: '<Root>/da'
                                        */
  real_T Gain2_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain2'
                                        */
  real_T dr_Time;                      /* Expression: 0.01
                                        * Referenced by: '<Root>/dr'
                                        */
  real_T dr_Y0;                        /* Expression: 0
                                        * Referenced by: '<Root>/dr'
                                        */
  real_T dr_YFinal;                    /* Expression: 1
                                        * Referenced by: '<Root>/dr'
                                        */
  real_T Gain3_Gain;                   /* Expression: 0
                                        * Referenced by: '<Root>/Gain3'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_xianxingfangzhen_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;
  RTWSolverInfo solverInfo;
  X_xianxingfangzhen_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  boolean_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T odeY[8];
  real_T odeF[3][8];
  ODE3_IntgData intgData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T tFinal;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (default storage) */
extern P_xianxingfangzhen_T xianxingfangzhen_P;

/* Block signals (default storage) */
extern B_xianxingfangzhen_T xianxingfangzhen_B;

/* Continuous states (default storage) */
extern X_xianxingfangzhen_T xianxingfangzhen_X;

/* Block states (default storage) */
extern DW_xianxingfangzhen_T xianxingfangzhen_DW;

/* Model entry point functions */
extern void xianxingfangzhen_initialize(void);
extern void xianxingfangzhen_step(void);
extern void xianxingfangzhen_terminate(void);

/* Real-time Model object */
extern RT_MODEL_xianxingfangzhen_T *const xianxingfangzhen_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'xianxingfangzhen'
 */
#endif                                 /* RTW_HEADER_xianxingfangzhen_h_ */
